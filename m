Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A9751A2AE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 16:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351568AbiEDO5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 10:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351559AbiEDO5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 10:57:44 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A322250A
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 07:54:08 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id j6so3345932ejc.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 07:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3CqMewY2qLhNoVYy8pnABiQEXDBLwdmzuZuCQ9llcqA=;
        b=JIZF4JLztNOcNEo4SWDoc3uVBUY3XVnnSRMHtEmNqfbINrHZhs+RqZgaXWlLYQJKBz
         45bRnisHROq/k5C6gSZLnuw+1KoJTn9/H2tf+974HGCcSzHB5rcmKSJEgIto4cJK9HKy
         8MAoyaI0cOrY6W4KqDLMFN54Jrif7hydeiZrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3CqMewY2qLhNoVYy8pnABiQEXDBLwdmzuZuCQ9llcqA=;
        b=cypvpUmbXIwri0Rr907KE+Gs0+XV0hmDQwTEFxcGRpT+IB25XKeTTmTTO4fGP7t1mj
         ZJ3t9X3ndF7C94VlaD+TiamGnkFSXXXfu9YxenAupoIecB7PEr6dv6owNxp1WDPVSBKz
         QjkO140Rvt5fnmkxA5fAqfdUjNLeurhXNtQg/ZcxGnUi5vS3PR6gxMEPfZYcbEgS0Skn
         /byiIUYs6DXUHRMZxKK7mUonxL8ZmGyadIMfcTuc0ZViZPsp0WdeBNsq0lyfUfDbJgJ7
         Q0PMyzxnpRZtThPois+evKNry1kXkqnyQz0xSKslX7bKVRPaX4WP+MNaNL58mEtViNSc
         gE/A==
X-Gm-Message-State: AOAM530gLdlrzhfkwOZonswuwoHIAq8M0Pg7JWbbFL6aUdQg3wMpJK9q
        FGuNNNKDcGmuasaRCIat+r4Dr0rY+4/HfQCIZgE=
X-Google-Smtp-Source: ABdhPJx9GEk3z3nW26GT/ex86vaMgAeHwUh3ICZ78ocxIT+DW2+8Wd7eZDQeAcXqk72fuQN+A5EnXA==
X-Received: by 2002:a17:907:1b25:b0:6da:8206:fc56 with SMTP id mp37-20020a1709071b2500b006da8206fc56mr20289606ejc.81.1651676048035;
        Wed, 04 May 2022 07:54:08 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id jl3-20020a17090775c300b006f3ef214e55sm5798507ejc.187.2022.05.04.07.54.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 07:54:07 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id x18so2422796wrc.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 07:54:06 -0700 (PDT)
X-Received: by 2002:a5d:6d09:0:b0:20c:53a9:cc30 with SMTP id
 e9-20020a5d6d09000000b0020c53a9cc30mr15857966wrq.513.1651676045944; Wed, 04
 May 2022 07:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220503224029.3195306-1-dianders@chromium.org>
 <20220503153850.v2.1.I4182ae27e00792842cb86f1433990a0ef9c0a073@changeid> <d4541684-337f-4c3f-fafa-a883be370c0e@linaro.org>
In-Reply-To: <d4541684-337f-4c3f-fafa-a883be370c0e@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 4 May 2022 07:53:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XMuUELUbLEuzG_r0J2+82gKxNLe5KTsvFBK2hNhKnLHQ@mail.gmail.com>
Message-ID: <CAD=FV=XMuUELUbLEuzG_r0J2+82gKxNLe5KTsvFBK2hNhKnLHQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/dp: Add callbacks to make using DP AUX bus
 properly easier
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Philip Chen <philipchen@chromium.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Lyude Paul <lyude@redhat.com>,
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

On Wed, May 4, 2022 at 3:41 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> > - We had forgotten a EXPORT_SYMBOL_GPL on the non "devm" populate
> >    function.
>
> This can go to a separate patch, so that the fix can be backported to
> earlier kernels. Please don't forget the Fixes: tag.

Sure. Will do for v3.


> > -EXPORT_SYMBOL_GPL(of_dp_aux_depopulate_ep_devices);
> > +EXPORT_SYMBOL_GPL(of_dp_aux_depopulate_ep_device);
>
> Small note about the name. What if we change that to something more
> future-proof? Something like of_dp_aux_depopulate_bus() (and similarly
> rename other calls)?

Will do for v3.

> > +     /*
> > +      * If no parent "of_node", no "aux-bus" child node, or no available
> > +      * children then we're done. Call the callback (if needed) and return.
> > +      *
> > +      * NOTE: we intentionally pass the return code from done_probing
> > +      * directly out here. eDP controller drivers may want to support
> > +      * panels from old device trees where the panel was an independent
> > +      * platform device. In that case it's expected that done_probing()
> > +      * might need to return -EPROBE_DEFER to our caller.
> > +      */
> > +     if (!np) {
> > +             if (done_probing)
> > +                     return done_probing(aux);
>
> I see your point here (and that it makes code simpler). However I'm a
> little bit uneasy here. What if code this more explicitly in the
> drivers? Like the following:
>
> if (!dev_has_aux_bus()) {
>         ret = panel_ready(....);
> } else {
>         ...
>         ret = of_dp_aux_populate_ep_device(dp_aux, panel_ready);
>         ....;
> }

Yeah, I had considered that and was about 50-50. You think I should
change it? Is it really easier to understand if we break it up like
this? I'll wait for a response from you, but if I don't hear anything
then I'll change this as you suggest.


> This way you won't have to worry about the EPROBE_DEFER. Or you'd rather
> forbid it explicitly. Why? Consider the following scenario:
>
> dp_driver_probe()
>    /* This creates new devices */
>    done_probing returns -EPROBE_DEFER
>    /* device registration is unwound */
>    dp_driver_probe returns -EPROBE_DEFER
>
> However as the state of devices was chagned, the dp_driver_probe() can
> be called again and again, ending up with the the same probe loop that
> we are trying to solve.

Actually, I'm not sure we'd necessarily end up the loop we're trying
to solve. Let's see. If the panel probe itself doesn't create any
sub-devices and neither does done_probing() then done_probing()
returning -EPROBE_DEFER shouldn't cause any looping, right? It would
look just as if the panel returned -EPROBE_DEFER.

So I guess one could argue that _perhaps_ we don't need to forbid
-EPROBE_DEFER from done_probing()? It'd probably work OK (we'd
eventually retry probing the panel and call done_probing() once more
devices were added), but it'd be ugly and the system would report
(/sys/kernel/debug/devices_deferred) that it was the panel that
deferred even though it was this extra callback.

I'm going to go ahead and say this is too hacky, though. Also as long
as Linux still has the probe loop when you create devices and return
-EPROBE_DEFER we can get stuck because the panel _can_ create
sub-devices. It can do this with DP AUX backlight.

So I guess the summary is: yes, I'm confident that we should forbid
-EPROBE_DEFER from being returned by done_probing() when called by
dp_aux_ep_probe()

-Doug
