Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B7148C743
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 16:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354594AbiALPee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 10:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349515AbiALPea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:34:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAF4C06173F;
        Wed, 12 Jan 2022 07:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0lxOXbswWpc0LLlxDh7sVTE9Is0OW2RPzURYxTEV11Y=; b=dQdvr4leWEqxkJENcBqH4uzhdo
        csmb6EX6Sqwq94EbRKhePBLLlXfSwuglV517clWaz8TLONS5G9JpOkJ1x+ziJD3OVTI6i9DH5XWav
        cX/gtITaYIYPMOLxF4sBbWm7XQsNqObvFaHUwmYaJPkcnXyYsuGuXpOC/ya3LJ9GiQcO9u+/6p0qF
        mUwSKJbOWeES9qRe5/qhh/SHATDxO3ktBDmqF/3J5o+fEkPfqyqCbjh5+P11xzEPTxEwh4EZpREyP
        N6OX2wA18UPW729/CaXKw03CwLbn1bGNn7tiKtB+agkMlYMwNv2Fa3fcTnD5mYI07fr9FnyQnIE9b
        ccxwWQiw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7fda-004ClM-5m; Wed, 12 Jan 2022 15:34:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5C9E9300222;
        Wed, 12 Jan 2022 16:34:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 42C2921125BAB; Wed, 12 Jan 2022 16:34:08 +0100 (CET)
Date:   Wed, 12 Jan 2022 16:34:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Mathieu Desnoyers' <mathieu.desnoyers@efficios.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, carlos <carlos@redhat.com>
Subject: Re: [RFC PATCH v2 1/2] rseq: x86: implement abort-at-ip extension
Message-ID: <Yd708EjQNEa9dFXZ@hirez.programming.kicks-ass.net>
References: <20220110171611.8351-1-mathieu.desnoyers@efficios.com>
 <20220111110556.inteixgtl5vpmka7@wittgenstein>
 <1626924888.21447.1641922985771.JavaMail.zimbra@efficios.com>
 <20220112084617.32bjjo774n7vvyct@wittgenstein>
 <1475639366.24565.1641998849957.JavaMail.zimbra@efficios.com>
 <71e7d09733df4a899d12b7ef25198bbc@AcuMS.aculab.com>
 <1953851780.24610.1641999934047.JavaMail.zimbra@efficios.com>
 <0088806280f54211b3f90b2c1a82a140@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0088806280f54211b3f90b2c1a82a140@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 03:15:27PM +0000, David Laight wrote:
> From: Mathieu Desnoyers
> > Sent: 12 January 2022 15:06
> > 
> > ----- On Jan 12, 2022, at 9:58 AM, David Laight David.Laight@ACULAB.COM wrote:
> > 
> > >>  * [*] The openrisc, powerpc64 and x86-64 architectures define a "redzone" as a
> > >>  *     stack area beyond the stack pointer which can be used by the compiler
> > >>  *     to store local variables in leaf functions.
> > >
> > > I wonder if that is really worth the trouble it causes!
> > > By the time a function is spilling values to stack the cost
> > > of a %sp update is almost certainly noise.
> > >
> > > Someone clearly thought it was a 'good idea (tm)'.
> > 
> > I must admit that I've been surprised to learn about these redzones. Thanks for
> > pointing them out to me, it was clearly a blind spot. I suspect it would be useful
> > to introduce per-architecture KERNEL_REDZONE, USER_REDZONE and COMPAT_USER_REDZONE
> > with a asm-generic version defining them to 0, with proper documentation. It would
> > make it clearer to kernel developers working on stuff similar to signal handler
> > delivery that they need to consider these carefully.
> 
> They can never be used in kernel - any ISR would overwrite them.

That depends on how the architecture does exceptions; also consider:

  https://www.intel.com/content/www/us/en/develop/download/flexible-return-and-event-delivery-specification.html
