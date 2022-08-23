Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8C159CD46
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 02:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238714AbiHWAmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 20:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbiHWAmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 20:42:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B354CA2D
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 17:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=OcnI4ebpnDu4G7YIVsCFew6u/5qBEhwNnUgkxxm55uc=; b=akCEHY61svxxMsDCCHNRmm8aVy
        ryA+6uUW4tYbeC25Y8VCRvhYMIhO5nItSq8O/1ldsTRuRPyTGUqNvx5BXhPYQfUOmvK1Cu7pEtjoJ
        4UssVcm3JY5kdlcoayCZmQCIyMbk8Zp6ALJkpChNQd6jS//sHMrBi/86I2WN3mysq5ze41P9cKxPu
        rwzlPIC8P+aARtrqtbQv7KvNcptSOdHsH1R1zcxKKj+0M13crjr5S739zRASwynttMPHUxZ3aMzrl
        PDZo3QSkXVJ0bBiNFwxpTbs1JR8ViNgl+azGSqwkx8PMTiDXgfE5Xym6hScXdi7lneg/Uy4CpwHQJ
        pFPnX9qw==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQI0H-00Eo70-Cq; Tue, 23 Aug 2022 00:42:49 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 2/2] drm: fix drm_mipi_dbi build errors
Date:   Mon, 22 Aug 2022 17:42:43 -0700
Message-Id: <20220823004243.11596-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

drm_mipi_dbi needs lots of DRM_KMS_HELPER support, so select
that Kconfig symbol like it is done is most other uses, and
the way that it was before MIPS_DBI was moved from tinydrm
to its core location.

Fixes these build errors:

ld: drivers/gpu/drm/drm_mipi_dbi.o: in function `mipi_dbi_buf_copy':
drivers/gpu/drm/drm_mipi_dbi.c:205: undefined reference to `drm_gem_fb_get_obj'
ld: drivers/gpu/drm/drm_mipi_dbi.c:211: undefined reference to `drm_gem_fb_begin_cpu_access'
ld: drivers/gpu/drm/drm_mipi_dbi.c:215: undefined reference to `drm_gem_fb_vmap'
ld: drivers/gpu/drm/drm_mipi_dbi.c:222: undefined reference to `drm_fb_swab'
ld: drivers/gpu/drm/drm_mipi_dbi.c:224: undefined reference to `drm_fb_memcpy'
ld: drivers/gpu/drm/drm_mipi_dbi.c:227: undefined reference to `drm_fb_xrgb8888_to_rgb565'
ld: drivers/gpu/drm/drm_mipi_dbi.c:235: undefined reference to `drm_gem_fb_vunmap'
ld: drivers/gpu/drm/drm_mipi_dbi.c:237: undefined reference to `drm_gem_fb_end_cpu_access'
ld: drivers/gpu/drm/drm_mipi_dbi.o: in function `mipi_dbi_dev_init_with_formats':
ld: drivers/gpu/drm/drm_mipi_dbi.o:/X64/../drivers/gpu/drm/drm_mipi_dbi.c:469: undefined reference to `drm_gem_fb_create_with_dirty'

Fixes: 174102f4de23 ("drm/tinydrm: Move mipi-dbi")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Dillon Min <dillon.minfei@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Noralf Trønnes <noralf@tronnes.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -31,6 +31,7 @@ menuconfig DRM
 config DRM_MIPI_DBI
 	tristate
 	depends on DRM
+	select DRM_KMS_HELPER
 
 config DRM_MIPI_DSI
 	bool
