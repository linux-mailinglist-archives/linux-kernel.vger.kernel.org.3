Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F6551C42A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 17:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381390AbiEEPsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 11:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380861AbiEEPsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:48:33 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBA5532E2
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 08:44:53 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id g6so9527203ejw.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 08:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=quJEpHcp/xQptAms2+pqVJe+BALCjwpz/XJpAyA2rOQ=;
        b=LtUWKtWwjEvzaJgwc+Y/Pc6ZtJYCCkbtEkwMj1kQLWR6QFKfyiqJlhG7vN+64C/904
         xP1Ersi2F/t8PVceS5QerFuVP5j/3gPomyLsiSTKmZBksKXz8GSeR+BShI51vCfXE6u3
         smVhw88erVhJUBtIhFgT/WIVkntmQ4UTU7dtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=quJEpHcp/xQptAms2+pqVJe+BALCjwpz/XJpAyA2rOQ=;
        b=dLqTY8GMcuTp7/KGDhNP/ubR0DCt6QWrbw5c5NNWY6XC/F614G+3uRw07vX0RhT/UA
         9jPHJ13SsR2ExDIIR8//PNFkfYTKurzsX7EKomsVrKwUW8EGN7cpwgAILLvNaJNvXHmG
         kSd3ZxU2J05wJKu2xzUa3kHPTfRnKc1O++H6gzJNnwVKjp+XsHH/mg+GOfYLqBqLnTxr
         16EPTAht28LphyBT2gLf+AbO3yy7mrfL/rm+SAspOkp+YqFlE9DfJux6RrdqceiBJ2bU
         vCYQem+H75bcav4o9s8mW5RrI2TTRILU5XbphtKMYRrOiEBhre/26h3l/cqJXSvAvlT9
         5HOg==
X-Gm-Message-State: AOAM533KeOZnB0WzyjRbgnjo2nfchrjly9G1LFOw478gV9fF4FYKYenu
        e9lJRetJ4qLeUOuPXiNzUn//pp5ySByhsh7yQLo=
X-Google-Smtp-Source: ABdhPJxKXwl6ZJFnDaL2Q0PL46c2dGGZjXij8xAuSPN99bI1wm03YECZOl1wU6zDc1NZvEQSR2K43A==
X-Received: by 2002:a17:907:1b28:b0:6f0:836:89b0 with SMTP id mp40-20020a1709071b2800b006f0083689b0mr25815297ejc.379.1651765491567;
        Thu, 05 May 2022 08:44:51 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id ek25-20020a056402371900b0042617ba637asm955430edb.4.2022.05.05.08.44.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 08:44:50 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 129so2905645wmz.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 08:44:49 -0700 (PDT)
X-Received: by 2002:a05:600c:4f08:b0:391:fe3c:40e6 with SMTP id
 l8-20020a05600c4f0800b00391fe3c40e6mr5718669wmq.34.1651765489131; Thu, 05 May
 2022 08:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220426114627.1.I2dd93486c6952bd52f2020904de0133970d11b29@changeid>
 <20220426114627.2.I4ac7f55aa446699f8c200a23c10463256f6f439f@changeid>
In-Reply-To: <20220426114627.2.I4ac7f55aa446699f8c200a23c10463256f6f439f@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 5 May 2022 08:44:36 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XzGOGc8pMics4=idQeCuLYWxj=bHcic4NZa9+3qbqpbg@mail.gmail.com>
Message-ID: <CAD=FV=XzGOGc8pMics4=idQeCuLYWxj=bHcic4NZa9+3qbqpbg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/probe-helper: For DP, add 640x480 if all other
 modes are bad
To:     dri-devel <dri-devel@lists.freedesktop.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
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

Ville,

On Tue, Apr 26, 2022 at 11:47 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> As per Displayport spec section 5.2.1.2 ("Video Timing Format") says
> that all detachable sinks shall support 640x480 @60Hz as a fail safe
> mode.
>
> A DP compliance test expected us to utilize the above fact when all
> modes it presented to the DP source were not achievable. It presented
> only modes that would be achievable with more lanes and/or higher
> speeds than we had available and expected that when we couldn't do
> that then we'd fall back to 640x480 even though it didn't advertise
> this size.
>
> In order to pass the compliance test (and also support any users who
> might fall into a similar situation with their display), we need to
> add 640x480 into the list of modes. However, we don't want to add
> 640x480 all the time. Despite the fact that the DP spec says all sinks
> _shall support_ 640x480, they're not guaranteed to support it
> _well_. Continuing to read the spec you can see that the display is
> not required to really treat 640x480 equal to all the other modes. It
> doesn't need to scale or anything--just display the pixels somehow for
> failsafe purposes. It should also be noted that it's not hard to find
> a display hooked up via DisplayPort that _doesn't_ support 640x480 at
> all. The HP ZR30w screen I'm sitting in front of has a native DP port
> and doesn't work at 640x480. I also plugged in a tiny 800x480 HDMI
> display via a DP to HDMI adapter and that screen definitely doesn't
> support 640x480.
>
> As a compromise solution, let's only add the 640x480 mode if:
> * We're on DP.
> * All other modes have been pruned.
>
> This acknowledges that 640x480 might not be the best mode to use but,
> since sinks are _supposed_ to support it, we will at least fall back
> to it if there's nothing else.
>
> Note that we _don't_ add higher resolution modes like 1024x768 in this
> case. We only add those modes for a failed EDID read where we have no
> idea what's going on. In the case where we've pruned all modes then
> instead we only want 640x480 which is the only defined "Fail Safe"
> resolution.
>
> This patch originated in response to Kuogee Hsieh's patch [1].
>
> [1] https://lore.kernel.org/r/1650671124-14030-1-git-send-email-quic_khsieh@quicinc.com
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/gpu/drm/drm_probe_helper.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)

I think this patch is fairly safe / non-controversial, but someone
suggested you might have an opinion on it and another patch I posted
recently [1] so I wanted to double-check. Just to be clear: I'm hoping
to land _both_ this patch and [1]. If you don't have an opinion,
that's OK too.

Abhinav: I think maybe you're happy with this now? Would you be
willing to give a Reviewed-by?

[1] https://lore.kernel.org/r/20220426132121.RFC.1.I31ec454f8d4ffce51a7708a8092f8a6f9c929092@changeid

-Doug
