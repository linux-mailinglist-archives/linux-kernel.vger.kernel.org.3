Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702824F9C69
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238502AbiDHSV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiDHSVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:21:54 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4EBFFF63;
        Fri,  8 Apr 2022 11:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649441987; x=1680977987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u7LpC0CRexlnr9Bm7yKus6yW4oMsBxZewEcIituiHzg=;
  b=ZApHwE8s+haXJlRL0/43qYuPyVEuTxnR9mt8AuQI6Q4aH373Gh5g5A7p
   Qn1JW1jUIP1mEPOZrlYgQ5yOWX8qlNtJP923JzJ/ViDYYSRQf0naaoS/B
   eKiNPw++NorL/kP22S4xQoBHd1QkmNHryjgclk/nklDPh4U70vrmQnTOS
   ieggWXPYYObFa3+kltnYCqbA8kipzAHsaUNxm8wqBU+7knqickItsACOY
   aoRV58UToNeQDbEIeZMDOnA7Lfpjj1JQMBHvE8nxP2mOroabRFa97tUzO
   swc5M0b68ONvhcHjLb7yZOBMv1oefbkh2b62W4u/2q6JbcHJv1deiZ8kY
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="259256462"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="259256462"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 11:19:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="525477714"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 08 Apr 2022 11:19:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3EAE7449; Fri,  8 Apr 2022 21:18:56 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 5/5] gpiolib: Move error message out of a spinlock
Date:   Fri,  8 Apr 2022 21:18:54 +0300
Message-Id: <20220408181854.73528-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408181854.73528-1-andriy.shevchenko@linux.intel.com>
References: <20220408181854.73528-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An error path is a slow path, no need to block other CPUs
when printing error messages.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index f537597838bb..6af9cd4566fb 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -288,7 +288,6 @@ static int gpiodev_add_to_list(struct gpio_device *gdev)
 		}
 	}
 
-	dev_err(&gdev->dev, "GPIO integer space overlap, cannot add chip\n");
 	return -EBUSY;
 }
 
@@ -722,6 +721,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	ret = gpiodev_add_to_list(gdev);
 	if (ret) {
 		spin_unlock_irqrestore(&gpio_lock, flags);
+		chip_err(gc, "GPIO integer space overlap, cannot add chip\n");
 		goto err_free_label;
 	}
 
-- 
2.35.1

