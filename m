Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4555D596A9C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 09:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbiHQHpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 03:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbiHQHpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:45:11 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2D079A57
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:45:10 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k16so43823wrx.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=HFcfwOb/lD01Rj3Ey5Bei3116I3ycqzoCbaWnsO8vpA=;
        b=l0l8Vz2xyVB4mSTBvNUAy2cyB0RRPZTHBao5daw8qtQi+mbamZGSBsqtdBc3361Xbl
         dB6nUBS2jy9iiPvs9VhGfkRNFy9120TlFnJ2Idk9ADpPUoQrGzMWjnhBGhbF6ZbC/o/P
         wajQzUiZDvOQsRHm0Pjh43MpdnatF11/8xD3P0Cspqg7jFSefBX8QeU8ISYsKEKmiI8i
         53BV7T870m0OkVty4H0qJyc2D3LPoqN7mmmTOkdr8N7SyGZHfVFlEdWg0puVApBj9qQ9
         b55BDlH4BxGCJdeP5GNXMSOC324w7ll1fI76ksVPl5taAPVEFCMIfzUli6cE9vEiLAYK
         Ax6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=HFcfwOb/lD01Rj3Ey5Bei3116I3ycqzoCbaWnsO8vpA=;
        b=GDZm0OZwnxGuk7U243UT9EkQ1ZHDjmh2OToX/sy+3KzadaXugYVce8INfS8ctGZj5v
         5w//eNwGPqleXuQvhiNqYiikwzO7IY1dCOsFYLcq3Hm7FqO1zG60+dhlRyIUVOeoWs0V
         GI76nBPPVacAVln3P7DIS011Oguk6VfwiaYZ/hF48XBXOFwMVAqNDiy3tdl/asJGVRvM
         tdxwmXmsO67qJhO97/1uzD7Y4Bu9RGQzGgrvElUOffCSR1ZslVVMatihLp1vK0z3tIcs
         ESV/UpNb3L8N1fl6kkbeAXSw39HMi2gefok+RG1uFlW1S9YPbGpdG9bbJKSZzFwZGww8
         G/8g==
X-Gm-Message-State: ACgBeo0EjDl0lq1AjeK8V06VLuhCMXMzLULwfdFYsIY/FMQtgPKHLOvJ
        1ADH+w+Bm+5obeE3SQeZVm4=
X-Google-Smtp-Source: AA6agR7UMlZKGEd++1JZg6xSz5hfCSY947xtP2e+3skvIl2jYGju7pO3k0GxOaZw3QbD6yXDa8F+PQ==
X-Received: by 2002:a5d:5273:0:b0:220:5d3e:c50f with SMTP id l19-20020a5d5273000000b002205d3ec50fmr13984628wrc.291.1660722309159;
        Wed, 17 Aug 2022 00:45:09 -0700 (PDT)
Received: from gmail.com (195-38-113-151.pool.digikabel.hu. [195.38.113.151])
        by smtp.gmail.com with ESMTPSA id i15-20020a05600c354f00b003a5dfd7e9eesm1201449wmq.44.2022.08.17.00.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 00:45:08 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 17 Aug 2022 09:45:06 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>
Subject: Re: [PATCH v3 2/5] x86/microcode/intel: Allow a late-load only if a
 min rev is specified
Message-ID: <YvycggAits6wBXP8@gmail.com>
References: <20220817051127.3323755-1-ashok.raj@intel.com>
 <20220817051127.3323755-3-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817051127.3323755-3-ashok.raj@intel.com>
X-Spam-Status: No, score=1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ashok Raj <ashok.raj@intel.com> wrote:

> In general users don't have the necessary information to determine
> whether a late-load of a new microcode version has removed any feature
> (MSR, CPUID etc) between what is currently loaded and this new microcode.
> To address this issue, Intel has added a "minimum required version" field to
> a previously reserved field in the file header. Microcode updates
> should only be applied if the current microcode version is equal
> to, or greater than this minimum required version.
> 
> https://lore.kernel.org/linux-kernel/alpine.DEB.2.21.1909062237580.1902@nanos.tec.linutronix.de/
> 
> Thomas made some suggestions on how meta-data in the microcode file could
> provide Linux with information to decide if the new microcode is suitable
> candidate for late-load. But even the "simpler" option#1 requires a lot of
> metadata and corresponding kernel code to parse it.
> 
> The proposal here is an even simpler option. The criteria for a microcode to
> be a viable late-load candidate is that no CPUID or OS visible MSR features
> are removed with respect to an earlier version of the microcode.
> 
> Pseudocode for late-load is as follows:
> 
> if header.min_required_id == 0
> 	This is old format microcode, block late-load
> else if current_ucode_version < header.min_required_id
> 	Current version is too old, block late-load of this microcode.
> else
> 	OK to proceed with late-load.
> 
> Any microcode that removes a feature will set the min_version to itself.
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
> 
> 2. New microcode with a non-zero min_rev in the header, but the specified
>    min_rev is greater than what is currently loaded in the CPU should be
>    blocked by kernel.
> 
>    245.139828] microcode: Current revision 0x8f685300 is too old to update,
> must be at 0xaa000050 version or higher
> 
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
>  	struct extended_sigtable *ext_header = NULL;
>  	u32 sum, orig_sum, ext_sigcount = 0, i;
>  	struct extended_signature *ext_sig;
> +	struct ucode_cpu_info uci;
>  
>  	total_size = get_totalsize(mc_header);
>  	data_size = get_datasize(mc_header);
> @@ -248,6 +249,25 @@ static int microcode_sanity_check(void *mc, int print_err)
>  		return -EINVAL;
>  	}
>  
> +	/*
> +	 * Enforce for late-load that min_req_id is specified in the header.
> +	 * Otherwise its an old format microcode, reject it.

s/its
 /it's

...

> +	 */
> +	if (print_err) {
> +		if (!mc_header->min_req_id) {
> +			pr_warn("Header MUST specify min version for late-load\n");
> +			return -EINVAL;
> +		}
> +
> +		intel_cpu_collect_info(&uci);
> +		if (uci.cpu_sig.rev < mc_header->min_req_id) {
> +			pr_warn("Current revision 0x%x is too old to update,"
> +				"must  be at 0x%x version or higher\n",
> +				uci.cpu_sig.rev, mc_header->min_req_id);

Please don't line-break user-visible syslog strings, just because 
checkpatch is stupid.

If the user sees it as a single line, developers should see that same line 
too...

Thanks,

	Ingo
