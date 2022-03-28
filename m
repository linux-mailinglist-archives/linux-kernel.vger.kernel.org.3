Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969914E9C0A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 18:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241658AbiC1QSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 12:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbiC1QSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:18:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB86327B1C;
        Mon, 28 Mar 2022 09:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d8/rOot+Zn55BsrOys3cwi/OQAonRbrHF4qbQtyFPfU=; b=JRielGlYIbDlpiEeEs8rRgK6zA
        +iV4zrteozIT6NLmADRqsFe5zcve5qm4T5rCYDyc6YBiF8OGbBJUiSa2my6KzdC/WFLPuHNXAaT0C
        aFX6+I361AWOIQCVILyke8MjVC+Js88koDB7pC63zgy3aGNx2tUleY7pMpLVdYRBS7YBQ3rhsFD9X
        lAZJJLfB3qd3GuFw79iWTLoIbflDYmYYKcMBeBZen1I/RtMrLTkcP0cF+J78efEDfC23R3y6yNq5T
        ojRfHpR65zd5cEuEM87bOpvoOC4qnhiNX29H4xsVIc2JY/p75TfSAqo+iSwgj8zDbmHvPdgHJ29UX
        1KyYwb4A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nYs2p-00H4I6-Ii; Mon, 28 Mar 2022 16:16:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 77C9F30026E;
        Mon, 28 Mar 2022 18:16:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 56EEB209909C8; Mon, 28 Mar 2022 18:16:37 +0200 (CEST)
Date:   Mon, 28 Mar 2022 18:16:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <nathan@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-toolchains@vger.kernel.org
Subject: Re: clang memcpy calls
Message-ID: <YkHfZbCE0ycVWyxz@hirez.programming.kicks-ass.net>
References: <YjxTt3pFIcV3lt8I@zn.tnic>
 <CAKwvOdkw0Bbm+=ZyViXQhBE1L6uSbvkstHJuHpQ21tzJRftgAw@mail.gmail.com>
 <Yj2yYFloadFobRPx@lakrids>
 <Yj3OEI+WHV/A5uf8@hirez.programming.kicks-ass.net>
 <20220325151238.GB614@gate.crashing.org>
 <YkGFdtn0yDIPqXRl@FVFF77S0Q05N>
 <20220328142220.GI614@gate.crashing.org>
 <YkHNArCbWUEojGjL@lakrids>
 <20220328155957.GK614@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328155957.GK614@gate.crashing.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 10:59:57AM -0500, Segher Boessenkool wrote:

> I do not see how that follows.  Maybe that is obvious from how you look
> at your use case, but it is not from the viewpoint of people who just
> want to do sanitation. 

It's a substitution issue:

either:

  memcpy() equals: "asan instrumentation" + "memcpy implementation"

or:

  memcpy() equals: "memcpy implementation"

It can not be both, since they're not equivalent.

So if the compiler does the substitution, it needs some sense of
equivalence. All we're asking is that it be consistent (my preference is
for the latter).

> So what is the goal here?  Why do you need to
> prevent sanitation on anything called from this function, at all cost?

Kernel entry code might not have reached a point where instrumentation
assumptions are valid yet. Consider calling into C before the kernel
page-tables are swapped in. KASAN instrumentation would insta-explode
simply because the environment it expects (the shadow data etc..) isn't
there.

