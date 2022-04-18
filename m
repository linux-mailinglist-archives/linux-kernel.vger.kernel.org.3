Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5C1505D2E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346651AbiDRRBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbiDRRBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:01:16 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD9B28D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:58:33 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id n33-20020a17090a5aa400b001d28f5ee3f9so3076006pji.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=491sLULzmlGZnrq6QIx86Myu+Z77mq9pr9+v487F+bc=;
        b=QFsNDmtLuRa8MARzTxIBlKpbwIsun1m3TqhOR6KBJKvXP7MAV5jxqdk6qXKe2xt/3i
         a0fvl5/4Mw6KLGK0NzvPor5GsPdOFKCHkeA4zVFanozzPvoPvW44XnudvbydI1MzMHbm
         hiv8uEFEFeAV13WJsHfXG/E6U1eqnhYUkvZeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=491sLULzmlGZnrq6QIx86Myu+Z77mq9pr9+v487F+bc=;
        b=AQWrzsQ6raPl4306vvSedwRT96x23Iux0mUKe3IdQug9tcht/vmOz+DdBKmhq6Lm9g
         ISuvmbGZd93hrNEhtrYgY4xQEzNlPKe5dUhi74UIuSTDz1AwrEtgvtPSfIZ7s6v1iaxk
         N20Dqbyk26DLxmKP+i20he13tJ9pJAw4FLBDMEGwrLtlurRNuIbzWU9IECwIaCbJj0D7
         yszHcA7fbscDaqLmljwQ+kZtuvwQzXXS65J6zAQIpIIbsOBKgyKh3feQyNb8xfozN69d
         cXDYuwyrx2MCB/TyqzJcivhzhzVWZ8jr2AzKtnc3QQlMEhggoqYeL7F/Hc0mgm0m1Dnm
         0PSw==
X-Gm-Message-State: AOAM532TXoihaxCpupziEAmksVmo95HwWE6jP2TSVjiO8+NIGK1DfyZG
        6/gGW8cmXJqfcmF8lbgQyNKAe3cUYbmQMf8H
X-Google-Smtp-Source: ABdhPJxJMuALfU4z0eS/x07j9x01pGshvsblfjUu+PvWZs9KC43EC1689mZc5oBSCn99eSsx7MuN9w==
X-Received: by 2002:a17:90a:d901:b0:1cb:97ae:636b with SMTP id c1-20020a17090ad90100b001cb97ae636bmr14153875pjv.60.1650301113070;
        Mon, 18 Apr 2022 09:58:33 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:94f4:f90:c59f:129b])
        by smtp.gmail.com with ESMTPSA id l8-20020a17090a150800b001cbaf536a3esm17700980pja.18.2022.04.18.09.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:58:32 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Philip Chen <philipchen@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
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
Subject: [PATCH v2 0/4] drm/dp: Introduce wait_hpd_asserted() for the DP AUX bus
Date:   Mon, 18 Apr 2022 09:56:38 -0700
Message-Id: <20220418165642.2218514-1-dianders@chromium.org>
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

 drivers/gpu/drm/bridge/parade-ps8640.c        | 34 ++++++++++-------
 drivers/gpu/drm/panel/panel-edp.c             | 33 +++++++++++-----
 .../gpu/drm/panel/panel-samsung-atna33xc20.c  | 38 ++++++++++++-------
 include/drm/dp/drm_dp_helper.h                | 26 +++++++++++++
 4 files changed, 95 insertions(+), 36 deletions(-)

-- 
2.36.0.rc0.470.gd361397f0d-goog

