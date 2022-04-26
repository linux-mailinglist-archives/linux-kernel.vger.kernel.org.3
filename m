Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8E4510B18
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355326AbiDZVUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355320AbiDZVUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:20:50 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603CCC7EA8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:17:41 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id kq17so15446154ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9kkw3V+5MLt1m5hoiWQpBjrcDCFgA9bH0l/Cgz/5i0Y=;
        b=Txcqq+E8b1nvNJ4CwcrWa26tfFMXvfHJ7iCCQN/y84apAGGwg+cTZiM6tNGnwi8NN8
         YqCHSDs1QTWXOVdIb8o3vpidV6J1KG5vhrvazNJyCXuPp2Z8bk7YMerXHaiOcz7SJ9As
         zSn+Ek/XBNkz/Ip6nSNmEAvc0fpd6eP0+7OLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9kkw3V+5MLt1m5hoiWQpBjrcDCFgA9bH0l/Cgz/5i0Y=;
        b=oiGBiY2zB4IEPhKMrw4UMihS45w2b448wd4DceAITDvC9FG3vB7Fd/oRRO04rH1ax5
         uTEz0suXmjczIYi9MP1XK99wDMd/n6jQDVnE8ef0izgn+JaDnN3308zrQM9RnS6WRcmH
         a0gSTIF3AKP/sdhccHxzpVwgFJwEIXvI9N9UC68N2jJ+9l3kYFr+wnGYaZ9abdmJSI4t
         oeMT+lwTFsQAFWaciBMWhtJQR9cal9K+osKy1DzaNSkLKoUvtszqNrN7U3sstbThZkSZ
         L3uPQ+CegG/BJ81CyQw4m6B/5niJXyPgMt9weui4RyhAdHWE5j+iluNmtXinyiMxvL/8
         +j1A==
X-Gm-Message-State: AOAM533vcPQdM+bnJ23c+K8aSVobO0D8ST1viCMIk5eoe/k8Ze84FkvK
        goAn3QS6tUPIR6NxtlOQBfBROp/Bom2bA9i/DyU=
X-Google-Smtp-Source: ABdhPJxQ1jQJyULciZbwxys0ulVAtI3MCxQJu7e+MO+q/YL2yJJ+tMiaqAG6UHhwSJm0PCLGDZvgTQ==
X-Received: by 2002:a17:906:4787:b0:6f3:7e2a:ebfd with SMTP id cw7-20020a170906478700b006f37e2aebfdmr15380731ejc.243.1651007859577;
        Tue, 26 Apr 2022 14:17:39 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id d2-20020a170906040200b006e84213fdffsm5554653eja.201.2022.04.26.14.17.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 14:17:37 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id j15so13925734wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:17:37 -0700 (PDT)
X-Received: by 2002:a05:6000:1acb:b0:20a:a4b0:dbc8 with SMTP id
 i11-20020a0560001acb00b0020aa4b0dbc8mr19325351wry.513.1651007856493; Tue, 26
 Apr 2022 14:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220426114627.1.I2dd93486c6952bd52f2020904de0133970d11b29@changeid>
 <20220426114627.2.I4ac7f55aa446699f8c200a23c10463256f6f439f@changeid>
 <fa49384c-76a5-6686-7d4d-cf11f3e98c75@quicinc.com> <517f71e4-785f-ef6f-d30e-fb18974eed57@quicinc.com>
 <CAD=FV=Xn_uTOxvwTZsKnQN4651T1OuZNd-EQG0WqvDsFPz+4hQ@mail.gmail.com> <37b16e86-f726-bf26-98ba-6146b6835c04@quicinc.com>
In-Reply-To: <37b16e86-f726-bf26-98ba-6146b6835c04@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 26 Apr 2022 14:17:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XrmjwBz2v6MOuiQ8Gg0Ht+skJJmw80fvvxzvBN+Uqjyg@mail.gmail.com>
Message-ID: <CAD=FV=XrmjwBz2v6MOuiQ8Gg0Ht+skJJmw80fvvxzvBN+Uqjyg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/probe-helper: For DP, add 640x480 if all other
 modes are bad
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
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

