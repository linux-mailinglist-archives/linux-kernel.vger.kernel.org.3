Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A833524035
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 00:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348716AbiEKWZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 18:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiEKWZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 18:25:17 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A3D15C183
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:25:16 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id m12so3203142plb.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V5bJJy2RyYza9nG/GuJ7w9CLiEz3hUMqtFlMd73k1V4=;
        b=SYuIvw/tx/wiDq912mkSaefyUCpHzlpZsSas7AQe6Lb5GyrcXEHx2tSo5F9wx84m84
         ttwZgsWrw6g8qcF5aCbUzfLl6o7+TdmLOE3NrlABgDFGVS1ik6/Wa9ae+i0tLlhRX5bk
         S5YhNWWgOOzCKA9FSDfCqGzejAVItUAZ3WynM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V5bJJy2RyYza9nG/GuJ7w9CLiEz3hUMqtFlMd73k1V4=;
        b=C5pMmZledPIzlQ+VQSY+Vr9HvqKyL5WVVzlEQKsDU5XmK/MJBcfBWB6frr9Ujnmnmc
         XzMQuQWzT77mGaY/2TAfPr5AciFP13M3HetHyQz9sQkH1ZHQQIho079VQoSXRO0h6e9F
         268HjnUdhsT1l+IM5UVHZOupfTrcQxWdNyliHZdyukKHm7Ac+BY0oMLiGDmMGMyO1dPU
         xipkxvuOQ5X5ENQwj/SksmReZ4cQxfUuHWuaWNvk341Sl0u3jz+ga4azYHnOWaQPQBd2
         suYnVuqKS0Eo0HvB260PHb3j2HMMUZiwZtvx1Vizv2/9hRQJtNdmy2h3KZBXgH4F27S4
         bYAA==
X-Gm-Message-State: AOAM530CzxZx5tbwhsIz0ebJKCM3O2Sk9fwyMImN20J6ZN1yqTcn8MjU
        i+sErdwKGm98Bb9pkNqTtLdGLw==
X-Google-Smtp-Source: ABdhPJxKGonCUnSEfOND0VeeShr/s99YvMUOtpAqGGJ7iCoNSw+934ho6pYYVD4c3yhHeYLJKQwqgw==
X-Received: by 2002:a17:903:230e:b0:15e:d0a1:922f with SMTP id d14-20020a170903230e00b0015ed0a1922fmr27566878plh.75.1652307915456;
        Wed, 11 May 2022 15:25:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v202-20020a6361d3000000b003c14af505f1sm403388pgb.9.2022.05.11.15.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 15:25:14 -0700 (PDT)
Date:   Wed, 11 May 2022 15:25:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     mcgrof@kernel.org, pmladek@suse.com, rostedt@goodmis.org,
        senozhatsky@chromium.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com, v.narang@samsung.com,
        swboyd@chromium.org, ojeda@kernel.or, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, avimalin@gmail.com,
        atomlin@redhat.com, onkarnath.1@samsung.com
Subject: Re: [PATCH modules-next 1/1] kallsyms: enhance %pS/s/b printing when
 KALLSYSMS is disabled
Message-ID: <202205111513.3AD646936@keescook>
References: <CGME20220421041604epcas5p414cf2e851d1bd828a151dc6b2b004680@epcas5p4.samsung.com>
 <20220421041542.9195-1-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421041542.9195-1-maninder1.s@samsung.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 09:45:42AM +0530, Maninder Singh wrote:
> print module information when KALLSYMS is disabled.

I'd like this patch reverted from -next.
- too many logical changes is a single patch
- addition of dangerous API usage
- duplicated logic (maybe? hard to review due to the changes)

Details below...

> 
> init_build_id() function is moved to module/main.c as it can be
> independent of kallsyms.
> 
> No change for %pB, as it needs to know symbol name to adjust address
> value which can't be done without KALLSYMS.
> 
> (A) original output with KALLSYMS:
> [8.842129] ps function_1 [crash]
> [8.842735] pS function_1+0x4/0x2c [crash]
> [8.842890] pSb function_1+0x4/0x2c [crash b367e79021b9f3b0172f9a36d4261c1f528ca1b3]
> [8.843175] pB function_1+0x4/0x2c [crash]
> [8.843362] pBb function_1+0x4/0x2c [crash b367e79021b9f3b0172f9a36d4261c1f528ca1b3]
> 
> (B) original output without KALLSYMS:

(and ptr hashing disabled?)

