Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413C15968D1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 07:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238711AbiHQFov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 01:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238707AbiHQFoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:44:15 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088E07CB50;
        Tue, 16 Aug 2022 22:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1660715038; x=1692251038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zDa/OToZ/vYiAzKBvDIfF4630+PtGKDsU6JSOj2YYVc=;
  b=qDRlQpZ088xOdvaptCHrNGt0E/QR5idS1h9HDwWwFMhFolvoPiIHREbV
   5QKnJ56qm91Hcq7bBO5/d2Eec7rnYO4xE1wcWm5ShbJnIeYFMbMAA4/i1
   EdVgUrPBYxOTXJ5Gjxt8xWTX1CoJO5fLyKuGXs+56d78nNPGpU1aN7SmH
   o=;
X-IronPort-AV: E=Sophos;i="5.93,242,1654560000"; 
   d="scan'208";a="233936718"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-c92fe759.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 05:43:46 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-c92fe759.us-east-1.amazon.com (Postfix) with ESMTPS id 45499C08A4;
        Wed, 17 Aug 2022 05:43:44 +0000 (UTC)
Received: from EX19D013UWA002.ant.amazon.com (10.13.138.210) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 17 Aug 2022 05:43:23 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX19D013UWA002.ant.amazon.com (10.13.138.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Wed, 17 Aug 2022 05:43:22 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Wed, 17 Aug 2022 05:43:22
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 8A3C24C6A; Wed, 17 Aug 2022 05:43:21 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <ronenk@amazon.com>,
        <itamark@amazon.com>, <shellykz@amazon.com>, <shorer@amazon.com>,
        <amitlavi@amazon.com>, <almogbs@amazon.com>, <dwmw@amazon.co.uk>,
        <rtanwar@maxlinear.com>
Subject: [PATCH v2 10/16] hwmon: (mr75203) add VM pre-scalar support
Date:   Wed, 17 Aug 2022 05:43:15 +0000
Message-ID: <20220817054321.6519-11-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220817054321.6519-1-farbere@amazon.com>
References: <20220817054321.6519-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pre-scalar support to normalzie the voltage output results for
channels the use pre-scalar units to get the measurement to be within
the range that the sensor supports.
The pre-scalar value is used if it exists in device-tree, otherwise
default value of 1 is used.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 drivers/hwmon/mr75203.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index 2e6139c09efc..24a00339cfd8 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -112,8 +112,12 @@
 struct voltage_device {
 	u8 vm_map;
 	u8 ch_map;
+	u32 pre_scaler;
 };
 
+#define PRE_SCALR_PROPERTY_NAME	32
+#define PRE_SCALR_DEFAULT_VAL	1
+
 struct pvt_device {
 	struct regmap		*c_map;
 	struct regmap		*t_map;
@@ -215,7 +219,9 @@ static int pvt_read_in(struct device *dev, u32 attr, int channel, long *val)
 
 		n &= SAMPLE_DATA_MSK;
 		/* Convert the N bitstream count into voltage */
-		*val = (PVT_N_CONST * n - PVT_R_CONST) >> PVT_CONV_BITS;
+		*val = pvt->vd[channel].pre_scaler;
+		*val *= (PVT_N_CONST * n - PVT_R_CONST);
+		*val >>= PVT_CONV_BITS;
 
 		return 0;
 	default:
@@ -527,6 +533,7 @@ static int pvt_reset_control_deassert(struct device *dev, struct pvt_device *pvt
 static int mr75203_probe(struct platform_device *pdev)
 {
 	const struct hwmon_channel_info **pvt_info;
+	const struct device_node *np = pdev->dev.of_node;
 	u32 ts_num, vm_num, pd_num, ch_num, val, index, i, j, k;
 	struct device *dev = &pdev->dev;
 	u32 *temp_config, *in_config;
@@ -552,7 +559,7 @@ static int mr75203_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (of_property_read_bool(dev->of_node, "reset-control-skip")) {
+	if (of_property_read_bool(np, "reset-control-skip")) {
 		dev_info(dev, "skipping reset-control\n");
 	} else {
 		pvt->rst = devm_reset_control_get_exclusive(dev, NULL);
@@ -615,6 +622,8 @@ static int mr75203_probe(struct platform_device *pdev)
 	if (vm_num) {
 		u8 vm_idx[VM_NUM_MAX];
 		u8 vm_active_ch[VM_NUM_MAX];
+		char prop_name[PRE_SCALR_PROPERTY_NAME] = {0};
+		u32 pre_scaler;
 
 		ret = pvt_get_regmap(pdev, "vm", pvt);
 		if (ret)
@@ -686,6 +695,21 @@ static int mr75203_probe(struct platform_device *pdev)
 				k++;
 			}
 
+		/*
+		 * Incase vm-pre-scalar-ch# property is not defined, we assume
+		 * default pre-scaler of 1.
+		 */
+		for (i = 0; i < pvt->vm_ch_total; i++) {
+			snprintf(prop_name, sizeof(prop_name),
+				 "vm-pre-scalar-ch%u", i);
+
+			ret = of_property_read_u32(np, prop_name, &pre_scaler);
+			if (ret)
+				pvt->vd[i].pre_scaler = PRE_SCALR_DEFAULT_VAL;
+			else
+				pvt->vd[i].pre_scaler = pre_scaler;
+		}
+
 		in_config = devm_kcalloc(dev, pvt->vm_ch_total + 1,
 					 sizeof(*in_config), GFP_KERNEL);
 		if (!in_config)
-- 
2.37.1

