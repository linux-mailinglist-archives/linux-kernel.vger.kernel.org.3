Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154864E35C4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 01:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbiCVAtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 20:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbiCVAtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 20:49:16 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31C627B0F;
        Mon, 21 Mar 2022 17:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647910069; x=1679446069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=4Hfyz22PouTDUj0o7xhLSgeFJEeNsb/nS9a947rwT5E=;
  b=VM/GUYKLe933AvBzEX3attDYoWB2YwBfgojvdzsDvEUk+zOS13jR6lCI
   TdcYT54eFkWQiJxbvgEGi9EDW5m6/EkpTdKG4XnoLtHNxoMh7QUOZS6lk
   jF4FBUzfzWHBVxtJJbKpVNsk+pVZ2g+pR/5qVtVBZ/G7tKmO+F0sMURIy
   8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 21 Mar 2022 17:47:48 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 17:47:49 -0700
Received: from collinsd-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 17:47:48 -0700
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
Subject: [PATCH v2 2/2] regulator: scmi: add support for registering SCMI regulators by name
Date:   Mon, 21 Mar 2022 17:47:20 -0700
Message-ID: <822eefd3ad25daf2da66c9257e2a69e93d9df5a4.1647909090.git.quic_collinsd@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1647909090.git.quic_collinsd@quicinc.com>
References: <cover.1647909090.git.quic_collinsd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to register SCMI regulator subnodes based on an SCMI
Voltage Domain name specified via the "arm,scmi-domain-name" device
tree property.  In doing so, make the "reg" property optional with
the constraint that at least one of "reg" or "arm,scmi-domain-name"
must be specified.  If both are specified, then both must match the
Voltage Domain data exposed by the SCMI platform.

Name based SCMI regulator registration helps ensure that an SCMI
agent doesn't need to be aware of the numbering scheme used for
Voltage Domains by the SCMI platform.  It also ensures that the
correct Voltage Domain is selected for a given physical regulator.
This cannot be guaranteed with numeric Voltage Domain IDs alone.

Signed-off-by: David Collins <quic_collinsd@quicinc.com>
---
 drivers/regulator/scmi-regulator.c | 58 ++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/scmi-regulator.c b/drivers/regulator/scmi-regulator.c
index 1f02f60ad136..15f9167b96ab 100644
--- a/drivers/regulator/scmi-regulator.c
+++ b/drivers/regulator/scmi-regulator.c
@@ -31,6 +31,7 @@
 #include <linux/regulator/of_regulator.h>
 #include <linux/scmi_protocol.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/types.h>
 
 static const struct scmi_voltage_proto_ops *voltage_ops;
@@ -252,16 +253,67 @@ static int scmi_regulator_common_init(struct scmi_regulator *sreg)
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
+	if (of_find_property(np, "arm,scmi-domain-name", NULL)) {
+		ret = of_property_read_string(np, "arm,scmi-domain-name",
+					      &name);
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

