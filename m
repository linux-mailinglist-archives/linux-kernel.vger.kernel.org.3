Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E18462663
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbhK2Wvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235660AbhK2WuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:50:09 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477B0C08E835
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 11:02:29 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id x6so75867876edr.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 11:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vHIcZ4ajJxCRfp6TfnnK3m4uOLsqq/PnoEl1uZz7+2M=;
        b=LHqpOuZ9bbPhm6BAEqNPiFiqNjqndKV4zQZgjWjGtAQXoprCwWKIcC6/fyMFaSBQ6N
         k+M+udaeBPxQSV/sqCPS8gOOdZr6WhSxUEYATlnHbqTy8naDBiledHzWmwVMy0eMdV+o
         X5fV9bcsNEZcXKYY4M9flL9DfU4JNrNc6Wi7tlanU/9oSP6XRf2M7zmjO2MmRwlLoDOr
         l81B3g2OMpp7EXMM9gbQ8nJGhZw5Emg0VQ/KMNogBPSu8XxQJOS5ddNYZXRxAQ4FwNN+
         lE8Wv32IPzfNJ+SGajHs4GHojQXuYFahcQ72Q/jolrV3T85hGnbS+/eM/1yqCW1k9cfP
         kAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vHIcZ4ajJxCRfp6TfnnK3m4uOLsqq/PnoEl1uZz7+2M=;
        b=torUjWgKmM/jZYZgk6IgQeSRZEE2yAjZFDCwPpQYRHJkMnhQiyFkR/1qNHU0xa/CKR
         Chau//yB+Vq/1yhkIHGk2keW9Q6THU+ricItUyf3HwbLBZsN6WhSm3CtNLSHKSWR/cit
         27xFASCnI66dFUxU2CXRLVWfL0vq/6Xk+ScyrpRfPOaxSLVdcSPau2/8/sIrp19n9Npj
         a9EsGXWC1FowZUBFgYTlxhwiqSIlgTylj+vf9Ywze8dr4ML8E7Evhad3W3Q9DIcQwyL5
         UdxleIEiRpyQr2fn6cSY1PFQC/KYGKtfvNYJSkuevIEHLMw+V+yBoQ632Z+0KblVz28h
         Jg8g==
X-Gm-Message-State: AOAM531Ue8a0ZUHI5aC4nhrCl760ba5S6YT9WyJXkMLjTv+OwMpuEFgO
        MWysa6dEI5109jtDWs4mgYlD95jiuRe6kCt6/L0=
X-Google-Smtp-Source: ABdhPJxGlKZy56+YMwTdyV8+MSNj2EB5bGzBFj/T14hqS9VsMurjSEHNZMxWqn+sj4E8NhGcq44MS8KxUYhtEUSU9i4=
X-Received: by 2002:aa7:c846:: with SMTP id g6mr76715007edt.75.1638212547798;
 Mon, 29 Nov 2021 11:02:27 -0800 (PST)
MIME-Version: 1.0
References: <20211128201916.10230-1-rikard.falkeborn@gmail.com>
In-Reply-To: <20211128201916.10230-1-rikard.falkeborn@gmail.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Mon, 29 Nov 2021 20:02:16 +0100
Message-ID: <CAH9NwWfhtYKsPMsiTN-pYc3CQ5XcA9TyX3R4yZch7ZHL2+Soyg@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: constify static struct cooling_ops
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am So., 28. Nov. 2021 um 21:20 Uhr schrieb Rikard Falkeborn
<rikard.falkeborn@gmail.com>:
>
> The only usage of cooling_ops is to pass its address to
> thermal_of_cooling_device_register(), which takes a pointer to const
> struct thermal_cooling_device_ops as input. Make it const to allow the
> compiler to put it in read-only memory.
>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>

> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index 06bde46df451..37018bc55810 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -1658,7 +1658,7 @@ etnaviv_gpu_cooling_set_cur_state(struct thermal_cooling_device *cdev,
>         return 0;
>  }
>
> -static struct thermal_cooling_device_ops cooling_ops = {
> +static const struct thermal_cooling_device_ops cooling_ops = {
>         .get_max_state = etnaviv_gpu_cooling_get_max_state,
>         .get_cur_state = etnaviv_gpu_cooling_get_cur_state,
>         .set_cur_state = etnaviv_gpu_cooling_set_cur_state,
> --
> 2.34.1
>


-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
