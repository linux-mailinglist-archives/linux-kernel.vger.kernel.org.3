Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A269647BF3D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237356AbhLUMBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhLUMBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:01:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D33C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 04:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/np5QlSTz8/ujwhtkvoBV5dzvVVLXX1ELEQ/iqgLwWw=; b=BdcCavnbRz0a8drgYiKmhVZhiB
        P/u2OJmlyX6qNny2EHnq6YDo7D6MgdVkiEkZ7wpWo7lGRPzS1tAkiqWcZlyhQ13ZQe1Nn7xpjVfoD
        wH+W8P4yGrTUEkUFTqkUfS5oRCGf9OT7A5UTLzZ2RNuZ+WeYLnbJxtqYd2CN2hLdgoKHpubmxA1TJ
        tv6zqqPayinOirRDxe8oFd3xM7tcelcngBNZ7Y6vsNVtiOLjJ8hG5dPf3egc11rjsB5Mko6L0y4Lb
        12YOPYGYYAqi2dvQrduEJ9Z9H+0PQ05cVjhl1PHVIWbC+BD1KwzOqxzGL0fpv68SPoVt7/uFtGYHP
        l6RcjeeA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzdpa-002RIM-Rm; Tue, 21 Dec 2021 12:01:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 32F1A300129;
        Tue, 21 Dec 2021 13:01:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 13FCE2CFD6134; Tue, 21 Dec 2021 13:01:22 +0100 (CET)
Date:   Tue, 21 Dec 2021 13:01:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     xuhaifeng <xuhaifeng@oppo.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH] sched: optimize __cond_resched_lock()
Message-ID: <YcHCEm/6AL0DQrv7@hirez.programming.kicks-ass.net>
References: <20211221072316.42-1-xuhaifeng@oppo.com>
 <YcGVzClid/7q3DuB@hirez.programming.kicks-ass.net>
 <YcGnvDEYBwOiV0cR@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcGnvDEYBwOiV0cR@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 11:09:00AM +0100, Peter Zijlstra wrote:
> On Tue, Dec 21, 2021 at 09:52:28AM +0100, Peter Zijlstra wrote:
> > On Tue, Dec 21, 2021 at 03:23:16PM +0800, xuhaifeng wrote:
> > > if the kernel is preemptible(CONFIG_PREEMPTION=y), schedule()may be
> > > called twice, once via spin_unlock, once via preempt_schedule_common.
> > > 
> > > we can add one conditional, check TIF_NEED_RESCHED flag again,
> > > to avoid this.
> > 
> > You can also make it more similar to __cond_resched() instead of making
> > it more different.
> 
> Bah, sorry, had to wake up first :/
> 
> cond_resched_lock still needs to exist for PREEMPT because locks won't
> magically release themselves.
> 
> Still don't much like the patch though, how's this work for you?
> 
> That's arguably the right thing to do work PREEMPT_DYNAMIC too.

Duh, those would need cond_resched() proper, clearly I should just give
up and call it a holiday already..
