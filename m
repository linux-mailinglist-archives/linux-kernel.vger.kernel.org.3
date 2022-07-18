Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC5657896C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 20:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbiGRST1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 14:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbiGRSTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:19:21 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F21085FF0;
        Mon, 18 Jul 2022 11:19:20 -0700 (PDT)
Received: from NTHCCAS04.nuvoton.com (NTHCCAS04.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id 422B71C811CC;
        Tue, 19 Jul 2022 02:19:20 +0800 (CST)
Received: from NTHCCAS03.nuvoton.com (10.1.20.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 19
 Jul 2022 02:19:20 +0800
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCCAS03.nuvoton.com
 (10.1.20.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1847.3; Tue, 19 Jul
 2022 02:19:19 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS04.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Tue, 19 Jul 2022 02:19:19 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id EDAA063A20; Mon, 18 Jul 2022 21:19:18 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <gregkh@linuxfoundation.org>,
        <stern@rowland.harvard.edu>, <tony@atomide.com>,
        <felipe.balbi@linux.intel.com>, <jgross@suse.com>,
        <lukas.bulwahn@gmail.com>, <arnd@arndb.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <openbmc@lists.ozlabs.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v2 3/3] USB: host: npcm: Add NPCM8XX support
Date:   Mon, 18 Jul 2022 21:18:42 +0300
Message-ID: <20220718181842.61040-4-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220718181842.61040-1-tmaimon77@gmail.com>
References: <20220718181842.61040-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify NPCM USB EHCI host controller configuration to support all NPCM
BMC SoC.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/usb/host/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 682b3d2da623..bcd595e30811 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -205,12 +205,12 @@ config USB_EHCI_FSL
 	  Variation of ARC USB block used in some Freescale chips.
 
 config USB_EHCI_HCD_NPCM7XX
-	tristate "Support for Nuvoton NPCM7XX on-chip EHCI USB controller"
-	depends on (USB_EHCI_HCD && ARCH_NPCM7XX) || COMPILE_TEST
-	default y if (USB_EHCI_HCD && ARCH_NPCM7XX)
+	tristate "Support for Nuvoton NPCM on-chip EHCI USB controller"
+	depends on (USB_EHCI_HCD && ARCH_NPCM) || COMPILE_TEST
+	default y if (USB_EHCI_HCD && ARCH_NPCM)
 	help
 	  Enables support for the on-chip EHCI controller on
-	  Nuvoton NPCM7XX chips.
+	  Nuvoton NPCM chips.
 
 config USB_EHCI_HCD_OMAP
 	tristate "EHCI support for OMAP3 and later chips"
-- 
2.33.0

