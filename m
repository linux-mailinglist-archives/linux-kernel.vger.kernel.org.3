Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B516B5812C1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 14:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239080AbiGZMGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 08:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbiGZMFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 08:05:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246E62AC6D;
        Tue, 26 Jul 2022 05:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658837155; x=1690373155;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MJcfMMw6vibpVnMNINqRvTa/7DV3eje+x+g9lq2jXNg=;
  b=ROT+jCB82bXvDUhA5uKEDlSQ+ltpq6HMJi1W7H8l3XOVzDgVtMkGb5O0
   qsl0X33d04vGVqGcrSL6z0gKIjCp0syHo3G7eIkBkRQQKF6d3py0n4Twf
   6IFzViIZNm0tOImXPkEzywthCsA6efDowYhVdEzvXWXA5Bb8W4arwxCCy
   tl1B1vrvhmG+GVVfEGiOJ9xBvbZrP9gUJauFJ6QpWQB1WJ7qnbhILCJZu
   hjIY6eze1PUvAoa1J6sGvt/GAAHKEbD9yN+GiY3/sLeS4e4afabp59uII
   5ytDGr1q8btk+0idDjYkSvOUEwzY0eaJbW0btbcGBgRVB7GBH/acTPGJ/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="270971287"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="270971287"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 05:05:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="702871731"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jul 2022 05:05:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 501E8F1; Tue, 26 Jul 2022 15:06:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tianshu Qiu <tian.shu.qiu@intel.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v1 1/8] media: ov2740: Remove duplicative pointer in struct nvm_data
