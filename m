Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9693560EDC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 03:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiF3B53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 21:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiF3B5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 21:57:25 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E173CA57;
        Wed, 29 Jun 2022 18:57:24 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v193-20020a1cacca000000b003a051f41541so699130wme.5;
        Wed, 29 Jun 2022 18:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qdKdTCtNsd2q3yyCl80PhBz12PXESIt3xwlp2rRhZIk=;
        b=KfF7ZFS9NFrkWlDud9w6rtd3isEKK9vmUWsziwc0EV5Huqhp1flNzs0am0DuEEOQol
         tOCjaro4iaqz8UI3gnD/rkVRBf7ThztHSuroaeLhff4beHX4q8fjsNK8GnxXqe1/Qvx6
         VdpS2eBp7V8PCFUASKDsYNg4C+cIJodeuVf5ftKL2MvRO4LHTeLt6nKf3BM8ENbn2Zjq
         CYmYge8IwsXS4D1iVOpLJpWr4jdip2ZlF3lJ3X9s0dx1IbH5r9pDD7oAgx++vQywcxFI
         b0LN+f2FoicBllLiGsaot4hBT4q9DPf7xHRS20A+Jc6vhRMphbBjErvwhzeKlIf/dkoW
         WIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qdKdTCtNsd2q3yyCl80PhBz12PXESIt3xwlp2rRhZIk=;
        b=u437/Rn8wSJlmzHTs2v4sxeYcS4vA5ub51Yd2lJW+N/wpv3YFbdkEY77dFNitJ03FM
         h+AgiafXl3IUMemI9IaQsBEdai7exjSj4FgFYm4h9A3VvhS8nNx39wU6MY6Uq48CaXrW
         uAl69yQQ8ArY9EbxGt7AXOdVkPFQVfiM7DnM+3bEZFnE0oKgUJB9dg/F/Mz8WJjxWllN
         AaIA2iA14DmUeKnXumVBS280wwDE3dtj1Q9dqBRmY3zArZpu0pd6Ituyqfe+34/mib5U
         8xwuAgnYztfZZUUmeITPAcZrVU/jbY/iPaIEVpAfBcBQPM7reBkDHglsqLGSBf5q5RoK
         H3Zw==
X-Gm-Message-State: AJIora9+HezrJaR/++dBj3xFtGv/iSyVXjLM6VGJxFW+Gd6BzVlFz2QV
        5mABIKUJqxW/ACWzb+uKEgiyLbhAO78k7+pT3hQ=
X-Google-Smtp-Source: AGRyM1tn/QWXIm16gupv6o40jn+N+JJwF8Z/jp2zMOHOjRGrHGQB29zHDzYlhwKzaQHPb6wFJtXnIqkm9WmNIcgtKzI=
X-Received: by 2002:a05:600c:4f83:b0:3a1:7310:62e7 with SMTP id
 n3-20020a05600c4f8300b003a1731062e7mr4908639wmq.84.1656554243027; Wed, 29 Jun
 2022 18:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <1656429606-2765-1-git-send-email-quic_khsieh@quicinc.com>
 <F35C87BF-46A5-41D3-B8A5-B2AB4A24252D@linaro.org> <CAD=FV=X3cv=Q30pODyi__OyRY+LbFT14RfEELvm_DAeHafF70g@mail.gmail.com>
In-Reply-To: <CAD=FV=X3cv=Q30pODyi__OyRY+LbFT14RfEELvm_DAeHafF70g@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 29 Jun 2022 18:57:35 -0700
Message-ID: <CAF6AEGvFYK3x_CmErkKsmYNEv9y8AksE9UB_sfp-Z7RieX=tVg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: make eDP panel as the first connected connector
To:     Doug Anderson <dianders@chromium.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 5:36 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Jun 28, 2022 at 1:14 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On 28 June 2022 18:20:06 GMT+03:00, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
> > >Some userspace presumes that the first connected connector is the main
> > >display, where it's supposed to display e.g. the login screen. For
> > >laptops, this should be the main panel.
> > >
> > >This patch call drm_helper_move_panel_connectors_to_head() after
> > >drm_bridge_connector_init() to make sure eDP stay at head of
> > >connected connector list. This fixes unexpected corruption happen
> > >at eDP panel if eDP is not placed at head of connected connector
> > >list.
> >
> > The change itself is a good fix anyway. (And I'd ack it.) However I would like to understand why does it fix the corruption issue. What is we have eDP and DSI, with DSI ending up before the eDP? Would we see the issue?
> > Also could you please describe the mind of corruption you are observing?
>
> I've spent a whole bunch of time poking at this and in the end my
> conclusion is this:
>
> 1. The glitchyness seems to be a result of the Chrome OS userspace
> somehow telling the kernel to do something wrong.
>
> 2. I believe (though I have no proof other than Kuogee's patch fixing
> things) that the Chrome OS userspace is simply confused by the eDP
> connector being second. This would imply that Kuogee's patch is
> actually the right one.
>
> 3. It would be ideal if the Chrome OS userspace were fixed to handle
> this, but it's an area of code that I've never looked at. It also
> seems terribly low priority to fix since apparently other OSes have
> similar problems (seems like this code was originally added by
> RedHat?)
>
>
> Specifically, I tested with a similar but "persistent" glitch that I
> reproduced. The glitch Kuogee was digging into was a transitory glitch
> on the eDP (internal) display when you plugged in a DP (external)
> display. It would show up for a frame or two and then be fixed. I can
> get a similar-looking glitch (vertical black and white bars) that
> persists by doing these steps on a Chrome OS device (and Chrome OS
> kernel):
>
> a) Observe screen looks good.
> b) Observe DP not connected.
> c) Plug in DP
> d) See transitory glitch on screen, then it all looks fine.
> e) set_power_policy --ac_screen_dim_delay=5 --ac_screen_off_delay=10
> f) Wait for screen to turn off
> g) Unplug DP
> h) Hit key on keyboard to wake device.
> i) See glitchy.
> j) Within 5 seconds: set_power_policy --ac_screen_dim_delay=5000
> --ac_screen_off_delay=10000
>
> Once I'm in the persistent glitch:
>
> * The "screenshot" command in Chrome OS shows corruption. Not exactly
> black and white bars, but the image produced has distinct bands of
> garbage.
>
> * I can actually toggle between VT2 and the main screen (VT1). Note
> that VT1/VT2 are not quite the normal Linux managed solution--I
> believe they're handled by frecon. In any case, when I switch to VT2
> it looks normal (I can see the login prompt). Then back to VT1 and the
> vertical bars glitch. Back to VT2 and it's normal. Back to VT1 and the
> glitch again. This implies (especially with the extra evidence of
> screenshot) that the display controller hardware is all fine and that
> it's the underlying data that's somehow messed up.

fwiw, from looking at this a bit w/ Doug, I think the "glitch" is
simply just an un-renderered buffer being interpreted by the display
controller as UBWC (because userspace tells it to)

BR,
-R

> When I pick Kuogee's patch then this "persistent" glitch goes away
> just like the transitory one does.
>
> I'm going to go ahead and do:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Tested-by: Douglas Anderson <dianders@chromium.org>
