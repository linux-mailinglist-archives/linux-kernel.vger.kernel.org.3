Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4067046A91D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243704AbhLFVLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:11:47 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48496 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245741AbhLFVLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:11:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DE3EB81084
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 21:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94A6C341C1;
        Mon,  6 Dec 2021 21:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638824893;
        bh=iYcGQ1M1jUSm3USRqxI4snJ2gWtgRp28eIuDa9jIP5c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pKo0fCgpdYmWbq0/LVSvo2unzDJ7KqFLqGqP1mF+uYBsPDOxw1E5hevXMXQ6FuYua
         kJgMh1sHqeyxdTD0Ihovfop4K397JO1AGSdpVl6yRHvKayLfnTjCVelNZgbXkuO47Q
         W5JTVfYHOaUUprqrxb+qX6FY7aFqE148Y2e1SB4O/5n/g0AB8do6sjJx11pKF5CLwB
         zezpC/kWHx1Xon4/aQgCY+5smsZMRyhwjxkMjCpPGgFymwruVyNcOLVHvkLYMxh17V
         wx/CUgavr8U6N1U6sf4kxd4djRU5+s30exZextiDnKQZyCWhcLYW3Rp5JvVU0SAX0d
         1Qf2ltB9kDEWA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8CFE25C1461; Mon,  6 Dec 2021 13:08:13 -0800 (PST)
Date:   Mon, 6 Dec 2021 13:08:13 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     "Paul E. McKenney via Libc-alpha" <libc-alpha@sourceware.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] nptl: Add rseq registration
Message-ID: <20211206210813.GF641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <cover.1638798186.git.fweimer@redhat.com>
 <9c58724d604e160ebda5f667331fa41416c0d12b.1638798186.git.fweimer@redhat.com>
 <1780152866.15126.1638809966443.JavaMail.zimbra@efficios.com>
 <871r2podt9.fsf@oldenburg.str.redhat.com>
 <1614144911.15213.1638816753026.JavaMail.zimbra@efficios.com>
 <87ilw1mu81.fsf@oldenburg.str.redhat.com>
 <20211206201122.GE641268@paulmck-ThinkPad-P17-Gen-1>
 <87k0ghlbsk.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0ghlbsk.fsf@oldenburg.str.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 09:26:51PM +0100, Florian Weimer wrote:
> * Paul E. McKenney via Libc-alpha:
> 
> >> The C memory model is broken and does not prevent out-of-thin-air
> >> values.  As far as I know, this breaks single-copy atomicity.  In
> >> practice, compilers will not exercise the latitude offered by the memory
> >> model.  volatile does not ensure absence of data races.
> >
> > Within the confines of the standard, agreed, use of the volatile keyword
> > does not explicitly prevent data races.
> >
> > However, volatile accesses are (informally) defined to suffice for
> > device-driver memory accesses that communicate with devices, whether via
> > MMIO or DMA-style shared memory.  The device-driver firmware is often
> > written in C or C++.  So doesn't this informal device-driver guarantee
> > need to also do what is needed for userspace code that is communicating
> > with kernel code?  If not, why not?
> 
> The informal guarantee is probably good enough here, too.  However, the
> actual accesses are behind macros, and those macros use either
> non-volatile plain reads or inline assembler (which use
> single-instruction naturally aligned reads).

Agreed, a non-volatile plain read is quite dangerous in this context.

							Thanx, Paul
