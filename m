Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36174D5585
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344764AbiCJXex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344766AbiCJXee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:34:34 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A800F14A6C2;
        Thu, 10 Mar 2022 15:33:32 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id v28so9905614ljv.9;
        Thu, 10 Mar 2022 15:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3vsc6ouoB8vOwzKcME49jGpp5OIxPMYEIohZYJnwev0=;
        b=d+eNWc8ngyjJrKSDwYLMFWPcDGHjiDCHSm/WfsKco0ew3i+q3rKmsbUZsPhtYcCnPL
         ZHuXvf5zv33rWdAhjMBkWYzeJW7MrA7e6nPmwM7JRTK+te1DR9CS84v8v2/Gb1YHzQU9
         dZKopydtHxwOp8y+ltdetI4cwStggwh2Vw7fgFpGmk26sQesb6JlcK8z1H/CK/ayXBVu
         xi3l7dZ+JUOGpK4CcvJOWXMjndGvJrzrGP9RVGJLhzs4AqA9aZ84l6M0wANuFmtnNUGC
         6mApEyCMgmT8LYENomRVAvrWlMVa2iOFM3Vaqf8MP3fYddEowwkEhP2pfdbILr44/8E1
         vbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3vsc6ouoB8vOwzKcME49jGpp5OIxPMYEIohZYJnwev0=;
        b=UXM6SNu9U/bZ/t/n9M8dn5XWQsSgOcBnEO4yTod/t8BuHqIYzz0Nl9UiPVxApz/uY9
         FDXVXtya/sNVJUCXy7Bsr2uZS3oq67MSHpqJA6jCmXW7T4QsB1SvZ5scBVD/hfjPTXfr
         5NC/WpHCA394Qu5X38FMJVvJjlCF1ZUX8MpsmroE0RqV7e068SCtOPu+eQXQdroLwYyn
         DHtSuBnIBkujqk3HXzjZBFE3A0qrT7a3qaTHctKPg1gTBlSQ+HHMrKDDmT1iNTnTDSVM
         wBbmM8Yd4IwKAPOjMD473EWvCMymdKE3Z3QgqstDXv4cJAebNtNRFYrS5/6X22yZ9dID
         9d8A==
X-Gm-Message-State: AOAM531AgQtDe1Ms6OowSaT2GMICvo7EwwaX1QX2Nlxtsb/RnrQH9fNh
        BKKyFF0uT9DhpdTiJpXeOew=
X-Google-Smtp-Source: ABdhPJwL0l5POI3v/Fyor58t2Taasl3ErFz6JqrWrNJbUSPoMJsjxaaDMNJTrcQ58ad2T9TAULliFA==
X-Received: by 2002:a2e:a7d5:0:b0:246:5f83:10da with SMTP id x21-20020a2ea7d5000000b002465f8310damr4497828ljp.335.1646955211006;
        Thu, 10 Mar 2022 15:33:31 -0800 (PST)
Received: from dell.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id s5-20020ac24645000000b00448628b8462sm598481lfo.249.2022.03.10.15.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 15:33:30 -0800 (PST)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Paul Walmsley <paul@pwsan.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH 3/4] ARM: OMAP1: Prepare for conversion of OMAP1 clocks to CCF
Date:   Fri, 11 Mar 2022 00:33:06 +0100
Message-Id: <20220310233307.99220-4-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310233307.99220-1-jmkrzyszt@gmail.com>
References: <20220310233307.99220-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for conversion of OMAP1 clocks to common clock framework,
identify users of those clocks which don't call clk_prepare/unprepare()
and update them to call clk_prepare_enable/clk_disable_unprepare() instead
of just clk_enable/disable(), as required by CCF implementation of clock
API.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/mcbsp.c     | 8 ++++----
 arch/arm/mach-omap1/ocpi.c      | 4 ++--
 arch/arm/mach-omap1/serial.c    | 6 +++---
 arch/arm/mach-omap1/timer32k.c  | 2 +-
 drivers/usb/host/ohci-omap.c    | 8 ++++----
 drivers/video/fbdev/omap/lcdc.c | 6 +++---
 6 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