On Tue, Apr 26, 2022 at 2:11 PM Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 4/26/2022 1:26 PM, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Apr 26, 2022 at 12:20 PM Abhinav Kumar
> > <quic_abhinavk@quicinc.com> wrote:
> >>
> >> Missed one more comment.
> >>
> >> On 4/26/2022 12:16 PM, Abhinav Kumar wrote:
> >>> Hi Doug
> >>>
> >>> One minor comment below.
> >>>
> >>> But otherwise, looking at this change this should work for us acc to me.
> >>>
> >>> We will test this out with our equipment and then provide R-b.
> >>>
> >>> Thanks
> >>>
> >>> Abhinav
> >>> On 4/26/2022 11:46 AM, Douglas Anderson wrote:
> >>>> As per Displayport spec section 5.2.1.2 ("Video Timing Format") says
> >>>> that all detachable sinks shall support 640x480 @60Hz as a fail safe
> >>>> mode.
> >>>>
> >>>> A DP compliance test expected us to utilize the above fact when all
> >>>> modes it presented to the DP source were not achievable. It presented
> >>>> only modes that would be achievable with more lanes and/or higher
> >>>> speeds than we had available and expected that when we couldn't do
> >>>> that then we'd fall back to 640x480 even though it didn't advertise
> >>>> this size.
> >>>>
> >>>> In order to pass the compliance test (and also support any users who
> >>>> might fall into a similar situation with their display), we need to
> >>>> add 640x480 into the list of modes. However, we don't want to add
> >>>> 640x480 all the time. Despite the fact that the DP spec says all sinks
> >>>> _shall support_ 640x480, they're not guaranteed to support it
> >>>> _well_. Continuing to read the spec you can see that the display is
> >>>> not required to really treat 640x480 equal to all the other modes. It
> >>>> doesn't need to scale or anything--just display the pixels somehow for
> >>>> failsafe purposes. It should also be noted that it's not hard to find
> >>>> a display hooked up via DisplayPort that _doesn't_ support 640x480 at
> >>>> all. The HP ZR30w screen I'm sitting in front of has a native DP port
> >>>> and doesn't work at 640x480. I also plugged in a tiny 800x480 HDMI
> >>>> display via a DP to HDMI adapter and that screen definitely doesn't
> >>>> support 640x480.
> >>>>
> >>>> As a compromise solution, let's only add the 640x480 mode if:
> >>>> * We're on DP.
> >>>> * All other modes have been pruned.
> >>>>
> >>>> This acknowledges that 640x480 might not be the best mode to use but,
> >>>> since sinks are _supposed_ to support it, we will at least fall back
> >>>> to it if there's nothing else.
> >>>>
> >>>> Note that we _don't_ add higher resolution modes like 1024x768 in this
> >>>> case. We only add those modes for a failed EDID read where we have no
> >>>> idea what's going on. In the case where we've pruned all modes then
> >>>> instead we only want 640x480 which is the only defined "Fail Safe"
> >>>> resolution.
> >>>>
> >>>> This patch originated in response to Kuogee Hsieh's patch [1].
> >>>>
> >>>> [1]
> >>>> https://lore.kernel.org/r/1650671124-14030-1-git-send-email-quic_khsieh@quicinc.com
> >>>>
> >>>>
> >>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >>>> ---
> >>>>
> >>>>    drivers/gpu/drm/drm_probe_helper.c | 26 +++++++++++++++++++++-----
> >>>>    1 file changed, 21 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/drm_probe_helper.c
> >>>> b/drivers/gpu/drm/drm_probe_helper.c
> >>>> index 819225629010..90cd46cbfec1 100644
> >>>> --- a/drivers/gpu/drm/drm_probe_helper.c
> >>>> +++ b/drivers/gpu/drm/drm_probe_helper.c
> >>>> @@ -476,7 +476,6 @@ int drm_helper_probe_single_connector_modes(struct
> >>>> drm_connector *connector,
> >>>>        const struct drm_connector_helper_funcs *connector_funcs =
> >>>>            connector->helper_private;
> >>>>        int count = 0, ret;
> >>>> -    bool verbose_prune = true;
> >>>>        enum drm_connector_status old_status;
> >>>>        struct drm_modeset_acquire_ctx ctx;
> >>>> @@ -556,8 +555,8 @@ int drm_helper_probe_single_connector_modes(struct
> >>>> drm_connector *connector,
> >>>>            DRM_DEBUG_KMS("[CONNECTOR:%d:%s] disconnected\n",
> >>>>                connector->base.id, connector->name);
> >>>>            drm_connector_update_edid_property(connector, NULL);
> >>>> -        verbose_prune = false;
> >>>> -        goto prune;
> >>>> +        drm_mode_prune_invalid(dev, &connector->modes, false);
> >>>> +        goto exit;
> >>>>        }
> >>>>        count = (*connector_funcs->get_modes)(connector);
> >>>> @@ -580,9 +579,26 @@ int
> >>>> drm_helper_probe_single_connector_modes(struct drm_connector *connector,
> >>>>            }
> >>>>        }
> >>>> -prune:
> >>>> -    drm_mode_prune_invalid(dev, &connector->modes, verbose_prune);
> >>>> +    drm_mode_prune_invalid(dev, &connector->modes, true);
> >>>> +    /*
> >>>> +     * Displayport spec section 5.2.1.2 ("Video Timing Format") says
> >>>> that
> >>>> +     * all detachable sinks shall support 640x480 @60Hz as a fail safe
> >>>> +     * mode. If all modes were pruned, perhaps because they need more
> >>>> +     * lanes or a higher pixel clock than available, at least try to add
> >>>> +     * in 640x480.
> >>>> +     */
> >>>> +    if (list_empty(&connector->modes) &&
> >>>> +        connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort) {
> >>>> +        count = drm_add_modes_noedid(connector, 640, 480);
> >>>> +        if (_drm_helper_update_and_validate(connector, maxX, maxY,
> >>>> &ctx)) {
> >>>> +            drm_modeset_backoff(&ctx);
> >>>> +            goto retry;
> >>>
> >>> Do we need another retry here? This will again repeat everything from
> >>> get_modes().
> >>> The fact that we are hitting this code is because we have already tried
> >>> that and this is already a second-pass. So I think another retry isnt
> >>> needed?
> >>
> >> This will help cover the case of 4.2.2.6 but not fix 4.2.2.1.
> >>
> >> For 4.2.2.1, we will have 0 modes and so the original DRM fwk code of
> >> adding all modes <= 1024x768 will kick in.
> >>
> >> Now, in that list, we will still need to pick/mark 640x480 as the
> >> preferred mode.
> >>
> >> We still need IGT for that.
> >
> > Are you sure you don't have those backwards? It seems like 4.2.2.6 is
> > the test case dealing with corrupt EDID and that's the one that will
> > still be broken, no? ...and corrupt EDID is still the case where we
> > have 0 modes.
>
> Yes indeed, sorry, I did have the numbers backwards.
> 4.2.2.6 will still be broken.
>
> >
> > In any case, let's see what people think about:
> >
> > https://lore.kernel.org/r/20220426132121.RFC.1.I31ec454f8d4ffce51a7708a8092f8a6f9c929092@changeid
>
> Yes sure. If it gets accepted, it will save us some IGT work.
>
> >
> > I've marked that one as RFC just because it seems like a bigger change
> > to existing behavior, though it still seems correct to me.
> >
> > NOTE: reading 4.2.2.6 more closely, it actually looks as if we're
> > actually supposed to be able to try various video modes one at a time
> > until we find one that works (or land on 640x480). Seems as if we're
> > supposed to be able to try the higher resolutions one at a time and we
> > can tell whether the sink "accepted" it by seeing if SINK_STATUS goes
> > to 1? I have no idea how that works with all the Linux APIs, though.
> >
>
> hmmm .... our equipment throws a warning if we dont sent 640x480. So
> perhaps just go with the "or land on 640x480" option.
>
> 0006.392.232: [WARNING] Source DUT failed to transmit a video stream
> using fail-safe mode
> 0006.392.491:   Received 1344 Htotal differs from fail-safe 800
> 0006.392.621:   Received 1024 Hactive differs from fail-safe 640
> 0006.392.750:   Received 296 Hstart differs from fail-safe 144
> 0006.392.868:   Received 136 Hsync width differs from fail-safe 96
> 0006.392.975:   Received 806 Vtotal differs from fail-safe 525
> 0006.393.099:   Received 768 Vactive differs from fail-safe 480
> 0006.393.229:   Received 6 Vsync width differs from fail-safe 2

Do you actually have code to implement the checking of SINK_STATUS?
I'm not aware of how that would work in Linux, which is why just
defaulting to 640x480 seems like a reasonable thing to do for now. The
test case actually says that you're allowed to try clock rates one at
a time (polling SINK_STATUS in DPCT) as long as you don't spend more
than 5 seconds on each clock rate. According to the test case if you
never saw SINK_STATUS in DPCT go to 1 then you should end at 640x480.
