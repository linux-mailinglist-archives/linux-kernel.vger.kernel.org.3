Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6F850A82D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391374AbiDUSgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389065AbiDUSgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:36:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE3E4BB80;
        Thu, 21 Apr 2022 11:33:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 429FB60CA5;
        Thu, 21 Apr 2022 18:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3E6C385A9;
        Thu, 21 Apr 2022 18:33:09 +0000 (UTC)
Date:   Thu, 21 Apr 2022 19:33:05 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lennart Poettering <lennart@poettering.net>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-abi-devel@lists.sourceforge.net,
        linux-hardening@vger.kernel.org, Jann Horn <jannh@google.com>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Igor Zhbanov <izh1979@gmail.com>
Subject: Re: [PATCH RFC 0/4] mm, arm64: In-kernel support for
 memory-deny-write-execute (MDWE)
Message-ID: <YmGjYYlcSVz38rOe@arm.com>
References: <20220413134946.2732468-1-catalin.marinas@arm.com>
 <202204141028.0482B08@keescook>
 <YmAEDsGtxhim46UI@arm.com>
 <c62170c6-5993-2417-4143-5a37a98b227c@gmail.com>
 <202204201610.093C9D5FE8@keescook>
 <YmF5s4KqT5WL4O0G@arm.com>
 <202204210941.4318DE6E8@keescook>
 <YmGTRQA74n/ZF7Vl@arm.com>
 <202204211030.B0093CC14@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204211030.B0093CC14@keescook>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 10:41:43AM -0700, Kees Cook wrote:
> On Thu, Apr 21, 2022 at 06:24:21PM +0100, Catalin Marinas wrote:
> > On Thu, Apr 21, 2022 at 09:42:23AM -0700, Kees Cook wrote:
> > > On Thu, Apr 21, 2022 at 04:35:15PM +0100, Catalin Marinas wrote:
> > > > Do we want the "was PROT_WRITE" or we just reject mprotect(PROT_EXEC) if
> > > > the vma is not already PROT_EXEC? The latter is closer to the current
> > > > systemd approach. The former allows an mprotect(PROT_EXEC) if the
> > > > mapping was PROT_READ only for example.
> > > > 
> > > > I'd drop the "was PROT_WRITE" for now if the aim is a drop-in
> > > > replacement for BPF MDWE.
> > > 
> > > I think "was PROT_WRITE" is an important part of the defense that
> > > couldn't be done with a simple seccomp filter (which is why the filter
> > > ended up being a problem in the first place).
> > 
> > I would say "was PROT_WRITE" is slightly more relaxed than "is not
> > already PROT_EXEC". The seccomp filter can't do "is not already
> > PROT_EXEC" either since it only checks the mprotect() arguments, not the
> > current vma flags.
> > 
> > So we have (with sub-cases):
> > 
> > 1. Current BPF filter:
> > 
> >    a)	mmap(PROT_READ|PROT_WRITE|PROT_EXEC);	// fails
> > 
> >    b)	mmap(PROT_READ|PROT_EXEC);
> >		mprotect(PROT_READ|PROT_EXEC|PROT_BTI);	// fails
> >
> >    c)	mmap(PROT_READ);
> >		mprotect(PROT_READ|PROT_EXEC);		// fails
> >
> >    d)	mmap(PROT_READ|PROT_WRITE);
> >		mprotect(PROT_READ);
> >		mprotect(PROT_READ|PROT_EXEC);		// fails
> > 
> > 2. "is not already PROT_EXEC":
> > 
> >    a)	mmap(PROT_READ|PROT_WRITE|PROT_EXEC);	// fails
> > 
> >    b)	mmap(PROT_READ|PROT_EXEC);
> >		mprotect(PROT_READ|PROT_EXEC|PROT_BTI);	// passes
> > 
> >    c)	mmap(PROT_READ);
> >		mprotect(PROT_READ|PROT_EXEC);		// fails
> >
> >    d)	mmap(PROT_READ|PROT_WRITE);
> >		mprotect(PROT_READ);
> >		mprotect(PROT_READ|PROT_EXEC);		// fails
> > 
> > 3. "is or was not PROT_WRITE":
> > 
> >    a)	mmap(PROT_READ|PROT_WRITE|PROT_EXEC);	// fails
> > 
> >    b)	mmap(PROT_READ|PROT_EXEC);
> >		mprotect(PROT_READ|PROT_EXEC|PROT_BTI);	// passes
> > 
> >    c)	mmap(PROT_READ);
> >		mprotect(PROT_READ|PROT_EXEC);		// passes
> > 
> >    d)	mmap(PROT_READ|PROT_WRITE);
> >		mprotect(PROT_READ);
> >	 	mprotect(PROT_READ|PROT_EXEC);		// fails
> 
> [edited above to show each case]

Thanks, I was in a rush to get home ;).

> restated what was already summarized:
> Problem is 1.b. 2 and 3 solve it. 3 is more relaxed (c passes).
> 
> > If we don't care about 3.c, we might as well go for (2). I don't mind,
> > already went for (3) in this series. I think either of them would not be
> > a regression on MDWE, unless there is some test that attempts 3.c and
> > expects it to fail.
> 
> I should stop arguing for a less restrictive mode. ;) It just feels weird
> that the combinations are API-mediated, rather than logically defined:
> I can do PROT_READ|PROT_EXEC with mmap but not mprotect under 2. As
> opposed to saying "the vma cannot be executable if it is or ever was
> writable". I find the latter much easier to reason about as far as the
> expectations of system state.

I had the same reasoning, hence option 3 in this series. I prefer to
treat mmap(PROT_READ|PROT_EXEC) and mprotect(PROT_READ|PROT_EXEC) in a
similar way.

-- 
Catalin
