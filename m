Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCDA47BEC2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 12:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbhLULSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 06:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbhLULSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 06:18:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BCDC061574;
        Tue, 21 Dec 2021 03:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m+04Hoi1CUS7niYirGQM4HsP6LZhQAse0zu7VHlCC9k=; b=hQ+7r2ejEarybIgiFRYrLBFBwj
        ICQ4I1FnzIAaNZz/GaJgkeBTB9d294bVSpHC3NcCOngdGVrH3DNJoPXEERX5ScHUGUi4pPHnY5Yco
        We+0xfa9ADUGItbceK4HzhwYvxwyOrDcoHKTx40AZld08Z4zJQXmodPopHtb8jNb8iRg2LJ1/9pQU
        Uxcef9kE4GfRVjrKS1FhyPBZBB6p83sCGsY/O4GPj6zdAm6svfM+BNpi4PDspMA0CVWgw1tpcDucT
        d4vG+yaQD+3KFcFF/YDGCPfTbKevmD940OPAayp/WYg4eO22FN8NIEGj2Lx/EQloaH6YtzbZ7kYqB
        pVHRmoPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzd9Q-002Phv-Pu; Tue, 21 Dec 2021 11:17:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0B34C300129;
        Tue, 21 Dec 2021 12:17:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A6DE730A54BB6; Tue, 21 Dec 2021 12:17:45 +0100 (CET)
Date:   Tue, 21 Dec 2021 12:17:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca, posk@posk.io
Subject: Re: [RFC][PATCH 2/3] x86/uaccess: Implement unsafe_try_cmpxchg_user()
Message-ID: <YcG32Ytj0zUAW/B2@hirez.programming.kicks-ass.net>
References: <20211214204445.665580974@infradead.org>
 <20211214205358.643980924@infradead.org>
 <YcC9nSbknJuODqq9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcC9nSbknJuODqq9@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 05:30:05PM +0000, Sean Christopherson wrote:
> On Tue, Dec 14, 2021, Peter Zijlstra wrote:
> > Do try_cmpxchg() loops on userspace addresses.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> > @@ -501,6 +543,21 @@ do {										\
> >  } while (0)
> >  #endif // CONFIG_CC_HAS_ASM_GOTO_OUTPUT
> >  
> > +extern void __try_cmpxchg_user_wrong_size(void);
> > +
> > +#define unsafe_try_cmpxchg_user(_ptr, _oldp, _nval, _label) ({		\
> > +	__typeof__(*(_ptr)) __ret;					\
> > +	switch (sizeof(__ret)) {					\
> > +	case 4:	__ret = __try_cmpxchg_user_asm("l", (_ptr), (_oldp),	\
> > +					       (_nval), _label);	\
> > +		break;							\
> > +	case 8:	__ret = __try_cmpxchg_user_asm("q", (_ptr), (_oldp),	\
> > +					       (_nval), _label);	\
> > +		break;							\
> 
> Can we add support for 1-byte and 2-byte cmpxchg, and for using cmpxchg8b to handle
> 8-byte operations in 32-bit mode?  Support for all the flavors (except 16-byte)
> would allow KVM to use this in an emulator path that currently kmaps the target.
> I'd be more than happy to help test the result.

Sure, no problem. I currently still need to audit parts of mm/ and
do the smp-wake-idle bits before I repost -- that and take a xmas break
ofcourse :-) So it'll be a while before I repost this.
