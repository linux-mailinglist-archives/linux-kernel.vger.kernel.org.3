Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC94051917D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 00:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243720AbiECWjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 18:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiECWjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 18:39:21 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76EC427DB
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 15:35:46 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id c62so17844885vsc.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 15:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8uN3rj4E61pEiXuH0S044PiehAa3W3BMN3Lqc1kk7Uw=;
        b=Ue8FeaYYp63Oq+H4NMZb+pBRhFnk/iofdWy5gXeIg5QTwAVaQhcPh7NJMycsbGfWZE
         Fc+5btEiGJmM5fEXhaxOFjxGU7fzkiSoqnkUqFrl1ZRRzs4ig52ohWMhFGSgHhm+VyaG
         TWPDOh3RfjJbT1pjROk+5GJXdEClUvyooIraMli+y9nHLH03LpgjlCrH+hdF8m40WCQE
         E5GOMstVRJssp5a6VJFS+WxZDfGT+cOVRpciMnyrojahl/hfM9ETPdwkTCKcre9KwcNY
         l73O7V2zpphu3uEFz9tC/hRsuke1nKrMRDzlaIhhkSYfm4lNq2qk0/FjvFICEl6nNSsW
         YGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8uN3rj4E61pEiXuH0S044PiehAa3W3BMN3Lqc1kk7Uw=;
        b=3Jj9rV5i4CYm5M02p6Fr0MwrVwLpXunEQsN2mOMODcFN/+61CAo68Tp40Gu9b18kQ3
         5Cu5RN/8AwcCP6BGPeS0JSyZkHMoWzqOI4n/jGTKRr2b+yd1Cy2pqZ9E2n4saNF1kNwb
         JGFeri+4ugIvzhrwB9mAMuH4iYH/4dHGJAWhd/rjoZbmTP2tiJjPP77e7pTVeKjFdzrr
         tGEsHmT1PR/f+plR3/gPLWSmjjfde+IyeRcKWl4Zm2CVN5Jkzq/HSAvk1n2tp60jhP+s
         qpO/bwe0SlL+kRwhMw8rvwLYl2zmI24cO3dEBnsSu5vYpzOpwpGsLupypC3BF17vRU1q
         oo2w==
X-Gm-Message-State: AOAM5305haY2PYDDjeUmXohaouoeHbS+FayvKqJkYDITEoI0yLGuzXHn
        ZcJoQDqj1kVwTvNxukTLTUdwn0hoLAUQ2+MEbWc9pQ==
X-Google-Smtp-Source: ABdhPJyL+ddQCd6SprqNHsm9X7kOXr4Vs6rtLnwYWhuO4UVCOvXbzKSI2dWSxbo9OUaHxwRSd1gZJrBcmkLhnuY7a5Y=
X-Received: by 2002:a67:c408:0:b0:32d:1319:2e38 with SMTP id
 c8-20020a67c408000000b0032d13192e38mr6059296vsk.72.1651617345595; Tue, 03 May
 2022 15:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
 <202204291545.47C6A97EA2@keescook> <Ymz7DWkRJy3PMaHm@hirez.programming.kicks-ass.net>
 <CABCJKuckt75qA1op-LpkJnQsJC36m9fstbY3uD=7pET2VyyZSg@mail.gmail.com> <YnA3Le2uJRaFF4TC@hirez.programming.kicks-ass.net>
In-Reply-To: <YnA3Le2uJRaFF4TC@hirez.programming.kicks-ass.net>
From:   Peter Collingbourne <pcc@google.com>
Date:   Tue, 3 May 2022 15:35:34 -0700
Message-ID: <CAMn1gO614sMzKzP6qTCcXB0QCeEu-G7CHn_h=6ikCLkFo_Z2Dg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/21] KCFI support
To:     Peter Zijlstra <peterz@infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022 at 1:02 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, May 02, 2022 at 08:22:57AM -0700, Sami Tolvanen wrote:
>
> > > Anyway, I think I hate that __builtin, I'd *much* rather see a variable
> > > attribute or qualifier for this, such that one can mark a function
> > > pointer as not doing CFI.
> > >
> > > I simply doesn't make sense to have a builtin that operates on an
> > > expression. The whole thing is about indirect calls, IOW function
> > > pointers.
> >
> > I also thought an attribute would be more convenient, but the compiler
> > folks prefer a built-in:
> >
> > https://reviews.llvm.org/D122673
>
> That seems to mostly worry about C++ things (overload sets, template
> specialization, name mangling) we kernel folks don't seem to much care
> about.
>
> I'll stick with saying type system makes more sense to me though.

I'd say it's not only the C++ issues but more the "action at a
distance" that's implied by having this be part of the type system.
With this being in the function type it's hard to tell whether any
particular call will have CFI disabled, without needing to go and look
at how the function pointer is defined. On the other hand, if we
explicitly mark up the calls with CFI disabled, the code becomes
easier to audit (think Rust "unsafe" blocks).

Does it seem any better to you to have this be marked up via the
function expression, rather than the call? The idea is that this would
always compile to a check-free function call, no matter what "func"
is:

__builtin_kcfi_call_unchecked(func)(args)

We already have this, to some degree, with KCFI as implemented: CFI
checks are disabled if the function expression refers to a declared
function. The builtin would allow overriding the decision to also
disable CFI checks for function expressions that use the builtin. It
also wouldn't preclude a type based system later on (the builtin would
become effectively a cast to the "unchecked" type).

Peter
