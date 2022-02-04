Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9E64A93B7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 06:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243516AbiBDFnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 00:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiBDFnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 00:43:33 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62735C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 21:43:31 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id j38-20020a9d1926000000b0059fa6de6c71so4423765ota.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 21:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7mANuUkOphLwpRj5DOxSB7bBMNAPdfAqDwmem0PTq4M=;
        b=dRimb3rkQuF872cN3hDsEC5d8pdWmYMrYpPfUjSQ89OFY3381YB3+Ww7XzTNY06hbM
         nsyfN6Ms40oc4AlkaV+5ls493uxXgvdTUvsmuGEFydixiBZbTc4C1vIcF+3lnT3Clerk
         ngwmFW1WlDbKIjXSlNx5IO1Y9JQeMSf/a1rCji/rb89YS+H1ueSCgwGpW18w+IyZRwWy
         ornPgZCacJ+94WOoh9/hfanEoNUgJ6azB4GtVAlROpxmV+Byj8onrRafo/2hWHEU5Gfa
         YyjLNJ14sodwngldDLXElkh1EHp9YU9tpXWC0bfgkcYAmqNJqqPR5NBeFm/WWw04sgyz
         VIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7mANuUkOphLwpRj5DOxSB7bBMNAPdfAqDwmem0PTq4M=;
        b=MRhFlDShVFIMFT9eiClo8j0yYbrEd1ZtwkearoKD7pJuNDKQ1dPjbNnptEgvpj1lG2
         ki+rPsbCBWvHVrNivK7ZIedFAl36FmQIMXpFlaCHB0NSwHEvJBJE2ZgWf2mc1noctgFH
         xiJr5UH/CMT3fl38GTva5qo5IWwwZUJ/5m+I1vDfA0QgG7nv/a/FllLaiUQcBr5YPCmT
         i/jZnDipkky34YHKxaxgxlJ2SCjVtGd29yCaMuPHk/fV78lSN7eP+/m7yy/TtHUS3OpO
         xGJxBypsPDaawPwFgJIKIHXJ4lPePUsgKzupysJju9127g9bXrWExt8dY//uWTI6S9k/
         pioA==
X-Gm-Message-State: AOAM531GrQWtlmonuo+JXNyXYtkAHQBjPD/nFvg4rGGDXVxehvPQrxFX
        Y1eQmYdUxWqzTMaQIgQlLHo=
X-Google-Smtp-Source: ABdhPJyJ+EIAftWt11y5TDCEQICKo9+GTL9gJGYS16InQ++LMScRqn91HUjOhNYSOSL5JpV8C1tIDA==
X-Received: by 2002:a05:6830:23ba:: with SMTP id m26mr586156ots.29.1643953410652;
        Thu, 03 Feb 2022 21:43:30 -0800 (PST)
Received: from tong-desktop.local (99-105-211-126.lightspeed.sntcca.sbcglobal.net. [99.105.211.126])
        by smtp.googlemail.com with ESMTPSA id l4sm428434otq.50.2022.02.03.21.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 21:43:30 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tong Zhang <ztong0001@gmail.com>,
        Paul Bolle <pebolle@tiscali.nl>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     insop.song@gainspeed.com, devel@driverdev.osuosl.org
Subject: [PATCH] staging: gs_fpgaboot: revert removed board specific code
Date:   Thu,  3 Feb 2022 21:40:27 -0800
Message-Id: <20220204054028.3123858-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gs_fpgaboot is currently useless since the board specific code is
removed in 06a3fab941da. Loading the driver will always fail since
xl_init_io() always returns -1. This driver is broken since 2014 and I
doubt anyone is actually using it, we could either remove it or revert
to the previous working version.

$ modprobe gs_fpga
GPIO INIT FAIL!!

This patch reverts previously removed code and adds a Kconfig to make
this board selectable for PPC_85xx processors.

