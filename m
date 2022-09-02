Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1867D5AB849
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiIBSeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiIBSeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:34:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3C3110DA8;
        Fri,  2 Sep 2022 11:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662143210; x=1693679210;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Q3WRq63GSFT0VKkdIUx6lAxO0G6NE0E/uC/WGB8UDaY=;
  b=ghjbht9M2YaZbrD8rBmK7OcQrWf2oNn8Q0ECFw3yNPyzzMpjej6JA5MK
   oUsEMRSTDe5ujNQD39+FqwLr5QI25WcHVAubuG/miq6VoT8Ugu/TihjfB
   wrn/lnr6y08VsBW4BtEdNtBVU+ratItxvxQOpQQHsy/0QpGebpE6OBQxC
   rcTMOkSy6b7BWbMLqRdjrnEztQ6BCrdE5R7ia4yBEy7EulQWHMCf1q6ri
   ujMiloVjO5jzgSWkWxExNA7XUPzMJxDB3SEcKYEQc8sI8ihZE9NmJ00Ev
   U4L272aA86jOIIsRfizCyaKHx8ixZxZcpABdKeOtH91fI97yahWq7Fs/B
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="283034556"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="283034556"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 11:26:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="681373078"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 02 Sep 2022 11:26:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 25BC35E4; Fri,  2 Sep 2022 21:27:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 08/17] pinctrl: cy8c95x0: Remove device initialization
Date:   Fri,  2 Sep 2022 21:26:41 +0300
Message-Id: <20220902182650.83098-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com>
References: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Cypress CY8C95x0 chips have an internal EEPROM that defines
initial configuration. It might be that bootloader or other
entity wrote the platform related setup into it. Don't override
it in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index f09311d2d3fa..b09f9485e57d 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -1213,30 +1213,6 @@ static int cy8c95x0_setup_pinctrl(struct cy8c95x0_pinctrl *chip)
 	return 0;
 }
 
-static int device_cy8c95x0_init(struct cy8c95x0_pinctrl *chip)
-{
-	DECLARE_BITMAP(ones, MAX_LINE);
-	DECLARE_BITMAP(zeros, MAX_LINE);
-	int ret;
-
-	/* Set all pins to input. This is the POR default. */
-	bitmap_fill(ones, MAX_LINE);
-	ret = cy8c95x0_write_regs_mask(chip, CY8C95X0_DIRECTION, ones, ones);
-	if (ret) {
-		dev_err(chip->dev, "Failed to set pins to input\n");
-		return ret;
-	}
-
-	bitmap_zero(zeros, MAX_LINE);
-	ret = cy8c95x0_write_regs_mask(chip, CY8C95X0_INVERT, zeros, ones);
-	if (ret) {
-		dev_err(chip->dev, "Failed to set polarity inversion\n");
-		return ret;
-	}
-
-	return 0;
-}
-
 static int cy8c95x0_detect(struct i2c_client *client,
 			   struct i2c_board_info *info)
 {
@@ -1332,10 +1308,6 @@ static int cy8c95x0_probe(struct i2c_client *client)
 	bitmap_set(chip->shiftmask, 0, 20);
 	mutex_init(&chip->i2c_lock);
 
-	ret = device_cy8c95x0_init(chip);
-	if (ret)
-		goto err_exit;
-
 	if (client->irq) {
 		ret = cy8c95x0_irq_setup(chip, client->irq);
 		if (ret)
-- 
2.35.1

