Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30794505D65
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346910AbiDRRU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbiDRRUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:20:53 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFC624F18
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:18:14 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id t184so7005674pgd.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6VccAa3X7Ms6K2SzwVUd0nrVrjIkZMldYG3f21qBakQ=;
        b=Wu45mOMXTib78iHCt2WfxT3OuOVxcIwRYu2fpBCu2udIyfPFlb3hMAlwNmb216jy8Y
         5Jg4h1Jin8fkEiz/z0cXM5xK7/LFaJAPAmpC/Shk6Rkf7kf8H3FzrcxupEw6uEzhlZ4n
         xbK1PqTXijDz2ir1vKY2051TxWfLwrS2Nr9X4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6VccAa3X7Ms6K2SzwVUd0nrVrjIkZMldYG3f21qBakQ=;
        b=ecEI8OZhd3dTyrb7u/OJC/ja2RGcIVAMx+IkHaysMIQYgFaeR/hdTFHOdASnw/mVeH
         /VXEcpNKH7WmVqmocz5FAcDodx86wthgEiLlfaxoob+H6JZ5a7QzisWW6F/s5B2LJzuu
         zNuN6/HYynAx4UH/bx9KD6l+Nmns3dwhOJY6TjWmMYS0OoSDoJuTTMMYRU2QpPOMKFJw
         GHKiHP/v3Men9oJKUA0Dml6DmRMLFtO6OtnbtQb0lzswLzl6dU/jECuGlYhesoTl7MQo
         8drrcofPTi10e6ogVrehjzWf6cKtgRfV/RNsQqRiJGD4MTK/BsUb6TYorqH6oA5sac4Y
         8tmA==
X-Gm-Message-State: AOAM53177f1q7Q5zD/iVw//ut/nS5wp3aqn9kBDv/VM0d9RRBUjc91dF
        oKpwwDtWktM+7+pYoyjEurR7Qw==
X-Google-Smtp-Source: ABdhPJzcbIa5UELYyDPJfDv8jCV3cTdq5XTaYyI/3HgRDpS9aMCXHdRatp1W5hnnE3AxNjy5N3DCEg==
X-Received: by 2002:a05:6a00:b54:b0:50a:8eec:e449 with SMTP id p20-20020a056a000b5400b0050a8eece449mr1509710pfo.80.1650302293686;
        Mon, 18 Apr 2022 10:18:13 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:94f4:f90:c59f:129b])
        by smtp.gmail.com with ESMTPSA id n184-20020a6227c1000000b0050a3bbd36d6sm12152126pfn.204.2022.04.18.10.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:18:13 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Philip Chen <philipchen@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Kees Cook <keescook@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Lyude Paul <lyude@redhat.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] drm/dp: Introduce wait_hpd_asserted() for the DP AUX bus
Date:   Mon, 18 Apr 2022 10:17:53 -0700
Message-Id: <20220418171757.2282651-1-dianders@chromium.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 2nd four patches from my RFC series ("drm/dp: Improvements
for DP AUX channel") [1]. I've broken the series in two so we can make
progress on the two halves separately.

v2 of this series changes to add wait_hpd_asserted() instead of
is_hpd_asserted(). This allows us to move the extra delay needed for
ps8640 into the ps8640 driver itself.

The idea for this series came up during the review process of
Sankeerth's series trying to add eDP for Qualcomm SoCs [2].

This _doesn't_ attempt to fix the Analogix driver. If this works out,
ideally someone can post a patch up to do that.

[1] https://lore.kernel.org/r/20220409023628.2104952-1-dianders@chromium.org/
[2] https://lore.kernel.org/r/1648656179-10347-2-git-send-email-quic_sbillaka@quicinc.com/

Changes in v3:
- Don't check "hpd_asserted" boolean when unset.
- Handle errors from gpiod_get_value_cansleep() properly.

Changes in v2:
- Change is_hpd_asserted() to wait_hpd_asserted()

Douglas Anderson (4):
  drm/dp: Add wait_hpd_asserted() callback to struct drm_dp_aux
  drm/panel-edp: Take advantage of wait_hpd_asserted() in struct
    drm_dp_aux
  drm/panel: atna33xc20: Take advantage of wait_hpd_asserted() in struct
    drm_dp_aux
  drm/bridge: parade-ps8640: Provide wait_hpd_asserted() in struct
    drm_dp_aux

 drivers/gpu/drm/bridge/parade-ps8640.c        | 34 +++++++++------
 drivers/gpu/drm/panel/panel-edp.c             | 33 ++++++++++-----
 .../gpu/drm/panel/panel-samsung-atna33xc20.c  | 41 +++++++++++++------
 include/drm/dp/drm_dp_helper.h                | 26 ++++++++++++
 4 files changed, 98 insertions(+), 36 deletions(-)

-- 
2.36.0.rc0.470.gd361397f0d-goog

