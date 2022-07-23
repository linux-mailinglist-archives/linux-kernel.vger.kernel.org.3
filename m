Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617CD57F065
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 18:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbiGWQGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 12:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238409AbiGWQFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 12:05:55 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CC71A055;
        Sat, 23 Jul 2022 09:05:42 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id h22so5471365qta.3;
        Sat, 23 Jul 2022 09:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HHu8G218PxZ+Sh+oW/8wfgk5SyIyArOnxoBZLnzyMqw=;
        b=JgZQUaG41TPYe1fXoXfnUQeRR7A+iKI3mbd+K+XIGcvqNHNJOtXcHcjPLSlyUOp8UH
         Yr5NOLVqqg2swISs0RxWyJUwBdpgAochSvT2eb+8PuaxdP6zrJ8z2cp19yWvaV4R84ff
         sp6+w/XGCRbXEglYdQ+iMN9ok2fNAOmtelOc9B58lHqzx/QxsE6xrArOrXdRfr+TSAOt
         yapOpTxb8z6JpoNvXeFwpbgcRHFtK0FRpNfe6Ekd69ad4rSu4qKm7MHo7S79CNB8+36T
         E7HPZDd68Yp5GwjuBHdv08FUBinhW6+Yekhaad51ZEgfDNJ8UiJARtZ25kNvkgChXGG8
         03kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HHu8G218PxZ+Sh+oW/8wfgk5SyIyArOnxoBZLnzyMqw=;
        b=NEWzffMQ0YmFb0yneiHlSlDlv0tq0vD8I+gbR5k5psTtxqjKZdzJ6UQvW3IHghnzMI
         a5RUUUxoC6iJiTlNIWJjucqB6+nz8S3LYbSz5uht8CMuUift4Fy1lK9FqD9NsYUc4mWC
         xfVWAkoMcsV1EuTbeRywNEdSyme7q79And11frIl3BcGT4AqB87qUC4zqX5RG5de0XEn
         /KQ6FJ+s6dLoFbGBFInfXTorswmQXlN3gxLzbwCBd9xp3jdzg9YLXD4UzM1GqTGG3p4A
         kMBAkm26NbfzriyEvH4w8/dXtEUoicjy5/QOoq2bvFydteGLwTl/i/R6rumOh1hATyMj
         uUuQ==
X-Gm-Message-State: AJIora8+ZXabWyfXmwS04MCyZyFlU4FSzlJDBi57qrjE12zSYG28NHbl
        wJ01GSdUhaxFYD5hYM0Dkuk=
X-Google-Smtp-Source: AGRyM1sty4J5XwW0ag/HITj7AIF93o93sOTihlZLsA/vbrWYDOL9pkU2KBAi8b1tZv8BQv2qmaeS3A==
X-Received: by 2002:ac8:5a86:0:b0:31e:d114:1964 with SMTP id c6-20020ac85a86000000b0031ed1141964mr4297753qtc.572.1658592340969;
        Sat, 23 Jul 2022 09:05:40 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id g4-20020ac87f44000000b0031eb3af3ffesm4935046qtk.52.2022.07.23.09.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 09:05:40 -0700 (PDT)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, abel.vesa@nxp.com, dev@lynxeye.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        leoyang.li@nxp.com, sebastian.reichel@collabora.com,
        cniedermaier@dh-electronics.com, Mr.Bossman075@gmail.com,
        clin@suse.com, giulio.benetti@benettiengineering.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v5 12/12] ARM: imxrt_defconfig: Add i.MXRT1170
Date:   Sat, 23 Jul 2022 12:05:13 -0400
Message-Id: <20220723160513.271692-13-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220723160513.271692-1-Mr.Bossman075@gmail.com>
References: <20220723160513.271692-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
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
V4 -> V5:
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

