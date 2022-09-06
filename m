Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A0A5AE2D3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239324AbiIFIf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239048AbiIFIe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:34:59 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6123D51438;
        Tue,  6 Sep 2022 01:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662453297; x=1693989297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=08sYMwrtQYKROSQcOPqY388/Q3O4R9NE1kR8HL/zR+o=;
  b=r7A/aYHlWzzKCucsJ/XPAeGRYwo4WfIbA9mXCtF1m0/bMfpen0gNAGVR
   ExGY933CbXgWB+jSFlalqkHPHDMIXkqVWXnBvXyKqIME/IbRW9feMfgtG
   Ek/1pbktX1kpAseqvYKFRSIrVqeIWobd5ANOu1oKzlggRSJG/Zv/M2jMr
   k=;
X-IronPort-AV: E=Sophos;i="5.93,293,1654560000"; 
   d="scan'208";a="256505599"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-10222bbc.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 08:34:41 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-10222bbc.us-east-1.amazon.com (Postfix) with ESMTPS id EFA291A005E;
        Tue,  6 Sep 2022 08:34:38 +0000 (UTC)
Received: from EX19D013UWA001.ant.amazon.com (10.13.138.253) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 6 Sep 2022 08:34:00 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX19D013UWA001.ant.amazon.com (10.13.138.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Tue, 6 Sep 2022 08:34:00 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Tue, 6 Sep 2022 08:34:00 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id D3EA94D7A; Tue,  6 Sep 2022 08:33:57 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>,
        <andriy.shevchenko@intel.com>
Subject: [PATCH v4 15/21] hwmon: (mr75203) add VM pre-scaler x2 support
Date:   Tue, 6 Sep 2022 08:33:50 +0000
Message-ID: <20220906083356.21067-16-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220906083356.21067-1-farbere@amazon.com>
References: <20220906083356.21067-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-14.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for mr76006 pre-scaler which provides divide-by-2 scaling
of the input voltage, so that it can be  presented to the VM for
measurement within its range (the VM input range is limited from -0.1V
to 1V).

The driver reads from the device-tree all the channels that use the
mr76006 pre-scaler and multiplies the voltage result by a factor of 2,
to represent to the user with the actual voltage input source.

Channels that are not in the device-tree are multiplied by a factor
of 1.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
V4 -> V3:
- Replace of_property_count_u8_elems() with device_property_count_u8().
- Remove unnecessary blank line.
- Remove code that validated the YAML.

V3 -> V2:
- Modify code according to new property format.

 drivers/hwmon/mr75203.c | 55 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index 5aa694fd9118..66f151082c11 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -17,6 +17,7 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
+#include <linux/slab.h>
 
 /* PVT Common register */
 #define PVT_IP_CONFIG	0x04
@@ -108,17 +109,24 @@
 #define PVT_N_CONST		90
 #define PVT_R_CONST		245805
 
+#define PRE_SCALER_X1	1
+#define PRE_SCALER_X2	2
+
 /**
  * struct voltage_device - VM single input parameters.
  * @vm_map: Map channel number to VM index.
  * @ch_map: Map channel number to channel index.
+ * @pre_scaler: Pre scaler value (1 or 2) used to normalize the voltage output
+ *              result.
  *
  * The structure provides mapping between channel-number (0..N-1) to VM-index
  * (0..num_vm-1) and channel-index (0..ch_num-1) where N = num_vm * ch_num.
+ * It also provides normalization factor for the VM equation.
  */
 struct voltage_device {
 	u32 vm_map;
 	u32 ch_map;
+	u32 pre_scaler;
 };
 
 /**
@@ -207,8 +215,8 @@ static int pvt_read_in(struct device *dev, u32 attr, int channel, long *val)
 {
 	struct pvt_device *pvt = dev_get_drvdata(dev);
 	struct regmap *v_map = pvt->v_map;
+	u32 n, stat, pre_scaler;
 	u8 vm_idx, ch_idx;
-	u32 n, stat;
 	int ret;
 
 	if (channel >= pvt->vm_channels.total)
@@ -232,7 +240,9 @@ static int pvt_read_in(struct device *dev, u32 attr, int channel, long *val)
 
 		n &= SAMPLE_DATA_MSK;
 		/* Convert the N bitstream count into voltage */
-		*val = (PVT_N_CONST * (long)n - PVT_R_CONST) / (1 << PVT_CONV_BITS);
+		pre_scaler = pvt->vd[channel].pre_scaler;
+		*val = pre_scaler * (PVT_N_CONST * (long)n - PVT_R_CONST) /
+			(1 << PVT_CONV_BITS);
 
 		return 0;
 	default:
@@ -594,6 +604,43 @@ static int pvt_get_active_channel(struct device *dev, struct pvt_device *pvt,
 	return 0;
 }
 
+static int pvt_get_pre_scaler(struct device *dev, struct pvt_device *pvt)
+{
+	u8 *pre_scaler_ch_list;
+	int i, ret, num_ch;
+	u32 channel;
+
+	/* Set default pre-scaler value to be 1. */
+	for (i = 0; i < pvt->vm_channels.total; i++)
+		pvt->vd[i].pre_scaler = PRE_SCALER_X1;
+
+	/* Get number of channels configured in "moortec,vm-pre-scaler-x2". */
+	num_ch = device_property_count_u8(dev, "moortec,vm-pre-scaler-x2");
+	if (num_ch <= 0)
+		return 0;
+
+	pre_scaler_ch_list = kcalloc(num_ch, sizeof(*pre_scaler_ch_list),
+				     GFP_KERNEL);
+	if (!pre_scaler_ch_list)
+		return -ENOMEM;
+
+	/* Get list of all channels that have pre-scaler of 2. */
+	ret = device_property_read_u8_array(dev, "moortec,vm-pre-scaler-x2",
+					    pre_scaler_ch_list, num_ch);
+	if (ret)
+		goto out;
+
+	for (i = 0; i < num_ch; i++) {
+		channel = pre_scaler_ch_list[i];
+		pvt->vd[channel].pre_scaler = PRE_SCALER_X2;
+	}
+
+out:
+	kfree(pre_scaler_ch_list);
+
+	return ret;
+}
+
 static int mr75203_probe(struct platform_device *pdev)
 {
 	u32 ts_num, vm_num, pd_num, ch_num, val, index, i;
@@ -709,6 +756,10 @@ static int mr75203_probe(struct platform_device *pdev)
 		if (ret)
 			return ret;
 
+		ret = pvt_get_pre_scaler(dev, pvt);
+		if (ret)
+			return ret;
+
 		in_config = devm_kcalloc(dev, pvt->vm_channels.total + 1,
 					 sizeof(*in_config), GFP_KERNEL);
 		if (!in_config)
-- 
2.37.1

