Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF0B4D864B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 14:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242034AbiCNN7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 09:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237653AbiCNN7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 09:59:19 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137D31EEF4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 06:58:09 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id p15so34153694ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 06:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/sGwhFLRtiH/ykUra8RNv5VtPDl39PfWAyeMQdseV4U=;
        b=E4HfJt2lpl5yMCJkmr268M1C6Xw1SdJiBIbXECMsySpxvvMRbBTqo3MSLg3VnfahpC
         P7LzLbgUQFA4BE/DsfILmqLQHUV+ASwOd5AcDTChMfwhP9mK0rdOs6tf3pdCjfyIgHEm
         lfiSNtrZ23gznqQr7osIXvkgdlCoTI2SO5lFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/sGwhFLRtiH/ykUra8RNv5VtPDl39PfWAyeMQdseV4U=;
        b=t9OjaxOsj2wsGncHgnIqLHXRUinJnJaOz3tImBY4JATu6m3NhoQvU0KD6OVoRmZLwc
         +ngcc6ikWrNq7odqjxC1pI7lRFKwXMwNsJc29g7CuDXc9IMfmZibZVbfVA0ZcXRvizT2
         9LRI2lh9Wu5l3M0d0cw3F6Fr+2/MVBjfZ3vp0XxpW3zJeTY9N3PBjfjqjNk1TYtcw8BE
         4SavzKCviVel0/rdbTke/ZIw0GdudqMRMMYoi76bRz4dYYACxqxeCet/yrhz5pagPSxD
         NsFQsM3BtEBUtcApCZHNQqu+aEFy2kpBOlw3Gqrx4U4arpFcqQbxmQqdmuNFsGRX5c7l
         7Kzg==
X-Gm-Message-State: AOAM530pwAlTGlLxC1kFPAR1/Ngr2G8HiEqMqtnXHtkeUJ/y2lofgJdq
        ZjF30I6P1UYKNiCyY4c5xRendMxyo1NNLQ==
X-Google-Smtp-Source: ABdhPJwbN/IwCXfPEcgBRpql62yvHrfAembeQvrHUsGwAkhsrwhITJi/9mxpLuv8AF4HmoyGUquAuA==
X-Received: by 2002:a17:906:a148:b0:6cd:50c7:8d4d with SMTP id bu8-20020a170906a14800b006cd50c78d4dmr18476993ejb.641.1647266287237;
        Mon, 14 Mar 2022 06:58:07 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id f3-20020a1709067f8300b006ce051bf215sm6893986ejr.192.2022.03.14.06.58.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 06:58:06 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id r190-20020a1c2bc7000000b0038a1013241dso1767971wmr.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 06:58:06 -0700 (PDT)
X-Received: by 2002:a05:600c:a53:b0:38a:fc5:3a90 with SMTP id
 c19-20020a05600c0a5300b0038a0fc53a90mr3788786wmq.15.1647266285495; Mon, 14
 Mar 2022 06:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <1646758500-3776-1-git-send-email-quic_vpolimer@quicinc.com>
 <1646758500-3776-2-git-send-email-quic_vpolimer@quicinc.com>
 <CAE-0n51bfqWs8yOiyQ-A_bEQ7CZSqavz8epcFEWYyZxxoRYFHg@mail.gmail.com>
 <BN0PR02MB8173F2E408848216D489D503E40C9@BN0PR02MB8173.namprd02.prod.outlook.com>
 <CAA8EJppt_NjOdJWGrP=8zwG1yEAyJBtnv4G5vLW3CHZ8WrGFvw@mail.gmail.com>