> [12.487424] ps 0xffff800000eb008c
> [12.487598] pS 0xffff800000eb008c
> [12.487723] pSb 0xffff800000eb008c
> [12.487850] pB 0xffff800000eb008c
> [12.487967] pBb 0xffff800000eb008c
> 
> (C) With patched kernel
> with KALLYSMS:
> [41.974576] ps function_1 [crash]
> [41.975173] pS function_1+0x4/0x2c [crash]
> [41.975386] pSb function_1+0x4/0x2c [crash a8b20caaec9635b316cf4812f6b55598fe2b7cee]
> [41.975879] pB function_1+0x4/0x2c [crash]
> [41.976076] pBb function_1+0x4/0x2c [crash a8b20caaec9635b316cf4812f6b55598fe2b7cee]
> 
> without KALLSYMS:
> [9.624152] ps 0xffff800001bd008c [crash]	// similar to original, no changes

Why is this not hashed?

> [9.624548] pS 0x(____ptrval____)+0x8c [crash]   // base address hashed and offset is without hash
> [9.624847] pSb 0x(____ptrval____)+0x8c [crash a8b20caaec9635b316cf4812f6b55598fe2b7cee]
> [9.625388] pB 0x(____ptrval____)+0x8c [crash]
> [9.625594] pBb 0x(____ptrval____)+0x8c [crash a8b20caaec9635b316cf4812f6b55598fe2b7cee]

Why is "____ptrval____" visible here after 9 seconds of boot? I would
expect a hashed value to be present.

> 
> with disable hashing:
> [8.563916] ps 0xffff800000f2008c [crash]
> [8.564574] pS 0xffff800000f20000+0x8c [crash]
> [8.564749] pSb 0xffff800000f20000+0x8c [crash 3423a8993a7033fb79e5add14bf9d8d6b56330ca]
> [8.565008] pB 0xffff800000f20000+0x8c [crash]
> [8.565154] pBb 0xffff800000f20000+0x8c [crash 3423a8993a7033fb79e5add14bf9d8d6b56330ca]
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Co-developed-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Tested-by: Petr Mladek <pmladek@suse.com>
> ---
>  include/linux/kallsyms.h |  2 +
>  include/linux/module.h   | 20 ++++++++++
>  kernel/kallsyms.c        | 27 +++++++------
>  kernel/module/internal.h | 11 +++---
>  kernel/module/kallsyms.c | 20 ----------
>  kernel/module/main.c     | 20 ++++++++++
>  lib/vsprintf.c           | 85 ++++++++++++++++++++++++++++++++++------
>  7 files changed, 133 insertions(+), 52 deletions(-)
> 
> diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
> index ce1bd2fbf23e..72bd24e80545 100644
> --- a/include/linux/kallsyms.h
> +++ b/include/linux/kallsyms.h
> @@ -89,6 +89,8 @@ extern int sprint_symbol_build_id(char *buffer, unsigned long address);
>  extern int sprint_symbol_no_offset(char *buffer, unsigned long address);
>  extern int sprint_backtrace(char *buffer, unsigned long address);
>  extern int sprint_backtrace_build_id(char *buffer, unsigned long address);
> +extern int sprint_kallsym_common(char *buffer, unsigned long address, int build_id,
> +			    int backtrace, int symbol);
>  
>  int lookup_symbol_name(unsigned long addr, char *symname);
>  int lookup_symbol_attrs(unsigned long addr, unsigned long *size, unsigned long *offset, char *modname, char *name);
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 46d4d5f2516e..66f4491249c5 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -682,6 +682,20 @@ static inline bool is_livepatch_module(struct module *mod)
>  
>  void set_module_sig_enforced(void);
>  
> +static inline int fill_name_build_id(char *buffer, char *modname,
> +			    int add_buildid, const unsigned char *buildid,
> +			    int len)
> +{
> +	len += sprintf(buffer + len, " [%s", modname);

This patch uses sprintf() everywhere. This needs to be using
scnprintf(). https://lwn.net/Articles/69419/

> +#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
> +	if (add_buildid && buildid) {
> +		/* build ID should match length of sprintf */
> +		static_assert(sizeof(typeof_member(struct module, build_id)) == 20);
> +		len += sprintf(buffer + len, " %20phN", buildid);
> +	}
> +#endif
> +	return len + sprintf(buffer + len, "]");
> +}
>  #else /* !CONFIG_MODULES... */
>  
>  static inline struct module *__module_address(unsigned long addr)
> @@ -818,6 +832,12 @@ void *dereference_module_function_descriptor(struct module *mod, void *ptr)
>  	return ptr;
>  }
>  
> +static inline int fill_name_build_id(char *buffer, char *modname,
> +			    int add_buildid, const unsigned char *buildid,
> +			    int len)
> +{
> +	return 0;
> +}
>  #endif /* CONFIG_MODULES */
>  
>  #ifdef CONFIG_SYSFS
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 79f2eb617a62..e6e96b2e0257 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -465,19 +465,8 @@ static int __sprint_symbol(char *buffer, unsigned long address,
>  	if (add_offset)
>  		len += sprintf(buffer + len, "+%#lx/%#lx", offset, size);
>  
> -	if (modname) {
> -		len += sprintf(buffer + len, " [%s", modname);
> -#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
> -		if (add_buildid && buildid) {
> -			/* build ID should match length of sprintf */
> -#if IS_ENABLED(CONFIG_MODULES)
> -			static_assert(sizeof(typeof_member(struct module, build_id)) == 20);
> -#endif
> -			len += sprintf(buffer + len, " %20phN", buildid);
> -		}
> -#endif
> -		len += sprintf(buffer + len, "]");
> -	}
> +	if (modname)
> +		len += fill_name_build_id(buffer, modname, add_buildid, buildid, len);

Build ID is now part of __sprint_symbol?

>  
>  	return len;
>  }
> @@ -572,6 +561,18 @@ int sprint_backtrace_build_id(char *buffer, unsigned long address)
>  	return __sprint_symbol(buffer, address, -1, 1, 1);
>  }
>  
> +int sprint_kallsym_common(char *buffer, unsigned long address, int build_id,
> +			    int backtrace, int symbol)

