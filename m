Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332215206C5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 23:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiEIVmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 17:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiEIVme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 17:42:34 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40FEABF66
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 14:38:39 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t13so13089007pgn.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 14:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hEal1fzA7Cb6EVB7wLpuE+1jBjav8uqTWNmWNSLdPPM=;
        b=mfk/cb7RNKP6+nHTNwOcOjPLUBR4aoeuA3mnGv0IUwXDr1Ujp98W34C2EvCbcKGbUg
         +xtsae0h3SD4iH7NDkEbPHLfZNP1uvGFtCHLTxBcEGyawYXYyn2hyGN2ua+qGkI2ZmYN
         9ERzDdNqXb9KtaHLnTmEFLn5K81AHaUSvNV7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hEal1fzA7Cb6EVB7wLpuE+1jBjav8uqTWNmWNSLdPPM=;
        b=gO4AwubnwgmsLSe3aZH3oaec5M2BZKHjsZxb94CzHCWYqNLK8rkkCQA6St20oNoZCK
         PRecAhxTrn1AqtoNMsjo010PjkPw27J2cBvcQOIKK4BNFi7/HTEV4SuNu/YCozEjMOgr
         CLv7/m8FfuFYNGEjTaEucscGYwXUPsFXco8PXC41v/6jUupNsxeXoJe4wDrCiWtYXRuZ
         qZfHR2biiFSfBpVMg8XnM2GT5zGGo09+x81t+ATQxZUciJK+rnPjmyih/U3SonlQbuAc
         9cr8LaPs5J8UF5qOpGegi/ObJL4qhApKWJxx/PQeRDh1fUYRyZnaPvmpYsZJjlDUFEvo
         k2OA==
X-Gm-Message-State: AOAM530kmMUkl/5HNiixXZ7CYQrLGTDOVfTKfwAizNLACfGJGHeyy+oQ
        C4r7GTmu6dvibxa3XFCyi4LTEg==
X-Google-Smtp-Source: ABdhPJx60tGBlAHyzZZAcgMzRcFzvYJ65r/xUfb28gP+vABmu2ZnfueyUR+aVfnAOHnZ2YyKOkpd6w==
X-Received: by 2002:a05:6a00:2181:b0:4f6:f1b1:1ba7 with SMTP id h1-20020a056a00218100b004f6f1b11ba7mr17818642pfi.73.1652132319432;
        Mon, 09 May 2022 14:38:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902d34600b0015e8d4eb1fasm356965plk.68.2022.05.09.14.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 14:38:39 -0700 (PDT)
Date:   Mon, 9 May 2022 14:38:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     ira.weiny@intel.com
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH V10 14/44] mm/pkeys: Introduce pks_set_readwrite()
Message-ID: <202205091304.434A9B45@keescook>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
 <20220419170649.1022246-15-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419170649.1022246-15-ira.weiny@intel.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 10:06:19AM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> When kernel code needs access to a PKS protected page they will need to
> change the protections for the pkey to Read/Write.

I'm excited to have this infrastructure available! It'll finally give us
the "write rarely" infrastructure we've needed:
https://github.com/KSPP/linux/issues/130

> 
> Define pks_set_readwrite() to update the specified pkey.  Define
> pks_update_protection() as a helper to do the heavy lifting and allow
> for subsequent pks_set_*() calls.
> 
> Define PKEY_READ_WRITE rather than use a magic value of '0' in
> pks_update_protection().
> 
> Finally, ensure preemption is disabled for pks_write_pkrs() because the
> context of this call can not generally be predicted.
> 
> pks.h is created to avoid conflicts and header dependencies with the
> user space pkey code.
> 
> Add documentation.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> changes for v9
> 	Move MSR documentation note to this patch
> 	move declarations to incline/linux/pks.h
> 	from rick edgecombe
> 		change pkey type to u8
> 	validate pkey range in pks_update_protection
> 	from 0day
> 		fix documentation link
> 	from dave hansen
> 		s/pks_mk_*/pks_set_*/
> 		use pkey
> 		s/pks_saved_pkrs/pkrs/
> 
> changes for v8
> 	define pkey_read_write
> 	make the call inline
> 	clean up the names
> 	use pks_write_pkrs() with preemption disabled
> 	split this out from 'add pks kernel api'
> 	include documentation in this patch
> ---
>  Documentation/core-api/protection-keys.rst | 15 +++++++++++
>  arch/x86/mm/pkeys.c                        | 31 ++++++++++++++++++++++
>  include/linux/pks.h                        | 31 ++++++++++++++++++++++
>  include/uapi/asm-generic/mman-common.h     |  1 +
>  4 files changed, 78 insertions(+)
>  create mode 100644 include/linux/pks.h
> 
> diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
> index fe63acf5abbe..3af92e1cbffd 100644
> --- a/Documentation/core-api/protection-keys.rst
> +++ b/Documentation/core-api/protection-keys.rst
> @@ -142,3 +142,18 @@ Adding pages to a pkey protected domain
>  
>  .. kernel-doc:: arch/x86/include/asm/pgtable_types.h
>          :doc: PKS_KEY_ASSIGNMENT
> +
> +Changing permissions of individual keys
> +---------------------------------------
> +
> +.. kernel-doc:: include/linux/pks.h
> +        :identifiers: pks_set_readwrite
> +
> +MSR details
> +~~~~~~~~~~~
> +
> +WRMSR is typically an architecturally serializing instruction.  However,
> +WRMSR(MSR_IA32_PKRS) is an exception.  It is not a serializing instruction and
> +instead maintains ordering properties similar to WRPKRU.  Thus it is safe to
> +immediately use a mapping when the pks_set*() functions returns.  Check the
> +latest SDM for details.
> diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
> index 39e4c2cbc279..e4cbc79686ea 100644
> --- a/arch/x86/mm/pkeys.c
> +++ b/arch/x86/mm/pkeys.c
> @@ -6,6 +6,7 @@
>  #include <linux/debugfs.h>		/* debugfs_create_u32()		*/
>  #include <linux/mm_types.h>             /* mm_struct, vma, etc...       */
>  #include <linux/pkeys.h>                /* PKEY_*                       */
> +#include <linux/pks.h>
>  #include <linux/pks-keys.h>
>  #include <uapi/asm-generic/mman-common.h>
>  
> @@ -275,4 +276,34 @@ void pks_setup(void)
>  	cr4_set_bits(X86_CR4_PKS);
>  }
>  
> +/*
> + * Do not call this directly, see pks_set*().
> + *
> + * @pkey: Key for the domain to change
> + * @protection: protection bits to be used
> + *
> + * Protection utilizes the same protection bits specified for User pkeys
> + *     PKEY_DISABLE_ACCESS
> + *     PKEY_DISABLE_WRITE
> + *
> + */
> +void pks_update_protection(u8 pkey, u8 protection)

