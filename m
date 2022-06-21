Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161B255392D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 19:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347168AbiFURt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 13:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiFURtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 13:49:23 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0841DA56
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 10:49:22 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id i17so14828144qvo.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 10:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nw0DlBYDfBdu22kSo0+uETWJWz7c+f9JtMxmK4Kl8RI=;
        b=dyq/TyGYhw8UU4mdyDE5mNCj129SFfyHjyX0dumMMkgB3V73o1m3jd/o0FAOfHjDAX
         dQZdD9UIP/FuACILeg/LBhBndr0mOpj8vRWjVXWfiklW8vGbrmu3Fw5X8R38DUfVfc/a
         BHCQcch51EY+WTFGOfppYA/hQ8ylFE6vzV0w8+JlSiq/sHozNRGvbd1FmU8NP8I98GN2
         zANcOgU+VsUk/lezKgdT2jdFDaroYQI9YoGX8lrL90gF7uGPDLbma2t9rlOjNBNhNF/R
         gzshyndEmw6dU54D45OE2N6NS5gM89HRH1EU0AMHfqN9QeMpMy6T2++emFsp1XQoGttn
         FZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nw0DlBYDfBdu22kSo0+uETWJWz7c+f9JtMxmK4Kl8RI=;
        b=5v/bSimHn7eJ5utSxx+mZQwaNe5knIJWz+CbmiIFITWy5CKGZaqBRWw1uZsrMCMR1p
         U4SZzu3PlAtLtC2TTM4AHug6HtT2lZqeHKYt7hhoJJLtXpWqPLtpObyMfuzrRPwaJTvJ
         GgqxL+t8lS+2nydob9SlA30LRwU4d0OphCH11m0k184Jzyi72gXTGUJalDHyCVjC6zUt
         8s37qwZj8yiKs9jPyiqz6uug/+qqpcDZInpitMSYM64rILcomEUZTm1ZGMCTpMEyltIi
         yOSw2OgdltL4bgsV9/hmvj2c+oaAw3PNuAdzKTLik8W2WPKyOjHOLf+gkmymyONZbLOR
         0Vgw==
X-Gm-Message-State: AJIora+gcsU3ppFab/gwB7sxsgnoOPKnwSyvT+/Mo0gWKXR8q1nygCaD
        OP2a4sK29amgYiCdijPV9XK1ApIM/+fp06/zmaZoe+8GNmA3RQ==
X-Google-Smtp-Source: AGRyM1vRZ27TE9JLxl0H2Bf2+iemKBHDRiHFCSDiyD9/BWISYi/Q905z5NHGQAOdijq8GrzXd4JAVga2mXdEiVg1o9w=
X-Received: by 2002:a05:622a:1351:b0:305:2e58:939 with SMTP id
 w17-20020a05622a135100b003052e580939mr24711190qtk.295.1655833761773; Tue, 21
 Jun 2022 10:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220621110634.368913-1-sunliming@kylinos.cn> <d4b882ba-b773-5271-6050-416c8f3cad4b@quicinc.com>
 <955f881c-7731-a337-3ff9-e58863c41976@quicinc.com>
In-Reply-To: <955f881c-7731-a337-3ff9-e58863c41976@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 21 Jun 2022 20:49:10 +0300
Message-ID: <CAA8EJpreR2bk827Mb4doU5yf=Af-3djoJ=UiOomfsGmuV1MUhA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: Fix variable dereferenced before check
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     sunliming <sunliming@kylinos.cn>, robdclark@gmail.com,
        linux-kernel@vger.kernel.org, kelulanainsley@gmail.com,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2022 at 20:44, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Copying freedreno

The patch needs to be sent to freedreno@. Otherwise it doesn't exist
in patchwork.

>
> On 6/21/2022 10:42 AM, Abhinav Kumar wrote:
> >
> >
> > On 6/21/2022 4:06 AM, sunliming wrote:
> >> Fixes the following smatch warning:
> >>
> >> drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c:261
> >> dpu_encoder_phys_wb_atomic_check() warn: variable dereferenced before
> >> check 'conn_state'
> >>
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Signed-off-by: sunliming <sunliming@kylinos.cn>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> >
> >> ---
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c | 10 +++++-----
> >>   1 file changed, 5 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> >> b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> >> index 59da348ff339..0ec809ab06e7 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> >> @@ -252,11 +252,6 @@ static int dpu_encoder_phys_wb_atomic_check(
> >>       DPU_DEBUG("[atomic_check:%d, \"%s\",%d,%d]\n",
> >>               phys_enc->wb_idx, mode->name, mode->hdisplay,
> >> mode->vdisplay);
> >> -    if (!conn_state->writeback_job || !conn_state->writeback_job->fb)
> >> -        return 0;
> >> -
> >> -    fb = conn_state->writeback_job->fb;
> >> -
> >>       if (!conn_state || !conn_state->connector) {
> >>           DPU_ERROR("invalid connector state\n");
> >>           return -EINVAL;
> >> @@ -267,6 +262,11 @@ static int dpu_encoder_phys_wb_atomic_check(
> >>           return -EINVAL;
> >>       }
> >> +    if (!conn_state->writeback_job || !conn_state->writeback_job->fb)
> >> +        return 0;
> >> +
> >> +    fb = conn_state->writeback_job->fb;
> >> +
> >>       DPU_DEBUG("[fb_id:%u][fb:%u,%u]\n", fb->base.id,
> >>               fb->width, fb->height);



-- 
With best wishes
Dmitry
