Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2075075BE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355793AbiDSQxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348967AbiDSQqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:46:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113A5396A3;
        Tue, 19 Apr 2022 09:43:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A15E56145C;
        Tue, 19 Apr 2022 16:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED67C385A9;
        Tue, 19 Apr 2022 16:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650386598;
        bh=v2JXUsT+aPSiyV8AWZ0OLtn99RZRKtVDeuty5M4eG68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tt/fiI6JfMKScsjC4gupDTlXwIFAYWcsYENflWn5n3kMrbCN+Y2cCr3glEwE1sItJ
         cONsIQQLt01Y/qCAeHUUbJd9TpD27gE/DUc3zMZ7c0U2VwpCWQ+qBf7uwrq/GZGzTX
         3FGOj+knk17r2GSyltkagM0yCF+n9LJkDIwNmtctqNly1C9p720AIevLts/VbLM17G
         O+4nFGEcvsfnWMk8Au/5OQB6coNhg3LP2cgERB8iHAG0NNlBzSNRpU2laCxc90/bD8
         8gZIgUWRqfgnaIv2WyLz/01oqgCe1ixn6EBO/7GUMc0aVvmzyH6K1PsZ1Shk5OoOYF
         /MoVumyBheReg==
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
Subject: [PATCH 34/48] ARM: pxa: pcmcia: move smemc configuration back to arch
Date:   Tue, 19 Apr 2022 18:37:56 +0200
Message-Id: <20220419163810.2118169-35-arnd@kernel.org>
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

Rather than poking at the smemc registers directly from the
pcmcia/pxa2xx_base driver, move those bits into machine file
to have a cleaner interface.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Link: https://lore.kernel.org/lkml/87d0egjzxk.fsf@belgarion.home/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/generic.c   | 29 ++++++++++++++++++++++
 drivers/pcmcia/pxa2xx_base.c  | 46 ++++++++++++-----------------------
 include/linux/soc/pxa/smemc.h | 10 ++++++++
 3 files changed, 55 insertions(+), 30 deletions(-)
 create mode 100644 include/linux/soc/pxa/smemc.h

diff --git a/arch/arm/mach-pxa/generic.c b/arch/arm/mach-pxa/generic.c
index f9083c4f0aea..fe1d55d328e5 100644
--- a/arch/arm/mach-pxa/generic.c
+++ b/arch/arm/mach-pxa/generic.c
@@ -70,6 +70,35 @@ unsigned int get_clk_frequency_khz(int info)
 }
 EXPORT_SYMBOL(get_clk_frequency_khz);
 
