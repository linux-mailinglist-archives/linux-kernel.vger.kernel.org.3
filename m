Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7A757B9A6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbiGTPbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiGTPbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:31:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1CAA5F99C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658331096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5rGNZ6AjrPiUeagfQcQM9gVNh8yDULt+VyoYmJxgGjw=;
        b=gKS6YNxFn/kNULJKBVi+hGck5NA8M+EZbXphfFTODXw1qRcn+y+YP8mc9pAwo5sFSOAfzZ
        0Q2po5pzqUPBqNbo4lc2b6Tk25E3FjPH9iALgmlGoXTmIuWhLpnTbA+myjgYi+wd/rvmsu
        /ilIjtsbu21V6yAM5DqjFhjuw+oHYKk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-262-Sa8MjyAUO3ewaXP7G7C7aQ-1; Wed, 20 Jul 2022 11:31:33 -0400
X-MC-Unique: Sa8MjyAUO3ewaXP7G7C7aQ-1
Received: by mail-ed1-f72.google.com with SMTP id b15-20020a056402278f00b0043acaf76f8dso12470405ede.21
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5rGNZ6AjrPiUeagfQcQM9gVNh8yDULt+VyoYmJxgGjw=;
        b=B992EUVoB4HNqZwBkg93ZhW7zCThNwCGuN8c+GL8Nb6H+M4+71UoxmYcXuEzcMwLyy
         jT6yhN8H5VaUyzaywG6JPzSIdZhkEsle92SeifvLlomC57nP1oc1qBT2BptOJHVNehi4
         8NUUmhZegrk24McVF5swP2Nc/axpZyT6O4kZsWGKNMnyxMKb8mJg57bDdUVbuSE5F4Xb
         6836DktmV3GY6lfsbOIofWgHJyupd0S+aVIRVwKAcjovuLGqf4a4a1X6uBuFjmmuQ+wd
         O7VqimGNriVhzGLsiSFjwU8Sb6wc/60c1qUGKcPKW9bNv6UdSPGl/z7GNyZDl+cmkjZy
         ACQQ==
X-Gm-Message-State: AJIora92/pnp9/9oBdSaEcn+DP2FO/81JuyDhTdUYi5qKhIx8OpyB2In
        W5QSZP9QQplZ6e9hVNTCk1YnbxoOml9VRTgIMyTN+nplPHTMCSRanWxcJOTER7Ojx+eV4m5qq7M
        sIYvxStdnNsE4e54ljsC9PoR+
X-Received: by 2002:a17:907:7ea6:b0:72b:4afb:e8b with SMTP id qb38-20020a1709077ea600b0072b4afb0e8bmr36524038ejc.205.1658331091881;
        Wed, 20 Jul 2022 08:31:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ttttURrpXNNJPMp+zevpfYONsMqWCHqsBWAPebWECToR5rJUIAtCmD26T53xfsFkZXGDbqKQ==
X-Received: by 2002:a17:907:7ea6:b0:72b:4afb:e8b with SMTP id qb38-20020a1709077ea600b0072b4afb0e8bmr36524027ejc.205.1658331091674;
        Wed, 20 Jul 2022 08:31:31 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id t6-20020aa7d706000000b0043a85d7d15esm12366756edq.12.2022.07.20.08.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 08:31:31 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, tzimmermann@suse.de, mripard@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v5 0/4] drm: rename CMA helpers to DMA helpers
Date:   Wed, 20 Jul 2022 17:31:24 +0200
Message-Id: <20220720153128.526876-1-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series renames all CMA helpers to DMA helpers - considering the
hierarchy of APIs (mm/cma -> dma -> gem/fb dma helpers) calling them DMA
helpers seems to be more applicable.

Additionally, commit e57924d4ae80 ("drm/doc: Task to rename CMA helpers")
requests to rename the CMA helpers and implies that people seem to be confused
about the naming.

The patches are compile-time tested building a x86_64 kernel with
`make allyesconfig && make drivers/gpu/drm`.

Changes in v2:
  - Fixed up comments for consistent memory/address classification
    (DMA-contiguous)
  - Added a patch to rename struct drm_gem_dma_object.{paddr => dma_addr}

