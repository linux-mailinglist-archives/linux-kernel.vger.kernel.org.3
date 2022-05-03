Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200F251880E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238044AbiECPQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238024AbiECPQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:16:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9CF3AA5F;
        Tue,  3 May 2022 08:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651590799; x=1683126799;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MpF02Moa29ovwMRzU1hSc6F61wABuzxKFQ0rKgnNZVo=;
  b=lmfNwNGHceU6Jl1uFSQgRzSUBDUb8k7CrW+604mzi0oLBzyD3AUdduX8
   HsKcPvCPUKW8jqAqqP5om3RBXS7tLwyL8Zb/vqJDDjW5mamed1Wf1v6Z8
   CnOGGqnVP9sxX6JgkpDE86VH/ZK1btSUxI98sD/liSr8HePzk5YlXMivP
   qwsbBHtUuD+IOIP1AUwCRT67mNeyOoXaTGc2rAbMwUUUZgQUoVcqyvQeN
   4oB6JxcK8QbKuJLQU5B4mWc9+iW+v13BzLFG20BzE6EMCzjUU9sHr7h+n
   szoVlf71P2PU9kMq6SJg5lmz21pGAYRcwOIlLHTwtCOTWszoKYl8N/HTC
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="330487929"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="330487929"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 08:13:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="653296374"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 03 May 2022 08:13:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7352D179; Tue,  3 May 2022 18:13:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] pinctrl: nomadik: Setup parent device and get rid of unnecessary of_node assignment
Date:   Tue,  3 May 2022 18:13:10 +0300
Message-Id: <20220503151310.58762-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the drivers do not set parent device. This may lead to obstacles
during debugging or understanding the device relations from the Linux
point of view. Assign parent device for GPIO chips created by these
drivers.

While at it, let GPIO library to assign of_node from the parent device.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index 4757bf964d3c..640e50d94f27 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1113,6 +1113,7 @@ static int nmk_gpio_probe(struct platform_device *dev)
 	spin_lock_init(&nmk_chip->lock);
 
 	chip = &nmk_chip->chip;
+	chip->parent = &dev->dev;
 	chip->request = gpiochip_generic_request;
 	chip->free = gpiochip_generic_free;
 	chip->get_direction = nmk_gpio_get_dir;
@@ -1154,7 +1155,6 @@ static int nmk_gpio_probe(struct platform_device *dev)
 	clk_enable(nmk_chip->clk);
 	nmk_chip->lowemi = readl_relaxed(nmk_chip->addr + NMK_GPIO_LOWEMI);
 	clk_disable(nmk_chip->clk);
-	chip->of_node = np;
 
 	ret = gpiochip_add_data(chip, nmk_chip);
 	if (ret)
-- 
2.35.1

