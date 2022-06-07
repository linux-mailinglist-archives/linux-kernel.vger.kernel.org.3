Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3404F541A37
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 23:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380149AbiFGVaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 17:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377851AbiFGUeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 16:34:09 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C6F1E7AEC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:36:16 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id i66so24990889oia.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 11:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=et5d4DM7Qkz5qPPCoiTPlM6P1258hTgQ0iEkTPrpV+I=;
        b=PuFBuqldb4cHgsAojupGIYPzKREKfkNatPa7bNJQ3T7Y+VXcNNgnWsYkvgJ/efgrh3
         6Tn3ounWD12Wg3D59zmyEuUSXPLON+5y+Nue/CWFFSBVH4f/G7rc7jpirEo3w6c2wPxC
         xHFhs/2y9CqjlPp5zehXBRxbhz6Hoz43R/XOkXaUR/jU++0Rvqfu/8tpLqh0ykZLOqCM
         E7ev37DY+9K9VrD5xzMbiLXP5yu8PUfmJjpJ3AjJKgAR28c36eSF84wSsYmuVxp65Dy0
         ocOiAaBGBT87tJfATIkqFQLfoCX1V2jcq2zXGsnmZpjMeZ56p2G8QVcGYYZG4KFtFwo8
         JjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=et5d4DM7Qkz5qPPCoiTPlM6P1258hTgQ0iEkTPrpV+I=;
        b=4Gg/7YwpEOrtmzp8YI9v+H6XIHNupcmqGeEs14X394CNbF3BVFqmFZbfMnCRZnb7Xs
         uvbzWb6udN2Sb+z7d2k4Z1V+XtNeYpEaXl6O7CGnOw1Z8yMAcb7BuoWysUIZONDchSZF
         kOkqPY+s8eKGy8hB7ZTTfXZDzSXm8Ff/yZGg1Zhh23b/fDhPqfjP4wmyLmlGkdJNCkk0
         tJrkFj2FvPgx0JMYdXCwDLW3YetcGf6oSlIHdp98nAgTVNySBTfGdfynyPZGub5DXMpD
         ro5zL5lILMNko9/lkCC4vNflTWeDyDYrYyWDCfrgd++OQYKmLJ3qIyNOT64//MrsHHWS
         hkEg==
X-Gm-Message-State: AOAM531o9oZmxYzW0J4WpEiVt+/Atwdz7sMXXVQ+EiwJeoc2SJ/8b1kJ
        FfF9N3IZ+/DGjyMpb1RDIBtjTU4Wlc0JdB+y6n0=
X-Google-Smtp-Source: ABdhPJzmUwUQfQ1DjEveyo8nz4KlADt9ph70/XrvL3Meqmc0UgfuQHYvRofrgjdJ+ret0rbkQJflWwhjvu8RZcC6Ftk=
X-Received: by 2002:a54:4f01:0:b0:32e:726c:bced with SMTP id
 e1-20020a544f01000000b0032e726cbcedmr128014oiy.253.1654626973764; Tue, 07 Jun
 2022 11:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220607151933.32850-1-xiaohuizhang@ruc.edu.cn>
In-Reply-To: <20220607151933.32850-1-xiaohuizhang@ruc.edu.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 7 Jun 2022 14:36:02 -0400
Message-ID: <CADnq5_MiHN=iXt4E5AKSixRqMR5bkqwoxXd_KUj02DFtcwhS6w@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/radeon: Initialize fences array entries in radeon_sa_bo_next_hole
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

On Tue, Jun 7, 2022 at 12:04 PM Xiaohui Zhang <xiaohuizhang@ruc.edu.cn> wrote:
>
> Similar to the handling of amdgpu_sa_bo_next_hole in commit 6a15f3ff19a8
> ("drm/amdgpu: Initialize fences array entries in amdgpu_sa_bo_next_hole"),
> we thought a patch might be needed here as well.
>
> The entries were only initialized once in radeon_sa_bo_new. If a fence
> wasn't signalled yet in the first radeon_sa_bo_next_hole call, but then
> got signalled before a later radeon_sa_bo_next_hole call, it could
> destroy the fence but leave its pointer in the array, resulting in
> use-after-free in radeon_sa_bo_new.
>
> Signed-off-by: Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>
> ---
>  drivers/gpu/drm/radeon/radeon_sa.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_sa.c b/drivers/gpu/drm/radeon/radeon_sa.c
> index 310c322c7112..0981948bd9ed 100644
> --- a/drivers/gpu/drm/radeon/radeon_sa.c
> +++ b/drivers/gpu/drm/radeon/radeon_sa.c
> @@ -267,6 +267,8 @@ static bool radeon_sa_bo_next_hole(struct radeon_sa_manager *sa_manager,
>         for (i = 0; i < RADEON_NUM_RINGS; ++i) {
>                 struct radeon_sa_bo *sa_bo;
>
> +               fences[i] = NULL;
> +
>                 if (list_empty(&sa_manager->flist[i])) {
>                         continue;
>                 }
> @@ -332,10 +334,8 @@ int radeon_sa_bo_new(struct radeon_device *rdev,
>
>         spin_lock(&sa_manager->wq.lock);
>         do {
> -               for (i = 0; i < RADEON_NUM_RINGS; ++i) {
> -                       fences[i] = NULL;
> +               for (i = 0; i < RADEON_NUM_RINGS; ++i)
>                         tries[i] = 0;
> -               }
>
>                 do {
>                         radeon_sa_bo_try_free(sa_manager);
> --
> 2.17.1
>
