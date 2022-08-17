Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD37C5968FC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 07:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238627AbiHQFnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 01:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238599AbiHQFnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:43:39 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452E978239;
        Tue, 16 Aug 2022 22:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1660715017; x=1692251017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BD7xLtT8ZDZM0YeRGZDNFzte0/L/07GbYy8it7xC5Js=;
  b=gltHg8/CbAseRcXoKTd0KC67YFfrzXp2bxOKNAkf06/Q+LJW8SqH28Qs
   MP53c9iZub7s5DLI+aXji25ekTdEimtUXNNOmXtLi+VCWFaq5LaSZyGFG
   He7Al7Y2eXn5nfB6+Lmqsjj79yU6GrKFgCJGRcBZmkDLbVybxx1MUHsLp
   8=;
X-IronPort-AV: E=Sophos;i="5.93,242,1654560000"; 
   d="scan'208";a="1045102103"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-11a39b7d.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 05:43:26 +0000
Received: from EX13MTAUEB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-11a39b7d.us-west-2.amazon.com (Postfix) with ESMTPS id D5BDA44812;
        Wed, 17 Aug 2022 05:43:25 +0000 (UTC)
Received: from EX13D08UEB002.ant.amazon.com (10.43.60.107) by
 EX13MTAUEB002.ant.amazon.com (10.43.60.12) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 17 Aug 2022 05:43:22 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D08UEB002.ant.amazon.com (10.43.60.107) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 17 Aug 2022 05:43:22 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Wed, 17 Aug 2022 05:43:22
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 838154C62; Wed, 17 Aug 2022 05:43:21 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <ronenk@amazon.com>,
        <itamark@amazon.com>, <shellykz@amazon.com>, <shorer@amazon.com>,
        <amitlavi@amazon.com>, <almogbs@amazon.com>, <dwmw@amazon.co.uk>,
        <rtanwar@maxlinear.com>
Subject: [PATCH v2 08/16] hwmon: (mr75203) add VM active channel support
Date:   Wed, 17 Aug 2022 05:43:13 +0000
Message-ID: <20220817054321.6519-9-farbere@amazon.com>
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

Add active channel support per VM, which is useful when not all VM
channels are used.
Number of active channel is read from device-tree.
When absent in device-tree, all channels are assumed to be used.
Setting number of active channels to 0, means that entire VM sesnor is
not used (this can partially replace the "intel,vm-map" functionality).

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 drivers/hwmon/mr75203.c | 94 +++++++++++++++++++++++++++++++----------
 1 file changed, 72 insertions(+), 22 deletions(-)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index 4419e481d47c..2e6139c09efc 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -30,6 +30,8 @@
 #define CH_NUM_MSK	GENMASK(31, 24)
 #define CH_NUM_SFT	24
 
+#define VM_NUM_MAX	(VM_NUM_MSK >> VM_NUM_SFT)
+
 /* Macro Common Register */
 #define CLK_SYNTH		0x00
 #define CLK_SYNTH_LO_SFT	0
@@ -107,6 +109,11 @@
 #define PVT_N_CONST		90
 #define PVT_R_CONST		245805
 
