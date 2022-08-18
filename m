Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8FF598693
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343859AbiHRO5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343828AbiHRO4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:56:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877E1BD11F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:56:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26227B8218F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 14:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F33C433C1;
        Thu, 18 Aug 2022 14:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660834601;
        bh=mtTReuzBuhhaSHPjJxbyPhffXjHDxEYyfjlRUGyAxjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cgbc8jG5hSZ/+L6U1fhAkVcOG0njXZcSzWxm9FClB55jk9ro16GAyk5mPoZRtc0b+
         iyiiTmdaOF+38CYFuyZ55PdPBkylw+DDbJivQKmDISta/vYDnt0xB6muNUl3Q1/6Kc
         Jqgzn7IBPIzbRAQ7MTJ0DCEfEFoChhlasZGSND9yxqhJ2YgNJSVD0DBiEEjgRDbAwt
         sGUm6a1ooH+MqCYrhNcMrK0wTriGDKAkX2aiX9MaZMs/9fWB+n/3P/zN1jpJCn15lF
         4dPFz+Id5xcJuVBPP+5WiybLKeUN5bAebSGXSkc3w9DSuhypPgRAFYq8tFZofRQ1G4
         STr6PmUCp6ORw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH 2/5] ARM: simplify machdirs/platdirs handling
Date:   Thu, 18 Aug 2022 16:56:13 +0200
Message-Id: <20220818145616.3156379-3-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220818145616.3156379-1-arnd@kernel.org>
References: <20220818145616.3156379-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There is only one plat-* directory left, and the MACHINE variable is
only used for the mach/*.h header path.

Simplify this by removing the checks for ARCH_MULTIPLATFORM and
ARM_SINGLE_ARMV7M, and just adding the include directories for the
remaining three platforms manually.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Makefile | 36 ++++++++++--------------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 369490d5f18a..2623d6e25bdb 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -224,40 +224,24 @@ machine-$(CONFIG_ARCH_ZYNQ)		+= zynq
 machine-$(CONFIG_PLAT_VERSATILE)	+= versatile
 machine-$(CONFIG_PLAT_SPEAR)		+= spear
 
-# Platform directory name.  This list is sorted alphanumerically
-# by CONFIG_* macro name.
-plat-$(CONFIG_PLAT_ORION)	+= orion
+# legacy platforms provide their own mach/*.h headers globally,
+# these three are mutually exclusive
+machdirs-$(CONFIG_ARCH_FOOTBRIDGE)	+= arch/arm/mach-footbridge
+machdirs-$(CONFIG_ARCH_RPC)		+= arch/arm/mach-rpc
+machdirs-$(CONFIG_ARCH_SA1100)		+= arch/arm/mach-sa1100
+KBUILD_CPPFLAGS += $(patsubst %,-I$(srctree)/%/include,$(machdirs-y))
 
 # The byte offset of the kernel image in RAM from the start of RAM.
 TEXT_OFFSET := $(textofs-y)
 
-# The first directory contains additional information for the boot setup code
-ifneq ($(machine-y),)
-MACHINE  := arch/arm/mach-$(word 1,$(machine-y))/
-else
-MACHINE  :=
-endif
-ifeq ($(CONFIG_ARCH_MULTIPLATFORM),y)
-MACHINE  :=
-endif
-
-machdirs := $(patsubst %,arch/arm/mach-%/,$(machine-y))
-platdirs := $(patsubst %,arch/arm/plat-%/,$(sort $(plat-y)))
-
-ifneq ($(CONFIG_ARCH_MULTIPLATFORM),y)
-ifneq ($(CONFIG_ARM_SINGLE_ARMV7M),y)
-KBUILD_CPPFLAGS += $(patsubst %,-I$(srctree)/%include,$(machdirs) $(platdirs))
-endif
-endif
-
 export	TEXT_OFFSET GZFLAGS MMUEXT
 
 # If we have a machine-specific directory, then include it in the build.
-core-y				+= $(machdirs) $(platdirs)
-
+core-y				+= $(patsubst %,arch/arm/mach-%/,$(machine-y))
 # For cleaning
-core-				+= $(patsubst %,arch/arm/mach-%/, $(machine-))
-core-				+= $(patsubst %,arch/arm/plat-%/, $(plat-))
+core-				+= $(patsubst %,arch/arm/mach-%/,$(machine-))
+
+core-$(CONFIG_PLAT_ORION)	+= arch/arm/plat-orion/
 
 libs-y				:= arch/arm/lib/ $(libs-y)
 
-- 
2.29.2

