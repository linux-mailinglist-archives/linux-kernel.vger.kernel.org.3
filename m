Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161064C4A97
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242948AbiBYQYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242946AbiBYQYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:24:13 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2F8CA0C9;
        Fri, 25 Feb 2022 08:23:40 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id j9-20020a9d7d89000000b005ad5525ba09so3922794otn.10;
        Fri, 25 Feb 2022 08:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wR/eoNNXBj1/My2CpHa5GPCtjCjqHRpXOZvwkOgYW9w=;
        b=EcyjzPZs9kbSzl+d2LBUySEw7Ulmassdt6Hh8IuhHTLAjFK8LAnbRNuhMjYtBURuh7
         U7PUdfm+Nkp0qFhqzg1Ssk5rv1jeROeHDT3B/Is+J9tVvn/HlyFYUEwmU1gySUuSDRnW
         KhjooY1BXTbxKsc2U7OKjXGvpb3oTkPdCkJ8JwhN1CJCTCn3eDDP6P7tBmPpKPaUKdxz
         LWkFNyBxpuCT6w5i7QQxQBxuD74obmTKjekinxfe5gHfP5xsvdu3ncX302OFGRB7X9xe
         IhOwETkKItOo8RFeRy77h4kQjtFMCklL7r7EtlhMWxZuhDmlN65X33dxeZ6vmdNc6rPT
         xK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wR/eoNNXBj1/My2CpHa5GPCtjCjqHRpXOZvwkOgYW9w=;
        b=JFKdroa08qDMwRTcWgsKM35KIXrG0ZscDVyZ8g+/yply1JG5zob5R7t3nONbgSIhHU
         N9PGZyswTMoJDtaqpluDExkovxwHWGUkZ5IsoNBBscF75uO/pFaN5+A1CaFYnQvsIaMG
         8vLuPSKN0QXHfWs8Ya9QEEF+/4ILWZIgcVKz90FmdpFnI592mRokvIYAVEfbc+HCwQWX
         PCp/PQa6xQSlwNUTWin7laSf9i75bvnh4kOCEPIg57mc+bzponlopc4RL9smeV0nftGG
         w69Qu5vXa9i5X7cowH+80fWbtOl2dnIVxPnME0BHC2yzFU6fKAeN9Tlqb+VY0PMK6l+J
         XCgA==
X-Gm-Message-State: AOAM533RasaSYzkPqdTxdNBmfba7iAiUI3ywvecLG4gBQwIs4x/uPE40
        IqjAyZYUIja9p1TqzKD+06IW8G1mZpN10wxhv+fl139p
X-Google-Smtp-Source: ABdhPJy4YvYnuTW9nQ3arrHphuxc2EfNmJj4uEoJL2y6biBbvt5LPVxOadtYIjKArwwfIlgX/RiklDzSSXL8j5CHjGs=
X-Received: by 2002:a9d:5a06:0:b0:5af:b5fd:5b72 with SMTP id
 v6-20020a9d5a06000000b005afb5fd5b72mr2906065oth.200.1645806220062; Fri, 25
 Feb 2022 08:23:40 -0800 (PST)
MIME-Version: 1.0
References: <20220224224316.149704-1-colin.i.king@gmail.com>
In-Reply-To: <20220224224316.149704-1-colin.i.king@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 25 Feb 2022 11:23:28 -0500
Message-ID: <CADnq5_Ot37zJGv8+JPNHd5OfPy94Ek2xXnNQxbCbzUPXDofwzw@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu: Fix missing assignment to variable r
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org,
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

Already fixed.  Thanks for the patch.

Alex

On Thu, Feb 24, 2022 at 5:43 PM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> Currently the call to function amdgpu_benchmark_move should be
> assigning the return value to variable r as this is checked in
> the next statement, however, this assignment is missing. Fix
> this by adding in the missing assignment.
>
> Addresses clang scan warning:
> drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c:168:7: warning:
> variable 'r' is uninitialized when used here [-Wuninitialized]
>
> Fixes: 9645c9c9fb15 ("drm/amdgpu: plumb error handling though amdgpu_benchmark()")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> index 3136a9ad2d54..bb293a5c6fd5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> @@ -163,7 +163,7 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
>                          "benchmark test: %d (simple test, VRAM to VRAM)\n",
>                          test_number);
>                 /* simple test, VRAM to VRAM */
> -               amdgpu_benchmark_move(adev, 1024*1024, AMDGPU_GEM_DOMAIN_VRAM,
> +               r = amdgpu_benchmark_move(adev, 1024*1024, AMDGPU_GEM_DOMAIN_VRAM,
>                                       AMDGPU_GEM_DOMAIN_VRAM);
>                 if (r)
>                         goto done;
> --
> 2.34.1
>
