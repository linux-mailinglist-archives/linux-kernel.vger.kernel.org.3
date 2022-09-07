Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CCF5AFA85
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 05:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiIGDT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 23:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiIGDTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 23:19:53 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4313E15FF7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 20:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662520790; x=1694056790;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RAcEtiEwWb9QLnBtlHAEAi1539PX2fBlXv8J0Kty2F0=;
  b=DZAdM2nkm7VU/55HzZ1Qj0Knv78VimbjuyJV4qJzqNiY+fL9ciyRATcG
   bEiNcw4V4wcz7MijkZrBnRN4MVdPSoYDtCSazDWgL55Z9HV7r29fZaTKK
   C9BwxLmsg3PzZZIfL6iWeil5Co8WFboQUIgdddpoFzy7MhncnZBhdzvcN
   H2FD97EDHhNeleP25DGO/ZvK5pDZmTpw5T1xsJiAOs8AmstzmCQYbZIEi
   YOSjzFWAMyd1gC71DgQvRIlbTDGZY/nOAJntd0W50nbTx4ktHwiuNjRkF
   ZGTk+jYelWq9mlXfuvjzdinPPF3vtAnXMTv+1ohIl+6uoOFA0VczqgW1P
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="279780677"
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="279780677"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 20:19:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="789903282"
Received: from sqa-gate.sh.intel.com (HELO robert-ivt.tsp.org) ([10.239.48.212])
  by orsmga005.jf.intel.com with ESMTP; 06 Sep 2022 20:19:45 -0700
Message-ID: <e8f01902b5c08eda4431890bbd907bcd12377161.camel@linux.intel.com>
Subject: Re: [PATCHv8 09/11] selftests/x86/lam: Add mmap and SYSCALL test
 cases for linear-address masking
From:   Robert Hoo <robert.hu@linux.intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Weihong Zhang <weihong.zhang@intel.com>
Date:   Wed, 07 Sep 2022 11:19:45 +0800
In-Reply-To: <20220830010104.1282-10-kirill.shutemov@linux.intel.com>
References: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
         <20220830010104.1282-10-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-08-30 at 04:01 +0300, Kirill A. Shutemov wrote:
> From: Weihong Zhang <weihong.zhang@intel.com>
> 
> Add mmap and SYSCALL test cases.
> 
> SYSCALL test cases:
> 
>  - LAM supports set metadata in high bits 62:57 (LAM_U57) of a user
> pointer, pass
>    the pointer to SYSCALL, SYSCALL can dereference the pointer and
> return correct
>    result.
> 
>  - Disable LAM, pass a pointer with metadata in high bits to SYSCALL,
>    SYSCALL returns -1 (EFAULT).
> 
> MMAP test cases:
> 
>  - Enable LAM_U57, MMAP with low address (below bits 47), set
> metadata
>    in high bits of the address, dereference the address should be
>    allowed.
> 
>  - Enable LAM_U57, MMAP with high address (above bits 47), set
> metadata
>    in high bits of the address, dereference the address should be
>    allowed.
> 
> Signed-off-by: Weihong Zhang <weihong.zhang@intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  tools/testing/selftests/x86/lam.c | 135
> +++++++++++++++++++++++++++++-
>  1 file changed, 132 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/x86/lam.c
> b/tools/testing/selftests/x86/lam.c
> index 900a3a0fb709..b88e007ee0a3 100644
> --- a/tools/testing/selftests/x86/lam.c
> +++ b/tools/testing/selftests/x86/lam.c
> @@ -7,6 +7,7 @@
>  #include <signal.h>
>  #include <setjmp.h>
>  #include <sys/mman.h>
> +#include <sys/utsname.h>
>  #include <sys/wait.h>
>  #include <inttypes.h>
>  
> @@ -29,11 +30,18 @@
>  /* Specified test function bits */
>  #define FUNC_MALLOC             0x1
>  #define FUNC_BITS               0x2
> +#define FUNC_MMAP               0x4
> +#define FUNC_SYSCALL            0x8
>  
> -#define TEST_MASK               0x3
> +#define TEST_MASK               0xf
> +
> +#define LOW_ADDR                (0x1UL << 30)
> +#define HIGH_ADDR               (0x3UL << 48)
>  
>  #define MALLOC_LEN              32
>  
> +#define PAGE_SIZE               (4 << 10)
> +
>  struct testcases {
>  	unsigned int later;
>  	int expected; /* 2: SIGSEGV Error; 1: other errors */
> @@ -49,6 +57,7 @@ jmp_buf segv_env;
>  static void segv_handler(int sig)
>  {
>  	ksft_print_msg("Get segmentation fault(%d).", sig);
> +
>  	siglongjmp(segv_env, 1);
>  }
>  
> @@ -61,6 +70,16 @@ static inline int cpu_has_lam(void)
>  	return (cpuinfo[0] & (1 << 26));
>  }
>  
> +/* Check 5-level page table feature in CPUID.(EAX=07H,
> ECX=00H):ECX.[bit 16] */
> +static inline int cpu_has_la57(void)
> +{
> +	unsigned int cpuinfo[4];
> +
> +	__cpuid_count(0x7, 0, cpuinfo[0], cpuinfo[1], cpuinfo[2],
> cpuinfo[3]);
> +
> +	return (cpuinfo[2] & (1 << 16));
> +}
> +
>  /*
>   * Set tagged address and read back untag mask.
>   * check if the untagged mask is expected.
> @@ -213,6 +232,68 @@ static int handle_malloc(struct testcases *test)
>  	return ret;
>  }
>  
> +static int handle_mmap(struct testcases *test)
> +{
> +	void *ptr;
> +	unsigned int flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED;
> +	int ret = 0;
> +
> +	if (test->later == 0 && test->lam != 0)
> +		if (set_lam(test->lam) != 0)
> +			return 1;
> +
> +	ptr = mmap((void *)test->addr, PAGE_SIZE, PROT_READ |
> PROT_WRITE,
> +		   flags, -1, 0);
> +	if (ptr == MAP_FAILED) {
> +		if (test->addr == HIGH_ADDR)
> +			if (!cpu_has_la57())
> +				return 3; /* unsupport LA57 */

I think here return 3 to indicate skip cases.

Perhaps you can enable skip case like this? Just FYI, I'm not familiar
with selftests yet.

@@ -321,8 +323,10 @@ static int handle_mmap(struct testcases *test)
                   flags, -1, 0);
        if (ptr == MAP_FAILED) {
                if (test->addr == HIGH_ADDR)
-                       if (!cpu_has_la57())
+                       if (!cpu_has_la57()) {
+                               perror("Unsupport LA57. Skip");
                                return 3; /* unsupport LA57 */
+                       }
                return 1;
        }
 
@@ -746,12 +750,16 @@ static void run_test(struct testcases *test, int
count)
 
                /* fork a process to run test case */
                ret = fork_test(t);
+               tests_cnt++;
+               if (ret == 3) {
+                       ksft_test_result_skip(t->msg);
+                       continue;
+               }
                if (ret != 0)
                        ret = (t->expected == ret);
                else
                        ret = !(t->expected);
 
-               tests_cnt++;
                ksft_test_result(ret, t->msg);
        }
 }