I find the build_id argument order unexpected: I'd think it'd match the
ordering of __sprint_symbol?

> +{
> +	if (backtrace)
> +		return __sprint_symbol(buffer, address, -1, 1, build_id);
> +
> +	if (symbol)
> +		return __sprint_symbol(buffer, address, 0, 1, build_id);
> +
> +	return __sprint_symbol(buffer, address, 0, 0, 0);
> +}
> +
>  /* To avoid using get_symbol_offset for every symbol, we carry prefix along. */
>  struct kallsym_iter {
>  	loff_t pos;
> diff --git a/kernel/module/internal.h b/kernel/module/internal.h
> index 3e23bef5884d..cfff130f7c5f 100644
> --- a/kernel/module/internal.h
> +++ b/kernel/module/internal.h
> @@ -206,21 +206,20 @@ static inline void kmemleak_load_module(const struct module *mod,
>  #endif /* CONFIG_DEBUG_KMEMLEAK */
>  
>  #ifdef CONFIG_KALLSYMS
> -void init_build_id(struct module *mod, const struct load_info *info);
>  void layout_symtab(struct module *mod, struct load_info *info);
>  void add_kallsyms(struct module *mod, const struct load_info *info);
>  unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name);
>  
> -static inline bool sect_empty(const Elf_Shdr *sect)
> -{
> -	return !(sect->sh_flags & SHF_ALLOC) || sect->sh_size == 0;
> -}
>  #else /* !CONFIG_KALLSYMS */
> -static inline void init_build_id(struct module *mod, const struct load_info *info) { }
>  static inline void layout_symtab(struct module *mod, struct load_info *info) { }
>  static inline void add_kallsyms(struct module *mod, const struct load_info *info) { }
>  #endif /* CONFIG_KALLSYMS */
>  
> +static inline bool sect_empty(const Elf_Shdr *sect)
> +{
> +	return !(sect->sh_flags & SHF_ALLOC) || sect->sh_size == 0;
> +}
> +
>  #ifdef CONFIG_SYSFS
>  int mod_sysfs_setup(struct module *mod, const struct load_info *info,
>  		    struct kernel_param *kparam, unsigned int num_params);
> diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> index 3e11523bc6f6..576a597615a7 100644
> --- a/kernel/module/kallsyms.c
> +++ b/kernel/module/kallsyms.c
> @@ -209,26 +209,6 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
>  	mod->core_kallsyms.num_symtab = ndst;
>  }
>  
> -#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
> -void init_build_id(struct module *mod, const struct load_info *info)
> -{
> -	const Elf_Shdr *sechdr;
> -	unsigned int i;
> -
> -	for (i = 0; i < info->hdr->e_shnum; i++) {
> -		sechdr = &info->sechdrs[i];
> -		if (!sect_empty(sechdr) && sechdr->sh_type == SHT_NOTE &&
> -		    !build_id_parse_buf((void *)sechdr->sh_addr, mod->build_id,
> -					sechdr->sh_size))
> -			break;
> -	}
> -}
> -#else
> -void init_build_id(struct module *mod, const struct load_info *info)
> -{
> -}
> -#endif
> -
>  /*
>   * This ignores the intensely annoying "mapping symbols" found
>   * in ARM ELF files: $a, $t and $d.
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 05a42d8fcd7a..d511a9c62b53 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2657,6 +2657,26 @@ static int unknown_module_param_cb(char *param, char *val, const char *modname,
>  
>  static void cfi_init(struct module *mod);
>  
> +#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
> +static void init_build_id(struct module *mod, const struct load_info *info)
> +{
> +	const Elf_Shdr *sechdr;
> +	unsigned int i;
> +
> +	for (i = 0; i < info->hdr->e_shnum; i++) {
> +		sechdr = &info->sechdrs[i];
> +		if (!sect_empty(sechdr) && sechdr->sh_type == SHT_NOTE &&
> +		    !build_id_parse_buf((void *)sechdr->sh_addr, mod->build_id,
> +					sechdr->sh_size))
> +			break;
> +	}
> +}
> +#else
> +static inline void init_build_id(struct module *mod, const struct load_info *info)
> +{
> +}
> +#endif
> +
>  /*
>   * Allocate and load the module: note that size of section 0 is always
>   * zero, and we rely on this for optional sections.
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 40d26a07a133..e0aba2c80b8e 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -999,33 +999,92 @@ char *bdev_name(char *buf, char *end, struct block_device *bdev,
>  }
>  #endif
>  
> +#if !defined(CONFIG_KALLSYMS) && defined(CONFIG_MODULES)
> +static int sprint_module_info(char *buf, unsigned long value,
> +			     int modbuildid, int backtrace, int symbol)
> +{
> +	struct module *mod;
> +	unsigned long offset;
> +	void *base;
> +	char *modname;
> +	int len;
> +	const unsigned char *buildid = NULL;
> +	bool add_offset;
> +
> +	if (is_ksym_addr(value))
> +		return 0;
> +
> +	if (backtrace || symbol)
> +		add_offset = true;
> +	else
> +		add_offset = false;
> +
> +	preempt_disable();
> +	mod = __module_address(value);
> +	if (mod) {
> +		modname = mod->name;
> +#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
> +		if (modbuildid)
> +			buildid = mod->build_id;
> +#endif
> +		if (add_offset) {
> +			base = mod->core_layout.base;
> +			offset = value - (unsigned long)base;
> +		}
> +	}
> +	preempt_enable();
> +	if (!mod)
> +		return 0;
> +
> +	/* address belongs to module */
> +	if (add_offset)
> +		len = sprintf(buf, "0x%p+0x%lx", base, offset);
> +	else
> +		len = sprintf(buf, "0x%lx", value);
> +
> +	return len + fill_name_build_id(buf, modname, modbuildid, buildid, len);

