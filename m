Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65EE517B97
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 03:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiECBRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 21:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiECBRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 21:17:01 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474E046B15
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 18:13:30 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-e2442907a1so15927378fac.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 18:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=qclzEzb88Rc+t48ko4XJR5J/G6hNGvffLYAtLNLjtGg=;
        b=oMv1VPZrM/ZMi0f31QB0gucXh6+DhBnn6+/swVv6D98hjF8pWpFV/xn5gE3d794mEC
         xObGXS8eh3MuWnUQHgWMshigJKgs98S9V0q5/CrKww50GnqZclCKCDZCXv+QI3uY6/R1
         irOU7irFy7w78/DZbonvKxn9PXcauIBf0eWqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=qclzEzb88Rc+t48ko4XJR5J/G6hNGvffLYAtLNLjtGg=;
        b=F5awS4QKq3o+f2l49f+MnP0tJloU3Q2okQ/uCoZOhPitghs1m2zGap7hVda9ziXJ0x
         nUIafIhnfj+PPLQAz/jbpWn9dmXfEDUoGMlhC0NeTF/Ligj/xkAbVjREBZmtX5VfjpeV
         KBErGPxodN2GJ7umhsYVTL1CHwRbx1kMD3kKh5NxceFbU/fxznEy5k9L8BMd9J0QMAe0
         M4nZSgNLbA7suQwDdvtacLPVpAEQOW2UYPncuWrAXZfR5xIMf2JyqSzUbJf3fZViJMXq
         O9qSsZufovtFBwAws6RdEVHwnFCmtaDoNQfg/Q6Du1lRAreHs6AUUCMYdynsXeZVOhkP
         zxSw==
X-Gm-Message-State: AOAM531zZEBzJ/wUhzQrNOis9BmJxBL4cgjoHOWns/f/M+hEk6++Vh8O
        bmZqOKExAksnB++k0q6YjyO/c9WGo259JdJpQUKA6Q==
X-Google-Smtp-Source: ABdhPJwH+KZOm2Y5mOS6pSMlAX2uuDmmCWPtK1tWF+fVhA7rmbH21MIi1mlPWosYQGBdHKh+DYu5bVsrhYOdvZpQNY8=
X-Received: by 2002:a05:6870:40c1:b0:ed:9a12:3f95 with SMTP id
 l1-20020a05687040c100b000ed9a123f95mr806123oal.193.1651540409644; Mon, 02 May
 2022 18:13:29 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 May 2022 18:13:29 -0700
MIME-Version: 1.0
In-Reply-To: <1651532668-18873-1-git-send-email-quic_khsieh@quicinc.com>
References: <1651532668-18873-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 2 May 2022 18:13:29 -0700
Message-ID: <CAE-0n51TjqYKzPbP7JHKi+ostwM7Q8FX64eC3Gufuz846mLA3g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dp: fix event thread stuck in wait_event after kthread_stop()
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dianders@chromium.org, dmitry.baryshkov@linaro.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Quoting Kuogee Hsieh (2022-05-02 16:04:28)
> Event thread supposed to exit from its while loop after kthread_stop().
> However there may has possibility that event thread is pending in the
> middle of wait_event due to condition checking never become true.
> To make sure event thread exit its loop after kthread_stop(), this
> patch OR kthread_should_stop() into wait_event's condition checking
> so that event thread will exit its loop after kernal_stop().
>
> Changes in v2:
> --  correct spelling error at commit title
>
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Fixes: 570d3e5d28db ("drm/msm/dp: stop event kernel thread when DP unbind")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index c388323..5200a58 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1106,12 +1106,17 @@ static int hpd_event_thread(void *data)
>         while (!kthread_should_stop()) {
>                 if (timeout_mode) {
>                         wait_event_timeout(dp_priv->event_q,
> -                               (dp_priv->event_pndx == dp_priv->event_gndx),
> -                                               EVENT_TIMEOUT);
> +                               ((dp_priv->event_pndx == dp_priv->event_gndx) ||

Why the parenthesis (before and after)?

> +                                       kthread_should_stop()), EVENT_TIMEOUT);
>                 } else {
>                         wait_event_interruptible(dp_priv->event_q,
> -                               (dp_priv->event_pndx != dp_priv->event_gndx));
> +                               ((dp_priv->event_pndx != dp_priv->event_gndx) ||

Why the parenthesis (before and after)?

> +                                       kthread_should_stop()));
>                 }
> +
> +               if(kthread_should_stop())

Missing space after if

> +                       break;

Is it possible to move the wait_event to the end of the loop and always
run the loop initially? That way we don't have to check for
kthread_should_stop() again.
