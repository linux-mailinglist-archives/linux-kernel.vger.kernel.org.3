Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4C7462611
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbhK2Wqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbhK2WqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:46:21 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41B2C0F4B38;
        Mon, 29 Nov 2021 12:56:55 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q3so16771769wru.5;
        Mon, 29 Nov 2021 12:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ql+suTnFvydSezbeHxVyPeDhtZlxR55/pcfoLfrc7+k=;
        b=Ens7ubDTOxqILotmtNmGg8U+4zE7BrADm8c85OPM9xJDZ/hgVyIKJZjoV+78BP7c7k
         /42TkHcAidV1uMsYtQMyGrV1m46QqeIWB61TSLpW4zNiUKOLWvUdPvCHt6tFReeOyvkj
         ohe4+m5f4e3OgOcc7zYxKRjV2MHoZGYlBLqmAftUa3pwuorsO8l/oHwYsC2bgaftikab
         hecr4tOEXJJAYjQ0mhefuLilKbAr95aBIF2o8Hj/FkBh6r+CAD7AtoWA7Ynw3C9yUmIm
         +/ggRVfCsqiUMEwKZp2FlaERAsIBfSkbyxqR16melEVlK/TkaFlefutwni+FeVH85os8
         5ZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ql+suTnFvydSezbeHxVyPeDhtZlxR55/pcfoLfrc7+k=;
        b=ni15KvOsu8R6+RUwbqWPZygZfLPk94si80eT/euSSZ7x/fXK9+ouo3v7XMEF+/X1CW
         IWkdb4S9ZObFZD3jcEuHQtrrGHox8d4teg3+0prT1gm5eEmhqxr/44Z/lXJKeL62LU/8
         RlOlO59JEle4GVhY8yxe+hOwIzgHfWKcRdZUPiQbhV7FQtqnEFGkp2hI7GyZS6YZgvgi
         i+Vgs09j/2efIYO+7VIT8+Ob0ZhP1s2ZAQrq0k1IEz6WwdM/l9W5smtDKQwJG/qt9Xy9
         AVFLlC4VFF0kPR8lp4HjVGksY3tdi2d2R+LIPkWUDlDGAh9l+LY2Oza1P7L95Jx9wbEw
         G4RQ==
X-Gm-Message-State: AOAM533BgI9PhYqtvehbT9g3/G1o2ZAo2XrMixU+WypieWLjqIqrCXK0
        1qUYhQiw+ksaoCFGWX3DTukOsQEl7eEuWlue7Zc=
X-Google-Smtp-Source: ABdhPJyrJ30OAXdBPr/U7cQs7gHEQbhx9D9YurENX81bSHU6lw8F1FvL1j+nliIEMNEguTJT6UDhj1LZLQ4tblRLOcg=
X-Received: by 2002:adf:e904:: with SMTP id f4mr35829349wrm.245.1638219414380;
 Mon, 29 Nov 2021 12:56:54 -0800 (PST)
MIME-Version: 1.0
References: <20211129182344.292609-1-robdclark@gmail.com>
In-Reply-To: <20211129182344.292609-1-robdclark@gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 29 Nov 2021 13:02:05 -0800
Message-ID: <CAF6AEGtLoT7XE-KoASfn=FjMvPmSijmjUYSyd_dFgubnjio3zw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/gpu: Don't allow zero fence_id
To:     dri-devel <dri-devel@lists.freedesktop.org>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 10:18 AM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Elsewhere we treat zero as "no fence" and __msm_gem_submit_destroy()
> skips removal from fence_idr.  We could alternately change this to use
> negative values for "no fence" but I think it is more clear to not allow
> zero as a valid fence_id.
>

probably should have added:

Fixes: a61acbbe9cf8 ("drm/msm: Track "seqno" fences by idr")

> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/msm_gem_submit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
> index 282628d6b72c..6cfa984dee6a 100644
> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> @@ -881,7 +881,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
>          * to the underlying fence.
>          */
>         submit->fence_id = idr_alloc_cyclic(&queue->fence_idr,
> -                       submit->user_fence, 0, INT_MAX, GFP_KERNEL);
> +                       submit->user_fence, 1, INT_MAX, GFP_KERNEL);
>         if (submit->fence_id < 0) {
>                 ret = submit->fence_id = 0;
>                 submit->fence_id = 0;
> --
> 2.33.1
>
