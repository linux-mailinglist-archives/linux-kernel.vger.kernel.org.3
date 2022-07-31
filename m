Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36F3585F9E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 17:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbiGaPzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 11:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237343AbiGaPzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 11:55:16 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2641083;
        Sun, 31 Jul 2022 08:55:15 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id d14so1913847lfl.13;
        Sun, 31 Jul 2022 08:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Ne/P7o9VC5S2mG3eYUHz+PPIOi9U0nlbs1682j/rMpQ=;
        b=WV48Z0y12oRs4Obs5cBKWCSDCXjxTrLfDko81+db6aiT9HAPLr4+cPEPmyGXwV8A9z
         T0x5i6jBZkVSoyRMOeYFbC788df5F1C0qN2vdmh61+5ChYgdIhYnf5K+IFdWn+Bt+J9b
         u2TPxAwK7pyVD/qRnKl0ALUTkqLpoLnAsM/zvgo6E0ZC81EZgm5Lg+VShOh32JYfkOxY
         Vtrfkn1Rvq/2XnjWtwmgImTrZOH1++YLatVCC7SBq9ZOkV87sa40qm864w9+n01qeYQB
         SY0XxyvNGlHGGHPR5aEUxhbDADFNw2jCgebCn6BJCWV1grzBhEgEK4kQfsf4eQu8BIVV
         Mngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Ne/P7o9VC5S2mG3eYUHz+PPIOi9U0nlbs1682j/rMpQ=;
        b=jO3tXVcEGXYpyEFquaOXWHNl/5Y1Fh8lGqVO1Z+/TGE8oCMdvnmYM+3aJz4n/sEk1V
         wzgxxc0h2g4y+ZjqEK0YmemIjzQgtm3ZMrdrv/cd7gOEKpv4AtcECoqaIz7OrFfb59rT
         Luc+zSAIzBQpgxH4uk4N5yedT0cBtX53UlnmpsxLrQuqH9IWSJnHoaob0uUspyzaZ/3s
         fR6fvhrorprI1IpccUbwi9abGsfTQS8rX+FCvWhHbQ20hJVe9KP3gueo4ghvHQv9Gugi
         Zh5j8FWQSQ5dskdGohW4qvZN+xVOa4B0BB/U5QQFbdhn1gjYQ3uKFr+TdjKflF2ZwugH
         r/Yw==
X-Gm-Message-State: AJIora+gB5r6hj/h9+JSZR7NnkI9uXFwtayfAInC7t487qfPE2iGXX4l
        s+xwO0fTIAvt5joupxf3/dSS8cEX9LQkyjXD5jI=
X-Google-Smtp-Source: AGRyM1vr1MiiyWyo134AlbEHdPJ1v0gL4xTCoCdkZQltOZXrmoBzri1WX7UWCsJ5zokt2FRyr16hRM5p+o4EqG5I/UE=
X-Received: by 2002:a05:6512:1307:b0:47f:baa4:52c5 with SMTP id
 x7-20020a056512130700b0047fbaa452c5mr4104696lfu.103.1659282913251; Sun, 31
 Jul 2022 08:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <1659174051-27816-1-git-send-email-quic_akhilpo@quicinc.com> <20220730150952.v3.1.Icf1e8f0c9b3e7e9933c3b48c70477d0582f3243f@changeid>
In-Reply-To: <20220730150952.v3.1.Icf1e8f0c9b3e7e9933c3b48c70477d0582f3243f@changeid>
From:   Rob Clark <robdclark@gmail.com>
Date:   Sun, 31 Jul 2022 08:55:38 -0700
Message-ID: <CAF6AEGsOzd8wMbgpt7bGNdCspNoH4shQfTknwwdyVde8k4zcZw@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] drm/msm: Remove unnecessary pm_runtime_get/put
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
> We already enable gpu power from msm_gpu_submit(), so avoid a duplicate
> pm_runtime_get/put from msm_job_run().
>
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
>
> (no changes since v1)
>
>  drivers/gpu/drm/msm/msm_ringbuffer.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.c b/drivers/gpu/drm/msm/msm_ringbuffer.c
> index 56eecb4..cad4c35 100644
> --- a/drivers/gpu/drm/msm/msm_ringbuffer.c
> +++ b/drivers/gpu/drm/msm/msm_ringbuffer.c
> @@ -29,8 +29,6 @@ static struct dma_fence *msm_job_run(struct drm_sched_job *job)
>                 msm_gem_unlock(obj);
>         }
>
> -       pm_runtime_get_sync(&gpu->pdev->dev);
> -

This is removing a _get_sync() and simply relying on a _get() (async)
in msm_gpu_submit().. that seems pretty likely to go badly?  I think
it should probably replace the _get() in msm_gpu_submit() with
_get_sync() (but also since this is changing position of
resume/suspend vs active_lock, please make sure you test with lockdep
enabled)

BR,
-R

>         /* TODO move submit path over to using a per-ring lock.. */
>         mutex_lock(&gpu->lock);
>
> @@ -38,8 +36,6 @@ static struct dma_fence *msm_job_run(struct drm_sched_job *job)
>
>         mutex_unlock(&gpu->lock);
>
> -       pm_runtime_put(&gpu->pdev->dev);
> -
>         return dma_fence_get(submit->hw_fence);
>  }
>
> --
> 2.7.4
>
