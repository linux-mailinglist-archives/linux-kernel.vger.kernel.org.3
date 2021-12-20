Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B22647B5BF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 23:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbhLTWFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 17:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhLTWFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 17:05:16 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A4AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 14:05:15 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id m12so8756738ild.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 14:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Hk8y3FD8xJfm6RryiwKYMpYBDu8nYDhrS0Z2nhR5mA=;
        b=Zab6bdqgsKpO/zQHt+XcX2McS19UTV7AO/xgbFVS71bQM/pdfVeLhUfqVN9sbQwrYi
         UQRVvcptR4po4cGi4gGflZ2MwNW+R7g7+LApOjTh1u4bYS4/O6eKEcwLK3DYDwbgzQ/E
         WBXRoPSz9gLS+Fq6VBM8zBLcY8p0bm8HTH4D3SlMwqDu7196S7+iLZAE9GwvW2HVsk9+
         OajY7HJWg9NoHGWKpa0gtiSlK5VJ1PYud1yDl8KhKAnqJozT2oD7+dZkUT2kQTYUn+Qh
         X6agFgDTcpdwfw7izJoxE9P25nDqACdQuj/WNVMEv5dSaO/YEe3jnAQOizboCyml5rcr
         +bjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Hk8y3FD8xJfm6RryiwKYMpYBDu8nYDhrS0Z2nhR5mA=;
        b=M5TgS6jvUFccOhhOIDmU7NU1WvtcR6/B3nsUMdS/RDq40f447eyD5d8genMz2okuGv
         k0VZbqTOLxrpIlwsU/Hp5cI5QvWvB1xJRzDQ6jRLCyvlT+y+FgSjOsRwooBu0JKsj2Qk
         1aWntCiT81tdhfzNBdNPsTcusFwnQgJQB49tRiAktqkipGR22BIHUzkN62Pk/3UwOmQC
         rFCWFb/JK1T2y65OM+oSgLWCukTreEbAUI6GUa3j+q/8FCH/b6sL47/JNErrBJaAXPBK
         pBLvCLVzBYRCsfb+hdRZHXbMWsex1zmxZaM+c9UL7jIBbmbYJ4P8dsEfDiYS8b3QWY/e
         YnwA==
X-Gm-Message-State: AOAM533qSushjMAs+olxwBKmiuKzLSkJTmeEcXbLgPEOYsUMmHKz3OzF
        Uv0RvMkx3KOBGS433qMy+CsZxnKfY4iEG4S/rjc=
X-Google-Smtp-Source: ABdhPJzbEqrJ5y5giLAK2HsSF+gca53GPFIF+26Au4MRdQDxf+RBp07h+hyXC7+c0b4HcvLGOf9GPlX21+NDcLtg7FM=
X-Received: by 2002:a05:6e02:178f:: with SMTP id y15mr19677ilu.235.1640037915336;
 Mon, 20 Dec 2021 14:05:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1640036051.git.andreyknvl@google.com> <85ecef50788a3915a9a8fb52e97207901f27b057.1640036051.git.andreyknvl@google.com>
In-Reply-To: <85ecef50788a3915a9a8fb52e97207901f27b057.1640036051.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 20 Dec 2021 23:05:04 +0100
Message-ID: <CA+fCnZdzzu=Fk_pyxCU3jCHkb0GW-nDA0E7svVfEeYVtRHSmsQ@mail.gmail.com>
Subject: Re: [PATCH mm v4 32/39] kasan, arm64: don't tag executable vmalloc allocations
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
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

On Mon, Dec 20, 2021 at 11:02 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Besides asking vmalloc memory to be executable via the prot argument
> of __vmalloc_node_range() (see the previous patch), the kernel can skip
> that bit and instead mark memory as executable via set_memory_x().
>
> Once tag-based KASAN modes start tagging vmalloc allocations, executing
> code from such allocations will lead to the PC register getting a tag,
> which is not tolerated by the kernel.
>
> Generic kernel code typically allocates memory via module_alloc() if
> it intends to mark memory as executable. (On arm64 module_alloc()
> uses __vmalloc_node_range() without setting the executable bit).
>
> Thus, reset pointer tags of pointers returned from module_alloc().
>
> However, on arm64 there's an exception: the eBPF subsystem. Instead of
> using module_alloc(), it uses vmalloc() (via bpf_jit_alloc_exec())
> to allocate its JIT region.
>
> Thus, reset pointer tags of pointers returned from bpf_jit_alloc_exec().
>
> Resetting tags for these pointers results in untagged pointers being
> passed to set_memory_x(). This causes conflicts in arithmetic checks
> in change_memory_common(), as vm_struct->addr pointer returned by
> find_vm_area() is tagged.
>
> Reset pointer tag of find_vm_area(addr)->addr in change_memory_common().
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> ---
>
> Changes v3->v4:
> - Reset pointer tag in change_memory_common().
>
> Changes v2->v3:
> - Add this patch.
> ---
>  arch/arm64/kernel/module.c    | 3 ++-
>  arch/arm64/mm/pageattr.c      | 2 +-
>  arch/arm64/net/bpf_jit_comp.c | 3 ++-
>  3 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
> index d3a1fa818348..f2d4bb14bfab 100644
> --- a/arch/arm64/kernel/module.c
> +++ b/arch/arm64/kernel/module.c
> @@ -63,7 +63,8 @@ void *module_alloc(unsigned long size)
>                 return NULL;
>         }
>
> -       return p;
> +       /* Memory is intended to be executable, reset the pointer tag. */
> +       return kasan_reset_tag(p);
>  }
>
>  enum aarch64_reloc_op {
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index a3bacd79507a..64e985eaa52d 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -85,7 +85,7 @@ static int change_memory_common(unsigned long addr, int numpages,
>          */
>         area = find_vm_area((void *)addr);
>         if (!area ||
> -           end > (unsigned long)area->addr + area->size ||
> +           end > (unsigned long)kasan_reset_tag(area->addr) + area->size ||
>             !(area->flags & VM_ALLOC))
>                 return -EINVAL;
>
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 07aad85848fa..381a67922c2d 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1147,7 +1147,8 @@ u64 bpf_jit_alloc_exec_limit(void)
>
>  void *bpf_jit_alloc_exec(unsigned long size)
>  {
> -       return vmalloc(size);
> +       /* Memory is intended to be executable, reset the pointer tag. */
> +       return kasan_reset_tag(vmalloc(size));
>  }
>
>  void bpf_jit_free_exec(void *addr)
> --
> 2.25.1

Hi Catalin,

I had to change this patch to fix an issue I discovered during
testing. Could you PTAL once again?

Thanks!
