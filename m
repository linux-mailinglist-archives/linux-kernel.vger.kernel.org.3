Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6457570CC4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiGKVfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiGKVf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:35:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B132714E;
        Mon, 11 Jul 2022 14:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657575327; x=1689111327;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=WepEYXWNkKtUNB934NK3NkDIk/AZ9SLeWeiU6/NlxkI=;
  b=QYduBDe/zBTBJ5m19HqyRarXXjKl3zNJlv6DgW87UfrduErmsNF5mZCj
   5XX+yKFnJSoVST4E4Bo104J7L2GfVUh0PiJreN5a+MbablI4QjmexdyIj
   5cBCucvI/FFXZN+eoaWWi8i0vxvyQRR61Mcoi/wyiwviuYqn+gDb4AJfo
   6tZHduxzjM7IGaTERmAIhca9sF/igNu9ZH23o2mP4ByOOwMqDfrIlgKzX
   G7t90eUH8nOPp52TniqegtpTBWpHRIUW5TBpPZxZ4Qt/BzKcvbtzevTlh
   4zXdFzsMR9tVdEoqOEymnLbIvOteHhFlUImkytlBb/Yq4GIpuNutEcbp7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="348752150"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="348752150"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 14:35:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="771651598"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 11 Jul 2022 14:35:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7B9F3AD; Tue, 12 Jul 2022 00:35:33 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pavel Machek <pavel@ucw.cz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] leds: is31fl319x: Make use of dev_err_probe()
Date:   Tue, 12 Jul 2022 00:35:21 +0300
Message-Id: <20220711213524.3587-2-andriy.shevchenko@linux.intel.com>
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

Simplify the error handling in probe function by switching from
dev_err() to dev_err_probe().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/leds/leds-is31fl319x.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/leds/leds-is31fl319x.c b/drivers/leds/leds-is31fl319x.c
index b1a0ca340e24..d9cf70505c43 100644
--- a/drivers/leds/leds-is31fl319x.c
+++ b/drivers/leds/leds-is31fl319x.c
@@ -396,11 +396,9 @@ static int is31fl319x_parse_fw(struct device *dev, struct is31fl319x_chip *is31)
 	int ret;
 
 	is31->shutdown_gpio = devm_gpiod_get_optional(dev, "shutdown", GPIOD_OUT_HIGH);
-	if (IS_ERR(is31->shutdown_gpio)) {
-		ret = PTR_ERR(is31->shutdown_gpio);
-		dev_err(dev, "Failed to get shutdown gpio: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(is31->shutdown_gpio))
+		return dev_err_probe(dev, PTR_ERR(is31->shutdown_gpio),
+				     "Failed to get shutdown gpio\n");
 
 	is31->cdef = device_get_match_data(dev);
 
@@ -410,11 +408,10 @@ static int is31fl319x_parse_fw(struct device *dev, struct is31fl319x_chip *is31)
 
 	dev_dbg(dev, "probing with %d leds defined in DT\n", count);
 
-	if (!count || count > is31->cdef->num_leds) {
-		dev_err(dev, "Number of leds defined must be between 1 and %u\n",
-			is31->cdef->num_leds);
-		return -ENODEV;
-	}
+	if (!count || count > is31->cdef->num_leds)
+		return dev_err_probe(dev, -ENODEV,
+				     "Number of leds defined must be between 1 and %u\n",
+				     is31->cdef->num_leds);
 
 	fwnode_for_each_available_child_node(fwnode, child) {
 		struct is31fl319x_led *led;
@@ -422,27 +419,25 @@ static int is31fl319x_parse_fw(struct device *dev, struct is31fl319x_chip *is31)
 
 		ret = fwnode_property_read_u32(child, "reg", &reg);
 		if (ret) {
-			dev_err(dev, "Failed to read led 'reg' property\n");
+			ret = dev_err_probe(dev, ret, "Failed to read led 'reg' property\n");
 			goto put_child_node;
 		}
 
 		if (reg < 1 || reg > is31->cdef->num_leds) {
-			dev_err(dev, "invalid led reg %u\n", reg);
-			ret = -EINVAL;
+			ret = dev_err_probe(dev, -EINVAL, "invalid led reg %u\n", reg);
 			goto put_child_node;
 		}
 
 		led = &is31->leds[reg - 1];
 
 		if (led->configured) {
-			dev_err(dev, "led %u is already configured\n", reg);
-			ret = -EINVAL;
+			ret = dev_err_probe(dev, -EINVAL, "led %u is already configured\n", reg);
 			goto put_child_node;
 		}
 
 		ret = is31fl319x_parse_child_fw(dev, child, led, is31);
 		if (ret) {
-			dev_err(dev, "led %u DT parsing failed\n", reg);
+			ret = dev_err_probe(dev, ret, "led %u DT parsing failed\n", reg);
 			goto put_child_node;
 		}
 
@@ -530,8 +525,7 @@ static int is31fl319x_probe(struct i2c_client *client,
 	is31->client = client;
 	is31->regmap = devm_regmap_init_i2c(client, is31->cdef->is31fl319x_regmap_config);
 	if (IS_ERR(is31->regmap)) {
-		dev_err(&client->dev, "failed to allocate register map\n");
-		err = PTR_ERR(is31->regmap);
+		err = dev_err_probe(dev, PTR_ERR(is31->regmap), "failed to allocate register map\n");
 		goto free_mutex;
 	}
 
@@ -540,8 +534,7 @@ static int is31fl319x_probe(struct i2c_client *client,
 	/* check for write-reply from chip (we can't read any registers) */
 	err = regmap_write(is31->regmap, is31->cdef->reset_reg, 0x00);
 	if (err < 0) {
-		dev_err(&client->dev, "no response from chip write: err = %d\n", err);
-		err = -EIO; /* does not answer */
+		err = dev_err_probe(dev, err, "no response from chip write\n");
 		goto free_mutex;
 	}
 
-- 
2.35.1

