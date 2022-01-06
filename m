Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D59E486C27
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244453AbiAFVqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244400AbiAFVqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:46:00 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8726DC0611FD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 13:46:00 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id t187so3558600pfb.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 13:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=brCHUxffELX7g748GhedHfW2USaNa6/M+pFJyVUZXSA=;
        b=HD4HW3q92GwTjzL9pH/Q6hAxGyWK7FaS4wX+mWQI8N2hWyPHzSMKWSgVlwux2spoJg
         cNHk7vFdROBIG5PRkUmJ5lb4wEZpd2H+Uw8Gr8gjGHCUmHMV5pJieUd7WaUfd9aa3JCz
         POMEAHF/2Wg2S+sbtZ1lCIj2wXz7dU6sntyDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=brCHUxffELX7g748GhedHfW2USaNa6/M+pFJyVUZXSA=;
        b=BbIxcms8vph4LvRvQrw/SvCQFutDVmXWLC5Cv9PaKkgrIbRXwui5lN+2LNi7gZ7lTa
         uNjTKx6NHXCbh9VTdEdwHhqL4ZAjRAJpOuBS+/NE6MgCaEobKq3sBGu9ddwvDxJSDfuz
         WxwpDzQyVwR5ENJYTuL66MtVt+RwTTp7GtfIdB8pu8D1Fn/OjX+750TQoJ6f6EfjCEni
         c0jSOjowCiY8PfZppkmhEAUblI9m+6SjqQddHOeLwnw1It22v7sbTkAzRMzJ4gQNLTHQ
         19umhugBI+BEGoRi/GyEBRTTgnOlo3xFpCqp9T+E6W4AW4919SklYxu+d0FZo+WBccxx
         b1Dg==
X-Gm-Message-State: AOAM532jrmLbTyer10UzU9tLl7SrSlMZg8u2AHYK7QWDL6K5VT4GQDoX
        /S+pYu92FASje5OEXvfs3/G0GA==
X-Google-Smtp-Source: ABdhPJyXE9BLzE1n4jQ3aYOyiKDxTUXdx0jwxEiX+rDhUHA6y/W6opCn8DzCUvw5dPSbkoiH2am8ng==
X-Received: by 2002:a65:5808:: with SMTP id g8mr53947571pgr.91.1641505559977;
        Thu, 06 Jan 2022 13:45:59 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:1ebe:a8fd:f9b0:7e85])
        by smtp.gmail.com with ESMTPSA id 10sm3539960pfm.56.2022.01.06.13.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 13:45:59 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Arnd Bergmann <arnd@arndb.de>,
        Chen Feng <puck.chen@hisilicon.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Emma Anholt <emma@anholt.net>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Inki Dae <inki.dae@samsung.com>,
        James Qian Wang <james.qian.wang@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Joerg Roedel <joro@8bytes.org>,
        John Stultz <john.stultz@linaro.org>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Sandy Huang <hjc@rock-chips.com>,
        Saravana Kannan <saravanak@google.com>,
        Sebastian Reichel <sre@kernel.org>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Takashi Iwai <tiwai@suse.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Will Deacon <will@kernel.org>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH v5 00/32] component: Make into an aggregate bus
Date:   Thu,  6 Jan 2022 13:45:23 -0800
Message-Id: <20220106214556.2461363-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is from discussion we had on reordering the device lists for
drm shutdown paths[1]. I've introduced an 'aggregate' bus that we put
the aggregate device onto and then we probe the aggregate device once
all the components are probed and call component_add(). The probe/remove
hooks are where the bind/unbind calls go, and then a shutdown hook is
added that can be used to shutdown the drm display pipeline at the right
time.

This works for me on my sc7180 board. I no longer get a warning from i2c
at shutdown that we're trying to make an i2c transaction after the i2c
bus has been shutdown. There's more work to do on the msm drm driver to
extract component device resources like clks, regulators, etc. out of
the component bind function into the driver probe but I wanted to move
everything over now in other component drivers before tackling that
problem.

Tested-by tags would be appreciated, and Acked-by/Reviewed-by tags too.

Per Daniel, I've resent this to collect Acks or Review tags from gregkh
and once Greg is happy with the driver core bits it can be merged
through drm-misc tree via dianders (both are on the To line).

One last thing, I suspect I'll have to send this once again after the
merge window because something is probably in linux-next that conflicts
with some driver patch. I'll do that in about two weeks.

