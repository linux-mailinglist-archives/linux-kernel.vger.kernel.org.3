Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4EE546F8C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 00:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348650AbiFJWL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 18:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbiFJWL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 18:11:26 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447CB2298CD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 15:11:25 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id u99so809967ybi.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 15:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MWULRuSNXNvUEP1Aer8U7L9Ej544qFLzNxmzAHlw9Pw=;
        b=DMsHdGeOrxFX3Q3VVCcrWgdPzggW0zIlKCsvOoT8IqZDJXWH6GWTpTxASJMkjLqzLS
         G9oxlnOK2EX3VgE/AlkwLPG1IzbWP86fWV/NyqfIv3xxqeRd2bTmYv++Ur6CCnGZ11VG
         5p72dWnW32cQyiXXCZLkkzSwe7bEzLfyMm+KdprsqaRDJM2mPtSwhvDZo0Mhk/b/XVVC
         26fbHJ3HMDZimScebK7fWgVMTFW067HpMh6AHMO22eOMa2ImsAjlcbxM0rV/E+X13l6k
         fP5PgM2dF4RNKzpLtjPeHIxoJwl9yrkCW5zQmKBMvIujoI8LJ0mdfPsxtQJBtWrUoJKO
         u2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MWULRuSNXNvUEP1Aer8U7L9Ej544qFLzNxmzAHlw9Pw=;
        b=LhC4MLjq+tak+Au9o1I0L1FkOoSJodTIJiDiyUxfFiGFaOhnaxVrg41o7oz2FjKkyD
         GiwCfRgHAkKx78fU6ih7H5kJsIWkpPdWeZu9PBOspNcJ2dM7RhlBvvg6/pk4EC0n+8SU
         Xu4hVfNzH0jaVY/SBW/GvdT9omjEWHyrNcdh4ZtT0id81AVEsJg5hic3pOzL63gkozmL
         6WPANsjfl/tqwWipeeS/pbSBMg3weU6DvTj9cvDwPcdAImOg7k3mbjrwRitgo5qDoCGj
         H6R9OergADGOXh1RPG5xwRgTZOy9+gDvNeVt2kwwa3RnBzpHNemsXtvVecZSe+y/M24J
         MhBQ==
X-Gm-Message-State: AOAM5336IRDWUfyURVoEMGlsJ18UPjtEEnEnTu9S+85ro3Wn7OIJIiYa
        KhA8Z8oMsJTIXmR6jLJrIx5+Tug1QL0NORFcHTo=
X-Google-Smtp-Source: ABdhPJynbO6LgQ+QlXC55LFtwEklynXKQQ9YZpF6vndRqPw5yzIb9NyDi0qa0MOE+jlFG4At4Fc4JivkHS7hiOLtxRk=
X-Received: by 2002:a25:7d47:0:b0:663:9da0:8502 with SMTP id
 y68-20020a257d47000000b006639da08502mr27136576ybc.43.1654899084351; Fri, 10
 Jun 2022 15:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220606202109.1306034-1-ankur.a.arora@oracle.com> <20220606203725.1313715-5-ankur.a.arora@oracle.com>
In-Reply-To: <20220606203725.1313715-5-ankur.a.arora@oracle.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Fri, 10 Jun 2022 15:11:13 -0700
Message-ID: <CAFUsyf+kDgApUu-q=FOh1WD=yzJqvTSYpHywyNteFubnKFa98A@mail.gmail.com>
Subject: Re: [PATCH v3 09/21] x86/asm: add clear_pages_movnt()
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        X86 ML <x86@kernel.org>, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        mingo@kernel.org, Andy Lutomirski <luto@kernel.org>,
        tglx@linutronix.de, Borislav Petkov <bp@alien8.de>,
        peterz@infradead.org, ak@linux.intel.com, arnd@arndb.de,
        jgg@nvidia.com, jon.grimm@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, joao.m.martins@oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 6, 2022 at 11:39 PM Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
