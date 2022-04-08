Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647014F9D84
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 21:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239197AbiDHTKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 15:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239190AbiDHTKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 15:10:49 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71935FA238
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 12:08:45 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id x8-20020a9d6288000000b005b22c373759so6727285otk.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 12:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4RDkLQsY+tsOENcOBL3ibndewOoaXXvYJerio/FFaLo=;
        b=HkYhGIWVZ8Thkkz6utKm5XMzS7kDFaNREki6y3Bt0ydRwhnft+Sa3OZHP0zfvYZPfe
         YTgbwNnkYoe2kX/neqjd3yQSSEBkZe3O/+n2FnHFkZ4fP82zAoolHzRfAYiLp+2FH2nz
         Ux4EQcgMpsB9GYy3yR0iN47/xVQnqxxMWQVhx9HG16M7X5Hu6MTyW89MwesJFgMPj9tQ
         Iea3dYjgzLg22QJCqMlLSyxLoL9YDwUjmGJhFHYZaPvb9FG/b08plMbPyuydfQ26RSGe
         GAT64QTKCyR7QFQLnRPg3dE+V4FEB/MS6LYXJy3UzroWJSWMyw5JImDlOIresmCUpLLa
         ra2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4RDkLQsY+tsOENcOBL3ibndewOoaXXvYJerio/FFaLo=;
        b=QnVzOGxgj+Wk98K2hwXAq8JXdfWBN4vEhFN48lnB+BmCej9/Az/M/7YKd9uphqwPXa
         9Tu242eugASh0axbs4ucJoTkwFrLFCHKHH1QD6q0eIoJ75Ys0F6sl/FYplwwpyBHvptA
         /sox5gtR2i2O6HPu0B9QiYRoqcNvXNNWNYHbsNZU8qvwfz2Cr2Zr5Lgt2tHiPyUkJbe8
         yok4W5szemkJT+4zn5AuEqXUsafOhkfY3ANBJc4QLgbPtW+jdB5tPkMjx7W96ZsG/K8j
         3U6mujtQ+f60ZAGF2o6I24/Nm5gXbOYy8ReTFXVSumNPF0Odx2fthy8Ks5Ykg4GKvog8
         rqMQ==
X-Gm-Message-State: AOAM53162nK7OdNnmdDwVm+Yte5yk1MKHrBq1lgC+ZGdsWnk4FsLT52Y
        ELCGLFbThcK+LBiJ3EI5haujXDldwPl5Awj5znd8uKH5
X-Google-Smtp-Source: ABdhPJwGTc8qZf6Z5/dgjTRxbVseJYdIR7/EJz5U0WdodBdeIYfyFOGmESzGumEhmuAzFm+pvypxgldcvMmwK/3VNEg=
X-Received: by 2002:a05:6830:1552:b0:5cd:bc6e:62b1 with SMTP id
 l18-20020a056830155200b005cdbc6e62b1mr7404046otp.357.1649444924800; Fri, 08
 Apr 2022 12:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220408190502.4103670-1-richard.gong@amd.com>
In-Reply-To: <20220408190502.4103670-1-richard.gong@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Apr 2022 15:08:33 -0400
Message-ID: <CADnq5_NY-2sX+5Q7LZWpRqPz0dQg4-xgqSx2_-qzvZ8Ar=J_YA@mail.gmail.com>
Subject: Re: [PATCHv2] drm/amdgpu: disable ASPM on Intel AlderLake based systems
To:     Richard Gong <richard.gong@amd.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <xinhui.pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 3:05 PM Richard Gong <richard.gong@amd.com> wrote:
>
> Active State Power Management (ASPM) feature is enabled since kernel 5.14.
> There are some AMD GFX cards (such as WX3200 and RX640) that cannot be
> used with Intel AlderLake based systems to enable ASPM. Using these GFX
> cards as video/display output, Intel Alder Lake based systems will hang
> during suspend/resume.
>
> Add extra check to disable ASPM on Intel AlderLake based systems.
>
> Fixes: 0064b0ce85bb ("drm/amd/pm: enable ASPM by default")
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1885
> Signed-off-by: Richard Gong <richard.gong@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v2: correct commit description
>     move the check from chip family to problematic platform
> ---
>  drivers/gpu/drm/amd/amdgpu/vi.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
> index 039b90cdc3bc..8b4eaf54b23e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -81,6 +81,10 @@
>  #include "mxgpu_vi.h"
>  #include "amdgpu_dm.h"
>
> +#if IS_ENABLED(CONFIG_X86_64)
> +#include <asm/intel-family.h>
> +#endif
> +
>  #define ixPCIE_LC_L1_PM_SUBSTATE       0x100100C6
>  #define PCIE_LC_L1_PM_SUBSTATE__LC_L1_SUBSTATES_OVERRIDE_EN_MASK       0x00000001L
>  #define PCIE_LC_L1_PM_SUBSTATE__LC_PCI_PM_L1_2_OVERRIDE_MASK   0x00000002L
> @@ -1134,13 +1138,24 @@ static void vi_enable_aspm(struct amdgpu_device *adev)
>                 WREG32_PCIE(ixPCIE_LC_CNTL, data);
>  }
>
> +static bool intel_core_apsm_chk(void)
> +{
> +#if IS_ENABLED(CONFIG_X86_64)
> +       struct cpuinfo_x86 *c = &cpu_data(0);
> +
> +       return (c->x86 == 6 && c->x86_model == INTEL_FAM6_ALDERLAKE);
> +#else
> +       return false;
> +#endif
> +}
> +
>  static void vi_program_aspm(struct amdgpu_device *adev)
>  {
>         u32 data, data1, orig;
>         bool bL1SS = false;
>         bool bClkReqSupport = true;
>
> -       if (!amdgpu_device_should_use_aspm(adev))
> +       if (!amdgpu_device_should_use_aspm(adev) || intel_core_apsm_chk())
>                 return;
>
>         if (adev->flags & AMD_IS_APU ||
> --
> 2.25.1
>