Changes since v4 (https://lore.kernel.org/r/20211202222732.2453851-1-swboyd@chromium.org):
 - Picked up tags
 - Moved rename patch to first in the series
 - Squashed device and bus type patch together

Changes since v3 (https://lore.kernel.org/r/20211026000044.885195-1-swboyd@chromium.org):
 - Picked up tags
 - Rebased to v5.16-rc2
 - Updated component.c for a few new patches there
 - Dropped a conversion patch
 - Added a conversion patch

Changes since v2 (https://lore.kernel.org/r/20211006193819.2654854-1-swboyd@chromium.org):
 - Picked up acks
 - Fixed build warnings/errors
 - Reworked patch series to rename 'master' in a different patch

Changes since v1 (https://lore.kernel.org/r/20210520002519.3538432-1-swboyd@chromium.org):
 - Use devlink to connect components to the aggregate device
 - Don't set the registering device as a parent of the aggregate device
 - New patch for bind_component/unbind_component ops that takes the
   aggregate device
 - Convert all drivers in the tree to use the aggregate driver approach
 - Allow one aggregate driver to be used for multiple aggregate devices

[1] https://lore.kernel.org/r/20210508074118.1621729-1-swboyd@chromium.org

Stephen Boyd (32):
  component: Replace most references to 'master' with 'aggregate device'
  component: Introduce the aggregate bus_type
  component: Move struct aggregate_device out to header file
  component: Add {bind,unbind}_component() ops that take aggregate
    device
  drm/of: Add a drm_of_aggregate_probe() API
  drm/msm: Migrate to aggregate driver
  drm/komeda: Migrate to aggregate driver
  drm/arm/hdlcd: Migrate to aggregate driver
  drm/malidp: Migrate to aggregate driver
  drm/armada: Migrate to aggregate driver
  drm/etnaviv: Migrate to aggregate driver
  drm/kirin: Migrate to aggregate driver
  drm/exynos: Migrate to aggregate driver
  drm/imx: Migrate to aggregate driver
  drm/ingenic: Migrate to aggregate driver
  drm/mcde: Migrate to aggregate driver
  drm/mediatek: Migrate to aggregate driver
  drm/meson: Migrate to aggregate driver
  drm/omap: Migrate to aggregate driver
  drm/rockchip: Migrate to aggregate driver
  drm/sti: Migrate to aggregate driver
  drm/sun4i: Migrate to aggregate driver
  drm/tilcdc: Migrate to aggregate driver
  drm/vc4: Migrate to aggregate driver
  iommu/mtk: Migrate to aggregate driver
  mei: Migrate to aggregate driver
  power: supply: ab8500: Migrate to aggregate driver
  fbdev: omap2: Migrate to aggregate driver
  sound: hdac: Migrate to aggregate driver
  ASoC: codecs: wcd938x: Migrate to aggregate driver
  component: Get rid of drm_of_component_probe()
  component: Remove component_master_ops and friends

 drivers/base/component.c                      | 544 ++++++++++--------
 .../gpu/drm/arm/display/komeda/komeda_drv.c   |  20 +-
 drivers/gpu/drm/arm/hdlcd_drv.c               |  21 +-
 drivers/gpu/drm/arm/malidp_drv.c              |  21 +-
 drivers/gpu/drm/armada/armada_drv.c           |  23 +-
 drivers/gpu/drm/drm_drv.c                     |   2 +-
 drivers/gpu/drm/drm_of.c                      |  18 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.c         |  20 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.c       |  21 +-
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   |  20 +-
 drivers/gpu/drm/imx/imx-drm-core.c            |  20 +-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c     |  25 +-
 drivers/gpu/drm/mcde/mcde_drv.c               |  23 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  20 +-
 drivers/gpu/drm/meson/meson_drv.c             |  21 +-
 drivers/gpu/drm/msm/msm_drv.c                 |  46 +-
 drivers/gpu/drm/omapdrm/dss/dss.c             |  20 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |  20 +-
 drivers/gpu/drm/sti/sti_drv.c                 |  20 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c             |  26 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c           |  28 +-
 drivers/gpu/drm/vc4/vc4_drv.c                 |  20 +-
 drivers/iommu/mtk_iommu.c                     |  14 +-
 drivers/iommu/mtk_iommu.h                     |   6 +-
 drivers/iommu/mtk_iommu_v1.c                  |  14 +-
 drivers/misc/mei/hdcp/mei_hdcp.c              |  22 +-
 drivers/misc/mei/pxp/mei_pxp.c                |  22 +-
 drivers/power/supply/ab8500_charger.c         |  22 +-
 drivers/video/fbdev/omap2/omapfb/dss/dss.c    |  20 +-
 include/drm/drm_of.h                          |  10 +-
 include/linux/component.h                     |  92 ++-
 sound/hda/hdac_component.c                    |  21 +-
 sound/soc/codecs/wcd938x.c                    |  20 +-
 33 files changed, 772 insertions(+), 490 deletions(-)

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Chen Feng <puck.chen@hisilicon.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Emma Anholt <emma@anholt.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Heiko Stübner" <heiko@sntech.de>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: James Qian Wang (Arm Technology China) <james.qian.wang@arm.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Jyri Sarha <jyri.sarha@iki.fi>
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: <linux-fbdev@vger.kernel.org>
Cc: <linux-omap@vger.kernel.org>
Cc: <linux-pm@vger.kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Russell King <linux+etnaviv@armlinux.org.uk>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Sandy Huang <hjc@rock-chips.com>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Tian Tao <tiantao6@hisilicon.com>
Cc: Tomas Winkler <tomas.winkler@intel.com>
Cc: Tomi Valkeinen <tomba@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Xinliang Liu <xinliang.liu@linaro.org>
Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Yong Wu <yong.wu@mediatek.com>
Cc: Vitaly Lubart <vitaly.lubart@intel.com>
Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>

base-commit: 136057256686de39cc3a07c2e39ef6bc43003ff6
-- 
https://chromeos.dev

