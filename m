Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BCA5AE218
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbiIFILI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbiIFIKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:10:31 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7498E7539F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 01:10:29 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-334dc616f86so88501717b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 01:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=kD16B7J90qYAXN9Q4HkNuXZa7up8m5iSAliPqwB9ybs=;
        b=k7tpAULwhwiYd7jdd42DgZeTPzKor5vWWgisFVqvcdDn7+RokQmbvpkWcSE1cBoFue
         Yta838q0NF2x/LtpsNsDEcwK7m40iRP4goOuLMlJuZLLSTmkOrTQd0tWqxZPthV6bOio
         OZZOqmh0/WgXthKJRU2gC2kDhZ5qWFh+96puxjwzgjfDPzcU6DAuS+Zcy+jmgJBO4aKM
         TX+XAhifYq1bakcKIuvKCJDh2qolkHOPEcpJ5IHcrcWaROV5uHS2EKaprA3YEEf7O/bR
         gsJNoYuOkaFuNv5eLll5WEQcdIUqS+TQNRkQVWFoRI330yhTQvw3Tgsf+sguLkBUXePJ
         mA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=kD16B7J90qYAXN9Q4HkNuXZa7up8m5iSAliPqwB9ybs=;
        b=wXsJesRmdPdkkvyZXRHs1PTxIwFFBbK6KMtEDDhr4VXNaLM9aTt/9941dxm9KlvXC2
         GiGLg9UVUnO3EujJXaO9kHunRuBT53RDSIgTMRe9FXfG4GfdMOqSmoCu+NNzIpHh6RBe
         HlWjTjkWqyS9xpFNQYT7LtZ3EbWRXkf7Pdlh3rac8LU/N2mavPyZ0oItPVo8GQkHtbqw
         6YFD4yRtxvZwp3Y6ch1sn8Uwocqmc8acMz4fZ14NfYYxGnuwI9gz6r9Td4Jb+Nxv8fGj
         INVvBcOkfNjLf14fcqYN9aG7eXCqUXmJjgK+9z2lf/lMQrLVMDw0v4gpzveuTT9Cthln
         SumQ==
X-Gm-Message-State: ACgBeo0a5VSK7TiXI65J8gdKhxgfvU44lfqd5s2TJEKcZbS1JtQuVuDG
        LIYfoP+Bt7UQhDWr8QJYMc1w0JyZQu/bfvjdmkUdFg==
X-Google-Smtp-Source: AA6agR4rIBbhGutrY9653MGpGLNzg1oKFDAbztQtqd8svJfF3wfx0wW+q2YV3yoZDJrO5T19oIugu+V32AMyTDTSo7Y=
X-Received: by 2002:a81:92c4:0:b0:340:bd1f:3e35 with SMTP id
 j187-20020a8192c4000000b00340bd1f3e35mr37658681ywg.324.1662451828519; Tue, 06
 Sep 2022 01:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220906075253.28491-1-alexander.sverdlin@nokia.com>
