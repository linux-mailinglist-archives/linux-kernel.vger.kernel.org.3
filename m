Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F075655AF94
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 08:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbiFZGqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 02:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbiFZGp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 02:45:56 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A5F12D3D;
        Sat, 25 Jun 2022 23:45:54 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id z16so97136qkj.7;
        Sat, 25 Jun 2022 23:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aIBzvIcPgXIgo6YMMrI6mphvH7OvkFUcVchByeZ71LA=;
        b=gb467VwqSuqj/ol5S15E27ZzkCWQTZNSRLHRupJs5oytxm0etIFF/2nMMEiWmI0Tih
         g945kEQJ9vGxsgUGoEzw+oRZ3pVQc28DkEubDF1uHPOt00EGDoOrAetpZMOyX7O3mQ83
         537ORI6/TK9fY77BnNpOD+niiph+O+rzbmD7DUZYtcLBedg0Q5pKF4rKk6Pys9MkcVFD
         dAlcYBgjCjVXxiY4lTlu3Hr9PzTY46Mfd2Z+YMWCGnPSppGjo4sxE+j0jg9uWSZavcj1
         atUUmcgl9LFtKEOnqPTGOnCA23qlyVHaNM9xoHBpaf+2y4VOKGFjTk07mA+Z1CvFZkxj
         OPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aIBzvIcPgXIgo6YMMrI6mphvH7OvkFUcVchByeZ71LA=;
        b=EErCY2ZEOAhvfo4v47kvvdbad8NVDxC0ai9ITTW8Lt4wrBImuvHgvbqzTx93LYmOf6
         htDARmeE9OGkaFHuQZve2SZa3nTVNYy0OVLMY/2P7H7Lia3RVjW+z0YeTKP8iFZTkZEM
         89T+KDjC8sKtgQi7xIyc3OHZ0V03BzT2IZ9KfLUSk2jwONLpCiZ0sAWbCGfhU+V+aShh
         aBwC5FvRRtT+tCiO4/c3bUyUZC3T+mknazvAqYubQd028RfKOI8hsDAxAI8dZf3imFXv
         v6eb3QzEc7toLHPv6aPaOQ0Ne/HlJSvT7X/F3qf0lAFOGXvHzvSnQVzXivBI0+g63OgX
         Bhew==
X-Gm-Message-State: AJIora/PQRZsjq3K/fpwqpcs8mNNtcrze9w/rDccj8NBzUR4n7f8Hk+k
        czu9ZFRvygKOJmIcBxDvQzA=
X-Google-Smtp-Source: AGRyM1tl4LnFKu4QKANzByjitSx9ebReMSpaR/tppkaoF50wcXffXewqZp8XtUDdi22tFJVJ+/XkZw==
X-Received: by 2002:ae9:e114:0:b0:6af:244:8de3 with SMTP id g20-20020ae9e114000000b006af02448de3mr4737402qkm.236.1656225954535;
        Sat, 25 Jun 2022 23:45:54 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id w15-20020a05620a424f00b006a76a939dbasm5914620qko.112.2022.06.25.23.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 23:45:53 -0700 (PDT)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, olof@lixom.net, linux@armlinux.org.uk,
        abel.vesa@nxp.com, dev@lynxeye.de, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, leoyang.li@nxp.com,
        sebastian.reichel@collabora.com, cniedermaier@dh-electronics.com,
        Mr.Bossman075@gmail.com, clin@suse.com,
        giulio.benetti@benettiengineering.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: [PATCH v4 13/13] ARM: imxrt_defconfig: Add i.MXRT1170
Date:   Sun, 26 Jun 2022 02:45:23 -0400
Message-Id: <20220626064523.3683775-14-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220626064523.3683775-1-Mr.Bossman075@gmail.com>
References: <20220626064523.3683775-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MXRT1170 pinctrl, clocks imxrt_defconfig.
Add support for CHIPIDEA usb host and usb gadget and other usb drives.

Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
V1 -> V2:
 - Remove USB_CONFIGFS*
V2 -> V3:
 - Nothing done
V3 -> V4:
 - Nothing done
---
 arch/arm/configs/imxrt_defconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/configs/imxrt_defconfig b/arch/arm/configs/imxrt_defconfig
index 52dba3762996..b3a013686255 100644
--- a/arch/arm/configs/imxrt_defconfig
+++ b/arch/arm/configs/imxrt_defconfig
@@ -17,7 +17,23 @@ CONFIG_SERIAL_FSL_LPUART=y
 CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
 CONFIG_SERIAL_DEV_BUS=y
 CONFIG_PINCTRL_IMXRT1050=y
+CONFIG_PINCTRL_IMXRT1170=y
 CONFIG_GPIO_MXC=y
+CONFIG_USB=y
+CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
+CONFIG_USB_DYNAMIC_MINORS=y
+CONFIG_USB_OTG=y
+CONFIG_USB_OTG_FSM=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_FSL=y
+CONFIG_USB_EHCI_HCD_PLATFORM=y
+CONFIG_USB_CHIPIDEA=y
+CONFIG_USB_CHIPIDEA_UDC=y
+CONFIG_USB_CHIPIDEA_HOST=y
+CONFIG_NOP_USB_XCEIV=y
+CONFIG_USB_MXS_PHY=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_MASS_STORAGE=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
@@ -25,6 +41,7 @@ CONFIG_MMC_SDHCI_ESDHC_IMX=y
 CONFIG_DMADEVICES=y
 CONFIG_FSL_EDMA=y
 CONFIG_CLK_IMXRT1050=y
+CONFIG_CLK_IMXRT1170=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
-- 
2.36.1

