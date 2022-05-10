Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E4E5210E0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238844AbiEJJdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238795AbiEJJdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:33:18 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4749F28C9F4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 02:29:18 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:8886:2b92:63eb:2922])
        by xavier.telenet-ops.be with bizsmtp
        id UxVG270050moLbn01xVGyi; Tue, 10 May 2022 11:29:16 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1noMB9-003cdn-MW; Tue, 10 May 2022 11:29:15 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1noMB8-0046l4-RN; Tue, 10 May 2022 11:29:14 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Roger Quadros <rogerq@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] memory: OMAP_GPMC should depend on ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3
Date:   Tue, 10 May 2022 11:29:13 +0200
Message-Id: <f6780f572f882ed6ab5934321942cf2b412bf8d1.1652174849.git.geert+renesas@glider.be>
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
only present on TI OMAP2/3/4/5, Keystone, AM33xx, AM43x, DRA7xx, TI81xx,
and K3 SoCs.  Hence add a dependency on ARCH_OMAP2PLUS || ARCH_KEYSTONE
|| ARCH_K3, to prevent asking the user about this driver when
configuring a kernel without OMAP2+, Keystone, or K3 SoC family support.

Fixes: be34f45f0d4aa91c ("memory: omap-gpmc: Make OMAP_GPMC config visible and selectable")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Add ARCH_KEYSTONE, as requested by Roger Quadros.
---
 drivers/memory/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index b7800b37af78a996..ac1a411648d8656f 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -105,6 +105,7 @@ config TI_EMIF
 config OMAP_GPMC
 	tristate "Texas Instruments OMAP SoC GPMC driver"
 	depends on OF_ADDRESS
+	depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
 	select GPIOLIB
 	help
 	  This driver is for the General Purpose Memory Controller (GPMC)
-- 
2.25.1

