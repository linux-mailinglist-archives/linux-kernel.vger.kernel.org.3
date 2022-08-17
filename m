Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F461596A7F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 09:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbiHQHlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 03:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbiHQHlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:41:36 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8991077E9B
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:41:35 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k16so34987wrx.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=cfWAzcpM/c9VSIt9fGXv336fh+Ou5eQgnJm6z+Ssrss=;
        b=l8hBfK1CUrSh99WjnOBrRRMw3g93SMcGZvMAXE0rk2bb15hle73e2eqHstSggSajGl
         b0Wox5mTsbbkhiTABAS/qmBFYdwU1KSsQXOtyLnhb07mnPLAWwSrK0/Crqn66dU+rvRd
         olxj7Om5HknowH3sqtlMFh0mqjprOssCF9+YVh9zpB9KeWIKWmur/9RYBeHZbJiHrRFP
         mLgEP8UW9Lff0PsjCIbwHL8tTfBe2RmXOZAj7nasEeFJQhkwvpSRrWKn1/Ehgzu1/jWl
         wm/EDz8KWUEWCUZyY9B7KM68i3FZAN9KVzyh4F1nmHWxKG4JmmTJJ5f6GQ9mEtxygB1Z
         xljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=cfWAzcpM/c9VSIt9fGXv336fh+Ou5eQgnJm6z+Ssrss=;
        b=QjJDZfWbWcAf8YI+qfjhiZEQq9ycfwvQJSPIZ8fsT2lPsoMRr0C1OezpK1zFgk03PJ
         D5w9sf0ou179Ph4eTWUvk8yZ/XDWmtjs9cBy6YrwunLk7Wy8tE9yGwBt6X2apyG5vRmc
         uITWLlGt7ht+tjB7i3sBa1eG17Mutt0Ss7TqUY56dQa8VBJwV6/jvmv2aWd4Q4E3TMHA
         K3fzNuf15jQfosuCzaofXuZQxancRmEbdm7udfkMVw7cHLyZB10zIWM6VN+Q6PGJpw+9
         0vREypD9S67FtZc/kkogMCLnGwcX+5PdbkZeMqxEI7FX81w3Mqyf5JHqDMpEruk9jVtJ
         pZ0A==
X-Gm-Message-State: ACgBeo1D55Zzhwo5PiaAgVDl6HjGdU+VhXcBoqx3nM8pwjoQV803HXcN
        BHI2MZGuk5sC5bzi580STOY=
X-Google-Smtp-Source: AA6agR65iobCpxR3N4kmCJGLt6GvCI024JXd/RuPlAjTGsq/VUPA2SqD+2rJyOy22jiCng61vm2/5w==
X-Received: by 2002:a5d:64aa:0:b0:21e:be27:6dfb with SMTP id m10-20020a5d64aa000000b0021ebe276dfbmr13825274wrp.456.1660722094077;
        Wed, 17 Aug 2022 00:41:34 -0700 (PDT)
Received: from gmail.com (195-38-113-151.pool.digikabel.hu. [195.38.113.151])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5f2cc2f1dsm1176949wmq.42.2022.08.17.00.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 00:41:33 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 17 Aug 2022 09:41:31 +0200
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
Subject: Re: [PATCH v3 3/5] x86/microcode: Avoid any chance of MCE's during
 microcode update
Message-ID: <Yvybq+hYT4tG/yAg@gmail.com>
References: <20220817051127.3323755-1-ashok.raj@intel.com>
 <20220817051127.3323755-4-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817051127.3323755-4-ashok.raj@intel.com>
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

> When a microcode update is in progress, several instructions and MSR's can
> be patched by the update. During the update in progress, touching any of
> the resources being patched could result in unpredictable results. If
> thread0 is doing the update and thread1 happens to get a MCE, the handler
> might read an MSR that's being patched.
> 
> In order to have predictable behavior, to avoid this scenario we set the MCIP in
> all threads. Since MCE's can't be nested, HW will automatically promote to
> shutdown condition.
> 
> After the update is completed, MCIP flag is cleared. The system is going to
> shutdown anyway, since the MCE could be a fatal error, or even recoverable
> errors in kernel space are treated as unrecoverable.
> 
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> ---
>  arch/x86/include/asm/mce.h           |  4 ++++
>  arch/x86/kernel/cpu/mce/core.c       |  9 +++++++++
>  arch/x86/kernel/cpu/microcode/core.c | 11 +++++++++++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index cc73061e7255..2aef6120e23f 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -207,12 +207,16 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c);
>  void mcheck_cpu_clear(struct cpuinfo_x86 *c);
>  int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
>  			       u64 lapic_id);
> +extern void mce_set_mcip(void);
> +extern void mce_clear_mcip(void);
>  #else
>  static inline int mcheck_init(void) { return 0; }
>  static inline void mcheck_cpu_init(struct cpuinfo_x86 *c) {}
>  static inline void mcheck_cpu_clear(struct cpuinfo_x86 *c) {}
>  static inline int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
>  					     u64 lapic_id) { return -EINVAL; }
> +static inline void mce_set_mcip(void) {}
> +static inline void mce_clear_mcip(void) {}
>  #endif
>  
>  void mce_setup(struct mce *m);
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 2c8ec5c71712..72b49d95bb3b 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -402,6 +402,15 @@ static noinstr void mce_wrmsrl(u32 msr, u64 v)
>  		     : : "c" (msr), "a"(low), "d" (high) : "memory");
>  }
>  
> +void mce_set_mcip(void)
> +{
> +	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0x1);
> +}
> +
> +void mce_clear_mcip(void)
> +{
> +	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0x0);
> +}

Instead of naming new APIs after how they are doing stuff, please name them 
after *what* they are doing at the highest level: they disable/enable MCEs.

Ie. I'd suggest something like:

     mce_disable()
     mce_enable()

I'd also suggest to at minimum add a WARN_ON_ONCE() if MSR_IA32_MCG_STATUS 
is already 1 when we disable it - because whoever wanted it disabled will 
now be surprised by us enabling them again.

> +	/*
> +	 * Its dangerous to let MCE while microcode update is in progress.

s/let MCE while
 /let MCEs execute while

> +	 * Its extremely rare and even if happens they are fatal errors.
> +	 * But reading patched areas before the update is complete can be
> +	 * leading to unpredictable results. Setting MCIP will guarantee

s/can be leading to
 /can lead to

> +	 * the platform is taken to reset predictively.

What does 'the platform is taken to reset predictively' mean?

Did you mean 'predictibly'/'reliably'?

> +	 */
> +	mce_set_mcip();
>  	/*
>  	 * On an SMT system, it suffices to load the microcode on one sibling of
>  	 * the core because the microcode engine is shared between the threads.
> @@ -457,6 +466,7 @@ static int __reload_late(void *info)
>  	 * loading attempts happen on multiple threads of an SMT core. See
>  	 * below.
>  	 */
> +
>  	if (cpumask_first(topology_sibling_cpumask(cpu)) == cpu)
>  		apply_microcode_local(&err);
>  	else

Spurious newline added?

Thanks,

	Ingo
