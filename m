Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89339473722
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 22:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243463AbhLMV7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 16:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243448AbhLMV7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 16:59:42 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D68C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:59:42 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id b187so20605469iof.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MRKR0iLm5s05rmkpI4jYkAhFh/8IVKgubKuDuwtAGZo=;
        b=BXPU2MKMaLSHJTBj5Fw+l85b1jn/pzQUVpMyk8A6WadXKXL91eftH/hXryN1YD02Bk
         yYJjKVCttnWtAu34nnoYtl5SDJsQBAt24aG9HH+TiEvggjxBVb1f6nz64e43tegiJtUy
         ns/h5Ks0DmU73WQJ8BXaSDsLcHJ8yT40QiXVFGWr3mhrvkLaS6wQEDtFg62pl+pgn4JV
         lam9uUklYEZLohMos1Kkdttx6dgFB4F2IKNStg8jD/r9JG9/TnOa2YgtxrOa4PfUcn4F
         UGpSoWkA//ZgRBnLkV6Sg7TxHWcmwoCYnStDA3T1VIeYXgaa7VmUFGF3VWze/Ab75IBm
         3HAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MRKR0iLm5s05rmkpI4jYkAhFh/8IVKgubKuDuwtAGZo=;
        b=Fb1tWkpLOFpLyCpjitMNg7QS+nEwqQID68e+mPYu+rEHrLawaDODB+e24hFrYJR+Id
         jBuP5peb60zb99+sewtWWRlYmewo7v8GwVuHFR2k14lSUuElS7ayIntEAHn05QROH3pE
         T7nAELvEWn/CvgH/2welDIOUwdQSNp3k24LXRL10fmeY3eZGp7oPw3wroQ63kXGCXp05
         I3GsiqZJ6BqXIe2UZNy9Dp5iTToSBhwfMqV1bhloAyVEpnBBe+xwtsEmA9Q9Yr1SiLJs
         dBBM3Cdb0bJUpRvefhT8cTnw7Va+5h2ZFuPc0Jw3uI6wkVuLCWiG+QRN/Bx0dWb+z7Uc
         YeHg==
X-Gm-Message-State: AOAM531PkQsgSYBBVJjj6Y0XWpO7GUqol3MGvY37YLqQAs6JeJC0uf3C
        YnSiPprb9D2Eo2kJ5K1AhkyWGXzWZySCFr0D3JU=
X-Google-Smtp-Source: ABdhPJxKp/i/u1m5HrD6sit7Rz5BFQRyACLGkQ1BCEa+r9UaBHJfr/S2oR06BO7c2NWiVg/7Z7ItGu9Si9PxaCbBSuU=
X-Received: by 2002:a05:6602:2c94:: with SMTP id i20mr967459iow.99.1639432781773;
 Mon, 13 Dec 2021 13:59:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1639432170.git.andreyknvl@google.com> <bc9f6cb3df24eb076a6d99f91f97820718f3e29e.1639432170.git.andreyknvl@google.com>
In-Reply-To: <bc9f6cb3df24eb076a6d99f91f97820718f3e29e.1639432170.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 13 Dec 2021 22:59:30 +0100
Message-ID: <CA+fCnZcwODsqmzHBXYi7GZWV_4ADCu72S60B7fqQikCHYdTYPQ@mail.gmail.com>
Subject: Re: [PATCH mm v3 23/38] kasan, arm64: reset pointer tags of vmapped stacks
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        andrey.konovalov@linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 10:54 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Once tag-based KASAN modes start tagging vmalloc() allocations,
> kernel stacks start getting tagged if CONFIG_VMAP_STACK is enabled.
>
> Reset the tag of kernel stack pointers after allocation in
> arch_alloc_vmap_stack().
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
>
> ---
>
> Changes v2->v3:
> - Add this patch.
> ---
>  arch/arm64/include/asm/vmap_stack.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/vmap_stack.h b/arch/arm64/include/asm/vmap_stack.h
> index 894e031b28d2..20873099c035 100644
> --- a/arch/arm64/include/asm/vmap_stack.h
> +++ b/arch/arm64/include/asm/vmap_stack.h
> @@ -17,10 +17,13 @@
>   */
>  static inline unsigned long *arch_alloc_vmap_stack(size_t stack_size, int node)
>  {
> +       void *p;
> +
>         BUILD_BUG_ON(!IS_ENABLED(CONFIG_VMAP_STACK));
>
> -       return __vmalloc_node(stack_size, THREAD_ALIGN, THREADINFO_GFP, node,
> +       p = __vmalloc_node(stack_size, THREAD_ALIGN, THREADINFO_GFP, node,
>                         __builtin_return_address(0));
> +       return kasan_reset_tag(p);
>  }
>
>  #endif /* __ASM_VMAP_STACK_H */
> --
> 2.25.1
>

Catalin, Vincenzo,

This is a new patch added in v3. Could you PTAL? Thanks!
