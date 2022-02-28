Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758B14C7A53
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 21:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiB1U0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 15:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiB1U0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 15:26:33 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B3D580D1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 12:25:53 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id e6so11134581pgn.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 12:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IxkmaZ+57/7rrIIgKIMooVvVx5aXtgitFuA8j/9jgsk=;
        b=cS0SmD0B0NxCV3Q45NQ/VtLDvLZelBQYVQZXYDdCRvvM6vXLNNFqwqPGdPiYhPUPvU
         M53Jj8VCV6nBW7hnBsV94StTXTNlrFTUjkcfFJSBPaVfkqj/IOmjbfEduBsd/42j/YZm
         VbX0WM5rJfZtErjnYmNmSWFG7M2e7KqSXzMBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IxkmaZ+57/7rrIIgKIMooVvVx5aXtgitFuA8j/9jgsk=;
        b=27I0vzgArGOv1qATObYHu/wmhIYKZkfLOYnTeH9/vOmac3ZW0isTYzqN3caxk6Kn7h
         64Wy3t6Uj1QNfOtChKETk8m4W8vo18EdDDi43DVF028e8pO3th6m5Vr9wJU56FdZuJlz
         vmgKNHCBmgBVqR2e9P5lEWlEDuyhJeieqO3UUxeaMQMc7YYmwGjQOX3L1pETxb3fY5V9
         2ngQsN4aknci0l4wfKA28FW8NmUNGKfK+TLfaN5+7hPjf4f4qvK7+6LGhNOffxtKWw1X
         YXedkSaUM34J8gIdQSQPurFrUOAFhuFjcs6bnG0FjNJahmLM5NEqVsVYK7Vn96mv1lzt
         Rm3w==
X-Gm-Message-State: AOAM530piPRCYpmu/EQc7xkYPVsxM4xd/9DG17hNj61SLBzK9292NusD
        bXR+Ifr+A5nE8brlQb6YyTKODA==
X-Google-Smtp-Source: ABdhPJyMN412BOJNazpnH1z9WFUw3+OvKDL665fOFaq4H6C9nRW3XoPfkwVDIBH+M2majOKSdGlnxA==
X-Received: by 2002:a05:6a00:2313:b0:4e0:ffa7:bbe0 with SMTP id h19-20020a056a00231300b004e0ffa7bbe0mr23439387pfh.53.1646079953455;
        Mon, 28 Feb 2022 12:25:53 -0800 (PST)
Received: from localhost ([2620:15c:202:201:ba66:7507:a6af:82f1])
        by smtp.gmail.com with UTF8SMTPSA id c63-20020a624e42000000b004f414f0a391sm3567792pfb.79.2022.02.28.12.25.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 12:25:52 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Liu Ying <victor.liu@oss.nxp.com>
Subject: [PATCH v2 0/2] drm/bridge: analogix_dp: Self-refresh state machine fixes
Date:   Mon, 28 Feb 2022 12:25:30 -0800
Message-Id: <20220228202532.869740-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been investigating several eDP issues on a Rockchip RK3399 system
and have two proposed bugfixes. RK3399 has two CRTCs, either of which
can be used for eDP output. For both fixes, we have bugs due to the
relationship between the generalized "self refresh helpers" and the
analogix-dp bridge driver which controls much of the PSR mechanics.
These bugs are most visible when switching between CRTCs.

I'm not a DRM expert, but I've been poking at a lot of Rockchip display
drivers recently. I'd love some skeptical eyes, so feel free to ask
questions if I haven't explained issues well, or the proposals look
fishy.

Regards,
Brian

Changes in v2:
- Drop "->enable" condition in crtc_needs_disable(); this could possibly
  be "->active" to reflect the intended hardware state, but it also is a
  little over-specific. We want to make a transition through "disabled"
  any time we're exiting PSR at the same time as a CRTC switch.
  (Thanks Liu Ying)

Brian Norris (2):
  drm/bridge: analogix_dp: Support PSR-exit to disable transition
  drm/atomic: Force bridge self-refresh-exit on CRTC switch

 .../drm/bridge/analogix/analogix_dp_core.c    | 42 +++++++++++++++++--
 drivers/gpu/drm/drm_atomic_helper.c           | 16 +++++--
 2 files changed, 51 insertions(+), 7 deletions(-)

-- 
2.35.1.574.g5d30c73bfb-goog

