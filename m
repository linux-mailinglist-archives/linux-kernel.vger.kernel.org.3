Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB9958E607
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 06:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiHJEI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 00:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiHJEHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 00:07:18 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81648050B
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 21:07:14 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id q191so6845179vkb.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 21:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=SijMLFPQGoCxCOL8dbYYqOROGmyGPnlAwdXVlgG4/Kw=;
        b=BaSVTSJZE1degkADn1SmzhM6XY+C5+pvmk50uT9/nOVoZuSr00zwi6RDcTT8AWQKza
         +P8bvBEDgDQngBzc7+mR64XQIZ0VE5C30K+b/HGz2h3geKqx0n0wsR+oUUFNgexI3dnh
         BXuG56gydCHhpOoV+94MgX27AOE/e2N/Pa8D8+uflLAgrslWAIey06QVURyql8DxQFnI
         iuMZGBBuW6pFY+fUdedJBJwwD0NENKZOjaxp1gBo7PUy2NxawLe2+zLCGgP8WKYz7fr1
         o62HsR9sgTq5a8/WH2CZO6gaaK+a0NvvV+fUxB3BtitmG45fTt4+c9bA6icgQPPCDPeO
         /dRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=SijMLFPQGoCxCOL8dbYYqOROGmyGPnlAwdXVlgG4/Kw=;
        b=k83XvBpbiDaX0VOwaAENKMNDJCkuQ4AvOMw59ZJ0ppIHCl3FS0yaq232oluZfEKri3
         chxsYbu9vCmbNFc+HiextjqY35WiXcDZF5MN1vAd03ewkvmpVnxdbXs1F0tsiYgfe49b
         DcUtVve+HChCjB6QPZifdqh0JhJ8QBYPTDv+kGZLTZnSKOVfc4O3+fQtBgTwo1yGb2oQ
         dXENukj72xvVh9KrDCDAXxUR69fzEK7EMhCaBwKdw2harUxIHYmarDPjL3oiaDhTnURu
         7+1E2p64Vd9saqBwN2p7pcGel8oT0an8Z07Rp3L8rik9pDi3wPIpbHtGzL6VcHUZ81rK
         zEsA==
X-Gm-Message-State: ACgBeo1VaZo+Zgu3fu9U/LhohOCsJtrQ9ntD7z1KoGlVWXtQUVnKEtff
        UE76CBnkZOk/MMEidmuuYZt64h1kBJ+dH10fWIRfVQ==
X-Google-Smtp-Source: AA6agR4ALr0NLzMI6Vj5O1GYDXkXWuqMzJ6XUAY/ajZqvUo6RC+2ekWwGstADb+UPknTWqbky5nl7r5Ou9N9W0O4bzk=
X-Received: by 2002:a1f:ad50:0:b0:377:fba2:803b with SMTP id
 w77-20020a1fad50000000b00377fba2803bmr11173141vke.34.1660104433790; Tue, 09
 Aug 2022 21:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660068429.git.sander@svanheule.net> <1c111f549d3c84a6fa5a96b19b17f89938314265.1660068429.git.sander@svanheule.net>
In-Reply-To: <1c111f549d3c84a6fa5a96b19b17f89938314265.1660068429.git.sander@svanheule.net>
From:   David Gow <davidgow@google.com>
Date:   Wed, 10 Aug 2022 12:07:02 +0800
Message-ID: <CABVgOS=8rwx-HA6QQ8H+wM4jppdVvDeC62Fvjar_Q+YwsMyiFQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] lib/cpumask_kunit: log mask contents
To:     Sander Vanheule <sander@svanheule.net>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
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

On Wed, Aug 10, 2022 at 2:09 AM Sander Vanheule <sander@svanheule.net> wrote:
>
> For extra context, log the contents of the masks under test.  This
> should help with finding out why a certain test fails.
>
> Link: https://lore.kernel.org/lkml/CABVgOSkPXBc-PWk1zBZRQ_Tt+Sz1ruFHBj3ixojymZF=Vi4tpQ@mail.gmail.com/
> Suggested-by: David Gow <davidgow@google.com>
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> ---

Thanks!

Another option would be to only print this on test failure, but it's
fine as-is as well.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  lib/cpumask_kunit.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/lib/cpumask_kunit.c b/lib/cpumask_kunit.c
> index 4d353614d853..0f8059a5e93b 100644
> --- a/lib/cpumask_kunit.c
> +++ b/lib/cpumask_kunit.c
> @@ -51,6 +51,10 @@
>  static cpumask_t mask_empty;
>  static cpumask_t mask_all;
>
> +#define STR_MASK(m)                    #m
> +#define TEST_CPUMASK_PRINT(test, mask) \
> +       kunit_info(test, "%s = '%*pbl'\n", STR_MASK(mask), nr_cpumask_bits, cpumask_bits(mask))
> +
>  static void test_cpumask_weight(struct kunit *test)
>  {
>         KUNIT_EXPECT_TRUE(test, cpumask_empty(&mask_empty));
> @@ -103,6 +107,9 @@ static void test_cpumask_iterators_builtin(struct kunit *test)
>         /* Ensure the dynamic masks are stable while running the tests */
>         cpu_hotplug_disable();
>
> +       TEST_CPUMASK_PRINT(test, cpu_online_mask);
> +       TEST_CPUMASK_PRINT(test, cpu_present_mask);
> +
>         EXPECT_FOR_EACH_CPU_BUILTIN_EQ(test, online);
>         EXPECT_FOR_EACH_CPU_BUILTIN_EQ(test, present);
>
> @@ -114,6 +121,9 @@ static int test_cpumask_init(struct kunit *test)
>         cpumask_clear(&mask_empty);
>         cpumask_setall(&mask_all);
>
> +       TEST_CPUMASK_PRINT(test, &mask_all);
> +       TEST_CPUMASK_PRINT(test, cpu_possible_mask);
> +
>         return 0;
>  }
>
> --
> 2.37.1
>
