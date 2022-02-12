Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D13D4B3649
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 17:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbiBLQQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 11:16:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236934AbiBLQQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 11:16:47 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136E0197
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 08:16:44 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id 200so10854768qki.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 08:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3eUSYNapb5x0nBAO2PC3SgJkWjN+mXVFDgbj8Nms+A4=;
        b=IbovKgOrNQZ3Y+TY6EwzkRLsveSQoXJQTPKGmLB0k2yGy8Az1EoFUDtWhRxpUNuGUF
         Bi/b0nqzz/FhJ9ofd7eMA0WPGsDDtqWvA3Mcp4ixRwi+Re+NHW4loZ64UBCITo1LGeWM
         eiWitKUKGEu/CqkVMJG254Notpcn1YpTIb9yntNl7VoYoHej75zs7XGnHE1EjC686AG9
         nswBg8dTA4dbkTdaHVxf80xhj557cT+CBE3lhwx+76/7+kpZ0Amve+MpwhXit7CwfjOD
         gbFAMWDz7V8Iw1fjbp7HIPOJNqr1bbGSqvnhpaaKN71bBdZW+fq1VeaqkWH6AVNQ1iKG
         GrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3eUSYNapb5x0nBAO2PC3SgJkWjN+mXVFDgbj8Nms+A4=;
        b=F83C9HWCVB7bY5bEwoLs/ZiSpG7k6jOMu82P5NADVsYNjddWjk0DG5+SalctW2JVvN
         xYC4TZfAa7xhwezf8X76bXRhLwrXkgQr07l4hWz2jpEZmE8jmB48gWtKd6+mfrv51b0W
         x8PWGp9q6lWkQu5pF7TE9jn5XCietcgh2jZlV4ZSyfhzxMYecJScvUuEWiJR31JhQL7J
         wvNSHDGrl7xHEhAj3g64PBM6O0D7GbwRQwbybqG1s10eHAA9zdUndpCh1BjiggDAghbg
         mWkX5rLwPCwfdqVFF98HHHAUb9F6YEb+/YJMUnPrxLWyQohEic08geaBkpPYhaef6E+E
         fQ0w==
X-Gm-Message-State: AOAM532zyS+uICWLyufoLv/g1n3+pODxAvZONsB79hFBNgZUKm3SfwOm
        Nhp07O9YIW2qUsvA7gNTNGAd69R1CvADyOzQzr4i9g==
X-Google-Smtp-Source: ABdhPJy4yNXKHI8Y5Y3irRuI3wCAhqkjdXkRQCIaGRHCH2HEY8Fz/S5Rz+oZlxZmAe/aD0Qa6GrZe3iD2sVhAlU010s=
X-Received: by 2002:a05:620a:75b:: with SMTP id i27mr3354494qki.593.1644682603176;
 Sat, 12 Feb 2022 08:16:43 -0800 (PST)
MIME-Version: 1.0
References: <1644621822-25407-1-git-send-email-quic_khsieh@quicinc.com>
 <d77140f5-73b3-b9a4-aa4b-b240105eb5d4@linaro.org> <f86504ba-835a-6e30-6c30-8bb89b1359c4@quicinc.com>
In-Reply-To: <f86504ba-835a-6e30-6c30-8bb89b1359c4@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 12 Feb 2022 19:16:32 +0300
Message-ID: <CAA8EJpqd_8VO1ah3HdhYJmFqRDQFquvrm-RfETZ5qjgC2ZU2tQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: populate intf_audio_select() base on hardware capability
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Kuogee Hsieh <quic_khsieh@quicinc.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, vkoul@kernel.org,
        daniel@ffwll.ch, airlied@linux.ie, agross@kernel.org,
        bjorn.andersson@linaro.org, quic_aravindh@quicinc.com,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sat, 12 Feb 2022 at 03:59, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> On 2/11/2022 4:08 PM, Dmitry Baryshkov wrote:
> > On 12/02/2022 02:23, Kuogee Hsieh wrote:
> >> intf_audio_select() callback function use to configure
> >> HDMI_DP_CORE_SELECT to decide audio output routes to HDMI or DP
> >> interface. HDMI is obsoleted at newer chipset. To keep supporting
> >> legacy hdmi application, intf_audio_select call back function have
> >> to be populated base on hardware chip capability where legacy
> >> chipsets have has_audio_select flag set to true.
> >
> > So, after thinking more about the patch, I have a bunch of questions:
> >
> > You are enabling this callback only for sdm845 and sm8150.
> >
> > Does this register exist on other (newer) platforms (but just defaults
> > to DP)?
>
> The register itself exists but there is no logic associated with it. Its
> a no-op.

Ack, thanks

