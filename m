Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620DC49DF40
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbiA0KXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239489AbiA0KW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:22:28 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FC2C061769
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 02:22:15 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 901F51EC053C;
        Thu, 27 Jan 2022 11:22:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643278929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oX1Ujj3Hq6Ixhsq/96M+Xpp/rbNY1TXsGRzT8a9NeUY=;
        b=JdpXMGqVtmel7Gn7TfU9zyN0KQuq2M3e3EBUcJnG9tPoxmA8HTzKgG8Fd9HpRfNmcGNary
        TcsoPTg1n/I7+D3OOODyw+44oYG3M7YJRsOSrjD4GyID/g2tK6acT81yxyRWNpj3fVSm//
        GTApE7Cq5qDq+HHPHB9xPY8KcjY9+lI=
Date:   Thu, 27 Jan 2022 11:22:03 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Smita Koralahalli Channabasappa 
        <smita.koralahallichannabasappa@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, patches@lists.linux.dev
Subject: Re: [PATCH v2 2/6] x86/cpu: Merge Intel and AMD ppin_init() functions
Message-ID: <YfJyS6/zXGIoasGO@zn.tnic>
References: <20220107225442.1690165-1-tony.luck@intel.com>
 <20220121174743.1875294-1-tony.luck@intel.com>
 <20220121174743.1875294-3-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220121174743.1875294-3-tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 09:47:39AM -0800, Tony Luck wrote:
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 7b8382c11788..b7700a47eadd 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -88,6 +88,80 @@ EXPORT_SYMBOL_GPL(get_llc_id);
>  /* L2 cache ID of each logical CPU */
>  DEFINE_PER_CPU_READ_MOSTLY(u16, cpu_l2c_id) = BAD_APICID;
>  
> +static struct ppin_info {
> +	int	feature;
> +	int	msr_ppin_ctl;
> +} ppin_info[] = {
> +	[X86_VENDOR_INTEL] = {
> +		.feature = X86_FEATURE_INTEL_PPIN,
> +		.msr_ppin_ctl = MSR_PPIN_CTL,
> +		.msr_ppin = MSR_PPIN
> +	},
> +	[X86_VENDOR_AMD] = {
> +		.feature = X86_FEATURE_AMD_PPIN,
> +		.msr_ppin_ctl = MSR_AMD_PPIN_CTL,
> +		.msr_ppin = MSR_AMD_PPIN
		^^^^^^^^^

You forgot to rebuild after removing that guy here in the struct
definition. I'll fix it up now so that I can continue going through them
but pls fix in the next submission so that all patches build separately.

Thx.

arch/x86/kernel/cpu/common.c:98:4: error: ‘struct ppin_info’ has no member named ‘msr_ppin’; did you mean ‘msr_ppin_ctl’?
   98 |   .msr_ppin = MSR_PPIN
      |    ^~~~~~~~
      |    msr_ppin_ctl
In file included from ./arch/x86/include/asm/msr.h:5,
                 from ./arch/x86/include/asm/processor.h:22,
                 from ./arch/x86/include/asm/cpufeature.h:5,
                 from ./arch/x86/include/asm/thread_info.h:53,
                 from ./include/linux/thread_info.h:60,
                 from ./arch/x86/include/asm/preempt.h:7,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/spinlock.h:55,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:6,
                 from ./include/linux/mm.h:10,
                 from ./include/linux/memblock.h:12,
                 from arch/x86/kernel/cpu/common.c:5:
./arch/x86/include/asm/msr-index.h:59:20: warning: excess elements in struct initializer
   59 | #define MSR_PPIN   0x0000004f
      |                    ^~~~~~~~~~
arch/x86/kernel/cpu/common.c:98:15: note: in expansion of macro ‘MSR_PPIN’
   98 |   .msr_ppin = MSR_PPIN
      |               ^~~~~~~~
./arch/x86/include/asm/msr-index.h:59:20: note: (near initialization for ‘ppin_info[0]’)
   59 | #define MSR_PPIN   0x0000004f
      |                    ^~~~~~~~~~
arch/x86/kernel/cpu/common.c:98:15: note: in expansion of macro ‘MSR_PPIN’
   98 |   .msr_ppin = MSR_PPIN
      |               ^~~~~~~~
arch/x86/kernel/cpu/common.c:103:4: error: ‘struct ppin_info’ has no member named ‘msr_ppin’; did you mean ‘msr_ppin_ctl’?
  103 |   .msr_ppin = MSR_AMD_PPIN
      |    ^~~~~~~~
      |    msr_ppin_ctl
In file included from ./arch/x86/include/asm/msr.h:5,
                 from ./arch/x86/include/asm/processor.h:22,
                 from ./arch/x86/include/asm/cpufeature.h:5,
                 from ./arch/x86/include/asm/thread_info.h:53,
                 from ./include/linux/thread_info.h:60,
                 from ./arch/x86/include/asm/preempt.h:7,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/spinlock.h:55,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:6,
                 from ./include/linux/mm.h:10,
                 from ./include/linux/memblock.h:12,
                 from arch/x86/kernel/cpu/common.c:5:
./arch/x86/include/asm/msr-index.h:455:24: warning: excess elements in struct initializer
  455 | #define MSR_AMD_PPIN   0xc00102f1
      |                        ^~~~~~~~~~
arch/x86/kernel/cpu/common.c:103:15: note: in expansion of macro ‘MSR_AMD_PPIN’
  103 |   .msr_ppin = MSR_AMD_PPIN
      |               ^~~~~~~~~~~~
./arch/x86/include/asm/msr-index.h:455:24: note: (near initialization for ‘ppin_info[2]’)
  455 | #define MSR_AMD_PPIN   0xc00102f1
      |                        ^~~~~~~~~~
arch/x86/kernel/cpu/common.c:103:15: note: in expansion of macro ‘MSR_AMD_PPIN’
  103 |   .msr_ppin = MSR_AMD_PPIN
      |               ^~~~~~~~~~~~
make[3]: *** [scripts/Makefile.build:288: arch/x86/kernel/cpu/common.o] Error 1
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.build:550: arch/x86/kernel/cpu] Error 2
make[1]: *** [scripts/Makefile.build:550: arch/x86/kernel] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1831: arch/x86] Error 2
make: *** Waiting for unfinished jobs....

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
