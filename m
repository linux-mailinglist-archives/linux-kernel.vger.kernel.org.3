Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60838585F7B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 17:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbiGaPXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 11:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbiGaPXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 11:23:43 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAB7DEC6
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 08:23:42 -0700 (PDT)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4LwlQP5ryBzDsRs;
        Sun, 31 Jul 2022 15:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1659281022; bh=KGSz7KHTmljNTcL0jll5cj7goyNUL4TDtN7lur63tCY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=b6p9PSd04g39vYCAP0BxMrNd02/32kKKR0yw7n509zvwKeb349GU1tJMBP5O8jMqL
         unTZZwy56yb/BDJrvgV1jAdCnLwfxdFV15CP4D2YAdCfgw6QnomVTz9e7qMY2UbDvl
         tBFg2bw16e10t0OG7GOEmnIHlGVPVtlZ5EE5TQyw=
X-Riseup-User-ID: 40A8A15C2D2551162AB75E94F831D440DCE770F961B58DBE736E48287AE1255E
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4LwlQJ5KXSz1yWm;
        Sun, 31 Jul 2022 15:23:36 +0000 (UTC)
Message-ID: <b6b20883-3fe7-9a5d-ab55-b5a61cef996c@riseup.net>
Date:   Sun, 31 Jul 2022 12:23:33 -0300
MIME-Version: 1.0
Subject: Re: [PATCH v5 4/5] lib/test: introduce cpumask KUnit test suite
Content-Language: en-US
To:     Sander Vanheule <sander@svanheule.net>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Gow <davidgow@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Yury Norov <yury.norov@gmail.com>
References: <cover.1659077534.git.sander@svanheule.net>
 <85217b5de6d62257313ad7fde3e1969421acad75.1659077534.git.sander@svanheule.net>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <85217b5de6d62257313ad7fde3e1969421acad75.1659077534.git.sander@svanheule.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sander

On 7/29/22 04:01, Sander Vanheule wrote:
> Add a basic suite of tests for cpumask, providing some tests for empty and
> completely filled cpumasks.
> 
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Maíra Canal <mairacanal@riseup.net>
> ---
> Changes since v4:
> - Belated addition of Yury's Suggested-by:
> - Follow KUnit style more closely
> - Drop full check on cpu_possible_mask
> - Update last check on cpu_possible_mask
> - Log masks when starting test
> - Update commit message 
>   
> Changes since v3:
> - Test for_each_cpu*() over empty mask and cpu_possible_mask
> - Add Andy's Reviewed-by
> - Use num_{online,present,possible}_cpus() for builtin masks
> - Guard against CPU hotplugging during test for dynamic builtin CPU masks
>  
> Changes since v2:
> - Rework for_each_* test macros, as suggested by Yury
> 
> Changes since v1:
> - New patch
> 
>  lib/Kconfig.debug  |  12 ++++
>  lib/Makefile       |   1 +
>  lib/cpumask_test.c | 147 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 160 insertions(+)
>  create mode 100644 lib/cpumask_test.c
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 2e24db4bff19..e85e74646178 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2021,6 +2021,18 @@ config LKDTM
>  	Documentation on how to use the module can be found in
>  	Documentation/fault-injection/provoke-crashes.rst
>  
> +config CPUMASK_KUNIT_TEST
> +	tristate "KUnit test for cpumask" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  Enable to turn on cpumask tests, running at boot or module load time.
> +
> +	  For more information on KUnit and unit tests in general, please refer
> +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +	  If unsure, say N.
> +
>  config TEST_LIST_SORT
>  	tristate "Linked list sorting test" if !KUNIT_ALL_TESTS
>  	depends on KUNIT
> diff --git a/lib/Makefile b/lib/Makefile
> index bcc7e8ea0cde..9f9db1376538 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -59,6 +59,7 @@ obj-$(CONFIG_TEST_BPF) += test_bpf.o
>  obj-$(CONFIG_TEST_FIRMWARE) += test_firmware.o
>  obj-$(CONFIG_TEST_BITOPS) += test_bitops.o
>  CFLAGS_test_bitops.o += -Werror
> +obj-$(CONFIG_CPUMASK_KUNIT_TEST) += cpumask_test.o
>  obj-$(CONFIG_TEST_SYSCTL) += test_sysctl.o
>  obj-$(CONFIG_TEST_SIPHASH) += test_siphash.o
>  obj-$(CONFIG_HASH_KUNIT_TEST) += test_hash.o
> diff --git a/lib/cpumask_test.c b/lib/cpumask_test.c
> new file mode 100644
> index 000000000000..0f8059a5e93b
> --- /dev/null
> +++ b/lib/cpumask_test.c

