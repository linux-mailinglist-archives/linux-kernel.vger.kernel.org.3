Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DE2513E11
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 23:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352588AbiD1VxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 17:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352638AbiD1Vwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:52:37 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F12C3E8B;
        Thu, 28 Apr 2022 14:49:06 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id f14so4501813qtq.1;
        Thu, 28 Apr 2022 14:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x2tfNJJ7zvk5t2UFdzL7uNJCGv9rRgs1ExdTc2XZh9U=;
        b=baXLtRyTMQ7d/LV1qdLfIjPKcoZLa/+WgUsUFZmrNSSw1msbNF4DpgT0CwPs7rjxK9
         0ioHyPE5v+hfAEhGAPSsAHJCO+wv2FMP6Dr9t/BCigIw/sGbbSQqMzbESC7lfCFyjAQ/
         sn6KgPtKJ6XP9UowM1ptd+p7MqQNCBFlG9l7UqNjBz3adUedpNWRnm3Tlnk58HdNTMYL
         qaq+ETHzKpkaR//VBKb4ovs7g/5lgGNOAM+rtkDd2SXlaiB/bSp/2FS58wfAiM7pBSVh
         Lq8C7SPfoIiAR7tE1hi+XzYarY9HfpB200D8kdxoYRMAXvmw5CpppgySeAnzsTBJ5GRL
         lTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x2tfNJJ7zvk5t2UFdzL7uNJCGv9rRgs1ExdTc2XZh9U=;
        b=x74qU254n30Bsebps1jsKEvzaSA9z2ukV0x0UqOHjWr6QOCcR3GlFcxbh/LhIK6WRM
         qdW1tUpL3TLkHty7lXpSsBn0a6KFDrL1EYscJTIMSI/XDDWZUZgsbCSCzef4916uxqmQ
         4RBXQWJin5R8OQX/bVGKBc/3VPQ4DmM9aujECxtJSDp1Q275OJYdDVhx2P4zwCVIgLaR
         WqGLlDqU1fdoKLcd24MSixW7SJQ9I32l7ESTpJyNGfLQNDo3KkqZCuBLZdPS0ABjc9Zc
         cQvErxLIiY/v/ttt44c0wpyyzxYSne/HuZlZTNfim9TmpZceJJwUvlUrnIIbb9TIDXOn
         r4HQ==
X-Gm-Message-State: AOAM533aqHgv3s/5oSzCp8D2KJUv90FS6ONYVlvu+4bGUN+4XqdJ/fDr
        KL4nTAZj0b5FJz3axqEy/BE=
X-Google-Smtp-Source: ABdhPJzx4tI+mCCSK+NG5AFusHNVdENss/6rZpTI+zjsZ5SvXww7P7xynhM8elMWOFDfB8sN136FlA==
X-Received: by 2002:a05:622a:148b:b0:2f1:fb24:5bcb with SMTP id t11-20020a05622a148b00b002f1fb245bcbmr24425756qtx.64.1651182545613;
        Thu, 28 Apr 2022 14:49:05 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id bl5-20020a05620a1a8500b0069f51e47c5esm546442qkb.110.2022.04.28.14.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 14:49:05 -0700 (PDT)
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
Subject: [PATCH v2 15/15] ARM: imxrt_defconfig: Add i.MXRT1170
Date:   Thu, 28 Apr 2022 17:48:38 -0400
Message-Id: <20220428214838.1040278-16-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428214838.1040278-1-Mr.Bossman075@gmail.com>
References: <20220428214838.1040278-1-Mr.Bossman075@gmail.com>
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
2.35.1

