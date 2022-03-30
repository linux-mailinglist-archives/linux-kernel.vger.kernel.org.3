Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E794EC7A7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347737AbiC3PAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347697AbiC3PAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:00:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EA260F0;
        Wed, 30 Mar 2022 07:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648652337; x=1680188337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SpYrts1YeZWLv9clP3yHemnD63N6o2d9vX+0nOBBfO0=;
  b=QtQKeH4w8EnxHtH98TLgra/oWk1enc0PG7QJEdsppPAWSXh33IRzBWv3
   7eO9DpxrjB90N70ZpZ3xofdfXGkndoNrpnUHPjzHUZGAYeuth2Xj/r2sh
   dpBf6vmWwZrlR9qCOl9JetvmimKo9ft6Hdhv/LPMoG1P8FDjTI6RT3KvT
   x9QQ+0aKkQGjT8ktSKcLak9gmtgwp43xcCldsjZrcwifnNDq1SKq5cWMJ
   4gubo/kzOFshOzt2DNg00+MZI9Sg16kiII92Xme2WrYl2gdNMEhgv+P+1
   1uV8Bou70Cu7KojNZiIZF9Ik2c84qd+Nz9J2LVqmuAbNpQUmirAp71bcx
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="247064042"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="247064042"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 07:58:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="519707735"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 30 Mar 2022 07:58:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C017B1C3; Wed, 30 Mar 2022 17:59:15 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 3/3] gpiolib: Move error message out of a spinlock
Date:   Wed, 30 Mar 2022 17:59:10 +0300
Message-Id: <20220330145910.1946-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330145910.1946-1-andriy.shevchenko@linux.intel.com>
References: <20220330145910.1946-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An error path is a slow path, no need to block other CPUs
when printing error messages.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index f956c533f218..062d127d9a0d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -289,7 +289,6 @@ static int gpiodev_add_to_list(struct gpio_device *gdev)
 		}
 	}
 
-	dev_err(&gdev->dev, "GPIO integer space overlap, cannot add chip\n");
 	return -EBUSY;
 }
 
@@ -724,6 +723,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	ret = gpiodev_add_to_list(gdev);
 	if (ret) {
 		spin_unlock_irqrestore(&gpio_lock, flags);
+		chip_err(gc, "GPIO integer space overlap, cannot add chip\n");
 		goto err_free_label;
 	}
 
-- 
2.35.1

