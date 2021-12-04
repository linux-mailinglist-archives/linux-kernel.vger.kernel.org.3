Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4AD4686C3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 18:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385359AbhLDRuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 12:50:19 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46632 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355448AbhLDRuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 12:50:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BDAE60E84
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 17:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC333C341C2;
        Sat,  4 Dec 2021 17:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638640012;
        bh=m53DYrzONUqXySnuyI8Iv8xHXEMmcTWjOknPMtQWpbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rC7Zy9oKyV5tet0TB29vkn49q0Ijv3HDdkSoK40B0JTRJvQO1WfXJgismeFAJGFRD
         wKn32hfbg+EMbHeOgQ7V3FgZA1aiGIkS2sGYzDlOE6NPJenvuASa5VD7Y8E85+Gp3x
         k4p2Eru1hUBJkF3YD1MOwhSYjJKFqNad0GDEjjlZQIQJ4+gwRPJ6MO3oc+zcWiqPGp
         6YzacJ9jFjVb2s/W0R+wdcaymfnflDIyEu9Kn41L5y7SEVX0+GsHZi8a0vE+Tl4f/0
         9UlQ+KHAOi0XeAWAWX8O209zBA6Si2l9X+RFsnf/mi81NbgeFYbOP+HDcVChZuvGir
         dAv1HFpi7txug==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Joel Stanley <joel@jms.id.au>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm: aspeed: select CONFIG_DRM_GEM_CMA_HELPER
Date:   Sat,  4 Dec 2021 18:46:23 +0100
Message-Id: <20211204174637.1160725-2-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211204174637.1160725-1-arnd@kernel.org>
References: <20211204174637.1160725-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The aspeed driver uses the gem_cma_helper code, but does
noto enforce enabling this through Kconfig:

x86_64-linux-ld: drivers/gpu/drm/aspeed/aspeed_gfx_drv.o:(.rodata+0x2c8): undefined reference to `drm_gem_cma_prime_import_sg_table'
x86_64-linux-ld: drivers/gpu/drm/aspeed/aspeed_gfx_drv.o:(.rodata+0x2d8): undefined reference to `drm_gem_cma_dumb_create'
x86_64-linux-ld: drivers/gpu/drm/aspeed/aspeed_gfx_crtc.o: in function `aspeed_gfx_pipe_update':
aspeed_gfx_crtc.c:(.text+0xe5): undefined reference to `drm_fb_cma_get_gem_obj'

Add the same 'select' that is used in other such drivers.

Fixes: 09717af7d13d ("drm: Remove CONFIG_DRM_KMS_CMA_HELPER option")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/aspeed/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/aspeed/Kconfig b/drivers/gpu/drm/aspeed/Kconfig
index 36c4a7e86981..024ccab14f88 100644
--- a/drivers/gpu/drm/aspeed/Kconfig
+++ b/drivers/gpu/drm/aspeed/Kconfig
@@ -5,6 +5,7 @@ config DRM_ASPEED_GFX
 	depends on (COMPILE_TEST || ARCH_ASPEED)
 	depends on MMU
 	select DRM_KMS_HELPER
+	select DRM_GEM_CMA_HELPER
 	select DMA_CMA if HAVE_DMA_CONTIGUOUS
 	select CMA if HAVE_DMA_CONTIGUOUS
 	select MFD_SYSCON
-- 
2.29.2