Fixes: 06a3fab941da ("staging: gs_fpgaboot: remove checks for CONFIG_B4860G100")
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/staging/gs_fpgaboot/Kconfig |  14 ++-
 drivers/staging/gs_fpgaboot/io.c    | 173 ++++++++++++++++++++++++++++
 2 files changed, 186 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/gs_fpgaboot/Kconfig b/drivers/staging/gs_fpgaboot/Kconfig
index 968a153c4ab6..0b4144450123 100644
--- a/drivers/staging/gs_fpgaboot/Kconfig
+++ b/drivers/staging/gs_fpgaboot/Kconfig
@@ -5,4 +5,16 @@
 config GS_FPGABOOT
 	tristate "Xilinx FPGA firmware download module"
 	help
-	  Xilinx FPGA firmware download module
+	  Xilinx FPGA firmware download module.
+
+choice
+	prompt "Support Board"
+	depends on GS_FPGABOOT
+
+config GS_FPGABOOT_BOARD_B4860G100
+	bool "B4860G100"
+	depends on PPC_85xx
+	help
+	  Select this to support B4860G100 board
+
+endchoice
diff --git a/drivers/staging/gs_fpgaboot/io.c b/drivers/staging/gs_fpgaboot/io.c
index 80903ec36b76..059016fb839e 100644
--- a/drivers/staging/gs_fpgaboot/io.c
+++ b/drivers/staging/gs_fpgaboot/io.c
@@ -16,10 +16,15 @@
 
 #include "io.h"
 
+#ifdef CONFIG_GS_FPGABOOT_BOARD_B4860G100
+static struct gpiobus gbus;
+#endif /* CONFIG_GS_FPGABOOT_BOARD_B4860G100 */
+
 static inline void byte0_out(unsigned char data);
 static inline void byte1_out(unsigned char data);
 static inline void xl_cclk_b(int32_t i);
 
+
 /* Assert and Deassert CCLK */
 void xl_shift_cclk(int count)
 {
@@ -59,6 +64,172 @@ void xl_shift_bytes_out(enum wbus bus_byte, unsigned char *pdata)
 	xl_shift_cclk(1);
 }
 
