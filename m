Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C2146F8D6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbhLJB6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 20:58:51 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:45209 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232642AbhLJB6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 20:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639101314; x=1670637314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=lHW3hLnV/NwAlPaJvWLZeYHn/Z13jsz9Dd88QrFizYA=;
  b=yXpZJEv1P74MIOw/Imy21QPGgBU8TUIBWhisf3jWKdLvz1Lx7V/s/RaO
   WG9nCeMLLntbK1vxqEtFydtkB7Bs/vRSAx+yoJ3xUNpEIbJwQ8Kx8fQ87
   rdCM2EGV26CWHwMzjABmdMVTNpX8BJ9jP1HsoYj0kivOVDJetXkPFLNra
   4=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Dec 2021 17:55:14 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 17:55:14 -0800
Received: from collinsd-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 9 Dec 2021 17:55:13 -0800
From:   David Collins <quic_collinsd@quicinc.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     David Collins <quic_collinsd@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
Subject: [PATCH 2/2] regulator: scmi: add support for registering SCMI regulators by name
Date:   Thu, 9 Dec 2021 17:54:42 -0800
Message-ID: <916966958cc63e9509f94fb263ad8d3c3ec768da.1639099631.git.quic_collinsd@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1639099631.git.quic_collinsd@quicinc.com>
References: <cover.1639099631.git.quic_collinsd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to register SCMI regulator subnodes based on an SCMI
Voltage Domain name specified via the 'regulator-name' device tree
property.  In doing so, make the 'reg' property optional with the
constraint that at least one of 'reg' or 'regulator-name' must be
specified.  If both are specified, then both must match the
Voltage Domain data exposed by the SCMI platform.

Name based SCMI regulator registration helps ensure that an SCMI
agent doesn't need to be aware of the numbering scheme used for
Voltage Domains by the SCMI platform.  It also ensures that the
correct Voltage Domain is selected for a given physical regulator.
This cannot be guaranteed with numeric Voltage Domain IDs alone.

Signed-off-by: David Collins <quic_collinsd@quicinc.com>
---
 drivers/regulator/scmi-regulator.c | 57 ++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/scmi-regulator.c b/drivers/regulator/scmi-regulator.c
index 1f02f60ad136..c3287901975e 100644
--- a/drivers/regulator/scmi-regulator.c
+++ b/drivers/regulator/scmi-regulator.c
@@ -31,6 +31,7 @@
 #include <linux/regulator/of_regulator.h>
 #include <linux/scmi_protocol.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/types.h>
 
 static const struct scmi_voltage_proto_ops *voltage_ops;
@@ -252,16 +253,66 @@ static int scmi_regulator_common_init(struct scmi_regulator *sreg)
 	return 0;
 }
 
+static int scmi_regulator_map_name(struct scmi_protocol_handle *ph,
+				   struct scmi_regulator_info *rinfo,
+				   const char *name)
+{
+	const struct scmi_voltage_info *vinfo;
+	int i;
+
+	for (i = 0; i < rinfo->num_doms; i++) {
+		vinfo = voltage_ops->info_get(ph, i);
+		if (!vinfo)
+			continue;
+		if (!strncmp(vinfo->name, name, sizeof(vinfo->name)))
+			return i;
+	}
+
+	return -ENODEV;
+}
+
 static int process_scmi_regulator_of_node(struct scmi_device *sdev,
 					  struct scmi_protocol_handle *ph,
 					  struct device_node *np,
 					  struct scmi_regulator_info *rinfo)
 {
 	u32 dom, ret;
+	int name_dom;
+	const char *name;
 
-	ret = of_property_read_u32(np, "reg", &dom);
-	if (ret)
-		return ret;
+	dom = rinfo->num_doms;
+	if (of_find_property(np, "reg", NULL)) {
+		ret = of_property_read_u32(np, "reg", &dom);
+		if (ret)
+			return ret;
+
+		if (dom >= rinfo->num_doms)
+			return -ENODEV;
+	}
+
+	if (of_find_property(np, "regulator-name", NULL)) {
+		ret = of_property_read_string(np, "regulator-name", &name);
+		if (ret)
+			return ret;
+
+		name_dom = scmi_regulator_map_name(ph, rinfo, name);
+		if (name_dom < 0) {
+			dev_err(&sdev->dev,
+				"No SCMI Voltage Domain found named %s. Skipping: %s\n",
+				name, np->full_name);
+			return name_dom;
+		}
+
+		if (dom >= rinfo->num_doms)
+			dom = name_dom;
+
+		if (name_dom != dom) {
+			dev_err(&sdev->dev,
+				"SCMI Voltage Domain %s ID mismatch, %u (DT) != %d (firmware). Skipping: %s\n",
+				name, dom, name_dom, np->full_name);
+			return -EINVAL;
+		}
+	}
 
 	if (dom >= rinfo->num_doms)
 		return -ENODEV;
-- 
2.17.1

