Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081D14D8C59
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 20:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244032AbiCNT1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 15:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244020AbiCNT1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 15:27:06 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D593B3C3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 12:25:56 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id r127so13647530qke.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 12:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ghXEBznY5vyHF7+fdWoY5v3OsItcalBlY/KG9K7yOhU=;
        b=e2Ud08S0Q7pZF215eRKz7vixHUKMgQNfUK9aOMWNfqStkSdZvWC5Mszd1gEoj/cIZz
         IrZAiRKPJytuFVu+isbnZ5e2rAWsyFV79zcMh9/gmlkX6+VS8y5uGJTay/iSQjW/XKar
         ayFug9ECos7jYnvjtc0aR6Qmtns5qgU5i4/dof+t3R4fwNzT32kHj5wHd1lmFVGOpo3c
         VzjLN9YEOS+PZOQ5vDnQHZ+wSvqk5QfEgoYhbfvKDBo0BAVVKdSnMYOyilpqGop0zHsL
         5HjdxNO1dsVE598rdiHBPM9joHRTxK2XG7aFr29FLlMOR3LRz/PPhkSKnpJmFSQHlnr4
         N8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ghXEBznY5vyHF7+fdWoY5v3OsItcalBlY/KG9K7yOhU=;
        b=FCJh1Vfxwo1wGW0SJ+M7BEJCrUoR7DSqIf+VRKoOUiuQKp1qs6/Po3596y2/w9ZwNC
         rj/FAhbUNtszdV1IWz7tGnwiBAAa9fKrSDhx1iJ/PGFhFHj5DMRpZXFU5n6c6jZZQgjO
         nV7PdXTsvxWRSBVUvH/AIek3E9ZutDnSxDgSaid6QO+NX6E7u0M80HZTa3miKp4YR2SZ
         8WVQ+pp3YfIsk1LkyZxPTWvRilUOm0n7CTk5/QJYymE7hs21eeddmaNDdhhQ45C47etR
         TCyC+MbAQA/s7XD7NEU8uNA19Iva9wkjSGYA8O0AdBRqj2HOukFdu16JDesAeGeJHFrL
         0e7w==
X-Gm-Message-State: AOAM532b1a0HplJjkvX2/LV3myBgx2n5FhZnBGB2cDvo4QCWGx9+3I3C
        0Ci9KVWYO2f2hNn+tSbCHNfNOFb/UTEYLhQHuLBPZw==
X-Google-Smtp-Source: ABdhPJyQEYq/aa0gjJEO9Tga4REDnt5I6yrfTmBRW4eRCznjlBUHHMh0lYM73RO7oxgtpMzyqDMXDoNaOp6yMHVijEk=
X-Received: by 2002:a05:620a:170a:b0:67d:be5c:204a with SMTP id
 az10-20020a05620a170a00b0067dbe5c204amr5211992qkb.593.1647285955193; Mon, 14
 Mar 2022 12:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <1647269217-14064-1-git-send-email-quic_vpolimer@quicinc.com> <1647269217-14064-2-git-send-email-quic_vpolimer@quicinc.com>
In-Reply-To: <1647269217-14064-2-git-send-email-quic_vpolimer@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 14 Mar 2022 22:25:44 +0300
Message-ID: <CAA8EJpr2rw4eSA+PViW7UZ2rVLLDS+ipcuo-1dzOargTcbE2hA@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] drm/msm/disp/dpu1: set mdp clk to the maximum
 frequency in opp table during probe
To:     Vinod Polimera <quic_vpolimer@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, quic_kalyant@quicinc.com
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

On Mon, 14 Mar 2022 at 17:47, Vinod Polimera <quic_vpolimer@quicinc.com> wrote:
>
> use max clock during probe/bind sequence from the opp table.
> The clock will be scaled down when framework sends an update.
>
> Fixes: 25fdd5933("drm/msm: Add SDM845 DPU support")
> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index e29796c..9c346ce 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -1202,7 +1202,9 @@ static int dpu_bind(struct device *dev, struct device *master, void *data)
>         struct platform_device *pdev = to_platform_device(dev);
>         struct drm_device *ddev = priv->dev;
>         struct dpu_kms *dpu_kms;
> +       struct dev_pm_opp *opp;
>         int ret = 0;
> +       unsigned long max_freq = ULONG_MAX;
>
>         dpu_kms = devm_kzalloc(&pdev->dev, sizeof(*dpu_kms), GFP_KERNEL);
>         if (!dpu_kms)
> @@ -1225,6 +1227,12 @@ static int dpu_bind(struct device *dev, struct device *master, void *data)
>         }
>         dpu_kms->num_clocks = ret;
>
> +       opp = dev_pm_opp_find_freq_floor(dev, &max_freq);
> +       if (!IS_ERR(opp))
> +               dev_pm_opp_put(opp);
> +
> +       dev_pm_opp_set_rate(dev, max_freq);
> +
>         platform_set_drvdata(pdev, dpu_kms);
>
>         ret = msm_kms_init(&dpu_kms->base, &kms_funcs);
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
