Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF2B478168
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhLQAiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:38:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50815 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230354AbhLQAiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UcuPE0AoZt0Mctr7vyCREdMtC8eh0mER6sYELdYOusQ=;
        b=L8l3b9px6hpGEBI2ue0uNWRtaWlDBskDiSRhcQkIO4QtB7+dBclwuAtwN5oHAt1tbymumc
        IRQ6rPM9Pn2FCOW991l/Zqe0PLpWF5VSa0vn+uchL6SF1W8ed1IaQ+3069lUYOXpjnsMXs
        uF2O3n1zjZ6IfBnrtBwhEHsLIoqVXkA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-R0__yJbYP62F8nFx5LO9Eg-1; Thu, 16 Dec 2021 19:37:59 -0500
X-MC-Unique: R0__yJbYP62F8nFx5LO9Eg-1
Received: by mail-wr1-f71.google.com with SMTP id f13-20020adfe90d000000b001a15c110077so145015wrm.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:37:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UcuPE0AoZt0Mctr7vyCREdMtC8eh0mER6sYELdYOusQ=;
        b=f9WbPQw/n6lWUH2MbmwqZNjiDC2AkJNKNbMa7UDcPt86MY6NKQD4HEX3jdIkDLyD1n
         BfjPQwxlOqUQXPEMoqlMUT/7oKy977mGM7hhTOklJVJokj9trmsXIrMnRnqMiCQdf0Jn
         tnX3+j6hymo7RCBiNI6pDaeawH7cuWJqQYTZGWOXH6Tc5JReEgi1BIWY6IV38IMCSvwq
         g12xOA/joH+nGOyuKI27vQsIfPFNKXk35HRNEomNLAnbZa60yVv2OJp7qbJyhzJgY76C
         JYKyfJwMhsnO1iR5LQBv3nGQFELEDHvqmifNLXYPGwKCEDgMYxb8Mr6TKJMNmJgX1Kyb
         QAQg==
X-Gm-Message-State: AOAM530tg7pJ964w79rU0JkrMHTjEXq78plqdIRtVSFvJYKh8O4w9k/7
        O3hqX68N681Uq5/jNSta5GbLt4nRFt7URunEOSeE4rKxSyPoFIsGhKUFlnaa6taO6WD2gTlHOEM
        0kfbPAG1PAWZ9XEKuUgheBeE6WrtVLfBOD+nFQagYg1jw5aqUtmKwzgCh/oqrsBuhdOYC17JxfE
        M=
X-Received: by 2002:a1c:96:: with SMTP id 144mr7469237wma.126.1639701478143;
        Thu, 16 Dec 2021 16:37:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxhvKYqhblogmMzb7NLVERvgIW4LXK0Y/44bPJukQECBSev7UAmtTbdLWWG/yEFd7I6S1UFwg==
X-Received: by 2002:a1c:96:: with SMTP id 144mr7469181wma.126.1639701477776;
        Thu, 16 Dec 2021 16:37:57 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:37:57 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Alison Wang <alison.wang@nxp.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Brian Starkey <brian.starkey@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Deepak Rawat <drawat.floss@gmail.com>,
        Edmund Dea <edmund.j.dea@intel.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Inki Dae <inki.dae@samsung.com>, Joel Stanley <joel@jms.id.au>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sandy Huang <hjc@rock-chips.com>, Sean Paul <sean@poorly.run>,
        Stefan Agner <stefan@agner.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tian Tao <tiantao6@hisilicon.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Yannick Fertre <yannick.fertre@foss.st.com>
Subject: [PATCH v2 00/37] drm: Make drivers to honour the nomodeset parameter
Date:   Fri, 17 Dec 2021 01:37:15 +0100
Message-Id: <20211217003752.3946210-1-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nomodeset kernel command line parameter is used to prevent the KMS/DRM
drivers to be registered/probed. But only a few drivers implement support
for this and most DRM drivers just ignore it.

This patch series is a v2 to make DRM drivers to honour nomodeset. It is
posted as separate patches to make easier for drivers maintainers to ack
or pick them independently at their own pace.

The drm_module_{pci,platform}_driver() helper macros are added, which are
just wrappers around module_{pci,platform}_driver() but adding a check for
drm_firmware_drivers_only() and returning -ENODEV if that is true.

PCI and platform DRM drivers are then modified in the following patches to
make use of those macros.

For drivers that have custom module init/exit, the check is added to these
functions instead. Since the drm_*_module_driver() macros are only for the
default case when the init/exit just register/unregister the driver type.

In v1 all KMS/DRM drivers were included but v2 only includes KMS drivers,
and only the the PCI and platform DRM drivers. A follow-up series might
do the same for rendering-only and USB/SPI/I2C drivers, but it will need
more discussion to agree if that's desirable.

I've built tested with 'make allmodconfig && make M=drivers/gpu/drm' but I
don't have hardware to test the drivers, so review/testing is appreciated.

Best regards,
Javier

Changes in v2:
- Add drm_module_{pci,platform}_driver() macros and put the check there
  (Thomas Zimmermann).
