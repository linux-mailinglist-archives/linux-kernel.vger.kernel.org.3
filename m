Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEBA5812CA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 14:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239113AbiGZMGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 08:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239039AbiGZMF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 08:05:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7182B187;
        Tue, 26 Jul 2022 05:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658837157; x=1690373157;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y/yDmo7qbXEh70Kz4ZNEYtLjd9Z7AKLADZUFGnXR7fs=;
  b=Pmjaw6aXbeWGQn0ZW+ZVBkzAVJQmpYwdrVP/dksc7Kv7YuFW0KxMbnb3
   7eQj8aae1Pir6CwHS8KlnalHBXRwx+AeUJmppjP/vd/rWYoh5lMpuTpzA
   oqPno4W1zKKOxfeg11lvZdV/2p9DUgV62kXC7Ex3SCPcgJNHLkPMi5LSw
   Ex992IyDnlF8RTM1s4UCp8v4JEgoiyo7uffNzG4gOVjd/Owwj7btFyCEe
   LWyf6SUNOnSxxTkr963dtwY7hyDvwunijp51wt34hitBwPh+X83I1HqB8
   u1qQP25wqO64lk9Ael/wJgLVTa4OAzAO4fRRsTkHzPqmH4jjBdb0uDcEG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="285485867"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="285485867"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 05:05:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="658656518"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jul 2022 05:05:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7F270303; Tue, 26 Jul 2022 15:06:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tianshu Qiu <tian.shu.qiu@intel.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v1 6/8] media: ov2740: Switch to use dev_err_probe()
Date:   Tue, 26 Jul 2022 15:05:54 +0300
Message-Id: <20220726120556.2881-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220726120556.2881-1-andriy.shevchenko@linux.intel.com>
References: <20220726120556.2881-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to use dev_err_probe() to simpify error path and unify message
template.

While at it, add missed \n to the end of the messages.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/i2c/ov2740.c | 44 ++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/media/i2c/ov2740.c b/drivers/media/i2c/ov2740.c
index 212190cb14e4..7271e3d011c9 100644
--- a/drivers/media/i2c/ov2740.c
+++ b/drivers/media/i2c/ov2740.c
@@ -1013,10 +1013,10 @@ static int ov2740_check_hwcfg(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (mclk != OV2740_MCLK) {
-		dev_err(dev, "external clock %d is not supported", mclk);
-		return -EINVAL;
-	}
+	if (mclk != OV2740_MCLK)
+		return dev_err_probe(dev, -EINVAL,
+				     "external clock %d is not supported\n",
+				     mclk);
 
 	ep = fwnode_graph_get_next_endpoint(fwnode, NULL);
 	if (!ep)
@@ -1028,15 +1028,14 @@ static int ov2740_check_hwcfg(struct device *dev)
 		return ret;
 
 	if (bus_cfg.bus.mipi_csi2.num_data_lanes != OV2740_DATA_LANES) {
-		dev_err(dev, "number of CSI2 data lanes %d is not supported",
-			bus_cfg.bus.mipi_csi2.num_data_lanes);
-		ret = -EINVAL;
+		ret = dev_err_probe(dev, -EINVAL,
+				    "number of CSI2 data lanes %d is not supported\n",
+				    bus_cfg.bus.mipi_csi2.num_data_lanes);
 		goto check_hwcfg_error;
 	}
 
 	if (!bus_cfg.nr_of_link_frequencies) {
-		dev_err(dev, "no link frequencies defined");
-		ret = -EINVAL;
+		ret = dev_err_probe(dev, -EINVAL, "no link frequencies defined\n");
 		goto check_hwcfg_error;
 	}
 
@@ -1048,9 +1047,9 @@ static int ov2740_check_hwcfg(struct device *dev)
 		}
 
 		if (j == bus_cfg.nr_of_link_frequencies) {
-			dev_err(dev, "no link frequency %lld supported",
-				link_freq_menu_items[i]);
-			ret = -EINVAL;
+			ret = dev_err_probe(dev, -EINVAL,
+					    "no link frequency %lld supported\n",
+					    link_freq_menu_items[i]);
 			goto check_hwcfg_error;
 		}
 	}
@@ -1153,16 +1152,14 @@ static int ov2740_register_nvmem(struct i2c_client *client,
 
 static int ov2740_probe(struct i2c_client *client)
 {
+	struct device *dev = &client->dev;
 	struct ov2740 *ov2740;
 	bool full_power;
 	int ret;
 
 	ret = ov2740_check_hwcfg(&client->dev);
-	if (ret) {
-		dev_err(&client->dev, "failed to check HW configuration: %d",
-			ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to check HW configuration\n");
 
 	ov2740 = devm_kzalloc(&client->dev, sizeof(*ov2740), GFP_KERNEL);
 	if (!ov2740)
@@ -1172,17 +1169,15 @@ static int ov2740_probe(struct i2c_client *client)
 	full_power = acpi_dev_state_d0(&client->dev);
 	if (full_power) {
 		ret = ov2740_identify_module(ov2740);
-		if (ret) {
-			dev_err(&client->dev, "failed to find sensor: %d", ret);
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to find sensor\n");
 	}
 
 	mutex_init(&ov2740->mutex);
 	ov2740->cur_mode = &supported_modes[0];
 	ret = ov2740_init_controls(ov2740);
 	if (ret) {
-		dev_err(&client->dev, "failed to init controls: %d", ret);
+		dev_err_probe(dev, ret, "failed to init controls\n");
 		goto probe_error_v4l2_ctrl_handler_free;
 	}
 
@@ -1193,14 +1188,13 @@ static int ov2740_probe(struct i2c_client *client)
 	ov2740->pad.flags = MEDIA_PAD_FL_SOURCE;
 	ret = media_entity_pads_init(&ov2740->sd.entity, 1, &ov2740->pad);
 	if (ret) {
-		dev_err(&client->dev, "failed to init entity pads: %d", ret);
+		dev_err_probe(dev, ret, "failed to init entity pads\n");
 		goto probe_error_v4l2_ctrl_handler_free;
 	}
 
 	ret = v4l2_async_register_subdev_sensor(&ov2740->sd);
 	if (ret < 0) {
-		dev_err(&client->dev, "failed to register V4L2 subdev: %d",
-			ret);
+		dev_err_probe(dev, ret, "failed to register V4L2 subdev\n");
 		goto probe_error_media_entity_cleanup;
 	}
 
-- 
2.35.1

