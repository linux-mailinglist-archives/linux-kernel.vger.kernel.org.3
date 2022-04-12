Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460074FE505
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343685AbiDLPpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiDLPpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:45:20 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84FD5EBC0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:43:02 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id j83so19425420oih.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZGZNu9iiX3iSvmXUM8rzXVowDpysbTVW80h1NVMIpd0=;
        b=cnUXGmM7zHLLJgvWl00m+xYFp1+371WRKCG4/3WQi09uZVR0nnJiO4SCnG8bZjyXa3
         ur4i8kaIHHT4fvx/ZfYUpEweUQiDT9CDKTLmzERuNi8t9OL+kKqtRHBMMdtaEJr0ag8z
         wK0LR/X5rmuzQZB4EtuO+eHu7jji5tfqSRrI7zVxKpNZB5S17nrluTOxQPknb2HOC9t1
         89vC0oZvlU70HG0jub9xt56KRz9Vg4G1pgb90mH5ISd6r02jDWIZf5KtrowO0Sni9jye
         fZKuVvIA+K88P7mfCMAzjAvLgTzGzsaMxMXxF6YLHaDvlVrQUynNwSCX95BX1bfRlR0q
         aimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZGZNu9iiX3iSvmXUM8rzXVowDpysbTVW80h1NVMIpd0=;
        b=a18phHQ/UFtXqGm42lJqc1UEQbk60BQvZmiJSfBEa2CpQjk14OJlUL4r5EaDF3ay68
         1wKNHPLmk6JoWddzKQ658jUpJh5iSrLlSyZoKROrIGrcBrwr/+soq8pyvH6RajXn4Uex
         ef9YE9vDkN2aWQCW6gH/SeT0tvu7FfDzXcbLZ4DmZanGqeV8ApajH99LNJHBWZR1iW/n
         evtlFd567hZgoWrdeypQIBedLr8oGkmPpyPhzVYX1eicI/OuMpNXbqY5rL3wyohuVQYf
         09J3E/IaZBVm7WT96o7pRbDsZ501ep8ZcuBuunIss0pWbWycGPtNJMzSYrtM5tmCCuH9
         ywKQ==
X-Gm-Message-State: AOAM5318ApytaEiVY+MUGrfvaESLno6EyVk+PYhxBvJoFS9b3JEMCUmT
        LVxIFliD2sRz6MLmPvzynAYVZQKenHoELlyB+Q8=
X-Google-Smtp-Source: ABdhPJxFB+Il2thTK2QAOb85QGOKwlW91TXm8qlLr1lQzB40w266iztnDdN5QvsGS+1bOw+dYPtWSm/w/73OAm4rWZg=
X-Received: by 2002:a05:6808:1486:b0:2f9:e821:51d9 with SMTP id
 e6-20020a056808148600b002f9e82151d9mr2140098oiw.253.1649778182265; Tue, 12
 Apr 2022 08:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220412145350.2843514-1-richard.gong@amd.com>
In-Reply-To: <20220412145350.2843514-1-richard.gong@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Apr 2022 11:42:51 -0400
Message-ID: <CADnq5_P5dO9eBR1c1bN+S73ABUBuUtZPkOtW0TCeLuBVD+PQwA@mail.gmail.com>
Subject: Re: [PATCHv3] drm/amdgpu: disable ASPM on Intel Alder Lake based systems
To:     Richard Gong <richard.gong@amd.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <xinhui.pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        kernel test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Limonciello, Mario" <mario.limonciello@amd.com>
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

On Tue, Apr 12, 2022 at 10:59 AM Richard Gong <richard.gong@amd.com> wrote:
>
> Active State Power Management (ASPM) feature is enabled since kernel 5.14.
> There are some AMD GFX cards (such as WX3200 and RX640) that won't work
> with ASPM-enabled Intel Alder Lake based systems. Using these GFX cards as
> video/display output, Intel Alder Lake based systems will hang during
> suspend/resume.
>
> The issue was initially reported on one system (Dell Precision 3660 with
> BIOS version 0.14.81), but was later confirmed to affect at least 4 Alder
> Lake based systems.
>
> Add extra check to disable ASPM on Intel Alder Lake based systems.
>
> Fixes: 0064b0ce85bb ("drm/amd/pm: enable ASPM by default")
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1885
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Richard Gong <richard.gong@amd.com>
> ---
> v3: s/intel_core_asom_chk/aspm_support_quirk_check
>     correct build error with W=1 option
> v2: correct commit description
>     move the check from chip family to problematic platform
> ---
>  drivers/gpu/drm/amd/amdgpu/vi.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
> index 039b90cdc3bc..b0b6353b48b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -81,6 +81,10 @@
>  #include "mxgpu_vi.h"
>  #include "amdgpu_dm.h"
>
> +#if IS_ENABLED(CONFIG_X86_64)

Shouldn't this be X86?  You could theoretically run this on 32 bit.

Alex

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
> +static bool aspm_support_quirk_check(void)
> +{
> +       if (IS_ENABLED(CONFIG_X86_64)) {
> +               struct cpuinfo_x86 *c = &cpu_data(0);
> +
> +               return (c->x86 == 6 && c->x86_model != INTEL_FAM6_ALDERLAKE);
> +       }
> +
> +       return true;
> +}
> +
>  static void vi_program_aspm(struct amdgpu_device *adev)
>  {
>         u32 data, data1, orig;
>         bool bL1SS = false;
>         bool bClkReqSupport = true;
>
> -       if (!amdgpu_device_should_use_aspm(adev))
> +       if (!amdgpu_device_should_use_aspm(adev) || !aspm_support_quirk_check())
>                 return;
>
>         if (adev->flags & AMD_IS_APU ||
> --
> 2.25.1
>
