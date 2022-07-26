Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8F35818B5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239555AbiGZRjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239556AbiGZRiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:38:52 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5803246F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:38:42 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o14-20020a17090a4b4e00b001f2f2b61be5so2449320pjl.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JCn9/IjaeLQGVh694onzThTpnzvbXceLIXHLyYRvYVY=;
        b=XNrZs8tWp8PRd21901P8ntMu55q2yctWNlQA1QfQ7KQJbecWjcvUbFuZkRuQq3CZ2h
         3QBdPPbVnF85OM3V1/QmY633wB99DZSO6VZOR5dFdUXpySbrXxHnud+iPJB+t0n4thbI
         GFIi2UlTfJ+/Cf7Jl9TYFdopqnbFRa1MNXlBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JCn9/IjaeLQGVh694onzThTpnzvbXceLIXHLyYRvYVY=;
        b=Z24gV1Po8qn7KQlxkOM0qUUra0ElOw4ssp/96fdpJYrB/7hGepC2NEsbSakg56RRvc
         +H06JL1CtxTDxWsjQOYjKuSrkt97a5+a3AUZmMLfGSpiMG+m8mQWajogSb3vbgsbM+I4
         0JrBbpaXjtzwp3luz2mnFOklwPpzOe1qoy2cmQVGEUVDeeTAj+zhHD8eP233nkwg6hnj
         n8JUrxf8u6E0mZJy4thDRnNjRHozRCXOmydX1+nxlOFgETRXGDQ0NV+C5/uA7qI/UqFX
         Fg0lkMn2IuEbjupaFIo+FADKanBVECDix5i2b7WebsKE89AlbpydHr1bD3xcRwED9GjQ
         rM1A==
X-Gm-Message-State: AJIora98NH81OEdBmz25NRM+e+QlUxeVq/nwPBrhez36zGXMBjTudmpZ
        EkOf3tQ0JSiqD68Wprn7R/EjcA==
X-Google-Smtp-Source: AGRyM1vgwZMiQM2WzJWkrdxjc5FVSLy91CuCpFSR+fEUatViRg+5GVgh6OGv5sqlFxiqNmaDne/52A==
X-Received: by 2002:a17:903:248:b0:168:ce2f:cbd2 with SMTP id j8-20020a170903024800b00168ce2fcbd2mr17627450plh.63.1658857120803;
        Tue, 26 Jul 2022 10:38:40 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:8693:e9aa:75c0:5134])
        by smtp.gmail.com with ESMTPSA id ik29-20020a170902ab1d00b0016d9ecd71f4sm245884plb.77.2022.07.26.10.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:38:40 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Archit Taneja <architt@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Marek <jonathan@marek.ca>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] drm/msm/dsi regulator improvements
Date:   Tue, 26 Jul 2022 10:38:17 -0700
Message-Id: <20220726173824.1166873-1-dianders@chromium.org>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main goal of this series is to make a small dent in cleaning up
the way we deal with regulator loads. The idea is to add some extra
functionality to the regulator "bulk" API so that consumers can
specify the load using that. Though I didn't convert everyone over, I
include patches in this series that show how the Qualcomm DSI driver
is improved by this.

I'd expect:
* The first two patches are bugfixes found while converting the DSI
  driver over. Those could land any time.
* The third patch ("drm/msm/dsi: Don't set a load before disabling a
  regulator") is a patch a sent the other day verbatim, included in
  this series because it's highly related. It could land any
  time. That's why I called this series "v2".
* After that I have patches that add to the regulator API and then
  show a usage of those in the DSI driver. I'd expect that the two
  regulator patches could land in the regulator tree. The DSI patches
  would need to wait until the new regulator changes are available.

Changes in v2:
- ("Fix number of regulators for msm8996_dsi_cfg") new for v2.
- ("Fix number of regulators for SDM660") new for v2.
- ("Allow specifying an initial load w/ the bulk API") new for v2.
- ("Use the new regulator bulk feature to specify the load") new for v2.
- ("Allow drivers to define their init data as const") new for v2.
- ("Take advantage of devm_regulator_bulk_get_const") new for v2.

Douglas Anderson (7):
  drm/msm/dsi: Fix number of regulators for msm8996_dsi_cfg
  drm/msm/dsi: Fix number of regulators for SDM660
  drm/msm/dsi: Don't set a load before disabling a regulator
  regulator: core: Allow specifying an initial load w/ the bulk API
  drm/msm/dsi: Use the new regulator bulk feature to specify the load
  regulator: core: Allow drivers to define their init data as const
  drm/msm/dsi: Take advantage of devm_regulator_bulk_get_const()

 drivers/gpu/drm/msm/dsi/dsi.h                 |   1 -
 drivers/gpu/drm/msm/dsi/dsi_cfg.c             | 172 +++++++++---------
 drivers/gpu/drm/msm/dsi/dsi_cfg.h             |   3 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c            |  61 +------
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c         |  41 +----
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c    |   4 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c    |   6 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_20nm.c    |   4 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c    |   6 +-
 .../gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c   |   2 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c     |   6 +-
 drivers/regulator/core.c                      |  20 +-
 drivers/regulator/devres.c                    |  28 +++
 include/linux/regulator/consumer.h            |  16 +-
 14 files changed, 165 insertions(+), 205 deletions(-)

-- 
2.37.1.359.gd136c6c3e2-goog

