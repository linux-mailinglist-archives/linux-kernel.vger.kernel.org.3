Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439E053D86A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240786AbiFDTeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241076AbiFDTca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:32:30 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2415D46
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:31:54 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id k6so5324321qkf.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 12:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2fcBIhRSy61bs3liml8wWElPXrakh/fpE9HDmmliLP4=;
        b=CUMxVZ2spntAvHs5dbmkEYv9xyXlH8i8buxlMk6b9S3FUTGaQQpWIyn1b2e8aj+yFh
         RLnrDS3YkQ7OuGbTHF1KPzxro52EllhPjR6Bz0clLyUE2jZ1dntiuawU82yww8FCL2UW
         ugTey8VrG+OCMeJ9g0jRX6/fpTHF+/TBmZX9NhGBmVANXbfKyeIfBZj6sVzkzLD67xAs
         kDiA76J7FgY8F68e+uOt9xSCcIkEIL6hNe1oYowAygR7e+Es7k+wuHU9yCxMq0iOlPK+
         Y3PsbO1dIp5gqquWeNgadl/0g3oJILfrLSH8LPd/X8tonNIxjQgXDLMRK75sx6HyCOXl
         pFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2fcBIhRSy61bs3liml8wWElPXrakh/fpE9HDmmliLP4=;
        b=gvJWUj2aqE8M3+JHm75Vr40B8UJUTtRgQ2wOgnzWqA/vPihO3JJUVG92BgVPxiopra
         9hYSbfL+uLRQBIgafcyupr15JNQdN4PpxKIDPvSom3yt9oeiZYke2xkb3KLTdCIZS+zy
         TWxY8wlfDfv+u/pKmUfa+r+/hrtiLoU7yzft2ltc12EKS5WVQiDAsQqXZN+m52wlBwAv
         WZ0bmHFKUpYZ02xEZv/5ZX8JPo7CExCboRCf3PRD9q35p39EIP0IYuqFJa5wLUIorSOs
         sbB4ggZ9d54SRCsWskMdfdqjKM/IIWblCvW0mR07TJOsSiHgvk8OOUBhfdMMU8nd748M
         YMZg==
X-Gm-Message-State: AOAM531A6Ko5CYQmhd1kizW6zuX+XV8vAldXHSwH2HfnJZAA+nYT5cdb
        5uGNX2aYvpm3SYT/YgD45cw=
X-Google-Smtp-Source: ABdhPJwgUVt+dZSyrLackqXJ5g5KD0DIsRpG2vF2/T1mnsime/YqZpvmtmcSKPJEz2+GIk5nmXGWew==
X-Received: by 2002:a05:620a:2414:b0:6a6:49ad:79b1 with SMTP id d20-20020a05620a241400b006a649ad79b1mr10856330qkn.663.1654371114360;
        Sat, 04 Jun 2022 12:31:54 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:291c:56c0:edc9:265a])
        by smtp.gmail.com with ESMTPSA id cd10-20020a05622a418a00b002f39b99f69csm7110279qtb.54.2022.06.04.12.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:31:53 -0700 (PDT)
Date:   Sat, 4 Jun 2022 12:31:52 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/4] lib/test: Introduce cpumask KUnit test suite
Message-ID: <YpuzKLQdToIwBrSm@yury-laptop>
References: <cover.1654362935.git.sander@svanheule.net>
 <5a55f41812dc18fccf66f8130682ff8e669e0c80.1654362935.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a55f41812dc18fccf66f8130682ff8e669e0c80.1654362935.git.sander@svanheule.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 04, 2022 at 07:15:56PM +0200, Sander Vanheule wrote:
> Add a basic suite of tests for cpumask, providing some tests for empty
> and completely filled cpumasks.
> 
> Signed-off-by: Sander Vanheule <sander@svanheule.net>

The test must go after fix, so that it's doesn't cause regressions
while bisecting.

> ---
>  lib/Kconfig.debug  |   9 ++++
>  lib/Makefile       |   1 +
>  lib/test_cpumask.c | 115 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 125 insertions(+)
>  create mode 100644 lib/test_cpumask.c

[..]

> +#define FOR_EACH_ITER_EQ(_test, _iter, _expect, _loop)		\
> +	do {							\
> +		(_iter) = 0;					\
> +		_loop						\
> +			(_iter)++;				\
> +		KUNIT_EXPECT_EQ((_test), (_expect), (_iter));	\
> +	} while (0)

This one is harder to use than it should be. Maybe like this? (not tested,
just an idea)

#define TEST_FOR_EACH_CPU_EQ(test, mask)                                \
	do {							        \
                cpumask_t *m = (mask);                                  \
                int iter = 0, cpu;                                      \
		for_each_cpu(cpu, m)		                        \
			iter++;			        	        \
		KUNIT_EXPECT_EQ((test), cpumask_weight(m), iter);	\
	} while (0)

static void test_cpumask_iterators(struct kunit *test)
{
        TEST_FOR_EACH_CPU(test, &mask_empty);
        ...
}
 
Similarly for NOT and WRAP.

Thanks,
Yury

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
> +	unsigned int iterations;
> +	int cpu;
> +
> +	FOR_EACH_ITER_EQ(test, iterations, cpumask_weight(&mask_empty),
> +			for_each_cpu(cpu, &mask_empty));
> +	FOR_EACH_ITER_EQ(test, iterations, nr_cpu_ids - cpumask_weight(&mask_empty),
> +			for_each_cpu_not(cpu, &mask_empty));
> +	FOR_EACH_ITER_EQ(test, iterations, cpumask_weight(&mask_empty),
> +			for_each_cpu_wrap(cpu, &mask_empty, nr_cpu_ids / 2));
> +
> +	FOR_EACH_ITER_EQ(test, iterations, cpumask_weight(cpu_possible_mask),
> +			for_each_cpu(cpu, cpu_possible_mask));
> +	FOR_EACH_ITER_EQ(test, iterations, nr_cpu_ids - cpumask_weight(cpu_possible_mask),
> +			for_each_cpu_not(cpu, cpu_possible_mask));
> +	FOR_EACH_ITER_EQ(test, iterations, cpumask_weight(cpu_possible_mask),
> +			for_each_cpu_wrap(cpu, cpu_possible_mask, nr_cpu_ids / 2));
> +}
> +
> +static void test_cpumask_iterators_builtin(struct kunit *test)
> +{
> +	unsigned int iterations;
> +	int cpu;
> +
> +	FOR_EACH_ITER_EQ(test, iterations, nr_cpu_ids,
> +		for_each_possible_cpu(cpu));
> +	FOR_EACH_ITER_EQ(test, iterations, cpumask_weight(cpu_online_mask),
> +		for_each_online_cpu(cpu));
> +	FOR_EACH_ITER_EQ(test, iterations, cpumask_weight(cpu_present_mask),
> +		for_each_present_cpu(cpu));
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