>
> >
> > Neither sdm845 nor sm8150 support INTF_HDMI. What's the purpose of the
> > register on these platforms?
>
> Yes we also had a similar thought earlier that this register has meaning
> only on chipsets which have HDMI and DP but our hardware team suggested
> sm8250 and its derivatives should be the cut-off point to stop using
> this register. So we are just following that.

Ack

>
> >
> > Does that mean that we should program the register for HDMI (e.g. on 8998)?
> >
> Yes, we should program this for HDMI 8998 ( although the default value
> of the register is 0 for HDMI ).

ok, so ideally we should add an argument switching between HDMI and DP audio.
This can be done in a separate patch.

>
> > And, as you are touching this piece of code, how do we control audio
> > routing on newer platforms which have several hardware DP interfaces?
> >
> Thats unrelated to this register because on newer chipsets which have
> two DPs there is no HDMI and hence this register remains a no-op.

Yep. I just wondered whether this register would be reused to switch
between DPs.
It doesn't.

>
> But coming to the overall question on multi-DP audio.
>
> This is not a new question. I had first asked about this to Bjorn for
> sc8180x. The current hdmi-codec interface which is used for single DP
> audio will have to be extended to support this to support which stream
> to pass the audio on. This is an open item which was left to be done
> later on because the only chipset which has multi-DP in upstream is
> sc8180x. We dont have that hardware with us for development. When we
> start working on that, we will have to implement what I just mentioned.

The implementation depends on the question whether the SoC can output
several DP audio streams in parallel,
but as the register in question is not used, it's definitely a
separate question.

>
> Thanks
>
> Abhinav
>
> >
> >>
> >> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> >> ---
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 2 ++
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 1 +
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c     | 9 ++++++---
> >>   3 files changed, 9 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> >> b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> >> index 272b14b..23680e7 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> >> @@ -201,6 +201,7 @@ static const struct dpu_caps sdm845_dpu_caps = {
> >>       .has_dim_layer = true,
> >>       .has_idle_pc = true,
> >>       .has_3d_merge = true,
> >> +    .has_audio_select = true,
> >>       .max_linewidth = DEFAULT_DPU_OUTPUT_LINE_WIDTH,
> >>       .pixel_ram_size = DEFAULT_PIXEL_RAM_SIZE,
> >>       .max_hdeci_exp = MAX_HORZ_DECIMATION,
> >> @@ -229,6 +230,7 @@ static const struct dpu_caps sm8150_dpu_caps = {
> >>       .has_dim_layer = true,
> >>       .has_idle_pc = true,
> >>       .has_3d_merge = true,
> >> +    .has_audio_select = true,
> >>       .max_linewidth = 4096,
> >>       .pixel_ram_size = DEFAULT_PIXEL_RAM_SIZE,
> >>       .max_hdeci_exp = MAX_HORZ_DECIMATION,
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> >> b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> >> index e5a96d6..b33f91b 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> >> @@ -357,6 +357,7 @@ struct dpu_caps {
> >>       bool has_dim_layer;
> >>       bool has_idle_pc;
> >>       bool has_3d_merge;
> >> +    bool has_audio_select;
> >>       /* SSPP limits */
> >>       u32 max_linewidth;
> >>       u32 pixel_ram_size;
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c
> >> b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c
> >> index 282e3c6..e608f4d 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c
> >> @@ -261,14 +261,17 @@ static void dpu_hw_intf_audio_select(struct
> >> dpu_hw_mdp *mdp)
> >>   }
> >>   static void _setup_mdp_ops(struct dpu_hw_mdp_ops *ops,
> >> -        unsigned long cap)
> >> +        unsigned long cap,
> >> +        const struct dpu_mdss_cfg *m)
> >>   {
> >>       ops->setup_split_pipe = dpu_hw_setup_split_pipe;
> >>       ops->setup_clk_force_ctrl = dpu_hw_setup_clk_force_ctrl;
> >>       ops->get_danger_status = dpu_hw_get_danger_status;
> >>       ops->setup_vsync_source = dpu_hw_setup_vsync_source;
> >>       ops->get_safe_status = dpu_hw_get_safe_status;
> >> -    ops->intf_audio_select = dpu_hw_intf_audio_select;
> >> +
> >> +    if (m->caps->has_audio_select)
> >> +        ops->intf_audio_select = dpu_hw_intf_audio_select;
> >>   }
> >>   static const struct dpu_mdp_cfg *_top_offset(enum dpu_mdp mdp,
> >> @@ -320,7 +323,7 @@ struct dpu_hw_mdp *dpu_hw_mdptop_init(enum dpu_mdp
> >> idx,
> >>        */
> >>       mdp->idx = idx;
> >>       mdp->caps = cfg;
> >> -    _setup_mdp_ops(&mdp->ops, mdp->caps->features);
> >> +    _setup_mdp_ops(&mdp->ops, mdp->caps->features, m);
> >>       return mdp;
> >>   }
> >
> >



-- 
With best wishes
Dmitry
