Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E875AB843
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiIBSeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiIBSeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:34:02 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B038A105B74;
        Fri,  2 Sep 2022 11:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662143640; x=1693679640;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=xkJ6xoIywugi4fMwTGaUIozhuU7T/pgcEKpJ47n1K48=;
  b=E2uImZQi6CBtCSs6E7pxiTd+ZpF5TEmybzsM5RBvD41ccuwNw+3lZavZ
   Jz6cqsb0ubfCU3qnsSXm9hRlaU5F94FKulhOfkwBPCGp+gs6OlMSB3j8P
   pRokXr26ll+2MT6pDanhP9qiT02tBjlOL5HXsh2TRq9xjPr7DNTloB6q5
   BkUUghisndwp9P2ApfiCX+5GAbLjCawqvoF6XyBKepSJ/w268V9WteaT3
   k0OdbYxSbbP1C5VtiZii/96YghlV2ej/kJksZIaowaseHHHPbPvGpljLC
   GLOcf5eurMjDo91MAr/9ZT0ReQ3dTsA/gbR7W7ri2o62W+iGIgtCUhAyZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="293635826"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="293635826"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 11:26:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="646203180"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 02 Sep 2022 11:26:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 330DC63F; Fri,  2 Sep 2022 21:27:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 10/17] pinctrl: cy8c95x0: Remove custom ->set_config()
Date:   Fri,  2 Sep 2022 21:26:43 +0300
Message-Id: <20220902182650.83098-10-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com>
References: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have pin configuration getter and setter provided,
there is no need to duplicate that in the custom ->set_config().
Instead, switch to gpiochip_generic_config().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 97da22016cce..55bd48c9d020 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -761,30 +761,6 @@ static int cy8c95x0_gpio_set_pincfg(struct cy8c95x0_pinctrl *chip,
 	return ret;
 }
 
-static int cy8c95x0_gpio_set_config(struct gpio_chip *gc, unsigned int offset,
-				    unsigned long config)
-{
-	struct cy8c95x0_pinctrl *chip = gpiochip_get_data(gc);
-	unsigned long arg = pinconf_to_config_argument(config);
-
-	switch (pinconf_to_config_param(config)) {
-	case PIN_CONFIG_INPUT_ENABLE:
-		return cy8c95x0_gpio_direction_input(gc, offset);
-	case PIN_CONFIG_OUTPUT:
-		return cy8c95x0_gpio_direction_output(gc, offset, arg);
-	case PIN_CONFIG_MODE_PWM:
-	case PIN_CONFIG_BIAS_PULL_UP:
-	case PIN_CONFIG_BIAS_PULL_DOWN:
-	case PIN_CONFIG_BIAS_DISABLE:
-	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
-	case PIN_CONFIG_DRIVE_OPEN_SOURCE:
-	case PIN_CONFIG_DRIVE_PUSH_PULL:
-		return cy8c95x0_gpio_set_pincfg(chip, offset, config);
-	default:
-		return -ENOTSUPP;
-	}
-}
-
 static int cy8c95x0_gpio_get_multiple(struct gpio_chip *gc,
 				      unsigned long *mask, unsigned long *bits)
 {
@@ -825,7 +801,7 @@ static int cy8c95x0_setup_gpiochip(struct cy8c95x0_pinctrl *chip)
 	gc->get_direction = cy8c95x0_gpio_get_direction;
 	gc->get_multiple = cy8c95x0_gpio_get_multiple;
 	gc->set_multiple = cy8c95x0_gpio_set_multiple;
-	gc->set_config = cy8c95x0_gpio_set_config;
+	gc->set_config = gpiochip_generic_config,
 	gc->can_sleep = true;
 	gc->add_pin_ranges = cy8c95x0_add_pin_ranges;
 
-- 
2.35.1

