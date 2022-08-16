Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B147595722
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbiHPJxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbiHPJwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:52:20 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122F12185
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 02:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660640431; x=1692176431;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=U7gAm6W3zbLKaBfCA6cNycbC3qMCev+ce+q8Hivmfs4=;
  b=BlDfLgJQXvtIYWRd2ij07SPeAUtsVuGQyYWTL+eCNztOryuHwMTkYfLi
   KDCa4CXMn9GKTMtcAMuch+yV5LPIKfURq3xnUo0/mlY5KpPxPTuN0AOgR
   8sqgNbyWJbm/YJ0PaWQYCQQW2ZBtrmBD89PA9rl9vlujP6FUxBTrIJwh2
   Z/1oAITpHRuR3oyUpYKq3eqJZf//cRb8TYJSfuE29AI2qTmUVm7bisqKm
   8+GaWVAn6zwBlrvx/7VIvOnTwS+ykcZJOzTN24Qy+YpXR3rVaRneaGCm/
   RmrEryhtsYFHwmkiVmfpuZ0GccKFpax9fhsZukvPRJrzui44kkK/vG2/+
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="293439460"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="293439460"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 02:00:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="635811415"
Received: from araj-dh-work.jf.intel.com (HELO araj-dh-work) ([10.165.157.158])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 02:00:30 -0700
Date:   Tue, 16 Aug 2022 09:00:14 +0000
From:   Ashok Raj <ashok_raj@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, Andrew Cooper <amc96@srcf.net>,
        LKML <linux-kernel@vger.kernel.org>,
        =?utf-8?Q?=C8=98tefan?= Talpalaru <stefantalpalaru@yahoo.com>,
        Ashok Raj <ashok.raj@intel.com>, ashok_raj@linux.intel.com
Subject: Re: [PATCH] x86/microcode/AMD: Attempt applying on every logical
 thread
Message-ID: <YvtcGEHX8eSFpALX@araj-dh-work>
References: <20220814120026.16118-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220814120026.16118-1-bp@alien8.de>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris

Trying to understand if I'm missing something here.

On Sun, Aug 14, 2022 at 02:00:26PM +0200, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Currently, the patch application logic checks whether patch application
> is needed. Therefore, on SMT designs where the microcode engine is
> shared between the two threads, the application happens only on one of
> them.

A re-application means, you want to apply even if the cpu_rev <= patch.rev


if cpu_rev is > patch_rev, clearly its ahead?. say BIOS has a newer version
than in the initrd image, do we want to replace the BIOS version since we do
no revid checks here.