Changes in v3:
  - Use a ccoccinelle script for 
    "drm/gem: rename struct drm_gem_dma_object.{paddr => dma_addr}" for fixing
    up missing drivers and compile-test on x86_64, arm and arm64.

Changes in v4:
  - Rebased all patches on drm-misc/drm-misc-next.

Changes in v5:
  - Rebase of v4, meanwhile some merge conflicts came up on
    drm-misc/drm-misc-next.

Danilo Krummrich (4):
  drm/fb: rename FB CMA helpers to FB DMA helpers
  drm/gem: rename GEM CMA helpers to GEM DMA helpers
  drm/gem: rename struct drm_gem_dma_object.{paddr => dma_addr}
  drm/todo: remove task to rename CMA helpers

 Documentation/gpu/drm-kms-helpers.rst         |   8 +-
 Documentation/gpu/drm-mm.rst                  |  16 +-
 Documentation/gpu/todo.rst                    |  13 -
 drivers/gpu/drm/Kconfig                       |   4 +-
 drivers/gpu/drm/Makefile                      |   6 +-
 drivers/gpu/drm/arm/Kconfig                   |   4 +-
 drivers/gpu/drm/arm/display/Kconfig           |   2 +-
 .../arm/display/komeda/komeda_framebuffer.c   |  12 +-
 .../gpu/drm/arm/display/komeda/komeda_kms.c   |  10 +-
 drivers/gpu/drm/arm/hdlcd_crtc.c              |   6 +-
 drivers/gpu/drm/arm/hdlcd_drv.c               |   8 +-
 drivers/gpu/drm/arm/malidp_drv.c              |  10 +-
 drivers/gpu/drm/arm/malidp_mw.c               |   8 +-
 drivers/gpu/drm/arm/malidp_planes.c           |  34 +-
 drivers/gpu/drm/armada/armada_gem.c           |   6 +-
 drivers/gpu/drm/aspeed/Kconfig                |   2 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c      |  10 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c       |   8 +-
 drivers/gpu/drm/atmel-hlcdc/Kconfig           |   2 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  |   6 +-
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   |   8 +-
 ...rm_fb_cma_helper.c => drm_fb_dma_helper.c} |  67 ++--
 drivers/gpu/drm/drm_file.c                    |   2 +-
 drivers/gpu/drm/drm_format_helper.c           |   4 +-
 ..._gem_cma_helper.c => drm_gem_dma_helper.c} | 302 +++++++++---------
 drivers/gpu/drm/drm_mipi_dbi.c                |   2 +-
 drivers/gpu/drm/fsl-dcu/Kconfig               |   2 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c     |   8 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c     |   2 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c   |  10 +-
 drivers/gpu/drm/hisilicon/kirin/Kconfig       |   2 +-
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   |  14 +-
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   |   4 +-
 drivers/gpu/drm/imx/Kconfig                   |   2 +-
 drivers/gpu/drm/imx/dcss/Kconfig              |   2 +-
 drivers/gpu/drm/imx/dcss/dcss-kms.c           |   6 +-
 drivers/gpu/drm/imx/dcss/dcss-plane.c         |  18 +-
 drivers/gpu/drm/imx/imx-drm-core.c            |  10 +-
 drivers/gpu/drm/imx/imx-drm.h                 |   2 +-
 drivers/gpu/drm/imx/ipuv3-crtc.c              |   4 +-
 drivers/gpu/drm/imx/ipuv3-plane.c             |  28 +-
 drivers/gpu/drm/ingenic/Kconfig               |   2 +-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c     |  14 +-
 drivers/gpu/drm/ingenic/ingenic-ipu.c         |  12 +-
 drivers/gpu/drm/kmb/Kconfig                   |   2 +-
 drivers/gpu/drm/kmb/kmb_drv.c                 |   6 +-
 drivers/gpu/drm/kmb/kmb_plane.c               |  10 +-
 drivers/gpu/drm/logicvc/logicvc_crtc.c        |   2 +-
 drivers/gpu/drm/logicvc/logicvc_drm.c         |  10 +-
 drivers/gpu/drm/logicvc/logicvc_interface.c   |   2 +-
 drivers/gpu/drm/logicvc/logicvc_layer.c       |   6 +-
 drivers/gpu/drm/logicvc/logicvc_mode.c        |   4 +-
 drivers/gpu/drm/mcde/Kconfig                  |   2 +-
 drivers/gpu/drm/mcde/mcde_display.c           |   8 +-
 drivers/gpu/drm/mcde/mcde_drv.c               |  10 +-
 drivers/gpu/drm/mediatek/Kconfig              |   2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |   2 +-
 drivers/gpu/drm/mediatek/mtk_drm_gem.c        |   4 +-
 drivers/gpu/drm/meson/Kconfig                 |   2 +-
 drivers/gpu/drm/meson/meson_drv.c             |  10 +-
 drivers/gpu/drm/meson/meson_overlay.c         |  18 +-
 drivers/gpu/drm/meson/meson_plane.c           |  10 +-
 drivers/gpu/drm/msm/msm_drv.c                 |   2 +-
 drivers/gpu/drm/mxsfb/Kconfig                 |   2 +-
 drivers/gpu/drm/mxsfb/lcdif_drv.c             |   6 +-
 drivers/gpu/drm/mxsfb/lcdif_kms.c             |   8 +-
 drivers/gpu/drm/mxsfb/mxsfb_drv.c             |   6 +-
 drivers/gpu/drm/mxsfb/mxsfb_kms.c             |  34 +-
 drivers/gpu/drm/panel/Kconfig                 |   2 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9341.c  |   6 +-
 drivers/gpu/drm/pl111/Kconfig                 |   2 +-
 drivers/gpu/drm/pl111/pl111_display.c         |   8 +-
 drivers/gpu/drm/pl111/pl111_drv.c             |  10 +-
 drivers/gpu/drm/rcar-du/Kconfig               |   2 +-
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c        |   4 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.c         |   6 +-
 drivers/gpu/drm/rcar-du/rcar_du_kms.c         |  38 +--
 drivers/gpu/drm/rcar-du/rcar_du_plane.c       |  10 +-
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c         |   8 +-
 drivers/gpu/drm/rockchip/Kconfig              |   2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |   2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c   |   4 +-
 drivers/gpu/drm/shmobile/Kconfig              |   2 +-
 drivers/gpu/drm/shmobile/shmob_drm_crtc.c     |  14 +-
 drivers/gpu/drm/shmobile/shmob_drm_drv.c      |   6 +-
 drivers/gpu/drm/shmobile/shmob_drm_kms.c      |   4 +-
 drivers/gpu/drm/shmobile/shmob_drm_kms.h      |   2 +-
 drivers/gpu/drm/shmobile/shmob_drm_plane.c    |  14 +-
 drivers/gpu/drm/solomon/ssd130x.c             |   2 +-
 drivers/gpu/drm/sprd/Kconfig                  |   2 +-
 drivers/gpu/drm/sprd/sprd_dpu.c               |  10 +-
 drivers/gpu/drm/sprd/sprd_drm.c               |   6 +-
 drivers/gpu/drm/sti/Kconfig                   |   2 +-
 drivers/gpu/drm/sti/sti_cursor.c              |  14 +-
 drivers/gpu/drm/sti/sti_drv.c                 |   8 +-
 drivers/gpu/drm/sti/sti_gdp.c                 |  18 +-
 drivers/gpu/drm/sti/sti_hqvdp.c               |  18 +-
 drivers/gpu/drm/sti/sti_plane.c               |   4 +-
 drivers/gpu/drm/stm/Kconfig                   |   2 +-
 drivers/gpu/drm/stm/drv.c                     |  12 +-
 drivers/gpu/drm/stm/ltdc.c                    |  16 +-
 drivers/gpu/drm/sun4i/Kconfig                 |   2 +-
 drivers/gpu/drm/sun4i/sun4i_backend.c         |  16 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c             |  10 +-
 drivers/gpu/drm/sun4i/sun4i_frontend.c        |  26 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.c           |   4 +-
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c        |  22 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c        |  22 +-
 drivers/gpu/drm/tegra/fb.c                    |   2 +-
 drivers/gpu/drm/tidss/Kconfig                 |   2 +-
 drivers/gpu/drm/tidss/tidss_crtc.c            |   4 +-
 drivers/gpu/drm/tidss/tidss_dispc.c           |  28 +-
 drivers/gpu/drm/tidss/tidss_drv.c             |   6 +-
 drivers/gpu/drm/tidss/tidss_kms.c             |   2 +-
 drivers/gpu/drm/tidss/tidss_plane.c           |   2 +-
 drivers/gpu/drm/tilcdc/Kconfig                |   2 +-
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c          |  10 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c           |   6 +-
 drivers/gpu/drm/tiny/Kconfig                  |  22 +-
 drivers/gpu/drm/tiny/arcpgu.c                 |  14 +-
 drivers/gpu/drm/tiny/hx8357d.c                |   6 +-
 drivers/gpu/drm/tiny/ili9163.c                |   6 +-
 drivers/gpu/drm/tiny/ili9225.c                |  12 +-
 drivers/gpu/drm/tiny/ili9341.c                |   6 +-
 drivers/gpu/drm/tiny/ili9486.c                |   6 +-
 drivers/gpu/drm/tiny/mi0283qt.c               |   6 +-
 drivers/gpu/drm/tiny/panel-mipi-dbi.c         |   6 +-
 drivers/gpu/drm/tiny/repaper.c                |  12 +-
 drivers/gpu/drm/tiny/st7586.c                 |  12 +-
 drivers/gpu/drm/tiny/st7735r.c                |   6 +-
 drivers/gpu/drm/tve200/Kconfig                |   2 +-
 drivers/gpu/drm/tve200/tve200_display.c       |  12 +-
 drivers/gpu/drm/tve200/tve200_drv.c           |   8 +-
 drivers/gpu/drm/v3d/v3d_drv.c                 |   2 +-
 drivers/gpu/drm/v3d/v3d_gem.c                 |   4 +-
 drivers/gpu/drm/vc4/Kconfig                   |   2 +-
 drivers/gpu/drm/vc4/vc4_bo.c                  |  46 +--
 drivers/gpu/drm/vc4/vc4_crtc.c                |  18 +-
 drivers/gpu/drm/vc4/vc4_drv.c                 |   8 +-
 drivers/gpu/drm/vc4/vc4_drv.h                 |  18 +-
 drivers/gpu/drm/vc4/vc4_gem.c                 |  12 +-
 drivers/gpu/drm/vc4/vc4_irq.c                 |   2 +-
 drivers/gpu/drm/vc4/vc4_plane.c               |  14 +-
 drivers/gpu/drm/vc4/vc4_render_cl.c           |  40 +--
 drivers/gpu/drm/vc4/vc4_txp.c                 |   8 +-
 drivers/gpu/drm/vc4/vc4_v3d.c                 |   8 +-
 drivers/gpu/drm/vc4/vc4_validate.c            |  28 +-
 drivers/gpu/drm/vc4/vc4_validate_shaders.c    |   2 +-
 drivers/gpu/drm/xlnx/Kconfig                  |   2 +-
 drivers/gpu/drm/xlnx/zynqmp_disp.c            |   8 +-
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c           |   8 +-
 ...rm_fb_cma_helper.h => drm_fb_dma_helper.h} |  10 +-
 include/drm/drm_gem.h                         |   2 +-
 ..._gem_cma_helper.h => drm_gem_dma_helper.h} | 158 ++++-----
 154 files changed, 913 insertions(+), 919 deletions(-)
 rename drivers/gpu/drm/{drm_fb_cma_helper.c => drm_fb_dma_helper.c} (60%)
 rename drivers/gpu/drm/{drm_gem_cma_helper.c => drm_gem_dma_helper.c} (61%)
 rename include/drm/{drm_fb_cma_helper.h => drm_fb_dma_helper.h} (56%)
 rename include/drm/{drm_gem_cma_helper.h => drm_gem_dma_helper.h} (53%)

-- 
2.36.1

