Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E1947631E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbhLOUXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbhLOUXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:23:36 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED76C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 12:23:36 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so26324952otu.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 12:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FU6DW9TAIgBZS3BvZRbpIiYJXu+E19y7bn4modn6Y5Q=;
        b=Or8gG9UbAvhApHsMhgbRMAo0/VDU1n7uZAeNZvPgQhG976afc2ZA7Q3s+MeFagQteS
         NKnvWmR3569uEYLnjImMb1y2DB/vK0B9/WVfWFtsauzQO+eJ0dKfKZUq3QyTmoAJYcp0
         /sALoJGAxMkLTTjGS1vXH0EefcGXsWdQ2Zo1/i/JTiTrtefn3m6QSUyMgKMRxN7dEiaX
         8DauXlMGXgzZJ4yroAmwArG9rcfRyiwIXlpK12LA6P54K37aCkgLQLn4LI//GnW0VXxW
         5Z3y4jWaNOmTIEXqCO0eMunXXFlM19Ohxx3/OBU5pA8LSO+J6u9Vz/hPvYK2yqQJg33G
         MgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FU6DW9TAIgBZS3BvZRbpIiYJXu+E19y7bn4modn6Y5Q=;
        b=O+P9TrWDYV/5W+vNMtp5SKc9fdX1IPmQXt1R7pTgLc4TZ9dNPU71y1lBjuqvMR5cko
         amE63dKLUCYDH43zmWGLYvzZoko4t6+NincBtyDep5wLUj5K2n4DVOvj7/qB356zWbBZ
         ZrFaRfUkZiuP8faL17tyoNDYmI2a4VyunG8ejlF17DtuSRUqmdMpgzaTX+0io+93eeaN
         FCQhK4ODNdbGGw7+f2AO6+6cHS4AHgm9z8yPcUwdK4FQg0F3tuV30Jby9DHoQuJPk5Vz
         gnPEt+2xWGa9c8Yji4ZVFyu6csH/1V2sC3MacyROOVcB+4EZ+gmxQcTeDqFs8mRyB8sI
         uSHA==
X-Gm-Message-State: AOAM531ozxubWFUYd9faS2OqtfGXCuohaJlxZktKMKB3bZjTc2IHKjGa
        ltxn3iGq3OoY1I9ww8fJASRlcZXzRYxUClgUVUs=
X-Google-Smtp-Source: ABdhPJzBBSaiN/Ft681zK6iiU9ZX+VHeu8HBNV1rtwv4sKxZwPFXLGR7E8iNW3+G0zxazJQ2LTR0Vto5utGDdtxADmg=
X-Received: by 2002:a9d:67c1:: with SMTP id c1mr10317586otn.299.1639599815897;
 Wed, 15 Dec 2021 12:23:35 -0800 (PST)
MIME-Version: 1.0
References: <20211215092337.340266-1-zhouzongmin@kylinos.cn>
In-Reply-To: <20211215092337.340266-1-zhouzongmin@kylinos.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 15 Dec 2021 15:23:24 -0500
Message-ID: <CADnq5_Mng5TyxZ6n1QpOobOFPQn2uB8oGWxG9et+R8go+p5-qA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fixup bad vram size on gmc v8
To:     Zongmin Zhou <zhouzongmin@kylinos.cn>
Cc:     Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        xinhui pan <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 10:31 AM Zongmin Zhou <zhouzongmin@kylinos.cn> wrote:
>
> Some boards(like RX550) seem to have garbage in the upper
> 16 bits of the vram size register.  Check for
> this and clamp the size properly.  Fixes
> boards reporting bogus amounts of vram.
>
> after add this patch,the maximum GPU VRAM size is 64GB,
> otherwise only 64GB vram size will be used.

Can you provide some examples of problematic boards and possibly a
vbios image from the problematic board?  What values are you seeing?
It would be nice to see what the boards are reporting and whether the
lower 16 bits are actually correct or if it is some other issue.  This
register is undefined until the asic has been initialized.  The vbios
programs it as part of it's asic init sequence (either via vesa/gop or
the OS driver).

Alex


>
> Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 492ebed2915b..63b890f1e8af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -515,10 +515,10 @@ static void gmc_v8_0_mc_program(struct amdgpu_device *adev)
>  static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
>  {
>         int r;
> +       u32 tmp;
>
>         adev->gmc.vram_width = amdgpu_atombios_get_vram_width(adev);
>         if (!adev->gmc.vram_width) {
> -               u32 tmp;
>                 int chansize, numchan;
>
>                 /* Get VRAM informations */
> @@ -562,8 +562,15 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
>                 adev->gmc.vram_width = numchan * chansize;
>         }
>         /* size in MB on si */
> -       adev->gmc.mc_vram_size = RREG32(mmCONFIG_MEMSIZE) * 1024ULL * 1024ULL;
> -       adev->gmc.real_vram_size = RREG32(mmCONFIG_MEMSIZE) * 1024ULL * 1024ULL;
> +       tmp = RREG32(mmCONFIG_MEMSIZE);
> +       /* some boards may have garbage in the upper 16 bits */
> +       if (tmp & 0xffff0000) {
> +               DRM_INFO("Probable bad vram size: 0x%08x\n", tmp);
> +               if (tmp & 0xffff)
> +                       tmp &= 0xffff;
> +       }
> +       adev->gmc.mc_vram_size = tmp * 1024ULL * 1024ULL;
> +       adev->gmc.real_vram_size = adev->gmc.mc_vram_size;
>
>         if (!(adev->flags & AMD_IS_APU)) {
>                 r = amdgpu_device_resize_fb_bar(adev);
> --
> 2.25.1
>
>
> No virus found
>                 Checked by Hillstone Network AntiVirus
