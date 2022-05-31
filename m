Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CE8539865
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 23:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347871AbiEaVEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 17:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345208AbiEaVEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 17:04:22 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AD18E19D
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 14:04:21 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id v25so11120008eda.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 14:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KHYrrg1OiYZowD6aPazdTTV7Ju3sH7vUcubOYj24fu4=;
        b=UtRwpwucfDR8gD3L7SaGmezgIA5eG73xQodHXxNq0JxfaLvad7Zzy+Lt8+nRFoDSEz
         cDnX8R6alvDMA8xggJQdl89Yyl40Pi+iiv/q9jVII2cMZt/1qu/TD1lCliPIdELSeYqP
         7hpayhSqZL9lkCIf9aX7v909SxUuQrV+NkdbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KHYrrg1OiYZowD6aPazdTTV7Ju3sH7vUcubOYj24fu4=;
        b=mXsk7VuokoZEqHe3wpZ7OgaZoU8e9CxEHAvrnqWDY925yCoNMU2vfH0NMEEi9eUg8q
         AvtyA8uz55wiGCYVLBkwi6FtB15Re7+W8Jumm0xn0qYhyzQV5bbMfW8vn+byDyeWlqPS
         5KGVCNmuMk2qwMA/6sl5HI+INW71WAiiezYuk4XjRz7CRQKoxz2aWpdueY1RyS5Y4A9t
         iGxq63tFHr7vPxgumtyYr2lies9r2XiCYh3XxVy7s/nscwV98fmT8i7ksMd4kIwDz10g
         tyPvl8yGtqvaaRKUlMu4lHx5QpmT4VLM0Adj21JTaHPLOf6quBcXm2bCMcOwunSslQKJ
         PxYw==
X-Gm-Message-State: AOAM533uAK5hcFTzWjDqeEd96P2HsSbyGPfZ5dN6+q+axNCyr4C3opEx
        N3Fw71Uy/MfKJLT5Kn86umuLk2zBC1jsaBJo
X-Google-Smtp-Source: ABdhPJyF1DY+8xv779jrrrD+NVy2ELzSH60o+rTTL663sTlpO90XlGD1EqKhugeYDlvq1yxQVKVd+A==
X-Received: by 2002:a05:6402:5d5:b0:42b:deaf:b95f with SMTP id n21-20020a05640205d500b0042bdeafb95fmr28641974edx.256.1654031059302;
        Tue, 31 May 2022 14:04:19 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id a11-20020a056402236b00b0042dd4ccccf5sm3769134eda.82.2022.05.31.14.04.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 14:04:18 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id o9so8685091wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 14:04:18 -0700 (PDT)
X-Received: by 2002:a05:600c:acf:b0:397:345f:fe10 with SMTP id
 c15-20020a05600c0acf00b00397345ffe10mr25847322wmr.15.1654031047944; Tue, 31
 May 2022 14:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220510192944.2408515-1-dianders@chromium.org>
In-Reply-To: <20220510192944.2408515-1-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 31 May 2022 14:03:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W-gW_TMKKJA-5bCETp+KB4sAUDnMuGJMMTwAixb7Ho6w@mail.gmail.com>
Message-ID: <CAD=FV=W-gW_TMKKJA-5bCETp+KB4sAUDnMuGJMMTwAixb7Ho6w@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] drm/dp: Make DP AUX bus usage easier; use it on ps8640
To:     dri-devel <dri-devel@lists.freedesktop.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Philip Chen <philipchen@chromium.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Robert Foss <robert.foss@linaro.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lyude Paul <lyude@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 10, 2022 at 12:30 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> This patch is v3 of the first 2 patches from my RFC series ("drm/dp: Improvements
> for DP AUX channel") [1]. I've broken the series in two so we can make
> progress on the two halves separately.
>
> v2 of this series tries to incorporate all the feedback from v1. Hopefully
> things are less confusing and simpler this time around. The one thing that got
> slightly more confusing is that the done_probing() callback can't return
> -EPROBE_DEFER in most cases so we have to adjust drivers a little more.
>
> v3 takes Dmitry's advice on v2. This now introduces
> devm_drm_bridge_add() (in an extra patch), splits some fixups into
> their own patch, uses a new name for functions, and requires an
> explicit call to done_probing if you have no children.
>
> The idea for this series came up during the review process of
> Sankeerth's series trying to add eDP for Qualcomm SoCs [2].
>
> This _doesn't_ attempt to fix the Analogix driver. If this works out,
> ideally someone can post a patch up to do that.
>
> NOTE: I don't have any ps8640 devices that _don't_ use the aux panel
> underneath them, so I'm relying on code inspection to make sure I
> didn't break those. If someone sees that I did something wrong for
> that case then please yell!
>
> [1] https://lore.kernel.org/r/20220409023628.2104952-1-dianders@chromium.org/
> [2] https://lore.kernel.org/r/1648656179-10347-2-git-send-email-quic_sbillaka@quicinc.com/
>
> Changes in v3:
> - Adapt to v3 changes in aux bus.
> - Don't call done_probing() if there are no children; return -ENODEV.
> - Patch ("drm/bridge: Add devm_drm_bridge_add()") new for v3.
> - Patch ("drm/dp: Export symbol / kerneldoc fixes...") split for v3.
> - Split out EXPORT_SYMBOL and kerneldoc fixes to its own patch.
> - Use devm_drm_bridge_add() to simplify.
> - Used Dmitry's proposed name: of_dp_aux_populate_bus()
>
> Changes in v2:
> - Change to assume exactly one device.
> - Have a probe callback instead of an extra sub device.
> - Rewrote atop new method introduced by patch #1.
>
> Douglas Anderson (4):
>   drm/dp: Export symbol / kerneldoc fixes for DP AUX bus
>   drm/dp: Add callbacks to make using DP AUX bus properly easier
>   drm/bridge: Add devm_drm_bridge_add()
>   drm/bridge: parade-ps8640: Handle DP AUX more properly
>
>  drivers/gpu/drm/bridge/parade-ps8640.c   |  74 +++++---
>  drivers/gpu/drm/display/drm_dp_aux_bus.c | 211 +++++++++++++++--------
>  drivers/gpu/drm/drm_bridge.c             |  23 +++
>  include/drm/display/drm_dp_aux_bus.h     |  34 +++-
>  include/drm/drm_bridge.h                 |   1 +
>  5 files changed, 238 insertions(+), 105 deletions(-)

I'm hoping to get some review for this series. Anyone? Dmitry: I know
you looked at earlier versions of this series. I guess you're happy
enough with it now but don't feel enough ownership to give a full
Reviewed-by?

-Doug
