Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B915E5968EF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 07:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238736AbiHQFoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 01:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238666AbiHQFoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:44:03 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D27978239;
        Tue, 16 Aug 2022 22:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1660715028; x=1692251028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I4ndVs36DtLZuD0EkdTFDFSmoQQ7OUW1UMKQNUkt/6g=;
  b=Vf4Vzv2c07SaEfo8Cahc1Hf2/M+HF7/FNDAn/9Xl/Xetl+EtNGuma+HO
   9Y++y0DEHe9oDhqG90TeebHeJhTNGSJDl8VQUUngwMBuDLR8l+ydhHrBQ
   busZTkVeNtrGvOXj3F4zs7OFbx7j6iynZFt5TvE3mW1MgMxPlkoAvxrKd
   E=;
X-IronPort-AV: E=Sophos;i="5.93,242,1654560000"; 
   d="scan'208";a="1045102180"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-9a235a16.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 05:43:46 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-9a235a16.us-east-1.amazon.com (Postfix) with ESMTPS id EE071803A2;
        Wed, 17 Aug 2022 05:43:43 +0000 (UTC)
Received: from EX19D013UWA001.ant.amazon.com (10.13.138.253) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 17 Aug 2022 05:43:23 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX19D013UWA001.ant.amazon.com (10.13.138.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Wed, 17 Aug 2022 05:43:22 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Wed, 17 Aug 2022 05:43:22
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 7CBFC4C56; Wed, 17 Aug 2022 05:43:21 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <ronenk@amazon.com>,
        <itamark@amazon.com>, <shellykz@amazon.com>, <shorer@amazon.com>,
        <amitlavi@amazon.com>, <almogbs@amazon.com>, <dwmw@amazon.co.uk>,
        <rtanwar@maxlinear.com>
Subject: [PATCH v2 06/16] hwmon: (mr75203) fix multi-channel voltage reading
Date:   Wed, 17 Aug 2022 05:43:11 +0000
Message-ID: <20220817054321.6519-7-farbere@amazon.com>
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

- Fix voltage reading to support number of channels in VM IP (CH_NUM).
- Configure the ip-polling register to enable polling for all channels.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 drivers/hwmon/mr75203.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index bec63b611eb4..4419e481d47c 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -69,8 +69,9 @@
 
 /* VM Individual Macro Register */
 #define VM_COM_REG_SIZE	0x200
-#define VM_SDIF_DONE(n)	(VM_COM_REG_SIZE + 0x34 + 0x200 * (n))
-#define VM_SDIF_DATA(n)	(VM_COM_REG_SIZE + 0x40 + 0x200 * (n))
+#define VM_SDIF_DONE(vm)	(VM_COM_REG_SIZE + 0x34 + 0x200 * (vm))
+#define VM_SDIF_DATA(vm, ch)	\
+	(VM_COM_REG_SIZE + 0x40 + 0x200 * (vm) + 0x4 * (ch))
 
 /* SDA Slave Register */
 #define IP_CTRL			0x00
@@ -116,6 +117,7 @@ struct pvt_device {
 	u32			t_num;
 	u32			p_num;
 	u32			v_num;
+	u32			c_num;
 	u32			ip_freq;
 	u8			*vm_idx;
 };
@@ -181,12 +183,14 @@ static int pvt_read_in(struct device *dev, u32 attr, int channel, long *val)
 	struct regmap *v_map = pvt->v_map;
 	u32 n, stat;
 	u8 vm_idx;
+	u8 ch_idx;
 	int ret;
 
-	if (channel >= pvt->v_num)
+	if (channel >= pvt->v_num * pvt->c_num)
 		return -EINVAL;
 
-	vm_idx = pvt->vm_idx[channel];
+	vm_idx = pvt->vm_idx[channel / pvt->c_num];
+	ch_idx = channel % pvt->c_num;
 
 	switch (attr) {
 	case hwmon_in_input:
@@ -197,7 +201,7 @@ static int pvt_read_in(struct device *dev, u32 attr, int channel, long *val)
 		if (ret)
 			return ret;
 
-		ret = regmap_read(v_map, VM_SDIF_DATA(vm_idx), &n);
+		ret = regmap_read(v_map, VM_SDIF_DATA(vm_idx, ch_idx), &n);
 		if(ret < 0)
 			return ret;
 
@@ -386,6 +390,20 @@ static int pvt_init(struct pvt_device *pvt)
 		if (ret)
 			return ret;
 
+		val = GENMASK(pvt->c_num - 1, 0) | VM_CH_INIT |
+		      IP_POLL << SDIF_ADDR_SFT |
+		      SDIF_WRN_W | SDIF_PROG;
+		ret = regmap_write(v_map, SDIF_W, val);
+		if (ret < 0)
+			return ret;
+
+		ret = regmap_read_poll_timeout(v_map, SDIF_STAT,
+					       val, !(val & SDIF_BUSY),
+					       PVT_POLL_DELAY_US,
+					       PVT_POLL_TIMEOUT_US);
+		if (ret)
+			return ret;
+
 		val = CFG1_VOL_MEAS_MODE | CFG1_PARALLEL_OUT |
 		      CFG1_14_BIT | IP_CFG << SDIF_ADDR_SFT |
 		      SDIF_WRN_W | SDIF_PROG;
@@ -501,7 +519,7 @@ static int pvt_reset_control_deassert(struct device *dev, struct pvt_device *pvt
 static int mr75203_probe(struct platform_device *pdev)
 {
 	const struct hwmon_channel_info **pvt_info;
-	u32 ts_num, vm_num, pd_num, val, index, i;
+	u32 ts_num, vm_num, pd_num, ch_num, val, index, i;
 	struct device *dev = &pdev->dev;
 	u32 *temp_config, *in_config;
 	struct device *hwmon_dev;
@@ -547,9 +565,11 @@ static int mr75203_probe(struct platform_device *pdev)
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
@@ -586,6 +606,8 @@ static int mr75203_probe(struct platform_device *pdev)
 	}
 
 	if (vm_num) {
+		u32 total_ch = ch_num * vm_num;
+
 		ret = pvt_get_regmap(pdev, "vm", pvt);
 		if (ret)
 			return ret;
@@ -614,13 +636,13 @@ static int mr75203_probe(struct platform_device *pdev)
 			pvt->v_num = i;
 		}
 
-		in_config = devm_kcalloc(dev, vm_num + 1,
+		in_config = devm_kcalloc(dev, total_ch + 1,
 					 sizeof(*in_config), GFP_KERNEL);
 		if (!in_config)
 			return -ENOMEM;
 
-		memset32(in_config, HWMON_I_INPUT, vm_num);
-		in_config[vm_num] = 0;
+		memset32(in_config, HWMON_I_INPUT, total_ch);
+		in_config[total_ch] = 0;
 		pvt_in.config = in_config;
 
 		pvt_info[index++] = &pvt_in;
-- 
2.37.1

