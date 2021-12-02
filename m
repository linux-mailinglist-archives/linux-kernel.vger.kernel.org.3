Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349B8466980
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 18:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376499AbhLBR7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 12:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhLBR7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:59:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C71C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 09:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z5l4ZowOfON8DShmpXR1Eklfg8s5dDGN7l9e7OCgVe8=; b=MfClZJKe0F1pbNikLiYqacxJtH
        esR3cz/4eCxZx19dx4KmDsEaorJDIesZdFC9Mqa0tY86lcw0dNvTiF7uIfNTzlQX3XhWTsgIzBpuD
        d/kjeXOcEH4s07UmV/HBaUMI7OPhwmL1BKEZZFiTdX/ZP2EtVcbZwnxLhRav0floJ4wEYA4BXqgOC
        rvA39Bla8yYIb32H9imAUKV1DKn9ronjzvb9BLOXYaIwNfZJ/bh/QgijwwqCfZFlrFMZ4atOR5rvF
        JbMXf+IfD8OyvfX70f8VDBvoVUbvfJdpa0f2k4pCh55BNPA3jRMhRmf1cC5aiFBBN3vaATtlLo2KK
        XlMcmX+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1msqJU-0050IV-2P; Thu, 02 Dec 2021 17:56:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EE626300293;
        Thu,  2 Dec 2021 18:56:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D8E85322A81C1; Thu,  2 Dec 2021 18:56:07 +0100 (CET)
Date:   Thu, 2 Dec 2021 18:56:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] kcov: fix generic Kconfig dependencies if
 ARCH_WANTS_NO_INSTR
Message-ID: <YakIt2aPZeeNzug0@hirez.programming.kicks-ass.net>
References: <20211201152604.3984495-1-elver@google.com>
 <YajdN5T8vi2ZzP3D@hirez.programming.kicks-ass.net>
 <CANpmjNM4nxnwt7iWF+kCT862H21CHL-cshYyugBei0ysGAt5uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNM4nxnwt7iWF+kCT862H21CHL-cshYyugBei0ysGAt5uA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 06:38:13PM +0100, Marco Elver wrote:
> On Thu, 2 Dec 2021 at 18:30, Peter Zijlstra <peterz@infradead.org> wrote:

> > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > index 9ef7ce18b4f5..589c8aaa2d5b 100644
> > > --- a/lib/Kconfig.debug
> > > +++ b/lib/Kconfig.debug
> > > @@ -1977,6 +1977,8 @@ config KCOV
> > >       bool "Code coverage for fuzzing"
> > >       depends on ARCH_HAS_KCOV
> > >       depends on CC_HAS_SANCOV_TRACE_PC || GCC_PLUGINS
> > > +     depends on !ARCH_WANTS_NO_INSTR || STACK_VALIDATION || \
> > > +                GCC_VERSION >= 120000 || CLANG_VERSION >= 130000
> >
> > Can we write that as something like:
> >
> >         $(cc-attribute,__no_sanitize_coverage)
> >
> > instead? Other than that, yes totally.
> 
> That'd be nice, but I think we don't have that cc-attribute helper? I

Nah indeed, I made that up on the spot.

> checked how e.g. CC_HAS_NO_PROFILE_FN_ATTR does it, but it won't work
> like that because gcc and clang define the attribute differently and
> it becomes a mess. That's also what Nathan pointed out here I think:
> https://lkml.kernel.org/r/Yaet8x/1WYiADlPh@archlinux-ax161


Urgh, that's one of them MsgIDs with a '/' in..

/me substitues with %2f and magic...

Hurmph yeah... so if we can somehow do that it would allow back porting
those fixes to older compiler versions and have things magically work.
Not sure how realistic that is, but still.. A well. I'll go do something
useful then :-)

