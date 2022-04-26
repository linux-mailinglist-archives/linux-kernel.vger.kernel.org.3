Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74968510A69
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354950AbiDZU3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354825AbiDZU3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:29:40 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AC65675C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:26:30 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g23so16730537edy.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2511p8lKZKcGvrdWMgX+EBPJEHzSt9seRbYqac/RtCc=;
        b=hGaC+IKpJb4ZV+/ENuOXAUoomcMvR+upCE8ArlkpYy2b8mRmHTEsubcOgafG49YseP
         HkjfuuPrbfj0jJLzu8eNAa2qEfgNSd2/LiT0jOpAksb761IuBP5LFzmucDc7WpKcv2oz
         mU2cNpQEwya2VI/kRxFNNe1GpUFz8nIO94XqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2511p8lKZKcGvrdWMgX+EBPJEHzSt9seRbYqac/RtCc=;
        b=Lfc6NJkFA5sgA5BahokU0o2CkSLso4J3qc/iyDikgSqiMZmJfqvQtffTQOVpMBqKTm
         eWEZTkMyDr+1v5AU3AKqKbeGS5w8uy3DnSiCRNM4UDJ3AYtJ0+4itJQLUcEvf5dR5yxR
         mt9w5fDOQHQu6L2C/MjxmstLm0iMDrIFdQF+NOuVT7WH2683yCMEMRw66O5p443cx9It
         hnjwldUUkOTq0osnIh5WTw2x2xiz0rITgHeOfoYviQR69yPniEXTVPQI1zrJ3xCD/Xws
         q7K2sLp4Jo7Hu3+droh8OdO4PvXarb0nGEUoY/EfnUH5MSPICPm45Bso/NrFZCHP2hBK
         GupQ==
X-Gm-Message-State: AOAM5301o98Zo38MNVgCJyYkWmPwMw+9vblxTRO2mty9xhwGeu6Iv8Fj
        RyzupMnj+xaLGznIlvx6pUhf75iWC7c9Im5cvls=
X-Google-Smtp-Source: ABdhPJzqN8JnAu7eXLanqci+EwDotFHkrHpvK7O8TaSRw4iAGdmkeGLmZYFfx7dNrp8IiADpV/a1zQ==
X-Received: by 2002:aa7:c789:0:b0:413:605d:8d17 with SMTP id n9-20020aa7c789000000b00413605d8d17mr26317148eds.100.1651004788538;
        Tue, 26 Apr 2022 13:26:28 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id g21-20020a056402115500b00413c824e422sm6739136edw.72.2022.04.26.13.26.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 13:26:24 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id j15so13771143wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:26:23 -0700 (PDT)
X-Received: by 2002:a05:6000:c7:b0:20a:d8c1:d044 with SMTP id
 q7-20020a05600000c700b0020ad8c1d044mr11038520wrx.422.1651004783068; Tue, 26
 Apr 2022 13:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220426114627.1.I2dd93486c6952bd52f2020904de0133970d11b29@changeid>
 <20220426114627.2.I4ac7f55aa446699f8c200a23c10463256f6f439f@changeid>
 <fa49384c-76a5-6686-7d4d-cf11f3e98c75@quicinc.com> <517f71e4-785f-ef6f-d30e-fb18974eed57@quicinc.com>
