Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD1B4E9CF7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 19:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243935AbiC1REb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbiC1REa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:04:30 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42D9F62BC8;
        Mon, 28 Mar 2022 10:02:49 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 22SGwOb6019521;
        Mon, 28 Mar 2022 11:58:24 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 22SGwL89019520;
        Mon, 28 Mar 2022 11:58:21 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 28 Mar 2022 11:58:21 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <nathan@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-toolchains@vger.kernel.org
Subject: Re: clang memcpy calls
Message-ID: <20220328165821.GL614@gate.crashing.org>
References: <YjxTt3pFIcV3lt8I@zn.tnic> <CAKwvOdkw0Bbm+=ZyViXQhBE1L6uSbvkstHJuHpQ21tzJRftgAw@mail.gmail.com> <Yj2yYFloadFobRPx@lakrids> <Yj3OEI+WHV/A5uf8@hirez.programming.kicks-ass.net> <20220325151238.GB614@gate.crashing.org> <YkGFdtn0yDIPqXRl@FVFF77S0Q05N> <20220328142220.GI614@gate.crashing.org> <YkHNArCbWUEojGjL@lakrids> <20220328155957.GK614@gate.crashing.org> <YkHfZbCE0ycVWyxz@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkHfZbCE0ycVWyxz@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 06:16:37PM +0200, Peter Zijlstra wrote:
> On Mon, Mar 28, 2022 at 10:59:57AM -0500, Segher Boessenkool wrote:

[ Context added back: ]
> > > My argument is: if the compiler is permitted to implictly and
> > > arbitrarily add calls to instrumented functions within a function marked
> > > with `no_sanitize_address`, the `no_sanitize_address` attribute is
> > > effectively useless, and therefore *something* needs to change.

 > I do not see how that follows.  Maybe that is obvious from how you look
> > at your use case, but it is not from the viewpoint of people who just
> > want to do sanitation. 
> 
> It's a substitution issue:
> 
> either:
> 
>   memcpy() equals: "asan instrumentation" + "memcpy implementation"
> 
> or:
> 
>   memcpy() equals: "memcpy implementation"
> 
> It can not be both, since they're not equivalent.

Equivalent in what sense?  ASAN (like any other sanitizer) does not
change the semantics of valid programs *at all*.  And invalid programs
do not have semantics, of course.

> So if the compiler does the substitution, it needs some sense of
> equivalence. All we're asking is that it be consistent (my preference is
> for the latter).

If you want to never do sanitation, there is -fno-sanitize=all.  But
that obviously is not what you want either.

> > So what is the goal here?  Why do you need to
> > prevent sanitation on anything called from this function, at all cost?
> 
> Kernel entry code might not have reached a point where instrumentation
> assumptions are valid yet. Consider calling into C before the kernel
> page-tables are swapped in. KASAN instrumentation would insta-explode
> simply because the environment it expects (the shadow data etc..) isn't
> there.

Ah.  Something like the proposed global boolean flag would work fine for
that, afaics?  Have all the asan implementation functions just return
until the "I am ready now" flag is set.  This is trivial overhead,
compared to having asan at all!


Segher
