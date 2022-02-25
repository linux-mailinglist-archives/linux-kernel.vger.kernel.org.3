Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F69B4C3ABE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbiBYBKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiBYBKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:10:05 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6BE1D06CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 17:09:34 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id w2so3346512pfu.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 17:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HpKKeKk2n1Oj0dQS7Dfs5DCdtWzG04Br2ivnFnRWVfI=;
        b=VM4AvjfzqNXsfDsdvekvRmxTfDgxlsOD77uJDqascic5L6G4TxJnnlkDDP0Hn5Dnbo
         iCMSEAMd874Pg645wmT5FjpVbJx+74tto+6+wJeLmJ3SNBtcMkEL7EkVBeKMCrOzZ+g0
         BUqsv0pxXmG7Urq/B/jsxI95F+FPe9VCL8arc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HpKKeKk2n1Oj0dQS7Dfs5DCdtWzG04Br2ivnFnRWVfI=;
        b=S3Mt7F/Q7wHULo+8mnW0xhypKMvcYCKph/36fuJU91CvkMSVzzGeRtfmDLy3h/ksRV
         OiACYzcycV8iT6a4y5y5hVjmO/TYD+A1PGV4iw2lV0JYZ/Q334Uwa5vuTA+TvsNfsRG4
         sUntP6DbfZJvHZW1D1tU1pWlmDyTV8ljnn5Ftc3FJz4ZC4jmYu4QVXi1nAKOEExtAZN/
         4PmIQUi8P2x21LpzqwhnZsAV3Nnyq61E/5SWn1sGKI9uBG17227mFBMwMfLhpR3kB33k
         azshTwM+YHMcLpEiwMTxnpUOGfBRD3B8G1kvzr0IxS08UBOpBH2bGKZi6dp1gi7AzJk5
         QqgQ==
X-Gm-Message-State: AOAM533MGY7KXqJ0QZdPx7jTcheJjCGupL+4TZYKMJvNPJNEzoEns///
        LKWLZo1VSnZtpWLGcx8GwqeqhA==
X-Google-Smtp-Source: ABdhPJylGbQS8vnj/61NHBaKcstT9+xfvM8OeGnu5F6R0WwgMIHkmiZKleXGTp12T1C8eyeC5tkS/g==
X-Received: by 2002:a63:db47:0:b0:372:dc64:5b56 with SMTP id x7-20020a63db47000000b00372dc645b56mr4203632pgi.555.1645751373911;
        Thu, 24 Feb 2022 17:09:33 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d25-20020a639919000000b00364f999aed5sm664001pge.20.2022.02.24.17.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 17:09:33 -0800 (PST)
Date:   Thu, 24 Feb 2022 17:09:32 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 18/39] x86/ibt: Add IBT feature, MSR and #CP handling
Message-ID: <202202241700.6FB8CDF7E7@keescook>
References: <20220224145138.952963315@infradead.org>
 <20220224151323.069205370@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224151323.069205370@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 03:51:56PM +0100, Peter Zijlstra wrote:
> [...]
> @@ -438,7 +439,8 @@ static __always_inline void setup_umip(s
>  
>  /* These bits should not change their value after CPU init is finished. */
>  static const unsigned long cr4_pinned_mask =
> -	X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP | X86_CR4_FSGSBASE;
> +	X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP |
> +	X86_CR4_FSGSBASE | X86_CR4_CET;

Thanks!

>  static DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
>  static unsigned long cr4_pinned_bits __ro_after_init;
>  
> @@ -592,6 +594,29 @@ static __init int setup_disable_pku(char
>  __setup("nopku", setup_disable_pku);
>  #endif /* CONFIG_X86_64 */
>  
> +static __always_inline void setup_cet(struct cpuinfo_x86 *c)
> +{
> +	u64 msr = CET_ENDBR_EN;
> +
> +	if (!HAS_KERNEL_IBT ||
> +	    !cpu_feature_enabled(X86_FEATURE_IBT))
> +		return;
> +
> +	wrmsrl(MSR_IA32_S_CET, msr);
> +	cr4_set_bits(X86_CR4_CET);
> +
> +	if (!ibt_selftest()) {
> +		pr_err("IBT selftest: Failed!\n");
> +		setup_clear_cpu_cap(X86_FEATURE_IBT);
> +	}

For easy boot-output testing, I'd love to see something like:

	} else {
		pr_info("CET detected: Indirect Branch Tracking enabled.\n")
	}

or maybe:
		pr_info("CET detected: Indirect Branch Tracking is %s.\n",
			ibt_fatal ? "enforced" : "warning only");

> [...]
> +bool ibt_selftest(void)
> +{
> +	unsigned long ret;
> +
> +	asm ("1: lea 2f(%%rip), %%rax\n\t"
> +	     ANNOTATE_RETPOLINE_SAFE
> +	     "   jmp *%%rax\n\t"
> +	     ASM_REACHABLE
> +	     ANNOTATE_NOENDBR
> +	     "2: nop\n\t"
> +
> +	     /* unsigned ibt_selftest_ip = 2b */
> +	     ".pushsection .rodata,\"a\"\n\t"
> +	     ".align 8\n\t"
> +	     ".type ibt_selftest_ip, @object\n\t"
> +	     ".size ibt_selftest_ip, 8\n\t"
> +	     "ibt_selftest_ip:\n\t"
> +	     ".quad 2b\n\t"
> +	     ".popsection\n\t"
> +
> +	     : "=a" (ret) : : "memory");
> +
> +	return !ret;
> +}

I did something like this for LKDTM, but I realize it depends on having no
frame pointer, and is likely x86-specific too, as I think arm64's function
preamble is responsible for pushing the return address on the stack:


static volatile int lkdtm_just_count;

/* Function taking one argument, returning int. */
static noinline void *lkdtm_just_return(void)
{
	/* Do something after preamble but before label. */
	lkdtm_just_count++;

yolo:
	{
		void *right_here = &&yolo;

		OPTIMIZER_HIDE_VAR(right_here);
		return right_here;
	}
}
/*
 * This tries to call an indirect function in the middle.
 */
void lkdtm_CFI_FORWARD_ENTRY(void)
{
	/*
	 * Matches lkdtm_increment_void()'s prototype, but not
	 * lkdtm_increment_int()'s prototype.
	 */
	void * (*func)(void);

	func = lkdtm_just_return;
	pr_info("Calling actual function entry point %px ...\n", func);
	func = func();

	pr_info("Calling middle of function %px ...\n", func);
	func = func();

	pr_err("FAIL: survived non-entry point call!\n");
#ifdef CONFIG_X86
	pr_expected_config(CONFIG_X86_BTI);
#endif
}

-- 
Kees Cook
