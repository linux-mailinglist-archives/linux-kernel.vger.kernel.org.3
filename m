Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B1A46AA8E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352055AbhLFVke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbhLFVkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:40:33 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04368C061746;
        Mon,  6 Dec 2021 13:37:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 35B36CE1862;
        Mon,  6 Dec 2021 21:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50800C341C6;
        Mon,  6 Dec 2021 21:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638826620;
        bh=f84xs3ZWRDRi5yCnS5uMKiSpraAqjxG5xApNM0KlV+M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rwJzyqjSjn+0tt76jOh96QKag8reoQ4QQlKYk8l22coi3ErZXW2bVShMEaXc88I/O
         6nwFfz/0BEWv5Bk1JhdvEVTW8QxhGlsX+at1OBrrTl0X3nU8zyTUWqhh2xjOoj8na0
         Jl2p2JEKtdw/tEbu8aOqsOwSMlBmT2Ret/VslgthhXcrZQaACF9YxjsqllLbIRpQdq
         hvImLAgFS3xrr8ifDN0XDGMg05YL7UnEkHC5d+OYyYyNYfnoTSEHbfKwhJl/kxcnij
         LDXZQydiehFCjBaa9iT/wimDjeaT1dnxgZhTxA5D/zPEXzXjErVzIR7l2Rld+iukqV
         zWNgoNG0MmG3Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E83665C14E6; Mon,  6 Dec 2021 13:36:59 -0800 (PST)
Date:   Mon, 6 Dec 2021 13:36:59 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        rcu@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        mtosatti <mtosatti@redhat.com>, frederic <frederic@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2] Documentation: Fill the gaps about entry/noinstr
 constraints
Message-ID: <20211206213659.GI641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <878rx5b7i5.ffs@tglx>
 <YadU1aSE6/0yGWny@FVFF77S0Q05N>
 <87v9088a5q.ffs@tglx>
 <Yae9tbtZW5mjcBVt@FVFF77S0Q05N>
 <87ee6w83yw.ffs@tglx>
 <87bl2083mu.ffs@tglx>
 <1158239c-4e65-d3d9-41b3-4fedac856622@infradead.org>
 <Ya5KM05XaUBjlthn@FVFF77S0Q05N>
 <20211206175323.GB641268@paulmck-ThinkPad-P17-Gen-1>
 <9ff94a5f-bb7e-501a-65cf-f260ae75b506@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ff94a5f-bb7e-501a-65cf-f260ae75b506@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 01:24:03PM -0800, Randy Dunlap wrote:
> 
> 
> On 12/6/21 09:53, Paul E. McKenney wrote:
> > On Mon, Dec 06, 2021 at 05:36:51PM +0000, Mark Rutland wrote:
> >> On Fri, Dec 03, 2021 at 07:48:08PM -0800, Randy Dunlap wrote:
> >>> On 12/1/21 12:35, Thomas Gleixner wrote:
> >>>> +Aside of that many architectures have to save register state, e.g. debug or
> >>>
> >>>                                                           state (e.g. debug) or
> >>>
> >>>> +cause registers before another exception of the same type can happen. A
> >>>
> >>>    ^^^^^ cannot parse (with or without the change to the previous line)
> >>
> >> I think the difficulty here is with "cause register"? That' a register which
> >> indicates the cause of an exception, e.g.
> 
> Oh. I see. Thanks.
> 
> >> * MIPS has `cause` (coprocessor 0 register 13)
> >> * arm64 / AArch64 has `ESR_ELx` (Exception Syndrome Register, ELx)
> >>
> >> We could probably clarify this as "exception cause registers" or "exception
> >> status registers", if that helps?
> > 
> > Or to make it word-by-word unambiguous, "exception-cause registers"
> > and "exception-status registers".
> 
> Any of those works. Or even 'cause' registers.

Agreed, careful use of quotation marks can also do the trick.  That is the
"wonderful" thing about English, so very many ways to say the same thing...

							Thanx, Paul
