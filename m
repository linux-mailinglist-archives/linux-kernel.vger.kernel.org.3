Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E5B5419CA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 23:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377738AbiFGVYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 17:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377049AbiFGU2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 16:28:22 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F481DAE53
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:33:47 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 61-20020a9d0bc3000000b0060b9bfcfe76so13475362oth.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 11:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=riYxWgnfyEpcIgAiDw0L5BFc6QRBMqAyo9RFEVz4Ltg=;
        b=XBkzcn57gKjDBu71hUDF7cAVJFALVJI4Nv/Ffo3O1uQTQ2qw8JOcs/hc4yUu1NHNCp
         +KgXAx7OYD6YxbzeZPvOozEqWsVq4hSzGeh3c/xROn+dyTt8DboZkCw/Tl+RdhY6OEAu
         iX4P2GFeZ0wH6Iz5JajX+2AbV6wdBs5eqCa1Bh0/vGpZlUO0C328blVHX9R6iQUOi2co
         FT58XcbsAP3L3EfnAg3UOvZT9e5p4dfMHJMekbq1peYgPGsbMsGw8uBfHFskrXtrc2Um
         i0j85cQnTjMaDHcg5FH6wBHKFitjvV95aXQj81nT/B3ysWsJ6ujEayv7pAdT1Y8Y8JP/
         Vnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=riYxWgnfyEpcIgAiDw0L5BFc6QRBMqAyo9RFEVz4Ltg=;
        b=LRDwF2CmjzHcoIew6zCgaT3tVnRozzVa5+RjfBMRWkw1WbX6fOzBLmJcAyZlmv4O0g
         hAW5CgQcz3Ai5YTJmlGh6Pd/s9wf9aAcO+5RtWgZE7aQhFLJuqz9DDqCQTLfsPtSbX99
         uao9/f26KG2TwSkTKb9F51eaJA9jkdiYCrVXw3Fn53VC6A9G8m5K6G691vAy9LCBYB7K
         sVp4qw1rITI1/ffEsHzMC16C4nsL78T+D9cHBzZKId7WwnJY3cVD+1BSGiYET3KEJNGx
         aTQ5DphyD0hVVs25kENuAI/OG0QOGkiBjM7KHepXBJ6ZLnj8O0gk8BnD0qZPuGpL9qj3
         8Q2w==
X-Gm-Message-State: AOAM533WyOis7Z9dQMnE2shOy1CofxGrP13LzzpIfCUsRkkhXVjURBlq
        IakAllXOalniNHtTtUNb+TgoNZ8J2l6vJyq5c7I=
X-Google-Smtp-Source: ABdhPJzCFqUJwteu4cxYpuQ2hYA5XaObaQJO5AY5u27Jnfmp15v1BHMqqwy3pR5lplBBUEgCdfoXCvfF1xZCEOYJgmI=
X-Received: by 2002:a9d:5f9c:0:b0:60b:f3e3:4658 with SMTP id
 g28-20020a9d5f9c000000b0060bf3e34658mr6776825oti.200.1654626826726; Tue, 07
 Jun 2022 11:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220607153631.7885-1-xiaohuizhang@ruc.edu.cn>
In-Reply-To: <20220607153631.7885-1-xiaohuizhang@ruc.edu.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 7 Jun 2022 14:33:35 -0400
Message-ID: <CADnq5_Nwf_bDVmT3fXTHFcxwfK1qzBP2Bi3mfYdSAHD5q9G=CQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/radeon: integer overflow in radeon_mode_dumb_create()
To:     Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Tue, Jun 7, 2022 at 12:05 PM Xiaohui Zhang <xiaohuizhang@ruc.edu.cn> wrote:
>
> Similar to the handling of amdgpu_mode_dumb_create in commit 54ef0b5461c0
> ("drm/amdgpu: integer overflow in amdgpu_mode_dumb_create()"),
> we thought a patch might be needed here as well.
>
> args->size is a u64.  arg->pitch and args->height are u32.  The
> multiplication will overflow instead of using the high 32 bits as
> intended.
>
> Signed-off-by: Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>
> ---
>  drivers/gpu/drm/radeon/radeon_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
> index 8c01a7f0e027..84843b3b3aef 100644
> --- a/drivers/gpu/drm/radeon/radeon_gem.c
> +++ b/drivers/gpu/drm/radeon/radeon_gem.c
> @@ -833,7 +833,7 @@ int radeon_mode_dumb_create(struct drm_file *file_priv,
>
>         args->pitch = radeon_align_pitch(rdev, args->width,
>                                          DIV_ROUND_UP(args->bpp, 8), 0);
> -       args->size = args->pitch * args->height;
> +       args->size = (u64)args->pitch * args->height;
>         args->size = ALIGN(args->size, PAGE_SIZE);
>
>         r = radeon_gem_object_create(rdev, args->size, 0,
> --
> 2.17.1
>
