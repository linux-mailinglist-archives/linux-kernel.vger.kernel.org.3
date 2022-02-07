Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641CD4AB710
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243191AbiBGI7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350847AbiBGIzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:55:55 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3736C043188
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 00:55:53 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id v47so12843499ybi.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 00:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=knF2fFP9aIoGTNmgPKFlIdzkXuLeb4VSUzI7AmunKNY=;
        b=kjKQjXhqwEwzFPGB6U7llci4Uyu0GDktsh9CriN7LUAxMChIRo0PfU0thwAaw7TEV0
         eqCQDKSViTSVsvrwmtQtElbEyfpkPhnyg4gPW1DbIanejHpDHkfG/4K2wXFclclpkWzI
         6WWHlSneOzKtnn8OzsMKXLagS1YERguBWMQh1qbU+fUkMIO42i0rVSiMI/6AnVSMVSkP
         QIAO7fAtsQeLrnZrgbbX9hklHmvYu1UJxrrxfeJ11kickjSzmqyKZiEW+JH0AbcMcCp7
         WeBBZbhdpkYxU/69NVf1lZzL3bs3DuayqvwzIEsIba6Y/YaBjtid3TAMYdo7sfNwHMiQ
         LMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=knF2fFP9aIoGTNmgPKFlIdzkXuLeb4VSUzI7AmunKNY=;
        b=MOyEShuAlZIRmEtiDxVaUFr+8FbTBsh4u4rhCycQQWRlWJcUC2bLUgpvznaPlECn5M
         wf4ni/dDn4s961R4/U910e1FB8jXYvcpVBrCZW38d21RnAMuDKNbb7F8nS3VHtPpbCiF
         zKmEzSe0hJgYRPSCiJuBxbekHzjUTJicT0FUXAggjFnOnj7qabKRyaHkVfNC0kwua9mc
         jXZt7KzNyrcsuAwmEIvxrJmRlBVK8Lr5RQI4KjpP3pzAXzherrqKM0LIXnWSJ32u9+5z
         tZ3rskbgcyAm2M2gekpbOgUg+oZruVyO1kL/SMuVK9HCKPg+LpeWcEcwHwCUcU9U9kjO
         HEig==
X-Gm-Message-State: AOAM533NmfvEBn7it6SrG08jAi7MpKDMATgUCBFMObIWlVfxK9uqYhZj
        Ps8WUo4wHJTZk24jwE2wZ5ie+MBlTrCJaLKJzgCL5Q==
X-Google-Smtp-Source: ABdhPJyWH7PhtKu+j316v5w82AR7rHUJWXjLEcMawUmUXMQHsH7DXQJajqIi03ZoF4QFGuosxGiLrl/nfBv2NmF3nwQ=
X-Received: by 2002:a81:c505:: with SMTP id k5mr6144103ywi.264.1644224152818;
 Mon, 07 Feb 2022 00:55:52 -0800 (PST)
MIME-Version: 1.0
References: <20220207034432.185532-1-liupeng256@huawei.com>
In-Reply-To: <20220207034432.185532-1-liupeng256@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 7 Feb 2022 09:55:41 +0100
Message-ID: <CANpmjNN=0Q6s5WnKrWm4YXqSj-1rRsL2VTD_QJUfQdv_2nhf0Q@mail.gmail.com>
Subject: Re: [PATCH v3] kfence: Make test case compatible with run time set
 sample interval
To:     Peng Liu <liupeng256@huawei.com>
Cc:     glider@google.com, dvyukov@google.com, corbet@lwn.net,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        akpm@linux-foundation.org, kasan-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Feb 2022 at 04:29, 'Peng Liu' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> The parameter kfence_sample_interval can be set via boot parameter
> and late shell command, which is convenient for automated tests and
> KFENCE parameter optimization. However, KFENCE test case just uses
> compile-time CONFIG_KFENCE_SAMPLE_INTERVAL, which will make KFENCE
> test case not run as users desired. Export kfence_sample_interval,
> so that KFENCE test case can use run-time-set sample interval.
>
> Signed-off-by: Peng Liu <liupeng256@huawei.com>

Reviewed-by: Marco Elver <elver@google.com>

Thank you.

> ---
> v2->v3:
> - Revise change log description
> v1->v2:
> - Use EXPORT_SYMBOL_GPL replace EXPORT_SYMBOL
>
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
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20220207034432.185532-1-liupeng256%40huawei.com.
