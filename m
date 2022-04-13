Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EF74FF0C2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 09:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbiDMHqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 03:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiDMHqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:46:10 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6932E63E7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:43:49 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5ae908.dynamic.kabel-deutschland.de [95.90.233.8])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9BE2661EA192C;
        Wed, 13 Apr 2022 09:43:46 +0200 (CEST)
Message-ID: <d4ba3998-34aa-86d2-bde9-bc6ae9d8d08d@molgen.mpg.de>
Date:   Wed, 13 Apr 2022 09:43:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCHv4] drm/amdgpu: disable ASPM on Intel Alder Lake based
 systems
Content-Language: en-US
To:     Richard Gong <richard.gong@amd.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        xinhui.pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        mario.limonciello@amd.com
References: <20220412215000.897344-1-richard.gong@amd.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220412215000.897344-1-richard.gong@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Richard,


Thank you for sending out v4.

Am 12.04.22 um 23:50 schrieb Richard Gong:
> Active State Power Management (ASPM) feature is enabled since kernel 5.14.
> There are some AMD GFX cards (such as WX3200 and RX640) that won't work
> with ASPM-enabled Intel Alder Lake based systems. Using these GFX cards as
> video/display output, Intel Alder Lake based systems will hang during
> suspend/resume.

I am still not clear, what “hang during suspend/resume” means. I guess 
suspending works fine? During resume (S3 or S0ix?), where does it hang? 
The system is functional, but there are only display problems?

> The issue was initially reported on one system (Dell Precision 3660 with
> BIOS version 0.14.81), but was later confirmed to affect at least 4 Alder
> Lake based systems.
> 
> Add extra check to disable ASPM on Intel Alder Lake based systems.
> 
> Fixes: 0064b0ce85bb ("drm/amd/pm: enable ASPM by default")
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1885
> Reported-by: kernel test robot <lkp@intel.com>

This tag is a little confusing. Maybe clarify that it was for an issue 
in a previous patch iteration?

> Signed-off-by: Richard Gong <richard.gong@amd.com>
> ---
> v4: s/CONFIG_X86_64/CONFIG_X86
>      enhanced check logic
> v3: s/intel_core_asom_chk/aspm_support_quirk_check
>      correct build error with W=1 option
> v2: correct commit description
>      move the check from chip family to problematic platform
> ---
>   drivers/gpu/drm/amd/amdgpu/vi.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
> index 039b90cdc3bc..b33e0a9bee65 100644
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
> +	if (IS_ENABLED(CONFIG_X86)) {
> +		struct cpuinfo_x86 *c = &cpu_data(0);
> +
> +		return !(c->x86 == 6 && c->x86_model == INTEL_FAM6_ALDERLAKE);
> +	}
> +
> +	return true;
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

Can users still forcefully enable ASPM with the parameter `amdgpu.aspm`?

>   
>   	if (adev->flags & AMD_IS_APU ||

If I remember correctly, there were also newer cards, where ASPM worked 
with Intel Alder Lake, right? Can only the problematic generations for 
WX3200 and RX640 be excluded from ASPM?


Kind regards,

Paul
