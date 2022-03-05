Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511364CE350
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 07:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiCEGl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 01:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiCEGl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 01:41:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5367250B29;
        Fri,  4 Mar 2022 22:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=psSImPzcv9vs6P1Eab/fDILx3bBTdtdrLoclhcr6SFw=; b=Rl+eO7j+hOA3cHBnij6MaHLB2I
        Payn71csVxJx7uC44Xr910c/PN5eNPH5IZAG7ShCASpjgOM4fQv5ddXU9+OuUFKhG/y2AtVWMxZL7
        vLA5hz5tsvGGfjFt3pvzdM0l20XtC8Aie1whDPzBuxI5yOPhn+qnHwNUj6x2mbrIoOM7A+nh9Tp/a
        KkGhbop9dTPRY77DFW0TrbnHqzeZWFUHv0Bj80FLmdtY4NxbzV4f5jlT6AddsXNSMmuY0rgQTEb1W
        qchdZkZMTCZFh4VLWP1RoJMib6sxICUKZpU09L5x1DauY2eA/lJfKcsBTCaIxJHHm/9DYN9mZD7KL
        w7MKJa+Q==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQO5l-00Crh4-Ij; Sat, 05 Mar 2022 06:40:37 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Angelo Dureghello <angelo@sysam.it>,
        Greg Ungerer <gerg@kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, uclinux-dev@uclinux.org
Subject: [PATCH v3] m68k: coldfire/device.c: only build for MCF_EDMA when h/w macros are defined
Date:   Fri,  4 Mar 2022 22:40:36 -0800
Message-Id: <20220305064036.4879-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
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

When CONFIG_MCF_EDMA is set (due to COMPILE_TEST, not due to
CONFIG_M5441x), coldfire/device.c has compile errors due to
missing MCFEDMA_* symbols. In the .config file that was provided,
CONFIG_M5206=y, not CONFIG_M5441x, so <asm/m5441xsim.h> is not
included in coldfire/device.c.

Only build the MCF_EDMA code in coldfire/device.c if the MCFEDMA_*
hardware macros are defined.

Fixes these build errors:

../arch/m68k/coldfire/device.c:512:35: error: 'MCFEDMA_BASE' undeclared here (not in a function); did you mean 'MCFDMA_BASE1'?
  512 |                 .start          = MCFEDMA_BASE,
../arch/m68k/coldfire/device.c:513:50: error: 'MCFEDMA_SIZE' undeclared here (not in a function)
  513 |                 .end            = MCFEDMA_BASE + MCFEDMA_SIZE - 1,
../arch/m68k/coldfire/device.c:517:35: error: 'MCFEDMA_IRQ_INTR0' undeclared here (not in a function)
  517 |                 .start          = MCFEDMA_IRQ_INTR0,
../arch/m68k/coldfire/device.c:523:35: error: 'MCFEDMA_IRQ_INTR16' undeclared here (not in a function)
  523 |                 .start          = MCFEDMA_IRQ_INTR16,
../arch/m68k/coldfire/device.c:529:35: error: 'MCFEDMA_IRQ_INTR56' undeclared here (not in a function)
  529 |                 .start          = MCFEDMA_IRQ_INTR56,
../arch/m68k/coldfire/device.c:535:35: error: 'MCFEDMA_IRQ_ERR' undeclared here (not in a function)
  535 |                 .start          = MCFEDMA_IRQ_ERR,

Fixes: d7e9d01ac292 ("m68k: add ColdFire mcf5441x eDMA platform support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: lore.kernel.org/r/202203030252.P752DK46-lkp@intel.com
Cc: Angelo Dureghello <angelo@sysam.it>
Cc: Greg Ungerer <gerg@kernel.org>
Cc: Greg Ungerer <gerg@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
Cc: uclinux-dev@uclinux.org
---
v2: only build when the hardware macros are defined (suggested by Geert)
v3: complete the Subject.

 arch/m68k/coldfire/device.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20220303.orig/arch/m68k/coldfire/device.c
+++ linux-next-20220303/arch/m68k/coldfire/device.c
@@ -480,7 +480,7 @@ static struct platform_device mcf_i2c5 =
 #endif /* MCFI2C_BASE5 */
 #endif /* IS_ENABLED(CONFIG_I2C_IMX) */
 
-#if IS_ENABLED(CONFIG_MCF_EDMA)
+#ifdef MCFEDMA_BASE
 
 static const struct dma_slave_map mcf_edma_map[] = {
 	{ "dreq0", "rx-tx", MCF_EDMA_FILTER_PARAM(0) },
@@ -552,7 +552,7 @@ static struct platform_device mcf_edma =
 		.platform_data = &mcf_edma_data,
 	}
 };
-#endif /* IS_ENABLED(CONFIG_MCF_EDMA) */
+#endif /* MCFEDMA_BASE */
 
 #ifdef MCFSDHC_BASE
 static struct mcf_esdhc_platform_data mcf_esdhc_data = {
@@ -651,7 +651,7 @@ static struct platform_device *mcf_devic
 	&mcf_i2c5,
 #endif
 #endif
-#if IS_ENABLED(CONFIG_MCF_EDMA)
+#ifdef MCFEDMA_BASE
 	&mcf_edma,
 #endif
 #ifdef MCFSDHC_BASE
