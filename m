Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E88B4D2306
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 22:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350233AbiCHVEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 16:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343684AbiCHVEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:04:41 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6175647067
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 13:03:42 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id s6so249094qtc.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 13:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yWhY8qlsdz7JCpSZpDlipoozq4SQyuAAucvDJGO5X2A=;
        b=I18vN8/IGEzuef44T7UgjcAGV/5fB8EmlgFJQNIRCsZvpnXLXns+WsL3tlcx5x3Sa7
         +EbPcoWiByB4/+7WqmKvv+JHeQDuLq1xTe83ek4BHXiWHrfM5pmZJyc06+SoudkVM7E9
         SCYmq+1SCmnIoSI1yIa4dYQ2Y8nFz+7z6zsu9kqb1ygxFXjg91duNvBVMunZ0YrW6Nl2
         Cby3t19bnzEOkLdkKDXVJLufP1M8N8qcr2Ppt6s5DHCb+QY6yjchRWl4FUAJC0xU5XqW
         tOSjDLYSMrSAhMDXF1tErKpGWljGB1tldoWc3aSuy4ZPwAjLgOE14hj5T9XM89bg6Li4
         B2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yWhY8qlsdz7JCpSZpDlipoozq4SQyuAAucvDJGO5X2A=;
        b=Z3NXcry/Omt24dBpMvUwKNss7t3tBrSczqTQtcG7AZhWuoM706pqgqpEOKOCXzb235
         ELleg8SNKDQWZpK0zyoGwMOZxGJFBtegd4+v8ShO0PvEUPoG2481cZC0I7NM4IpOiicd
         LonMJs3pPJOas1slyelR+LgCYQeFoEalCL4qikX+2iMONejC/keHVf5pCIhgThRhAYEQ
         4kQUhHvlgcZsRc0SExdi2ndeMcvDirLUgSvwXmyZjLr//VkVDVDALRE+oOgO8jakW5lK
         jOPJWh9bZJS0nWAkzfA2L2VmP+mVcUa4Vl10goE03SKWriHt8K+rUHEI7ibVxyBF0HF6
         D46g==
X-Gm-Message-State: AOAM533ssj6z9OACJHNDoo+RJKUsuyiDK5frS43vZ/+dOJbJhkxjXqUR
        baH3nViKMmlu2sOGxCBZ282UrW6/30Qj8OXPiUvC3A==
X-Google-Smtp-Source: ABdhPJxHaZrUYr2m2Hlos3OFVZ5iTKhrjft5Lscz7Y+azOpRkhGOU+LvOYkxFfMkz8mobriFIysyNSnVFHYzB2SB02I=
X-Received: by 2002:a05:622a:170d:b0:2e0:7148:ec14 with SMTP id
 h13-20020a05622a170d00b002e07148ec14mr3907614qtk.62.1646773421537; Tue, 08
 Mar 2022 13:03:41 -0800 (PST)
MIME-Version: 1.0
References: <20220308184844.1121029-1-robdclark@gmail.com>
In-Reply-To: <20220308184844.1121029-1-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 9 Mar 2022 00:03:30 +0300
Message-ID: <CAA8EJpqzdXTMbFt4xT5t+nsr9Hgo4mUyfJRqx6obcVtxy-tPHQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/gpu: Fix crash on devices without devfreq support (v2)
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
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

On Tue, 8 Mar 2022 at 21:48, Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Avoid going down devfreq paths on devices where devfreq is not
> initialized.
>
> v2: Change has_devfreq() logic [Dmitry]
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/msm_gpu_devfreq.c | 30 ++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
>



-- 
With best wishes
Dmitry
