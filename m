Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AAA596A97
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 09:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbiHQHqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 03:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbiHQHqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:46:02 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529957C1F4;
        Wed, 17 Aug 2022 00:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=45RsTvvQpAn/sSf9KQMAsIEwdB3TRL9b7yAQ8edqZtc=; b=rQtLOXCrBQhDRm/70fh1y3S2/5
        Zvjv3iR9bXRxOX13MCcEc+zLzE1ul+eO189lBhcYzwcTX+W1j/mi2IgUa+iUyMVGaK8aYo36zJjSY
        NkCmlQy650FpaTgpiFwTVE4INDiafqOmRl68kXZHmAHqlDDBq0ErZdxHYP6lyJAeElBUCv6Vt8FIY
        bf/z+K5QWA5XTj32dh1I+lB8Kzy9/+y9UNrjbghtVzObo1Si4ugnWoJA85F98bM8STwICsN6Huv2z
        pdHljpDabBsJ59lxHnBBhfJFWRny5gkRtg3Z4buBCxMiC6dFPr7tF7TLfLLlH38venKpOxQl61ZM/
        T7NlV8ng==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oODkH-003CgF-VP; Wed, 17 Aug 2022 07:45:46 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4881A98007A; Wed, 17 Aug 2022 09:45:45 +0200 (CEST)
Date:   Wed, 17 Aug 2022 09:45:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        clang-built-linux <llvm@lists.linux.dev>
Subject: Re: Simplify load_unaligned_zeropad() (was Re: [GIT PULL] Ceph
 updates for 5.20-rc1)
Message-ID: <YvycqWVs5JbBR1D+@worktop.programming.kicks-ass.net>
References: <CAHk-=wh1xHi-WeytuAK1-iSsR0wi=6e4-WgFq6ZPt8Z1mvqoNA@mail.gmail.com>
 <Yvny9L3tw1EolqQ4@worktop.programming.kicks-ass.net>
 <CAHk-=whnEN3Apb5gRXSZK7BM+MOby9VCZe3sDcW34Zme_wk3uA@mail.gmail.com>
 <Yvqn8BqE7FdB6Ccd@worktop.programming.kicks-ass.net>
 <CAHk-=wj6QaNkoNPA0jrW8F_=RNNb1jCsFF2QngNEQb_C=wMDPQ@mail.gmail.com>
 <YvtPEA/9GV7GthZJ@worktop.programming.kicks-ass.net>
 <CAHk-=wjZ0oC0__-kLX51jRwo4XgAQ9xJ=OeT5_=fiLxmDexFZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjZ0oC0__-kLX51jRwo4XgAQ9xJ=OeT5_=fiLxmDexFZw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 10:57:45AM -0700, Linus Torvalds wrote:

> > > +     if (insn_decode(&insn, (void *) regs->ip, len, INSN_MODE_KERN))
> > > +             return false;
> >
> > We have insn_decode_kernel() for exactly this (very) common case.
> 
> I did that originally, and then I undid it in disgust, because that
> interface is too simple.
> 
> In particular, it just uses MAX_INSN_SIZE blindly. Which I didn't want
> to do when I actually had the instruction size.
> 
> Yes, yes, I also check the decode size after-the-fact, but I didn't
> want the decoder to even look at the invalid bytes.
> 
> This exception case is about the data being at the end of the page, I
> wanted the fixup to be aware of code being at the end of a page too.

I don't want to argue this point too much; but I will anyway :-)

IMO if the decoder ends up out of bounds its a decoder bug either way
around. That is, we *know* there is a full instruction at the given IP
because we got into this exception path.

( it would be possible to add further constraints on trapnr )

Irrespective of the length constraint given to the decoder, it should
not decode/access things past this instruction (without being careful
about it).

Anyway, I'm fine with the patch as you have it.
