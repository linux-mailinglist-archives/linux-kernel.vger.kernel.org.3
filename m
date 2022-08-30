Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D215A6D27
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiH3TXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbiH3TWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:22:37 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFF679A7B;
        Tue, 30 Aug 2022 12:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1661887356; x=1693423356;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OY7VLVa2TpEEvpaKzDB+Hlk4tGYxU6BP/Z21DvqRTqE=;
  b=SUbY8Bmlws3GnMW6KwHH2TPQpYyHVYU6ST6/pd/HRtv3gK9GGVaBGdx0
   runp8brxknCNGGQ++8X39aQ4zd/ocHoIovUoAOaq5B8aePzQ0vJ9qZbEu
   Uhp4YvxTCzji992ZPUjdOyMOK86IvNkXXRpLjhjHaGNvt509oTDB9BDlJ
   k=;
X-IronPort-AV: E=Sophos;i="5.93,275,1654560000"; 
   d="scan'208";a="125055812"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-54a073b7.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 19:22:19 +0000
Received: from EX13D44EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-54a073b7.us-east-1.amazon.com (Postfix) with ESMTPS id 80F5B803A7;
        Tue, 30 Aug 2022 19:22:16 +0000 (UTC)
Received: from EX19D019EUB004.ant.amazon.com (10.252.51.91) by
 EX13D44EUB003.ant.amazon.com (10.43.166.64) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 30 Aug 2022 19:22:14 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX19D019EUB004.ant.amazon.com (10.252.51.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.12; Tue, 30 Aug 2022 19:22:14 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Tue, 30 Aug 2022 19:22:13
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 5E6D44D49; Tue, 30 Aug 2022 19:22:12 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <ronenk@amazon.com>,
        <itamark@amazon.com>, <shellykz@amazon.com>, <shorer@amazon.com>,
        <amitlavi@amazon.com>, <almogbs@amazon.com>, <dkl@amazon.com>,
        <rahul.tanwar@linux.intel.com>, <andriy.shevchenko@intel.com>
Subject: [PATCH v3 11/19] hwmon: (mr75203) add VM pre-scaler support
Date:   Tue, 30 Aug 2022 19:22:04 +0000
Message-ID: <20220830192212.28570-12-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220830192212.28570-1-farbere@amazon.com>
References: <20220830192212.28570-1-farbere@amazon.com>
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

Add mr76006 pre-scaler support to normalize the voltage output result for
channels that use pre-scaler units to get the measurement to be within
the range that the sensor supports.

For channels that are listed in the device-tree to have a pre-scaler, the
voltage result is multiplied by a factor of 2, to represent to the user
the actual voltage source which is measured.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
V3 -> V2:
- Modify code according to new property format.

 drivers/hwmon/mr75203.c | 64 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index 6925e8490587..1cd5ff6eacce 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -13,10 +13,12 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
+#include <linux/slab.h>
 
 /* PVT Common register */
 #define PVT_IP_CONFIG	0x04
@@ -108,9 +110,13 @@
 #define PVT_N_CONST		90
 #define PVT_R_CONST		245805
 
+#define PRE_SCALER_X1	1
+#define PRE_SCALER_X2	2
+
 struct voltage_device {
 	u32 vm_map;	/* Map channel number to VM index */
 	u32 ch_map;	/* Map channel number to channel index */
+	u32 pre_scaler;
 };
 
 struct voltage_channels {
@@ -192,7 +198,7 @@ static int pvt_read_in(struct device *dev, u32 attr, int channel, long *val)
 {
 	struct pvt_device *pvt = dev_get_drvdata(dev);
 	struct regmap *v_map = pvt->v_map;
-	u32 n, stat;
+	u32 n, stat, pre_scaler;
 	u8 vm_idx, ch_idx;
 	int ret;
 
@@ -217,7 +223,9 @@ static int pvt_read_in(struct device *dev, u32 attr, int channel, long *val)
 
 		n &= SAMPLE_DATA_MSK;
 		/* Convert the N bitstream count into voltage */
-		*val = (PVT_N_CONST * n - PVT_R_CONST) >> PVT_CONV_BITS;
+		pre_scaler = pvt->vd[channel].pre_scaler;
+		*val = pre_scaler * (PVT_N_CONST * n - PVT_R_CONST) >>
+			PVT_CONV_BITS;
 
 		return 0;
 	default:
@@ -582,6 +590,54 @@ static int pvt_get_active_channel(struct device *dev, struct pvt_device *pvt,
 	return 0;
 }
 
+static int pvt_get_pre_scaler(struct device *dev, struct pvt_device *pvt)
+{
+	const struct device_node *np = dev->of_node;
+	u32 total_channels = pvt->vm_channels.total;
+	u32 channel;
+	u8 *pre_scaler_ch_list;
+	int i, ret, num_ch;
+
+	/* Set default pre-scaler value to be 1. */
+	for (i = 0; i < total_channels; i++)
+		pvt->vd[i].pre_scaler = PRE_SCALER_X1;
+
+	/* Get number of channels configured in "moortec,vm-pre-scaler". */
+	num_ch = of_property_count_u8_elems(np, "moortec,vm-pre-scaler");
+	if (num_ch <= 0)
+		return 0;
+
+	pre_scaler_ch_list = kcalloc(total_channels,
+				     sizeof(*pre_scaler_ch_list), GFP_KERNEL);
+	if (!pre_scaler_ch_list)
+		return -ENOMEM;
+
+	/* Get list of all channels that have pre-scaler of 2. */
+	ret = device_property_read_u8_array(dev, "moortec,vm-pre-scaler",
+					    pre_scaler_ch_list, num_ch);
+	if (ret)
+		goto out;
+
+	for (i = 0; i < num_ch; i++) {
+		channel = pre_scaler_ch_list[i];
+
+		if (channel >= total_channels) {
+			dev_err(dev,
+				"invalid channel (%u) in pre-scaler list\n",
+				channel);
+			ret = -EINVAL;
+			goto out;
+		}
+
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
 	const struct hwmon_channel_info **pvt_info;
@@ -697,6 +753,10 @@ static int mr75203_probe(struct platform_device *pdev)
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

