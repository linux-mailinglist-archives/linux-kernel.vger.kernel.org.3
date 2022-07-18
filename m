Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D73C578D40
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 00:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236433AbiGRWC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbiGRWC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:02:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691A83123A;
        Mon, 18 Jul 2022 15:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658181777; x=1689717777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YzoNkDQpsCe1jaKRzKqoEsfnVBE89io/l2jisd5Aa9Q=;
  b=P8w5hRM8Q9MoTs/tNN9AdmJEjSQ87CBinQWUGe2JQN7wQ0AEr+mvRt1C
   KxnA9TsU6Hgz+t/jFIQ2mprwyevnRF03wl/8f2p7tTZ0foJhsCRf6p+4+
   4e+Fxmk2n7ZNl03XbM7xRjEQFE7yqIn+a9QRJ+YvCSUqHHcaYMB50Wswd
   /6oYPaHKA9E4c1HtQ2Dbxsyd5vZvvG4KXKJ1Lr2DafPkSZM4wCAV266Ja
   0P2yUy37yBcynGSVe8mdShniuWWbbOcXTmY3igZFKaXMDXsn0DdZp5gtY
   8qONBw7Dhs+8P1pnNzHekU2qmbAA/F6kTfkeNzQSveyU/cgdIt2J2yVi4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="285087798"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="285087798"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 15:02:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="597413626"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 18 Jul 2022 15:02:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 24118F1; Tue, 19 Jul 2022 01:02:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 2/3] gpio: 74xx-mmio: Check MMIO_74XX_DIR_IN flag in mmio_74xx_dir_in()
Date:   Tue, 19 Jul 2022 01:02:51 +0300
Message-Id: <20220718220252.16923-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220718220252.16923-1-andriy.shevchenko@linux.intel.com>
References: <20220718220252.16923-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's logically better to check the IN in ->direction_input() and
_OUT in ->direction_output().

While at it, replace ternary with plain if-conditional for the sake
of consistency with mmio_74xx_dir_out().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-74xx-mmio.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-74xx-mmio.c b/drivers/gpio/gpio-74xx-mmio.c
index 5e3c948ddb73..b2cc8a55c257 100644
--- a/drivers/gpio/gpio-74xx-mmio.c
+++ b/drivers/gpio/gpio-74xx-mmio.c
@@ -88,7 +88,10 @@ static int mmio_74xx_dir_in(struct gpio_chip *gc, unsigned int gpio)
 {
 	struct mmio_74xx_gpio_priv *priv = gpiochip_get_data(gc);
 
-	return (priv->flags & MMIO_74XX_DIR_OUT) ? -ENOTSUPP : 0;
+	if (priv->flags & MMIO_74XX_DIR_IN)
+		return 0;
+
+	return -ENOTSUPP;
 }
 
 static int mmio_74xx_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
-- 
2.35.1

