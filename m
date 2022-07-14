Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5635756BE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 23:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240712AbiGNVNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 17:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiGNVNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 17:13:13 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DED466B8D;
        Thu, 14 Jul 2022 14:13:08 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id c3so2037203pfb.13;
        Thu, 14 Jul 2022 14:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B8cg+mg5jw1FPQY3lZieWXxuymftU8CQoVPtDoUrT1k=;
        b=N4B8l/vxJ2Xe1WBWxHBNHOXdKIleUoQraxHL6cKnbirSEeVlNV8t/zKLRnCYqzYzVa
         VOFhRLaFcUQDbF6R7jicePd2wjfV1lu7CVAlAjtrzkNXofz1wzoTSoCQ+sM3IJbuaIXj
         Q9PW/XbBEzCz+hRs6n8Jy/MHVQgHBGYkLxeG2plAguprbm7lkYLn8UNwqtSA7B8KVlDi
         6sIsUxkZ6lY1TMCQA+we74LZrsGoG0733NIVrg4y+0ENCUA87gk4aRIQl423r/z6dRjm
         QdpEKOqFNvQ71AYeOdSA++DIaUSUDvzLfXIbMZF9IVl4sYrpxQyNeRY+ZYTfkp4J3ivw
         DyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B8cg+mg5jw1FPQY3lZieWXxuymftU8CQoVPtDoUrT1k=;
        b=uzVpPfT7NkwDu55WYX1JmM5gmp7rLeV4siVA4VbyZm7CSiF7xE97MSD+d0IynndBfF
         9Z1T2S+WJPqjB3v3WvTH+hq2EM80d3Gf9ymfwUmRnNWxOKA0ez/1Z8MWgx89w62XITSB
         BGv475RJgg1a4gZcpyojdayRiOks1MOae4mrhFWR8SWdnZhRZ+sciEf8F62UXMjmwNau
         1+cbJXtr5nwV/ykDK14whsmQW77ztqvCd5U1yk/rLb6mSEp9+q9ByxirKDo9NIMus4vB
         aklcYt87qw7N/VBkx0y1ZxhwHKSK9eOKDVtVRAxQ2EmDg5Qj78zqXMsj2IHPRBOOooJo
         KpXw==
X-Gm-Message-State: AJIora8pohxGoyNXV1cg4mGd43ft3TsrK8h+t0jxauUX8i2AH6jSUXKe
        Za0kOEKkBTNTtRRHnHmR9Siwlb/7vvU=
X-Google-Smtp-Source: AGRyM1tE09kZsob7yu5BB/hFdoN9wNzLWdn2SuCJwb2sZPMx+cGS5kDlbRSDdRnY+5bBNjepbAyDWw==
X-Received: by 2002:a05:6a00:8cf:b0:522:93a6:46e9 with SMTP id s15-20020a056a0008cf00b0052293a646e9mr10619023pfu.62.1657833187250;
        Thu, 14 Jul 2022 14:13:07 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709027e8500b0016c9ac386dfsm1896782pla.94.2022.07.14.14.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 14:13:06 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] MIPS: BCM47XX: Add support for Netgear WNR3500L v2
Date:   Thu, 14 Jul 2022 14:13:01 -0700
Message-Id: <20220714211302.1391015-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Netgear WNR3500L v2 router based on the BCM47186
chipset and supporting 802.11n Wi-Fi.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/bcm47xx/board.c                          |  2 ++
 arch/mips/bcm47xx/buttons.c                        | 10 ++++++++++
 arch/mips/bcm47xx/leds.c                           | 11 +++++++++++
 arch/mips/bcm47xx/workarounds.c                    |  1 +
 arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h |  1 +
 5 files changed, 25 insertions(+)

