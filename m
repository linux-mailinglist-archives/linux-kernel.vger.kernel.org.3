Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153C8492863
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 15:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbiARO3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 09:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiARO3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 09:29:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1357FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 06:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6h1Zdr2EydcVe9RHTPIOffSWxJ2GattgKQcuFo1Sgpc=; b=XWJBblrlv8Jt4qr8OGjvdKAMAA
        QtTgYzW+R6Ivc64T0KV8TL1o2Fn+EalccwpsRJZW8YypLQ9laTwaCAb6Dg8XSpr4dlTOCb9bzKGfJ
        o5saOMBiNQAFQXrg3Xv/eXepOy74ZYZY16YjbhaK6f6z+Cy0hQgaeaoHwcbQMCvuaVqyTZrxs8tcf
        O3R5dQ3AkEJJ7yYXVE7fnJlvgYWAJdusI9l7+yZYp6giJtOPA367IxOxLHNprrIYbMZXKq5lidqJ3
        cJBiEa8HWnitjLWIbs2MgfEz3eIfF4sqcCOkgDP5EuTXg80xQEX1avksD9OfFlPt81imSi0cybGsR
        wL1RNeMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9pTx-009HrY-Kd; Tue, 18 Jan 2022 14:29:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 17A63300252;
        Tue, 18 Jan 2022 15:29:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F32442015FD51; Tue, 18 Jan 2022 15:29:07 +0100 (CET)
Date:   Tue, 18 Jan 2022 15:29:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Walt Drummond <walt@drummond.us>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ar@cs.msu.ru,
        linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        mm <linux-mm@kvack.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 3/3] status: Display an informational message when the
 VSTATUS character is pressed or TIOCSTAT ioctl is called.
Message-ID: <YebOs1OWRAru2v5B@hirez.programming.kicks-ass.net>
References: <20220118044323.765038-1-walt@drummond.us>
 <20220118044323.765038-3-walt@drummond.us>
 <72a719a0-cd7c-9516-93c2-bd258930b71e@kernel.org>
 <YeamX3ELWyc/BtGp@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeamX3ELWyc/BtGp@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 12:37:03PM +0100, Peter Zijlstra wrote:
> > > +static inline struct task_struct *compare(struct task_struct *new,
> > > +					  struct task_struct *old)
> > > +{
> > > +	unsigned int ostate, nstate;
> > > +
> > > +	if (old == NULL)
> > > +		return new;
> > > +
> > > +	ostate = task_state_index(old);
> > > +	nstate = task_state_index(new);
> > > +
> > > +	if (ostate == nstate) {
> 
> That's not an ordered set, please don't do that.

*sigh*.. sorry about that, I can't read, for some reason I thought you
did: ostate < nstate...

> > > +		if (old->start_time > new->start_time)
> > > +			return old;
> > > +		return new;
> > > +	}
> > > +
> > > +	if (ostate < nstate)
> > > +		return old;
> > > +
> > > +	return new;
> > > +}
