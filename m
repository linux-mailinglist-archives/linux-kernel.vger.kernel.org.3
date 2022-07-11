Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D983A56FF8E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 12:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiGKKyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 06:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiGKKyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 06:54:04 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D502B79D8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:00:07 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id tm022700o4C55Sk06m02yF; Mon, 11 Jul 2022 12:00:03 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oAqCw-0032if-As; Mon, 11 Jul 2022 12:00:02 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oApI8-0054vV-Tl; Mon, 11 Jul 2022 11:01:20 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] drm: mxsfb: DRM_IMX_LCDIF should depend on ARCH_MXC
Date:   Mon, 11 Jul 2022 11:01:19 +0200
Message-Id: <5689170a22b3e2a76f0989dd3993a2b132ade8b6.1657530040.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <379f49058c7455802302c42bfbf615aaf3400f2c.1657530040.git.geert+renesas@glider.be>
References: <379f49058c7455802302c42bfbf615aaf3400f2c.1657530040.git.geert+renesas@glider.be>
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

The Freescale/NXP i.MX LCDIFv3 LCD controller is only present on
Freescale/NXP i.MX SoCs.  Hence add a dependency on ARCH_MXC, to prevent
asking the user about this driver when configuring a kernel without
Freescale/NXP i.MX support.

Fixes: 9db35bb349a0ef32 ("drm: lcdif: Add support for i.MX8MP LCDIF variant")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpu/drm/mxsfb/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mxsfb/Kconfig b/drivers/gpu/drm/mxsfb/Kconfig
index 02cf19fcef315724..40cc9b8fb749f3e4 100644
--- a/drivers/gpu/drm/mxsfb/Kconfig
+++ b/drivers/gpu/drm/mxsfb/Kconfig
@@ -25,6 +25,7 @@ config DRM_IMX_LCDIF
 	tristate "i.MX LCDIFv3 LCD controller"
 	depends on DRM && OF
 	depends on COMMON_CLK
+	depends on ARCH_MXC || COMPILE_TEST
 	select DRM_MXS
 	select DRM_KMS_HELPER
 	select DRM_GEM_CMA_HELPER
-- 
2.25.1

