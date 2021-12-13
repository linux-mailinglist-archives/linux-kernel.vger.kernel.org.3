Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7DB473724
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 22:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243472AbhLMV7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 16:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243466AbhLMV7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 16:59:46 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F21C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:59:46 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id t1so3406429ils.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BNW1RvPQZwm1C5HKSe2mnjCE7ya9sQIsxIsz8L3X9Xo=;
        b=AFw0EAZVYhtZb0kjOzExWi8L294KFToI1Em3urGtFjSQd9JkW7HjFQ4iOp6lcdkTDs
         s0KIuURm3rHMjTYCFxnzDKQlNvw3GNad4PAvf/7jFd0feQzei3a80L5AQbp4+2nUsdZl
         jZCgp9p/1Hr6AnkKBZ/OE1bWN7IZ7Gi7ubTdEccmlU882chctjUEhw64P7vq+pjGuqav
         ubgjskP7/39W6k9MPSe/ZFUrtf+cQ9W0v0CyU3bo8wOW2z6VdIVHpYaRBoAxMkywbiAE
         110JqPwMiLmJyFXVjTlD3G9dQZRWEn/fptDxE9Yddf6QBLjRbFg7PPH0dnQswAHxQktH
         XVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BNW1RvPQZwm1C5HKSe2mnjCE7ya9sQIsxIsz8L3X9Xo=;
        b=wzlv124RSnHcz3E0DkLioaGJv+Y2BVWcGb0W7PuSv4CyqXY44Mj/Sjz4VdtgltKRqO
         z7UG2IH8nn1ELPa+1kIs7+hlPuxC7QoaZz9g+0PzR31kwtSTGEnCNuiItg27IfG0YoXV
         POnZZeshsBz6+ZqSfk1uKhRrH7MmR15Zu3vZzXRXS5iHG3LF60D++uk1ifmkj0CWUuS5
         xqwzSrtc1JMgymWSXrNvYWf8j7xXNYItv/kBkDdSVMIJFYbBIqgtf3cKu9lJc+bY+V8n
         4v+7DeHWawEI1geUSLIT+UHMPDnZ+ZtMZHxhKZikENHiVuOsvJPQNamJ+gDz2c4Fx4xR
         SPhw==
X-Gm-Message-State: AOAM5304uP+ZKDLZPtPBn02z0Po6USXyGbZVMNRAUzMT487IJrYTwswA
        OOThMOZMVbkGen5ydJD0j5ZFfbjdbYS3gwk5Mfs=
X-Google-Smtp-Source: ABdhPJw/1rN4lq8DuEoGuVwsZabrwHwTtkKTIszhbJcLxpcHOEkIJwhJK1EKrYh44rTOBDgVCMPkoPzceaTP/CJTLBA=
X-Received: by 2002:a05:6e02:f07:: with SMTP id x7mr921673ilj.28.1639432785937;
 Mon, 13 Dec 2021 13:59:45 -0800 (PST)
MIME-Version: 1.0
References: <cover.1639432170.git.andreyknvl@google.com> <4a5ec956a2666c1f967c9789534a8ac4d4fe26f9.1639432170.git.andreyknvl@google.com>
In-Reply-To: <4a5ec956a2666c1f967c9789534a8ac4d4fe26f9.1639432170.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 13 Dec 2021 22:59:35 +0100
Message-ID: <CA+fCnZd9n1S59mJewsTnN+u-Ng0prrjYhOw4KJWzVKBLf5FtQA@mail.gmail.com>
Subject: Re: [PATCH mm v3 31/38] kasan, arm64: don't tag executable vmalloc allocations
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

On Mon, Dec 13, 2021 at 10:55 PM <andrey.konovalov@linux.dev> wrote:
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
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> ---
>
> Changes v2->v3:
> - Add this patch.
> ---
>  arch/arm64/kernel/module.c    | 3 ++-
>  arch/arm64/net/bpf_jit_comp.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
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
>

Catalin, Vincenzo,

This is a new patch added in v3. Could you PTAL? Thanks!