index f36c34f47f11..3ec2badff6af 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -44,8 +44,8 @@ static void omap1_mcbsp_request(unsigned int id)
 			api_clk = clk_get(NULL, "api_ck");
 			dsp_clk = clk_get(NULL, "dsp_ck");
 			if (!IS_ERR(api_clk) && !IS_ERR(dsp_clk)) {
-				clk_enable(api_clk);
-				clk_enable(dsp_clk);
+				clk_prepare_enable(api_clk);
+				clk_prepare_enable(dsp_clk);
 
 				/*
 				 * DSP external peripheral reset
@@ -63,11 +63,11 @@ static void omap1_mcbsp_free(unsigned int id)
 	if (id == 0 || id == 2) {
 		if (--dsp_use == 0) {
 			if (!IS_ERR(api_clk)) {
-				clk_disable(api_clk);
+				clk_disable_unprepare(api_clk);
 				clk_put(api_clk);
 			}
 			if (!IS_ERR(dsp_clk)) {
-				clk_disable(dsp_clk);
+				clk_disable_unprepare(dsp_clk);
 				clk_put(dsp_clk);
 			}
 		}
diff --git a/arch/arm/mach-omap1/ocpi.c b/arch/arm/mach-omap1/ocpi.c
index 380ea2de58c1..03cc48024fd6 100644
--- a/arch/arm/mach-omap1/ocpi.c
+++ b/arch/arm/mach-omap1/ocpi.c
@@ -73,7 +73,7 @@ static int __init omap_ocpi_init(void)
 	if (IS_ERR(ocpi_ck))
 		return PTR_ERR(ocpi_ck);
 
-	clk_enable(ocpi_ck);
+	clk_prepare_enable(ocpi_ck);
 	ocpi_enable();
 	pr_info("OMAP OCPI interconnect driver loaded\n");
 
@@ -87,7 +87,7 @@ static void __exit omap_ocpi_exit(void)
 	if (!cpu_is_omap16xx())
 		return;
 
-	clk_disable(ocpi_ck);
+	clk_disable_unprepare(ocpi_ck);
 	clk_put(ocpi_ck);
 }
 
diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
index 9eb591fbfd89..5f591a836ab5 100644
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -141,7 +141,7 @@ void __init omap_serial_init(void)
 			if (IS_ERR(uart1_ck))
 				printk("Could not get uart1_ck\n");
 			else {
-				clk_enable(uart1_ck);
+				clk_prepare_enable(uart1_ck);
 				if (cpu_is_omap15xx())
 					clk_set_rate(uart1_ck, 12000000);
 			}
@@ -151,7 +151,7 @@ void __init omap_serial_init(void)
 			if (IS_ERR(uart2_ck))
 				printk("Could not get uart2_ck\n");
 			else {
-				clk_enable(uart2_ck);
+				clk_prepare_enable(uart2_ck);
 				if (cpu_is_omap15xx())
 					clk_set_rate(uart2_ck, 12000000);
 				else
@@ -163,7 +163,7 @@ void __init omap_serial_init(void)
 			if (IS_ERR(uart3_ck))
 				printk("Could not get uart3_ck\n");
 			else {
-				clk_enable(uart3_ck);
+				clk_prepare_enable(uart3_ck);
 				if (cpu_is_omap15xx())
 					clk_set_rate(uart3_ck, 12000000);
 			}
diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
index 780fdf03c3ce..049c7b7f28c4 100644
--- a/arch/arm/mach-omap1/timer32k.c
+++ b/arch/arm/mach-omap1/timer32k.c
@@ -180,7 +180,7 @@ int __init omap_32k_timer_init(void)
 
 		sync32k_ick = clk_get(NULL, "omap_32ksync_ick");
 		if (!IS_ERR(sync32k_ick))
-			clk_enable(sync32k_ick);
+			clk_prepare_enable(sync32k_ick);
 
 		ret = omap_init_clocksource_32k(base);
 	}
diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index 45dcf8292072..f09d6871499d 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -58,13 +58,13 @@ static struct hc_driver __read_mostly ohci_omap_hc_driver;
 static void omap_ohci_clock_power(struct ohci_omap_priv *priv, int on)
 {
 	if (on) {
-		clk_enable(priv->usb_dc_ck);
-		clk_enable(priv->usb_host_ck);
+		clk_prepare_enable(priv->usb_dc_ck);
+		clk_prepare_enable(priv->usb_host_ck);
 		/* guesstimate for T5 == 1x 32K clock + APLL lock time */
 		udelay(100);
 	} else {
-		clk_disable(priv->usb_host_ck);
-		clk_disable(priv->usb_dc_ck);
+		clk_disable_unprepare(priv->usb_host_ck);
+		clk_disable_unprepare(priv->usb_dc_ck);
 	}
 }
 
diff --git a/drivers/video/fbdev/omap/lcdc.c b/drivers/video/fbdev/omap/lcdc.c
index 7317c9aad677..97d20dc0d1d0 100644
--- a/drivers/video/fbdev/omap/lcdc.c
+++ b/drivers/video/fbdev/omap/lcdc.c
@@ -711,7 +711,7 @@ static int omap_lcdc_init(struct omapfb_device *fbdev, int ext_mode,
 		dev_err(fbdev->dev, "failed to adjust LCD rate\n");
 		goto fail1;
 	}
-	clk_enable(lcdc.lcd_ck);
+	clk_prepare_enable(lcdc.lcd_ck);
 
 	r = request_irq(OMAP_LCDC_IRQ, lcdc_irq_handler, 0, MODULE_NAME, fbdev);
 	if (r) {
@@ -746,7 +746,7 @@ static int omap_lcdc_init(struct omapfb_device *fbdev, int ext_mode,
 fail3:
 	free_irq(OMAP_LCDC_IRQ, lcdc.fbdev);
 fail2:
-	clk_disable(lcdc.lcd_ck);
+	clk_disable_unprepare(lcdc.lcd_ck);
 fail1:
 	clk_put(lcdc.lcd_ck);
 fail0:
@@ -760,7 +760,7 @@ static void omap_lcdc_cleanup(void)
 	free_fbmem();
 	omap_free_lcd_dma();
 	free_irq(OMAP_LCDC_IRQ, lcdc.fbdev);
-	clk_disable(lcdc.lcd_ck);
+	clk_disable_unprepare(lcdc.lcd_ck);
 	clk_put(lcdc.lcd_ck);
 }
 
-- 
2.35.1