In-Reply-To: <20220906075253.28491-1-alexander.sverdlin@nokia.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 6 Sep 2022 02:09:52 -0600
Message-ID: <CAOUHufacHqka5NgpZ5ztd5Ur_B=AKU4DWEYwWjCWBVK-8x+h3A@mail.gmail.com>
Subject: Re: [PATCH] MIPS: octeon: Get rid of preprocessor directives around RESERVE32
To:     Alexander A Sverdlin <alexander.sverdlin@nokia.com>
Cc:     Joe Perches <joe@perches.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Corey Minyard <cminyard@mvista.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 1:53 AM Alexander A Sverdlin
<alexander.sverdlin@nokia.com> wrote:
>
> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
>
> Some of them were pointless because CONFIG_CAVIUM_RESERVE32 is now always
> defined, some were not enough (Yu Zhao reported [1]
> "Failed to allocate CAVIUM_RESERVE32 memory area" error).
>
> Removing (in contrast to proposal [2] though) the directives allows for
> compiler coverage of RESERVE32 code and replacing one of [always-true]
> "ifdef" with a compiler conditional fixes the [cosmetic] error message.
>
> Couple of variables doesn't justify preprocessor ugliness and none of this
> code is in a hot-path.
>
> Link: https://lore.kernel.org/lkml/20220830030259.3503212-1-yuzhao@google.com/
> Link: https://lore.kernel.org/lkml/d5f8d6b58a32cdbf6326ccef7d46a58ba753edc7.camel@perches.com/
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> ---
>  arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c |  4 ----
>  arch/mips/cavium-octeon/setup.c                    | 25 +++++++++-------------
>  2 files changed, 10 insertions(+), 19 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c b/arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c
> index bf13e35..aa7bbf8 100644
> --- a/arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c
> +++ b/arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c
> @@ -57,14 +57,11 @@ EXPORT_SYMBOL_GPL(__cvmx_cmd_queue_state_ptr);
>  static cvmx_cmd_queue_result_t __cvmx_cmd_queue_init_state_ptr(void)
>  {
>         char *alloc_name = "cvmx_cmd_queues";
> -#if defined(CONFIG_CAVIUM_RESERVE32) && CONFIG_CAVIUM_RESERVE32
>         extern uint64_t octeon_reserve32_memory;
> -#endif
>
>         if (likely(__cvmx_cmd_queue_state_ptr))
>                 return CVMX_CMD_QUEUE_SUCCESS;
>
> -#if defined(CONFIG_CAVIUM_RESERVE32) && CONFIG_CAVIUM_RESERVE32
>         if (octeon_reserve32_memory)
>                 __cvmx_cmd_queue_state_ptr =
>                     cvmx_bootmem_alloc_named_range(sizeof(*__cvmx_cmd_queue_state_ptr),
> @@ -73,7 +70,6 @@ static cvmx_cmd_queue_result_t __cvmx_cmd_queue_init_state_ptr(void)
>                                                    (CONFIG_CAVIUM_RESERVE32 <<
>                                                     20) - 1, 128, alloc_name);
>         else
> -#endif
>                 __cvmx_cmd_queue_state_ptr =
>                     cvmx_bootmem_alloc_named(sizeof(*__cvmx_cmd_queue_state_ptr),
>                                             128,
> diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
> index cbd8320..df45f76 100644
> --- a/arch/mips/cavium-octeon/setup.c
> +++ b/arch/mips/cavium-octeon/setup.c
> @@ -284,10 +284,8 @@ void octeon_crash_smp_send_stop(void)
>
>  #endif /* CONFIG_KEXEC */
>
> -#ifdef CONFIG_CAVIUM_RESERVE32
>  uint64_t octeon_reserve32_memory;
>  EXPORT_SYMBOL(octeon_reserve32_memory);
> -#endif
>
>  #ifdef CONFIG_KEXEC
>  /* crashkernel cmdline parameter is parsed _after_ memory setup
> @@ -666,9 +664,7 @@ void __init prom_init(void)
>         int i;
>         u64 t;
>         int argc;
> -#ifdef CONFIG_CAVIUM_RESERVE32
>         int64_t addr = -1;
> -#endif

Nit: `addr` can be moved into the `if` block below.

>         /*
>          * The bootloader passes a pointer to the boot descriptor in
>          * $a3, this is available as fw_arg3.
> @@ -783,7 +779,7 @@ void __init prom_init(void)
>                 cvmx_write_csr(CVMX_LED_UDD_DATX(1), 0);
>                 cvmx_write_csr(CVMX_LED_EN, 1);
>         }
> -#ifdef CONFIG_CAVIUM_RESERVE32
> +
>         /*
>          * We need to temporarily allocate all memory in the reserve32
>          * region. This makes sure the kernel doesn't allocate this
> @@ -794,14 +790,15 @@ void __init prom_init(void)
>          * Allocate memory for RESERVED32 aligned on 2MB boundary. This
>          * is in case we later use hugetlb entries with it.
>          */
> -       addr = cvmx_bootmem_phy_named_block_alloc(CONFIG_CAVIUM_RESERVE32 << 20,
> -                                               0, 0, 2 << 20,
> -                                               "CAVIUM_RESERVE32", 0);
> -       if (addr < 0)
> -               pr_err("Failed to allocate CAVIUM_RESERVE32 memory area\n");
> -       else
> -               octeon_reserve32_memory = addr;
> -#endif
> +       if (CONFIG_CAVIUM_RESERVE32) {
> +               addr = cvmx_bootmem_phy_named_block_alloc(CONFIG_CAVIUM_RESERVE32 << 20,
> +                                                         0, 0, 2 << 20,
> +                                                         "CAVIUM_RESERVE32", 0);

I.e., `int64_t addr = cvmx_...`.

> +               if (addr < 0)
> +                       pr_err("Failed to allocate CAVIUM_RESERVE32 memory area\n");
> +               else
> +                       octeon_reserve32_memory = addr;
> +       }

Acked-by: Yu Zhao <yuzhao@google.com>
