Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C46524B88
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353359AbiELLWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353502AbiELLVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:21:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D85F37015
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 04:21:14 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1BAD51EC06D9;
        Thu, 12 May 2022 13:21:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652354469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3af80NoShEJeVK3bKiOGXNISWp5953FppXTqOHZIyWE=;
        b=cksWcvnBT88mXlZX++f6bki9H++RpxKakk9PxHEgEIkeXo4rHOsLACLRIw2NJzR0j66JYg
        +8hW7jZSEZG69gbVMO1PoYFqQsI9Zd0n0cscr1UCq7mXCQWdXXk8lojz8z3Ifl57ruNu0W
        Qb0eGvd+pIvYRvhz5WEn2WwwYmvafP0=
Date:   Thu, 12 May 2022 13:21:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Baskov Evgeniy <baskov@ispras.ru>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] x86: Parse CONFIG_CMDLINE in compressed kernel
Message-ID: <YnztqAtNEvnF5YcX@zn.tnic>
References: <20220505103224.21667-1-baskov@ispras.ru>
 <20220505103224.21667-3-baskov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220505103224.21667-3-baskov@ispras.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 01:32:24PM +0300, Baskov Evgeniy wrote:

Same note on the subject format as for your previous patch.

> CONFIG_CMDLINE, CONFIG_CMDLINE_BOOL, and CONFIG_CMDLINE_OVERRIDE were
> ignored during options lookup in compressed kernel.
> 
> Parse CONFIG_CMDLINE-related options correctly in compressed kernel
> code.
> 
> cmd_line_ptr_init is explicitly placed in .data section since it is
> used and expected to be equal to zero before .bss section is cleared.

What I'm missing in this commit message is the use case which you have
in your 0/2 mail.

Also, to the tone of your commit messages, from
Documentation/process/submitting-patches.rst:

 "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
  to do frotz", as if you are giving orders to the codebase to change
  its behaviour."

Also, do not talk about what your patch does - that should hopefully be
visible in the diff itself. Rather, talk about *why* you're doing what
you're doing.

> Signed-off-by: Baskov Evgeniy <baskov@ispras.ru>
> 
> diff --git a/arch/x86/boot/compressed/cmdline.c b/arch/x86/boot/compressed/cmdline.c
> index f1add5d85da9..261f53ad395a 100644
> --- a/arch/x86/boot/compressed/cmdline.c
> +++ b/arch/x86/boot/compressed/cmdline.c
> @@ -1,6 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include "misc.h"
>  
> +#define COMMAND_LINE_SIZE 2048
> +
>  static unsigned long fs;
>  static inline void set_fs(unsigned long seg)
>  {
> @@ -12,12 +14,32 @@ static inline char rdfs8(addr_t addr)
>  	return *((char *)(fs + addr));
>  }
>  #include "../cmdline.c"
> +
> +#ifdef CONFIG_CMDLINE_BOOL
> +static char builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
> +static bool builtin_cmdline_init __section(".data");
> +#endif
> +
>  unsigned long get_cmd_line_ptr(void)
>  {
>  	unsigned long cmd_line_ptr = boot_params->hdr.cmd_line_ptr;
> -
>  	cmd_line_ptr |= (u64)boot_params->ext_cmd_line_ptr << 32;
>  
> +#ifdef CONFIG_CMDLINE_BOOL
> +	if (!builtin_cmdline_init) {
> +		if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
> +			strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
> +			strlcat(builtin_cmdline,
> +				(char *)cmd_line_ptr,
> +				COMMAND_LINE_SIZE);
> +		}
> +
> +		builtin_cmdline_init = 1;
> +	}
> +
> +	cmd_line_ptr = (unsigned long)builtin_cmdline;
> +#endif

I had asked this already but let me try again: instead of copying this
from kernel proper, why don't you add a common helper which you call
from both locations?

And it is not like this is going to be a huge function so you can stick
it into a shared header in arch/x86/include/asm/shared/ and it'll get
inlined into both locations...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
