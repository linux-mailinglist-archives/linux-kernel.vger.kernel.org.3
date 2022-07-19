Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A16157A901
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 23:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237621AbiGSVbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 17:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbiGSVb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 17:31:29 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6658630F5D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 14:31:28 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4LnX8H2wRszDqJC;
        Tue, 19 Jul 2022 21:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1658266287; bh=IlR+h/k5M7ni97DzaWmb98C/43FMVa2bu1mpMGL2Yg0=;
        h=Date:To:Cc:References:Subject:From:In-Reply-To:From;
        b=ROI8S71Oh1AtIa53Q2bb5+jStdbd+vWN4mdFsVuPji05dTmD1JsXMedHvQf9SML5O
         EcEE+awE7vvGfvmL3UiAF65QM0+uINXO4Z6XkZOswypcCWX/0U4FNy8LX1qqAHGC1o
         rumrtECTKnw6b36TWf2UaXVk296qY6k9h/SyzQEs=
X-Riseup-User-ID: 92D2031C7E6A103CD5F2C7998F5AD7BA4864E866230F130EF1B1504D5A920505
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4LnX890Nl8z5vk8;
        Tue, 19 Jul 2022 21:31:20 +0000 (UTC)
Message-ID: <346cb279-8e75-24b0-7d12-9803f2b41c73@riseup.net>
Date:   Tue, 19 Jul 2022 18:31:17 -0300
MIME-Version: 1.0
To:     sander@svanheule.net
Cc:     akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        bp@alien8.de, dave.hansen@linux.intel.com, elver@google.com,
        gregkh@linuxfoundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, vschneid@redhat.com,
        x86@kernel.org, yury.norov@gmail.com,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>
References: <c96980ec35c3bd23f17c3374bf42c22971545e85.1656777646.git.sander@svanheule.net>
Subject: Re: [PATCH v4 3/5] lib/test: Introduce cpumask KUnit test suite
Content-Language: en-US
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <c96980ec35c3bd23f17c3374bf42c22971545e85.1656777646.git.sander@svanheule.net>
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

> Add a basic suite of tests for cpumask, providing some tests for empty
> and completely filled cpumasks.
> 
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The tests test_cpumask_weight and test_cpumask_last are failing on all
architectures, as can be seen on [1]. Also this test doesn't follow the
standard style for KUnit tests [2].

[1]
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220718/testrun/10865066/suite/kunit/tests/
[2] https://docs.kernel.org/dev-tools/kunit/style.html

CC: Brendan Higgins <brendanhiggins@google.com>
CC: David Gow <davidgow@google.com>

Best Regards,
- Maíra Canal

> ---
> 
> Notes:
>     Changes since v3:
>     - Test for_each_cpu*() over empty mask and cpu_possible_mask
>     - Add Andy's Reviewed-by
>     - Use num_{online,present,possible}_cpus() for builtin masks
>     - Guard against CPU hotplugging during test for dynamic builtin CPU masks
>     
>     Changes since v2:
>     - Rework for_each_* test macros, as suggested by Yury
>     
>     Changes since v1:
>     - New patch
> 
>  lib/Kconfig.debug  |   9 +++
>  lib/Makefile       |   1 +
>  lib/test_cpumask.c | 138 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 148 insertions(+)
>  create mode 100644 lib/test_cpumask.c
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 2e24db4bff19..04aaa20d50f9 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2021,6 +2021,15 @@ config LKDTM
>  	Documentation on how to use the module can be found in
>  	Documentation/fault-injection/provoke-crashes.rst
>  
> +config TEST_CPUMASK
> +	tristate "cpumask tests" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  Enable to turn on cpumask tests, running at boot or module load time.
> +
> +	  If unsure, say N.
> +
>  config TEST_LIST_SORT
>  	tristate "Linked list sorting test" if !KUNIT_ALL_TESTS
>  	depends on KUNIT
> diff --git a/lib/Makefile b/lib/Makefile
> index bcc7e8ea0cde..de3e47453fe8 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -99,6 +99,7 @@ obj-$(CONFIG_TEST_HMM) += test_hmm.o
>  obj-$(CONFIG_TEST_FREE_PAGES) += test_free_pages.o
>  obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
>  obj-$(CONFIG_TEST_REF_TRACKER) += test_ref_tracker.o
> +obj-$(CONFIG_TEST_CPUMASK) += test_cpumask.o
>  CFLAGS_test_fprobe.o += $(CC_FLAGS_FTRACE)
>  obj-$(CONFIG_FPROBE_SANITY_TEST) += test_fprobe.o
>  #
> diff --git a/lib/test_cpumask.c b/lib/test_cpumask.c
> new file mode 100644
> index 000000000000..a31a1622f1f6
> --- /dev/null
> +++ b/lib/test_cpumask.c
> @@ -0,0 +1,138 @@
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
> +static void test_cpumask_weight(struct kunit *test)
> +{
> +	KUNIT_EXPECT_TRUE(test, cpumask_empty(&mask_empty));
> +	KUNIT_EXPECT_TRUE(test, cpumask_full(cpu_possible_mask));
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
> +	KUNIT_EXPECT_EQ(test, nr_cpumask_bits - 1, cpumask_last(cpu_possible_mask));
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
> -- 
> 2.36.1


