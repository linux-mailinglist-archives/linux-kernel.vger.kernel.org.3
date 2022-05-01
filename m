Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C70516272
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 09:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243884AbiEAHSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 03:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbiEAHR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 03:17:58 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DF840902
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 00:14:34 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aed6d.dynamic.kabel-deutschland.de [95.90.237.109])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9AF5F61EA1923;
        Sun,  1 May 2022 09:14:32 +0200 (CEST)
Message-ID: <232384f1-c888-33f7-07dd-b99545f1b115@molgen.mpg.de>
Date:   Sun, 1 May 2022 09:14:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHv5] drm/amdgpu: vi: disable ASPM on Intel Alder Lake based
 systems
Content-Language: en-US
To:     Richard Gong <richard.gong@amd.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        xinhui.pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        mario.limonciello@amd.com
References: <20220429160604.2608782-1-richard.gong@amd.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220429160604.2608782-1-richard.gong@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Richard,


Am 29.04.22 um 18:06 schrieb Richard Gong:
> Active State Power Management (ASPM) feature is enabled since kernel 5.14.
> There are some AMD Volcanic Islands (VI) GFX cards, such as the WX3200 and
> RX640, that do not work with ASPM-enabled Intel Alder Lake based systems.
> Using these GFX cards as video/display output, Intel Alder Lake based
> systems will freeze after suspend/resume.

As replied in v4 just now, “freeze” is misleading if you can still run 
`dmesg` after resume.


Kind regards,

Paul


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
>      rolled back guard with the preprocessor as did in v2 to correct build
>      error on non-x86 systems
> v4: s/CONFIG_X86_64/CONFIG_X86
>      enhanced check logic
> v3: s/intel_core_aspm_chk/aspm_support_quirk_check
>      correct build error with W=1 option
> v2: correct commit description
>      move the check from chip family to problematic platform
> ---
>   drivers/gpu/drm/amd/amdgpu/vi.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
> index 039b90cdc3bc..45f0188c4273 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -81,6 +81,10 @@
>   #include "mxgpu_vi.h"
>   #include "amdgpu_dm.h"
>   
> +#if IS_ENABLED(CONFIG_X86)
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
> +static bool aspm_support_quirk_check(void)
> +{
> +#if IS_ENABLED(CONFIG_X86)
> +	struct cpuinfo_x86 *c = &cpu_data(0);
> +
> +	return !(c->x86 == 6 && c->x86_model == INTEL_FAM6_ALDERLAKE);
> +#else
> +	return true;
> +#endif
> +}
> +
>   static void vi_program_aspm(struct amdgpu_device *adev)
>   {
>   	u32 data, data1, orig;
>   	bool bL1SS = false;
>   	bool bClkReqSupport = true;
>   
> -	if (!amdgpu_device_should_use_aspm(adev))
> +	if (!amdgpu_device_should_use_aspm(adev) || !aspm_support_quirk_check())
>   		return;
>   
>   	if (adev->flags & AMD_IS_APU ||
