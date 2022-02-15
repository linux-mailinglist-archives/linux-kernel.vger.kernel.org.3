Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128AA4B7B71
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 00:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244704AbiBOXzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 18:55:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237886AbiBOXzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 18:55:01 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343A9F65FD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:54:51 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id j4so628277plj.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+nTGNa9s6u2rYcAhXWuxtwf4TTMMDST6LAdmBGRAZ9k=;
        b=gs536kU/AcOsO1s8ccJDa8Cl0nWLPsH7Kt25IJC2NXtxM4/uhdTZ7KeEnxZrtKMymL
         zH6keBd92K6elTWTQEjtZE6PdxQPQR8vAQAFW5ySaqRI73Yt09rfKaekwn1ZO5fl4OEO
         HBm2IfP4hQJkgGJLfWLHZdJG788fplKYLh48k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+nTGNa9s6u2rYcAhXWuxtwf4TTMMDST6LAdmBGRAZ9k=;
        b=lNsWR5dHDAxAPA+Erajnaaxxgf4sPhP/eOK+71/bGcz45b7OGu3mwHCcG/bRAm1J4X
         o0Gel1Lk0/tPHLm4A5rwjxo7mZyMoR2VmBLCx8TkPTSruSBWHavRjhzndIkofCZ/9ZKg
         i+Vsx28Xd7x1SwBS9NTbog3pR/sO6NvdgclyyKxTBqQhQVKEssRRo1PC6H+pVnsVzO7K
         33BEW5dj22tkk6Kqc+i1QUiUQwOW7yJMpzTqg4vQ065ySndG6aLewoM3T9tU1VJfEQO0
         xlN6GM44zHTbPC9DTSXhaCAFZz6f0qg3fpJZ3D4L+Z6cw9IAZqAv0IM85zzTwjz7fO6b
         EfRw==
X-Gm-Message-State: AOAM532xru6/+g+XyuJu/nCQM9rK1xA/uIc/puS8k7iKTIjOQ4HUV+of
        SyuACbk1MI5eN7j38ibDjBBbSA==
X-Google-Smtp-Source: ABdhPJyfgHzglRsCZcuCTEveJ50IZg7QeQSve0L8/LjgLavRV70CR8Eoi0SvPPKabLI0pw/ZoVXdZQ==
X-Received: by 2002:a17:90b:4c8e:b0:1b9:f99f:1218 with SMTP id my14-20020a17090b4c8e00b001b9f99f1218mr7174869pjb.75.1644969290754;
        Tue, 15 Feb 2022 15:54:50 -0800 (PST)
Received: from localhost ([2620:15c:202:201:97ca:4b5:7d22:b276])
        by smtp.gmail.com with UTF8SMTPSA id k5sm10176304pfu.180.2022.02.15.15.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 15:54:50 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>, Sean Paul <sean@poorly.run>,
        linux-kernel@vger.kernel.org, Sean Paul <seanpaul@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 0/2] drm/bridge: analogix_dp: Self-refresh state machine fixes
Date:   Tue, 15 Feb 2022 15:54:18 -0800
Message-Id: <20220215235420.1284208-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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


Brian Norris (2):
  drm/bridge: analogix_dp: Support PSR-exit to disable transition
  drm/atomic: Force bridge self-refresh-exit on CRTC switch

 .../drm/bridge/analogix/analogix_dp_core.c    | 42 +++++++++++++++++--
 drivers/gpu/drm/drm_atomic_helper.c           | 16 +++++--
 2 files changed, 51 insertions(+), 7 deletions(-)

-- 
2.35.1.265.g69c8d7142f-goog

