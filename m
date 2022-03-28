Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CDD4E960A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242136AbiC1L7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242153AbiC1L5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:57:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEA631DFB;
        Mon, 28 Mar 2022 04:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V8SPwDvoJviYgsUTGhN1PbWTTa7UH/mLN46SQAz/mHM=; b=LeSH7zKYa2ASEHhCVpTn2c0IRh
        08dAntK5bJWlCZMV/6R+8Ea3GZNpADKzqX32Lheclvr5DzcF/cDB1PZosWLuoXBqxdUgdMZdpl8hP
        2/AjAtRXaojXWOuAmg/RPcN7AbJXz9OK3QZrWwSAQ7eRize9TTenjXk4bh3cKAKyngJUWmL/uUj+F
        lafpZQHgS200OScp4Q7we+evlYQZg7Sfi1PUeWZf79TUtaR/PQ2f7SKohLGuYw67I0SK+c1587mDn
        2J0NUCfDM5t+6vAGPs39FJofyDY7eVTyCsA/dSbszDaRg6U7C166QERGq93riN+uVPf6SH/DfVcyc
        /MhIntCg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nYnx7-00GsqX-2c; Mon, 28 Mar 2022 11:54:29 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id F01849861E7; Mon, 28 Mar 2022 13:54:26 +0200 (CEST)
Date:   Mon, 28 Mar 2022 13:54:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jakub Jelinek <jakub@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <nathan@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-toolchains@vger.kernel.org
Subject: Re: clang memcpy calls
Message-ID: <20220328115426.GB8939@worktop.programming.kicks-ass.net>
References: <YjxTt3pFIcV3lt8I@zn.tnic>
 <CAKwvOdkw0Bbm+=ZyViXQhBE1L6uSbvkstHJuHpQ21tzJRftgAw@mail.gmail.com>
 <Yj2yYFloadFobRPx@lakrids>
 <Yj3OEI+WHV/A5uf8@hirez.programming.kicks-ass.net>
 <20220325151238.GB614@gate.crashing.org>
 <YkGFdtn0yDIPqXRl@FVFF77S0Q05N>
 <YkGL929QoFiTfMK7@tucnak>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkGL929QoFiTfMK7@tucnak>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 12:20:39PM +0200, Jakub Jelinek wrote:
> On Mon, Mar 28, 2022 at 10:52:54AM +0100, Mark Rutland wrote:
> > I think we're talking past each other here, so let me be more precise. :)
> > 
> > The key thing is that when the user passes `-fsantize=address`, instrumentation
> > is added by (a part of) the compiler. That instrumentation is added under some
> > assumptions as to how the compiler as a whole will behave.
> > 
> > With that in mind, the question is how is __attribute__((no_sanitize_address))
> > intended to work when considering all the usual expectations around how the
> > compiler can play with memcpy and similar?
> 
> no_sanitize_address or lack thereof is whether the current function
> shouldn't be or should be ASan instrumented, not on whether other functions
> it calls are instrumented or not.  memcpy/memmove/memset are just a tiny bit
> special case because the compiler can add them on their own even if they
> aren't present in the source (there are a few others the compiler can
> pattern match too) and various builtins can be on the other side expanded
> inline instead of called, so one then gets the sanitization status of the
> function in which it is used rather than whether the out of line
> implementation of the function is sanitized.
> 
> If coexistence of instrumented and non-instrumented memcpy etc. was the goal
> (it clearly wasn't), then the sanitizer libraries wouldn't be overriding
> memcpy calls, but instead the compiler would redirect calls to memcpy in
> instrumented functions to say __asan_memcpy which then would be
> instrumented.

This then leaves us holding the pieces because this behaviour is
actively wrong.

A non-instrumented function *MUST*NOT* call an instrumented function,
ever. This very much violates how we use/expect
__attribute__((no_sanitize_address)) to work.

If we use that on a function, we expect/rely on that function (nor any
compiler tranformation thereof) to *NOT* have instrumentation. This is a
hard correctness requirement that cannot be argued with.


So there's two options:

 A) compiler generates implicit mem*() calls with the knowledge that
    mem*() is not instrumentet, and as such will also emit
    instrumentation for it when so required (or calls mem*_asan() like
    functions.

 B) compiler knows mem*() are instrumented, at which point the implicit
    mem*() calls are no longer equivalent under
    __attribute__((no_sanitize_address)) and will no longer perform
    these substitutions.


At some point this becomes a choice between being able to boot or having
KASAN, choice is simple.
