Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C094B912F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbiBPTb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:31:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiBPTbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:31:55 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E033024595
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:31:41 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id p5so8189765ybd.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dXrDCcliqXFznAwN9UKmpIFnfCTr0AltCrpKcHBOhyI=;
        b=qJ/yCvpEUmPA0hRxUmuaDL81dNgclLtlovcbdNgaJnAG1T1c32U9gLeLgGeqRZK46y
         ZHBad5Ri7881CaaonxsVe70p0ozztVdEVl1vZUad7WOwV/8X6HAinMDGmukdCqZuotDp
         BvK2CvmQfatfstbbEvvmtJUX1E+TngZgH7jIZUGi3DR1pFu53xgJQme+IT+UcZgcQfON
         5G603uaeNfjqESP9nuEOL/Au6g2oZwo6bdz22BtrNEU2RdbszEC2MJhkQ1xZUnKQ6Jeq
         8qBYNEHe5r560UUO4tg0Q05n5D+orZdP2KbqZRDMmjaZUT/jm2hYDmTksU2I1M+jhVEK
         18XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dXrDCcliqXFznAwN9UKmpIFnfCTr0AltCrpKcHBOhyI=;
        b=ia12YKXMnWie8mkAatIGQJFnw4+dpWiNGPD3dtEzK7a6ID3lLPJNunpjYNQunuDgJm
         WvtjnEAS9dpfBQgLqRkolNcf+fK7S6jRu0HBthPiUs7RI4NR7L7QycJjlOK4zUFxIqHT
         RRbu3EhbTptYcTG5hdkyr5FHRVHomUQ65+6Jvbc/ngISk3LA/JOjuTPa6pJwDjI1z1aq
         uANI0Qcf1IePgY7TUMXZAHn2KUf3fjfWfOoMmBjzF9GGSBnsT87TMO3sRdqGUItMXY3J
         sZw3+1a9FguD+r3KKr4mqpGioiD/PcVW/BmzL72MsUW44oLiP5AfPUWmbgzfecpXNUV7
         SNgw==
X-Gm-Message-State: AOAM53298Wq6cpN+Bj2Z1QyqVyXuqYqALabNDqcfHtr6swCz766XMdNy
        zHBbcfA+mX87v/Ui5eU3QyzJEbQKnsfh7hivuq1qtQ==
X-Google-Smtp-Source: ABdhPJyd8vNcqO73LtXnsYyTU+wTX6CnjbUBRm0qKYB+hv+NCyTiJtR9isxNXT4zUaugFzR/dpVMje33RcuTSxrzBNk=
X-Received: by 2002:a25:f441:0:b0:611:4f60:aab1 with SMTP id
 p1-20020a25f441000000b006114f60aab1mr3441157ybe.598.1645039900830; Wed, 16
 Feb 2022 11:31:40 -0800 (PST)
MIME-Version: 1.0
References: <5b120f7cadcc0e0d8d5f41fd0cff35981b3f7f3a.1645038022.git.andreyknvl@google.com>
In-Reply-To: <5b120f7cadcc0e0d8d5f41fd0cff35981b3f7f3a.1645038022.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 16 Feb 2022 20:31:29 +0100
Message-ID: <CANpmjNP0QCMhSL+ePf5G8UwbmdjM-qpimAQbuQD+pYK8Gx+2Gw@mail.gmail.com>
Subject: Re: [PATCH mm] kasan: print virtual mapping info in reports
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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

On Wed, 16 Feb 2022 at 20:01, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Print virtual mapping range and its creator in reports affecting virtual
> mappings.
>
> Also get physical page pointer for such mappings, so page information
> gets printed as well.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> ---
>
> Note: no need to merge this patch into any of the KASAN vmalloc patches
> that are already in mm, better to keep it separate.
> ---
>  mm/kasan/report.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 137c2c0b09db..8002fb3c417d 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -260,8 +260,18 @@ static void print_address_description(void *addr, u8 tag)
>                 pr_err(" %pS\n", addr);
>         }
>
> +       if (is_vmalloc_addr(addr)) {
> +               struct vm_struct *va = find_vm_area(addr);
> +
> +               pr_err("The buggy address belongs to the virtual mapping at\n"
> +                      " [%px, %px) created by:\n"
> +                      " %pS\n", va->addr, va->addr + va->size, va->caller);

Can you show an example of what this looks like? It's not showing a
stack trace, so why not continue the line and just say "... created
by: %pS\n"

> +               page = vmalloc_to_page(page);
> +       }
> +
>         if (page) {
> -               pr_err("The buggy address belongs to the page:\n");
> +               pr_err("The buggy address belongs to the physical page:\n");
>                 dump_page(page, "kasan: bad access detected");
>         }
>
> --
> 2.25.1
>