In-Reply-To: <CAA8EJppt_NjOdJWGrP=8zwG1yEAyJBtnv4G5vLW3CHZ8WrGFvw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 14 Mar 2022 06:57:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wy-ew3sbsQ_ojoAdAXeZPsRzwGJWqNQqpuZDb1GPknfg@mail.gmail.com>
Message-ID: <CAD=FV=Wy-ew3sbsQ_ojoAdAXeZPsRzwGJWqNQqpuZDb1GPknfg@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] arm64/dts/qcom/sc7280: remove assigned-clock-rate
 property for mdp clk
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Vinod Polimera <vpolimer@qti.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        quic_vpolimer <quic_vpolimer@quicinc.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        quic_kalyant <quic_kalyant@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 11, 2022 at 1:22 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Fri, 11 Mar 2022 at 11:06, Vinod Polimera <vpolimer@qti.qualcomm.com> wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: Stephen Boyd <swboyd@chromium.org>
> > > Sent: Wednesday, March 9, 2022 1:36 AM
> > > To: quic_vpolimer <quic_vpolimer@quicinc.com>;
> > > devicetree@vger.kernel.org; dri-devel@lists.freedesktop.org;
> > > freedreno@lists.freedesktop.org; linux-arm-msm@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org; robdclark@gmail.com;
> > > dianders@chromium.org; quic_kalyant <quic_kalyant@quicinc.com>
> > > Subject: Re: [PATCH v5 1/5] arm64/dts/qcom/sc7280: remove assigned-clock-
> > > rate property for mdp clk
> > >
> > > WARNING: This email originated from outside of Qualcomm. Please be wary
> > > of any links or attachments, and do not enable macros.
> > >
> > > Quoting Vinod Polimera (2022-03-08 08:54:56)
> > > > Kernel clock driver assumes that initial rate is the
> > > > max rate for that clock and was not allowing it to scale
> > > > beyond the assigned clock value.
> > >
> > > How? I see ftbl_disp_cc_mdss_mdp_clk_src[] has multiple frequencies and
> > > clk_rcg2_shared_ops so it doesn't look like anything in the clk driver
> > > is preventing the frequency from changing beyond the assigned value.
> >
> > Folowing the comment of Stephen, i have checked a bit more. it appears that clock driver is not setting the max clock from assgined clocks, dpu driver is doing that.
> > i am planning to fix it as below.
> > 1) assign ULONG_MAX to max_rate while initializing clock in dpu driver.
> > 2) remove unnecessary checks in the core_perf library. If rate doesn't match with the entries in the opp table, it will throw error, hence furthur checks are not needed.
> > 3) no changes in dt are required. (we can drop all the posted ones)
>
> Why? They made perfect sense. The dts assignments should be replaced
> by the opp setting in the bind function, as this would also set the
> performance point of the respective power domain.

Right. You should still _post_ the dts patches. It's nice to avoid
unneeded "assigned-clocks" in the dts. The patch description should
just be clear that it relies on the driver patch and shouldn't land /
be backported without the driver patch.


> > Changes :
> > ```--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
> > @@ -284,17 +284,6 @@ void dpu_core_perf_crtc_release_bw(struct drm_crtc *crtc)
> >         }
> >  }
> >
> > -static int _dpu_core_perf_set_core_clk_rate(struct dpu_kms *kms, u64 rate)
> > -{
> > -       struct dss_clk *core_clk = kms->perf.core_clk;
> > -
> > -       if (core_clk->max_rate && (rate > core_clk->max_rate))
> > -               rate = core_clk->max_rate;
> > -
> > -       core_clk->rate = rate;
> > -       return dev_pm_opp_set_rate(&kms->pdev->dev, core_clk->rate);
> > -}
> > -
> >  static u64 _dpu_core_perf_get_core_clk_rate(struct dpu_kms *kms)
> >  {
> >         u64 clk_rate = kms->perf.perf_tune.min_core_clk;
> > @@ -405,7 +394,7 @@ int dpu_core_perf_crtc_update(struct drm_crtc *crtc,
> >
> >                 trace_dpu_core_perf_update_clk(kms->dev, stop_req, clk_rate);
> >
> > -               ret = _dpu_core_perf_set_core_clk_rate(kms, clk_rate);
> > +               ret = dev_pm_opp_set_rate(&kms->pdev->dev, clk_rate);
> >                 if (ret) {
> >                         DPU_ERROR("failed to set %s clock rate %llu\n",
> >                                         kms->perf.core_clk->clk_name, clk_rate);
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_io_util.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_io_util.c
>
> This file has been removed in msm/next

To echo Dmitry, please make sure that your patch applies to msm-next,
As I understand it, that means the branch msm-next on:

https://gitlab.freedesktop.org/drm/msm.git

-Doug
