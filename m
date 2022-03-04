Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9AE4CCC52
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 04:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbiCDDg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 22:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235245AbiCDDgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 22:36:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432D811B5CC;
        Thu,  3 Mar 2022 19:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=a2JRiPymeaevTl2okq3HY2SPEajWajmTc73gK4oUt4s=; b=mE5NHe6dOwMMWMMOI/r9EQPC9W
        71OGhoXbzejqd/1x54WIMz7mjhmvQvbLIM4XfWq8PgdUK82NMb7E4jafTgdcx1jEBqaskPwY9YTWT
        9vt0J7SAsH0H1NLlBylUnkFEOTgsW1Y2U8SxWoUcJffuIEQ5GVt5dxiWKVOOPc5kmW1q0MdUPXNSf
        LtekS7MCDQhDl1O4yCl91xu2RLj2kunUjXEpXBXhRvdXnt6I0+vvtVGJxMjGCM5lo3mUv/AJtxy8l
        OFQEu7RZNjvtrGEAp81rHRDWjSJeb57EaQ5MktxTZbTuSfVm34LjfGggJmvJWk/3YemxWULAbCS+d
        457UJG4w==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPyj6-008Qqe-OE; Fri, 04 Mar 2022 03:35:32 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Angelo Dureghello <angelo@sysam.it>,
        Greg Ungerer <gerg@kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, uclinux-dev@uclinux.org
Subject: [PATCH] m68k: tweak coldfire/device.c for COMPILE_TEST
Date:   Thu,  3 Mar 2022 19:35:31 -0800
Message-Id: <20220304033531.28667-1-rdunlap@infradead.org>
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

Only build the MCF_EDMA code in coldfire/device.c if both MCF_EDMA
and M5441x are enabled.

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
 arch/m68k/coldfire/device.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20220303.orig/arch/m68k/coldfire/device.c
+++ linux-next-20220303/arch/m68k/coldfire/device.c
@@ -480,7 +480,7 @@ static struct platform_device mcf_i2c5 =
 #endif /* MCFI2C_BASE5 */
 #endif /* IS_ENABLED(CONFIG_I2C_IMX) */
 
-#if IS_ENABLED(CONFIG_MCF_EDMA)
+#if IS_ENABLED(CONFIG_MCF_EDMA) && IS_ENABLED(CONFIG_M5441x)
 
 static const struct dma_slave_map mcf_edma_map[] = {
 	{ "dreq0", "rx-tx", MCF_EDMA_FILTER_PARAM(0) },
@@ -552,7 +552,7 @@ static struct platform_device mcf_edma =
 		.platform_data = &mcf_edma_data,
 	}
 };
-#endif /* IS_ENABLED(CONFIG_MCF_EDMA) */
+#endif /* IS_ENABLED(CONFIG_MCF_EDMA) && IS_ENABLED(CONFIG_M5441x) */
 
 #ifdef MCFSDHC_BASE
 static struct mcf_esdhc_platform_data mcf_esdhc_data = {
@@ -651,7 +651,7 @@ static struct platform_device *mcf_devic
 	&mcf_i2c5,
 #endif
 #endif
-#if IS_ENABLED(CONFIG_MCF_EDMA)
+#if IS_ENABLED(CONFIG_MCF_EDMA) && IS_ENABLED(CONFIG_M5441x)
 	&mcf_edma,
 #endif
 #ifdef MCFSDHC_BASE
