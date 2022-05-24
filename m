Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23D5532C22
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 16:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238151AbiEXOW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 10:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236990AbiEXOWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 10:22:55 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A8862237
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 07:22:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 684124228E;
        Tue, 24 May 2022 14:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1653402171; bh=YeoPwINgF/K0Y1Y2RiM2xpjnuyhOyxS+KRYgH/Qk2Ng=;
        h=From:To:Cc:Subject:Date;
        b=Ybg3YcRtKyfMcYJvL+qv5KD8h6BYyPG31xTox/HctaoDPATqjeU8Vvry6cyahTcrx
         FRMRfT+Y4YTZUduP5CtYem1pra+k63BOPP/lqDvpMd8/7bfm6+8vHMissaKcqV6lKx
         wi5VckpbOsTAT3wOKtL0hhTK5yvgiBevPhMoPw3JrdAoQ0mOoVHeWdZ41QeGkZuYmN
         4xHQ6R1+DIcu5meo0SYkgtclWrGTLtUu8rjwCnzqwhhENiOzC2k1Rf4CZZYeGZacpt
         I4biLY0BXxFXYbEWWHZSQYfb9DQoLcqWreWq3qjK5J/tflLv43Qw9idrKTgQ0P0okI
         UA2SuuuI3RVvA==
From:   Hector Martin <marcan@marcan.st>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH] pinctrl: apple: Use a raw spinlock for the regmap
Date:   Tue, 24 May 2022 23:22:06 +0900
Message-Id: <20220524142206.18833-1-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The irqchip ops are called with a raw spinlock held, so the subsequent
regmap usage cannot use a plain spinlock.

spi-hid-apple-of spi0.0: spihid_apple_of_probe:74

=============================
[ BUG: Invalid wait context ]
5.18.0-asahi-00176-g0fa3ab03bdea #1337 Not tainted
-----------------------------
kworker/u20:3/86 is trying to lock:
ffff8000166b5018 (pinctrl_apple_gpio:462:(&regmap_config)->lock){....}-{3:3}, at: regmap_lock_spinlock+0x18/0x30
other info that might help us debug this:
context-{5:5}
7 locks held by kworker/u20:3/86:
 #0: ffff800017725d48 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1c8/0x670
 #1: ffff80001e33bdd0 (deferred_probe_work){+.+.}-{0:0}, at: process_one_work+0x1c8/0x670
 #2: ffff800017d629a0 (&dev->mutex){....}-{4:4}, at: __device_attach+0x30/0x17c
 #3: ffff80002414e618 (&ctlr->add_lock){+.+.}-{4:4}, at: spi_add_device+0x40/0x80
 #4: ffff800024116990 (&dev->mutex){....}-{4:4}, at: __device_attach+0x30/0x17c
 #5: ffff800022d4be58 (request_class){+.+.}-{4:4}, at: __setup_irq+0xa8/0x720
 #6: ffff800022d4bcc8 (lock_class){....}-{2:2}, at: __setup_irq+0xcc/0x720

Fixes: a0f160ffcb83 ("pinctrl: add pinctrl/GPIO driver for Apple SoCs")
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/pinctrl/pinctrl-apple-gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/pinctrl-apple-gpio.c b/drivers/pinctrl/pinctrl-apple-gpio.c
index 3a33731b8cdb..b02dad2b2f69 100644
--- a/drivers/pinctrl/pinctrl-apple-gpio.c
+++ b/drivers/pinctrl/pinctrl-apple-gpio.c
@@ -72,6 +72,7 @@ struct regmap_config regmap_config = {
 	.max_register = 512 * sizeof(u32),
 	.num_reg_defaults_raw = 512,
 	.use_relaxed_mmio = true,
+	.use_raw_spinlock = true,
 };
 
 /* No locking needed to mask/unmask IRQs as the interrupt mode is per pin-register. */
-- 
2.35.1

