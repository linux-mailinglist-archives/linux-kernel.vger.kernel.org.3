Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0ADD5540B9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 05:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356159AbiFVC7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 22:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354017AbiFVC7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 22:59:43 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF38A3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 19:59:42 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-101ab23ff3fso17130599fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 19:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=QkbVDi6oZOvTPDcMwZXGsoYfGdqUPPUk7tJ+2+elX5s=;
        b=THYrB1E9k91TCnr+V74Cuctr7fnR5f25+6XK/hEIc0Gif5IUpqNWE73dTSwmcJpggO
         XWrydg+/DLYqpayTOjK7lMa/upuYVQpdjRKb5oBp5LuXjA6bonQsm1/LJtNtWYqyqU3z
         qk+UkVZ+F0eEg6q0/uvotetNpCZcmBqTdYiso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=QkbVDi6oZOvTPDcMwZXGsoYfGdqUPPUk7tJ+2+elX5s=;
        b=r9e0oJJDEHDxiFylfYF2GjbhABF6CC6KOhKdssN9LOyC1h0zeOQM8PF9h5ZM/rITMh
         FSQMJo+p1usNyd705aglEALtGNAng5y+Y9Z2VadR1+From+OXUqz6Pf4oJ3EYiebALQD
         CVxFK4nB8hmUYHXs6X+khTnF05TR3mn+vUvS4lhmcKf90RXHxjLEm+GLuGGumkTJCnGN
         oTklfVVhzCKk4XwRMlBtP0K/VMZwYOnICkHvlLzl9HD2uGbicghc7qa0MaHYjM6XEzXe
         IOfs/Guj6LAK0BSmG9OrtGNeD5rI/dOl7dCYHLisazwf5a3tMvDAyvHwOFP1KPjgRo2J
         wDJQ==
X-Gm-Message-State: AJIora8EHfplCRWOk9Z4mx7HR1oVVPdNGYmaKN87udqWK+s2nBMBt6FT
        mvRtVc2b4MfEr8cuycb+j78GbX3Hp+FBLW6IsCW/FQ==
X-Google-Smtp-Source: AGRyM1uopL3zeCsqA5w30zHRns6v+RvwzmYQSxJqB4ZSOOW5tSWTRM/NTziAL3zCVDH56+dcJU0kjl17IwBIClIWsPs=
X-Received: by 2002:a05:6870:b627:b0:102:f25:a460 with SMTP id
 cm39-20020a056870b62700b001020f25a460mr748273oab.193.1655866781557; Tue, 21
 Jun 2022 19:59:41 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Jun 2022 22:59:41 -0400
MIME-Version: 1.0
In-Reply-To: <bb98ca29-8752-6864-ddbd-19547fb6f73b@linaro.org>
References: <20220617204750.2347797-1-swboyd@chromium.org> <20220617204750.2347797-3-swboyd@chromium.org>
 <bb98ca29-8752-6864-ddbd-19547fb6f73b@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 21 Jun 2022 22:59:41 -0400
Message-ID: <CAE-0n51_zysbkktVEfhvXtGqpADTWcaPBAX7A7rD1FV+vcK3Uw@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/msm/dp: Remove pixel_rate from struct dp_ctrl
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
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

Quoting Dmitry Baryshkov (2022-06-17 16:07:58)
> On 17/06/2022 23:47, Stephen Boyd wrote:
> > This struct member is stored to in the function that calls the function
> > which uses it. That's possible with a function argument instead of
> > storing to a struct member. Pass the pixel_rate as an argument instead
> > to simplify the code. Note that dp_ctrl_link_maintenance() was storing
> > the pixel_rate but never using it so we just remove the assignment from
> > there.
> >
> > Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >   drivers/gpu/drm/msm/dp/dp_ctrl.c | 57 ++++++++++++++++----------------
> >   drivers/gpu/drm/msm/dp/dp_ctrl.h |  1 -
> >   2 files changed, 28 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > index bd445e683cfc..e114521af2e9 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > @@ -1336,7 +1336,7 @@ static void dp_ctrl_set_clock_rate(struct dp_ctrl_private *ctrl,
> >                               name, rate);
> >   }
> >
> > -static int dp_ctrl_enable_mainlink_clocks(struct dp_ctrl_private *ctrl)
> > +static int dp_ctrl_enable_mainlink_clocks(struct dp_ctrl_private *ctrl, unsigned long pixel_rate)
>
>
> I think we can read pixel_rate here rather than getting it as an
> argument. We'd need to move handling (DP_TEST_LINK_PHY_TEST_PATTERN &&
> !ctrl->panel->dp_mode.drm_mode.clock) case here from dp_ctrl_on_link().

This is also called from dp_ctrl_on_stream() and
dp_ctrl_reinitialize_mainlink(). In the dp_ctrl_on_stream() case we may
divide the pixel_rate by 2 with widebus. We could move the
dp_ctrl_on_link() code here, but then we also need to move widebus, and
then I'm not sure which pixel rate to use.

It looks like the test code doesn't care about widebus? And similarly,
we may run the pixel clk faster until we get a modeset and then divide
it for widebus. Is that why you're suggesting to check
!ctrl->panel->dp_mode.drm_mode.clock? I hesitate because it isn't a
direct conversion, instead it checks some other stashed struct member.

I'll also note that dp_ctrl_enable_mainlink_clocks() doesn't really use
this argument except to print the value in drm_dbg_dp(). Maybe we should
simply remove it from here instead?

> > @@ -1588,12 +1586,12 @@ static int dp_ctrl_on_stream_phy_test_report(struct dp_ctrl *dp_ctrl)
> >   {
> >       int ret;
> >       struct dp_ctrl_private *ctrl;
> > +     unsigned long pixel_rate;
> >
> >       ctrl = container_of(dp_ctrl, struct dp_ctrl_private, dp_ctrl);
> >
> > -     ctrl->dp_ctrl.pixel_rate = ctrl->panel->dp_mode.drm_mode.clock;
> > -
> > -     ret = dp_ctrl_enable_stream_clocks(ctrl);
> > +     pixel_rate = ctrl->panel->dp_mode.drm_mode.clock;
> > +     ret = dp_ctrl_enable_stream_clocks(ctrl, pixel_rate);
>
> I think we can take another step forward here. Read the
> ctrl->panel->dp_mode.drm_mode.clock from within the
> dp_ctrl_enable_stream_clocks() function. This removes the need to pass
> pixel_rate as an argument here.

This is also affected by widebus and if the function is called from
dp_ctrl_on_stream() or dp_ctrl_on_stream_phy_test_report(). Maybe it
would be better to inline dp_ctrl_enable_stream_clocks() to the
callsites? That would probably simplify things because the function is
mostly a wrapper around a couple functions.
