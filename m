Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35005075BF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355485AbiDSQw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355187AbiDSQrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:47:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2614B2617;
        Tue, 19 Apr 2022 09:45:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B729F6187A;
        Tue, 19 Apr 2022 16:44:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE24C385A5;
        Tue, 19 Apr 2022 16:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650386699;
        bh=TQPO8Eb4DXbuBVjH4snBze/CPXLx8hYfj8F7j3GxU9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PkE+S9qLLt/uVvjmX7SVYzOD8H0A2jnCwpUediQL9CiEFuo2XQ7+fzVe5orFR/j+B
         1Kn0644vK/CRT07rVNiayly/tbCE5RPqmVa3sV7YLFN50VR4KOu5kwLyvCKy7UdWrd
         PpC3+mfHHUpdHO2H25Am/SucJvYtHlNwTKkTuKmcMj5yZ3LlaeFsGLmcsHCxsrNU/J
         cXPXnNTaI9aPH1OycStlSzavEF+2HEuf5KBubApJxMqmt5vWDdLpCukXObZY00wvyD
         QUu8InZhgmCtgAChwTU5DZn/0HRUIttBKkcHuZWOka//Ki7ysvaMnLhCuX+trrjXmv
         KfputJ5rHCapw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     robert.jarzmik@free.fr, linux-arm-kernel@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Paul Parsons <lost.distance@yahoo.com>,
        Tomas Cech <sleep_walker@suse.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Helge Deller <deller@gmx.de>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-input@vger.kernel.org,
        patches@opensource.cirrus.com, linux-leds@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        alsa-devel@alsa-project.org
Subject: [PATCH 47/48] ARM: pxa: remove support for MTD_XIP
Date:   Tue, 19 Apr 2022 18:38:09 +0200
Message-Id: <20220419163810.2118169-48-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220419163810.2118169-1-arnd@kernel.org>
References: <20220419163810.2118169-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Using MTD-XIP does not work on multiplatform kernels because
it requires SoC specific register accesses to be done from
low-level flash handling functions in RAM while the rest of the
kernel sits in flash.

I found no evidence of anyone still actually using this feature,
so remove it from PXA to avoid spending a lot of time on
actually making it work.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                         |  1 -
 arch/arm/mach-pxa/include/mach/mtd-xip.h | 36 ------------------------
 2 files changed, 37 deletions(-)
 delete mode 100644 arch/arm/mach-pxa/include/mach/mtd-xip.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index eef8cbf20045..ace6c08c8ae2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -413,7 +413,6 @@ config ARCH_DOVE
 
 config ARCH_PXA
 	bool "PXA2xx/PXA3xx-based"
-	select ARCH_MTD_XIP
 	select ARM_CPU_SUSPEND if PM
 	select AUTO_ZRELADDR
 	select COMMON_CLK
diff --git a/arch/arm/mach-pxa/include/mach/mtd-xip.h b/arch/arm/mach-pxa/include/mach/mtd-xip.h
deleted file mode 100644
index 4b31bef9e50a..000000000000
--- a/arch/arm/mach-pxa/include/mach/mtd-xip.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * MTD primitives for XIP support. Architecture specific functions
- *
- * Do not include this file directly. It's included from linux/mtd/xip.h
- * 
- * Author:	Nicolas Pitre
- * Created:	Nov 2, 2004
- * Copyright:	(C) 2004 MontaVista Software, Inc.
- */
-
-#ifndef __ARCH_PXA_MTD_XIP_H__
-#define __ARCH_PXA_MTD_XIP_H__
-
-#include <mach/regs-ost.h>
-
-/* restored July 2017, this did not build since 2011! */
-
-#define ICIP			io_p2v(0x40d00000)
-#define ICMR			io_p2v(0x40d00004)
-#define xip_irqpending()	(readl(ICIP) & readl(ICMR))
-
-/* we sample OSCR and convert desired delta to usec (1/4 ~= 1000000/3686400) */
-#define xip_currtime()		readl(OSCR)
-#define xip_elapsed_since(x)	(signed)((readl(OSCR) - (x)) / 4)
-
-/*
- * xip_cpu_idle() is used when waiting for a delay equal or larger than
- * the system timer tick period.  This should put the CPU into idle mode
- * to save power and to be woken up only when some interrupts are pending.
- * As above, this should not rely upon standard kernel code.
- */
-
-#define xip_cpu_idle()  asm volatile ("mcr p14, 0, %0, c7, c0, 0" :: "r" (1))
-
-#endif /* __ARCH_PXA_MTD_XIP_H__ */
-- 
2.29.2

