Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F524FA1E3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 05:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbiDIDHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 23:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiDIDHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 23:07:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3925DF3E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 20:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=zj+6qY9oD0Jri3Uj9KIZMW6MqyKShipi14GhcbjvaE8=; b=o2/XIYlk3asS/ckD2dNmjhUPND
        3xNzThDxnWPEFAkJRvgi636lpHD8HMjlokS4wWxZWx5vREQDgA9Bm2C64Zm1CCHjDkani/p6W5qDn
        22r2PmQnAPJ53emP5Ydnug/209GDoMO4d1wa41erdZ+vLKLX8OObtUYbcFPAbRLhxmNaeuyQujfqW
        I++0pTk1h5ZUbqtm/gpdqgyVInPrc7eVpxNGeWtUdeVWTC34iHGEnC3obMWe7ak9/4EcHA0GGSGdC
        DIvn3BI2fArB4ZJHvE2hfOqqkd6OrN9Qk5E4DPQ7Ur59DfeB2TjFbAp6wv9WAaZbCkULcDfXQ874T
        ZnZ4VxlA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nd1PN-001nKr-Il; Sat, 09 Apr 2022 03:05:05 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        John Stultz <john.stultz@linaro.org>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/hisilicon/hibmc: add back depends on MMU
Date:   Fri,  8 Apr 2022 20:05:04 -0700
Message-Id: <20220409030504.16089-1-rdunlap@infradead.org>
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

ARM64 always has CONFIG_MMU=y but adding a dependency on
COMPILE_TEST allows an arch with MMU optional (riscv in this case)
to build the hibmc driver, leading to a kconfig warning and
build errors, so restore the MMU dependency.

WARNING: unmet direct dependencies detected for DRM_TTM
  Depends on [n]: HAS_IOMEM [=y] && DRM [=y] && MMU [=n]
  Selected by [y]:
  - DRM_TTM_HELPER [=y] && HAS_IOMEM [=y] && DRM [=y]
  - DRM_HISI_HIBMC [=y] && HAS_IOMEM [=y] && DRM [=y] && PCI [=y] && (ARM64 || COMPILE_TEST [=y])

riscv64-linux-ld: drivers/gpu/drm/ttm/ttm_bo_vm.o: in function `.L97':
ttm_bo_vm.c:(.text+0x814): undefined reference to `vmf_insert_pfn_prot'
riscv64-linux-ld: drivers/gpu/drm/ttm/ttm_bo_vm.o: in function `.L0 ':
ttm_bo_vm.c:(.text+0x9d0): undefined reference to `vmf_insert_pfn_prot'

Fixes: a0f25a6bb319 ("drm/hisilicon/hibmc: Allow to be built if COMPILE_TEST is enabled")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Xinliang Liu <xinliang.liu@linaro.org>
Cc: Tian Tao  <tiantao6@hisilicon.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Chen Feng <puck.chen@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/hisilicon/hibmc/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/hisilicon/hibmc/Kconfig
+++ b/drivers/gpu/drm/hisilicon/hibmc/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config DRM_HISI_HIBMC
 	tristate "DRM Support for Hisilicon Hibmc"
-	depends on DRM && PCI && (ARM64 || COMPILE_TEST)
+	depends on DRM && PCI && MMU && (ARM64 || COMPILE_TEST)
 	select DRM_KMS_HELPER
 	select DRM_VRAM_HELPER
 	select DRM_TTM
