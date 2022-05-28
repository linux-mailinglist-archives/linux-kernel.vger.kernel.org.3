Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D86E536DCA
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 18:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238546AbiE1Qk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 12:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238307AbiE1QkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 12:40:23 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A9713EA1;
        Sat, 28 May 2022 09:40:21 -0700 (PDT)
Date:   Sun, 29 May 2022 00:41:07 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653756019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+FSRGYJ5CWwQNcNXNsvsX6b7FMt9Ji3rjbqmnbhCCV8=;
        b=fxJ8CQ3ukTwvSLk3yAXJhEmIxlVVq1bixVA9RaazQ0TbAszmWjZY/g+tQ5SZs4/xgRUTGj
        Zgbx5n1/BYoXqvXLVrGWi2pHo9f/0c5eoDKV6gOunaJjhmYeoU4uB8SsJhYtBqWOcuzHL9
        Ipa5rP6uzroFO6rXWxJv8xQZfqdKPtE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Yu-Jen Chang <arthurchang09@gmail.com>, tao.zhou@linux.dev
Cc:     ak@linux.intel.com, jdike@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes@sipsolutions.net, linux-um@lists.infradead.org,
        jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH 1/2] x86/lib: Optimize memchr()
Message-ID: <YpJQoxUt9RhKb0Pr@geo.homenetwork>
References: <20220528081236.3020-1-arthurchang09@gmail.com>
 <20220528081236.3020-2-arthurchang09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220528081236.3020-2-arthurchang09@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 04:12:35PM +0800, Yu-Jen Chang wrote:

