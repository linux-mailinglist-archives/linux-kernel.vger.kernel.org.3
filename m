Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D76474C28
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 20:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237465AbhLNTmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 14:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbhLNTmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 14:42:13 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9227EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 11:42:13 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id p65so26237214iof.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 11:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=46avN96nbskMUAFWXD0G4IICxhuVMqWM0c7esNIiqMg=;
        b=ew5BVOtU7X5oUwTQZlarYRrQHTSpfsszZXVQ0r8X5Bs2Vcymhf6eOzOKE3Ji49kpxr
         zgI/89XMXPio0g8DWR5Uxztyd+MizHHtvVqKHcfJiUlpjXlaQ5xcilvaOvzJAwlGpIb5
         /+svTql0qmsj1ig4VPS/Zysy4s51h8M3LTD3+1Uiv9P8G1m8ybV2QO/KZGG8Yb9Spepf
         0wyJE4hDrI5D1XxUBrWDyB3SUhZKjd6wxRFEWSg1c7vOoKh3Kl2xVvZPbhUnhL52wFtt
         /Vq2wRN4hlQPVVSaUt1AvCrUC9aisapMYJxTMH+dFQD/XGqa8GhKTjykvkdoRsiMdrdE
         iFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=46avN96nbskMUAFWXD0G4IICxhuVMqWM0c7esNIiqMg=;
        b=HFEpnMA+Uww6DHq0oYV7y8Eod7dok4xSQSZ3yTAXj6QY18JE1ExYIkGZvMRGgoLjSn
         L9DYQUofZQpEn3pOcvHxjRzukyj3U/+7W7lnb504HP2D6qEsCGiioj/Z1OPvq3+eo64w
         TFOorVEL1/l2YiiR2oimcdSrjR3Ee48Qc8XdhN3t7mcNaAZL2lZ51+yXFaaNWAwHxpdv
         zFzHZyM6kLlkX9sW/iIgeqTFHTQwBLOB7FZjBEyhLrrEQRXq6jcVVrYK1+zClDq7mMxd
         1cNBrim9wX7883tRLuwiMSyOHzvfbqUczwYEp5X7yExpip+iIPjX6/uOz1QPzn9eIrhF
         U5IA==
X-Gm-Message-State: AOAM532EaXIRjyH0HwOSaUNqD3UfIH4ZOHBVdGoIudQF8mu7lcUjOs2n
        envLVH3B937OgmK8RiVpN6WS16O03YdoMVBx7Eo=
X-Google-Smtp-Source: ABdhPJxdsOqYQ1pKobWbQy/onfaa6DITWMD3VZOL7D7HM5A5kmhnFDRiADZ4ifd/Bo6glHWYCqsO7qRPFNji1uE5688=
X-Received: by 2002:a02:830e:: with SMTP id v14mr4174019jag.644.1639510930962;
 Tue, 14 Dec 2021 11:42:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1639432170.git.andreyknvl@google.com> <c77f819e87b9fefcb26c6448a027b25c939f079e.1639432170.git.andreyknvl@google.com>
In-Reply-To: <c77f819e87b9fefcb26c6448a027b25c939f079e.1639432170.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 14 Dec 2021 20:42:00 +0100
Message-ID: <CA+fCnZfP+j6ra4vExsOg96yVHTHQy_NB65-TT=S=9Gr1X62yiA@mail.gmail.com>
Subject: Re: [PATCH mm v3 30/38] kasan, vmalloc: don't tag executable vmalloc allocations
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 10:54 PM <andrey.konovalov@linux.dev> wrote:
>

[...]

> @@ -3133,10 +3133,14 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>          * (except for the should_skip_init() check) to make sure that memory
>          * is initialized under the same conditions regardless of the enabled
>          * KASAN mode.
> +        * Tag-based KASAN modes only assign tags to non-executable
> +        * allocations, see __kasan_unpoison_vmalloc().
>          */
>         kasan_flags = KASAN_VMALLOC_VM_ALLOC;
>         if (!want_init_on_free() && want_init_on_alloc(gfp_mask))
>                 kasan_flags |= KASAN_VMALLOC_INIT;
> +       if (pgprot_val(prot) == pgprot_val(pgprot_nx(prot)))

Can simply compare with PAGE_KERNEL here to match the check in
arch_vmalloc_pgprot_modify(). Will do in v4.

> +               kasan_flags |= KASAN_VMALLOC_NOEXEC;
>         addr = kasan_unpoison_vmalloc(addr, real_size, kasan_flags);
>
>         /*
> @@ -3844,7 +3848,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>         for (area = 0; area < nr_vms; area++)
>                 vms[area]->addr = kasan_unpoison_vmalloc(vms[area]->addr,
>                                                          vms[area]->size,
> -                                                        KASAN_VMALLOC_NONE);
> +                                                        KASAN_VMALLOC_NOEXEC);
>
>         kfree(vas);
>         return vms;
> --
> 2.25.1
>
