Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B1B467B3D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 17:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352096AbhLCQZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 11:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349889AbhLCQZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 11:25:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A832EC061751;
        Fri,  3 Dec 2021 08:22:14 -0800 (PST)
Date:   Fri, 3 Dec 2021 17:22:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638548532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BJ6x9GmhrMGSwleKWOyUnt6LaxJim77CKztb61Kx8l4=;
        b=lyum7gvBn8nygbp+Au1Oq42kgYVbwkSLmcXAkzVYHNTQdzRNVqKrO/5mv/UFmC2QUItLmy
        RCsrLqpnp/XycPynd6SE8bVDFppJk1wmLnjvcmnEMz0xO6i2nDgd3mnNTtgU+rPxJZFQXA
        fpHrEre47SiUSCuaJy5fDy8qOhBDpXCnyw6qbI5JudCoT8cyemjC2ru3BDiD5mI7tNsegf
        C04D8xR/XWtoyUj0ux3PpWKF3/W9M9Ty/ZX5WW0EK3X1xxbsaEkoEAs0zF10nODWFN1i/6
        MXQIJKA77zgnRQjLXu6JWKSgzKOgy873aA8E/zapXpEFDCVXU8rsenEX3R/2GQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638548532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BJ6x9GmhrMGSwleKWOyUnt6LaxJim77CKztb61Kx8l4=;
        b=94vvCxucgox7cFwviKtvhz2CZXAphlNc8z06ilF52qco2dvXgJ2KYaTogkTipJBHyjlw2K
        bVIJo0SA4WC0XPBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        tglx@linutronix.de
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 0/8] kernel/fork: Move thread stack free otu of the
 scheduler path.
Message-ID: <20211203162211.qvcnvbj4cdsa5g3a@linutronix.de>
References: <20211118143452.136421-1-bigeasy@linutronix.de>
 <20211118143850.ygpp7xetpz3pt2nj@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211118143850.ygpp7xetpz3pt2nj@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-18 15:38:50 [+0100], To linux-kernel@vger.kernel.org wrote:
> + tglx.
> 
> It starts at
>    https://lore.kernel.org/all/20211118143452.136421-1-bigeasy@linutronix.de/
> 
> On 2021-11-18 15:34:44 [+0100], To linux-kernel@vger.kernel.org wrote:
> > 
> > This is a follup-up on the patch
> >     sched: Delay task stack freeing on RT 
> >     https://lkml.kernel.org/r/20210928122411.593486363@linutronix.de
> > 
> > It addresses the review feedback:
> > - Decouple stack accounting from its free invocation. The accounting
> >   happens in do_exit(), the final free call happens later.
> > 
> > - Add put_task_stack_sched() to finish_task_switch(). Here the VMAP
> >   stack is cached only. If it fails, or in the !VMAP case then the final
> >   free happens in delayed_put_task_struct(). This is also an oportunity
> >   to cache the stack.

ping ;)

Sebastian
