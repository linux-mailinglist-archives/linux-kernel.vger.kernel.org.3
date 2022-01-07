Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6275148717E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 04:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345984AbiAGDwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 22:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345931AbiAGDwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 22:52:10 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD31C061245;
        Thu,  6 Jan 2022 19:52:09 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id y9so4336820pgr.11;
        Thu, 06 Jan 2022 19:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zYcqEoQI29hMWYZqyQy1OtQsjoVbbA0r88mZGlgKY4A=;
        b=Qa0LlzaN7jijteHr/SGTUhu71JV6fo73vqA+B3N6T4s0E2+9RiqigpMPjESlBAQOv6
         Nv0hdcC8ejTZdiBw/h/1bPNHPWPFRme69RAYymYDQqotxenTo35S3NTnpx0o8r807iMr
         Z2lTTllz/qDmCjMgxbrZFmNuAmyeaBIArbspYIFt/wtb/ZQHKxNJQejpt0j/wCDfgMEz
         s7jTRSzbs/3ha/oVR33M6bCqB7qZFHnyKRRGW4EMtA3BT5ZiLgqwb0+Znbz7BT/J5M8U
         y8uQIyiBlSjNkOzJ0EwHAhBcQExKv3AOMFEVAetO0GiUeyZv1EIZ88p7KApr12kVf/yN
         Z00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zYcqEoQI29hMWYZqyQy1OtQsjoVbbA0r88mZGlgKY4A=;
        b=ZcQDmTY4jOrdhQc0CdNF6yainHjP89xgvdDY274Mcvg7MDMFlh4O+XcPtTWh2+jmLH
         Z8ugPy2w40EF5QjaFrEdqIJgUHRfgsKzpxSO0z5JPUU3QsbPfNOhIlF4+p9/HPBX8vQF
         FX/wrQX0hYiGoHx788XWn//kbkhAXhIfsmggTvfLMzkrv/ic8SMr1zX9Gy21wgObmf+E
         4jyrJJ6VWNpA4yXGuTlNPNGTzzwyY1XOuEsjOSN8i3WNj4oU8Hh3SYihm280n7Iq+lHN
         joxNIeanHBhGDXx7TcpdcZ8e34xdM2DLtpObxGmfiaoxPFAbQI2kFZTtg1detCLT6dSV
         ydnQ==
X-Gm-Message-State: AOAM532s/l3fn6kEhfJIdAGUxK1mEl5Xqryc0RGtbRXYyZBpZprJBya2
        RhoVGseshW+lavRhxmV/h8BdROqBLHs=
X-Google-Smtp-Source: ABdhPJxGYbGeHW+Gc7dBjAgSOuinoqAyhaSqHIkvQhHwsLiqnp3Z1xdnS/6dU01E/mODwUi0MiJ1rA==
X-Received: by 2002:a62:7bcc:0:b0:4bc:e13e:b484 with SMTP id w195-20020a627bcc000000b004bce13eb484mr9607751pfc.53.1641527529063;
        Thu, 06 Jan 2022 19:52:09 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j16sm4043855pfj.16.2022.01.06.19.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 19:52:08 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/5] MIPS: BCM47XX: Add support for Netgear WN2500RP v1 & v2
Date:   Thu,  6 Jan 2022 19:51:41 -0800
Message-Id: <20220107035141.2325384-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107035141.2325384-1-f.fainelli@gmail.com>
References: <20220107035141.2325384-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Netgear WN2500 RP v1 and v2 Wi-Fi range extenders
based on the BCM5357 chipset and supporting 802.11n and 802.11ac.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/bcm47xx/board.c                          | 2 ++
 arch/mips/bcm47xx/buttons.c                        | 9 +++++++++
 arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h | 2 ++
 3 files changed, 13 insertions(+)

diff --git a/arch/mips/bcm47xx/board.c b/arch/mips/bcm47xx/board.c
index f87b14c73f3c..012cf1c5e911 100644
--- a/arch/mips/bcm47xx/board.c
+++ b/arch/mips/bcm47xx/board.c
@@ -166,6 +166,8 @@ struct bcm47xx_board_type_list1 bcm47xx_board_list_board_id[] __initconst = {
 	{{BCM47XX_BOARD_NETGEAR_WGR614V8, "Netgear WGR614 V8"}, "U12H072T00_NETGEAR"},
 	{{BCM47XX_BOARD_NETGEAR_WGR614V9, "Netgear WGR614 V9"}, "U12H094T00_NETGEAR"},
 	{{BCM47XX_BOARD_NETGEAR_WGR614_V10, "Netgear WGR614 V10"}, "U12H139T01_NETGEAR"},
+	{{BCM47XX_BOARD_NETGEAR_WN2500RP_V1, "Netgear WN2500RP V1"}, "U12H197T00_NETGEAR"},
+	{{BCM47XX_BOARD_NETGEAR_WN2500RP_V2, "Netgear WN2500RP V2"}, "U12H294T00_NETGEAR"},
 	{{BCM47XX_BOARD_NETGEAR_WNDR3300, "Netgear WNDR3300"}, "U12H093T00_NETGEAR"},
 	{{BCM47XX_BOARD_NETGEAR_WNDR3400V1, "Netgear WNDR3400 V1"}, "U12H155T00_NETGEAR"},
 	{{BCM47XX_BOARD_NETGEAR_WNDR3400V2, "Netgear WNDR3400 V2"}, "U12H187T00_NETGEAR"},
diff --git a/arch/mips/bcm47xx/buttons.c b/arch/mips/bcm47xx/buttons.c
index e380baef2458..36f0b1aafaa2 100644
--- a/arch/mips/bcm47xx/buttons.c
+++ b/arch/mips/bcm47xx/buttons.c
@@ -414,6 +414,12 @@ bcm47xx_buttons_netgear_r6300_v1[] __initconst = {
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 };
 
+static const struct gpio_keys_button
+bcm47xx_buttons_netgear_wn2500rp_v1[] __initconst = {
+	BCM47XX_GPIO_KEY(12, KEY_RESTART),
+	BCM47XX_GPIO_KEY(31, KEY_WPS_BUTTON),
+};
+
 static const struct gpio_keys_button
 bcm47xx_buttons_netgear_wndr3400v1[] __initconst = {
 	BCM47XX_GPIO_KEY(4, KEY_RESTART),
@@ -709,6 +715,9 @@ int __init bcm47xx_buttons_register(void)
 	case BCM47XX_BOARD_NETGEAR_R6300_V1:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_r6300_v1);
 		break;
+	case BCM47XX_BOARD_NETGEAR_WN2500RP_V1:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wn2500rp_v1);
+		break;
 	case BCM47XX_BOARD_NETGEAR_WNDR3400V1:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wndr3400v1);
 		break;
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
index 721c65312b19..6583639fe760 100644
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
+++ b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
@@ -104,6 +104,8 @@ enum bcm47xx_board {
 	BCM47XX_BOARD_NETGEAR_WGR614V8,
 	BCM47XX_BOARD_NETGEAR_WGR614V9,
 	BCM47XX_BOARD_NETGEAR_WGR614_V10,
+	BCM47XX_BOARD_NETGEAR_WN2500RP_V1,
+	BCM47XX_BOARD_NETGEAR_WN2500RP_V2,
 	BCM47XX_BOARD_NETGEAR_WNDR3300,
 	BCM47XX_BOARD_NETGEAR_WNDR3400V1,
 	BCM47XX_BOARD_NETGEAR_WNDR3400V2,
-- 
2.25.1

