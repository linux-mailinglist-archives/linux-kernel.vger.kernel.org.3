Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8F24D3128
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 15:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbiCIOm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 09:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbiCIOmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:42:55 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DF517DBB7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 06:41:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C5994CE1F08
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B581C340E8;
        Wed,  9 Mar 2022 14:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646836913;
        bh=GFoS6bPRq7lzudSutkAFe2brQro/Mh9slsno9R8y1vM=;
        h=From:To:Cc:Subject:Date:From;
        b=S1k0sVmKPBTacVmbx8BTwfhZZcpPblrE6SH1a/uxzCxYq14PNXGrpZQEyM2z+ymhi
         +nbO79UQkBDUch83CsQfxb2ami/ek/9xKZnn/TnXFSYZB5wVtum/cij0qGU7FKQpjl
         SrkMDT3vi6Tj916Ae2C0l6h/qk9isYlEu/u34CjyY41QCvTOIOAfdlwtkwzevpnjWC
         ILfnx0IhHs4mNWFrOGiaATGwlNaggIHKFh+nLIkAWdePKFb0aqOksidIivwgzD5Bfl
         VWRqpI59/MvApv85jdudgz5r2lXpoNhSMvRP+NEUX7fca6UW229qHJSEjaq/9mcvlO
         E8DfKyRzRz/9Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: fix building NOMMU ARMv4/v5 kernels
Date:   Wed,  9 Mar 2022 15:40:47 +0100
Message-Id: <20220309144138.360482-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The removal of the old-style irq entry broke obscure NOMMU
configurations on machines that have an MMU:

ld.lld: error: undefined symbol: generic_handle_arch_irq
 referenced by kernel/entry-armv.o:(__irq_svc) in archive arch/arm/built-in.a

A follow-up patch to convert nvic to the generic_handle_arch_irq()
could have fixed this by removing the Kconfig conditional, but did
it differently.

Change the Kconfig logic so ARM machines now unconditionally
enable the feature.

I have also submitted a patch to remove support for the configurations
that broke, but fixing the regression first is a trivial and correct
change.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 54f481a2308e ("ARM: remove old-style irq entry")
Fixes: 52d240871760 ("irqchip: nvic: Use GENERIC_IRQ_MULTI_HANDLER")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This patch should go into the arm/devel-stable branch that has
the arm-irq-and-vmap-stacks-for-rmk patches from Ard
---
 arch/arm/Kconfig        | 2 +-
 drivers/irqchip/Kconfig | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e9975ddd5034..5f0b40bab4fb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -60,7 +60,7 @@ config ARM
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_IDLE_POLL_SETUP
-	select GENERIC_IRQ_MULTI_HANDLER if MMU
+	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 488eaa14d3a7..7038957f4a77 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -58,7 +58,6 @@ config ARM_NVIC
 	bool
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_IRQ_CHIP
-	select GENERIC_IRQ_MULTI_HANDLER
 
 config ARM_VIC
 	bool
-- 
2.29.2

