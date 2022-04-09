Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1334FA09A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 02:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiDIAVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 20:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiDIAVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 20:21:52 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A064DE911
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 17:19:46 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5ae917.dynamic.kabel-deutschland.de [95.90.233.23])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5F95861E6478B;
        Sat,  9 Apr 2022 02:19:43 +0200 (CEST)
Message-ID: <44354d78-b340-fbc4-fd6c-060d7ad3404e@molgen.mpg.de>
Date:   Sat, 9 Apr 2022 02:19:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCHv2] drm/amdgpu: disable ASPM on Intel AlderLake based
 systems
Content-Language: en-US
To:     Richard Gong <richard.gong@amd.com>
Cc:     mario.limonciello@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        xinhui.pan@amd.com, airlied@linux.ie, daniel@ffwll.ch
References: <20220408190502.4103670-1-richard.gong@amd.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220408190502.4103670-1-richard.gong@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Richard,


Thank you for your patch.

Am 08.04.22 um 21:05 schrieb Richard Gong:
> Active State Power Management (ASPM) feature is enabled since kernel 5.14.
> There are some AMD GFX cards (such as WX3200 and RX640) that cannot be
> used with Intel AlderLake based systems to enable ASPM. Using these GFX

Alder Lake

> cards as video/display output, Intel Alder Lake based systems will hang
> during suspend/resume.

Please reflow for 75 characters per line.

Also please mention the exact system you had problems with (also 
firmware versions).

> 
> Add extra check to disable ASPM on Intel AlderLake based systems.

Is that a problem with Intel Alder Lake or the Dell system? Shouldn’t 
ASPM just be disabled for the problematic cards for the Dell system. You 
write newer cards worked fine.

> Fixes: 0064b0ce85bb ("drm/amd/pm: enable ASPM by default")
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1885
> Signed-off-by: Richard Gong <richard.gong@amd.com>
> ---
> v2: correct commit description
>      move the check from chip family to problematic platform
> ---
>   drivers/gpu/drm/amd/amdgpu/vi.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
> index 039b90cdc3bc..8b4eaf54b23e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -81,6 +81,10 @@
>   #include "mxgpu_vi.h"
>   #include "amdgpu_dm.h"
>   
> +#if IS_ENABLED(CONFIG_X86_64)
> +#include <asm/intel-family.h>
> +#endif
> +
>   #define ixPCIE_LC_L1_PM_SUBSTATE	0x100100C6
>   #define PCIE_LC_L1_PM_SUBSTATE__LC_L1_SUBSTATES_OVERRIDE_EN_MASK	0x00000001L
>   #define PCIE_LC_L1_PM_SUBSTATE__LC_PCI_PM_L1_2_OVERRIDE_MASK	0x00000002L
> @@ -1134,13 +1138,24 @@ static void vi_enable_aspm(struct amdgpu_device *adev)
>   		WREG32_PCIE(ixPCIE_LC_CNTL, data);
>   }
>   
> +static bool intel_core_apsm_chk(void)

aspm

> +{
> +#if IS_ENABLED(CONFIG_X86_64)
> +	struct cpuinfo_x86 *c = &cpu_data(0);
> +
> +	return (c->x86 == 6 && c->x86_model == INTEL_FAM6_ALDERLAKE);
> +#else
> +	return false;
> +#endif

Please do the check in C code and not the preprocessor.

> +}
> +
>   static void vi_program_aspm(struct amdgpu_device *adev)
>   {
>   	u32 data, data1, orig;
>   	bool bL1SS = false;
>   	bool bClkReqSupport = true;
>   
> -	if (!amdgpu_device_should_use_aspm(adev))
> +	if (!amdgpu_device_should_use_aspm(adev) || intel_core_apsm_chk())
>   		return;
>   
>   	if (adev->flags & AMD_IS_APU ||


Kind regards,

Paul
