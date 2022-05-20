Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC98052EF54
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350903AbiETPia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344615AbiETPi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:38:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E729D05C
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653061107; x=1684597107;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FTcYXObNA72+JfxB9UBcj9N5vY/n/OK6No5jETfhSeQ=;
  b=XigNgZyMyKxRuG0zyupy9og5KeSHEmflANghRU84Hm8GpNC8w6CIhdWc
   COSCFwaSaKarnUEIu10wcGgsEuiPAj9flf8WB+y4GwuIxyZq7fyT8AB5p
   ipz/u2CAxhhM+UXUiH0QFcYKI/AsM8llWCaNWLn79mwHZOXClj5zDL4qR
   wEwCdaO2vS9mLu+ECNLnUDPvfLJ3kFco3OP/j3cCFZIjNv/Ok6705yws9
   2pCW2yLRYvWPYh0xt1PB9hnhGuqrd/JZshd3k0S/AoS0g7p7vd0L/2ihV
   TevAy+LzSYYPhk8b18W9drGDXspPS9tjqmQGvQVRnboI32nWfyPCdryjf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="359042209"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="359042209"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 08:38:26 -0700
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="599278128"
Received: from yyan7-mobl1.ccr.corp.intel.com ([10.255.31.53])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 08:38:19 -0700
Message-ID: <a2fba1bf7cf0833372a825f626c12502a44a660e.camel@intel.com>
Subject: Re: [PATCH v3 1/3] x86: Use HLT in default_idle when idle=nomwait
 cmdline arg is passed
From:   Zhang Rui <rui.zhang@intel.com>
To:     Wyes Karny <wyes.karny@amd.com>, linux-kernel@vger.kernel.org
Cc:     Lewis.Carroll@amd.com, Mario.Limonciello@amd.com,
        gautham.shenoy@amd.com, Ananth.Narayan@amd.com, bharata@amd.com,
        len.brown@intel.com, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org, chang.seok.bae@intel.com,
        keescook@chromium.org, metze@samba.org, zhengqi.arch@bytedance.com,
        mark.rutland@arm.com, puwen@hygon.cn, rafael.j.wysocki@intel.com,
        andrew.cooper3@citrix.com, jing2.liu@intel.com,
        jmattson@google.com, pawan.kumar.gupta@linux.intel.com
Date:   Fri, 20 May 2022 23:38:17 +0800
In-Reply-To: <1b24cadcf1d86a91352baa13905218015b9d4fed.1652176835.git-series.wyes.karny@amd.com>
References: <cover.fba143c82098dffab6bbf0a2f3c4be8bae07ccf1.1652176835.git-series.wyes.karny@amd.com>
         <1b24cadcf1d86a91352baa13905218015b9d4fed.1652176835.git-series.wyes.karny@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Wyes,

On Tue, 2022-05-10 at 15:48 +0530, Wyes Karny wrote:
> When kernel is booted with idle=nomwait do not use MWAIT as the
> default idle state.
> 
> If the user boots the kernel with idle=nomwait, it is a clear
> direction to not use mwait as the default idle state.
> However, the current code does not take this into consideration
> while selecting the default idle state on x86.
> 
> This patch fixes it by checking for the idle=nomwait boot option in
> prefer_mwait_c1_over_halt().
> 
> Also update the documentation around idle=nomwait appropriately.

I think we also need to update the comment in idle_setup() as well. 

        } else if (!strcmp(str, "nomwait")) {
                /*
        
         * If the boot option of "idle=nomwait" is added,
              
   * it means that mwait will be disabled for CPU C2/C3
                
 * states. In such case it won't touch the variable
                 *
of boot_option_idle_override.
                 */
                boot_op
tion_idle_override = IDLE_NOMWAIT;
        } else

thanks,
rui
> 
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> ---
> Changes in v3:
> - Update documentation around idle=mwait
> 
>  Documentation/admin-guide/pm/cpuidle.rst | 15 +++++++++------
>  arch/x86/kernel/process.c                |  4 ++++
>  2 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/cpuidle.rst
> b/Documentation/admin-guide/pm/cpuidle.rst
> index aec2cd2aaea7..19754beb5a4e 100644
> --- a/Documentation/admin-guide/pm/cpuidle.rst
> +++ b/Documentation/admin-guide/pm/cpuidle.rst
> @@ -612,8 +612,8 @@ the ``menu`` governor to be used on the systems
> that use the ``ladder`` governor
>  by default this way, for example.
>  
>  The other kernel command line parameters controlling CPU idle time
> management
> -described below are only relevant for the *x86* architecture and
> some of
> -them affect Intel processors only.
> +described below are only relevant for the *x86* architecture and
> references
> +to ``intel_idle`` affect Intel processors only.
>  
>  The *x86* architecture support code recognizes three kernel command
> line
>  options related to CPU idle time management: ``idle=poll``,
> ``idle=halt``,
> @@ -635,10 +635,13 @@ idle, so it very well may hurt single-thread
> computations performance as well as
>  energy-efficiency.  Thus using it for performance reasons may not be
> a good idea
>  at all.]
>  
> -The ``idle=nomwait`` option disables the ``intel_idle`` driver and
> causes
> -``acpi_idle`` to be used (as long as all of the information needed
> by it is
> -there in the system's ACPI tables), but it is not allowed to use the
> -``MWAIT`` instruction of the CPUs to ask the hardware to enter idle
> states.
> +The ``idle=nomwait`` option prevents the use of ``MWAIT``
> instruction of
> +the CPU to enter idle states. When this option is used, the
> ``acpi_idle``
> +driver will use the ``HLT`` instruction instead of ``MWAIT``. On
> systems
> +running Intel processors, this option disables the ``intel_idle``
> driver
> +and forces the use of the ``acpi_idle`` driver instead. Note that in
> either
> +case, ``acpi_idle`` driver will function only if all the information
> needed
> +by it is in the system's ACPI tables.
>  
>  In addition to the architecture-level kernel command line options
> affecting CPU
>  idle time management, there are parameters affecting individual
> ``CPUIdle``
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index b370767f5b19..49b915d1b7b4 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -824,6 +824,10 @@ static void amd_e400_idle(void)
>   */
>  static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
>  {
> +	/* User has disallowed the use of MWAIT. Fallback to HALT */
> +	if (boot_option_idle_override == IDLE_NOMWAIT)
> +		return 0;
> +
>  	if (c->x86_vendor != X86_VENDOR_INTEL)
>  		return 0;
>  

