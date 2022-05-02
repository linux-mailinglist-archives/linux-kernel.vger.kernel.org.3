Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BEC516C75
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 10:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383846AbiEBIwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359538AbiEBIwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:52:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D69750E3B
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 01:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651481342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=g1EGMUSX4uhdpumN1AqArSCJZUMcx2qk+SIJN7jkMXI=;
        b=R200hlisoA5GgcTQu43l+PIwa36cGpcqSHJpA8hWYupIDl55WTqiRBahErCJjjgvBrqZvz
        aYiRElhf6dZhG6kZrEQM4f6Migga5+TeZ4DjZjDgk/EUmGsLpgX/lcC85tumb7z09Lq8k8
        dk+wOUrNNdlrbH1jkBCB27k6oR5l0ls=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-EXInG29aPbORkTwJQTdkrA-1; Mon, 02 May 2022 04:49:01 -0400
X-MC-Unique: EXInG29aPbORkTwJQTdkrA-1
Received: by mail-wm1-f70.google.com with SMTP id c62-20020a1c3541000000b0038ec265155fso9665823wma.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 01:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g1EGMUSX4uhdpumN1AqArSCJZUMcx2qk+SIJN7jkMXI=;
        b=gyFAt1OZfwL3bLjMi0UYL+HJtbWCD7WWFtxjrt5N3JDyRuFF4+R8r/INBwU93g/SWq
         BUJyiS5Mf3DlnsQn1H3UVk8kiM3wOaB98MbzOfgSqqRNPr+w4vtZgIBFsS0IM4UXAnBh
         RRyIqeRjjcivCwo9NcyLjpSozOT7ay6/G9mPbpJuiZ3Yzzi+sADhybpCua0ALknely4+
         K+cTlL0jG5TgOMrsp9KHovuNeO2P0aSDKWUf+BKxLumjNTqMoUG5eSQkIyb75DHsTtuR
         8zIYMNwjOkSRO6F5RK5CYQcIEc5qYh3B9Xw6Xe3PJizmoQcYYE3iS7j+c+QFAQL72J7/
         RJ0w==
X-Gm-Message-State: AOAM531BJCgQr+PuR3sq47Pu73hwZtibNfVen6gYtj1GveTh4qgVllQu
        TZIDG4OR6qSZ3yfrSqmV6CzySAT0sDvHjPa6lhlc6Phk3frSS43Prj5tIQrsv0JwaeUBqC8rD8b
        zRN/q9VE1b6GlfiAX5wrD3hKQxTACDRHsWcX/FbBr8cbB0JXceSMy8654MZ7vPPoWy0HLp3Kiwp
        A=
X-Received: by 2002:a1c:7512:0:b0:394:16ee:ab9b with SMTP id o18-20020a1c7512000000b0039416eeab9bmr9917271wmc.176.1651481340048;
        Mon, 02 May 2022 01:49:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1HDOH0L0J59jWzQqe8OCc8OrGCpxEDekTc2b0ViBR9lVxUT3tRNZw5Yfr7Gkyc9Gu0hnOLg==
X-Received: by 2002:a1c:7512:0:b0:394:16ee:ab9b with SMTP id o18-20020a1c7512000000b0039416eeab9bmr9917168wmc.176.1651481339590;
        Mon, 02 May 2022 01:48:59 -0700 (PDT)
Received: from minerva.. ([90.167.94.74])
        by smtp.gmail.com with ESMTPSA id i14-20020adfa50e000000b0020c5253d8c6sm8032307wrb.18.2022.05.02.01.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 01:48:59 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Alison Wang <alison.wang@nxp.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Brian Starkey <brian.starkey@arm.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Chen-Yu Tsai <wens@csie.org>, Chia-I Wu <olvaffe@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>, Emma Anholt <emma@anholt.net>,
        Evan Quan <evan.quan@amd.com>,
        Fabio Estevam <festevam@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Hao Fang <fanghao11@huawei.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Joel Stanley <joel@jms.id.au>,
        John Stultz <john.stultz@linaro.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Kevin Hilman <khilman@baylibre.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Marek Vasut <marex@denx.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Nirmoy Das <nirmoy.das@amd.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Samuel Holland <samuel@sholland.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Solomon Chiu <solomon.chiu@amd.com>,
        Stefan Agner <stefan@agner.ch>,
        Tian Tao <tiantao6@hisilicon.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Yong Wu <yong.wu@mediatek.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-mediatek@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, spice-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 0/3] drm: Allow simpledrm to setup its emulated FB as firmware provided
