Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439A350475A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 11:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbiDQJSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 05:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbiDQJSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 05:18:22 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DD22A277;
        Sun, 17 Apr 2022 02:15:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VAELPyY_1650186943;
Received: from 192.168.193.180(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0VAELPyY_1650186943)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 17 Apr 2022 17:15:43 +0800
Message-ID: <e1563d18-36d7-08b2-762c-def7021d1382@linux.alibaba.com>
Date:   Sun, 17 Apr 2022 02:15:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] lkdtm: Add CFI_BACKWARD to test ROP mitigations
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20220416001103.1524653-1-keescook@chromium.org>
From:   Dan Li <ashimida@linux.alibaba.com>
In-Reply-To: <20220416001103.1524653-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/15/22 17:11, Kees Cook wrote:
> In order to test various backward-edge control flow integrity methods,
> add a test that manipulates the return address on the stack. Currently
> only arm64 Pointer Authentication and Shadow Call Stack is supported.
> 
>   $ echo CFI_BACKWARD | cat >/sys/kernel/debug/provoke-crash/DIRECT
> 
> Under SCS, successful test of the mitigation is reported as:
> 
>   lkdtm: Performing direct entry CFI_BACKWARD
>   lkdtm: Attempting unchecked stack return address redirection ...
>   lkdtm: ok: redirected stack return address.
>   lkdtm: Attempting checked stack return address redirection ...
>   lkdtm: ok: control flow unchanged.
> 
> Under PAC, successful test of the mitigation is reported by the PAC
> exception handler:
> 
>   lkdtm: Performing direct entry CFI_BACKWARD
>   lkdtm: Attempting unchecked stack return address redirection ...
>   lkdtm: ok: redirected stack return address.
>   lkdtm: Attempting checked stack return address redirection ...
>   Unable to handle kernel paging request at virtual address bfffffc0088d0514
>   Mem abort info:
>     ESR = 0x86000004
>     EC = 0x21: IABT (current EL), IL = 32 bits
>     SET = 0, FnV = 0
>     EA = 0, S1PTW = 0
>     FSC = 0x04: level 0 translation fault
>   [bfffffc0088d0514] address between user and kernel address ranges
>   ...
> 
> If the CONFIGs are missing (or the mitigation isn't working), failure
> is reported as:
> 
>   lkdtm: Performing direct entry CFI_BACKWARD
>   lkdtm: Attempting unchecked stack return address redirection ...
>   lkdtm: ok: redirected stack return address.
>   lkdtm: Attempting checked stack return address redirection ...
>   lkdtm: FAIL: stack return address was redirected!
>   lkdtm: This is probably expected, since this kernel was built *without* CONFIG_ARM64_PTR_AUTH_KERNEL=y nor CONFIG_SHADOW_CALL_STACK=y
> 
> Co-developed-by: Dan Li <ashimida@linux.alibaba.com>
> Signed-off-by: Dan Li <ashimida@linux.alibaba.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v1: https://lore.kernel.org/lkml/20220413213917.711770-1-keescook@chromium.org
> v2:
>   - add PAGE_OFFSET setting for PAC bits (Dan Li)
> ---
>   drivers/misc/lkdtm/cfi.c                | 134 ++++++++++++++++++++++++
>   tools/testing/selftests/lkdtm/tests.txt |   1 +
>   2 files changed, 135 insertions(+)
> 
> diff --git a/drivers/misc/lkdtm/cfi.c b/drivers/misc/lkdtm/cfi.c
> index e88f778be0d5..804965a480b7 100644
> --- a/drivers/misc/lkdtm/cfi.c
> +++ b/drivers/misc/lkdtm/cfi.c
> @@ -3,6 +3,7 @@
>    * This is for all the tests relating directly to Control Flow Integrity.
>    */
>   #include "lkdtm.h"
> +#include <asm/page.h>
>   
>   static int called_count;
>   
> @@ -42,8 +43,141 @@ static void lkdtm_CFI_FORWARD_PROTO(void)
>   	pr_expected_config(CONFIG_CFI_CLANG);
>   }
>   
> +/*
> + * This can stay local to LKDTM, as there should not be a production reason
> + * to disable PAC && SCS.
> + */
> +#ifdef CONFIG_ARM64_PTR_AUTH_KERNEL
> +# ifdef CONFIG_ARM64_BTI_KERNEL
> +#  define __no_pac             "branch-protection=bti"
> +# else
> +#  define __no_pac             "branch-protection=none"
> +# endif
> +# define __no_ret_protection   __noscs __attribute__((__target__(__no_pac)))
> +#else
> +# define __no_ret_protection   __noscs
> +#endif
> +
> +#define no_pac_addr(addr)      \
> +	((__force __typeof__(addr))((__force u64)(addr) | PAGE_OFFSET))
> +
> +/* The ultimate ROP gadget. */
> +static noinline __no_ret_protection
> +void set_return_addr_unchecked(unsigned long *expected, unsigned long *addr)
> +{
> +	/* Use of volatile is to make sure final write isn't seen as a dead store. */
> +	unsigned long * volatile *ret_addr = (unsigned long **)__builtin_frame_address(0) + 1;
> +
> +	/* Make sure we've found the right place on the stack before writing it. */
> +	if (no_pac_addr(*ret_addr) == expected)
> +		*ret_addr = (addr);
> +	else
> +		/* Check architecture, stack layout, or compiler behavior... */
> +		pr_warn("Eek: return address mismatch! %px != %px\n",
> +			*ret_addr, addr);
> +}
> +
> +static noinline
> +void set_return_addr(unsigned long *expected, unsigned long *addr)
> +{
> +	/* Use of volatile is to make sure final write isn't seen as a dead store. */
> +	unsigned long * volatile *ret_addr = (unsigned long **)__builtin_frame_address(0) + 1;
> +
> +	/* Make sure we've found the right place on the stack before writing it. */
> +	if (no_pac_addr(*ret_addr) == expected)
> +		*ret_addr = (addr);
> +	else
> +		/* Check architecture, stack layout, or compiler behavior... */
> +		pr_warn("Eek: return address mismatch! %px != %px\n",
> +			*ret_addr, addr);
> +}
> +
> +static volatile int force_check;
> +
> +static void lkdtm_CFI_BACKWARD(void)
> +{
> +	/* Use calculated gotos to keep labels addressable. */
> +	void *labels[] = {0, &&normal, &&redirected, &&check_normal, &&check_redirected};
> +
> +	pr_info("Attempting unchecked stack return address redirection ...\n");
> +
> +	/* Always false */
> +	if (force_check) {
> +		/*
> +		 * Prepare to call with NULLs to avoid parameters being treated as
> +		 * constants in -02.
> +		 */
> +		set_return_addr_unchecked(NULL, NULL);
> +		set_return_addr(NULL, NULL);
> +		if (force_check)
> +			goto *labels[1];
> +		if (force_check)
> +			goto *labels[2];
> +		if (force_check)
> +			goto *labels[3];
> +		if (force_check)
> +			goto *labels[4];
> +		return;
> +	}
> +
> +	/*
> +	 * Use fallthrough switch case to keep basic block ordering between
> +	 * set_return_addr*() and the label after it.
> +	 */
> +	switch (force_check) {
> +	case 0:
> +		set_return_addr_unchecked(&&normal, &&redirected);
> +		fallthrough;
> +	case 1:
> +normal:
> +		/* Always true */
> +		if (!force_check) {
> +			pr_err("FAIL: stack return address manipulation failed!\n");
> +			/* If we can't redirect "normally", we can't test mitigations. */
> +			return;
> +		}
> +		break;
> +	default:
> +redirected:
> +		pr_info("ok: redirected stack return address.\n");
> +		break;
> +	}
> +
> +	pr_info("Attempting checked stack return address redirection ...\n");
> +
> +	switch (force_check) {
> +	case 0:
> +		set_return_addr(&&check_normal, &&check_redirected);
> +		fallthrough;
> +	case 1:
> +check_normal:
> +		/* Always true */
> +		if (!force_check) {
> +			pr_info("ok: control flow unchanged.\n");
> +			return;
> +		}
> +
> +check_redirected:
> +		pr_err("FAIL: stack return address was redirected!\n");
> +		break;
> +	}
> +
> +	if (IS_ENABLED(CONFIG_ARM64_PTR_AUTH_KERNEL)) {
> +		pr_expected_config(CONFIG_ARM64_PTR_AUTH_KERNEL);
> +		return;
> +	}
> +	if (IS_ENABLED(CONFIG_SHADOW_CALL_STACK)) {
> +		pr_expected_config(CONFIG_SHADOW_CALL_STACK);
> +		return;
> +	}
> +	pr_warn("This is probably expected, since this %s was built *without* %s=y nor %s=y\n",
> +		lkdtm_kernel_info,
> +		"CONFIG_ARM64_PTR_AUTH_KERNEL", "CONFIG_SHADOW_CALL_STACK");
> +}
> +
>   static struct crashtype crashtypes[] = {
>   	CRASHTYPE(CFI_FORWARD_PROTO),
> +	CRASHTYPE(CFI_BACKWARD),
>   };
>   
>   struct crashtype_category cfi_crashtypes = {
> diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
> index 243c781f0780..9dace01dbf15 100644
> --- a/tools/testing/selftests/lkdtm/tests.txt
> +++ b/tools/testing/selftests/lkdtm/tests.txt
> @@ -74,6 +74,7 @@ USERCOPY_STACK_BEYOND
>   USERCOPY_KERNEL
>   STACKLEAK_ERASING OK: the rest of the thread stack is properly erased
>   CFI_FORWARD_PROTO
> +CFI_BACKWARD call trace:|ok: control flow unchanged
>   FORTIFIED_STRSCPY
>   FORTIFIED_OBJECT
>   FORTIFIED_SUBOBJECT


Compiling with gcc/llvm 12 on aarch64 platform with scs/pac enabled
respectively, all four cases work fine for me :)