> 
> However, there are microcode patches which do per-thread modification,
> see Link tag below.
> 
> Therefore, drop the revision check and try applying on each thread. This
> is what the BIOS does too so this method is very much tested.
> 
> Reported-by:  Ștefan Talpalaru <stefantalpalaru@yahoo.com>
> Tested-by:  Ștefan Talpalaru <stefantalpalaru@yahoo.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216211
> ---
>  arch/x86/kernel/cpu/microcode/amd.c | 39 +++++++----------------------
>  1 file changed, 9 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
> index 8b2fcdfa6d31..a575dbb4d80c 100644
> --- a/arch/x86/kernel/cpu/microcode/amd.c
> +++ b/arch/x86/kernel/cpu/microcode/amd.c
> @@ -420,8 +420,8 @@ apply_microcode_early_amd(u32 cpuid_1_eax, void *ucode, size_t size, bool save_p
>  	struct cont_desc desc = { 0 };
>  	u8 (*patch)[PATCH_MAX_SIZE];
>  	struct microcode_amd *mc;
> -	u32 rev, dummy, *new_rev;
>  	bool ret = false;
> +	u32 *new_rev;
>  
>  #ifdef CONFIG_X86_32
>  	new_rev = (u32 *)__pa_nodebug(&ucode_new_rev);
> @@ -439,10 +439,6 @@ apply_microcode_early_amd(u32 cpuid_1_eax, void *ucode, size_t size, bool save_p
>  	if (!mc)
>  		return ret;
>  
> -	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
> -	if (rev >= mc->hdr.patch_id)
> -		return ret;
> -

Instead of just removing the entire rev check, you want to reapply even if
the rev == patch_rev?

Worried this would allow you to go backwards as well. 


        if(rev > mc->hdr.patch_id)
		return ret;

>  	if (!__apply_microcode_amd(mc)) {
>  		*new_rev = mc->hdr.patch_id;
>  		ret      = true;
> @@ -516,7 +512,7 @@ void load_ucode_amd_ap(unsigned int cpuid_1_eax)
>  {
>  	struct microcode_amd *mc;
>  	struct cpio_data cp;
> -	u32 *new_rev, rev, dummy;
> +	u32 *new_rev;
>  
>  	if (IS_ENABLED(CONFIG_X86_32)) {
>  		mc	= (struct microcode_amd *)__pa_nodebug(amd_ucode_patch);
> @@ -526,10 +522,8 @@ void load_ucode_amd_ap(unsigned int cpuid_1_eax)
>  		new_rev = &ucode_new_rev;
>  	}
>  
> -	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
> -
>  	/* Check whether we have saved a new patch already: */
> -	if (*new_rev && rev < mc->hdr.patch_id) {
> +	if (*new_rev) {

Here cpu_rev < mc->rev, is there a reason to remove this check?

if cpu_rev > mc->rev, the following would go backwards in rev

>  		if (!__apply_microcode_amd(mc)) {
>  			*new_rev = mc->hdr.patch_id;
>  			return;
> @@ -571,23 +565,17 @@ int __init save_microcode_in_initrd_amd(unsigned int cpuid_1_eax)
>  
>  void reload_ucode_amd(void)
>  {
> -	struct microcode_amd *mc;
> -	u32 rev, dummy __always_unused;
> -
> -	mc = (struct microcode_amd *)amd_ucode_patch;
> +	struct microcode_amd *mc = (struct microcode_amd *)amd_ucode_patch;
>  
> -	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
> -
> -	if (rev < mc->hdr.patch_id) {
> -		if (!__apply_microcode_amd(mc)) {
> -			ucode_new_rev = mc->hdr.patch_id;
> -			pr_info("reload patch_level=0x%08x\n", ucode_new_rev);
> -		}
> +	if (!__apply_microcode_amd(mc)) {
> +		ucode_new_rev = mc->hdr.patch_id;
> +		pr_info("reload patch_level=0x%08x\n", ucode_new_rev);
>  	}
>  }
>  static u16 __find_equiv_id(unsigned int cpu)
>  {
>  	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
> +
>  	return find_equiv_id(&equiv_table, uci->cpu_sig.sig);
>  }
>  
> @@ -678,7 +666,7 @@ static enum ucode_state apply_microcode_amd(int cpu)
>  	struct ucode_cpu_info *uci;
>  	struct ucode_patch *p;
>  	enum ucode_state ret;
> -	u32 rev, dummy __always_unused;
> +	u32 rev;
>  
>  	BUG_ON(raw_smp_processor_id() != cpu);
>  
> @@ -691,14 +679,6 @@ static enum ucode_state apply_microcode_amd(int cpu)
>  	mc_amd  = p->data;
>  	uci->mc = p->data;
>  
> -	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
> -
> -	/* need to apply patch? */
> -	if (rev >= mc_amd->hdr.patch_id) {
> -		ret = UCODE_OK;
> -		goto out;
> -	}
> -
>  	if (__apply_microcode_amd(mc_amd)) {
>  		pr_err("CPU%d: update failed for patch_level=0x%08x\n",
>  			cpu, mc_amd->hdr.patch_id);
> @@ -710,7 +690,6 @@ static enum ucode_state apply_microcode_amd(int cpu)
>  
>  	pr_info("CPU%d: new patch_level=0x%08x\n", cpu, rev);
>  
> -out:
>  	uci->cpu_sig.rev = rev;
>  	c->microcode	 = rev;
>  
> -- 
> 2.35.1
> 
