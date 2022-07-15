Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7C1575DF5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 11:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbiGOJC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 05:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiGOJCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 05:02:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C736813F1F;
        Fri, 15 Jul 2022 02:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KMXSNWGMHmJ+jj9ZYeAtw7H2e/KJpSnJYKi5iWOk7l8=; b=Yt64swh1+6qVTfwJ/UpxioG6KT
        ACsQjYy56ZIiTQXQ40ypPzSVdGd/mqiTRR8SZv1bZF6MHzKpykl9MOO8k1r9/MOn57p1D1Kq9zWPg
        MomgamAX5i5KC3ItoY5T4siut5ORDZqPISoceFGCMePiARlfa5QC9pqGyFI0KSTo50ugzmqYj/Ekx
        nBdLHfsyurzamdJJoD7qOr4jsQAqKJkPPqO2jqZ4W7l6u8B+/7JqU5cthAfBdIVZExRdYhB0QzB/5
        pth4/xiIyk6nUmhdtj5XOIr3ylVlPrtRfPgVCIChq9o+8GLwWPvnI/P8dMenTqK/v3OUZhCUW7Gl6
        GSB+f+KA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oCHCf-00A8c0-L5; Fri, 15 Jul 2022 09:01:41 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5963098021B; Fri, 15 Jul 2022 11:01:40 +0200 (CEST)
Date:   Fri, 15 Jul 2022 11:01:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Borislav Petkov <bp@suse.de>, Daniel Xu <dxu@dxuuu.xyz>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        David Gow <davidgow@google.com>,
        Douglas Su <d0u9.su@outlook.com>, Finn Behrens <me@kloenk.de>,
        Gary Guo <gary@garyguo.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Cano <macanroj@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        samitolvanen@google.com, joao@overdrivepizza.com,
        keescook@chromium.org
Subject: Re: linux-next: manual merge of the rust tree with Linus' tree
Message-ID: <YtEs9H+JEDUq6NNm@worktop.programming.kicks-ass.net>
References: <20220713203409.559c5464@canb.auug.org.au>
 <Ys6u88DqQdgmkWWf@hirez.programming.kicks-ass.net>
 <CANiq72k_dtr2=KX-WheUiM2v2370imAdWFawJR+8P41L7HjwpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72k_dtr2=KX-WheUiM2v2370imAdWFawJR+8P41L7HjwpA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 03:13:17AM +0200, Miguel Ojeda wrote:
> On Wed, Jul 13, 2022 at 1:40 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Does Rust have the equivalent of -mfunction-return=thunk-extern ?
> 
> While GCC has had it for a while, Nick just landed 2 days ago the
> X86ReturnThunks pass in LLVM, so it will take some time to arrive in
> rustc.
> 
> I have naively backported it to rustc and hacked it so that I set the
> LLVM attribute for all functions, and I am getting the rets replaced
> in Rust functions, e.g.
> 
> (gdb) disassemble a::f
> Dump of assembler code for function _ZN1a1f17hdc6112b1b4a4fe99E:
>    ...
>    0x0000000000008a1f <+31>: pop    %rbp
>    0x0000000000008a20 <+32>: jmp    0x8ce0 <__x86_return_thunk>
> 
> A trivial userspace program that counts the times that it goes through
> the return thunk also appears to work.

Ok; I'm supposing that'll be sorted by the time rust happens.

> > Related, how does Rust deal with all the various CC_HAS_ Kconfig stuff?
> > What if C has the relevant option but Rust does not; then we must not
> > have the feature enabled or there will be a mis-match.
> 
> I guess that would depend on the particular option: whether it applies
> to Rust at all, whether it creates an incompatibility or not, etc.

There's quite a few things affecting code-gen; rustc not using the exact
same compiler arguments is going to create a head-ache.

> > Do we now have to litter everythign with RUSTC_HAS_ ?
> 
> Why? Only a single `rustc` version is targeted at the moment, so it is
> possible to statically know what it supports.

But does it support everything clang does now? If not, you need to
express that in Kconfig and disable the features it doesn't carry. So
even for a single rustc version will you need RUSTC_HAS_ stuff.

What about CC_HAS_IBT? Can rust generate sane IBT code? Current next
doesn't seem to have anything there, suggesting I can't build an IBT
enabled kernel if rust is on (or rather, it'll build, but it'll also
burn at boot).

What if LLVM were to grow -mindirect-branch-cs-prefix (please!) and rust
doesn't have it? Same if LLVM finally stops generating those pesky
conditional tail-calls, will rust continue emitting them?

I'm thinking of the kCFI work, will rustc support that from day 1 or
will that only work when not building any rust.

There being a single rustc is not a single target, every compiler
version grows (and breaks) new features. And for some reason we seem to
change the actual kernel calling convetion a lot of late :/

Currently we can support a feature when one compiler version supports it
(either gcc or clang), but the moment rust becomes a mandatory part of
the kernel build (and I dread that day) we'll need to
wait/update/wrangle at least two different toolchains to implement the
feature in a consistent manner before we can use it.

I also don't see any RUST -mfentry support...
