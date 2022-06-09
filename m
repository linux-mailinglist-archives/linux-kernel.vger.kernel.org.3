Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09755545435
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343835AbiFISes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbiFISeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:34:44 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C75810C307
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 11:34:44 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id h8so4685125iof.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 11:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h+QoQcZlBQcgjaXTtPpLAq3kb9O2sEKS7YuulaGYrdM=;
        b=Y7L1oYc4ArWnrFVDRVPeULE6pzqLh3WUk0CNiPz7NrRBgZdSWaSTUCQcPlJDbeVg+j
         LBqa2kIEBIN5O4+n3C9ZzeP5vy8R2QsSi9lswlABwcPHQvpDdov85nCJVzimprRN6UJ0
         iD5m/s+cbQBj1gn8zzBjmMS5F2UpuYLE56zonznVZFJfo++oE0C0tSo/KaElhmyFZsYg
         BFrV2OgVsxgu4MZZn7ZgkXJyxidvddkjXpV9nnI7dyLAS7oxqneQqXiSA/JHjpjAUhd/
         FEnkjLjHTpV9j3pzOI9Y/EAe4UL6BUaYl4lTx2BF5CU+QVAZMi32dsQ2BIurzAg7RDX7
         QFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h+QoQcZlBQcgjaXTtPpLAq3kb9O2sEKS7YuulaGYrdM=;
        b=cfakkD7uc5iIm+OWnbz6DxbjMEAfl2Zh7lNJ7cqXMmKeEtcyvBOH8cA2HFTF2RMpjd
         zp3hiwFDT+YriS0VnfXJOR8dNycGtB4/I4CilBuKdni4mKAUdwrCJSXcrLbzuFcFu+iI
         olQT2TYyd2QmpU4grnQE+E6WlHt5FLtV7jGoBVjnt8xu2GmUHx1dwcMBtGjemlt4YmQ9
         tKp6xvWZZV+8VGG+AaXVwezaaZoH8G+F/L1435yXlaLeaPKzNUZ7IIVryRSW3Lgno2YK
         mnziwM3CpNYYy7mQ80JK7vfmPECfH3E55g7VFhSGCwxPpi+oza1T7mji4zmTQciTS2az
         qepg==
X-Gm-Message-State: AOAM530ZQ51iIlb/T2zlcFwhY+j/pS9VA5CTJKSmFwl4+lw4HM4DXXLP
        Lw0o0J842yOq73dqvksWHCh+3/j/mMEc+jvQ4fmZKANp
X-Google-Smtp-Source: ABdhPJz7XAipzp0kbM49L99YDkyeQFf6HdOEexpPmmCsedyTSkPAHR5EGJDeWq/6YFMx8bUdqOZ0TVqcAFqnX/EgQRw=
X-Received: by 2002:a5d:9817:0:b0:65a:f20b:db2c with SMTP id
 a23-20020a5d9817000000b0065af20bdb2cmr20052140iol.118.1654799683559; Thu, 09
 Jun 2022 11:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220607113150.55140-1-vincenzo.frascino@arm.com>
In-Reply-To: <20220607113150.55140-1-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 9 Jun 2022 20:34:32 +0200
Message-ID: <CA+fCnZcZcoOz+SVXdVOsrC_pR_PJUoCQnJe3B2u=D_K7=J79+Q@mail.gmail.com>
Subject: Re: [PATCH] mte: Initialize tag storage to KASAN_TAG_INVALID
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 7, 2022 at 1:32 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> When the kernel is entered on aarch64, the MTE allocation tags are in an
> UNKNOWN state.
>
> With MTE enabled, the tags are initialized:
>  - When a page is allocated and the user maps it with PROT_MTE.
>  - On allocation, with in-kernel MTE enabled (KHWASAN).

Hi Vincenzo,

I think we should move away from the KHWASAN name - it was used during
the early prototyping days for SW_TAGS KASAN. What you mean here is
HW_TAGS KASAN.

Thanks!


>
> If the tag pool is zeroed by the hardware at reset, it makes it
> difficult to track potential places where the initialization of the
> tags was missed.
>
> This can be observed under QEMU for aarch64, which initializes the MTE
> allocation tags to zero.
>
> Initialize to tag storage to KASAN_TAG_INVALID to catch potential
> places where the initialization of the tags was missed.
>
> This is done introducing a new kernel command line parameter
> "mte.tags_init" that enables the debug option.
>
> Note: The proposed solution should be considered a debug option because
> it might have performance impact on large machines at boot.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/kernel/mte.c | 47 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 57b30bcf9f21..259a826363f1 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -6,6 +6,7 @@
>  #include <linux/bitops.h>
>  #include <linux/cpu.h>
>  #include <linux/kernel.h>
> +#include <linux/memblock.h>
>  #include <linux/mm.h>
>  #include <linux/prctl.h>
>  #include <linux/sched.h>
> @@ -35,6 +36,8 @@ DEFINE_STATIC_KEY_FALSE(mte_async_or_asymm_mode);
>  EXPORT_SYMBOL_GPL(mte_async_or_asymm_mode);
>  #endif
>
> +static bool mte_tags_init __ro_after_init;
> +
>  static void mte_sync_page_tags(struct page *page, pte_t old_pte,
>                                bool check_swap, bool pte_is_tagged)
>  {
> @@ -107,6 +110,48 @@ int memcmp_pages(struct page *page1, struct page *page2)
>         return ret;
>  }
>
> +/* mte.tags_init=off/on */
> +static int __init early_mte_tags_init(char *arg)
> +{
> +       if (!arg)
> +               return -EINVAL;
> +
> +       if (!strcmp(arg, "off"))
> +               mte_tags_init = false;
> +       else if (!strcmp(arg, "on"))
> +               mte_tags_init = true;
> +       else
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +early_param("mte.tags_init", early_mte_tags_init);
> +
> +static inline void __mte_tag_storage_init(void)
> +{
> +       static bool mte_tags_uninitialized = true;
> +       phys_addr_t pa_start, pa_end;
> +       u64 index;
> +
> +       if (mte_tags_init && !mte_tags_uninitialized)
> +               return;
> +
> +       for_each_mem_range(index, &pa_start, &pa_end) {
> +               void *va_start = (void *)__phys_to_virt(pa_start);
> +               void *va_end = (void *)__phys_to_virt(pa_end);
> +               size_t va_size = (u64)va_end - (u64)va_start;
> +
> +               if (va_start >= va_end)
> +                       break;
> +
> +               mte_set_mem_tag_range(va_start, va_size, KASAN_TAG_INVALID, false);
> +       }
> +
> +       /* Tags are now initialized to KASAN_TAG_INVALID */
> +       mte_tags_uninitialized = false;
> +       pr_info("MTE: Tag Storage Initialized\n");
> +}
> +
>  static inline void __mte_enable_kernel(const char *mode, unsigned long tcf)
>  {
>         /* Enable MTE Sync Mode for EL1. */
> @@ -114,6 +159,8 @@ static inline void __mte_enable_kernel(const char *mode, unsigned long tcf)
>                          SYS_FIELD_PREP(SCTLR_EL1, TCF, tcf));
>         isb();
>
> +       __mte_tag_storage_init();
> +
>         pr_info_once("MTE: enabled in %s mode at EL1\n", mode);
>  }
>
> --
> 2.36.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20220607113150.55140-1-vincenzo.frascino%40arm.com.
