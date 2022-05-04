Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6A951986A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345581AbiEDHjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 03:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346037AbiEDHjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 03:39:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05DB27157;
        Wed,  4 May 2022 00:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cTSIQdlg91RSK+na/NVKBd/Ax/ZBULg9Q/4Gx74hmBE=; b=DJ4sRfVFdZHqiUR1scXw9foZfl
        L7yKxBEJhUhm/nN8KNGznPTfuCfQS10cTZGTZncnxpQcvHtmIibXuZIf4BWhkVTwUsXutzODCujTX
        9ol5m6lfkrhF1XEjyiZyaKvorG5EUGu2bSqA/FcWM5LcriPRGK2tDMPLFNt4Lz0WYO0NKcTysvqe1
        ju+XiMI9AoOmYgIRswBct3J0G8rSnfT/S/lYzMGoHVAa5UY/87fStP27Br/E5nPYN5Sh2OitDpTAx
        CPy06b7r2hzVIO98a1HVNwlRWcw0xPwXqpEILLaa17u5ZiJGLI0PMYOMFXL3CPPGYkmCdK5kE6dIL
        wBOgZgjg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nm9Wd-00B171-EK; Wed, 04 May 2022 07:34:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7BD913004B5;
        Wed,  4 May 2022 09:34:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3EF7E2029A1DC; Wed,  4 May 2022 09:34:18 +0200 (CEST)
Date:   Wed, 4 May 2022 09:34:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev
Subject: Re: [RFC PATCH 00/21] KCFI support
Message-ID: <YnIses89/uPLrazS@hirez.programming.kicks-ass.net>
References: <20220429203644.2868448-1-samitolvanen@google.com>
 <202204291545.47C6A97EA2@keescook>
 <Ymz7DWkRJy3PMaHm@hirez.programming.kicks-ass.net>
 <CABCJKuckt75qA1op-LpkJnQsJC36m9fstbY3uD=7pET2VyyZSg@mail.gmail.com>
 <YnA3Le2uJRaFF4TC@hirez.programming.kicks-ass.net>
 <CAMn1gO614sMzKzP6qTCcXB0QCeEu-G7CHn_h=6ikCLkFo_Z2Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMn1gO614sMzKzP6qTCcXB0QCeEu-G7CHn_h=6ikCLkFo_Z2Dg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 03:35:34PM -0700, Peter Collingbourne wrote:
> On Mon, May 2, 2022 at 1:02 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, May 02, 2022 at 08:22:57AM -0700, Sami Tolvanen wrote:
> >
> > > > Anyway, I think I hate that __builtin, I'd *much* rather see a variable
> > > > attribute or qualifier for this, such that one can mark a function
> > > > pointer as not doing CFI.
> > > >
> > > > I simply doesn't make sense to have a builtin that operates on an
> > > > expression. The whole thing is about indirect calls, IOW function
> > > > pointers.
> > >
> > > I also thought an attribute would be more convenient, but the compiler
> > > folks prefer a built-in:
> > >
> > > https://reviews.llvm.org/D122673
> >
> > That seems to mostly worry about C++ things (overload sets, template
> > specialization, name mangling) we kernel folks don't seem to much care
> > about.
> >
> > I'll stick with saying type system makes more sense to me though.
> 
> I'd say it's not only the C++ issues but more the "action at a
> distance" that's implied by having this be part of the type system.
> With this being in the function type it's hard to tell whether any
> particular call will have CFI disabled, without needing to go and look
> at how the function pointer is defined.

Look at how we use volatile:

	*(volatile int *)(&foo)

we don't use volatile on actual variable definitions (much), but instead
cast it in at the usage site. Same can be done with this if so desired.

> On the other hand, if we
> explicitly mark up the calls with CFI disabled, the code becomes
> easier to audit (think Rust "unsafe" blocks).

I don't know any Rust. To me Rust still looks like line noise.

> Does it seem any better to you to have this be marked up via the
> function expression, rather than the call? The idea is that this would
> always compile to a check-free function call, no matter what "func"
> is:
> 
> __builtin_kcfi_call_unchecked(func)(args)
> 
> We already have this, to some degree, with KCFI as implemented: CFI
> checks are disabled if the function expression refers to a declared
> function. The builtin would allow overriding the decision to also
> disable CFI checks for function expressions that use the builtin. It
> also wouldn't preclude a type based system later on (the builtin would
> become effectively a cast to the "unchecked" type).

That's still a bit naf; you've effectively made that builtin a type-cast.
