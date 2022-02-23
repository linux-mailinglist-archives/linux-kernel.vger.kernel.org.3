Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7AC4C17A1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242423AbiBWPrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242407AbiBWPrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:47:36 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3338522E6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 07:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645631228; x=1677167228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PzYQR+t0O5FQrk4Z747NPIlXOGLHErjoDvgAXwUgPi8=;
  b=ikYyncQ01eYUbgWvoi7lovlnlUlApvexrV8piiJQqBJ40uN98Zq0gYqF
   USRRAdnyORvftnYNXmB4vUDQ17KFtjT4Ah7sstoKfUyHcc+0M59GLA9hK
   nDcomlkDtwbcnwTUKNcJ8pd5XJjeWw7QpLIRkP9jou0r1VaX5A6bU9XSQ
   aaCtsKdiWHtDaLAfBJm7j2hAO3SfHVsirBeA8ryAvWmuCfy5UTaLwZk9+
   xw6KpSZHavxnQYKztn4WTiil75P0TpwLJ9CCsHgVVjx1R9hsZJordsqwA
   9n6IWVzurEGpMOiM/bLmdC6/dSXlWaO/0lVnegzIKxMFMXHWupoxDOtX3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="276613018"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="276613018"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 07:47:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="543356370"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 23 Feb 2022 07:47:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 01ECC73; Wed, 23 Feb 2022 17:47:23 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars Poeschel <poeschel@lemonage.de>
Subject: [PATCH v1 2/3] auxdisplay: lcd2s: Fix memory leak in ->remove()
Date:   Wed, 23 Feb 2022 17:47:17 +0200
Message-Id: <20220223154718.83500-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220223154718.83500-1-andriy.shevchenko@linux.intel.com>
References: <20220223154718.83500-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once allocated the struct lcd2s_data is never freed.
Fix the memory leak by switching to devm_kzalloc().

Fixes: 8c9108d014c5 ("auxdisplay: add a driver for lcd2s character display")
Cc: Lars Poeschel <poeschel@lemonage.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/lcd2s.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/auxdisplay/lcd2s.c b/drivers/auxdisplay/lcd2s.c
index ea9d75ad4f16..7b9cfbbaf007 100644
--- a/drivers/auxdisplay/lcd2s.c
+++ b/drivers/auxdisplay/lcd2s.c
@@ -298,6 +298,10 @@ static int lcd2s_i2c_probe(struct i2c_client *i2c,
 			I2C_FUNC_SMBUS_WRITE_BLOCK_DATA))
 		return -EIO;
 
+	lcd2s = devm_kzalloc(&i2c->dev, sizeof(*lcd2s), GFP_KERNEL);
+	if (!lcd2s)
+		return -ENOMEM;
+
 	/* Test, if the display is responding */
 	err = lcd2s_i2c_smbus_write_byte(i2c, LCD2S_CMD_DISPLAY_OFF);
 	if (err < 0)
@@ -307,12 +311,6 @@ static int lcd2s_i2c_probe(struct i2c_client *i2c,
 	if (!lcd)
 		return -ENOMEM;
 
-	lcd2s = kzalloc(sizeof(struct lcd2s_data), GFP_KERNEL);
-	if (!lcd2s) {
-		err = -ENOMEM;
-		goto fail1;
-	}
-
 	lcd->drvdata = lcd2s;
 	lcd2s->i2c = i2c;
 	lcd2s->charlcd = lcd;
@@ -321,24 +319,22 @@ static int lcd2s_i2c_probe(struct i2c_client *i2c,
 	err = device_property_read_u32(&i2c->dev, "display-height-chars",
 			&lcd->height);
 	if (err)
-		goto fail2;
+		goto fail1;
 
 	err = device_property_read_u32(&i2c->dev, "display-width-chars",
 			&lcd->width);
 	if (err)
-		goto fail2;
+		goto fail1;
 
 	lcd->ops = &lcd2s_ops;
 
 	err = charlcd_register(lcd2s->charlcd);
 	if (err)
-		goto fail2;
+		goto fail1;
 
 	i2c_set_clientdata(i2c, lcd2s);
 	return 0;
 
-fail2:
-	kfree(lcd2s);
 fail1:
 	kfree(lcd);
 	return err;
-- 
2.34.1

