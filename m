Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A654E49F6A8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347732AbiA1Jts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347666AbiA1Jtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:49:47 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4184BC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 01:49:47 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id w133so11300298oie.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 01:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KD2MpvTo6d8AcZYWRzGbZANNSm7u8StOzxLlvpWuXTM=;
        b=FQzQLz7w2uSqyOzFrdxgHPBSvl26iWOThEOJaHmMYuIVXnVQEgZKxZ5U4FWsJLPY0S
         X4XEZ3XJtyt2Hk0VsyZfdJ30dA7SvjN3AZ6QJ5l2DCpTYfQZdDb00FoHJas4xqHE0lRE
         0aOu4PtW8jL1ggLGdgMydU0uN8yXsBv5qOCviu2tDu4MBCNuiYhhW2oNdiW+QnjMy/jj
         n0QqnYbHvV7RJUVwZjDX/6vTmFpoGsgkRhHiXwqRvFc9HrnyEWmxuljZgaze8tC1AAWV
         PphyuKKG98JeSBtMcyM/5mPLxi2zPXe7nksv2nZa2qvYzpBK/MYoW2Y1GSzKRDWMxGWk
         itVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KD2MpvTo6d8AcZYWRzGbZANNSm7u8StOzxLlvpWuXTM=;
        b=2hmjV4DOPq+Jn2dF1SaqPFJHVNaEXqqP6eC2FwbGJY0nzuLx2jzzIUMSk1wGXlwJ5O
         OTUk8egn473RSGMYvaJs/wIlrPI5HM9rChVxL41EbJhdt1OY+9SalEYPv+BzA5+MouJr
         REz2npAK1womwFMZa/UPpYhJ8OOlHZTQyCeuQcRyQRX4+JleiP4qS3FR27cys+PRSEN+
         MH/WTeKFiCrEM506jr0XXm4Ub7niPYnBXXA0D3BFKSkN/6+a5/44D+Yyx6EIqEJX8DYU
         YmHOxqqV9IDEU578nwaoprm68d64885eunjeLmmg9iuJmPzmRAeJsr0JBYHS2aRB4ote
         1qpQ==
X-Gm-Message-State: AOAM532lqTepGS8qDBioKCkvQbUONl7arYkeQwuIYG/CMxn2EVTEYkni
        ny8UwdbvsHSxagfQA2EwjiNanbar/qNzWmkNMvrngQ==
X-Google-Smtp-Source: ABdhPJxKbcqfZUb1crg7oqDeoxOAlqqsIMh8sFoswaBdoHmg/9J3J8aMcSu3WBha2OvAdhq+y7Y7sjYIrLFdQDgLj1w=
X-Received: by 2002:a05:6808:1901:: with SMTP id bf1mr5020470oib.197.1643363386387;
 Fri, 28 Jan 2022 01:49:46 -0800 (PST)
MIME-Version: 1.0
References: <20220128015752.931256-1-liupeng256@huawei.com>
In-Reply-To: <20220128015752.931256-1-liupeng256@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 28 Jan 2022 10:49:34 +0100
Message-ID: <CANpmjNP+J-Ztz_sov0LPXS8nGCf-2oJFs0OJp1LQMBeaL00CBQ@mail.gmail.com>
Subject: Re: [PATCH v2] kfence: Make test case compatible with run time set
 sample interval
To:     Peng Liu <liupeng256@huawei.com>
Cc:     glider@google.com, dvyukov@google.com, corbet@lwn.net,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        akpm@linux-foundation.org, kasan-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2022 at 02:41, Peng Liu <liupeng256@huawei.com> wrote:
> The parameter kfence_sample_interval can be set via boot parameter
> and late shell command, which is convenient for automatical tests

s/automatical/automated/

> and KFENCE parameter optimation. However, KFENCE test case just use

s/optimation/optimization/

> compile time CONFIG_KFENCE_SAMPLE_INTERVAL, this will make KFENCE
> test case not run as user desired. This patch will make KFENCE test
> case compatible with run-time-set sample interval.

I'm not too particular about it, but "This patch" is usually bad style:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