+void pxa_smemc_set_pcmcia_timing(int sock, u32 mcmem, u32 mcatt, u32 mcio)
+{
+	__raw_writel(mcmem, MCMEM(sock));
+	__raw_writel(mcatt, MCATT(sock));
+	__raw_writel(mcio, MCIO(sock));
+}
+EXPORT_SYMBOL_GPL(pxa_smemc_set_pcmcia_timing);
+
+void pxa_smemc_set_pcmcia_socket(int nr)
+{
+	switch (nr) {
+	case 0:
+		__raw_writel(0, MECR);
+		break;
+	case 1:
+		/*
+		 * We have at least one socket, so set MECR:CIT
+		 * (Card Is There)
+		 */
+		__raw_writel(MECR_CIT, MECR);
+		break;
+	case 2:
+		/* Set CIT and MECR:NOS (Number Of Sockets) */
+		__raw_writel(MECR_CIT | MECR_NOS, MECR);
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(pxa_smemc_set_pcmcia_socket);
+
 /*
  * Intel PXA2xx internal register mapping.
  *
diff --git a/drivers/pcmcia/pxa2xx_base.c b/drivers/pcmcia/pxa2xx_base.c
index 7cd1375d6087..0ea41f1411e5 100644
--- a/drivers/pcmcia/pxa2xx_base.c
+++ b/drivers/pcmcia/pxa2xx_base.c
@@ -24,11 +24,10 @@
 #include <linux/spinlock.h>
 #include <linux/platform_device.h>
 #include <linux/soc/pxa/cpu.h>
+#include <linux/soc/pxa/smemc.h>
 
-#include <mach/smemc.h>
 #include <asm/io.h>
 #include <asm/irq.h>
-#include <mach/pxa2xx-regs.h>
 #include <asm/mach-types.h>
 
 #include <pcmcia/ss.h>
@@ -113,7 +112,7 @@ static inline u_int pxa2xx_pcmcia_cmd_time(u_int mem_clk_10khz,
 	return (300000 * (pcmcia_mcxx_asst + 1) / mem_clk_10khz);
 }
 
-static int pxa2xx_pcmcia_set_mcmem( int sock, int speed, int clock )
+static uint32_t pxa2xx_pcmcia_mcmem(int sock, int speed, int clock)
 {
 	uint32_t val;
 
@@ -124,12 +123,10 @@ static int pxa2xx_pcmcia_set_mcmem( int sock, int speed, int clock )
 		| ((pxa2xx_mcxx_hold(speed, clock)
 		& MCXX_HOLD_MASK) << MCXX_HOLD_SHIFT);
 
-	__raw_writel(val, MCMEM(sock));
-
-	return 0;
+	return val;
 }
 
-static int pxa2xx_pcmcia_set_mcio( int sock, int speed, int clock )
+static int pxa2xx_pcmcia_mcio(int sock, int speed, int clock)
 {
 	uint32_t val;
 
@@ -140,12 +137,11 @@ static int pxa2xx_pcmcia_set_mcio( int sock, int speed, int clock )
 		| ((pxa2xx_mcxx_hold(speed, clock)
 		& MCXX_HOLD_MASK) << MCXX_HOLD_SHIFT);
 
-	__raw_writel(val, MCIO(sock));
 
-	return 0;
+	return val;
 }
 
-static int pxa2xx_pcmcia_set_mcatt( int sock, int speed, int clock )
+static int pxa2xx_pcmcia_mcatt(int sock, int speed, int clock)
 {
 	uint32_t val;
 
@@ -156,31 +152,26 @@ static int pxa2xx_pcmcia_set_mcatt( int sock, int speed, int clock )
 		| ((pxa2xx_mcxx_hold(speed, clock)
 		& MCXX_HOLD_MASK) << MCXX_HOLD_SHIFT);
 
-	__raw_writel(val, MCATT(sock));
 
-	return 0;
+	return val;
 }
 
-static int pxa2xx_pcmcia_set_mcxx(struct soc_pcmcia_socket *skt, unsigned int clk)
+static int pxa2xx_pcmcia_set_timing(struct soc_pcmcia_socket *skt)
 {
+	unsigned long clk = clk_get_rate(skt->clk) / 10000;
 	struct soc_pcmcia_timing timing;
 	int sock = skt->nr;
 
 	soc_common_pcmcia_get_timing(skt, &timing);
 
-	pxa2xx_pcmcia_set_mcmem(sock, timing.mem, clk);
-	pxa2xx_pcmcia_set_mcatt(sock, timing.attr, clk);
-	pxa2xx_pcmcia_set_mcio(sock, timing.io, clk);
+	pxa_smemc_set_pcmcia_timing(sock,
+		pxa2xx_pcmcia_mcmem(sock, timing.mem, clk),
+		pxa2xx_pcmcia_mcatt(sock, timing.attr, clk),
+		pxa2xx_pcmcia_mcio(sock, timing.io, clk));
 
 	return 0;
 }
 
-static int pxa2xx_pcmcia_set_timing(struct soc_pcmcia_socket *skt)
-{
-	unsigned long clk = clk_get_rate(skt->clk);
-	return pxa2xx_pcmcia_set_mcxx(skt, clk / 10000);
-}
-
 #ifdef CONFIG_CPU_FREQ
 
 static int
@@ -215,18 +206,13 @@ pxa2xx_pcmcia_frequency_change(struct soc_pcmcia_socket *skt,
 
 void pxa2xx_configure_sockets(struct device *dev, struct pcmcia_low_level *ops)
 {
-	/*
-	 * We have at least one socket, so set MECR:CIT
-	 * (Card Is There)
-	 */
-	uint32_t mecr = MECR_CIT;
+	int nr = 1;
 
-	/* Set MECR:NOS (Number Of Sockets) */
 	if ((ops->first + ops->nr) > 1 ||
 	    machine_is_viper() || machine_is_arcom_zeus())
-		mecr |= MECR_NOS;
+		nr = 2;
 
-	__raw_writel(mecr, MECR);
+	pxa_smemc_set_pcmcia_socket(nr);
 }
 EXPORT_SYMBOL(pxa2xx_configure_sockets);
 
diff --git a/include/linux/soc/pxa/smemc.h b/include/linux/soc/pxa/smemc.h
new file mode 100644
index 000000000000..cbf1a2d8af29
--- /dev/null
+++ b/include/linux/soc/pxa/smemc.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __PXA_REGS_H
+#define __PXA_REGS_H
+
+#include <linux/types.h>
+
+void pxa_smemc_set_pcmcia_timing(int sock, u32 mcmem, u32 mcatt, u32 mcio);
+void pxa_smemc_set_pcmcia_socket(int nr);
+
+#endif
-- 
2.29.2