In order to make the tests at lib/ with more compliant naming, it would
make more sense to name it test_cpumask.c.

Thank you for the respin to the series! All tests are passing now.

Tested-by: Maíra Canal <mairacanal@riseup.net>

Best Regards,
- Maíra Canal

> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * KUnit tests for cpumask.
> + *
> + * Author: Sander Vanheule <sander@svanheule.net>
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +
> +#define EXPECT_FOR_EACH_CPU_EQ(test, mask)			\
> +	do {							\
> +		const cpumask_t *m = (mask);			\
> +		int mask_weight = cpumask_weight(m);		\
> +		int cpu, iter = 0;				\
> +		for_each_cpu(cpu, m)				\
> +			iter++;					\
> +		KUNIT_EXPECT_EQ((test), mask_weight, iter);	\
> +	} while (0)
> +
> +#define EXPECT_FOR_EACH_CPU_NOT_EQ(test, mask)					\
> +	do {									\
> +		const cpumask_t *m = (mask);					\
> +		int mask_weight = cpumask_weight(m);				\
> +		int cpu, iter = 0;						\
> +		for_each_cpu_not(cpu, m)					\
> +			iter++;							\
> +		KUNIT_EXPECT_EQ((test), nr_cpu_ids - mask_weight, iter);	\
> +	} while (0)
> +
> +#define EXPECT_FOR_EACH_CPU_WRAP_EQ(test, mask)			\
> +	do {							\
> +		const cpumask_t *m = (mask);			\
> +		int mask_weight = cpumask_weight(m);		\
> +		int cpu, iter = 0;				\
> +		for_each_cpu_wrap(cpu, m, nr_cpu_ids / 2)	\
> +			iter++;					\
> +		KUNIT_EXPECT_EQ((test), mask_weight, iter);	\
> +	} while (0)
> +
> +#define EXPECT_FOR_EACH_CPU_BUILTIN_EQ(test, name)		\
> +	do {							\
> +		int mask_weight = num_##name##_cpus();		\
> +		int cpu, iter = 0;				\
> +		for_each_##name##_cpu(cpu)			\
> +			iter++;					\
> +		KUNIT_EXPECT_EQ((test), mask_weight, iter);	\
> +	} while (0)
> +
> +static cpumask_t mask_empty;
> +static cpumask_t mask_all;
> +
> +#define STR_MASK(m)			#m
> +#define TEST_CPUMASK_PRINT(test, mask)	\
> +	kunit_info(test, "%s = '%*pbl'\n", STR_MASK(mask), nr_cpumask_bits, cpumask_bits(mask))
> +
> +static void test_cpumask_weight(struct kunit *test)
> +{
> +	KUNIT_EXPECT_TRUE(test, cpumask_empty(&mask_empty));
> +	KUNIT_EXPECT_TRUE(test, cpumask_full(&mask_all));
> +
> +	KUNIT_EXPECT_EQ(test, 0, cpumask_weight(&mask_empty));
> +	KUNIT_EXPECT_EQ(test, nr_cpu_ids, cpumask_weight(cpu_possible_mask));
> +	KUNIT_EXPECT_EQ(test, nr_cpumask_bits, cpumask_weight(&mask_all));
> +}
> +
> +static void test_cpumask_first(struct kunit *test)
> +{
> +	KUNIT_EXPECT_LE(test, nr_cpu_ids, cpumask_first(&mask_empty));
> +	KUNIT_EXPECT_EQ(test, 0, cpumask_first(cpu_possible_mask));
> +
> +	KUNIT_EXPECT_EQ(test, 0, cpumask_first_zero(&mask_empty));
> +	KUNIT_EXPECT_LE(test, nr_cpu_ids, cpumask_first_zero(cpu_possible_mask));
> +}
> +
> +static void test_cpumask_last(struct kunit *test)
> +{
> +	KUNIT_EXPECT_LE(test, nr_cpumask_bits, cpumask_last(&mask_empty));
> +	KUNIT_EXPECT_EQ(test, nr_cpu_ids - 1, cpumask_last(cpu_possible_mask));
> +}
> +
> +static void test_cpumask_next(struct kunit *test)
> +{
> +	KUNIT_EXPECT_EQ(test, 0, cpumask_next_zero(-1, &mask_empty));
> +	KUNIT_EXPECT_LE(test, nr_cpu_ids, cpumask_next_zero(-1, cpu_possible_mask));
> +
> +	KUNIT_EXPECT_LE(test, nr_cpu_ids, cpumask_next(-1, &mask_empty));
> +	KUNIT_EXPECT_EQ(test, 0, cpumask_next(-1, cpu_possible_mask));
> +}
> +
> +static void test_cpumask_iterators(struct kunit *test)
> +{
> +	EXPECT_FOR_EACH_CPU_EQ(test, &mask_empty);
> +	EXPECT_FOR_EACH_CPU_NOT_EQ(test, &mask_empty);
> +	EXPECT_FOR_EACH_CPU_WRAP_EQ(test, &mask_empty);
> +
> +	EXPECT_FOR_EACH_CPU_EQ(test, cpu_possible_mask);
> +	EXPECT_FOR_EACH_CPU_NOT_EQ(test, cpu_possible_mask);
> +	EXPECT_FOR_EACH_CPU_WRAP_EQ(test, cpu_possible_mask);
> +}
> +
> +static void test_cpumask_iterators_builtin(struct kunit *test)
> +{
> +	EXPECT_FOR_EACH_CPU_BUILTIN_EQ(test, possible);
> +
> +	/* Ensure the dynamic masks are stable while running the tests */
> +	cpu_hotplug_disable();
> +
> +	TEST_CPUMASK_PRINT(test, cpu_online_mask);
> +	TEST_CPUMASK_PRINT(test, cpu_present_mask);
> +
> +	EXPECT_FOR_EACH_CPU_BUILTIN_EQ(test, online);
> +	EXPECT_FOR_EACH_CPU_BUILTIN_EQ(test, present);
> +
> +	cpu_hotplug_enable();
> +}
> +
> +static int test_cpumask_init(struct kunit *test)
> +{
> +	cpumask_clear(&mask_empty);
> +	cpumask_setall(&mask_all);
> +
> +	TEST_CPUMASK_PRINT(test, &mask_all);
> +	TEST_CPUMASK_PRINT(test, cpu_possible_mask);
> +
> +	return 0;
> +}
> +
> +static struct kunit_case test_cpumask_cases[] = {
> +	KUNIT_CASE(test_cpumask_weight),
> +	KUNIT_CASE(test_cpumask_first),
> +	KUNIT_CASE(test_cpumask_last),
> +	KUNIT_CASE(test_cpumask_next),
> +	KUNIT_CASE(test_cpumask_iterators),
> +	KUNIT_CASE(test_cpumask_iterators_builtin),
> +	{}
> +};
> +
> +static struct kunit_suite test_cpumask_suite = {
> +	.name = "cpumask",
> +	.init = test_cpumask_init,
> +	.test_cases = test_cpumask_cases,
> +};
> +kunit_test_suite(test_cpumask_suite);
> +
> +MODULE_LICENSE("GPL");