> +		return 1;
> +	}
> +
> +	if (test->later != 0 && test->lam != 0)
> +		if (set_lam(test->lam) != 0)
> +			ret = 1;
> +
> +	if (ret == 0) {
> +		if (sigsetjmp(segv_env, 1) == 0) {
> +			signal(SIGSEGV, segv_handler);
> +			ret = handle_lam_test(ptr, test->lam);
> +		} else {
> +			ret = 2;
> +		}
> +	}
> +
> +	munmap(ptr, PAGE_SIZE);
> +	return ret;
> +}
> +
> +static int handle_syscall(struct testcases *test)
> +{
> +	struct utsname unme, *pu;
> +	int ret = 0;
> +
> +	if (test->later == 0 && test->lam != 0)
> +		if (set_lam(test->lam) != 0)
> +			return 1;
> +
> +	if (sigsetjmp(segv_env, 1) == 0) {
> +		signal(SIGSEGV, segv_handler);
> +		pu = (struct utsname *)set_metadata((uint64_t)&unme,
> test->lam);
> +		ret = uname(pu);
> +		if (ret < 0)
> +			ret = 1;
> +	} else {
> +		ret = 2;
> +	}
> +
> +	if (test->later != 0 && test->lam != 0)
> +		if (set_lam(test->lam) != -1 && ret == 0)
> +			ret = 1;
> +
> +	return ret;
> +}
> +
>  static int fork_test(struct testcases *test)
>  {
>  	int ret, child_ret;
> @@ -268,7 +349,6 @@ static struct testcases malloc_cases[] = {
>  	},
>  };
>  
> -
>  static struct testcases bits_cases[] = {
>  	{
>  		.test_func = handle_max_bits,
> @@ -276,11 +356,54 @@ static struct testcases bits_cases[] = {
>  	},
>  };
>  
> +static struct testcases syscall_cases[] = {
> +	{
> +		.later = 0,
> +		.lam = LAM_U57_BITS,
> +		.test_func = handle_syscall,
> +		.msg = "SYSCALL: LAM_U57. syscall with metadata\n",
> +	},
> +	{
> +		.later = 1,
> +		.expected = 1,
> +		.lam = LAM_U57_BITS,
> +		.test_func = handle_syscall,
> +		.msg = "SYSCALL:[Negative] Disable LAM. Dereferencing
> pointer with metadata.\n",
> +	},
> +};
> +
> +static struct testcases mmap_cases[] = {
> +	{
> +		.later = 1,
> +		.expected = 0,
> +		.lam = LAM_U57_BITS,
> +		.addr = HIGH_ADDR,
> +		.test_func = handle_mmap,
> +		.msg = "MMAP: First mmap high address, then set
> LAM_U57.\n",
> +	},
> +	{
> +		.later = 0,
> +		.expected = 0,
> +		.lam = LAM_U57_BITS,
> +		.addr = HIGH_ADDR,
> +		.test_func = handle_mmap,
> +		.msg = "MMAP: First LAM_U57, then High address.\n",
> +	},
> +	{
> +		.later = 0,
> +		.expected = 0,
> +		.lam = LAM_U57_BITS,
> +		.addr = LOW_ADDR,
> +		.test_func = handle_mmap,
> +		.msg = "MMAP: First LAM_U57, then Low address.\n",
> +	},
> +};
> +
>  static void cmd_help(void)
>  {
>  	printf("usage: lam [-h] [-t test list]\n");
>  	printf("\t-t test list: run tests specified in the test list,
> default:0x%x\n", TEST_MASK);
> -	printf("\t\t0x1:malloc; 0x2:max_bits;\n");
> +	printf("\t\t0x1:malloc; 0x2:max_bits; 0x4:mmap;
> 0x8:syscall.\n");
>  	printf("\t-h: help\n");
>  }
>  
> @@ -320,6 +443,12 @@ int main(int argc, char **argv)
>  	if (tests & FUNC_BITS)
>  		run_test(bits_cases, ARRAY_SIZE(bits_cases));
>  
> +	if (tests & FUNC_MMAP)
> +		run_test(mmap_cases, ARRAY_SIZE(mmap_cases));
> +
> +	if (tests & FUNC_SYSCALL)
> +		run_test(syscall_cases, ARRAY_SIZE(syscall_cases));
> +
>  	ksft_set_plan(tests_cnt);
>  
>  	return ksft_exit_pass();

