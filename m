Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8F857CD17
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiGUOO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiGUOOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:14:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA07454CB6;
        Thu, 21 Jul 2022 07:14:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AB3161F83;
        Thu, 21 Jul 2022 14:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D617AC341CE;
        Thu, 21 Jul 2022 14:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658412852;
        bh=HO637mSvJ0fa013XUlQ3skvx1VWmjJL5qgqbdXTIG+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=plxVr1IWQy20sQ9IGrSIB7IHa075ihtpf3utetdfgTHTXNMlaMohbGXwuu6fboaiU
         EuknAGEpCdaqFqZZFi67OyxGanl4pXKSHOLvSRE/j3Ux/EraFC/juWNJRzrwx72r/i
         QSQFyX0vb/3aMrqDprnFTut6FyGN7VA9OGDy51dn9GR0veSibjtF1Aq+zV4bxr1NbP
         beLcBKMb8ywEnNjpdpepK0ByA04UYhBpHCOUB+En1JWTpn8babhAZ8afqtv+I/ETJm
         FVP0bNQ3NTo+xA4jVJ1NRangN1PL4P6P8VIGt4HUYqtsNyqUL2fb23KZ+Zbv5RmRQm
         UtY7yAcw/z3pw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Takao Orito <orito.takao@socionext.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-oxnas@groups.io, linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-sh@vger.kernel.org
