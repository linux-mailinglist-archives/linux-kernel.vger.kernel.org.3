Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B032F5241D3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 03:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349797AbiELBEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 21:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349787AbiELBEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 21:04:05 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEF36FD20
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:04:03 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2ebf4b91212so39932577b3.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U6tK8GPMBaPnPvzJJPFEhM/26woZfEa9DJERPsRxEgc=;
        b=O54KDau0H299Yh1PZu6Xhrp359vgu0EaCOr0TEQ/1KQCZW7p1D709aynAaO927QN3S
         UZUfHNwwZrp+1CFeN4XNOMaaS5M6mpBErWA+N68xAb9L61s0Qp/IiL64JvVWglGzVIFz
         u+oaHgKD8xuQLQtOLAqgHXTMm9jBCWEeGEPkVi0UwcKJwx80WSC4Z14THJl68l/5Z5U/
         YTvzfMCTynwmLcMaTlC2OgUByA+dLsYoiDZYirgkTXD0ospQCc1hCH9gkxMNRdVV3NcT
         kVmF/hkBFaWumtIL1U6f4E3gIUXkxbLnMgoclRCuzEk5r1MCW9iaNOSVxoKsHrknhHtQ
         9+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U6tK8GPMBaPnPvzJJPFEhM/26woZfEa9DJERPsRxEgc=;
        b=zBX/e5ys0x8dVvyEOAFQZsBxDbHdRpueI/tiLAFrTgx3jtZ7BTw3rYV0yf8Dh6wVaY
         7Dy6doaHB8xWeZrfMbcgu8doBLSHQp9H2o5ikEm49XD+wB13Aj9LoR+g+MSdDLlRy6V4
         TbZtvngs9E1fF7rt5D6VcQRP6t8RoOX61CSxMWsXR2NpbcIKYYCxR1h1wd3GtjWbsySR
         lWqBFVaI38yIZT+mKEQPrbOOeBarA1IPiM1LBj/zJqk5v2N6WSGzQDBg0h2n1CRJTLgy
         CEq++ZN39Men/BcistJHkhjFDQemI/5sgq01BNBM6ZSfKky/4lnx4nNxWiORcjbv8m39
         K4hw==
X-Gm-Message-State: AOAM531wwgpsBCr+/YuX9cjmaPUQCL2YJcjLaB5KKiqX7n13xz7pb99j
        7qz3iFMm0d9/gUHs56H3kqA45xvX3/b2EpGW4qPUTA==
X-Google-Smtp-Source: ABdhPJxcC7GLVrVLu5NCUf/TT8p1tHqKlLQAuai83vmfQMaboWPR/caZ0bZRwSbcggq7Pe9iZ8h/+m7oNv703gUkJgY=
X-Received: by 2002:a81:1d4e:0:b0:2f7:be8b:502e with SMTP id
 d75-20020a811d4e000000b002f7be8b502emr28547800ywd.278.1652317443088; Wed, 11
 May 2022 18:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <1652313768-16286-1-git-send-email-quic_khsieh@quicinc.com>
 <e5c16697-5919-bafa-4ec5-294c94d7a740@linaro.org> <CAE-0n53zHrczQAOWM5f_tafUVJxg7JU2NuC4sGcBZddwKr-dGA@mail.gmail.com>
In-Reply-To: <CAE-0n53zHrczQAOWM5f_tafUVJxg7JU2NuC4sGcBZddwKr-dGA@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 12 May 2022 04:03:51 +0300
Message-ID: <CAA8EJppc9d+FjVzAX_KU2-akTc1vSmSHMeKr8dp2ynH2LLOyBQ@mail.gmail.com>
Subject: Re: [PATCH v5] drm/msm/dp: Always clear mask bits to disable
 interrupts at dp_ctrl_reset_irq_ctrl()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dianders@chromium.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org, quic_abhinavk@quicinc.com,
        quic_aravindh@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 at 04:01, Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Dmitry Baryshkov (2022-05-11 17:41:50)
> > On 12/05/2022 03:02, Kuogee Hsieh wrote:
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > index af7a80c..f3e333e 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > @@ -1389,8 +1389,13 @@ void dp_ctrl_reset_irq_ctrl(struct dp_ctrl *dp_ctrl, bool enable)
> > >
> > >       dp_catalog_ctrl_reset(ctrl->catalog);
> > >
> > > -     if (enable)
> > > -             dp_catalog_ctrl_enable_irq(ctrl->catalog, enable);
> > > +     /*
> > > +      * all dp controller programmable registers will not
> > > +      * be reset to default value after DP_SW_RESET
> > > +      * therefore interrupt mask bits have to be updated
> > > +      * to enable/disable interrupts
> > > +      */
> > > +     dp_catalog_ctrl_enable_irq(ctrl->catalog, enable);
> > >   }
> > >
> > >   void dp_ctrl_phy_init(struct dp_ctrl *dp_ctrl)
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > > index c388323..79439b8 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > > @@ -98,6 +98,8 @@ struct dp_display_private {
> > >       struct dp_ctrl    *ctrl;
> > >       struct dp_debug   *debug;
> > >
> > > +     atomic_t suspended;
> >
> > I think it'd be better to protect it with event_lock rather than using
> > atomics.
>
> Agreed. I think the concern is that the event queue will have "stuff" in
> it. If the event queue was all a threaded irq we could simply call
> synchronize_irq() after disabling the irq bit in the DP hardware and
> then we would know it is safe to power down the DP logic. Unfortunately
> the event queue is a kthread so we can't do that and we have to rewrite
> synchronize_irq() by checking that the event queue is empty and waiting
> for it to empty out otherwise. It's not safe enough to simply do the
> power operations underneath the event_lock because there's a queue in
> the kthread that might be waiting to grab the event_lock to process.

This sounds like a good reason to rewrite event_thread to use
threaded_irq and/or workqueue.

-- 
With best wishes
Dmitry