Date:   Tue, 26 Jul 2022 15:05:49 +0300
Message-Id: <20220726120556.2881-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct i2c_client pointer is used only to get driver data,
associated with a struct device or print messages on behalf.
Moreover, the very same pointer to a struct device is already
assigned by a regmap and can be retrieved from there.
No need to keep a duplicative pointer.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/i2c/ov2740.c | 39 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/media/i2c/ov2740.c b/drivers/media/i2c/ov2740.c
index d5f0eabf20c6..c975db1bbe8c 100644
--- a/drivers/media/i2c/ov2740.c
+++ b/drivers/media/i2c/ov2740.c
@@ -77,7 +77,6 @@
 #define OV2740_REG_OTP_CUSTOMER		0x7010
 
 struct nvm_data {
-	struct i2c_client *client;
 	struct nvmem_device *nvmem;
 	struct regmap *regmap;
 	char *nvm_buffer;
@@ -649,34 +648,28 @@ static void ov2740_update_pad_format(const struct ov2740_mode *mode,
 
 static int ov2740_load_otp_data(struct nvm_data *nvm)
 {
-	struct i2c_client *client;
-	struct ov2740 *ov2740;
+	struct device *dev = regmap_get_device(nvm->regmap);
+	struct ov2740 *ov2740 = to_ov2740(dev_get_drvdata(dev));
 	u32 isp_ctrl00 = 0;
 	u32 isp_ctrl01 = 0;
 	int ret;
 
-	if (!nvm)
-		return -EINVAL;
-
 	if (nvm->nvm_buffer)
 		return 0;
 
-	client = nvm->client;
-	ov2740 = to_ov2740(i2c_get_clientdata(client));
-
 	nvm->nvm_buffer = kzalloc(CUSTOMER_USE_OTP_SIZE, GFP_KERNEL);
 	if (!nvm->nvm_buffer)
 		return -ENOMEM;
 
 	ret = ov2740_read_reg(ov2740, OV2740_REG_ISP_CTRL00, 1, &isp_ctrl00);
 	if (ret) {
-		dev_err(&client->dev, "failed to read ISP CTRL00\n");
+		dev_err(dev, "failed to read ISP CTRL00\n");
 		goto err;
 	}
 
 	ret = ov2740_read_reg(ov2740, OV2740_REG_ISP_CTRL01, 1, &isp_ctrl01);
 	if (ret) {
-		dev_err(&client->dev, "failed to read ISP CTRL01\n");
+		dev_err(dev, "failed to read ISP CTRL01\n");
 		goto err;
 	}
 
@@ -684,7 +677,7 @@ static int ov2740_load_otp_data(struct nvm_data *nvm)
 	ret = ov2740_write_reg(ov2740, OV2740_REG_ISP_CTRL00, 1,
 			       isp_ctrl00 & ~BIT(5));
 	if (ret) {
-		dev_err(&client->dev, "failed to set ISP CTRL00\n");
+		dev_err(dev, "failed to set ISP CTRL00\n");
 		goto err;
 	}
 
@@ -692,14 +685,14 @@ static int ov2740_load_otp_data(struct nvm_data *nvm)
 	ret = ov2740_write_reg(ov2740, OV2740_REG_ISP_CTRL01, 1,
 			       isp_ctrl01 & ~BIT(7));
 	if (ret) {
-		dev_err(&client->dev, "failed to set ISP CTRL01\n");
+		dev_err(dev, "failed to set ISP CTRL01\n");
 		goto err;
 	}
 
 	ret = ov2740_write_reg(ov2740, OV2740_REG_MODE_SELECT, 1,
 			       OV2740_MODE_STREAMING);
 	if (ret) {
-		dev_err(&client->dev, "failed to set streaming mode\n");
+		dev_err(dev, "failed to set streaming mode\n");
 		goto err;
 	}
 
@@ -712,26 +705,26 @@ static int ov2740_load_otp_data(struct nvm_data *nvm)
 	ret = regmap_bulk_read(nvm->regmap, OV2740_REG_OTP_CUSTOMER,
 			       nvm->nvm_buffer, CUSTOMER_USE_OTP_SIZE);
 	if (ret) {
-		dev_err(&client->dev, "failed to read OTP data, ret %d\n", ret);
+		dev_err(dev, "failed to read OTP data, ret %d\n", ret);
 		goto err;
 	}
 
 	ret = ov2740_write_reg(ov2740, OV2740_REG_MODE_SELECT, 1,
 			       OV2740_MODE_STANDBY);
 	if (ret) {
-		dev_err(&client->dev, "failed to set streaming mode\n");
+		dev_err(dev, "failed to set streaming mode\n");
 		goto err;
 	}
 
 	ret = ov2740_write_reg(ov2740, OV2740_REG_ISP_CTRL01, 1, isp_ctrl01);
 	if (ret) {
-		dev_err(&client->dev, "failed to set ISP CTRL01\n");
+		dev_err(dev, "failed to set ISP CTRL01\n");
 		goto err;
 	}
 
 	ret = ov2740_write_reg(ov2740, OV2740_REG_ISP_CTRL00, 1, isp_ctrl00);
 	if (ret) {
-		dev_err(&client->dev, "failed to set ISP CTRL00\n");
+		dev_err(dev, "failed to set ISP CTRL00\n");
 		goto err;
 	}
 
@@ -746,7 +739,6 @@ static int ov2740_load_otp_data(struct nvm_data *nvm)
 static int ov2740_start_streaming(struct ov2740 *ov2740)
 {
 	struct i2c_client *client = v4l2_get_subdevdata(&ov2740->sd);
-	struct nvm_data *nvm = ov2740->nvm;
 	const struct ov2740_reg_list *reg_list;
 	int link_freq_index;
 	int ret = 0;
@@ -755,7 +747,8 @@ static int ov2740_start_streaming(struct ov2740 *ov2740)
 	if (ret)
 		return ret;
 
-	ov2740_load_otp_data(nvm);
+	if (ov2740->nvm)
+		ov2740_load_otp_data(ov2740->nvm);
 
 	link_freq_index = ov2740->cur_mode->link_freq_index;
 	reg_list = &link_freq_configs[link_freq_index].reg_list;
@@ -1071,9 +1064,8 @@ static int ov2740_nvmem_read(void *priv, unsigned int off, void *val,
 			     size_t count)
 {
 	struct nvm_data *nvm = priv;
-	struct v4l2_subdev *sd = i2c_get_clientdata(nvm->client);
-	struct device *dev = &nvm->client->dev;
-	struct ov2740 *ov2740 = to_ov2740(sd);
+	struct device *dev = regmap_get_device(nvm->regmap);
+	struct ov2740 *ov2740 = to_ov2740(dev_get_drvdata(dev));
 	int ret = 0;
 
 	mutex_lock(&ov2740->mutex);
@@ -1120,7 +1112,6 @@ static int ov2740_register_nvmem(struct i2c_client *client,
 		return PTR_ERR(regmap);
 
 	nvm->regmap = regmap;
-	nvm->client = client;
 
 	nvmem_config.name = dev_name(dev);
 	nvmem_config.dev = dev;
-- 
2.35.1

