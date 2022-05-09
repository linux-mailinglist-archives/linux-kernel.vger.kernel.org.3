Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9331151FEC6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236438AbiEINwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbiEINwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:52:36 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DA81C964E
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 06:48:42 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:8886:2b92:63eb:2922])
        by michel.telenet-ops.be with bizsmtp
        id Udob2700B0moLbn06dob56; Mon, 09 May 2022 15:48:40 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1no3kZ-003Xmr-3S; Mon, 09 May 2022 15:48:35 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1no3kY-003NFe-HA; Mon, 09 May 2022 15:48:34 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Roger Quadros <rogerq@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] memory: OMAP_GPMC should depend on ARCH_OMAP2PLUS || ARCH_K3
Date:   Mon,  9 May 2022 15:48:33 +0200
Message-Id: <2b7d411b4a7913335082c858cb0d63b9e4bf7c5b.1652103920.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Texas Instruments OMAP General Purpose Memory Controller (GPMC) is
only present on TI OMAP2/3/4/5, AM33xx, AM43x, DRA7xx, TI81xx, and K3
SoCs.  Hence add a dependency on ARCH_OMAP2PLUS || ARCH_K3, to prevent
asking the user about this driver when configuring a kernel without
OMAP2+ or K3 SoC family support.

Fixes: be34f45f0d4aa91c ("memory: omap-gpmc: Make OMAP_GPMC config visible and selectable")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/memory/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index b7800b37af78a996..f00757912e2e4c1e 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -105,6 +105,7 @@ config TI_EMIF
 config OMAP_GPMC
 	tristate "Texas Instruments OMAP SoC GPMC driver"
 	depends on OF_ADDRESS
+	depends on ARCH_OMAP2PLUS || ARCH_K3 || COMPILE_TEST
 	select GPIOLIB
 	help
 	  This driver is for the General Purpose Memory Controller (GPMC)
-- 
2.25.1

