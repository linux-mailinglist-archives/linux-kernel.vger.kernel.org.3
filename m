Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FF557DC24
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbiGVITe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiGVIT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:19:29 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19DF9E295
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 01:19:26 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 09EDA2FEE80;
        Fri, 22 Jul 2022 10:19:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1658477965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HZNAS0xeih0cr4UAkW0Tqvo67hsDsJQX4e9Q7//3Eh8=;
        b=YPDiNBnZ9plyhDM6iqwDnehR946qXSyDbffR1i3umBy+sMJMHLYHVBK2CtCdiwRo/tZCpC
        OG7Vh7ehiGh9McvgUu9OVA8+qBDJLqIY1xq7+e/5Ce6wMLspldHPpjfqt0lyZiNJK3g9aa
        q9kYoXDBu09Vdsx0f+F/MnF4HH9jFvcTr5zpp3fvcJX3mARZ7PJos/p0wxCrA9usDo/tlf
        C91YnsvkPVuyPnOrbMigVXh8mTYaarMPrRtvRUUUhknznuFWK8qNxTgfJr5u2MlpoH9WNW
        SHWcLARje5fgey1gPdWvI/5nNqchBH9I29GhhIMVIHmGU8eGJWZzBXvsKZlDnQ==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-gpio@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Bert Vermeulen <bert@biot.com>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v1 1/2] gpio: realtek-otto: amend ctrl struct docs
Date:   Fri, 22 Jul 2022 10:19:16 +0200
Message-Id: <778b5c9f05c42c0963a5eca1c1c7e58b588a4bc7.1658477809.git.sander@svanheule.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1658477809.git.sander@svanheule.net>
References: <cover.1658477809.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 512c5be35223 ("gpio: realtek-otto: Support reversed port
layouts") and commit 95fa6dbe58f2 ("gpio: realtek-otto: Support per-cpu
interrupts") updated the realtek_gpio_ctrl struct with new fields, but
the associated kernel-doc comment was not updated accordingly.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 drivers/gpio/gpio-realtek-otto.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpio/gpio-realtek-otto.c b/drivers/gpio/gpio-realtek-otto.c
index 63dcf42f7c20..a352fbfc3c28 100644
--- a/drivers/gpio/gpio-realtek-otto.c
+++ b/drivers/gpio/gpio-realtek-otto.c
@@ -43,9 +43,19 @@
  *
  * @gc: Associated gpio_chip instance
  * @base: Base address of the register block for a GPIO bank
+ * @cpumask_base: Base address of the interrupt routing registers
+ * @cpu_irq_maskable: Mask of CPUs that can be individually masked for IRQs
  * @lock: Lock for accessing the IRQ registers and values
  * @intr_mask: Mask for interrupts lines
  * @intr_type: Interrupt type selection
+ * @port_offset_u8: Get offset of an 8b port value
+ * @port_offset_u16: Get offset of a 16b port value
+ *
+ * The DIR, DATA, and ISR registers consist of four u8 port values, packed into
+ * a single 32b register. Use @port_offset_u8 to get the correct offset inside
+ * that register. The IMR register consists of four u16 port values, packed
+ * into two 32b registers. Use @port_offset_u16 to get the correct offset for
+ * the u16 value, starting from the first register.
  *
  * Because the interrupt mask register (IMR) combines the function of IRQ type
  * selection and masking, two extra values are stored. @intr_mask is used to
-- 
2.36.1

