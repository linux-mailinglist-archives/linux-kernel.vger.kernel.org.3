Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF4950BE01
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbiDVRLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236877AbiDVRLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:11:15 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66DD8BF12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:08:19 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id q185so1221659ljb.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ydRGpptIb5w81SmMvS/nipUS4vYlFd2laIjOx1l84s=;
        b=Lvd464N6kYN0JkSu1d8HO48IyDf7HODgjimqZsNgT54ppx6uKMwlrVXLSjUGD98RhY
         Pq0tcSZ4P6rrA2KwURvfmZxdD/Rhh4j7v6eCQuGetT0NswRtG/u1JUAK4PZA48TMiRyP
         uy1ByLyEeu1hJJmzsmM51y7T/M7OtsP2SKMmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ydRGpptIb5w81SmMvS/nipUS4vYlFd2laIjOx1l84s=;
        b=BmNFrkdy60txAbwED9SCqVxzrIhQLN1/kKbEkDzs5IVemNxLwznVFdKXIVxxwUXviD
         EgMhpEZlChhPB+Ug5paq6/FXHj8YFANMsTwXLdju5fBZSLumwScYatYriCkhcVGhcqJD
         dtTNuJHDk9xDjnvBzyn/OzyKQbs7MdqOAuPxnOzYLoGjdfOkLsNDzj66lBRQMQF5Lk6M
         30pLXBj34cRQzBn3FLARfPvQRO3DNzkLgUytsPtvWw1D52r0kLDn8KlMIrPkEIraSF6e
         FzJMWPOfDJVDHcQTHEeZvwoPbF/5pgkK8vWUnGzUZR86On01HByIRBuMsc1bZg0/dsYp
         a2pA==
X-Gm-Message-State: AOAM5338kZNt6Cyzfe1HckQ1JOtxJhXfvneQeUCZizMY3tKLZA3GiInF
        2UpqTGrV7et68Hh3YH262bM7IJ+yVjCRDkzhIFg=
X-Google-Smtp-Source: ABdhPJxQAG0E+R1T44LLsvmWZ4RSwb2HVgy1IFyW72l75+pus+CFslqXaQ09cfsI/KrA4NI3tT/rmQ==
X-Received: by 2002:a05:651c:179a:b0:247:d37b:6ec5 with SMTP id bn26-20020a05651c179a00b00247d37b6ec5mr3245071ljb.112.1650647297771;
        Fri, 22 Apr 2022 10:08:17 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id w22-20020a194916000000b0046ba5a6ff16sm288861lfa.11.2022.04.22.10.08.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 10:08:17 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id bf11so10402498ljb.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:08:17 -0700 (PDT)
X-Received: by 2002:a2e:b818:0:b0:24c:ce86:e6d6 with SMTP id
 u24-20020a2eb818000000b0024cce86e6d6mr3398453ljo.443.1650647296730; Fri, 22
 Apr 2022 10:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220422060107.781512-1-npiggin@gmail.com> <20220422060107.781512-3-npiggin@gmail.com>
In-Reply-To: <20220422060107.781512-3-npiggin@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Apr 2022 10:08:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgFoWLCV9aPHkHe1Mpu0XqxYWaPkKLpe_hcsTS_Vx3aRA@mail.gmail.com>
Message-ID: <CAHk-=wgFoWLCV9aPHkHe1Mpu0XqxYWaPkKLpe_hcsTS_Vx3aRA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "vmalloc: replace VM_NO_HUGE_VMAP with VM_ALLOW_HUGE_VMAP"
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 11:01 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> This reverts commit 559089e0a93d44280ec3ab478830af319c56dbe3
>
> The previous commit fixes huge vmalloc for drivers that use the
> vmalloc_to_page() struct pages.

Yeah, no.

The very revert shows the problem:

> --- a/arch/powerpc/kernel/module.c
> +++ b/arch/powerpc/kernel/module.c
> @@ -101,7 +101,7 @@ __module_alloc(unsigned long size, unsigned long start, unsigned long end, bool
>          * too.
>          */
>         return __vmalloc_node_range(size, 1, start, end, gfp, prot,
> -                                   VM_FLUSH_RESET_PERMS,
> +                                   VM_FLUSH_RESET_PERMS | VM_NO_HUGE_VMAP,
>                                     NUMA_NO_NODE, __builtin_return_address(0));

This VM_NO_HUGE_VMAP is a sign of the fact that using hugepages for
mapping still isn't a transparent operation.

Now, in some cases that would be perfectly fine, ie the s390 case has
a nice clear comment about how it's a very special case:

> +       /*
> +        * The Create Secure Configuration Ultravisor Call does not support
> +        * using large pages for the virtual memory area.
> +        * This is a hardware limitation.
> +        */
> +       kvm->arch.pv.stor_var = vmalloc_no_huge(vlen);

but as long as it is "anything that plays permission games with the
mapping is broken" we are not reverting that opt-in thing.

And no, it's not just that powerpc module code that is somehow magical.

This is the exact same issue that the bpf people hit.

It's also elsewhere, although it might well be hidden by "small
allocations will never trigger this" (eg the arm64 kprobes case only
does a single page).

I also wonder how this affects any use of 'set_memory_xyz()' with
partial mappings (I can point to "frob_text()" and friends for
modules, but I can easily imagine drivers doing odd things).

In particular, x86 does support pmd splitting for pmd's in
set_memory_xyz(), but I *really* couldn't tell you that it's ok with a
largepage that has already had its page counts split.

It only used to hit the big IO mappings traditionally.

Now I *think* it JustWorks(tm) - I don't actually see any obvious
problems there - and I also really hope that nobody actually even does
that "partial set_memory" on some vmalloc allocation in the first
place, but no, that kind of "let's hope" is not ok.

And we already know it happens at least for modules.

And no, don't even start about that "it's x86".  It *still* isn't
about x86 as shown by this very patch. The issue is generic, and x86
just tends to hit more odd cases and drivers.

In fact, I think x86 probably does *better* than powerpc.

Because it looks like 'set_memory_xyz()' just returns an error for
vmalloc addresses on powerpc. Sounds strange. Doesn't powerpc do
STRICT_MODULE_RWX? Does it work only because 'frob_text()' doesn't
actually check the return value?

Or maybe set_memory_xyz() is ok and it is *only* VM_FLUSH_RESET_PERMS
that doesn't work? I don't know.

But I do know bpf was affected, and I'm looking at that module thing,
and so I suspect it's elsewhere too.

Just opt-in with the mappings that matter.

                   Linus