For better security, I think this should be a static inline, not a
callable (i.e. as a non-inline it could be the target of a control
flow attack).

> +{
> +	u32 pkrs;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_PKS))
> +		return;
> +
> +	if (WARN_ON_ONCE(pkey >= PKS_KEY_MAX))
> +		return;

I think this should enforce arguments being __builtin_constant_p(). i.e.
making sure that all callers of pks_update_protection() are using a
compile-time constant value. That makes it so that the caller location
and key become hard-coded (i.e. further reduction in risk to becoming a
control-flow gadget: the inlining of a const value means no arguments
any more). For example:

	BUILD_BUG_ON(!__builtin_constant_p(pkey));
	BUILD_BUG_ON(!__builtin_constant_p(protection));

(I think the test code will need some tweaking, but it should be
possible to adjust it.)

> +
> +	pkrs = current->thread.pkrs;
> +	current->thread.pkrs = pkey_update_pkval(pkrs, pkey,
> +						 protection);
> +	preempt_disable();
> +	pks_write_pkrs(current->thread.pkrs);
> +	preempt_enable();

To resist cross-thread attacks, please:

- make pkey_update_pkval() also an inline
- use the pkrs variable directly and store it back only after the write

For example:

	preempt_disable();
	pkrs = pkey_update_pkval(current->thread.pkrs,
				 pkey, protection);
	pks_write_pkrs(pkrs);
	current->thread.pkrs = pkrs;
	preempt_enable();

This means that the pkey/protection relationship always lives in a
CPU-local register and cannot be manipulated by another CPU before the
msr write completes. Better yet would be:

	preempt_disable();
	rdmsrl(MSR_IA32_PKRS, pkrs);
	pkrs = pkey_update_pkval(pkrs, pkey, protection);
	pks_write_pkrs(pkrs);
	current->thread.pkrs = pkrs;
	preempt_enable();

Then cross-thread attacks cannot corrupt the _other_ PKS keys (i.e.
write the desired changes to target's current->thread.kprs and trigger
an update to a different pkey, resulting in flushing the attacker's
changes to that CPU's pkey state.

> +/**
> + * pks_set_readwrite() - Make the domain Read/Write
> + * @pkey: the pkey for which the access should change.
> + *
> + * Allow all access, read and write, to the domain specified by pkey.  This is
> + * not a global update and only affects the current running thread.
> + */
> +static inline void pks_set_readwrite(u8 pkey)
> +{
> +	pks_update_protection(pkey, PKEY_READ_WRITE);
> +}

While adding these, can you please also add pks_set_nowrite()? This
will be needed for protecting writes to memory that should be otherwise
readable.

With these changes it should be possible to protect the kernel's page
table entries from "stray" writes. :)

-Kees

> +
> +#else /* !CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
> +
> +static inline void pks_set_readwrite(u8 pkey) {}
> +
> +#endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
> +
> +#endif /* _LINUX_PKS_H */
> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> index 6c1aa92a92e4..f179544bd33a 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -80,6 +80,7 @@
>  /* compatibility flags */
>  #define MAP_FILE	0
>  
> +#define PKEY_READ_WRITE		0x0
>  #define PKEY_DISABLE_ACCESS	0x1
>  #define PKEY_DISABLE_WRITE	0x2
>  #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
> -- 
> 2.35.1
> 

-- 
Kees Cook
