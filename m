Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7B55812BE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 14:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239030AbiGZMF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 08:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiGZMFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 08:05:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20F623BC7;
        Tue, 26 Jul 2022 05:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658837154; x=1690373154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c8qJbgX+bkOR5QAtm73Za+GslKiRmJrk9Ct5rxSUFyw=;
  b=Vk9XlZoQPGo5w3KEfJSkEpxQJl96A8y0AHLUNS2yLO5fv9jdwqcnKLDW
   F/y/Qodfq4Dgx+7vxdWeeAHu8iXjkdZ8J+UmOrErJz076XY7wOklUk6NR
   M/qK6OGmXx8HB0YcCS3BJDd/+7EarQUGKL/6pimKg6VnQyHG/T4JQyHBC
   V9lyDQNZW/JVhn2QKZMDGWhyT5NJ1of79N2h1EPtIhdUqmH6JIhoy70Na
   dcZmHf7NhLQGGDtHxff0Igg935egX4NYju8VCTNZdmo92ePB0GqTGa59a
   5pvD29tN4vy1OphfzRo+8wGK6JL14XkM58z9iWVsqpQltD1i19vGVxjCG
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="287948612"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="287948612"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 05:05:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="689417853"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Jul 2022 05:05:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 70C6DF7; Tue, 26 Jul 2022 15:06:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tianshu Qiu <tian.shu.qiu@intel.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v1 5/8] media: ov2740: Drop redundant assignments of ret = 0
Date:   Tue, 26 Jul 2022 15:05:53 +0300
Message-Id: <20220726120556.2881-5-andriy.shevchenko@linux.intel.com>
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

In some cases it might hide real bugs, in most cases here it's just
redundant as it's being reassigned immediately after initial assignment.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/i2c/ov2740.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/media/i2c/ov2740.c b/drivers/media/i2c/ov2740.c
index 07fe8fda274e..212190cb14e4 100644
--- a/drivers/media/i2c/ov2740.c
+++ b/drivers/media/i2c/ov2740.c
@@ -378,7 +378,7 @@ static int ov2740_read_reg(struct ov2740 *ov2740, u16 reg, u16 len, u32 *val)
 	struct i2c_msg msgs[2];
 	u8 addr_buf[2];
 	u8 data_buf[4];
-	int ret = 0;
+	int ret;
 
 	if (len > 4)
 		return -EINVAL;
@@ -415,7 +415,7 @@ static int ov2740_write_reg(struct ov2740 *ov2740, u16 reg, u16 len, u32 val)
 {
 	struct i2c_client *client = v4l2_get_subdevdata(&ov2740->sd);
 	u8 buf[6];
-	int ret = 0;
+	int ret;
 
 	if (len > 4)
 		return -EINVAL;
@@ -444,7 +444,7 @@ static int ov2740_write_reg_list(struct ov2740 *ov2740,
 {
 	struct i2c_client *client = v4l2_get_subdevdata(&ov2740->sd);
 	unsigned int i;
-	int ret = 0;
+	int ret;
 
 	for (i = 0; i < r_list->num_of_regs; i++) {
 		ret = ov2740_write_reg(ov2740, r_list->regs[i].address, 1,
@@ -486,7 +486,7 @@ static int ov2740_identify_module(struct ov2740 *ov2740)
 
 static int ov2740_update_digital_gain(struct ov2740 *ov2740, u32 d_gain)
 {
-	int ret = 0;
+	int ret;
 
 	ret = ov2740_write_reg(ov2740, OV2740_REG_GROUP_ACCESS, 1,
 			       OV2740_GROUP_HOLD_START);
@@ -530,7 +530,7 @@ static int ov2740_set_ctrl(struct v4l2_ctrl *ctrl)
 					     struct ov2740, ctrl_handler);
 	struct i2c_client *client = v4l2_get_subdevdata(&ov2740->sd);
 	s64 exposure_max;
-	int ret = 0;
+	int ret;
 
 	/* Propagate change of current control to all related controls */
 	if (ctrl->id == V4L2_CID_VBLANK) {
@@ -593,7 +593,7 @@ static int ov2740_init_controls(struct ov2740 *ov2740)
 	s64 exposure_max, h_blank, pixel_rate;
 	u32 vblank_min, vblank_max, vblank_default;
 	int size;
-	int ret = 0;
+	int ret;
 
 	ctrl_hdlr = &ov2740->ctrl_handler;
 	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 8);
@@ -759,7 +759,7 @@ static int ov2740_start_streaming(struct ov2740 *ov2740)
 	struct i2c_client *client = v4l2_get_subdevdata(&ov2740->sd);
 	const struct ov2740_reg_list *reg_list;
 	int link_freq_index;
-	int ret = 0;
+	int ret;
 
 	ret = ov2740_identify_module(ov2740);
 	if (ret)
@@ -1154,8 +1154,8 @@ static int ov2740_register_nvmem(struct i2c_client *client,
 static int ov2740_probe(struct i2c_client *client)
 {
 	struct ov2740 *ov2740;
-	int ret = 0;
 	bool full_power;
+	int ret;
 
 	ret = ov2740_check_hwcfg(&client->dev);
 	if (ret) {
-- 
2.35.1

