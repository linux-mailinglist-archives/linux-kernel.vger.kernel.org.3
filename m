Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1BC5B2250
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiIHPas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbiIHPaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:30:12 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F1DE622F;
        Thu,  8 Sep 2022 08:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662650969; x=1694186969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jRT3N7/5et4tGKVg477fY1LTJIHU36KO8NZGyu1f8eY=;
  b=LqZAtFiPEBwzmuA+nO1vSH0xfDiZ3GwjljDzUFQV/IHj2G+kh7frgT5Z
   ocpUlnAteSvlo7lsueQxEcGl9EwB6D0pLHG0HduxCUkf2MCh97Ad0e4Gq
   e1T3Y1l0VX19nhgWHP/Ih4R7N7VuMn2Drum7XZ2KrJR2qE+jf5wzFZlVw
   g=;
X-IronPort-AV: E=Sophos;i="5.93,300,1654560000"; 
   d="scan'208";a="257507784"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-2d7489a4.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 15:25:12 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-2d7489a4.us-east-1.amazon.com (Postfix) with ESMTPS id E555D4820C5;
        Thu,  8 Sep 2022 15:25:08 +0000 (UTC)
Received: from EX19D013UWB003.ant.amazon.com (10.13.138.111) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 8 Sep 2022 15:24:52 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX19D013UWB003.ant.amazon.com (10.13.138.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Thu, 8 Sep 2022 15:24:52 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Thu, 8 Sep 2022 15:24:52 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 81E454D4C; Thu,  8 Sep 2022 15:24:49 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <andriy.shevchenko@intel.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 05/21] hwmon: (mr75203) fix multi-channel voltage reading
Date:   Thu, 8 Sep 2022 15:24:33 +0000
Message-ID: <20220908152449.35457-6-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220908152449.35457-1-farbere@amazon.com>
References: <20220908152449.35457-1-farbere@amazon.com>
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

Fix voltage allocation and reading to support all channels in all VMs.
Prior to this change allocation and reading were done only for the first
channel in each VM.
This change counts the total number of channels for allocation, and takes
into account the channel offset when reading the sample data register.

Fixes: 9d823351a337 ("hwmon: Add hardware monitoring driver for Moortec MR75203 PVT controller")
Signed-off-by: Eliav Farber <farbere@amazon.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
V4 -> V3:
- Keep lines sorted according to length.

V3 -> V2:
- Remove configuration of ip-polling register to a separate commit.
- Explain the fix.

 drivers/hwmon/mr75203.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index 8211d463495d..87a14713e124 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -68,8 +68,9 @@
 
 /* VM Individual Macro Register */
 #define VM_COM_REG_SIZE	0x200
-#define VM_SDIF_DONE(n)	(VM_COM_REG_SIZE + 0x34 + 0x200 * (n))
-#define VM_SDIF_DATA(n)	(VM_COM_REG_SIZE + 0x40 + 0x200 * (n))
+#define VM_SDIF_DONE(vm)	(VM_COM_REG_SIZE + 0x34 + 0x200 * (vm))
+#define VM_SDIF_DATA(vm, ch)	\
+	(VM_COM_REG_SIZE + 0x40 + 0x200 * (vm) + 0x4 * (ch))
 
 /* SDA Slave Register */
 #define IP_CTRL			0x00
@@ -115,6 +116,7 @@ struct pvt_device {
 	u32			t_num;
 	u32			p_num;
 	u32			v_num;
+	u32			c_num;
 	u32			ip_freq;
 	u8			*vm_idx;
 };
@@ -178,14 +180,15 @@ static int pvt_read_in(struct device *dev, u32 attr, int channel, long *val)
 {
 	struct pvt_device *pvt = dev_get_drvdata(dev);
 	struct regmap *v_map = pvt->v_map;
+	u8 vm_idx, ch_idx;
 	u32 n, stat;
-	u8 vm_idx;
 	int ret;
 
-	if (channel >= pvt->v_num)
+	if (channel >= pvt->v_num * pvt->c_num)
 		return -EINVAL;
 
-	vm_idx = pvt->vm_idx[channel];
+	vm_idx = pvt->vm_idx[channel / pvt->c_num];
+	ch_idx = channel % pvt->c_num;
 
 	switch (attr) {
 	case hwmon_in_input:
@@ -196,7 +199,7 @@ static int pvt_read_in(struct device *dev, u32 attr, int channel, long *val)
 		if (ret)
 			return ret;
 
-		ret = regmap_read(v_map, VM_SDIF_DATA(vm_idx), &n);
+		ret = regmap_read(v_map, VM_SDIF_DATA(vm_idx, ch_idx), &n);
 		if(ret < 0)
 			return ret;
 
@@ -509,8 +512,8 @@ static int pvt_reset_control_deassert(struct device *dev, struct pvt_device *pvt
 
 static int mr75203_probe(struct platform_device *pdev)
 {
+	u32 ts_num, vm_num, pd_num, ch_num, val, index, i;
 	const struct hwmon_channel_info **pvt_info;
-	u32 ts_num, vm_num, pd_num, val, index, i;
 	struct device *dev = &pdev->dev;
 	u32 *temp_config, *in_config;
 	struct device *hwmon_dev;
@@ -551,9 +554,11 @@ static int mr75203_probe(struct platform_device *pdev)
 	ts_num = (val & TS_NUM_MSK) >> TS_NUM_SFT;
 	pd_num = (val & PD_NUM_MSK) >> PD_NUM_SFT;
 	vm_num = (val & VM_NUM_MSK) >> VM_NUM_SFT;
+	ch_num = (val & CH_NUM_MSK) >> CH_NUM_SFT;
 	pvt->t_num = ts_num;
 	pvt->p_num = pd_num;
 	pvt->v_num = vm_num;
+	pvt->c_num = ch_num;
 	val = 0;
 	if (ts_num)
 		val++;
@@ -590,7 +595,7 @@ static int mr75203_probe(struct platform_device *pdev)
 	}
 
 	if (vm_num) {
-		u32 num = vm_num;
+		u32 total_ch;
 
 		ret = pvt_get_regmap(pdev, "vm", pvt);
 		if (ret)
@@ -614,20 +619,20 @@ static int mr75203_probe(struct platform_device *pdev)
 			for (i = 0; i < vm_num; i++)
 				if (pvt->vm_idx[i] >= vm_num ||
 				    pvt->vm_idx[i] == 0xff) {
-					num = i;
 					pvt->v_num = i;
 					vm_num = i;
 					break;
 				}
 		}
 
-		in_config = devm_kcalloc(dev, num + 1,
+		total_ch = ch_num * vm_num;
+		in_config = devm_kcalloc(dev, total_ch + 1,
 					 sizeof(*in_config), GFP_KERNEL);
 		if (!in_config)
 			return -ENOMEM;
 
-		memset32(in_config, HWMON_I_INPUT, num);
-		in_config[num] = 0;
+		memset32(in_config, HWMON_I_INPUT, total_ch);
+		in_config[total_ch] = 0;
 		pvt_in.config = in_config;
 
 		pvt_info[index++] = &pvt_in;
-- 
2.37.1

