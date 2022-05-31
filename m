Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACF05398DD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 23:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348044AbiEaVjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 17:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbiEaVjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 17:39:13 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E3E69296
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 14:39:12 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id rs12so29069863ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 14:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZSLV3GBQBnlAV5yFp3A4v28u1Gnmik85ogLelASJBlM=;
        b=G6+2ri/VlQ8yFwFXj74MfREI3aG4EAj3Tv4RTyXriFCkuNZgqqsE6YEb+RI1MiiG6u
         jUrvLmn+pmyEOMkFGPDQlwvGDysPypwMJAL+4flzyKzCAEFIQRRucXeADWRCWhYR2I6f
         ciei005AA9QQiQXNIDi8ojvPdlBRv+7S4gA7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZSLV3GBQBnlAV5yFp3A4v28u1Gnmik85ogLelASJBlM=;
        b=XWwLLmFrQuZRbXJAkfNK4dEIgZdwTYN/8tNJuXa63T/Ezq9JgcFPDShpbSsSQ0OMKP
         acjbhjStyGWWirKXKD1S7n0ywtJc8gfnPJW/uAdndwT7G2tvgNq8A5mn011F6+k7fmDP
         HPvPYZ4LxjW6PuncAYAXc5MQj7fJ7YH8//CxnBdPoXhAzqNSCukLzb8WA7PnDFXN8dkU
         UVf5tirJVyTTIfojKMu4QZEuZofWpnSYlCyAU5Ggcpv60du8J/zleP1tQBcRE/9CyTXs
         BGFtS71QHZvlZXaaRF1RLznzOIK5S9dDlEIiO930ZkDeHQSTKHuZhMKnd//Q5pXHy+J3
         yGJA==
X-Gm-Message-State: AOAM5310X7619r8fqZuNFCTTQQBBs/IRf1UxGpWaG/cSFlTLT1K8cJoo
        sFPIIz+mfpVo2u20kPqJ3jRskQFOEbyrx+W5
X-Google-Smtp-Source: ABdhPJzToT45oaXFTpAWw0ToIHfDLX4owLXZjKrYE3q6vvQny1PLpW5IpXkgGD1WAgZu2IoHm1IjWw==
X-Received: by 2002:a17:906:7954:b0:6fe:d9af:feb0 with SMTP id l20-20020a170906795400b006fed9affeb0mr39867804ejo.361.1654033150385;
        Tue, 31 May 2022 14:39:10 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id g3-20020a1709063b0300b006feb3d65330sm5318223ejf.109.2022.05.31.14.39.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 14:39:08 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id q21so9137925wra.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 14:39:07 -0700 (PDT)
X-Received: by 2002:a05:6000:1548:b0:20f:c4e3:637a with SMTP id
 8-20020a056000154800b0020fc4e3637amr41857017wry.513.1654033146812; Tue, 31
 May 2022 14:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220531072757.1.Ie7f6d4bf8cce28131da31a43354727e417cae98d@changeid>
 <1ce24f74-3c9e-60ed-46ad-3ba714fb7c61@quicinc.com>
In-Reply-To: <1ce24f74-3c9e-60ed-46ad-3ba714fb7c61@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 31 May 2022 14:38:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WP9-W-_rQMNbCb6JYrz9FT3wG1J1irwMZB_0ug4-jK9Q@mail.gmail.com>
Message-ID: <CAD=FV=WP9-W-_rQMNbCb6JYrz9FT3wG1J1irwMZB_0ug4-jK9Q@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: Move min BW request and full BW disable back
 to mdss
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
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

On Tue, May 31, 2022 at 2:29 PM Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> > @@ -136,6 +178,13 @@ static int msm_mdss_enable(struct msm_mdss *msm_mdss)
> >   {
> >       int ret;
> >
> > +     /*
> > +      * Several components have AXI clocks that can only be turned on if
> > +      * the interconnect is enabled (non-zero bandwidth). Let's make sure
> > +      * that the interconnects are at least at a minimum amount.
> > +      */
> > +     msm_mdss_icc_request_bw(msm_mdss, MIN_IB_BW);
> > +
>
> This patch does two things :
>
> 1) Move the min icc vote from the dpu_runtime_resume() path to the
> msm_mdss_enable() so that while resuming, we add the min vote to the
> parent device. We do need a min vote before turning on the AXI clk as
> per this comment mentioned in c33b7c0389e1 (drm/msm/dpu: add support for
> clk and bw scaling for display)
>
>
> @@ -1101,8 +1129,15 @@ static int __maybe_unused
> dpu_runtime_resume(struct device *dev)
>          struct drm_encoder *encoder;
>          struct drm_device *ddev;
>          struct dss_module_power *mp = &dpu_kms->mp;
> +       int i;
>
>          ddev = dpu_kms->dev;
> +
> +       /* Min vote of BW is required before turning on AXI clk */
> +       for (i = 0; i < dpu_kms->num_paths; i++)
> +               icc_set_bw(dpu_kms->path[i], 0,
> +                       dpu_kms->catalog->perf.min_dram_ib);
>
> So I understand and I am fine with this part.
>
> 2) Add a min vote in msm_mdss_init().
>
> This is the part I am not able to fully follow.
>
> If we only need to add the min vote before voting for the clocks, adding
> it in mdss_mdss_enable() should be enough.
>
> Do we need this part of adding the min vote to the msm_mdss_init()?
>
> If so, why?

Ah, good question. Mostly I was matching how things were done before
commit a670ff578f1f ("drm/msm/dpu: always use mdp device to scale
bandwidth"). Before that commit we used to put the min vote in the
init path.

...but you're right, I don't see any good reason for it. I'll send a
v2 removing that line from msm_mdss_init().

-Doug