> The original assembly version of memchr() is implemented with
> the byte-wise comparing technique, which does not fully
> use 64-bits registers in x86_64 CPU. We use word-wide
> comparing so that 8 characters can be compared at the same time
> on x86_64 CPU. First we align the input and then use word-wise
> comparing to find the first 64-bit word that contain the target.
> Secondly, we compare every byte in the word and get the output.
> 
> We create two files to measure the performance. The first file
> contains on average 10 characters ahead the target character.
> The second file contains at least 1000 characters ahead the
> target character. Our implementation of “memchr()” is slightly
> better in the first test and nearly 4x faster than the orginal
> implementation in the second test.
> 
> Signed-off-by: Yu-Jen Chang <arthurchang09@gmail.com>
> Signed-off-by: Ching-Chun (Jim) Huang <jserv@ccns.ncku.edu.tw>
> ---
>  arch/x86/include/asm/string_64.h |  3 ++
>  arch/x86/lib/Makefile            |  1 +
>  arch/x86/lib/string_64.c         | 78 ++++++++++++++++++++++++++++++++
>  3 files changed, 82 insertions(+)
>  create mode 100644 arch/x86/lib/string_64.c
> 
> diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
> index 6e450827f..edce657e0 100644
> --- a/arch/x86/include/asm/string_64.h
> +++ b/arch/x86/include/asm/string_64.h
> @@ -14,6 +14,9 @@
>  extern void *memcpy(void *to, const void *from, size_t len);
>  extern void *__memcpy(void *to, const void *from, size_t len);
>  
> +#define __HAVE_ARCH_MEMCHR
> +extern void *memchr(const void *cs, int c, size_t length);
> +
>  #define __HAVE_ARCH_MEMSET
>  void *memset(void *s, int c, size_t n);
>  void *__memset(void *s, int c, size_t n);
> diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
> index f76747862..4d530e559 100644
> --- a/arch/x86/lib/Makefile
> +++ b/arch/x86/lib/Makefile
> @@ -69,5 +69,6 @@ else
>          lib-y += clear_page_64.o copy_page_64.o
>          lib-y += memmove_64.o memset_64.o
>          lib-y += copy_user_64.o
> +        lib-y += string_64.o
>  	lib-y += cmpxchg16b_emu.o
>  endif
> diff --git a/arch/x86/lib/string_64.c b/arch/x86/lib/string_64.c
> new file mode 100644
> index 000000000..4e067d5be
> --- /dev/null
> +++ b/arch/x86/lib/string_64.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/string.h>
> +#include <linux/export.h>
> +#include <linux/align.h>
> +
> +/* How many bytes are loaded each iteration of the word copy loop */
> +#define LBLOCKSIZE (sizeof(long))
> +
> +#ifdef __HAVE_ARCH_MEMCHR
> +
> +void *memchr(const void *cs, int c, size_t length)
> +{
> +	const unsigned char *src = (const unsigned char *)cs, d = c;

I don't know why this 'd = c' is not error.
d is a char pointer and c is int. At least this is not safe me do not know.

> +	while (!IS_ALIGNED((long)src, sizeof(long))) {
> +		if (!length--)
> +			return NULL;
> +		if (*src == d)

Compare a character value to a pointer value and this value is c.
May be right do not know.

Or:

char d = c;
...

> +			return (void *)src;
> +		src++;
> +	}
> +	if (length >= LBLOCKSIZE) {
> +		unsigned long mask = d << 8 | d;
> +		unsigned int i = 32;
> +		long xor, data;
> +		const long consta = 0xFEFEFEFEFEFEFEFF,
> +			   constb = 0x8080808080808080;

Two magic number..

> +		/*
> +		 * Create a 8-bytes mask for word-wise comparing.
> +		 * For example, a mask for 'a' is 0x6161616161616161.
> +		 */
> +
> +		mask |= mask << 16;
> +		for (i = 32; i < LBLOCKSIZE * 8; i <<= 1)
> +			mask |= mask << i;
> +		/*
> +		 * We perform word-wise comparing with following operation:
> +		 *	1. Perform xor on the long word @src and @mask
> +		 *	   and put into @xor.
> +		 *	2. Add @xor with @consta.
> +		 *	3. ~@xor & @constb.
> +		 *	4. Perform & with the result of step 2 and 3.
> +		 *
> +		 * Step 1 creates a byte which is 0 in the long word if
> +		 * there is at least one target byte in it.
> +		 *
> +		 * Step 2 to Step 4 find if there is a byte with 0 in
> +		 * the long word.
> +		 */
> +		asm volatile("1:\n\t"
> +			     "movq (%0),%1\n\t"
> +			     "xorq %6,%1\n\t"
> +			     "lea (%1,%4), %2\n\t"
> +			     "notq %1\n\t"
> +			     "andq %5,%1\n\t"
> +			     "testq %1,%2\n\t"
> +			     "jne 2f\n\t"

s/jne/jnz/

Lack much here from me. But I give example that should check the 
CF flag is zero.

1) contain matching byte.

1111111011111111(consta)
                        +add
0000000001101100(xor)
------------------------
1111111101101011 (%1)


1111111110010100(~xor)
                        &and
1000000010000000(constb)
------------------------
1000000010000000 (%2)


the logical and of %1 and %2 is
1000000000000000 that is not zero.

2) not contain matching byte

1111111011111111
                 +
0110111011011100
----------------
0110110111011011(%1)

1001000100100011
                 &
1000000010000000
----------------
1000000000000000(%2)

%1 and %2 is
0000000000000000 that is zero.

I guess that here should use jump instruction jnz instead.
Even though, I do not know why that two magic number is so magical..

Thanks,
Tao
> +			     "add $8,%0\n\t"
> +			     "sub $8,%3\n\t"
> +			     "cmp $7,%3\n\t"
> +			     "ja 1b\n\t"
> +			     "2:\n\t"
> +			     : "=D"(src), "=r"(xor), "=r"(data), "=r"(length)
> +			     : "r"(consta), "r"(constb), "r"(mask), "0"(src),
> +			       "1"(xor), "2"(data), "3"(length)
> +			     : "memory", "cc");
> +	}
> +
> +	while (length--) {
> +		if (*src == d)
> +			return (void *)src;
> +		src++;
> +	}
> +	return NULL;
> +}
> +EXPORT_SYMBOL(memchr);
> +#endif
> -- 
> 2.25.1
> 
