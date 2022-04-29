Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780E6515083
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378922AbiD2QRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240669AbiD2QRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:17:08 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6149CD662
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:13:49 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-e93ff05b23so8585373fac.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Un+8uBdSonMBArNllHw60eJ9+stkGa05/rjOsT5H7mQ=;
        b=CcsvnPcyaByh/nvf5QgMaDK4KDq+1ywC2wyRQgS4Z5PIcHl5NrA1xwhpD70O4uFRMj
         tR9E0NJzMirunOscfIp2SGOnQC9aQf02NR7/CYUFnAs0ToijQawWAhKZRTqfUyRcyyMT
         ZMMZvCLOqxPLWM+uRhg201zcAlgjQPdiXnmYx3MX7/S2+D4Wd+ci2wMTk/kZ9TI8hyxZ
         I/jagVFQQb2Rg3XnXZS2BANG+rqq0zT9YRRfiqeNEu1niItjVsmAIFGia9DoklrES8mU
         Psvu0isGTybgzYHeh/pslkmrhbzskYlNW47ViTWVY9Wx3JNxGP05H39qOCX0Bf5TutYa
         j4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Un+8uBdSonMBArNllHw60eJ9+stkGa05/rjOsT5H7mQ=;
        b=2rDKEjbDY1o1XW4VAupkkUWu7+iA9QUKLDv1ru3smOKe6+Wpsg/41/8sLECt7DUhP0
         Dbvxt7kev7x4jY00mckQlD7QNzt5/aEKZXWUiYcf6HxVzb66JQYXiCXQpPdjZp5Pl+85
         ZQFYNJxANJWeAvEsu5UF8UqCrENxC+C5b8uNOk8pDpHovnP+OSepYoGX4HpiushzD+DB
         9plgCtUQTZrE+xmP00T3iVir9fyr0PXT4ULV192NfQyk01DYme01YNpW5hB/zzFh2+4X
         1xPoQnumEjsQn/AoX3lCFd63GeuQ++CmSwbhDRwvsm77ovKnlV0H47AhFqMlvpUVLu+A
         b4Zw==
X-Gm-Message-State: AOAM532Z4ZlBW6WsbWcYoiiWctGkBYXzIB5Q1T2rqF7uTMMIVAWn05k5
        e2w1DJbc2D/g1RlalMOseweycwITrJdjDMVdZ5Y=
X-Google-Smtp-Source: ABdhPJxOiBo4M/pvZvo6hhugzdJ2Op2OmRYRd++GDtCarikTTq3eyAiFl/sdq1eGPRIPu01vIKYQK69XBKFGhqKtPjc=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr24878oap.253.1651248829146; Fri, 29 Apr
 2022 09:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220429160604.2608782-1-richard.gong@amd.com>
In-Reply-To: <20220429160604.2608782-1-richard.gong@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 29 Apr 2022 12:13:38 -0400
Message-ID: <CADnq5_OoyRmM+tWZ_nipfnNyxFVnyUH+R8Pc4-u2akeffXgssg@mail.gmail.com>
Subject: Re: [PATCHv5] drm/amdgpu: vi: disable ASPM on Intel Alder Lake based systems
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Apr 29, 2022 at 12:08 PM Richard Gong <richard.gong@amd.com> wrote:
>
> Active State Power Management (ASPM) feature is enabled since kernel 5.14.
> There are some AMD Volcanic Islands (VI) GFX cards, such as the WX3200 and
> RX640, that do not work with ASPM-enabled Intel Alder Lake based systems.
> Using these GFX cards as video/display output, Intel Alder Lake based
> systems will freeze after suspend/resume.
>
> The issue was originally reported on one system (Dell Precision 3660 with
> BIOS version 0.14.81), but was later confirmed to affect at least 4
> pre-production Alder Lake based systems.
>
> Add an extra check to disable ASPM on Intel Alder Lake based systems with
> the problematic AMD Volcanic Islands GFX cards.
>
> Fixes: 0064b0ce85bb ("drm/amd/pm: enable ASPM by default")
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1885
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Richard Gong <richard.gong@amd.com>
> ---
> v5: added vi to commit header and updated commit message
>     rolled back guard with the preprocessor as did in v2 to correct build
>     error on non-x86 systems
> v4: s/CONFIG_X86_64/CONFIG_X86
>     enhanced check logic
> v3: s/intel_core_aspm_chk/aspm_support_quirk_check
>     correct build error with W=1 option
> v2: correct commit description
>     move the check from chip family to problematic platform
> ---
>  drivers/gpu/drm/amd/amdgpu/vi.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
> index 039b90cdc3bc..45f0188c4273 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -81,6 +81,10 @@
>  #include "mxgpu_vi.h"
>  #include "amdgpu_dm.h"
>
> +#if IS_ENABLED(CONFIG_X86)
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
> +#if IS_ENABLED(CONFIG_X86)
> +       struct cpuinfo_x86 *c = &cpu_data(0);
> +
> +       return !(c->x86 == 6 && c->x86_model == INTEL_FAM6_ALDERLAKE);
> +#else
> +       return true;
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
> +       if (!amdgpu_device_should_use_aspm(adev) || !aspm_support_quirk_check())
>                 return;
>
>         if (adev->flags & AMD_IS_APU ||
> --
> 2.25.1
>