+struct voltage_device {
+	u8 vm_map;
+	u8 ch_map;
+};
+
 struct pvt_device {
 	struct regmap		*c_map;
 	struct regmap		*t_map;
@@ -114,12 +121,13 @@ struct pvt_device {
 	struct regmap		*v_map;
 	struct clk		*clk;
 	struct reset_control	*rst;
+	struct voltage_device	*vd;
 	u32			t_num;
 	u32			p_num;
 	u32			v_num;
-	u32			c_num;
 	u32			ip_freq;
-	u8			*vm_idx;
+	u8			vm_ch_max;
+	u8			vm_ch_total;
 };
 
 static umode_t pvt_is_visible(const void *data, enum hwmon_sensor_types type,
@@ -186,11 +194,11 @@ static int pvt_read_in(struct device *dev, u32 attr, int channel, long *val)
 	u8 ch_idx;
 	int ret;
 
-	if (channel >= pvt->v_num * pvt->c_num)
+	if (channel >= pvt->vm_ch_total)
 		return -EINVAL;
 
-	vm_idx = pvt->vm_idx[channel / pvt->c_num];
-	ch_idx = channel % pvt->c_num;
+	vm_idx = pvt->vd[channel].vm_map;
+	ch_idx = pvt->vd[channel].ch_map;
 
 	switch (attr) {
 	case hwmon_in_input:
@@ -390,7 +398,7 @@ static int pvt_init(struct pvt_device *pvt)
 		if (ret)
 			return ret;
 
-		val = GENMASK(pvt->c_num - 1, 0) | VM_CH_INIT |
+		val = GENMASK(pvt->vm_ch_max - 1, 0) | VM_CH_INIT |
 		      IP_POLL << SDIF_ADDR_SFT |
 		      SDIF_WRN_W | SDIF_PROG;
 		ret = regmap_write(v_map, SDIF_W, val);
@@ -519,7 +527,7 @@ static int pvt_reset_control_deassert(struct device *dev, struct pvt_device *pvt
 static int mr75203_probe(struct platform_device *pdev)
 {
 	const struct hwmon_channel_info **pvt_info;
-	u32 ts_num, vm_num, pd_num, ch_num, val, index, i;
+	u32 ts_num, vm_num, pd_num, ch_num, val, index, i, j, k;
 	struct device *dev = &pdev->dev;
 	u32 *temp_config, *in_config;
 	struct device *hwmon_dev;
@@ -569,7 +577,6 @@ static int mr75203_probe(struct platform_device *pdev)
 	pvt->t_num = ts_num;
 	pvt->p_num = pd_num;
 	pvt->v_num = vm_num;
-	pvt->c_num = ch_num;
 	val = 0;
 	if (ts_num)
 		val++;
@@ -606,43 +613,86 @@ static int mr75203_probe(struct platform_device *pdev)
 	}
 
 	if (vm_num) {
-		u32 total_ch = ch_num * vm_num;
+		u8 vm_idx[VM_NUM_MAX];
+		u8 vm_active_ch[VM_NUM_MAX];
 
 		ret = pvt_get_regmap(pdev, "vm", pvt);
 		if (ret)
 			return ret;
 
-		pvt->vm_idx = devm_kcalloc(dev, vm_num, sizeof(*pvt->vm_idx),
-					   GFP_KERNEL);
-		if (!pvt->vm_idx)
-			return -ENOMEM;
-
-		ret = device_property_read_u8_array(dev, "intel,vm-map",
-						    pvt->vm_idx, vm_num);
+		ret = device_property_read_u8_array(dev, "intel,vm-map", vm_idx,
+						    vm_num);
 		if (ret) {
 			/*
 			 * Incase intel,vm-map property is not defined, we
 			 * assume incremental channel numbers.
 			 */
 			for (i = 0; i < vm_num; i++)
-				pvt->vm_idx[i] = i;
+				vm_idx[i] = i;
 		} else {
 			for (i = 0; i < vm_num; i++)
-				if (pvt->vm_idx[i] >= vm_num ||
-				    pvt->vm_idx[i] == 0xff)
+				if (vm_idx[i] >= vm_num || vm_idx[i] == 0xff)
 					break;
 
 			vm_num = i;
 			pvt->v_num = i;
 		}
 
-		in_config = devm_kcalloc(dev, total_ch + 1,
+		ret = device_property_read_u8_array(dev, "vm-active-channels",
+						    vm_active_ch, vm_num);
+		if (ret) {
+			/*
+			 * Incase vm-active-channels property is not defined,
+			 * we assume each VM sensor has all of its channels
+			 * active.
+			 */
+			for (i = 0; i < vm_num; i++)
+				vm_active_ch[i] = ch_num;
+
+			pvt->vm_ch_max = ch_num;
+			pvt->vm_ch_total = ch_num * vm_num;
+		} else {
+			for (i = 0; i < vm_num; i++) {
+				if (vm_active_ch[i] > ch_num) {
+					dev_err(dev,
+						"invalid active channels: %u\n",
+						vm_active_ch[i]);
+					return -EINVAL;
+				}
+
+				pvt->vm_ch_total += vm_active_ch[i];
+
+				if (vm_active_ch[i] > pvt->vm_ch_max)
+					pvt->vm_ch_max = vm_active_ch[i];
+			}
+		}
+
+		/*
+		 * Map between the channel-number to VM-index and channel-index.
+		 * Example - 3 VMs, vm_active_ch = [05 02 04]:
+		 * vm_map = [0 0 0 0 0 1 1 2 2 2 2]
+		 * ch_map = [0 1 2 3 4 0 1 0 1 2 3]
+		 */
+		pvt->vd = devm_kcalloc(dev, pvt->vm_ch_total, sizeof(*pvt->vd),
+				       GFP_KERNEL);
+		if (!pvt->vd)
+			return -ENOMEM;
+
+		k = 0;
+		for (i = 0; i < vm_num; i++)
+			for (j = 0; j < vm_active_ch[i]; j++) {
+				pvt->vd[k].vm_map = vm_idx[i];
+				pvt->vd[k].ch_map = j;
+				k++;
+			}
+
+		in_config = devm_kcalloc(dev, pvt->vm_ch_total + 1,
 					 sizeof(*in_config), GFP_KERNEL);
 		if (!in_config)
 			return -ENOMEM;
 
-		memset32(in_config, HWMON_I_INPUT, total_ch);
-		in_config[total_ch] = 0;
+		memset32(in_config, HWMON_I_INPUT, pvt->vm_ch_total);
+		in_config[pvt->vm_ch_total] = 0;
 		pvt_in.config = in_config;
 
 		pvt_info[index++] = &pvt_in;
-- 
2.37.1

