Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A95557DA1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiFWOUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiFWOUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:20:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A93CF43EFB
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 07:20:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9965912FC;
        Thu, 23 Jun 2022 07:20:03 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.26.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 012A13F66F;
        Thu, 23 Jun 2022 07:20:01 -0700 (PDT)
Date:   Thu, 23 Jun 2022 15:19:59 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [RFC][PATCH] ftrace,objtool: PC32 based __mcount_loc
Message-ID: <YrR2j74IWiGrUKFr@FVFF77S0Q05N.cambridge.arm.com>
References: <YqxkhV1YcI6e+xXp@worktop.programming.kicks-ass.net>
 <YqxoEJG6jGDWitg3@FVFF77S0Q05N>
 <CAMj1kXFuPAUfknadWDXPDXA5LYFnr0MGeXvF5MAYJBLxfCWEWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFuPAUfknadWDXPDXA5LYFnr0MGeXvF5MAYJBLxfCWEWw@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 06:27:39PM +0200, Ard Biesheuvel wrote:
> On Fri, 17 Jun 2022 at 13:40, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Fri, Jun 17, 2022 at 01:24:53PM +0200, Peter Zijlstra wrote:
> > >
> > > Hi,
> > >
> > > I recently noticed that __mcount_loc is 64bit wide, containing absolute
> > > addresses. Since __mcount_loc is a permanent section (not one we drop
> > > after boot), this bloats the kernel memory usage for no real purpose.
> > >
> > > The below patch adds __mcount_loc_32 and objtool support to generate it.
> > > This saves, on an x86_64-defconfig + FTRACE, 23975*4 ~= 94K of permanent
> > > storage.
> >
> > We have a similar issue on arm64, which is exacerbated by needing ABS64
> > relocations (24 bytes per entry!) adding significant bloat when FTRACE is
> > enabled.
> >
> > It'd be really nice if going forwards compilers could expose an option to
> > generate PC32/PREL32 entries directly for this.
> 
> As opposed to generating absolute references today? Or as opposed to
> having to rely on our own tooling?

Both; My prefrence would be the compiler had the option to generate these
entries as relative at compile-time, without needing a binary post-processing
step.

That said, from my PoV this is one of the things that I think it's somewhat
reasonable for objtool to do, as it's arguably akin to the build-time sort, and
doesn't require deep knowledge of the control flow, etc.

Thanks,
Mark.
