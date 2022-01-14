Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB8B48E542
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 09:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236858AbiANIMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 03:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbiANIMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 03:12:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4731AC06161C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 00:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NraZ8fvyZRxvjRMo439JQpZVn3ryMj7D5MUYPkmZY2I=; b=KhDy6wPc04NDgqGLagYH/WnnuH
        Sz+IiB1DuI1p+u99aTeHcMAvNpqTfKEEsCeZGWx/FubYHPkHtO0gNu8k0xz7I3tTedm1Gly/AUvtO
        GzhHaYR0J7TfdPJWihxbdrWLEa5yonVCw+nfjNOE551ig/2Yv495w7e4kI++8rDx/Qyo81A0z5A12
        vwqPVE/0cIVTW/LfXIdAdKmzveXAnBq9ixkQOp7KmVTuRRP8c7NLFMh9YGMTlKgO8DOID3xf3QT4F
        LEwnVsYAZ5Jso5RtU4tT7imyWnleBjvBInWD9IBIW0EGHhzsnXJQjrgnMXhnO3UugFdB757saq0Xm
        zEkV8U6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n8HhP-005c65-La; Fri, 14 Jan 2022 08:12:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D2AC53001FD;
        Fri, 14 Jan 2022 09:12:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B5DAF302237B8; Fri, 14 Jan 2022 09:12:37 +0100 (CET)
Date:   Fri, 14 Jan 2022 09:12:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] generic/bitops: Always inline some more generic
 helpers
Message-ID: <YeEwdYXOjhFfuvKA@hirez.programming.kicks-ass.net>
References: <20220113155357.4706-1-bp@alien8.de>
 <CANpmjNO2mGJjb6YO0EsgjYsEuuF9sGP26Vazb2w0NZ2svevcsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNO2mGJjb6YO0EsgjYsEuuF9sGP26Vazb2w0NZ2svevcsA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 05:58:57PM +0100, Marco Elver wrote:
> On Thu, 13 Jan 2022 at 16:53, Borislav Petkov <bp@alien8.de> wrote:
> >
> > From: Borislav Petkov <bp@suse.de>
> >
> > Hi all,
> >
> > a build report by the 0day robot:
> >
> >   https://lore.kernel.org/r/Yc7t934f%2Bf/mO8lj@zn.tnic
> >
> > made me look at asm and how gcc, at least, generates funky calls to the
> > *_bit() bit manipulation functions on x86 instead of inlining them into
> > the call sites as on x86 that's a single insn, in most of the cases.
> >
> > So PeterZ says the way to go is to always inline them. So here they are.
> > The fun thing is that on x86 there is even a size decrease of more than
> > a Kilobyte for a defconfig, which is nice, see patch 1.
> >
> > As always, comments and suggestions are welcome.
> >
> > Thx.
> >
> > Borislav Petkov (2):
> >   asm-generic/bitops: Always inline all bit manipulation helpers
> >   cpumask: Always inline helpers which use bit manipulation functions
> >
> >  include/asm-generic/bitops/instrumented-atomic.h | 12 ++++++------
> >  .../asm-generic/bitops/instrumented-non-atomic.h | 16 ++++++++--------
> >  include/linux/cpumask.h                          | 14 +++++++-------
> >  3 files changed, 21 insertions(+), 21 deletions(-)
> 
> Acked-by: Marco Elver <elver@google.com>
> 
> Yup, this is probably something we should have done a long time ago. :-)

Thanks, I'll go stuff it in locking/core.