In-Reply-To: <517f71e4-785f-ef6f-d30e-fb18974eed57@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 26 Apr 2022 13:26:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xn_uTOxvwTZsKnQN4651T1OuZNd-EQG0WqvDsFPz+4hQ@mail.gmail.com>
Message-ID: <CAD=FV=Xn_uTOxvwTZsKnQN4651T1OuZNd-EQG0WqvDsFPz+4hQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/probe-helper: For DP, add 640x480 if all other
 modes are bad
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 26, 2022 at 12:20 PM Abhinav Kumar
<quic_abhinavk@quicinc.com> wrote:
>
> Missed one more comment.
>
> On 4/26/2022 12:16 PM, Abhinav Kumar wrote:
> > Hi Doug
> >
> > One minor comment below.
> >
> > But otherwise, looking at this change this should work for us acc to me.
> >
> > We will test this out with our equipment and then provide R-b.
> >
> > Thanks
> >
> > Abhinav
> > On 4/26/2022 11:46 AM, Douglas Anderson wrote:
> >> As per Displayport spec section 5.2.1.2 ("Video Timing Format") says
> >> that all detachable sinks shall support 640x480 @60Hz as a fail safe
> >> mode.
> >>
> >> A DP compliance test expected us to utilize the above fact when all
> >> modes it presented to the DP source were not achievable. It presented
> >> only modes that would be achievable with more lanes and/or higher
> >> speeds than we had available and expected that when we couldn't do
> >> that then we'd fall back to 640x480 even though it didn't advertise
> >> this size.
> >>
> >> In order to pass the compliance test (and also support any users who
> >> might fall into a similar situation with their display), we need to
> >> add 640x480 into the list of modes. However, we don't want to add
> >> 640x480 all the time. Despite the fact that the DP spec says all sinks
> >> _shall support_ 640x480, they're not guaranteed to support it
> >> _well_. Continuing to read the spec you can see that the display is
> >> not required to really treat 640x480 equal to all the other modes. It
> >> doesn't need to scale or anything--just display the pixels somehow for
> >> failsafe purposes. It should also be noted that it's not hard to find
> >> a display hooked up via DisplayPort that _doesn't_ support 640x480 at
> >> all. The HP ZR30w screen I'm sitting in front of has a native DP port
> >> and doesn't work at 640x480. I also plugged in a tiny 800x480 HDMI
> >> display via a DP to HDMI adapter and that screen definitely doesn't
> >> support 640x480.
> >>
> >> As a compromise solution, let's only add the 640x480 mode if:
> >> * We're on DP.
> >> * All other modes have been pruned.
> >>
> >> This acknowledges that 640x480 might not be the best mode to use but,
> >> since sinks are _supposed_ to support it, we will at least fall back
> >> to it if there's nothing else.
> >>
> >> Note that we _don't_ add higher resolution modes like 1024x768 in this
> >> case. We only add those modes for a failed EDID read where we have no
> >> idea what's going on. In the case where we've pruned all modes then
> >> instead we only want 640x480 which is the only defined "Fail Safe"
> >> resolution.
> >>
> >> This patch originated in response to Kuogee Hsieh's patch [1].
> >>
> >> [1]
> >> https://lore.kernel.org/r/1650671124-14030-1-git-send-email-quic_khsieh@quicinc.com
> >>
> >>
> >> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >> ---
> >>
> >>   drivers/gpu/drm/drm_probe_helper.c | 26 +++++++++++++++++++++-----
> >>   1 file changed, 21 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/drm_probe_helper.c
> >> b/drivers/gpu/drm/drm_probe_helper.c
> >> index 819225629010..90cd46cbfec1 100644
> >> --- a/drivers/gpu/drm/drm_probe_helper.c
> >> +++ b/drivers/gpu/drm/drm_probe_helper.c
> >> @@ -476,7 +476,6 @@ int drm_helper_probe_single_connector_modes(struct
> >> drm_connector *connector,
> >>       const struct drm_connector_helper_funcs *connector_funcs =
> >>           connector->helper_private;
> >>       int count = 0, ret;
> >> -    bool verbose_prune = true;
> >>       enum drm_connector_status old_status;
> >>       struct drm_modeset_acquire_ctx ctx;
> >> @@ -556,8 +555,8 @@ int drm_helper_probe_single_connector_modes(struct
> >> drm_connector *connector,
> >>           DRM_DEBUG_KMS("[CONNECTOR:%d:%s] disconnected\n",
> >>               connector->base.id, connector->name);
> >>           drm_connector_update_edid_property(connector, NULL);
> >> -        verbose_prune = false;
> >> -        goto prune;
> >> +        drm_mode_prune_invalid(dev, &connector->modes, false);
> >> +        goto exit;
> >>       }
> >>       count = (*connector_funcs->get_modes)(connector);
> >> @@ -580,9 +579,26 @@ int
> >> drm_helper_probe_single_connector_modes(struct drm_connector *connector,
> >>           }
> >>       }
> >> -prune:
> >> -    drm_mode_prune_invalid(dev, &connector->modes, verbose_prune);
> >> +    drm_mode_prune_invalid(dev, &connector->modes, true);
> >> +    /*
> >> +     * Displayport spec section 5.2.1.2 ("Video Timing Format") says
> >> that
> >> +     * all detachable sinks shall support 640x480 @60Hz as a fail safe
> >> +     * mode. If all modes were pruned, perhaps because they need more
> >> +     * lanes or a higher pixel clock than available, at least try to add
> >> +     * in 640x480.
> >> +     */
> >> +    if (list_empty(&connector->modes) &&
> >> +        connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort) {
> >> +        count = drm_add_modes_noedid(connector, 640, 480);
> >> +        if (_drm_helper_update_and_validate(connector, maxX, maxY,
> >> &ctx)) {
> >> +            drm_modeset_backoff(&ctx);
> >> +            goto retry;
> >
> > Do we need another retry here? This will again repeat everything from
> > get_modes().
> > The fact that we are hitting this code is because we have already tried
> > that and this is already a second-pass. So I think another retry isnt
> > needed?
>
> This will help cover the case of 4.2.2.6 but not fix 4.2.2.1.
>
> For 4.2.2.1, we will have 0 modes and so the original DRM fwk code of
> adding all modes <= 1024x768 will kick in.
>
> Now, in that list, we will still need to pick/mark 640x480 as the
> preferred mode.
>
> We still need IGT for that.

Are you sure you don't have those backwards? It seems like 4.2.2.6 is
the test case dealing with corrupt EDID and that's the one that will
still be broken, no? ...and corrupt EDID is still the case where we
have 0 modes.

In any case, let's see what people think about:

https://lore.kernel.org/r/20220426132121.RFC.1.I31ec454f8d4ffce51a7708a8092f8a6f9c929092@changeid

I've marked that one as RFC just because it seems like a bigger change
to existing behavior, though it still seems correct to me.

NOTE: reading 4.2.2.6 more closely, it actually looks as if we're
actually supposed to be able to try various video modes one at a time
until we find one that works (or land on 640x480). Seems as if we're
supposed to be able to try the higher resolutions one at a time and we
can tell whether the sink "accepted" it by seeing if SINK_STATUS goes
to 1? I have no idea how that works with all the Linux APIs, though.

-Doug
