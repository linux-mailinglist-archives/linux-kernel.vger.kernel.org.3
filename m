Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DF15257F3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 00:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359277AbiELWpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 18:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244764AbiELWpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 18:45:14 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B906283A07
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 15:45:13 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g23so7865820edy.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 15:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Jt3cP1a7pSTmIordOsQBiND5m8bbi2YpKIrE+mPhkM=;
        b=fqLHlnbObR2B44qlvG2vcl1goZgmgi7lfvQPG31LMzu9dt0+k98fCuYxRp94SkCDAO
         8T//3rqQrm8abKiJG3ZpIqAEadAUaaZKBzJ1E5YeB616jpa3OcM1h/xN0LwxtbEK8ceX
         K8z+UHj0qDRBrbvGthUjD4T+4NAKxStiQFaEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Jt3cP1a7pSTmIordOsQBiND5m8bbi2YpKIrE+mPhkM=;
        b=GjiM2/csAfXPTVj+EjVW35cvYXEte4jKmPCJdfRFtF/4wqwYMxcxL7wQ56Kn2P3y0v
         vox8lVOk2RvVJboFrYPjlEotADs0TpjMV3XgUrNc4qOvyDrMC8PcFL6jr60N0x2mZDpB
         jYhtHZ6OHoTUY87vkxUPlhEMU41nXRsAcxILPH2jOEM867aOYNPa1eO0QCTGdac5FG9q
         kOv2Jzk7G6FLD0QKXB48Ku0VkEkzRv9I+K70kyIHhi4xVHpDxAccZlYeS7A1wZh/7YvZ
         lOZo8QO4PPAn2qifyeAi+dBaXnAGl34C2+2DmWAQN1fAhVB9UBxXD15uPHwxSKeCKZb3
         K49Q==
X-Gm-Message-State: AOAM530okwZo/RZJNvsisjAu2G+BrpaQN2yeqJcRMJ0eeT5zD6pqBUsI
        v0VGprLkW9hu/FKi1pcgMISJel+LYyYbq0OR
X-Google-Smtp-Source: ABdhPJz6/rebx6KQLq1cZ9eh+Hne7S318Rw9Dypgy8ZEjbAJJshh0cnV5//E77ORw16OUh6prlXjwg==
X-Received: by 2002:a05:6402:3484:b0:428:1a5e:3d48 with SMTP id v4-20020a056402348400b004281a5e3d48mr37723335edc.401.1652395511693;
        Thu, 12 May 2022 15:45:11 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id jx8-20020a170907760800b006f3ef214da1sm193717ejc.7.2022.05.12.15.45.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 15:45:11 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id k2so9157774wrd.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 15:45:11 -0700 (PDT)
X-Received: by 2002:adf:f50d:0:b0:20a:e096:ef with SMTP id q13-20020adff50d000000b0020ae09600efmr1411987wro.679.1652395510552;
 Thu, 12 May 2022 15:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220512145954.v4.1.Ia196e35ad985059e77b038a41662faae9e26f411@changeid>
 <dd62b8a7-43b9-364a-a427-94d621648012@linaro.org> <a721e2e9-934e-3028-cb1a-047f6d5c5b1e@quicinc.com>
In-Reply-To: <a721e2e9-934e-3028-cb1a-047f6d5c5b1e@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 12 May 2022 15:44:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U_dfCzcW6kP9zH=pxOUAioTMwh7=0-_=zSAkX9hurZmg@mail.gmail.com>
Message-ID: <CAD=FV=U_dfCzcW6kP9zH=pxOUAioTMwh7=0-_=zSAkX9hurZmg@mail.gmail.com>
Subject: Re: [PATCH v4] drm/msm/dsi: don't powerup at modeset time for parade-ps8640
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        David Airlie <airlied@linux.ie>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>
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

On Thu, May 12, 2022 at 3:34 PM Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> On 5/12/2022 3:16 PM, Dmitry Baryshkov wrote:
> > On 13/05/2022 01:00, Douglas Anderson wrote:
> >> Commit 7d8e9a90509f ("drm/msm/dsi: move DSI host powerup to modeset
> >> time") caused sc7180 Chromebooks that use the parade-ps8640 bridge
> >> chip to fail to turn the display back on after it turns off.
> >>
> >> Unfortunately, it doesn't look easy to fix the parade-ps8640 driver to
> >> handle the new power sequence. The Linux driver has almost nothing in
> >> it and most of the logic for this bridge chip is in black-box firmware
> >> that the bridge chip uses.
> >>
> >> Also unfortunately, reverting the patch will break "tc358762".
> >>
> >> The long term solution here is probably Dave Stevenson's series [1]
> >> that would give more flexibility. However, that is likely not a quick
> >> fix.
> >>
> >> For the short term, we'll look at the compatible of the next bridge in
> >> the chain and go back to the old way for the Parade PS8640 bridge
> >> chip. If it's found that other bridge chips also need this workaround
> >> then we can add them to the list or consider inverting the condition.
> >>
> >> [1]
> >> https://lore.kernel.org/r/cover.1646406653.git.dave.stevenson@raspberrypi.com
> >>
> >>
> >> Fixes: 7d8e9a90509f ("drm/msm/dsi: move DSI host powerup to modeset
> >> time")
> >> Suggested-by: Rob Clark <robdclark@gmail.com>
> >> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >
> Yes, I think this is a better solution than a full revert
>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>
> I am curious to know why this doesnt work for parade but will not hold
> this patch back for that. We are initializing and turning on DSI PHY now
> before turning on the bridge chip which is actually better as we are
> putting PHY in a good state.
>
> So this should have been better, but somehow doesn't work.

I can't really explain it, but mostly because the Parade chip is just
a big black box. There have been several times when an OEM using this
bridge chip had one problem or another with getting the display to
turn on, then the parade FAE would make some magic tweak to the
firmware and it would be fixed. The current way that the Linux driver
is working is with pretty much zero configuration so I think this chip
bakes in a bunch of assumptions about the timings / signal coming from
the MIPI DSI side. It doesn't surprise me that changing the order like
this would confuse it.

In theory I believe the Parade chip can run in a less "automatic" mode
where everything is configured and controlled by Linux. I'd really
have preferred if we could have gotten that done, but it didn't end up
happening. :(

-Doug
