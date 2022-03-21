Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627DA4E2375
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345947AbiCUJkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbiCUJkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:40:19 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AB11CFE9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:38:54 -0700 (PDT)
Received: from mail-wm1-f43.google.com ([209.85.128.43]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MCKWI-1nO11T0Tdy-009Nqg for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022
 10:38:53 +0100
Received: by mail-wm1-f43.google.com with SMTP id h16so7591504wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:38:53 -0700 (PDT)
X-Gm-Message-State: AOAM533DDIP/5gaI19qkQwzdS582c2WWqGqoieovW2T7AFUbXt4RZhNc
        ECXmqq6W8itTq//4vEQbyTuLu9r2MYncEovaFF0=
X-Google-Smtp-Source: ABdhPJwHrKUKxYkZNzmmlwfspjQ9k/71XpCyBvdLMSQD+yuTHl2E5JvC+V3hbYc0A6xq6NZLQGug9dNQCUt046C6+7g=
X-Received: by 2002:a1c:f20b:0:b0:389:c99a:4360 with SMTP id
 s11-20020a1cf20b000000b00389c99a4360mr26314299wmc.174.1647852195434; Mon, 21
 Mar 2022 01:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220319142759.1026237-1-chenhuacai@loongson.cn>
 <20220319143817.1026708-1-chenhuacai@loongson.cn> <20220319143817.1026708-4-chenhuacai@loongson.cn>
In-Reply-To: <20220319143817.1026708-4-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 21 Mar 2022 09:42:59 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1ST1hBnhepvoQ9UTbAM=56JEU=-OiBAFQeK2rgaZ5aWw@mail.gmail.com>
Message-ID: <CAK8P3a1ST1hBnhepvoQ9UTbAM=56JEU=-OiBAFQeK2rgaZ5aWw@mail.gmail.com>
Subject: Re: [PATCH V8 11/22] LoongArch: Add process management
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:GlIyRrow0ulsm/Aycuhen3FK1PeWomz8YzR+cAe6BmEOIiVHYSa
 SST/54mcYqv9cL6h7QY6j+LOWO7ZF1/lr/n+XeZJVpxhovmz9A6idKk+zI22pFFRMG9laCY
 csEy4rTUHwGc4DgXUS0KsRXDSNi9kdz1gD406jJ8fE5FYCybVZN7oXcgXZaVxoKvuTQLsU1
 B+W1ToUmwS6cy+0rFTlyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kg0ucPJluXo=:i9RhAZLP5mtdHAIIwcVgO8
 6XlZzE4HPzfe8l3rSDS37ufCiXrOuQOAgsC3VEet+5H+SC067KwVOQKY5N5a+DafAH0G1ttO5
 N+Y10b71JUcJ1vTJe4vu8osqS9khnJ8TB6FeHvBOY+HNyOCr4JcobyiIbotEVy9sBQyci6/wV
 7Z3mxvot+XNh6oL4DTUDdpwIvWr4gianiEFLj0PVmiPaxMZCOIQJuuR1ONX2axUhd0WqAaOZZ
 xhEHwOAeDMJM6eujj2LDwKRR/HvmGVlmHe1WUAus2DXoK9+kJ1irEmqQp1U6Ww1eB7x8/ciMh
 KPMKFcX0FTbH27twMda3oqdXlasQ+WhRxVsQpGDITD1TsX4/YPLbIweGABbJLRaLRbTEOPRM6
 d14/6mMHAcB/cbXSTVraZlOTX5Sv7M+Oj93N2EaZYK6hwZdvX21+qJKfVah8rQ1sFvHgheWrq
 EzqZpmC78iR7z6S7nuiO4DwL+GHLpGDXiCCU1oNSDphjylQvD2WDuK7BlPOnnvZUrcSjdL9ed
 BwNOhYtoMYvcmhgFR1cpqMp5z2wcvXmEHsDFvipG/kQpUvl9j4v8CCGEHOqcSMt0TAGuQmTNt
 qoT4V9HZjRyFVVYc9oWWxGPAQpUbRamU0lzEshxD4qUjKx0sDf2DSBid1ix9RO0PY/u5mb0ed
 5F1VDUEJLMrwHWwk7a1k5DqO3jCygMHXn4s8Gyed4VkY68wYlOutl/mhTEheremhiI3Q95EXq
 P+nTlIyyKPsnxjUdIVnSO2NaORaBQ9O7E+bxrUgBsUitCxzZFLuKHGCtQXxr2DSG28KYqSMFx
 Szlh6UH9rytZGfTnIzB+hBhNjqThx3egQKE1azo/7sBSNrGREY=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2022 at 3:38 PM Huacai Chen <chenhuacai@kernel.org> wrote:

> +#ifdef CONFIG_PAGE_SIZE_64KB
> +#define THREAD_SIZE_ORDER (0)
> +#endif
> +
> +#define THREAD_SIZE (PAGE_SIZE << THREAD_SIZE_ORDER)
> +#define THREAD_MASK (THREAD_SIZE - 1UL)
> +

Having a 64KB stack area is rather wasteful. I think you should use a sub-page
allocation in this configuration, or possibly disallow 64KB page configuration
entirely.

Note that you have to use full pages when using CONFIG_VMAP_STACK, but
you don't seem to support that at the moment, so allocating only 16KB stacks
on a 64KB page config should still work.

       Arnd
