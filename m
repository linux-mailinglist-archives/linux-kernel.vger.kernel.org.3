Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5054C4DC45E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 11:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbiCQLAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbiCQLAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:00:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF572176D29;
        Thu, 17 Mar 2022 03:59:19 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3453021110;
        Thu, 17 Mar 2022 10:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647514758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FRZFWYXu0lglEsdbgAkHKkmcItgzgemxTYTZc8fsVTc=;
        b=InraB4+0kSCdc8UDu/okTjNgatj5P6RAXhgCUwmKkl5JBuP6Jc7a82aAVFQCKM5cJV03oP
        loW9dzgewNjtEz6rsoEZ9jmW3SA7GOPDLYpS9JFRAiS9/7oKRCLfQcaX5T5WrPRqHSmMPf
        97Oh7UgJ4tESVOfSiJe/aFWx82wNEnE=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 97D36A3B83;
        Thu, 17 Mar 2022 10:59:16 +0000 (UTC)
Date:   Thu, 17 Mar 2022 11:59:15 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     mcgrof@kernel.org, rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        v.narang@samsung.com, swboyd@chromium.org, ojeda@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        avimalin@gmail.com, atomlin@redhat.com, keescook@chromium.org,
        ndesaulniers@google.com, rdunlap@infradead.org, void@manifault.com
Subject: Re: [PATCH 1/1 module-next] kallsyms: enhance %pS/s/b printing when
 KALLSYSMS is disabled
Message-ID: <YjMUg8xwgRAH3lzA@alley>
References: <CGME20220316043552epcas5p29b0723b7c55a3bcc9b4d858660e45933@epcas5p2.samsung.com>
 <20220316043540.677128-1-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316043540.677128-1-maninder1.s@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-03-16 10:05:40, Maninder Singh wrote:
> print module information when KALLSYMS is disabled.
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
> [9.624548] pS 0x(____ptrval____)+0x8c [crash]   // base address hashed and offset is without hash
> [9.624847] pSb 0x(____ptrval____)+0x8c [crash a8b20caaec9635b316cf4812f6b55598fe2b7cee]
> [9.625388] pB 0x(____ptrval____)+0x8c [crash]
> [9.625594] pBb 0x(____ptrval____)+0x8c [crash a8b20caaec9635b316cf4812f6b55598fe2b7cee]
> 
> with disable hashing:
> [8.563916] ps 0xffff800000f2008c [crash]
> [8.564574] pS 0xffff800000f20000+0x8c [crash]
> [8.564749] pSb 0xffff800000f20000+0x8c [crash 3423a8993a7033fb79e5add14bf9d8d6b56330ca]
> [8.565008] pB 0xffff800000f20000+0x8c [crash]
> [8.565154] pBb 0xffff800000f20000+0x8c [crash 3423a8993a7033fb79e5add14bf9d8d6b56330ca]
> 
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -979,33 +979,92 @@ char *bdev_name(char *buf, char *end, struct block_device *bdev,
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

I think that some earlier version of the patch allowed to print
also the address from vmlinux with the offset. My concern was
that it would show non-hashed base pointer. IMHO, it is fine
to show it hashed.

> +
> +	/* address belongs to module */
> +	if (add_offset)
> +		len = sprintf(buf, "0x%p+0x%lx", base, offset);
> +	else
> +		len = sprintf(buf, "0x%lx", value);
> +
> +	return len + fill_name_build_id(buf, modname, modbuildid, buildid, len);
> +}

Otherwise, it looks good to me. I did also some basic testing.
The vmlinux address with offset can be added by a followup patch.
Feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
