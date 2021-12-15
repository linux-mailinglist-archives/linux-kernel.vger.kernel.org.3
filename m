Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B01474FF8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238724AbhLOBAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:00:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21750 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238706AbhLOBAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:00:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vBf2LRURKsRzlb+vhaJGWIb0ImHMSAjNCVFgOW2fQD8=;
        b=c4JwpOTIRpa6mjSg39WekMXaPTXfJo456JPpBva8hXWTaJ8/WrGj2vQw81PNgDDJMEgmLN
        fD/3NsTLQ/iryx/v2zp0vyA5D3g+w7eYUfXGTdXqnGL237O27j8Pfetzi7tgcRrAFjMNcF
        e/okU5FP6d49oMOvaY7XzQDkMRhWYeA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-536-MCEwN8SYMGqWsmdIMM7zZA-1; Tue, 14 Dec 2021 20:00:51 -0500
X-MC-Unique: MCEwN8SYMGqWsmdIMM7zZA-1
Received: by mail-wm1-f72.google.com with SMTP id j20-20020a05600c1c1400b00343ad0c4c40so1928510wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:00:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vBf2LRURKsRzlb+vhaJGWIb0ImHMSAjNCVFgOW2fQD8=;
        b=qJOTJD8c/+g7g0SXFCJQIgRpI40e/I81/QB1lUayY7qjqGSTT/K/GEA/0eFb9yQ4Tg
         /gjFuMd6fwUlvueoHv1g9GMQa5PflZmaf1PFXQHgggVoe24LVhKtZfZo3WN3HpD3K4QS
         pYrWNAci5nbXtHHLeq/KuVP0jDPWPzRZxDPal+Zfj2JCb7uZceF7Rbh5wC/7IK+dltqo
         BeWYDpqR1B96Q8xoNP3SHJiwJRBmgYkLiTQp+AG6kd4JxpC8l74tRTOoVe57EEdNiAWw
         U6az5EhqT1Hl0mirOD9BGu7aizYLWBRi8Qtp+l+W4Qebtuizbyd7FqQ/Nr6BB9vYXEhv
         kdBA==
X-Gm-Message-State: AOAM530xQDPMLrlyChUk9QCWELSJRofjtf61ezoaUHyehAmfUKf/VFwQ
        4D+EQ50OcrB+HdZrS6fQxN59/0kJDNSBmTl5NOv1xfGoMd2ZH3UvGhRCm2RhkD6AjYE3si02Urv
        LaqcZI8S7/7hSFMzlbBkLH1R7D0j4WgFVyBQNZRSt3oRShwdWBzqHSSuTk+C9MbJBS/YFMlgqNA
        Q=
X-Received: by 2002:a5d:5008:: with SMTP id e8mr2128797wrt.594.1639530050172;
        Tue, 14 Dec 2021 17:00:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxdAuwrdTMEESvsFcDG08E2OwA6WCyIG6BZJLPvxZ6SUDqAusQV4uM3jZsIEEHWw9jEc8VdZw==
X-Received: by 2002:a5d:5008:: with SMTP id e8mr2128737wrt.594.1639530049813;
        Tue, 14 Dec 2021 17:00:49 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:00:49 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Alison Wang <alison.wang@nxp.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Brian Starkey <brian.starkey@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        David Lechner <david@lechnology.com>,
        Deepak Rawat <drawat.floss@gmail.com>,
        Edmund Dea <edmund.j.dea@intel.com>,
        Emma Anholt <emma@anholt.net>,
        Erico Nunes <nunes.erico@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Inki Dae <inki.dae@samsung.com>, Joel Stanley <joel@jms.id.au>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
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
        Qiang Yu <yuq825@gmail.com>, Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sandy Huang <hjc@rock-chips.com>, Sean Paul <sean@poorly.run>,
        Stefan Agner <stefan@agner.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tian Tao <tiantao6@hisilicon.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Yannick Fertre <yannick.fertre@foss.st.com>
Subject: [PATCH 00/60] drm: Make all drivers to honour the nomodeset parameter
Date:   Wed, 15 Dec 2021 01:59:08 +0100
Message-Id: <20211215010008.2545520-1-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nomodeset kernel command line parameter is used to prevent the KMS/DRM
drivers to be registered/probed. But only a few drivers implement support
for this parameter and most DRM drivers would just ignore it.

This (huge) patch series makes all DRM drivers to honour this parameter. It
is posted as separate patches to make easier for drivers maintainers to ack
or pick them independently at their own pace.

