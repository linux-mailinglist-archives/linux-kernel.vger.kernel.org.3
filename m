Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39B64A5179
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 22:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358076AbiAaVbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 16:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241365AbiAaVbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:31:15 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62CCC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:31:14 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id p125so13452201pga.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=euvri5MbsGrE+v+kTfVEgObI2Y6QhDM6kqPkM69TlfQ=;
        b=KRMwnS74hwkMxr23OMbJ0cdMukWTu4tX3Qey8TTzo+qha901QdnqqBFjhhHQK8us3i
         Ucijw5hKEl8XXCuZ5k1ndLzR3eWmVIdOYileed7eyEXS45AL0AcdQWPTwM2qL01RdLbh
         wBj1ezhpUHOr8DR8m707uPLqbSmTzcxVSrHPFNeIZTVcmWm23CVcDT9cbzNp4d5i3j9Z
         QnuExooFeYMRvN5ghvgcBST5VzIkv6uWt/JVFEYusLET52YjxtKuRByyenPC8/B6GGVX
         /LxZbtsd2CwNfvf/IxbmC5sLPO09qO49Pf5mEJZavPdcpkz0s8O6YUYEAEoqB8zL6OcY
         liAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=euvri5MbsGrE+v+kTfVEgObI2Y6QhDM6kqPkM69TlfQ=;
        b=j9miaugANFuuV7XO19ARhuU2Cv90l6Dc/KRURvkVIgpvBD4WMnwzHRI1RLsk6cOukt
         M5SXG1Y64dxZcfsnZUYaO8JVGFwYidQR6Q7SJCawGnKJ7JVRga+n5+TqyRpQjk5kQCV0
         BjYd9xFbhS5HGcghVGcyEGzv6BKp7/97/Hmp2HSZpcos/5ZYPi+WlnuKXeFlD2B+JHKh
         BWntVOtt6J2fw/12PBwGAkZcGrGzIkv52MVUrR8CbqWS7ElRF0P5i8LCdrVYxWbIiX8a
         wvrZec2zFf2M3LK8cCJTTODE6vyNO0Zq5hXw9Y8ZvZ6xDpvB18HY3nGY4EvDDwvXRYmw
         /J5w==
X-Gm-Message-State: AOAM531cNwIxMFRduUeeN59MPIx5RPB8G+wh/hkeYhOl+50WwjxjmjFJ
        tTfWIcbgCj2WzjrDV67ch2H+GbSHwlBSE0CZJbA=
X-Google-Smtp-Source: ABdhPJwy55TI7QG154oSq4OE+hBkDxPt8mlCSSssff55lGgIARdfkbVDMVT1Y0vdQSeuprxdLVoHrbA/fllTiTQPZbg=
X-Received: by 2002:aa7:888b:: with SMTP id z11mr16428972pfe.76.1643664674047;
 Mon, 31 Jan 2022 13:31:14 -0800 (PST)
MIME-Version: 1.0
References: <20220131201716.5198-1-a3at.mail@gmail.com>
In-Reply-To: <20220131201716.5198-1-a3at.mail@gmail.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Mon, 31 Jan 2022 13:30:38 -0800
Message-ID: <CAMe9rOqoPy6jsWrodnc41M4+b2onwkfbfr=pZ9qRWzOU2Uisgg@mail.gmail.com>
Subject: Re: [PATCH] fs/binfmt_elf: use ELF_ET_DYN_BASE for PIE (ET_DYN with
 INTERP) binaries
To:     Azat Khuzhin <a3at.mail@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Chris Kennelly <ckennelly@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Song Liu <songliubraving@fb.com>,
        David Rientjes <rientjes@google.com>,
        Ian Rogers <irogers@google.com>,
        Hugh Dickins <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 12:17 PM Azat Khuzhin <a3at.mail@gmail.com> wrote:
>
> Since 9630f0d60fec ELF_ET_DYN_BASE is not used as a load_bias anymore
> and this breaks PIE binaries, since after this change data segment
> became too nearby the stack:
>
> Before 9630f0d60fec:
>
>     $ strace -febrk /tmp/test-stack |& head
>     brk(NULL)                               = 0x555555559000
>     $ /tmp/test-stack
>     bottom_of_stack = 0x7fffffffc5c0
>     recursion depth: 1 (stack diff: 32)
>     ...
>     recursion depth: 7690 (stack diff: 8365664)
>     Segmentation fault (core dumped)
>
> After 9630f0d60fec:
>
>     $ strace -ebrk /tmp/test-stack  |& head
>     brk(NULL)                               = 0x7ffff7fff000
>
>     $ /tmp/test-stack
>     bottom_of_stack = 0x7fffffffc640
>     recursion depth: 1 (stack diff: 32)
>     ...
>     recursion depth: 146 (stack diff: 157792)
>     Segmentation fault (core dumped)
>
> Found this during compiling with clang, that started to randomly
> SIGSEGV when it eats some heap.

How do I reproduce it on x86-64?

> Reproducer:
>
>     #include <stdio.h>
>     #include <stddef.h>
>     #include <stdlib.h>
>
>     static int depth = 0;
>     static void* bottom_of_stack;
>
>     int inner()
>     {
>         char buffer[1024];
>         ptrdiff_t diff;
>         int ret;
>
>         ++depth;
>         diff = bottom_of_stack - __builtin_frame_address(0);
>
>         fprintf(stderr,
>                 "recursion depth: %i (stack diff: %zu)\n",
>                 depth, (size_t)diff);
>
>         for (size_t i = 0; i < 1024; ++i)
>                 ret += buffer[i];
>
>         ret += inner();
>
>         return ret;
>     }
>
>     int main()
>     {
>         for (size_t size = 0; size < 128<<20; size += 16<<10)
>                 malloc(16<<10);
>
>         bottom_of_stack = __builtin_frame_address(0);
>         fprintf(stderr, "bottom_of_stack = %p\n", bottom_of_stack);
>         inner();
>     }
>
> Fixes: 9630f0d60fec ("fs/binfmt_elf: use PT_LOAD p_align values for static PIE")
> Signed-off-by: Azat Khuzhin <a3at.mail@gmail.com>
> Cc: Chris Kennelly <ckennelly@google.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Sandeep Patil <sspatil@google.com>
> Cc: Fangrui Song <maskray@google.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: H.J. Lu <hjl.tools@gmail.com>
> ---
>  fs/binfmt_elf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 605017eb9349..9e11e6f13e83 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1117,7 +1117,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>                          * without MAP_FIXED nor MAP_FIXED_NOREPLACE).
>                          */
>                         alignment = maximum_alignment(elf_phdata, elf_ex->e_phnum);
> -                       if (alignment > ELF_MIN_ALIGN) {
> +                       if (interpreter || alignment > ELF_MIN_ALIGN) {
>                                 load_bias = ELF_ET_DYN_BASE;
>                                 if (current->flags & PF_RANDOMIZE)
>                                         load_bias += arch_mmap_rnd();
> --
> 2.35.1
>


-- 
H.J.