+#ifdef CONFIG_GS_FPGABOOT_BOARD_B4860G100
+/*
+ * ======================================================================
+ * board specific configuration
+ */
+
+static inline void mpc85xx_gpio_set_dir(
+			int32_t port,
+			uint32_t mask,
+			uint32_t dir)
+{
+	dir |= (in_be32(gbus.r[port]+GPDIR) & ~mask);
+	out_be32(gbus.r[port]+GPDIR, dir);
+}
+
+static inline void mpc85xx_gpio_set(int32_t port, uint32_t mask, uint32_t val)
+{
+	/* First mask off the unwanted parts of "dir" and "val" */
+	val &= mask;
+
+	/* Now read in the values we're supposed to preserve */
+	val |= (in_be32(gbus.r[port]+GPDAT) & ~mask);
+
+	out_be32(gbus.r[port]+GPDAT, val);
+}
+
+static inline uint32_t mpc85xx_gpio_get(int32_t port, uint32_t mask)
+{
+	/* Read the requested values */
+	return in_be32(gbus.r[port]+GPDAT) & mask;
+}
+
+static inline void mpc85xx_gpio_set_low(int32_t port, uint32_t gpios)
+{
+	mpc85xx_gpio_set(port, gpios, 0x00000000);
+}
+
+static inline void mpc85xx_gpio_set_high(int32_t port, uint32_t gpios)
+{
+	mpc85xx_gpio_set(port, gpios, 0xFFFFFFFF);
+}
+
+static inline void gpio_set_value(int32_t port, uint32_t gpio, uint32_t value)
+{
+	int32_t g;
+
+	g = 31 - gpio;
+	if (value)
+		mpc85xx_gpio_set_high(port, 1U << g);
+	else
+		mpc85xx_gpio_set_low(port, 1U << g);
+}
+
+static inline int gpio_get_value(int32_t port, uint32_t gpio)
+{
+	int32_t g;
+
+	g = 31 - gpio;
+	return !!mpc85xx_gpio_get(port, 1U << g);
+}
+
+static inline void xl_cclk_b(int32_t i)
+{
+	gpio_set_value(XL_CCLK_PORT, XL_CCLK_PIN, i);
+}
+
+static inline unsigned char bitswap(unsigned char s)
+{
+       unsigned char d;
+
+       d = (((s&0x80)>>7) | ((s&0x40)>>5) | ((s&0x20)>>3) | ((s&0x10)>>1) |
+               ((s&0x08)<<1) | ((s&0x04)<<3) | ((s&0x02)<<5) | ((s&0x01)<<7));
+       return d;
+}
+
+void xl_program_b(int32_t i)
+{
+	gpio_set_value(XL_PROGN_PORT, XL_PROGN_PIN, i);
+}
+
+void xl_rdwr_b(int32_t i)
+{
+	gpio_set_value(XL_RDWRN_PORT, XL_RDWRN_PIN, i);
+}
+
+void xl_csi_b(int32_t i)
+{
+	gpio_set_value(XL_CSIN_PORT, XL_CSIN_PIN, i);
+}
+
+int xl_get_init_b(void)
+{
+	return gpio_get_value(XL_INITN_PORT, XL_INITN_PIN);
+}
+
+int xl_get_done_b(void)
+{
+	return gpio_get_value(XL_DONE_PORT, XL_DONE_PIN);
+}
+
+
+/* G100 specific bit swap and remmap (to gpio pins) for byte 0 */
+static inline uint32_t bit_remap_byte0(uint32_t s)
+{
+	uint32_t d;
+
+	d = (((s&0x80)>>7) | ((s&0x40)>>5) | ((s&0x20)>>3) | ((s&0x10)>>1) |
+		((s&0x08)<<1) | ((s&0x04)<<3) | ((s&0x02)<<6) | ((s&0x01)<<9));
+	return d;
+}
+
+/*
+ * G100 specific MSB, in this order [byte0 | byte1], out
+ */
+static inline void byte0_out(unsigned char data)
+{
+	uint32_t swap32;
+
+	swap32 =  bit_remap_byte0((uint32_t) data) << 8;
+
+	mpc85xx_gpio_set(0, 0x0002BF00, (uint32_t) swap32);
+}
+
+/*
+ * G100 specific LSB, in this order [byte0 | byte1], out
+ */
+static inline void byte1_out(unsigned char data)
+{
+	mpc85xx_gpio_set(0, 0x000000FF, (uint32_t) bitswap(data));
+}
+
+/*
+ * configurable per device type for different I/O config
+ */
+int xl_init_io(void)
+{
+	struct device_node *np;
+	const u32 *p_reg;
+	int reg, cnt;
+
+	cnt = 0;
+	memset(&gbus, 0, sizeof(struct gpiobus));
+	for_each_compatible_node(np, NULL, "fsl,qoriq-gpio") {
+		p_reg = of_get_property(np, "reg", NULL);
+		if (p_reg == NULL)
+			break;
+		reg = (int) *p_reg;
+		gbus.r[cnt] = of_iomap(np, 0);
+
+		if (!gbus.r[cnt]) {
+			pr_err("not findding gpio cell-index %d\n", cnt);
+			return -ENODEV;
+		}
+		cnt++;
+	}
+	mpc85xx_gpio_set_dir(0, 0x0002BFFF, 0x0002BFFF);
+	mpc85xx_gpio_set_dir(1, 0x00240060, 0x00240060);
+
+	gbus.ngpio = cnt;
+
+	return 0;
+}
+
+
+#else	/* placeholder for boards with different config */
+
 /*
  * generic bit swap for xilinx SYSTEMMAP FPGA programming
  */
@@ -103,3 +274,5 @@ int xl_init_io(void)
 {
 	return -1;
 }
+
+#endif /* CONFIG_GS_FPGABOOT_BOARD_B4860G100 */
-- 
2.25.1

