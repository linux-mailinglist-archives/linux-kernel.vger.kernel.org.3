Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F8A569E01
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbiGGIu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235387AbiGGIuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:50:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B2932ECD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:50:08 -0700 (PDT)
Date:   Thu, 07 Jul 2022 08:50:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657183807;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GSd72UO/hQ5qghescJMr5K/+JQ2x8UC87b/mURDW8+E=;
        b=LkArKRsuLYoYIq9u4gj7Qh/MX1KxeZ6tAZdnL5NN4T0bzGiwv6EimiYdIsTmKI4GQDj2nN
        GiMHajAiB8dhB8TDb3tUgJhAuwilmv9v3hTkuzQ3ZfO1bgUGT3Pto6zGLiGWlNabvUGs4e
        IeSy6EF+Vb0H+s0My3ru4HSjU0PGxNxzZdhcggUsfP7r+qTInO1pjkBLeBcecVN11zOmOP
        RgOVcWLuoIX+cYYI0ybERY7pT33MFS/9UvgvSKHzKaZH/8Bld6/BrxpQFBlDdYV+niJy1m
        xbkwmeKrwDC/fYPqA4uCroyUCErhzCrp+T4VzWwHIGb5GEwI/3zYASHKqWiO3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657183807;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GSd72UO/hQ5qghescJMr5K/+JQ2x8UC87b/mURDW8+E=;
        b=dNBaa0OQCIsNJomdwZ6b4XOG8G1uixh8g5BGitMtFzMxPOOtWAJ/6DHJ7k873hD6EWbTmF
        Uaq+sKcTLC1UApBQ==
From:   "irqchip-bot for Samuel Holland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq: GENERIC_IRQ_IPI depends on SMP
Cc:     kernel test robot <lkp@intel.com>,
        Samuel Holland <samuel@sholland.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220701200056.46555-3-samuel@sholland.org>
References: <20220701200056.46555-3-samuel@sholland.org>
MIME-Version: 1.0
Message-ID: <165718380587.15455.10892784709085960785.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     0f5209fee90b4544c58b4278d944425292789967
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/0f5209fee90b4544c58b4278d944425292789967
Author:        Samuel Holland <samuel@sholland.org>
AuthorDate:    Fri, 01 Jul 2022 15:00:50 -05:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 07 Jul 2022 09:38:03 +01:00

genirq: GENERIC_IRQ_IPI depends on SMP

The generic IPI code depends on the IRQ affinity mask being allocated
and initialized. This will not be the case if SMP is disabled. Fix up
the remaining driver that selected GENERIC_IRQ_IPI in a non-SMP config.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220701200056.46555-3-samuel@sholland.org
---
 drivers/irqchip/Kconfig | 2 +-
 kernel/irq/Kconfig      | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index d26a4ff..5dd98a8 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -177,7 +177,7 @@ config MADERA_IRQ
 config IRQ_MIPS_CPU
 	bool
 	select GENERIC_IRQ_CHIP
-	select GENERIC_IRQ_IPI if SYS_SUPPORTS_MULTITHREADING
+	select GENERIC_IRQ_IPI if SMP && SYS_SUPPORTS_MULTITHREADING
 	select IRQ_DOMAIN
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
 
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 10929ed..fc760d0 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -82,6 +82,7 @@ config IRQ_FASTEOI_HIERARCHY_HANDLERS
 # Generic IRQ IPI support
 config GENERIC_IRQ_IPI
 	bool
+	depends on SMP
 	select IRQ_DOMAIN_HIERARCHY
 
 # Generic MSI interrupt support
