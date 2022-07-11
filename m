Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D898570CC3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiGKVfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiGKVf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:35:29 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC1527173;
        Mon, 11 Jul 2022 14:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657575328; x=1689111328;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=NYFzjtjo3hI3b196haT7JB1le3WzmcyUxNaCDlrIrJ0=;
  b=dUmxBhYhlQbKYv+6r0EIn78kRE71TpHxZNwSD/TiyBQhDSVbzlY5KVKD
   +MDe5Qa6eCdssILq+q1RjgeXAcNhy3JGEOjyTs5ujQu7oha1v8K7HUwQa
   m2oHDUvmBUhdaTi1goNALCt7Z0109/bhI2gcj8b8IxjsoRbSlKtcwd01T
   TwwaJoU1gz765zCFbAlv/5HGfPLxuOzH3dSAK/5a1dmYxA67zjAm0FBv2
   r6bRsIhPSXt0AaCB+6ZcshANB8lOBuJ91+kCHdoNc594/y/RAi5N+1zEk
   vE+hGlek+pItTJW74fILZuyZL00UaxcBsih4SUBajBp+ATumDvSkEDoq/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="346458131"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="346458131"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 14:35:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="684535812"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jul 2022 14:35:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 83204400; Tue, 12 Jul 2022 00:35:33 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pavel Machek <pavel@ucw.cz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] leds: is31fl319x: Fix devm vs. non-devm ordering
Date:   Tue, 12 Jul 2022 00:35:22 +0300
Message-Id: <20220711213524.3587-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220711213524.3587-1-andriy.shevchenko@linux.intel.com>
References: <20220711213524.3587-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When non-devm resources are allocated they mustn't be followed by
devm allocations, otherwise it will break the tear down ordering
and might lead to crashes or other bugs during ->remove() stage.
Fix this by wrapping mutex_destroy() call with
devm_add_action_or_reset().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/leds/leds-is31fl319x.c | 32 +++++++++-----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/drivers/leds/leds-is31fl319x.c b/drivers/leds/leds-is31fl319x.c
index d9cf70505c43..233ed67830a3 100644
--- a/drivers/leds/leds-is31fl319x.c
+++ b/drivers/leds/leds-is31fl319x.c
@@ -511,10 +511,13 @@ static int is31fl319x_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	mutex_init(&is31->lock);
+	err = devm_add_action(dev, (void (*)(void *))mutex_destroy, &is31->lock);
+	if (err)
+		return err;
 
 	err = is31fl319x_parse_fw(&client->dev, is31);
 	if (err)
-		goto free_mutex;
+		return err;
 
 	if (is31->shutdown_gpio) {
 		gpiod_direction_output(is31->shutdown_gpio, 0);
@@ -524,19 +527,15 @@ static int is31fl319x_probe(struct i2c_client *client,
 
 	is31->client = client;
 	is31->regmap = devm_regmap_init_i2c(client, is31->cdef->is31fl319x_regmap_config);
-	if (IS_ERR(is31->regmap)) {
-		err = dev_err_probe(dev, PTR_ERR(is31->regmap), "failed to allocate register map\n");
-		goto free_mutex;
-	}
+	if (IS_ERR(is31->regmap))
+		return dev_err_probe(dev, PTR_ERR(is31->regmap), "failed to allocate register map\n");
 
 	i2c_set_clientdata(client, is31);
 
 	/* check for write-reply from chip (we can't read any registers) */
 	err = regmap_write(is31->regmap, is31->cdef->reset_reg, 0x00);
-	if (err < 0) {
-		err = dev_err_probe(dev, err, "no response from chip write\n");
-		goto free_mutex;
-	}
+	if (err < 0)
+		return dev_err_probe(dev, err, "no response from chip write\n");
 
 	/*
 	 * Kernel conventions require per-LED led-max-microamp property.
@@ -568,22 +567,10 @@ static int is31fl319x_probe(struct i2c_client *client,
 
 		err = devm_led_classdev_register(&client->dev, &led->cdev);
 		if (err < 0)
-			goto free_mutex;
+			return err;
 	}
 
 	return 0;
-
-free_mutex:
-	mutex_destroy(&is31->lock);
-	return err;
-}
-
-static int is31fl319x_remove(struct i2c_client *client)
-{
-	struct is31fl319x_chip *is31 = i2c_get_clientdata(client);
-
-	mutex_destroy(&is31->lock);
-	return 0;
 }
 
 /*
@@ -611,7 +598,6 @@ static struct i2c_driver is31fl319x_driver = {
 		.of_match_table = of_is31fl319x_match,
 	},
 	.probe    = is31fl319x_probe,
-	.remove   = is31fl319x_remove,
 	.id_table = is31fl319x_id,
 };
 
-- 
2.35.1

