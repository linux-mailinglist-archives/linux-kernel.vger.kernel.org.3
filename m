Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02860599A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 13:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348764AbiHSLLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 07:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348758AbiHSLLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:11:41 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1BEFEEBB
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 04:11:25 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9849329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9849:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5A83D1EC064F;
        Fri, 19 Aug 2022 13:11:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660907471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Bm39S14WA191KzPCf0Yr9KuPhFTIj82RCcIsltkgZfc=;
        b=nuRL7ectlfB38NiCQJQ4m/S72SAEpqBri3Pr6Gj2ReecvDfsPW/LuJluPNrhWsDSsLtnIK
        ieewcYiOFFGci93yW1KuYOf4oavUDZA1DXkFkALdmLlsMpRbZAqGiiaHqJJWrzRpwrpU1o
        w5zpIVe1ZUBju7J8B6ISupBe3cfQCXA=
Date:   Fri, 19 Aug 2022 13:11:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>
Subject: Re: [PATCH v3 2/5] x86/microcode/intel: Allow a late-load only if a
 min rev is specified
Message-ID: <Yv9vy/GTh/QInBPM@zn.tnic>
References: <20220817051127.3323755-1-ashok.raj@intel.com>
 <20220817051127.3323755-3-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220817051127.3323755-3-ashok.raj@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 05:11:24AM +0000, Ashok Raj wrote:
> In general users don't have the necessary information to determine
> whether a late-load of a new microcode version has removed any feature
> (MSR, CPUID etc) between what is currently loaded and this new microcode.
> To address this issue, Intel has added a "minimum required version" field to
> a previously reserved field in the file header. Microcode updates
> should only be applied if the current microcode version is equal
> to, or greater than this minimum required version.
> 
> https://lore.kernel.org/linux-kernel/alpine.DEB.2.21.1909062237580.1902@nanos.tec.linutronix.de/

That goes into a Link: tag.

> Thomas made some suggestions on how meta-data in the microcode file could
> provide Linux with information to decide if the new microcode is suitable
> candidate for late-load. But even the "simpler" option#1 requires a lot of

In all your text:

s/late-load/late loading/g

It is called CONFIG_MICROCODE_LATE_LOADING - not CONFIG_MICROCODE_LATE_LOAD.

People are confused enough already - no need for more.

> metadata and corresponding kernel code to parse it.
> 
> The proposal here is an even simpler option. The criteria for a microcode to
> be a viable late-load candidate is that no CPUID or OS visible MSR features

Simply "OS visible features" - CPUID and MSRs are only two examples. The
microcode cannot change how the OS is supposed to interact with visible
features because that causes problems.

> are removed with respect to an earlier version of the microcode.
> 
> Pseudocode for late-load is as follows:

Unknown word [Pseudocode] in commit message.
Suggestions: ['Pseudo code',

> if header.min_required_id == 0
> 	This is old format microcode, block late-load
> else if current_ucode_version < header.min_required_id
> 	Current version is too old, block late-load of this microcode.
> else
> 	OK to proceed with late-load.
> 
> Any microcode that removes a feature will set the min_version to itself.

"... that modifies the interface to a OS-visible feature..."

> This will enforce this microcode is not suitable for late-loading.
> 
> The enforcement is not in hardware and limited to kernel loader enforcing
> the requirement. It is not required for early loading of microcode to
> enforce this requirement, since the new features are only
> evaluated after early loading in the boot process.
> 
> 
> Test cases covered:
> 
> 1. With new kernel, attempting to load an older format microcode with the
>    min_rev=0 should be blocked by kernel.
> 
>    [  210.541802] microcode: Header MUST specify min version for late-load

Make that more user-friendly:

"microcode: Late loading denied: microcode header does not specify a required min version."

> 2. New microcode with a non-zero min_rev in the header, but the specified
>    min_rev is greater than what is currently loaded in the CPU should be
>    blocked by kernel.
> 
>    245.139828] microcode: Current revision 0x8f685300 is too old to update,
> must be at 0xaa000050 version or higher

"microcode: Late loading denied: Current version ... or higher. Use early loading instead."

> 3. New microcode with a min_rev < currently loaded should allow loading the
>    microcode
> 
> 4. Build initrd with microcode that has min_rev=0, or min_rev > currently
>    loaded should permit early loading microcode from initrd.
> 
> 
> Tested-by: William Xie <william.xie@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> ---
>  arch/x86/include/asm/microcode_intel.h |  4 +++-
>  arch/x86/kernel/cpu/microcode/intel.c  | 20 ++++++++++++++++++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/microcode_intel.h b/arch/x86/include/asm/microcode_intel.h
> index 4c92cea7e4b5..16b8715e0984 100644
> --- a/arch/x86/include/asm/microcode_intel.h
> +++ b/arch/x86/include/asm/microcode_intel.h
> @@ -14,7 +14,9 @@ struct microcode_header_intel {
>  	unsigned int            pf;
>  	unsigned int            datasize;
>  	unsigned int            totalsize;
> -	unsigned int            reserved[3];
> +	unsigned int            reserved1;
> +	unsigned int		min_req_id;
> +	unsigned int            reserved3;
>  };
>  
>  struct microcode_intel {
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index c4b11e2fbe33..1eb202ec2302 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -178,6 +178,7 @@ static int microcode_sanity_check(void *mc, int print_err)

You can't do this in this function:

load_ucode_intel_bsp -> __load_ucode_intel -> scan_microcode -> microcode_sanity_check

which is the early path.

So you'd have to pass down the fact that you're doing late loading from
request_microcode_fw().

Now, I'm staring at that ugly refresh_fw bool arg in that function and
I *think* I did it 10 years ago because it shouldn't try to load from
the fs when it is resuming because there might not be a fs yet... or
something to that effect.

tglx might have a better idea how to check we're in the ->starting notifier...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
