Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5228C48C694
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354368AbiALOzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240344AbiALOzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:55:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E909C06173F;
        Wed, 12 Jan 2022 06:55:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1475FB81F4A;
        Wed, 12 Jan 2022 14:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CE5C36AE5;
        Wed, 12 Jan 2022 14:55:43 +0000 (UTC)
Date:   Wed, 12 Jan 2022 15:55:40 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        David Laight <David.Laight@ACULAB.COM>,
        carlos <carlos@redhat.com>
Subject: Re: [RFC PATCH v2 1/2] rseq: x86: implement abort-at-ip extension
Message-ID: <20220112145540.6mzkqx6qmy2e2rcz@wittgenstein>
References: <20220110171611.8351-1-mathieu.desnoyers@efficios.com>
 <20220111110556.inteixgtl5vpmka7@wittgenstein>
 <1626924888.21447.1641922985771.JavaMail.zimbra@efficios.com>
 <20220112084617.32bjjo774n7vvyct@wittgenstein>
 <1475639366.24565.1641998849957.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1475639366.24565.1641998849957.JavaMail.zimbra@efficios.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 09:47:29AM -0500, Mathieu Desnoyers wrote:
> ----- On Jan 12, 2022, at 3:46 AM, Christian Brauner christian.brauner@ubuntu.com wrote:
> 
> > On Tue, Jan 11, 2022 at 12:43:05PM -0500, Mathieu Desnoyers wrote:
> [...]
> >> >> + *
> >> >> + * rseq critical sections defined with the RSEQ_CS_FLAG_ABORT_AT_IP flag
> >> >> + * have the following behavior on abort: when the stack grows down: the
> >> >> + * stack pointer is decremented to skip the redzone, and decremented of
> >> >> + * the pointer size.  The aborted address (abort-at-ip) is stored at
> >> >> + * this stack pointer location.  The user-space abort handler needs to
> >> >> + * pop the abort-at-ip address from the stack, and add the redzone size
> >> >> + * to the stack pointer.
> >> >> + *
> >> >> + * TODO: describe stack grows up.
> >> > 
> >> > Is this intentional or did you forget? :)
> >> 
> >> Since I did not implement abort-at-ip on stack-grows-up architectures, I felt
> >> it would be too early to describe the algorithm. I can simply remove the TODO
> >> altogether and we'll take care of it when we get there ? If I had to try to
> >> wordsmith it, it would look like e.g.:
> >> 
> >>  *                                    [...] When the stack grows up: the
> >>  * stack pointer is incremented to skip the redzone, and incremented of
> >>  * the pointer size.  The aborted address (abort-at-ip) is stored immediately
> >>  * under this stack pointer location.  The user-space abort handler needs to
> >>  * pop the abort-at-ip address from the stack, and subtract the redzone size
> >>  * from the stack pointer.
> >> 
> >> [ Please let me know if I got somehow confused in my understanding of stack
> >> grows
> >> up architectures. ]
> >> 
> >> I'm also unsure whether any of the stack grows up architecture have redzones ?
> > 
> > I don't think so? From when I last touched that piece of arch code when
> > massaging copy_thread() I only remember parisc as having an upwards
> > growing stack.
> > 
> >> From a quick grep for redzone in Linux arch/, only openrisc, powerpc64 and
> > > x86-64 appear to have redzones.
> 
> I figured it was kind of silly to special-case arch-agnostic comments for stack
> grows up/down, how about the following instead ?
> 
>  * rseq critical sections defined with the RSEQ_CS_FLAG_ABORT_AT_IP flag
>  * have the following behavior on abort: the stack pointer is adjusted to
>  * skip over the redzone [*], and the aborted address (abort-at-ip) is pushed
>  * at this stack pointer location.  The user-space abort handler needs to pop
>  * the abort-at-ip address from the stack, and adjust the stack pointer to skip
>  * back over the redzone.
>  *
>  * [*] The openrisc, powerpc64 and x86-64 architectures define a "redzone" as a
>  *     stack area beyond the stack pointer which can be used by the compiler
>  *     to store local variables in leaf functions.

Sounds good to me.
