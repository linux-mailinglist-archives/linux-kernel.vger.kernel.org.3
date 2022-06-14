Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F2D54BD18
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352479AbiFNVym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbiFNVyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:54:39 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D822251F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:54:38 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id i64so9732404pfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4H4NUn2COrLp0xRa2CBlPVWg2u2KQwlrtLFJ1rLvcbY=;
        b=aPUqpJuTW2ZEhs8q222WyLL2uAmKddpR8yFqy+uAwQgI8aG3d4TujliIQh+rDF2M7j
         CF9baksp+VUo0+FVwURSragwSTKY/5p1A5mdjuLb98RN4LrqVKbnwoKIbpQja+ZEDN8a
         j0EB/NVbNwJojEqVwLhqEXG7H4veo0TiilYfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4H4NUn2COrLp0xRa2CBlPVWg2u2KQwlrtLFJ1rLvcbY=;
        b=AGfVyPeZ4JQFTuQ8mXLWTejvh6SvyqdobT7/YYEofrID6k6dlRMAWXqVUfCx/hzQcZ
         Qm6d+ck3mI7H2NULWX/1UwuBmrqvahHkCabzdIsEipalvhWTn8Ofjh+loaSFN6lLQkP2
         9lr8NbTx4F2hdGT04nP4ejvF82E76dCMet7xaHs22OCty0YbzFiJ7vkeE6BYb8D0JRbS
         vI/cD4+n68nRaCh8IZb+EgP3coo+vAnAj2cNla9Unb6N9udhLXygylrMmJUxAZ9nvZK3
         ArueG46RTnJ00a8RCJAlWnzvaWxNfQ5CpT78ry8gbBpVQvGiu9elBYdJU/r07RK9q670
         KYDg==
X-Gm-Message-State: AOAM531xibzE9vgTeextD/Yf3n88OSWA3WIfWGw4v9/uYu5z4l3gz6lU
        wK3aWRG5RMFap25lz5YQYQwUqQ==
X-Google-Smtp-Source: AGRyM1u/yF9eLDb7e/TJmxATeXtE5Z6AOnB/WD28MbfZxfTCpN9K62ERWgY38EUgexp8Ck6tiN1hEQ==
X-Received: by 2002:aa7:94a6:0:b0:51b:ddb8:1fcf with SMTP id a6-20020aa794a6000000b0051bddb81fcfmr6288329pfl.23.1655243678378;
        Tue, 14 Jun 2022 14:54:38 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f355:be2d:74b7:3c7c])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090264c200b0016641a646cbsm7668968pli.218.2022.06.14.14.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 14:54:38 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Philip Chen <philipchen@chromium.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Lyude Paul <lyude@redhat.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] drm/dp: Introduce wait_hpd_asserted() for the DP AUX bus
Date:   Tue, 14 Jun 2022 14:54:14 -0700
Message-Id: <20220614215418.910948-1-dianders@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Changes in v4:
- Add comment that caller powered up the panel.
- Comments now explain that we may wait longer due to debouncing.
- Mention in commit message debouncing vs. powering on timing.
- Rebased to handle the fact that the stuct moved files.
- Reorganized logic as per Dmitry's suggestion.

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

 drivers/gpu/drm/bridge/parade-ps8640.c        | 39 +++++++++-----
 drivers/gpu/drm/panel/panel-edp.c             | 33 ++++++++----
 .../gpu/drm/panel/panel-samsung-atna33xc20.c  | 51 ++++++++++++++-----
 include/drm/display/drm_dp_helper.h           | 30 +++++++++++
 4 files changed, 117 insertions(+), 36 deletions(-)

-- 
2.36.1.476.g0c4daa206d-goog