> v1->v2:
> - Use EXPORT_SYMBOL_GPL replace EXPORT_SYMBOL

Changelog is usually placed after '---', because it's mostly redundant
once committed. Often maintainers include a "Link" to the original
patch which then has history and discussion.

> Signed-off-by: Peng Liu <liupeng256@huawei.com>

Reviewed-by: Marco Elver <elver@google.com>


> ---
>  include/linux/kfence.h  | 2 ++
>  mm/kfence/core.c        | 3 ++-
>  mm/kfence/kfence_test.c | 8 ++++----
>  3 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/kfence.h b/include/linux/kfence.h
> index 4b5e3679a72c..f49e64222628 100644
> --- a/include/linux/kfence.h
> +++ b/include/linux/kfence.h
> @@ -17,6 +17,8 @@
>  #include <linux/atomic.h>
>  #include <linux/static_key.h>
>
> +extern unsigned long kfence_sample_interval;
> +
>  /*
>   * We allocate an even number of pages, as it simplifies calculations to map
>   * address to metadata indices; effectively, the very first page serves as an
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 5ad40e3add45..13128fa13062 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -47,7 +47,8 @@
>
>  static bool kfence_enabled __read_mostly;
>
> -static unsigned long kfence_sample_interval __read_mostly = CONFIG_KFENCE_SAMPLE_INTERVAL;
> +unsigned long kfence_sample_interval __read_mostly = CONFIG_KFENCE_SAMPLE_INTERVAL;
> +EXPORT_SYMBOL_GPL(kfence_sample_interval); /* Export for test modules. */
>
>  #ifdef MODULE_PARAM_PREFIX
>  #undef MODULE_PARAM_PREFIX
> diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
> index a22b1af85577..50dbb815a2a8 100644
> --- a/mm/kfence/kfence_test.c
> +++ b/mm/kfence/kfence_test.c
> @@ -268,13 +268,13 @@ static void *test_alloc(struct kunit *test, size_t size, gfp_t gfp, enum allocat
>          * 100x the sample interval should be more than enough to ensure we get
>          * a KFENCE allocation eventually.
>          */
> -       timeout = jiffies + msecs_to_jiffies(100 * CONFIG_KFENCE_SAMPLE_INTERVAL);
> +       timeout = jiffies + msecs_to_jiffies(100 * kfence_sample_interval);
>         /*
>          * Especially for non-preemption kernels, ensure the allocation-gate
>          * timer can catch up: after @resched_after, every failed allocation
>          * attempt yields, to ensure the allocation-gate timer is scheduled.
>          */
> -       resched_after = jiffies + msecs_to_jiffies(CONFIG_KFENCE_SAMPLE_INTERVAL);
> +       resched_after = jiffies + msecs_to_jiffies(kfence_sample_interval);
>         do {
>                 if (test_cache)
>                         alloc = kmem_cache_alloc(test_cache, gfp);
> @@ -608,7 +608,7 @@ static void test_gfpzero(struct kunit *test)
>         int i;
>
>         /* Skip if we think it'd take too long. */
> -       KFENCE_TEST_REQUIRES(test, CONFIG_KFENCE_SAMPLE_INTERVAL <= 100);
> +       KFENCE_TEST_REQUIRES(test, kfence_sample_interval <= 100);
>
>         setup_test_cache(test, size, 0, NULL);
>         buf1 = test_alloc(test, size, GFP_KERNEL, ALLOCATE_ANY);
> @@ -739,7 +739,7 @@ static void test_memcache_alloc_bulk(struct kunit *test)
>          * 100x the sample interval should be more than enough to ensure we get
>          * a KFENCE allocation eventually.
>          */
> -       timeout = jiffies + msecs_to_jiffies(100 * CONFIG_KFENCE_SAMPLE_INTERVAL);
> +       timeout = jiffies + msecs_to_jiffies(100 * kfence_sample_interval);
>         do {
>                 void *objects[100];
>                 int i, num = kmem_cache_alloc_bulk(test_cache, GFP_ATOMIC, ARRAY_SIZE(objects),
> --
> 2.18.0.huawei.25
>
