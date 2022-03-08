Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6B44D1E31
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348651AbiCHRKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348622AbiCHRKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:10:44 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96973FDB3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:09:47 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id x3so15130465qvd.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 09:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UQsloRHTSaGiGetdbDWoxqQEJYsHpKTImpl+EXTJaU0=;
        b=H2042iFn8zbvVMiOulmTBRC55hfhpLFhLPRiEwvUGuLHJeAjSulrbb/dnZ+gGOGpdx
         z+nEoUPsD5v9kA7aLyUd3mh/+c+OPht0WtwZz7SUgG5EpIxXKtD33/rrpjJgBRLOZ+Wc
         +w4Ng70uS1XwbnLD2GxLQoEqEPlzd/G0Nj4DbBPsF4RU+8mYeOajlGGlmH85BpFpMHq4
         V9pj+HOsO1K0j7YJzSI1eVB8yORUl7FQ0K4fuwqcZEq2hj4nu6kvqSciK8Z1UvqSgnGX
         2Gg1wU8u+siIqzrk0fumIX8gcdhjob0cCaqDCKEe8NWqBvwoktmRCHASmW+vII/XTqBi
         SkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UQsloRHTSaGiGetdbDWoxqQEJYsHpKTImpl+EXTJaU0=;
        b=UU0qv1wZsf2FJ/rWV0YEJh6frVcDgC5jMXImMKda5ErXlhKEwG3CC5mpiZawW+5YPt
         4+cassmXGjpO6xfAR/Glf/B9PMAzmnV8/UljQq/iMuky851HMnTugBVnBofizK971s21
         ebsRG+VMarrXcRmdYIc/etGwGJE3GrMn5V8pq64KDSKheCOqCr4TdJAL7reia+LV3OVN
         rnSIMlQVWgxSxbeSb2k02vg+ozrHvLLcQ9BZDvvgl+xWLRqJz+fsTAdl5FVNyeDviET3
         CvJHtidfvuZmubvyH9k2g458AWuXYSqXGSsKrcm4vTP3QBQjtgKaT6XqZpNaA9MfSLO6
         80Sg==
X-Gm-Message-State: AOAM531k9hgGb2g6Y72SUurzkgKsM6zpQpTEZF2rlrgjIXbQNwg+V5rT
        zTQURJ0l2GR5LxjaWvt31GsYpNa7hBqjvt5mnTbvaaJisLQ=
X-Google-Smtp-Source: ABdhPJziwHM3mwjCjwO4Ib9qlCcqXaMHab7YQ1KRTIBpOJvcb8c3ZW4vgDTtKRTvbt8UU9j7WWhqwP7KKAN7SmM4acc=
X-Received: by 2002:a05:6214:1bcf:b0:435:4c86:607a with SMTP id
 m15-20020a0562141bcf00b004354c86607amr12909937qvc.122.1646759386744; Tue, 08
 Mar 2022 09:09:46 -0800 (PST)
MIME-Version: 1.0
References: <1646758500-3776-1-git-send-email-quic_vpolimer@quicinc.com> <1646758500-3776-6-git-send-email-quic_vpolimer@quicinc.com>
In-Reply-To: <1646758500-3776-6-git-send-email-quic_vpolimer@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 8 Mar 2022 20:09:35 +0300
Message-ID: <CAA8EJprgJvOGCU_PvAHCNoMvSam8QV4x9N2ZEm+oer5d7B-cPA@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] drm/msm/disp/dpu1: set mdp clk to the maximum
 frequency in opp table during probe
To:     Vinod Polimera <quic_vpolimer@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com
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

On Tue, 8 Mar 2022 at 19:55, Vinod Polimera <quic_vpolimer@quicinc.com> wrote:
>
> use max clock during probe/bind sequence from the opp table.
> The clock will be scaled down when framework sends an update.
>
> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index d550f90..d9922b9 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -1221,6 +1221,7 @@ static int dpu_bind(struct device *dev, struct device *master, void *data)
>         struct dpu_kms *dpu_kms;
>         struct dss_module_power *mp;
>         int ret = 0;
> +       unsigned long max_freq = ULONG_MAX;
>
>         dpu_kms = devm_kzalloc(&pdev->dev, sizeof(*dpu_kms), GFP_KERNEL);
>         if (!dpu_kms)
> @@ -1243,6 +1244,8 @@ static int dpu_bind(struct device *dev, struct device *master, void *data)
>                 return ret;
>         }
>
> +       dev_pm_opp_find_freq_floor(dev, &max_freq);

You leak a reference to the opp here. The function returns a value,
which should be dev_pm_opp_put().
Moreover judging from the dev_pm_opp_set_rate() code I think you don't
have to find an exact frequency, as it will call
clk_round_rate()/_find_freq_ceil() anyway.
Could you please check that it works?

> +       dev_pm_opp_set_rate(dev, max_freq);
>         platform_set_drvdata(pdev, dpu_kms);
>
>         ret = msm_kms_init(&dpu_kms->base, &kms_funcs);
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
