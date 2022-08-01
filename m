Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1FC586FA3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbiHARiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiHARiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:38:18 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D65838B7;
        Mon,  1 Aug 2022 10:38:17 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id z25so18462106lfr.2;
        Mon, 01 Aug 2022 10:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ZEofs24gWs056HlATsdo9nk24MrkNe/lc9UM4+Isgr8=;
        b=Y6aD/NFrfESMvBfbHzvKOWWdDZQzFo2aG0nDV5EzCdNn4dWqhzz55mE6mbkGX4X023
         w5f+dmNk7z7SwcCdijk0Gcahw2NhGVeHrgPh7AyzIc3O4cZ0amRedlG9Aj2zCWP2Gaw1
         VDLnkeRuX6DyUR1cfRFhGREXishTcJx85CfewWjc51jacmOqc9rgj0omjylug/jBR/iD
         YJzuXVhof3t/CpA5FNbIDnp70aZKTec0ly7qX39koUnCNNZiPhjlFQD4ssz9erbDBNU+
         ZGNIK7s7nKoRiy78/O/sovkFTvOuN2Lt7wAQVl7q0vBBO/ctYd5xNyZ5t3J9nT3ZJOhr
         aOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZEofs24gWs056HlATsdo9nk24MrkNe/lc9UM4+Isgr8=;
        b=rxzC5wZDzuwlCiLqKo9z38mFA1vFlEj5hRH5OQ+b4ruowwy0BX/hOzQPU/wOv1hSvr
         sPO2VzAJ8cH7F+9kGIRNHfMQGtMmpEzkJOrk5QOMwu+OjmohJxl12Le7Ea0mRoYIue2T
         M4quu1x4ACQQMu5j79QdMiwSviEpR0Wb/r0nCpayYhv+lw974d1Hihs/SYL2DDVDiaUk
         CsbhPBejwdDgLhhe3OV4DFanRZSMHukLJoIZWqsh0tm4W6DJBV7kvnnDX4CuY7RpdaZx
         vk2vIQo0wI22al8+7qTDZwkI1/kd0fJOyKCrSfrkoWy7DAR4mACOHdlN6WS3O9SFoWju
         TcYQ==
X-Gm-Message-State: AJIora+TxKGqVISF1md73Woimkn12U2z1ZzShqiawVyHHyoDSg+OOBqG
        Sh1hj66chXgNZyD42c5u8u/gyqcvIHQSnhbeXzoMUVds
X-Google-Smtp-Source: AGRyM1uH70a7t4bA3N9awioJlcyh926xaZ5LmjMqI/SMlNSixVeVv7X58I/Su0ACuAScAp5/nzenLH2wV2YKiMFTjBI=
X-Received: by 2002:ac2:4f03:0:b0:481:50f7:ac07 with SMTP id
 k3-20020ac24f03000000b0048150f7ac07mr5615148lfr.422.1659375495569; Mon, 01
 Aug 2022 10:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220708162632.3529864-1-bjorn.andersson@linaro.org>
In-Reply-To: <20220708162632.3529864-1-bjorn.andersson@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 1 Aug 2022 10:38:41 -0700
Message-ID: <CAF6AEGuWj_7MPaYCcQa+ewr2MsLGNttKO=HVqmb72SPEemmizw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/gpu: Drop qos request if devm_devfreq_add_device()
 fails
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

On Fri, Jul 8, 2022 at 9:24 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> In the event that devm_devfreq_add_device() fails the device's qos freq
> list is left referencing df->idle_freq and df->boost_freq. Attempting to
> initialize devfreq again after a probe deferral will then cause invalid
> memory accesses in dev_pm_qos_add_request().
>
> Fix this by dropping the requests in the error path.
>
> Fixes: 7c0ffcd40b16 ("drm/msm/gpu: Respect PM QoS constraints")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Rob Clark <robdclark@gmail.com>

> ---
>  drivers/gpu/drm/msm/msm_gpu_devfreq.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> index c2ea978c8921..21e271a318ee 100644
> --- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> +++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> @@ -198,6 +198,8 @@ void msm_devfreq_init(struct msm_gpu *gpu)
>
>         if (IS_ERR(df->devfreq)) {
>                 DRM_DEV_ERROR(&gpu->pdev->dev, "Couldn't initialize GPU devfreq\n");
> +               dev_pm_qos_remove_request(&df->idle_freq);
> +               dev_pm_qos_remove_request(&df->boost_freq);
>                 df->devfreq = NULL;
>                 return;
>         }
> --
> 2.35.1
>
