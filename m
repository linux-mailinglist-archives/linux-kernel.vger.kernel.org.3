Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5844E79F6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 18:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377361AbiCYRSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 13:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377347AbiCYRSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 13:18:21 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70116E8860
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 10:16:44 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so4779752wmp.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 10:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ttvVODLTTBaqB4olSje/RjnCtKXgr801DvSo2q2eG0E=;
        b=N1CIxrPllldGtyrr6zpOrMX0FXbRkN9jSKNyyoOnpgzvf3oO00M6yzMIR/NdW3SJ1m
         tZDvFwFHCU0wiAvTdbmuCf6VURSMugIOFNr9ByRJR0ccKWPVhDJ7OExv6Yl/GbZu2pNx
         DFDfr7MvT/GIw1bYXLKZB5vruoRQkJsBGc5R6DF2aFSuHAmh0nlo2LSe6a8nhmC2xaav
         EgQhahyI4MwTpYQ1VKfoG4vl0ZOx69Oca5bEdc+a5E3kKOyNye+xSmu/v+bAY0WrrMKO
         66HRHMw6d8lSFlB4Oacgo6ig6bCAad0RlRsdWosVOW5xo2PQC/W6/hpVr/LU68aFVsKX
         Qz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ttvVODLTTBaqB4olSje/RjnCtKXgr801DvSo2q2eG0E=;
        b=CqZZeo+zgvjhP+OgL6G1kx1GJosY+OIxMmLQos+WsVKy1xvO12W/M7i1HDzXeeO+no
         Js4Llyw9cQHKmZB6A+ZqbvvHudaBLv1MNpdZ1fHVX8sPnoC9ZuGsJ78XHAQ6Y7BS0jsP
         BwSdCWV2zl0LG6lBylnlFRPS/VPa/FMCP2KzGi6v3IacSij7oma4LEFRjHxWFH08MMmj
         OZd+W5+I35HzZDKWerzgF+ITPoncDeql0yHUIgoTE5aYblHtBLbxI9BuCltohMh0bE35
         uxJjPA54HdUJ+aBjU2TgETHdBu/YKeu7mCX+wMaYz1dAps/tRHQhuKZuPYJRxTr0v+45
         1QZA==
X-Gm-Message-State: AOAM530x826u4Tcf6S96hCKtPLLeg8KWYD2d1ih4sY9WnNhuTdl7Tew2
        pccYVxcA7ETsnnP7XiS62tsqoQ==
X-Google-Smtp-Source: ABdhPJxYt+gdFp9cOKWjwZsLb/u9lRiQpwwVDTh6wjY60qcTISWQeI+ehBpxnSUzrqMg6tzyAQdKCA==
X-Received: by 2002:a05:600c:19ce:b0:38c:dcc1:4cf3 with SMTP id u14-20020a05600c19ce00b0038cdcc14cf3mr6782388wmq.126.1648228602590;
        Fri, 25 Mar 2022 10:16:42 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6240-cc41-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6240:cc41:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7547464wru.99.2022.03.25.10.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:16:42 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
To:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, matthias.bgg@gmail.com,
        chunfeng.yun@mediatek.com, kishon@ti.com, vkoul@kernel.org,
        deller@gmx.de, ck.hu@mediatek.com, jitao.shi@mediatek.com,
        angelogioacchino.delregno@collabora.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org,
        markyacoub@google.com
Subject: [PATCH 00/22] drm/mediatek: Add mt8195 DisplayPort driver
Date:   Fri, 25 Mar 2022 18:14:49 +0100
Message-Id: <20220325171511.23493-1-granquet@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this series is built around the DisplayPort driver. The dpi/dpintf
driver and the added helper functions are required for the DisplayPort
driver to work.

This v9 is not quite ready yet, as project constraints forces me to
publish v9 this week, I'm sorry if it's not standard practice.

Moreover, it is still un-tested on a recent kernel.
The integration kernel we are using is still based on 5.10... but we
are actively working on bringing up a mt8195 integration branch on 5.17.
The patches have been rebased on top of next-20220301 and have been
tested to build sucessfully (no functional testing).

Changes from v8:
- The DP-Phy now has its own dt-bindings and now shares a regmap using the
  syscon facility with the DP driver.
- hot plug detection has been removed from the Embedded Display Port.
  patch and moved to the patch adding External Display Port support.
- started working on better error handling for the mtk_dp driver.
- rebased on linux-next.
- removal of tvd pll clocks re-introduced by mistake.
- various coding style fixes.

Things that are in my todolist for v10:
- fixing the train_handler in the mtk_dp driver, as I haven't been able
  to reproduce locally (hopefully migrating to running the tests on a
  more recent kernel will help)
- explaining the various sleep/delays introduced in the drivers
- explaining some of the differences between mt8195 and "legacy"
- retrieve CK/DE support from panel driver instead of hardcoding it into
  the dpi driver.
