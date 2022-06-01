Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A03453A1FC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351791AbiFAKH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352026AbiFAKFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:05:06 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0847A76F5
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 03:04:49 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id x65so924896qke.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 03:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lHSPQr2cIR/ntw9mchA0Qp1Mf6n70DWLKdFta7FA2i8=;
        b=rf0on8d64kNqqEPTSKDTeJLGi5mhx/w+LSPJtQsnkQKzerFRuh98mE1mlZVoerdEdB
         nilWximLlUxpwJOs6aAz4ko74Qc9SI1fC0RMONIZ9o6NiK4xAhDC905SK2U7UgYVPaTj
         39HnnlavGu7ksAvSci1lRnC1b6W/qVV7Lvsn892uJV3Z3R20E63iaxso4k8FTMBFdRCY
         1I2NERWc8n/ZlpGPw9fQnlfCPLBEdGUcbAXi+7ckTakLT2rvM4VyDnQwIZoSlf7TsSqj
         GWmnEf3wePEtp1Za+lfRaKXAM5SoA+GXn1A0hgDcQEob8ruq43wLLx4r+NgtiKwX2TQf
         SNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lHSPQr2cIR/ntw9mchA0Qp1Mf6n70DWLKdFta7FA2i8=;
        b=bSvCzx3Vue0CX4te8Tgrw7G/xYwn0VW65kmuIMk9/gE+2f5NUMc3u7A26O1uWx3+84
         R8W0Xjk8/TOEVJK+kygM6n4jjwDvvNZbMbfVLhHdr44+xRbij1suuRIW/nmlLguVzwBD
         4icD5mb+9dBVCjibbaUE0mdJODOWFnDHoDuTpt/lPoMS5Tk1gNHzYcZL1bNnpyIuGf4p
         8zKQw41U4LgRIzAp2BF/QgAT9AWjTGHwbRjhuSAb3yhRe16oQuLMe6kJUwTl6jX9KI5d
         xC21fZTTvr8InmD2DuttZWekFlyUkJaQOElllcGLqtW8BldxpNqA52TiE7XL3udpJ1hf
         DXnA==
X-Gm-Message-State: AOAM533Ei1U5q2buBszXUeIeFKGVAOxv0lTaNpAk1fu2eUydyozER+Uq
        lQE5cy65f5DoFA8FT+t7ucncP/fMXg2i0+9f0tWkrQ==
X-Google-Smtp-Source: ABdhPJzAahRdMs1ggkVHLtcwa0pM08LnUkdsm3uZvqJc3UZYhpPnwH+rgos7SIKGM+mWOnxRi1I1hPNAfmBomXzhN+c=
X-Received: by 2002:a05:620a:4311:b0:67e:8a0f:4cd5 with SMTP id
 u17-20020a05620a431100b0067e8a0f4cd5mr44362828qko.363.1654077888548; Wed, 01
 Jun 2022 03:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220531160059.v2.1.Ie7f6d4bf8cce28131da31a43354727e417cae98d@changeid>
In-Reply-To: <20220531160059.v2.1.Ie7f6d4bf8cce28131da31a43354727e417cae98d@changeid>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 1 Jun 2022 13:04:37 +0300
Message-ID: <CAA8EJpqp64eDmXPN1qMTZ78My8BKPUcu7zKunZV1SJpzjSRDuQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dpu: Move min BW request and full BW disable
 back to mdss
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
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

On Wed, 1 Jun 2022 at 02:01, Douglas Anderson <dianders@chromium.org> wrote:
>
> In commit a670ff578f1f ("drm/msm/dpu: always use mdp device to scale
> bandwidth") we fully moved interconnect stuff to the DPU driver. This
> had no change for sc7180 but _did_ have an impact for other SoCs. It
> made them match the sc7180 scheme.

[skipped the description]

>
> Changes in v2:
> - Don't set bandwidth in init.
>
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c |  8 ----
>  drivers/gpu/drm/msm/msm_mdss.c          | 57 +++++++++++++++++++++++++
>  2 files changed, 57 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index 2b9d931474e0..3025184053e0 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -49,8 +49,6 @@
>  #define DPU_DEBUGFS_DIR "msm_dpu"
>  #define DPU_DEBUGFS_HWMASKNAME "hw_log_mask"
>
> -#define MIN_IB_BW      400000000ULL /* Min ib vote 400MB */
> -
>  static int dpu_kms_hw_init(struct msm_kms *kms);
>  static void _dpu_kms_mmu_destroy(struct dpu_kms *dpu_kms);
>

[skipped]

> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> index 0454a571adf7..e13c5c12b775 100644
> --- a/drivers/gpu/drm/msm/msm_mdss.c
> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> @@ -5,6 +5,7 @@
>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/interconnect.h>
>  #include <linux/irq.h>
>  #include <linux/irqchip.h>
>  #include <linux/irqdesc.h>
> @@ -25,6 +26,8 @@
>  #define UBWC_CTRL_2                    0x150
>  #define UBWC_PREDICTION_MODE           0x154
>
> +#define MIN_IB_BW      400000000UL /* Min ib vote 400MB */

As msm_mdss is now used for both DPU and MDP5 devices, could you
please confirm that this value is valid for older devices too? E.g.
db410c or 8974

> +
>  struct msm_mdss {
>         struct device *dev;
>

-- 
With best wishes
Dmitry