diff --git a/arch/mips/bcm47xx/board.c b/arch/mips/bcm47xx/board.c
index 87dc76a1f941..8ef002471b9c 100644
--- a/arch/mips/bcm47xx/board.c
+++ b/arch/mips/bcm47xx/board.c
@@ -181,6 +181,7 @@ struct bcm47xx_board_type_list1 bcm47xx_board_list_board_id[] __initconst = {
 	{{BCM47XX_BOARD_NETGEAR_WNR1000_V3, "Netgear WNR1000 V3"}, "U12H139T50_NETGEAR"},
 	{{BCM47XX_BOARD_NETGEAR_WNR2000, "Netgear WNR2000"}, "U12H114T00_NETGEAR"},
 	{{BCM47XX_BOARD_NETGEAR_WNR3500L, "Netgear WNR3500L"}, "U12H136T99_NETGEAR"},
+	{{BCM47XX_BOARD_NETGEAR_WNR3500L_V2, "Netgear WNR3500L V2"}, "U12H172T00_NETGEAR"},
 	{{BCM47XX_BOARD_NETGEAR_WNR3500U, "Netgear WNR3500U"}, "U12H136T00_NETGEAR"},
 	{{BCM47XX_BOARD_NETGEAR_WNR3500V2, "Netgear WNR3500 V2"}, "U12H127T00_NETGEAR"},
 	{{BCM47XX_BOARD_NETGEAR_WNR3500V2VC, "Netgear WNR3500 V2vc"}, "U12H127T70_NETGEAR"},
@@ -195,6 +196,7 @@ struct bcm47xx_board_type_list3 bcm47xx_board_list_board[] __initconst = {
 	{{BCM47XX_BOARD_PHICOMM_M1, "Phicomm M1"}, "0x0590", "80", "0x1104"},
 	{{BCM47XX_BOARD_ZTE_H218N, "ZTE H218N"}, "0x053d", "1234", "0x1305"},
 	{{BCM47XX_BOARD_NETGEAR_WNR3500L, "Netgear WNR3500L"}, "0x04CF", "3500", "02"},
+	{{BCM47XX_BOARD_NETGEAR_WNR3500L_V2, "Netgear WNR3500L V2"}, "0x052b", "3500L", "02"},
 	{{BCM47XX_BOARD_LINKSYS_WRT54G_TYPE_0101, "Linksys WRT54G/GS/GL"}, "0x0101", "42", "0x10"},
 	{{BCM47XX_BOARD_LINKSYS_WRT54G_TYPE_0467, "Linksys WRT54G/GS/GL"}, "0x0467", "42", "0x10"},
 	{{BCM47XX_BOARD_LINKSYS_WRT54G_TYPE_0708, "Linksys WRT54G/GS/GL"}, "0x0708", "42", "0x10"},
diff --git a/arch/mips/bcm47xx/buttons.c b/arch/mips/bcm47xx/buttons.c
index 36f0b1aafaa2..38e4a9cbcf4e 100644
--- a/arch/mips/bcm47xx/buttons.c
+++ b/arch/mips/bcm47xx/buttons.c
@@ -459,6 +459,13 @@ bcm47xx_buttons_netgear_wnr3500lv1[] __initconst = {
 	BCM47XX_GPIO_KEY(6, KEY_WPS_BUTTON),
 };
 
+static const struct gpio_keys_button
+bcm47xx_buttons_netgear_wnr3500lv2[] __initconst = {
+	BCM47XX_GPIO_KEY(4, KEY_RESTART),
+	BCM47XX_GPIO_KEY(6, KEY_WPS_BUTTON),
+	BCM47XX_GPIO_KEY(8, KEY_RFKILL),
+};
+
 static const struct gpio_keys_button
 bcm47xx_buttons_netgear_wnr834bv2[] __initconst = {
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
@@ -736,6 +743,9 @@ int __init bcm47xx_buttons_register(void)
 	case BCM47XX_BOARD_NETGEAR_WNR3500L:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wnr3500lv1);
 		break;
+	case BCM47XX_BOARD_NETGEAR_WNR3500L_V2:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wnr3500lv2);
+		break;
 	case BCM47XX_BOARD_NETGEAR_WNR834BV2:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wnr834bv2);
 		break;
diff --git a/arch/mips/bcm47xx/leds.c b/arch/mips/bcm47xx/leds.c
index 4648a302a3c0..8e257d0896d2 100644
--- a/arch/mips/bcm47xx/leds.c
+++ b/arch/mips/bcm47xx/leds.c
@@ -527,6 +527,14 @@ bcm47xx_leds_netgear_wnr3500lv1[] __initconst = {
 	BCM47XX_GPIO_LED(7, "amber", "power", 0, LEDS_GPIO_DEFSTATE_OFF),
 };
 
+static const struct gpio_led
+bcm47xx_leds_netgear_wnr3500lv2[] __initconst = {
+	BCM47XX_GPIO_LED(0, "blue", "wlan", 0, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(1, "green", "wps", 0, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(3, "green", "power", 0, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(7, "amber", "power", 0, LEDS_GPIO_DEFSTATE_OFF),
+};
+
 static const struct gpio_led
 bcm47xx_leds_netgear_wnr834bv2[] __initconst = {
 	BCM47XX_GPIO_LED(2, "green", "power", 0, LEDS_GPIO_DEFSTATE_ON),
@@ -791,6 +799,9 @@ void __init bcm47xx_leds_register(void)
 	case BCM47XX_BOARD_NETGEAR_WNR3500L:
 		bcm47xx_set_pdata(bcm47xx_leds_netgear_wnr3500lv1);
 		break;
+	case BCM47XX_BOARD_NETGEAR_WNR3500L_V2:
+		bcm47xx_set_pdata(bcm47xx_leds_netgear_wnr3500lv2);
+		break;
 	case BCM47XX_BOARD_NETGEAR_WNR834BV2:
 		bcm47xx_set_pdata(bcm47xx_leds_netgear_wnr834bv2);
 		break;
diff --git a/arch/mips/bcm47xx/workarounds.c b/arch/mips/bcm47xx/workarounds.c
index 0ab95dd431b3..745c6228eb2c 100644
--- a/arch/mips/bcm47xx/workarounds.c
+++ b/arch/mips/bcm47xx/workarounds.c
@@ -22,6 +22,7 @@ void __init bcm47xx_workarounds(void)
 
 	switch (board) {
 	case BCM47XX_BOARD_NETGEAR_WNR3500L:
+	case BCM47XX_BOARD_NETGEAR_WNR3500L_V2:
 		bcm47xx_workarounds_enable_usb_power(12);
 		break;
 	case BCM47XX_BOARD_NETGEAR_WNDR3400V2:
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
index 6583639fe760..30f4114ab872 100644
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
+++ b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
@@ -118,6 +118,7 @@ enum bcm47xx_board {
 	BCM47XX_BOARD_NETGEAR_WNR1000_V3,
 	BCM47XX_BOARD_NETGEAR_WNR2000,
 	BCM47XX_BOARD_NETGEAR_WNR3500L,
+	BCM47XX_BOARD_NETGEAR_WNR3500L_V2,
 	BCM47XX_BOARD_NETGEAR_WNR3500U,
 	BCM47XX_BOARD_NETGEAR_WNR3500V2,
 	BCM47XX_BOARD_NETGEAR_WNR3500V2VC,
-- 
2.25.1