Subject: [PATCH 3/6] ARM: defconfig: remove stale CONFIG_ZBOOT_ROM entries
Date:   Thu, 21 Jul 2022 16:13:22 +0200
Message-Id: <20220721141325.2413920-4-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220721141325.2413920-1-arnd@kernel.org>
References: <20220721141325.2413920-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The default is always 0x0 after commit 39c3e304567a ("ARM: 8984/1:
Kconfig: set default ZBOOT_ROM_TEXT/BSS value to 0x0"), so any
defconfig file that has these two lines can now drop them to reduce
the diff against the 'make savedefconfig' version.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/am200epdkit_defconfig | 2 --
 arch/arm/configs/assabet_defconfig     | 2 --
 arch/arm/configs/axm55xx_defconfig     | 2 --
 arch/arm/configs/badge4_defconfig      | 2 --
 arch/arm/configs/cerfcube_defconfig    | 2 --
 arch/arm/configs/clps711x_defconfig    | 2 --
 arch/arm/configs/cm_x300_defconfig     | 2 --
 arch/arm/configs/cns3420vb_defconfig   | 2 --
 arch/arm/configs/collie_defconfig      | 2 --
 arch/arm/configs/corgi_defconfig       | 2 --
 arch/arm/configs/davinci_all_defconfig | 2 --
 arch/arm/configs/dove_defconfig        | 2 --
 arch/arm/configs/ep93xx_defconfig      | 2 --
 arch/arm/configs/eseries_pxa_defconfig | 2 --
 arch/arm/configs/exynos_defconfig      | 2 --
 arch/arm/configs/ezx_defconfig         | 2 --
 arch/arm/configs/footbridge_defconfig  | 2 --
 arch/arm/configs/h3600_defconfig       | 2 --
 arch/arm/configs/h5000_defconfig       | 2 --
 arch/arm/configs/hackkit_defconfig     | 2 --
 arch/arm/configs/imx_v4_v5_defconfig   | 2 --
 arch/arm/configs/iop32x_defconfig      | 2 --
 arch/arm/configs/jornada720_defconfig  | 2 --
 arch/arm/configs/lart_defconfig        | 2 --
 arch/arm/configs/lpc18xx_defconfig     | 2 --
 arch/arm/configs/lpc32xx_defconfig     | 2 --
 arch/arm/configs/lpd270_defconfig      | 2 --
 arch/arm/configs/lubbock_defconfig     | 2 --
 arch/arm/configs/magician_defconfig    | 2 --
 arch/arm/configs/mainstone_defconfig   | 2 --
 arch/arm/configs/mmp2_defconfig        | 2 --
 arch/arm/configs/mps2_defconfig        | 2 --
 arch/arm/configs/multi_v4t_defconfig   | 2 --
 arch/arm/configs/mv78xx0_defconfig     | 2 --
 arch/arm/configs/mvebu_v5_defconfig    | 2 --
 arch/arm/configs/netwinder_defconfig   | 2 --
 arch/arm/configs/omap1_defconfig       | 2 --
 arch/arm/configs/orion5x_defconfig     | 2 --
 arch/arm/configs/palmz72_defconfig     | 2 --
 arch/arm/configs/pcm027_defconfig      | 2 --
 arch/arm/configs/pleb_defconfig        | 2 --
 arch/arm/configs/pxa168_defconfig      | 2 --
 arch/arm/configs/pxa255-idp_defconfig  | 2 --
 arch/arm/configs/pxa3xx_defconfig      | 2 --
 arch/arm/configs/pxa910_defconfig      | 2 --
 arch/arm/configs/pxa_defconfig         | 2 --
 arch/arm/configs/rpc_defconfig         | 2 --
 arch/arm/configs/s3c2410_defconfig     | 2 --
 arch/arm/configs/shannon_defconfig     | 2 --
 arch/arm/configs/simpad_defconfig      | 2 --
 arch/arm/configs/socfpga_defconfig     | 2 --
 arch/arm/configs/spitz_defconfig       | 2 --
 arch/arm/configs/stm32_defconfig       | 2 --
 arch/arm/configs/tct_hammer_defconfig  | 2 --
 arch/arm/configs/vexpress_defconfig    | 2 --
 arch/arm/configs/viper_defconfig       | 2 --
 arch/arm/configs/xcep_defconfig        | 2 --
 arch/arm/configs/zeus_defconfig        | 2 --
 58 files changed, 116 deletions(-)

diff --git a/arch/arm/configs/am200epdkit_defconfig b/arch/arm/configs/am200epdkit_defconfig
index bd57a66d8f2b..3f633eaf9770 100644
--- a/arch/arm/configs/am200epdkit_defconfig
+++ b/arch/arm/configs/am200epdkit_defconfig
@@ -10,8 +10,6 @@ CONFIG_ARCH_PXA=y
 CONFIG_ARCH_GUMSTIX=y
 CONFIG_AEABI=y
 # CONFIG_OABI_COMPAT is not set
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="console=ttyS0,115200n8 root=1f01 rootfstype=jffs2"
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/arm/configs/assabet_defconfig b/arch/arm/configs/assabet_defconfig
index ae7354550a63..da5284a8f374 100644
--- a/arch/arm/configs/assabet_defconfig
+++ b/arch/arm/configs/assabet_defconfig
@@ -5,8 +5,6 @@ CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_ASSABET=y
 CONFIG_LEDS=y
 CONFIG_LEDS_CPU=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="mem=32M console=ttySA0,38400n8 initrd=0xc0800000,3M root=/dev/ram"
 CONFIG_FPE_NWFPE=y
 CONFIG_PM=y
diff --git a/arch/arm/configs/axm55xx_defconfig b/arch/arm/configs/axm55xx_defconfig
index c6850a6b9a8b..263490e59250 100644
--- a/arch/arm/configs/axm55xx_defconfig
+++ b/arch/arm/configs/axm55xx_defconfig
@@ -41,8 +41,6 @@ CONFIG_HOTPLUG_CPU=y
 CONFIG_AEABI=y
 CONFIG_OABI_COMPAT=y
 CONFIG_HIGHMEM=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_VFP=y
diff --git a/arch/arm/configs/badge4_defconfig b/arch/arm/configs/badge4_defconfig
index 3a46dce304c4..4e3490798d6d 100644
--- a/arch/arm/configs/badge4_defconfig
+++ b/arch/arm/configs/badge4_defconfig
@@ -2,8 +2,6 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_EXPERT=y
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_BADGE4=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="init=/linuxrc root=/dev/mtdblock3"
 CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
 CONFIG_FPE_NWFPE=y
diff --git a/arch/arm/configs/cerfcube_defconfig b/arch/arm/configs/cerfcube_defconfig
index 8c9b6ddf026a..c42e39b011df 100644
--- a/arch/arm/configs/cerfcube_defconfig
+++ b/arch/arm/configs/cerfcube_defconfig
@@ -6,8 +6,6 @@ CONFIG_SA1100_CERF=y
 CONFIG_SA1100_CERF_FLASH_16MB=y
 CONFIG_LEDS=y
 CONFIG_LEDS_CPU=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="console=ttySA0,38400 root=/dev/mtdblock3 rootfstype=jffs2 rw mem=32M init=/linuxrc"
 CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
 CONFIG_CPU_FREQ_GOV_USERSPACE=m
diff --git a/arch/arm/configs/clps711x_defconfig b/arch/arm/configs/clps711x_defconfig
index 8d86599e4de3..92481b2a88fa 100644
--- a/arch/arm/configs/clps711x_defconfig
+++ b/arch/arm/configs/clps711x_defconfig
@@ -13,8 +13,6 @@ CONFIG_ARCH_CLEP7312=y
 CONFIG_ARCH_EDB7211=y
 CONFIG_ARCH_P720T=y
 CONFIG_AEABI=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 # CONFIG_COREDUMP is not set
 CONFIG_SLOB=y
 CONFIG_NET=y
diff --git a/arch/arm/configs/cm_x300_defconfig b/arch/arm/configs/cm_x300_defconfig
index 232c891a7471..9264f488c49f 100644
--- a/arch/arm/configs/cm_x300_defconfig
+++ b/arch/arm/configs/cm_x300_defconfig
@@ -12,8 +12,6 @@ CONFIG_ARCH_PXA=y
 CONFIG_MACH_CM_X300=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=/dev/mtdblock5 rootfstype=ubifs console=ttyS2,38400"
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_GOV_USERSPACE=y
diff --git a/arch/arm/configs/cns3420vb_defconfig b/arch/arm/configs/cns3420vb_defconfig
index 416728cffadb..53f601bbe647 100644
--- a/arch/arm/configs/cns3420vb_defconfig
+++ b/arch/arm/configs/cns3420vb_defconfig
@@ -21,8 +21,6 @@ CONFIG_IOSCHED_BFQ=m
 #CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_DEBUG_CNS3XXX=y
 CONFIG_AEABI=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 # CONFIG_SWAP is not set
 CONFIG_SLAB=y
 CONFIG_MTD=y
diff --git a/arch/arm/configs/collie_defconfig b/arch/arm/configs/collie_defconfig
index ff40d3214729..d35cc59ce847 100644
--- a/arch/arm/configs/collie_defconfig
+++ b/arch/arm/configs/collie_defconfig
@@ -7,8 +7,6 @@ CONFIG_EXPERT=y
 # CONFIG_EPOLL is not set
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_COLLIE=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="noinitrd root=/dev/mtdblock2 rootfstype=jffs2 fbcon=rotate:1"
 CONFIG_FPE_NWFPE=y
 CONFIG_PM=y
diff --git a/arch/arm/configs/corgi_defconfig b/arch/arm/configs/corgi_defconfig
index 126ddc2a0d09..bd9b5a013040 100644
--- a/arch/arm/configs/corgi_defconfig
+++ b/arch/arm/configs/corgi_defconfig
@@ -13,8 +13,6 @@ CONFIG_MACH_POODLE=y
 CONFIG_MACH_CORGI=y
 CONFIG_MACH_SHEPHERD=y
 CONFIG_MACH_HUSKY=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="console=ttyS0,115200n8 console=tty1 noinitrd root=/dev/mtdblock2 rootfstype=jffs2   debug"
 CONFIG_FPE_NWFPE=y
 CONFIG_BINFMT_AOUT=m
diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 673dd230a229..c60c39a8b95f 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -29,8 +29,6 @@ CONFIG_DAVINCI_MUX_DEBUG=y
 CONFIG_DAVINCI_MUX_WARNINGS=y
 CONFIG_AEABI=y
 CONFIG_SECCOMP=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_AUTO_ZRELADDR=y
diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defconfig
index 33d13c425d80..683ad6466919 100644
--- a/arch/arm/configs/dove_defconfig
+++ b/arch/arm/configs/dove_defconfig
@@ -11,8 +11,6 @@ CONFIG_MACH_CM_A510=y
 CONFIG_MACH_DOVE_DT=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_VFP=y
diff --git a/arch/arm/configs/ep93xx_defconfig b/arch/arm/configs/ep93xx_defconfig
index 290d93a06f67..dd390f3b19d2 100644
--- a/arch/arm/configs/ep93xx_defconfig
+++ b/arch/arm/configs/ep93xx_defconfig
@@ -27,8 +27,6 @@ CONFIG_MACH_SNAPPER_CL15=y
 CONFIG_MACH_TS72XX=y
 CONFIG_MACH_VISION_EP9307=y
 CONFIG_AEABI=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="console=ttyAM0,115200 root=/dev/nfs ip=bootp"
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/arm/configs/eseries_pxa_defconfig b/arch/arm/configs/eseries_pxa_defconfig
index a8db4f45a68d..b8994bff3f62 100644
--- a/arch/arm/configs/eseries_pxa_defconfig
+++ b/arch/arm/configs/eseries_pxa_defconfig
@@ -9,8 +9,6 @@ CONFIG_ARCH_PXA_ESERIES=y
 # CONFIG_ARM_THUMB is not set
 CONFIG_IWMMXT=y
 CONFIG_AEABI=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_KEXEC=y
 CONFIG_FPE_NWFPE=y
 CONFIG_MODULES=y
diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 94d4eb2cb8a4..a85c220487f9 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -13,8 +13,6 @@ CONFIG_BIG_LITTLE=y
 CONFIG_NR_CPUS=8
 CONFIG_HIGHMEM=y
 CONFIG_SECCOMP=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC1,115200 init=/linuxrc mem=256M"
diff --git a/arch/arm/configs/ezx_defconfig b/arch/arm/configs/ezx_defconfig
index d3240089bbfb..3a5eab10110f 100644
--- a/arch/arm/configs/ezx_defconfig
+++ b/arch/arm/configs/ezx_defconfig
@@ -15,8 +15,6 @@ CONFIG_EXPERT=y
 CONFIG_ARCH_PXA=y
 CONFIG_PXA_EZX=y
 CONFIG_AEABI=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="console=tty1 root=/dev/mmcblk0p2 rootfstype=ext2 rootdelay=3 ip=192.168.0.202:192.168.0.200:192.168.0.200:255.255.255.0 debug"
 CONFIG_KEXEC=y
 CONFIG_CPU_FREQ=y
diff --git a/arch/arm/configs/footbridge_defconfig b/arch/arm/configs/footbridge_defconfig
index 2c4e15261d42..af7d3120cc9c 100644
--- a/arch/arm/configs/footbridge_defconfig
+++ b/arch/arm/configs/footbridge_defconfig
@@ -10,8 +10,6 @@ CONFIG_ARCH_EBSA285_HOST=y
 CONFIG_ARCH_NETWINDER=y
 CONFIG_LEDS=y
 CONFIG_LEDS_TIMER=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_FPE_NWFPE=y
 CONFIG_FPE_NWFPE_XP=y
 CONFIG_BINFMT_AOUT=y
diff --git a/arch/arm/configs/h3600_defconfig b/arch/arm/configs/h3600_defconfig
index 1bf143e69de3..5bd1ec539610 100644
--- a/arch/arm/configs/h3600_defconfig
+++ b/arch/arm/configs/h3600_defconfig
@@ -6,8 +6,6 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_H3600=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 # CONFIG_CPU_FREQ_STAT is not set
 CONFIG_FPE_NWFPE=y
 CONFIG_MODULES=y
diff --git a/arch/arm/configs/h5000_defconfig b/arch/arm/configs/h5000_defconfig
index 3b170cfbf537..e1af11d3e632 100644
--- a/arch/arm/configs/h5000_defconfig
+++ b/arch/arm/configs/h5000_defconfig
@@ -10,8 +10,6 @@ CONFIG_EXPERT=y
 CONFIG_ARCH_PXA=y
 CONFIG_MACH_H5000=y
 CONFIG_AEABI=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="keepinitrd"
 CONFIG_KEXEC=y
 CONFIG_FPE_NWFPE=y
diff --git a/arch/arm/configs/hackkit_defconfig b/arch/arm/configs/hackkit_defconfig
index 826497b28b6e..e0ea332a4cf4 100644
--- a/arch/arm/configs/hackkit_defconfig
+++ b/arch/arm/configs/hackkit_defconfig
@@ -5,8 +5,6 @@ CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_HACKKIT=y
 CONFIG_LEDS=y
 CONFIG_LEDS_CPU=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="console=ttySA0,115200 root=/dev/ram0 initrd=0xc0400000,8M init=/rootshell"
 CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
 CONFIG_FPE_NWFPE=y
diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index c32bdbc07d0c..bfa2a95638af 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -21,8 +21,6 @@ CONFIG_SOC_IMX1=y
 CONFIG_SOC_IMX25=y
 CONFIG_SOC_IMX27=y
 CONFIG_AEABI=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_PM_DEBUG=y
 CONFIG_KPROBES=y
 CONFIG_MODULES=y
diff --git a/arch/arm/configs/iop32x_defconfig b/arch/arm/configs/iop32x_defconfig
index 6d91b3cbd881..e4c563182dea 100644
--- a/arch/arm/configs/iop32x_defconfig
+++ b/arch/arm/configs/iop32x_defconfig
@@ -10,8 +10,6 @@ CONFIG_ARCH_IQ80321=y
 CONFIG_ARCH_IQ31244=y
 CONFIG_MACH_N2100=y
 # CONFIG_ARM_THUMB is not set
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="console=ttyS0,115200 root=/dev/nfs ip=bootp cachepolicy=writealloc"
 CONFIG_FPE_NWFPE=y
 CONFIG_BINFMT_AOUT=y
diff --git a/arch/arm/configs/jornada720_defconfig b/arch/arm/configs/jornada720_defconfig
index 6c99a48e2812..d9e2551ac31d 100644
--- a/arch/arm/configs/jornada720_defconfig
+++ b/arch/arm/configs/jornada720_defconfig
@@ -4,8 +4,6 @@ CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_JORNADA720=y
 CONFIG_SA1100_JORNADA720_SSP=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_FPE_NWFPE=y
 CONFIG_BINFMT_AOUT=y
 CONFIG_PM=y
diff --git a/arch/arm/configs/lart_defconfig b/arch/arm/configs/lart_defconfig
index a414fe01ef52..76ea89716184 100644
--- a/arch/arm/configs/lart_defconfig
+++ b/arch/arm/configs/lart_defconfig
@@ -5,8 +5,6 @@ CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_LART=y
 CONFIG_LEDS=y
 CONFIG_LEDS_CPU=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="console=ttySA0,9600 root=/dev/ram"
 CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
 CONFIG_CPU_FREQ_GOV_USERSPACE=y
diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
index bb7f54c51871..0f44c7428396 100644
--- a/arch/arm/configs/lpc18xx_defconfig
+++ b/arch/arm/configs/lpc18xx_defconfig
@@ -22,8 +22,6 @@ CONFIG_DRAM_BASE=0x28000000
 CONFIG_DRAM_SIZE=0x02000000
 CONFIG_FLASH_MEM_BASE=0x1b000000
 CONFIG_FLASH_SIZE=0x00080000
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_BINFMT_FLAT=y
 CONFIG_BINFMT_ZFLAT=y
diff --git a/arch/arm/configs/lpc32xx_defconfig b/arch/arm/configs/lpc32xx_defconfig
index afa0aceedc2b..ca510e18b7d8 100644
--- a/arch/arm/configs/lpc32xx_defconfig
+++ b/arch/arm/configs/lpc32xx_defconfig
@@ -13,8 +13,6 @@ CONFIG_EMBEDDED=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_LPC32XX=y
 CONFIG_AEABI=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CMDLINE="console=ttyS0,115200n81 root=/dev/ram0"
diff --git a/arch/arm/configs/lpd270_defconfig b/arch/arm/configs/lpd270_defconfig
index ce142e52a195..f47c8c4ae2a5 100644
--- a/arch/arm/configs/lpd270_defconfig
+++ b/arch/arm/configs/lpd270_defconfig
@@ -4,8 +4,6 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_ARCH_PXA=y
 CONFIG_MACH_LOGICPD_PXA270=y
 # CONFIG_ARM_THUMB is not set
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=/dev/nfs ip=bootp console=ttyS0,115200 mem=64M"
 CONFIG_FPE_NWFPE=y
 CONFIG_MODULES=y
diff --git a/arch/arm/configs/lubbock_defconfig b/arch/arm/configs/lubbock_defconfig
index 8875befb7927..efddb63f9387 100644
--- a/arch/arm/configs/lubbock_defconfig
+++ b/arch/arm/configs/lubbock_defconfig
@@ -6,8 +6,6 @@ CONFIG_ARCH_LUBBOCK=y
 # CONFIG_ARM_THUMB is not set
 CONFIG_LEDS=y
 CONFIG_LEDS_CPU=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=/dev/nfs ip=bootp console=ttyS0,115200 mem=64M"
 CONFIG_FPE_NWFPE=y
 CONFIG_MODULES=y
diff --git a/arch/arm/configs/magician_defconfig b/arch/arm/configs/magician_defconfig
index 75a15efa6e06..b65cce921ecc 100644
--- a/arch/arm/configs/magician_defconfig
+++ b/arch/arm/configs/magician_defconfig
@@ -13,8 +13,6 @@ CONFIG_ARCH_PXA=y
 CONFIG_MACH_H4700=y
 CONFIG_MACH_MAGICIAN=y
 CONFIG_AEABI=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="keepinitrd"
 CONFIG_KEXEC=y
 CONFIG_CPU_FREQ=y
diff --git a/arch/arm/configs/mainstone_defconfig b/arch/arm/configs/mainstone_defconfig
index 52de8b15c349..d29a07628b09 100644
--- a/arch/arm/configs/mainstone_defconfig
+++ b/arch/arm/configs/mainstone_defconfig
@@ -6,8 +6,6 @@ CONFIG_MACH_MAINSTONE=y
 # CONFIG_ARM_THUMB is not set
 CONFIG_LEDS=y
 CONFIG_LEDS_CPU=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=/dev/nfs ip=bootp console=ttyS0,115200 mem=64M"
 CONFIG_FPE_NWFPE=y
 CONFIG_MODULES=y
diff --git a/arch/arm/configs/mmp2_defconfig b/arch/arm/configs/mmp2_defconfig
index bfa28daf458d..8c6ed151dfe6 100644
--- a/arch/arm/configs/mmp2_defconfig
+++ b/arch/arm/configs/mmp2_defconfig
@@ -9,8 +9,6 @@ CONFIG_MACH_BROWNSTONE=y
 CONFIG_MACH_FLINT=y
 CONFIG_MACH_MARVELL_JASPER=y
 CONFIG_AEABI=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=/dev/nfs rootfstype=nfs nfsroot=192.168.1.100:/nfsroot/ ip=192.168.1.101:192.168.1.100::255.255.255.0::eth0:on console=ttyS2,38400 mem=128M user_debug=255 earlyprintk"
 CONFIG_VFP=y
 CONFIG_MODULES=y
diff --git a/arch/arm/configs/mps2_defconfig b/arch/arm/configs/mps2_defconfig
index 81d3edb35d3e..0d3049208964 100644
--- a/arch/arm/configs/mps2_defconfig
+++ b/arch/arm/configs/mps2_defconfig
@@ -17,8 +17,6 @@ CONFIG_SET_MEM_PARAM=y
 CONFIG_DRAM_BASE=0x21000000
 CONFIG_DRAM_SIZE=0x1000000
 # CONFIG_ATAGS is not set
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 # CONFIG_SUSPEND is not set
 # CONFIG_BLOCK is not set
 CONFIG_BINFMT_FLAT=y
diff --git a/arch/arm/configs/multi_v4t_defconfig b/arch/arm/configs/multi_v4t_defconfig
index 9f5b3f5dc8b6..6c3e45b71ab5 100644
--- a/arch/arm/configs/multi_v4t_defconfig
+++ b/arch/arm/configs/multi_v4t_defconfig
@@ -19,8 +19,6 @@ CONFIG_INTEGRATOR_CM920T=y
 CONFIG_INTEGRATOR_CM922T_XA10=y
 CONFIG_AEABI=y
 # CONFIG_ATAGS is not set
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CPU_IDLE=y
 CONFIG_ARM_CPUIDLE=y
 CONFIG_ARM_CLPS711X_CPUIDLE=y
diff --git a/arch/arm/configs/mv78xx0_defconfig b/arch/arm/configs/mv78xx0_defconfig
index 980be9fb5e21..202fd7a6abea 100644
--- a/arch/arm/configs/mv78xx0_defconfig
+++ b/arch/arm/configs/mv78xx0_defconfig
@@ -16,8 +16,6 @@ CONFIG_MACH_RD78X00_MASA=y
 CONFIG_MACH_TERASTATION_WXL=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_FPE_NWFPE=y
 CONFIG_VFP=y
 CONFIG_KPROBES=y
diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
index 16bd80f0fcfa..e31a1c5d9ffe 100644
--- a/arch/arm/configs/mvebu_v5_defconfig
+++ b/arch/arm/configs/mvebu_v5_defconfig
@@ -33,8 +33,6 @@ CONFIG_MACH_RD88F5181L_FXO=y
 CONFIG_MACH_RD88F6183AP_GE=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CPU_FREQ=y
diff --git a/arch/arm/configs/netwinder_defconfig b/arch/arm/configs/netwinder_defconfig
index 41b97e9a7506..d870524e87bf 100644
--- a/arch/arm/configs/netwinder_defconfig
+++ b/arch/arm/configs/netwinder_defconfig
@@ -5,8 +5,6 @@ CONFIG_ARCH_NETWINDER=y
 CONFIG_LEDS=y
 CONFIG_LEDS_CPU=y
 CONFIG_DEPRECATED_PARAM_STRUCT=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=0x801"
 CONFIG_FPE_NWFPE=y
 CONFIG_BINFMT_AOUT=y
diff --git a/arch/arm/configs/omap1_defconfig b/arch/arm/configs/omap1_defconfig
index 930e53e8b3ed..0cb4a4f9445f 100644
--- a/arch/arm/configs/omap1_defconfig
+++ b/arch/arm/configs/omap1_defconfig
@@ -43,8 +43,6 @@ CONFIG_MACH_OMAP_GENERIC=y
 # CONFIG_ARM_THUMB is not set
 CONFIG_AEABI=y
 CONFIG_LEDS=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=1f03 rootfstype=jffs2"
 CONFIG_FPE_NWFPE=y
 # CONFIG_SUSPEND is not set
diff --git a/arch/arm/configs/orion5x_defconfig b/arch/arm/configs/orion5x_defconfig
index 8fcab7b22a07..59cfda53b5c8 100644
--- a/arch/arm/configs/orion5x_defconfig
+++ b/arch/arm/configs/orion5x_defconfig
@@ -34,8 +34,6 @@ CONFIG_MACH_RD88F5181L_GE=y
 CONFIG_MACH_RD88F5181L_FXO=y
 CONFIG_MACH_RD88F6183AP_GE=y
 CONFIG_AEABI=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_FPE_NWFPE=y
diff --git a/arch/arm/configs/palmz72_defconfig b/arch/arm/configs/palmz72_defconfig
index fc6553bede61..5ceed551b972 100644
--- a/arch/arm/configs/palmz72_defconfig
+++ b/arch/arm/configs/palmz72_defconfig
@@ -10,8 +10,6 @@ CONFIG_ARCH_PXA=y
 CONFIG_ARCH_PXA_PALM=y
 # CONFIG_MACH_PALMTX is not set
 CONFIG_AEABI=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="mem=32M console=tty root=/dev/mmcblk0"
 CONFIG_FPE_NWFPE=y
 CONFIG_PM=y
diff --git a/arch/arm/configs/pcm027_defconfig b/arch/arm/configs/pcm027_defconfig
index 69a318f74216..5215a685e082 100644
--- a/arch/arm/configs/pcm027_defconfig
+++ b/arch/arm/configs/pcm027_defconfig
@@ -16,8 +16,6 @@ CONFIG_MACH_PCM027=y
 CONFIG_MACH_PCM990_BASEBOARD=y
 CONFIG_AEABI=y
 # CONFIG_OABI_COMPAT is not set
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
diff --git a/arch/arm/configs/pleb_defconfig b/arch/arm/configs/pleb_defconfig
index 1b5a6c28d3fb..e109d8784b10 100644
--- a/arch/arm/configs/pleb_defconfig
+++ b/arch/arm/configs/pleb_defconfig
@@ -6,8 +6,6 @@ CONFIG_EXPERT=y
 # CONFIG_SHMEM is not set
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_PLEB=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="console=ttySA0,9600 mem=16M@0xc0000000 mem=16M@0xc8000000 root=/dev/ram initrd=0xc0400000,4M"
 CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
 CONFIG_CPU_FREQ_GOV_ONDEMAND=y
diff --git a/arch/arm/configs/pxa168_defconfig b/arch/arm/configs/pxa168_defconfig
index d7090c4aeb1e..772d92905199 100644
--- a/arch/arm/configs/pxa168_defconfig
+++ b/arch/arm/configs/pxa168_defconfig
@@ -8,8 +8,6 @@ CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_ARCH_MMP=y
 CONFIG_CMDLINE="root=/dev/nfs rootfstype=nfs nfsroot=192.168.2.100:/nfsroot/ ip=192.168.2.101:192.168.2.100::255.255.255.0::eth0:on console=ttyS0,115200 mem=128M"
diff --git a/arch/arm/configs/pxa255-idp_defconfig b/arch/arm/configs/pxa255-idp_defconfig
index a0b2027bc92a..eb0111ab3caf 100644
--- a/arch/arm/configs/pxa255-idp_defconfig
+++ b/arch/arm/configs/pxa255-idp_defconfig
@@ -6,8 +6,6 @@ CONFIG_ARCH_PXA_IDP=y
 # CONFIG_ARM_THUMB is not set
 CONFIG_LEDS=y
 CONFIG_LEDS_CPU=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=/dev/nfs ip=dhcp console=ttyS0,115200 mem=64M"
 CONFIG_FPE_NWFPE=y
 CONFIG_MODULES=y
diff --git a/arch/arm/configs/pxa3xx_defconfig b/arch/arm/configs/pxa3xx_defconfig
index b1cce2a8c74c..f898af656249 100644
--- a/arch/arm/configs/pxa3xx_defconfig
+++ b/arch/arm/configs/pxa3xx_defconfig
@@ -11,8 +11,6 @@ CONFIG_MACH_LITTLETON=y
 CONFIG_MACH_TAVOREVB=y
 CONFIG_MACH_SAAR=y
 CONFIG_AEABI=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=/dev/nfs rootfstype=nfs nfsroot=192.168.1.100:/nfsroot/ ip=192.168.1.101:192.168.1.100::255.255.255.0::eth0:on console=ttyS0,115200 mem=64M debug"
 CONFIG_FPE_NWFPE=y
 CONFIG_MODULES=y
diff --git a/arch/arm/configs/pxa910_defconfig b/arch/arm/configs/pxa910_defconfig
index 634ab55ff69d..f04197f3da1f 100644
--- a/arch/arm/configs/pxa910_defconfig
+++ b/arch/arm/configs/pxa910_defconfig
@@ -14,8 +14,6 @@ CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MACH_TAVOREVB=y
 CONFIG_MACH_TTC_DKB=y
 CONFIG_AEABI=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_FPE_NWFPE=y
 CONFIG_SLAB=y
 CONFIG_NET=y
diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index d3fc216de6fa..ad9d1d764b54 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -66,8 +66,6 @@ CONFIG_MACH_ICONTROL=y
 CONFIG_ARCH_PXA_ESERIES=y
 CONFIG_MACH_ZIPIT2=y
 CONFIG_AEABI=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=/dev/ram0 ro"
 CONFIG_KEXEC=y
 CONFIG_CPU_FREQ=y
diff --git a/arch/arm/configs/rpc_defconfig b/arch/arm/configs/rpc_defconfig
index a908663044ba..16d74a1f027a 100644
--- a/arch/arm/configs/rpc_defconfig
+++ b/arch/arm/configs/rpc_defconfig
@@ -6,8 +6,6 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_ARCH_RPC=y
 CONFIG_CPU_SA110=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_FPE_NWFPE=y
 CONFIG_BINFMT_AOUT=y
 CONFIG_PARTITION_ADVANCED=y
diff --git a/arch/arm/configs/s3c2410_defconfig b/arch/arm/configs/s3c2410_defconfig
index a455fd772e5b..26d9c8410923 100644
--- a/arch/arm/configs/s3c2410_defconfig
+++ b/arch/arm/configs/s3c2410_defconfig
@@ -37,8 +37,6 @@ CONFIG_ARCH_S3C2440=y
 CONFIG_MACH_NEO1973_GTA02=y
 CONFIG_MACH_RX1950=y
 CONFIG_MACH_SMDK2443=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=/dev/hda1 ro init=/bin/bash console=ttySAC0"
 CONFIG_FPE_NWFPE=y
 CONFIG_FPE_NWFPE_XP=y
diff --git a/arch/arm/configs/shannon_defconfig b/arch/arm/configs/shannon_defconfig
index 9c1de40132b2..feaec5405576 100644
--- a/arch/arm/configs/shannon_defconfig
+++ b/arch/arm/configs/shannon_defconfig
@@ -3,8 +3,6 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_SHANNON=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="console=ttySA0,9600 console=tty1 root=/dev/mtdblock2 init=/linuxrc"
 CONFIG_FPE_NWFPE=y
 CONFIG_MODULES=y
diff --git a/arch/arm/configs/simpad_defconfig b/arch/arm/configs/simpad_defconfig
index 0e1871fc8311..b81e5decd147 100644
--- a/arch/arm/configs/simpad_defconfig
+++ b/arch/arm/configs/simpad_defconfig
@@ -8,8 +8,6 @@ CONFIG_KALLSYMS_EXTRA_PASS=y
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_SIMPAD=y
 CONFIG_LEDS=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="mtdparts=sa1100:512k(boot),1m(kernel),-(root) console=ttySA0 root=1f02 noinitrd mem=64M jffs2_orphaned_inodes=delete rootfstype=jffs2"
 CONFIG_FPE_NWFPE=y
 CONFIG_MODULES=y
diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 9d4f352a57de..82932da2cec1 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -14,8 +14,6 @@ CONFIG_ARM_THUMBEE=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_HIGHMEM=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_MODULES=y
diff --git a/arch/arm/configs/spitz_defconfig b/arch/arm/configs/spitz_defconfig
index 7757d26396c1..1284a1d92ca3 100644
--- a/arch/arm/configs/spitz_defconfig
+++ b/arch/arm/configs/spitz_defconfig
@@ -11,8 +11,6 @@ CONFIG_ARCH_PXA=y
 CONFIG_PXA_SHARPSL=y
 CONFIG_MACH_AKITA=y
 CONFIG_MACH_BORZOI=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="console=ttyS0,115200n8 console=tty1 noinitrd root=/dev/mtdblock2 rootfstype=jffs2   debug"
 CONFIG_FPE_NWFPE=y
 CONFIG_BINFMT_AOUT=m
diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index 25fbd8a6ad15..0dbdf4d2f29f 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -21,8 +21,6 @@ CONFIG_DRAM_BASE=0x90000000
 CONFIG_FLASH_MEM_BASE=0x08000000
 CONFIG_FLASH_SIZE=0x00200000
 # CONFIG_ATAGS is not set
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_XIP_KERNEL=y
 CONFIG_XIP_PHYS_ADDR=0x08008000
 CONFIG_BINFMT_FLAT=y
diff --git a/arch/arm/configs/tct_hammer_defconfig b/arch/arm/configs/tct_hammer_defconfig
index 6cc2f108056f..ce95cc97dcac 100644
--- a/arch/arm/configs/tct_hammer_defconfig
+++ b/arch/arm/configs/tct_hammer_defconfig
@@ -13,8 +13,6 @@ CONFIG_ARCH_MULTI_V4T=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_S3C24XX=y
 CONFIG_MACH_TCT_HAMMER=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="mem=64M root=/dev/ram0 init=/linuxrc rw"
 CONFIG_FPE_NWFPE=y
 CONFIG_MODULES=y
diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
index acfe53205780..9722c237f600 100644
--- a/arch/arm/configs/vexpress_defconfig
+++ b/arch/arm/configs/vexpress_defconfig
@@ -20,8 +20,6 @@ CONFIG_MCPM=y
 CONFIG_VMSPLIT_2G=y
 CONFIG_NR_CPUS=8
 CONFIG_ARM_PSCI=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="console=ttyAMA0"
 CONFIG_CPU_IDLE=y
 CONFIG_VFP=y
diff --git a/arch/arm/configs/viper_defconfig b/arch/arm/configs/viper_defconfig
index 3ef71a2cd602..0a2ad9ec8c89 100644
--- a/arch/arm/configs/viper_defconfig
+++ b/arch/arm/configs/viper_defconfig
@@ -9,8 +9,6 @@ CONFIG_ARCH_PXA=y
 CONFIG_ARCH_VIPER=y
 CONFIG_IWMMXT=y
 CONFIG_AEABI=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=31:02 rootfstype=jffs2 ro console=ttyS0,115200"
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_GOV_POWERSAVE=m
diff --git a/arch/arm/configs/xcep_defconfig b/arch/arm/configs/xcep_defconfig
index 9c2f039fc09a..35b3689dc1c5 100644
--- a/arch/arm/configs/xcep_defconfig
+++ b/arch/arm/configs/xcep_defconfig
@@ -17,8 +17,6 @@ CONFIG_ARCH_PXA=y
 CONFIG_MACH_XCEP=y
 CONFIG_IWMMXT=y
 CONFIG_AEABI=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=mtd4 rootfstype=jffs2 ro console=ttyS0,115200"
 CONFIG_FPE_NWFPE=y
 CONFIG_KPROBES=y
diff --git a/arch/arm/configs/zeus_defconfig b/arch/arm/configs/zeus_defconfig
index 9a72be595fce..37ae98a762c0 100644
--- a/arch/arm/configs/zeus_defconfig
+++ b/arch/arm/configs/zeus_defconfig
@@ -5,8 +5,6 @@ CONFIG_LOG_BUF_SHIFT=13
 CONFIG_ARCH_PXA=y
 CONFIG_MACH_ARCOM_ZEUS=y
 CONFIG_AEABI=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=31:02 rootfstype=jffs2 ro console=ttyS0,115200"
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_GOV_POWERSAVE=m
-- 
2.29.2

