Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDE846A693
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349249AbhLFUOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 15:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348870AbhLFUOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 15:14:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C221AC061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 12:11:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88540B81252
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 20:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449EDC341C2;
        Mon,  6 Dec 2021 20:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638821482;
        bh=U+e1PtDjyQt3wnfvPmEv/wOTCI/AFkvmOmQaUVUKFVE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=A9+p72ACTlZdp6PkMG3BW4uDO2je3g/WYm86WDa7Z+6ExNLTrTALzjwINVgeBIzB6
         6I1fibLSNmkszgAbn63jE13VYdP4QOzVMzQpECVHv5uOKCpvl4EqrWCA/9YcByA1ry
         nwz/0FXEZ3LEUujYUGkjXAW+vbGEhN1G6GphyybPCVaJO3jatw/BLAJK/JkVLd3yGT
         nHk3885mQzB5m3zugsHmlGUCtTAMQ2KGDxEgMS+YTRyFYbRWRRSh3P26lKxJCx5ZR8
         zYOr2totkx/4gJujLoEK6xAYbMbHYERX9OyPB+lAVQsIf8WSjbb+K6+HX3b5psK+lz
         cewJZm9laxXpA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 074D55C1461; Mon,  6 Dec 2021 12:11:22 -0800 (PST)
Date:   Mon, 6 Dec 2021 12:11:22 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] nptl: Add rseq registration
Message-ID: <20211206201122.GE641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <cover.1638798186.git.fweimer@redhat.com>
 <9c58724d604e160ebda5f667331fa41416c0d12b.1638798186.git.fweimer@redhat.com>
 <1780152866.15126.1638809966443.JavaMail.zimbra@efficios.com>
 <871r2podt9.fsf@oldenburg.str.redhat.com>
 <1614144911.15213.1638816753026.JavaMail.zimbra@efficios.com>
 <87ilw1mu81.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilw1mu81.fsf@oldenburg.str.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 08:03:26PM +0100, Florian Weimer wrote:
> * Mathieu Desnoyers:
> 
> > [ Adding other kernel rseq maintainers in CC. ]
> >
> > ----- On Dec 6, 2021, at 12:14 PM, Florian Weimer fweimer@redhat.com wrote:
> >
> >> * Mathieu Desnoyers:
> >> 
> >>> ----- On Dec 6, 2021, at 8:46 AM, Florian Weimer fweimer@redhat.com wrote:
> >>> [...]
> >>>> @@ -406,6 +407,9 @@ struct pthread
> >>>>   /* Used on strsignal.  */
> >>>>   struct tls_internal_t tls_state;
> >>>> 
> >>>> +  /* rseq area registered with the kernel.  */
> >>>> +  struct rseq rseq_area;
> >>>
> >>> The rseq UAPI requires that the fields within the rseq_area
> >>> are read-written with single-copy atomicity semantics.
> >>>
> >>> So either we define a "volatile struct rseq" here, or we'll need
> >>> to wrap all accesses with the proper volatile casts, or use the
> >>> relaxed_mo atomic accesses.
> >> 
> >> Under the C memory model, neither volatile nor relaxed MO result in
> >> single-copy atomicity semantics.  So I'm not sure what to make of this.
> >> Surely switching to inline assembly on all targets is over the top.
> >> 
> >> I think we can rely on a plain read doing the right thing for us.
> >
> > AFAIU, the plain read does not prevent the compiler from re-loading the
> > value in case of high register pressure.
> >
> > Accesses to rseq fields such as cpu_id need to be done as if those were
> > concurrently modified by a signal handler nesting on top of the user-space
> > code, with the particular twist that blocking signals has no effect on
> > concurrent updates.
> >
> > I do not think we need to do the load in assembly. I was under the impression
> > that both volatile load and relaxed MO result in single-copy atomicity
> > semantics for an aligned pointer. Perhaps Paul, Peter, Boqun have something
> > to add here ?
> 
> The C memory model is broken and does not prevent out-of-thin-air
> values.  As far as I know, this breaks single-copy atomicity.  In
> practice, compilers will not exercise the latitude offered by the memory
> model.  volatile does not ensure absence of data races.

Within the confines of the standard, agreed, use of the volatile keyword
does not explicitly prevent data races.

However, volatile accesses are (informally) defined to suffice for
device-driver memory accesses that communicate with devices, whether via
MMIO or DMA-style shared memory.  The device-driver firmware is often
written in C or C++.  So doesn't this informal device-driver guarantee
need to also do what is needed for userspace code that is communicating
with kernel code?  If not, why not?

> Using atomics or volatile would require us to materialize the thread
> pointer, given the current internal interfaces we have, and I don't want
> to do this because this is supposed to be performance-critical code.
> The compiler barrier inherent to the function call will have to be
> enough.  I can add a comment to this effect:
> 
>   /* This load has single-copy atomicity semantics (as required for
>      rseq) because the function call implies a compiler barrier.  */

Agreed on the need to be very careful to avoid degrading performance on
fast paths!

							Thanx, Paul