Date:   Mon,  2 May 2022 10:48:27 +0200
Message-Id: <20220502084830.285639-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series contain patches suggested by Thomas Zimmermannas a feedback for
"[RFC PATCH v4 00/11] Fix some race between sysfb device registration and
drivers probe" [0].

Since other changes in [0] were more controversial, I decided to just split
this part in a new patch-set and revisit the rest of the patches later.

Patch #1 is just a cleanup since when working on this noticed that some DRM
drivers were passing as preferred bits per pixel to drm_fbdev_generic_setup()
the value that is the default anyways.

Patch #2 renames the 'preferred_bpp' drm_fbdev_generic_setup() parameter to
'options', and make this a multi field parameter so that it can be extended
later to pass other options as well.

Patch #3 finally adds the new DRM_FB_FW option and makes simpledrm to use it
so that the registered framebuffer device is also marked as firmware provided.

[0]: https://lore.kernel.org/lkml/20220429084253.1085911-1-javierm@redhat.com/


Javier Martinez Canillas (3):
  drm: Remove superfluous arg when calling to drm_fbdev_generic_setup()
  drm/fb-helper: Rename preferred_bpp drm_fbdev_generic_setup()
    parameter
  drm: Allow simpledrm to setup its emulated FB as firmware provided

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  6 +++--
 drivers/gpu/drm/arm/hdlcd_drv.c               |  2 +-
 drivers/gpu/drm/arm/malidp_drv.c              |  2 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c       |  2 +-
 drivers/gpu/drm/ast/ast_drv.c                 |  2 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  |  2 +-
 drivers/gpu/drm/drm_drv.c                     |  2 +-
 drivers/gpu/drm/drm_fb_helper.c               | 25 ++++++++++++++++---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c     |  2 +-
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  2 +-
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   |  2 +-
 drivers/gpu/drm/imx/dcss/dcss-kms.c           |  2 +-
 drivers/gpu/drm/imx/imx-drm-core.c            |  2 +-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c     |  2 +-
 drivers/gpu/drm/mcde/mcde_drv.c               |  2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  2 +-
 drivers/gpu/drm/meson/meson_drv.c             |  2 +-
 drivers/gpu/drm/mxsfb/mxsfb_drv.c             |  2 +-
 drivers/gpu/drm/pl111/pl111_drv.c             |  2 +-
 drivers/gpu/drm/qxl/qxl_drv.c                 |  2 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.c         |  2 +-
 drivers/gpu/drm/sti/sti_drv.c                 |  2 +-
 drivers/gpu/drm/stm/drv.c                     |  2 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c             |  2 +-
 drivers/gpu/drm/tidss/tidss_drv.c             |  2 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c           |  2 +-
 drivers/gpu/drm/tiny/arcpgu.c                 |  2 +-
 drivers/gpu/drm/tiny/bochs.c                  |  2 +-
 drivers/gpu/drm/tiny/cirrus.c                 |  2 +-
 drivers/gpu/drm/tiny/simpledrm.c              |  2 +-
 drivers/gpu/drm/tve200/tve200_drv.c           |  2 +-
 drivers/gpu/drm/vboxvideo/vbox_drv.c          |  2 +-
 drivers/gpu/drm/vc4/vc4_drv.c                 |  2 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c          |  2 +-
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c           |  2 +-
 include/drm/drm_fb_helper.h                   | 22 ++++++++++++++++
 36 files changed, 80 insertions(+), 39 deletions(-)

-- 
2.35.1