- better error handling/reporting in mtk_dp
- look into re-implementing mtk_dp_aux_transfer() using drm_dp_dpcd_read and
  drm_dp_dpcd_write as suggested by Rex.

Older revisions:
RFC - https://lore.kernel.org/linux-mediatek/20210816192523.1739365-1-msp@baylibre.com/
v1  - https://lore.kernel.org/linux-mediatek/20210906193529.718845-1-msp@baylibre.com/
v2  - https://lore.kernel.org/linux-mediatek/20210920084424.231825-1-msp@baylibre.com/
v3  - https://lore.kernel.org/linux-mediatek/20211001094443.2770169-1-msp@baylibre.com/
v4  - https://lore.kernel.org/linux-mediatek/20211011094624.3416029-1-msp@baylibre.com/
v5  - https://lore.kernel.org/all/20211021092707.3562523-1-msp@baylibre.com/
v6  - https://lore.kernel.org/linux-mediatek/20211110130623.20553-1-granquet@baylibre.com/
v7  - https://lore.kernel.org/linux-mediatek/20211217150854.2081-1-granquet@baylibre.com/
v8  - https://lore.kernel.org/linux-mediatek/20220218145437.18563-1-granquet@baylibre.com/

Functional dependencies are:
- Add Mediatek Soc DRM (vdosys0) support for mt8195
  https://lore.kernel.org/all/20211026155911.17651-1-jason-jh.lin@mediatek.com/
- Add MediaTek SoC DRM (vdosys1) support for mt8195
  https://lore.kernel.org/all/20211029075203.17093-1-nancy.lin@mediatek.com/

Guillaume Ranquet (15):
  dt-bindings: mediatek,dp_phy: Add Display Port PHY binding
  drm/edid: Convert cea_sad helper struct to kernelDoc
  drm/edid: Add cea_sad helpers for freq/length
  drm/mediatek: dpi: move dpi limits to SoC config
  drm/mediatek: dpi: implement a CK/DE pol toggle in SoC config
  drm/mediatek: dpi: implement a swap_input toggle in SoC config
  drm/mediatek: dpi: move dimension mask to SoC config
  drm/mediatek: dpi: move hvsize_mask to SoC config
  drm/mediatek: dpi: move swap_shift to SoC config
  drm/mediatek: dpi: move the yuv422_en_bit to SoC config
  drm/mediatek: dpi: move the csc_enable bit to SoC config
  drm/mediatek: dpi: Add dpintf support
  drm/meditek: dpi: Add matrix_sel helper
  drm/mediatek: Add mt8195 External DisplayPort support
  drm/mediatek: DP audio support for mt8195

Jitao Shi (2):
  drm/mediatek: add hpd debounce
  drm/mediatek: change the aux retries times when receiving AUX_DEFER

Markus Schneider-Pargmann (5):
  dt-bindings: mediatek,dpi: Add DP_INTF compatible
  dt-bindings: mediatek,dp: Add Display Port binding
  video/hdmi: Add audio_infoframe packing for DP
  phy: phy-mtk-dp: Add driver for DP phy
  drm/mediatek: Add mt8195 Embedded DisplayPort driver

 .../display/mediatek/mediatek,dp.yaml         |   97 +
 .../display/mediatek/mediatek,dpi.yaml        |   11 +-
 .../bindings/phy/mediatek,dp-phy.yaml         |   43 +
 MAINTAINERS                                   |    1 +
 drivers/gpu/drm/drm_edid.c                    |   74 +
 drivers/gpu/drm/mediatek/Kconfig              |    8 +
 drivers/gpu/drm/mediatek/Makefile             |    2 +
 drivers/gpu/drm/mediatek/mtk_dp.c             | 3204 +++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_dp_reg.h         |  568 +++
 drivers/gpu/drm/mediatek/mtk_dpi.c            |  222 +-
 drivers/gpu/drm/mediatek/mtk_dpi_regs.h       |   38 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c   |    8 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h   |    1 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |    6 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h        |    1 +
 drivers/phy/mediatek/Kconfig                  |    8 +
 drivers/phy/mediatek/Makefile                 |    1 +
 drivers/phy/mediatek/phy-mtk-dp.c             |  202 ++
 drivers/video/hdmi.c                          |   82 +-
 include/drm/dp/drm_dp_helper.h                |    2 +
 include/drm/drm_edid.h                        |   25 +-
 include/linux/hdmi.h                          |    7 +-
 include/linux/soc/mediatek/mtk-mmsys.h        |    3 +-
 23 files changed, 4541 insertions(+), 73 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,dp-phy.yaml
 create mode 100644 drivers/gpu/drm/mediatek/mtk_dp.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_dp_reg.h
 create mode 100644 drivers/phy/mediatek/phy-mtk-dp.c

-- 
2.34.1