- Use the drm_module_*_driver() macros if possible (Thomas Zimmermann).
- Leave the DRM drivers that don't set the DRIVER_MODESET driver feature
  (Lucas Stach).
- Leave USB/SPI/I2C drivers and only include PCI and platform ones
  (Noralf Trønnes).
- Add collected Reviewed-by tags

Javier Martinez Canillas (37):
  drm: Add drm_module_{pci,platform}_driver() helper macros
  drm/hisilicon/hibmc: Use drm_module_pci_driver() to register the
    driver
  drm/komeda: Use drm_module_platform_driver() to register the driver
  drm/arm/hdlcd: Use drm_module_platform_driver() to register the driver
  drm/malidp: Use drm_module_platform_driver() to register the driver
  drm/aspeed: Use drm_module_platform_driver() to register the driver
  drm/atmel-hlcdc: Use drm_module_platform_driver() to register the
    driver
  drm/fsl-dcu: Use drm_module_platform_driver() to register the driver
  drm/hisilicon/kirin: Use drm_module_platform_driver() to register the
    driver
  drm/imx/dcss: Use drm_module_platform_driver() to register the driver
  drm/kmb: Use drm_module_platform_driver() to register the driver
  drm/meson: Use drm_module_platform_driver() to register the driver
  drm: mxsfb: Use drm_module_platform_driver() to register the driver
  drm/shmobile: Use drm_module_platform_driver() to register the driver
  drm/stm: Use drm_module_platform_driver() to register the driver
  drm/sun4i: Use drm_module_platform_driver() to register the driver
  drm/tidss: Use drm_module_platform_driver() to register the driver
  drm/arc: Use drm_module_platform_driver() to register the driver
  drm/tve200: Use drm_module_platform_driver() to register the driver
  drm/xlnx: Use drm_module_platform_driver() to register the driver
  drm/armada: Add support for the nomodeset kernel parameter
  drm/exynos: Add support for the nomodeset kernel parameter
  drm/gma500: Add support for the nomodeset kernel parameter
  drm/hyperv: Add support for the nomodeset kernel parameter
  drm/imx: Add support for the nomodeset kernel parameter
  drm/ingenic: Add support for the nomodeset kernel parameter
  drm/mcde: Add support for the nomodeset kernel parameter
  drm/mediatek: Add support for the nomodeset kernel parameter
  drm/msm: Add support for the nomodeset kernel parameter
  drm/omap: Add support for the nomodeset kernel parameter
  drm: rcar-du: Add support for the nomodeset kernel parameter
  drm/rockchip: Add support for the nomodeset kernel parameter
  drm/sprd: Add support for the nomodeset kernel parameter
  drm/sti: Add support for the nomodeset kernel parameter
  drm/tegra: Add support for the nomodeset kernel parameter
  drm/tilcdc: Add support for the nomodeset kernel parameter
  drm/xen: Add support for the nomodeset kernel parameter

 .../gpu/drm/arm/display/komeda/komeda_drv.c   |  3 +-
 drivers/gpu/drm/arm/hdlcd_drv.c               |  2 +-
 drivers/gpu/drm/arm/malidp_drv.c              |  2 +-
 drivers/gpu/drm/armada/armada_drv.c           |  3 ++
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c       |  2 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.c       |  3 ++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c     |  2 +-
 drivers/gpu/drm/gma500/psb_drv.c              |  3 ++
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  2 +-
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   |  2 +-
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c       |  3 ++
 drivers/gpu/drm/imx/dcss/dcss-drv.c           |  2 +-
 drivers/gpu/drm/imx/imx-drm-core.c            |  3 ++
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c     |  3 ++
 drivers/gpu/drm/kmb/kmb_drv.c                 |  2 +-
 drivers/gpu/drm/mcde/mcde_drv.c               |  3 ++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  3 ++
 drivers/gpu/drm/meson/meson_drv.c             |  2 +-
 drivers/gpu/drm/msm/msm_drv.c                 |  3 ++
 drivers/gpu/drm/mxsfb/mxsfb_drv.c             |  2 +-
 drivers/gpu/drm/omapdrm/omap_drv.c            |  3 ++
 drivers/gpu/drm/rcar-du/rcar_du_drv.c         |  3 ++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |  3 ++
 drivers/gpu/drm/shmobile/shmob_drm_drv.c      |  2 +-
 drivers/gpu/drm/sprd/sprd_drm.c               |  3 ++
 drivers/gpu/drm/sti/sti_drv.c                 |  3 ++
 drivers/gpu/drm/stm/drv.c                     |  2 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c             |  2 +-
 drivers/gpu/drm/tegra/drm.c                   |  3 ++
 drivers/gpu/drm/tidss/tidss_drv.c             |  2 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c           |  3 ++
 drivers/gpu/drm/tiny/arcpgu.c                 |  2 +-
 drivers/gpu/drm/tve200/tve200_drv.c           |  2 +-
 drivers/gpu/drm/xen/xen_drm_front.c           |  3 ++
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c           |  2 +-
 include/drm/drm_drv.h                         | 50 +++++++++++++++++++
 37 files changed, 121 insertions(+), 19 deletions(-)

-- 
2.33.1

