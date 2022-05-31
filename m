Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEEF5389E2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 04:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243548AbiEaCRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 22:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbiEaCR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 22:17:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A46163BE8;
        Mon, 30 May 2022 19:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=cZUqmeJtYaU0Pqny7S69e3JuJrm04akOK2P4y4OgcwE=; b=KTJFqrY68DyuaDw7XIfCJ8VDvb
        ZeMfOdBkH74O6PPoKFTVEJHvd7l9Mcr+F/Lrjpj7BmmXo9Ai7PHyMCtNb4zHe4coDHxX0/F4cMj6M
        bGoR9SUNy+azShmvFGVuroQChJfMegkGXWcRl/aH7+lh4oKpVfcI96UPxfBqFGjT4GDSJxOkb5PYL
        3YS04a4Z5M2Zcj+pS54GlyBr6A9SG9Q44016A/pWHFsex5rjaaTnboTSJv/8lAY+hhaQZAZEdwBbk
        yqBce6yzH+2gAy3c+LGA3oRtBZgiVkHiRHrbUSNrQhBth7/bzsc5xt1LS9/QgdfX3cSRfblKwkbQ1
        eNCdg0Lg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvrRe-004xy5-22; Tue, 31 May 2022 02:17:18 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, uclinux-dev@uclinux.org,
        Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH] m68k: coldfire/device.c: protect FLEXCAN blocks
Date:   Mon, 30 May 2022 19:17:12 -0700
Message-Id: <20220531021712.6050-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CAN_FLEXCAN=y and M5441x is not set/enabled, there are build
errors in coldfire/device.c:

../arch/m68k/coldfire/device.c:595:26: error: 'MCFFLEXCAN_BASE0' undeclared here (not in a function); did you mean 'MCFDMA_BASE0'?
  595 |                 .start = MCFFLEXCAN_BASE0,
../arch/m68k/coldfire/device.c:596:43: error: 'MCFFLEXCAN_SIZE' undeclared here (not in a function)
  596 |                 .end = MCFFLEXCAN_BASE0 + MCFFLEXCAN_SIZE,
../arch/m68k/coldfire/device.c:600:26: error: 'MCF_IRQ_IFL0' undeclared here (not in a function); did you mean 'MCF_IRQ_I2C0'?
  600 |                 .start = MCF_IRQ_IFL0,
../arch/m68k/coldfire/device.c:605:26: error: 'MCF_IRQ_BOFF0' undeclared here (not in a function); did you mean 'MCF_IRQ_I2C0'?
  605 |                 .start = MCF_IRQ_BOFF0,
../arch/m68k/coldfire/device.c:610:26: error: 'MCF_IRQ_ERR0' undeclared here (not in a function); did you mean 'MCF_IRQ_I2C0'?
  610 |                 .start = MCF_IRQ_ERR0,

Protect the FLEXCAN code blocks by checking if MCFFLEXCAN_SIZE
is defined.

Fixes: 35a9f9363a89 ("m68k: m5441x: add flexcan support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Greg Ungerer <gerg@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
Cc: uclinux-dev@uclinux.org
Cc: Angelo Dureghello <angelo@kernel-space.org>
---
 arch/m68k/coldfire/device.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/m68k/coldfire/device.c
+++ b/arch/m68k/coldfire/device.c
@@ -581,7 +581,7 @@ static struct platform_device mcf_esdhc
 };
 #endif /* MCFSDHC_BASE */
 
-#if IS_ENABLED(CONFIG_CAN_FLEXCAN)
+#ifdef MCFFLEXCAN_SIZE
 
 #include <linux/can/platform/flexcan.h>
 
@@ -620,7 +620,7 @@ static struct platform_device mcf_flexca
 	.resource = mcf5441x_flexcan0_resource,
 	.dev.platform_data = &mcf5441x_flexcan_info,
 };
-#endif /* IS_ENABLED(CONFIG_CAN_FLEXCAN) */
+#endif /* MCFFLEXCAN_SIZE */
 
 static struct platform_device *mcf_devices[] __initdata = {
 	&mcf_uart,
@@ -657,7 +657,7 @@ static struct platform_device *mcf_devic
 #ifdef MCFSDHC_BASE
 	&mcf_esdhc,
 #endif
-#if IS_ENABLED(CONFIG_CAN_FLEXCAN)
+#ifdef MCFFLEXCAN_SIZE
 	&mcf_flexcan0,
 #endif
 };