> Add clear_pages_movnt(), which uses MOVNTI as the underlying primitive.
> With this, page-clearing can skip the memory hierarchy, thus providing
> a non cache-polluting implementation of clear_pages().
>
> MOVNTI, from the Intel SDM, Volume 2B, 4-101:
>  "The non-temporal hint is implemented by using a write combining (WC)
>   memory type protocol when writing the data to memory. Using this
>   protocol, the processor does not write the data into the cache
>   hierarchy, nor does it fetch the corresponding cache line from memory
>   into the cache hierarchy."
>
> The AMD Arch Manual has something similar to say as well.
>
> One use-case is to zero large extents without bringing in never-to-be-
> accessed cachelines. Also, often clear_pages_movnt() based clearing is
> faster once extent sizes are O(LLC-size).
>
> As the excerpt notes, MOVNTI is weakly ordered with respect to other
> instructions operating on the memory hierarchy. This needs to be
> handled by the caller by executing an SFENCE when done.
>
> The implementation is straight-forward: unroll the inner loop to keep
> the code similar to memset_movnti(), so that we can gauge
> clear_pages_movnt() performance via perf bench mem memset.
>
>  # Intel Icelakex
>  # Performance comparison of 'perf bench mem memset -l 1' for x86-64-stosb
>  # (X86_FEATURE_ERMS) and x86-64-movnt:
>
>  System:      Oracle X9-2 (2 nodes * 32 cores * 2 threads)
>  Processor:   Intel Xeon(R) Platinum 8358 CPU @ 2.60GHz (Icelakex, 6:106:6)
>  Memory:      512 GB evenly split between nodes
>  LLC-size:    48MB for each node (32-cores * 2-threads)
>  no_turbo: 1, Microcode: 0xd0001e0, scaling-governor: performance
>
>               x86-64-stosb (5 runs)     x86-64-movnt (5 runs)    Delta(%)
>               ----------------------    ---------------------    --------
>      size            BW   (   stdev)          BW    (   stdev)
>
>       2MB      14.37 GB/s ( +- 1.55)     12.59 GB/s ( +- 1.20)   -12.38%
>      16MB      16.93 GB/s ( +- 2.61)     15.91 GB/s ( +- 2.74)    -6.02%
>     128MB      12.12 GB/s ( +- 1.06)     22.33 GB/s ( +- 1.84)   +84.24%
>    1024MB      12.12 GB/s ( +- 0.02)     23.92 GB/s ( +- 0.14)   +97.35%
>    4096MB      12.08 GB/s ( +- 0.02)     23.98 GB/s ( +- 0.18)   +98.50%

For these sizes it may be worth it to save/rstor an xmm register to do
the memset:

Just on my Tigerlake laptop:
model name : 11th Gen Intel(R) Core(TM) i7-1165G7 @ 2.80GHz

                  movntdq xmm (5 runs)          movnti GPR (5 runs)
    Delta(%)
                  -----------------------       -----------------------
           size      BW GB/s ( +-  stdev)          BW GB/s ( +-
stdev)         %
           2 MB   35.71 GB/s ( +-   1.02)       34.62 GB/s ( +-
0.77)    -3.15%
          16 MB   36.43 GB/s ( +-   0.35)        31.3 GB/s ( +-
0.1)   -16.39%
         128 MB    35.6 GB/s ( +-   0.83)       30.82 GB/s ( +-
0.08)    -15.5%
        1024 MB   36.85 GB/s ( +-   0.26)       30.71 GB/s ( +-
0.2)    -20.0%
>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  arch/x86/include/asm/page_64.h |  1 +
>  arch/x86/lib/clear_page_64.S   | 21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
> index a88a3508888a..3affc4ecb8da 100644
> --- a/arch/x86/include/asm/page_64.h
> +++ b/arch/x86/include/asm/page_64.h
> @@ -55,6 +55,7 @@ extern unsigned long __phys_addr_symbol(unsigned long);
>  void clear_pages_orig(void *page, unsigned long npages);
>  void clear_pages_rep(void *page, unsigned long npages);
>  void clear_pages_erms(void *page, unsigned long npages);
> +void clear_pages_movnt(void *page, unsigned long npages);
>
>  #define __HAVE_ARCH_CLEAR_USER_PAGES
>  static inline void clear_pages(void *page, unsigned int npages)
> diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
> index 2cc3b681734a..83d14f1c9f57 100644
> --- a/arch/x86/lib/clear_page_64.S
> +++ b/arch/x86/lib/clear_page_64.S
> @@ -58,3 +58,24 @@ SYM_FUNC_START(clear_pages_erms)
>         RET
>  SYM_FUNC_END(clear_pages_erms)
>  EXPORT_SYMBOL_GPL(clear_pages_erms)
> +
> +SYM_FUNC_START(clear_pages_movnt)
> +       xorl    %eax,%eax
> +       movq    %rsi,%rcx
> +       shlq    $PAGE_SHIFT, %rcx
> +
> +       .p2align 4
> +.Lstart:
> +       movnti  %rax, 0x00(%rdi)
> +       movnti  %rax, 0x08(%rdi)
> +       movnti  %rax, 0x10(%rdi)
> +       movnti  %rax, 0x18(%rdi)
> +       movnti  %rax, 0x20(%rdi)
> +       movnti  %rax, 0x28(%rdi)
> +       movnti  %rax, 0x30(%rdi)
> +       movnti  %rax, 0x38(%rdi)
> +       addq    $0x40, %rdi
> +       subl    $0x40, %ecx
> +       ja      .Lstart
> +       RET
> +SYM_FUNC_END(clear_pages_movnt)
> --
> 2.31.1
>
