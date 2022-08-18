Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D615598F6A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 23:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347119AbiHRVY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 17:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241782AbiHRVXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 17:23:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D249411D
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 14:16:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E9AC61648
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 21:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCD2C433D7;
        Thu, 18 Aug 2022 21:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660857368;
        bh=3FTdBeOswHQgR9EnPzD7r7Hj2aF9kPId60Rz+0t0sOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iHVZu4ckcK0W0culRyiYB2Gxi6D7mULjmK0Y47drQ1QMkozUPBHS/NeMj/B86bGaB
         p3ZWAvi0QtyHZGxfB4ZpazW/IY8e7WyZEj0foSDpSnPH3zOZdYP54Z7DwgAaMgK67G
         FR8Q5vuUXu+XxGFixq/HHNSnXnG3siH6Egx/jISZfkpFRQNkVDGYzzyMzKTmjVyRTs
         ziva+mlrNpB0wGmx/KuRE9XX6JyLNrc7b1zJemONWZmTngMINz6/rcp4raGxBXQlp0
         RbnLYJUwFOxhKidQJIRi797fpnuLFG70+gJzopDuIH94rb1cgLrTIYs2mkRqJMqQP2
         eD67xxj8yVPhg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 4/4] ARM: footbridge: limit CONFIG_ISA to CATS
Date:   Thu, 18 Aug 2022 23:15:50 +0200
Message-Id: <20220818211550.3272321-5-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220818211550.3272321-1-arnd@kernel.org>
References: <20220818211550.3272321-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The CONFIG_ISA option is only used for actual add-in cards, not
on-board devices. NetWinder has no hardware support for those,
and ebsa285 appears to not support them in Linux, as the XBUS
is not set up that way and there is no support for a PCI-ISA
bridge.

CATS on the other hand has four ISA slots connected to a PCI-ISA
bridge device.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-footbridge/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-footbridge/Kconfig b/arch/arm/mach-footbridge/Kconfig
index 1a3676109654..cd18871fd03f 100644
--- a/arch/arm/mach-footbridge/Kconfig
+++ b/arch/arm/mach-footbridge/Kconfig
@@ -18,7 +18,6 @@ config ARCH_CATS
 config ARCH_EBSA285_HOST
 	bool "EBSA285 (host mode)"
 	select ARCH_EBSA285
-	select ISA
 	select ARCH_MAY_HAVE_PC_FDC
 	select FORCE_PCI
 	help
@@ -31,7 +30,6 @@ config ARCH_NETWINDER
 	bool "NetWinder"
 	select CLKEVT_I8253
 	select CLKSRC_I8253
-	select ISA
 	select FORCE_PCI
 	help
 	  Say Y here if you intend to run this kernel on the Rebel.COM
-- 
2.29.2