Patches are quite trivial and just add an if (drm_firmware_drivers_only())
check and return -ENODEV if that's true. The condition is checked as early
as possible, that is in the module_init handler for drivers that have one
or in the probe function for drivers that are using the module_*_driver()
macros and don't have their own module init function.

I included all the DRM drivers that think makes sense. I only left the vc4
and v3d drivers, that Maxime is already handling in another patch series
and the vgem, vkms and simpledrm drivers that should ignore the param IMO.

I've built tested with 'make allmodconfig && make M=drivers/gpu/drm/', but
only booted in a few devices with and without nomodeset in the cmdline. So
testing and reviewing for all the drivers would be highly appreciated.

Best regards,
Javier


Javier Martinez Canillas (60):
  drm/komeda: Add support for the nomodeset kernel parameter
  drm/arm/hdlcd: Add support for the nomodeset kernel parameter
  drm/malidp: Add support for the nomodeset kernel parameter
  drm/armada: Add support for the nomodeset kernel parameter
  drm/aspeed: Add support for the nomodeset kernel parameter
  drm/atmel-hlcdc: Add support for the nomodeset kernel parameter
  drm/etnaviv: Add support for the nomodeset kernel parameter
  drm/exynos: Add support for the nomodeset kernel parameter
  drm/fsl-dcu: Add support for the nomodeset kernel parameter
  drm/gma500: Add support for the nomodeset kernel parameter
  drm/gud: Add support for the nomodeset kernel parameter
  drm/hisilicon/hibmc: Add support for the nomodeset kernel parameter
  drm/hisilicon/kirin: Add support for the nomodeset kernel parameter
  drm/hyperv: Add support for the nomodeset kernel parameter
  drm/i810: Add support for the nomodeset kernel parameter
  drm/imx/dcss: Add support for the nomodeset kernel parameter
  drm/imx: Add support for the nomodeset kernel parameter
  drm/ingenic: Add support for the nomodeset kernel parameter
  drm/kmb: Add support for the nomodeset kernel parameter
  drm/lima: Add support for the nomodeset kernel parameter
  drm/mcde: Add support for the nomodeset kernel parameter
  drm/mediatek: Add support for the nomodeset kernel parameter
  drm/meson: Add support for the nomodeset kernel parameter
  drm/mga: Add support for the nomodeset kernel parameter
  drm/msm: Add support for the nomodeset kernel parameter
  drm: mxsfb: Add support for the nomodeset kernel parameter
  drm/omap: Add support for the nomodeset kernel parameter
  drm/panel: ilitek-ili9341: Add support for the nomodeset kernel
    parameter
  drm/panfrost: Add support for the nomodeset kernel parameter
  drm/pl111: Add support for the nomodeset kernel parameter
  drm/r128: Add support for the nomodeset kernel parameter
  drm: rcar-du: Add support for the nomodeset kernel parameter
  drm/rockchip: Add support for the nomodeset kernel parameter
  drm/savage: Add support for the nomodeset kernel parameter
  drm/shmobile: Add support for the nomodeset kernel parameter
  drm/sis: Add support for the nomodeset kernel parameter
  drm/sprd: Add support for the nomodeset kernel parameter
  drm/sti: Add support for the nomodeset kernel parameter
  drm/stm: Add support for the nomodeset kernel parameter
  drm/sun4i: Add support for the nomodeset kernel parameter
  drm/tdfx: Add support for the nomodeset kernel parameter
  drm/tegra: Add support for the nomodeset kernel parameter
  drm/tidss: Add support for the nomodeset kernel parameter
  drm/tilcdc: Add support for the nomodeset kernel parameter
  drm/arc: Add support for the nomodeset kernel parameter
  drm/gm12u320: Add support for the nomodeset kernel parameter
  drm/hx8357d: Add support for the nomodeset kernel parameter
  drm/ili9163: Add support for the nomodeset kernel parameter
  drm/ili9225: Add support for the nomodeset kernel parameter
  drm/ili9341: Add support for the nomodeset kernel parameter
  drm/ili9486: Add support for the nomodeset kernel parameter
  drm/mi0283qt: Add support for the nomodeset kernel parameter
  drm/repaper: Add support for the nomodeset kernel parameter
  drm/st7586: Add support for the nomodeset kernel parameter
  drm/st7735r: Add support for the nomodeset kernel parameter
  drm/tve200: Add support for the nomodeset kernel parameter
  drm/udl: Add support for the nomodeset kernel parameter
  drm/via: Add support for the nomodeset kernel parameter
  drm/xen: Add support for the nomodeset kernel parameter
  drm/xlnx: Add support for the nomodeset kernel parameter

 drivers/gpu/drm/arm/display/komeda/komeda_drv.c | 4 ++++
 drivers/gpu/drm/arm/hdlcd_drv.c                 | 3 +++
 drivers/gpu/drm/arm/malidp_drv.c                | 3 +++
 drivers/gpu/drm/armada/armada_drv.c             | 3 +++
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c         | 3 +++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c    | 3 +++
 drivers/gpu/drm/etnaviv/etnaviv_drv.c           | 3 +++
 drivers/gpu/drm/exynos/exynos_drm_drv.c         | 3 +++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c       | 3 +++
 drivers/gpu/drm/gma500/psb_drv.c                | 3 +++
 drivers/gpu/drm/gud/gud_drv.c                   | 3 +++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 3 +++
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 3 +++
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c         | 3 +++
 drivers/gpu/drm/i810/i810_drv.c                 | 3 +++
 drivers/gpu/drm/imx/dcss/dcss-drv.c             | 3 +++
 drivers/gpu/drm/imx/imx-drm-core.c              | 3 +++
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c       | 3 +++
 drivers/gpu/drm/kmb/kmb_drv.c                   | 3 +++
 drivers/gpu/drm/lima/lima_drv.c                 | 3 +++
 drivers/gpu/drm/mcde/mcde_drv.c                 | 3 +++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c          | 3 +++
 drivers/gpu/drm/meson/meson_drv.c               | 3 +++
 drivers/gpu/drm/mga/mga_drv.c                   | 3 +++
 drivers/gpu/drm/msm/msm_drv.c                   | 3 +++
 drivers/gpu/drm/mxsfb/mxsfb_drv.c               | 3 +++
 drivers/gpu/drm/omapdrm/omap_drv.c              | 3 +++
 drivers/gpu/drm/panel/panel-ilitek-ili9341.c    | 3 +++
 drivers/gpu/drm/panfrost/panfrost_drv.c         | 3 +++
 drivers/gpu/drm/pl111/pl111_drv.c               | 3 +++
 drivers/gpu/drm/r128/r128_drv.c                 | 3 +++
 drivers/gpu/drm/rcar-du/rcar_du_drv.c           | 3 +++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c     | 3 +++
 drivers/gpu/drm/savage/savage_drv.c             | 3 +++
 drivers/gpu/drm/shmobile/shmob_drm_drv.c        | 3 +++
 drivers/gpu/drm/sis/sis_drv.c                   | 3 +++
 drivers/gpu/drm/sprd/sprd_drm.c                 | 3 +++
 drivers/gpu/drm/sti/sti_drv.c                   | 3 +++
 drivers/gpu/drm/stm/drv.c                       | 3 +++
 drivers/gpu/drm/sun4i/sun4i_drv.c               | 3 +++
 drivers/gpu/drm/tdfx/tdfx_drv.c                 | 3 +++
 drivers/gpu/drm/tegra/drm.c                     | 3 +++
 drivers/gpu/drm/tidss/tidss_drv.c               | 3 +++
 drivers/gpu/drm/tilcdc/tilcdc_drv.c             | 3 +++
 drivers/gpu/drm/tiny/arcpgu.c                   | 3 +++
 drivers/gpu/drm/tiny/gm12u320.c                 | 3 +++
 drivers/gpu/drm/tiny/hx8357d.c                  | 3 +++
 drivers/gpu/drm/tiny/ili9163.c                  | 3 +++
 drivers/gpu/drm/tiny/ili9225.c                  | 3 +++
 drivers/gpu/drm/tiny/ili9341.c                  | 3 +++
 drivers/gpu/drm/tiny/ili9486.c                  | 3 +++
 drivers/gpu/drm/tiny/mi0283qt.c                 | 3 +++
 drivers/gpu/drm/tiny/repaper.c                  | 3 +++
 drivers/gpu/drm/tiny/st7586.c                   | 3 +++
 drivers/gpu/drm/tiny/st7735r.c                  | 3 +++
 drivers/gpu/drm/tve200/tve200_drv.c             | 3 +++
 drivers/gpu/drm/udl/udl_drv.c                   | 3 +++
 drivers/gpu/drm/via/via_drv.c                   | 3 +++
 drivers/gpu/drm/xen/xen_drm_front.c             | 3 +++
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c             | 3 +++
 60 files changed, 181 insertions(+)

-- 
2.33.1

