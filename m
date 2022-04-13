Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44214FFA7F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbiDMPm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 11:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbiDMPmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:42:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A717541F8A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 08:40:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EDCE61DA2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 15:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D28C385A8;
        Wed, 13 Apr 2022 15:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649864430;
        bh=aDZsnIu78Sw4wqXPmCkaYFfJvE/1m8bL+bjVG7Ns0wI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HMfsF5SappHXuWWV+oC6KDzHEsoUjuIe1WEm7lKyDHSbE/gwwYl6YSMf5LGLyz9J4
         sTZuMuRJlmmzxQJU8Sn7/7uXyrnbVQzRkrLRr2pOM0iRN1nJ02sDBW8YJqP/5NZwA6
         jxV+ggAxM9ReRFOEhmB/8m+gGJqCIiID9ySZ23pGb91PVXVyJvcB1CfBjpAOM+A9oF
         4TWDPnUodyZ2+Oz3IhUxR+fWKjYHCLfJ47Hoj12Lws1ZLXdHvelLgVtvfUHmuaKRc8
         FQkH9fCtw8FzrvC0lMj45loG1bAluE/YQIoq0koWg+4Fywp3SUSoGKqcyE71WiweC4
         aB+yn0t2+4Llw==
Date:   Wed, 13 Apr 2022 08:40:28 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Richard Gong <richard.gong@amd.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        xinhui.pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCHv4] drm/amdgpu: disable ASPM on Intel Alder Lake based
 systems
Message-ID: <Ylbu7OGHVaqnznQb@thelio-3990X>
References: <20220412215000.897344-1-richard.gong@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412215000.897344-1-richard.gong@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On Tue, Apr 12, 2022 at 04:50:00PM -0500, Richard Gong wrote:
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
> v4: s/CONFIG_X86_64/CONFIG_X86
>     enhanced check logic
> v3: s/intel_core_asom_chk/aspm_support_quirk_check
>     correct build error with W=1 option
> v2: correct commit description
>     move the check from chip family to problematic platform
> ---
>  drivers/gpu/drm/amd/amdgpu/vi.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
> index 039b90cdc3bc..b33e0a9bee65 100644
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
>  #define ixPCIE_LC_L1_PM_SUBSTATE	0x100100C6
>  #define PCIE_LC_L1_PM_SUBSTATE__LC_L1_SUBSTATES_OVERRIDE_EN_MASK	0x00000001L
>  #define PCIE_LC_L1_PM_SUBSTATE__LC_PCI_PM_L1_2_OVERRIDE_MASK	0x00000002L
> @@ -1134,13 +1138,24 @@ static void vi_enable_aspm(struct amdgpu_device *adev)
>  		WREG32_PCIE(ixPCIE_LC_CNTL, data);
>  }
>  
> +static bool aspm_support_quirk_check(void)
> +{
> +	if (IS_ENABLED(CONFIG_X86)) {
> +		struct cpuinfo_x86 *c = &cpu_data(0);
> +
> +		return !(c->x86 == 6 && c->x86_model == INTEL_FAM6_ALDERLAKE);
> +	}

I have not seen this reported by a bot, sorry if it is a duplicate. This
breaks non-x86 builds (arm64 allmodconfig for example):

drivers/gpu/drm/amd/amdgpu/vi.c:1144:28: error: implicit declaration of function 'cpu_data' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                struct cpuinfo_x86 *c = &cpu_data(0);
                                         ^
drivers/gpu/drm/amd/amdgpu/vi.c:1144:27: error: cannot take the address of an rvalue of type 'int'
                struct cpuinfo_x86 *c = &cpu_data(0);
                                        ^~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/vi.c:1146:13: error: incomplete definition of type 'struct cpuinfo_x86'
                return !(c->x86 == 6 && c->x86_model == INTEL_FAM6_ALDERLAKE);
                         ~^
drivers/gpu/drm/amd/amdgpu/vi.c:1144:10: note: forward declaration of 'struct cpuinfo_x86'
                struct cpuinfo_x86 *c = &cpu_data(0);
                       ^
drivers/gpu/drm/amd/amdgpu/vi.c:1146:28: error: incomplete definition of type 'struct cpuinfo_x86'
                return !(c->x86 == 6 && c->x86_model == INTEL_FAM6_ALDERLAKE);
                                        ~^
drivers/gpu/drm/amd/amdgpu/vi.c:1144:10: note: forward declaration of 'struct cpuinfo_x86'
                struct cpuinfo_x86 *c = &cpu_data(0);
                       ^
drivers/gpu/drm/amd/amdgpu/vi.c:1146:43: error: use of undeclared identifier 'INTEL_FAM6_ALDERLAKE'
                return !(c->x86 == 6 && c->x86_model == INTEL_FAM6_ALDERLAKE);
                                                        ^
5 errors generated.

'struct cpuinfo_x86' is only defined for CONFIG_X86 so this section
needs to guarded with the preprocessor, which is how it was done in v2.
Please go back to that.

Cheers,
Nathan
