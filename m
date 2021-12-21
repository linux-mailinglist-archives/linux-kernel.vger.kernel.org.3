Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D713347C24C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238978AbhLUPLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238979AbhLUPLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:11:51 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBADC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:11:51 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id t6so12828424qkg.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=inKnCrxjiVlEFGg7TNsjz8T66oFLFowuMdP2ABAhDNw=;
        b=ZXXoTFFpFceomVCNZbiSunDDkt4OnlItu8mtU+NMmTOEcfg0gxBDShl1sSnVt/nLm8
         x2YmJ/p+osB3SadllEUVUcn9Pt/IfJyQHd9cxW+VxL7ytT24/D9PkhyZM9vHpr8q9kBQ
         QVeD7D8f1QPckG3DjhGcEc7GHW5rDNW+b8VeFwlxyMlErdA6UsDQvAPrqXni9eITkLEl
         r+bYnT3mgV2uljc7gH/N3+Gh8waibfzvtq0GtTBV3/9s5Irju2R49+xQezhFPH/jGiNK
         5Cb7c9GkaFLc1c570g8Z9qv3cYgKJzmtBqEYCP6bDbebH5ABNRqp0Tu0yKkJI2q6v+Mm
         iFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=inKnCrxjiVlEFGg7TNsjz8T66oFLFowuMdP2ABAhDNw=;
        b=X5aALgM669te53EiBwD5a5ZtzePWGJvpGWSi3Sh4r1ZTI20KmkL1aXjf8RlZYMygrB
         Z7m+sDuHFZwIrvKsehgkqQZJpZz3I3QDlYfAFQ1EHYbYgMM7R9WC6NnuEzaLj43Asgwa
         3rPTLw+zRS1mJYHp+T7sE8KjrjcRKOXNVwhPm5A4gOQws9CMv2eufMGwfhbR7BZ6PCd2
         icsaNNcp9WYPgmUsDcjJp95qYd8MHs6TkWgdE+4ZchgTcRpH8mXrjwNLQiXKQirxpJP3
         FDaeO7qiZIekk9WOX83KZkkTdjLlL6juaxBqeDYZoNsFRCWSsBTD/tqpRm91F3i9w+mf
         3v2g==
X-Gm-Message-State: AOAM530dxaMfAYKEFewaTDXCLfskck4KN92BT1p1GTWRk+hVXrHJPvsf
        WIw7ZhpjP6PrYbJtySoM66T4G17/0EezMqilPGmPMg==
X-Google-Smtp-Source: ABdhPJxUCH5aZo8HNcHbdUS06B2iz7YpO0Z5RJr0Phvi1i+pX2K7NddgPRzWHHeZmi01iZghm7e3vWM7VMUd7b8x8go=
X-Received: by 2002:a05:620a:e0c:: with SMTP id y12mr2303562qkm.109.1640099508387;
 Tue, 21 Dec 2021 07:11:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1640036051.git.andreyknvl@google.com> <c3fa42da7337bc46a4b7a1e772e87bed5ff89850.1640036051.git.andreyknvl@google.com>
In-Reply-To: <c3fa42da7337bc46a4b7a1e772e87bed5ff89850.1640036051.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 21 Dec 2021 16:11:11 +0100
Message-ID: <CAG_fn=UHZe+9sSkpc0=2HWP9ZeVNWU0jR2tEVS-4FP5+zRB6sA@mail.gmail.com>
Subject: Re: [PATCH mm v4 22/39] kasan, fork: reset pointer tags of vmapped stacks
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 11:01 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Once tag-based KASAN modes start tagging vmalloc() allocations,
> kernel stacks start getting tagged if CONFIG_VMAP_STACK is enabled.
>
> Reset the tag of kernel stack pointers after allocation in
> alloc_thread_stack_node().
>
> For SW_TAGS KASAN, when CONFIG_KASAN_STACK is enabled, the
> instrumentation can't handle the SP register being tagged.
>
> For HW_TAGS KASAN, there's no instrumentation-related issues. However,
> the impact of having a tagged SP register needs to be properly evaluated,
> so keep it non-tagged for now.
>
> Note, that the memory for the stack allocation still gets tagged to
> catch vmalloc-into-stack out-of-bounds accesses.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
>
> ---
>
> Changes v2->v3:
> - Update patch description.
> ---
>  kernel/fork.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 403b9dbbfb62..4125373dba4e 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -254,6 +254,7 @@ static unsigned long *alloc_thread_stack_node(struct =
task_struct *tsk, int node)
>          * so cache the vm_struct.
>          */
>         if (stack) {
> +               stack =3D kasan_reset_tag(stack);
>                 tsk->stack_vm_area =3D find_vm_area(stack);
>                 tsk->stack =3D stack;
>         }
> --
> 2.25.1
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
