Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CAB585F9D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 17:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237431AbiGaPzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 11:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiGaPzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 11:55:38 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11332DD0;
        Sun, 31 Jul 2022 08:55:37 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a13so9828564ljr.11;
        Sun, 31 Jul 2022 08:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=68Zx22+TjRH5OHp9EnI3pIbkka2i60cLP3LWWH0Sg2c=;
        b=l4ePCz6FDfhhsEligq+HCm18CCMTok5xTCZQrrReX+ZUYOwvUZ4V0a/dDVfwv8HYxd
         /bImxtpWsNTq8qbNBixq02QRsJJ6LksbA4tisVmDpvog88oFpgiT5+WqX0p1OT4B13wW
         euy5B0EbzYZ1uwfojBRqrfQ9n4HFuMzHp1WpjTtnkfBZTmPx9gh2bk8H/wsng87q0e2X
         +ZVBIm0aBA4W/3iyj+c+JzexOzICAzVgJjPpfkLgG/zzd4KU0Qz6KqF60zu2p7/DuRpj
         zC2Sio8thj0xrIiOXLfcbD2MMZKmxoIn9JY079p+r7wWA/bOwVnmsHIeOmHykRp3jQwD
         ktdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=68Zx22+TjRH5OHp9EnI3pIbkka2i60cLP3LWWH0Sg2c=;
        b=0CpAW3nzQFCDgzE5eM43lF91GhfRjV1yTXHW5XW/56NKClSKASTSyar9/KJPRyRqhP
         yddrzVofSgjnidrFpeW3uoxS6yGirGg+UVLFMHi9H/6wna4R8gY5B9wyflyxLxL/oDwX
         aC11FBc46OwSqP2HmCBF50stIE22vRmdQ3ueCnA5WicjBwk/xMu9Bqp8kRjrYe05jfju
         lm933ixENo7hb8/cZARO9BtQz/2xEMlkwjpiJcBJn/EqPfSAgh1d0rTGd6Y8SLTJYLyn
         v2B5SSbeWgZS5xY4kjp7B+MjE33LamekGzof93H92RnAxFEKZcPZHs21LsllUT/Muy5y
         EhGg==
X-Gm-Message-State: AJIora83R3ZgIeLe2xX2lXh/yVVfdR35VLuPcpjzbcyNjaZhD8SlOOmH
        YXJ7lxZpIpkcTGP33IptgB1n6QQAYHfirVsg33E=
X-Google-Smtp-Source: AGRyM1szAzmxnPmFhMRNyZADWHCi2VJJLy5Mh1bVtJZaNZezIoH1ssQqGJ/HU3W8IgAwtruD9Uu7zTw5d+b2DOEHpPs=
X-Received: by 2002:a05:651c:1993:b0:25e:2766:924 with SMTP id
 bx19-20020a05651c199300b0025e27660924mr4318545ljb.231.1659282935860; Sun, 31
 Jul 2022 08:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <1659174051-27816-1-git-send-email-quic_akhilpo@quicinc.com> <20220730150952.v3.2.Ifee853f6d8217a0fdacc459092bbc9e81a8a7ac7@changeid>
In-Reply-To: <20220730150952.v3.2.Ifee853f6d8217a0fdacc459092bbc9e81a8a7ac7@changeid>
From:   Rob Clark <robdclark@gmail.com>
Date:   Sun, 31 Jul 2022 08:56:01 -0700
Message-ID: <CAF6AEGs7zKDoRY=ijxFQvaZig=UiSPgWkJFA-PY2MTxKWr5bpw@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] drm/msm: Take single rpm refcount on behalf of all submits
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2022 at 2:41 AM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>
> Instead of separate refcount for each submit, take single rpm refcount
> on behalf of all the submits. This makes it easier to drop the rpm
> refcount during recovery in an upcoming patch.
>
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
>
> (no changes since v1)

I see no earlier version of this patch?

>
>  drivers/gpu/drm/msm/msm_gpu.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index c8cd9bf..e1dd3cc 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -663,11 +663,12 @@ static void retire_submit(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
>         mutex_lock(&gpu->active_lock);
>         gpu->active_submits--;
>         WARN_ON(gpu->active_submits < 0);
> -       if (!gpu->active_submits)
> +       if (!gpu->active_submits) {
>                 msm_devfreq_idle(gpu);
> -       mutex_unlock(&gpu->active_lock);
> +               pm_runtime_put_autosuspend(&gpu->pdev->dev);
> +       }
>
> -       pm_runtime_put_autosuspend(&gpu->pdev->dev);
> +       mutex_unlock(&gpu->active_lock);
>
>         msm_gem_submit_put(submit);
>  }
> @@ -756,14 +757,17 @@ void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
>
>         /* Update devfreq on transition from idle->active: */
>         mutex_lock(&gpu->active_lock);
> -       if (!gpu->active_submits)
> +       if (!gpu->active_submits) {
> +               pm_runtime_get(&gpu->pdev->dev);
>                 msm_devfreq_active(gpu);
> +       }
>         gpu->active_submits++;
>         mutex_unlock(&gpu->active_lock);
>
>         gpu->funcs->submit(gpu, submit);
>         gpu->cur_ctx_seqno = submit->queue->ctx->seqno;
>
> +       pm_runtime_put(&gpu->pdev->dev);

this looks unbalanced?

BR,
-R

>         hangcheck_timer_reset(gpu);
>  }
>
> --
> 2.7.4
>