Doesn't this duplicate a bunch of logic elsewhere?

> +}
> +#else
> +static inline int sprint_module_info(char *buf, unsigned long value,
> +			     int modbuildid, int backtrace, int symbol)
> +{
> +	return 0;
> +}
> +#endif
> +
>  static noinline_for_stack
>  char *symbol_string(char *buf, char *end, void *ptr,
>  		    struct printf_spec spec, const char *fmt)
>  {
>  	unsigned long value;
> -#ifdef CONFIG_KALLSYMS
>  	char sym[KSYM_SYMBOL_LEN];
> -#endif
> +	int backtrace = 0, symbol = 0, build_id = 0;
>  
>  	if (fmt[1] == 'R')
>  		ptr = __builtin_extract_return_addr(ptr);
>  	value = (unsigned long)ptr;
>  
> -#ifdef CONFIG_KALLSYMS
> -	if (*fmt == 'B' && fmt[1] == 'b')
> -		sprint_backtrace_build_id(sym, value);
> -	else if (*fmt == 'B')
> -		sprint_backtrace(sym, value);
> -	else if (*fmt == 'S' && (fmt[1] == 'b' || (fmt[1] == 'R' && fmt[2] == 'b')))
> -		sprint_symbol_build_id(sym, value);
> -	else if (*fmt != 's')
> -		sprint_symbol(sym, value);
> -	else
> -		sprint_symbol_no_offset(sym, value);
> +	if (fmt[0] == 'B' && fmt[1] == 'b') {
> +		backtrace = 1;
> +		build_id = 1;
> +	} else if (fmt[0] == 'B')
> +		backtrace = 1;
> +	else if (fmt[0] == 'S' && (fmt[1] == 'b' || (fmt[1] == 'R' && fmt[2] == 'b'))) {
> +		symbol = 1;
> +		build_id = 1;
> +	} else if (fmt[0] != 's')
> +		symbol = 1;
> +	else {
> +		/* Do Nothing, no offset */
> +	}
>  
> +#ifdef CONFIG_KALLSYMS
> +	sprint_kallsym_common(sym, value, build_id, backtrace, symbol);
>  	return string_nocheck(buf, end, sym, spec);
>  #else
> +	if (sprint_module_info(sym, value, build_id, backtrace, symbol))
> +		return string_nocheck(buf, end, sym, spec);

These take the same arguments, and only differ about their ability to
look things up.

> +
>  	return special_hex_number(buf, end, value, sizeof(void *));
>  #endif
>  }
> -- 
> 2.17.1
> 

-- 
Kees Cook
