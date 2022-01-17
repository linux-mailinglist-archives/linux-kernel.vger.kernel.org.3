Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE72490924
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 14:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240096AbiAQNFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 08:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbiAQNFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 08:05:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D65BC061574;
        Mon, 17 Jan 2022 05:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=okXnBIihNJ45zjlOgVaV9HIZ4gTPr/ksjRMtNE9fq8A=; b=loMPvfhzX0Y2aCcY8FmyxPWYmv
        ra70tAkSHGlVnnENkpYDo41jNZOdowzu1iBT8Ud+sM4P5s0MCs7LriwvrzyUaugGV1d3iBS4T4/wr
        1eCZPth/HiaKLbdOqeG7fJFvQD9ek/SCCjyW+ZwRhuJs02N3UI80H1KmocLVE5LK7xNc+LWy7Fb3Z
        B+mQPZpOK9l/3Sa9DoO6FvxXeJI2rSQEYceR1FHe+Y6tR4tEDP9XjYpQUhiAuIjVho7iaEw4kU0Lm
        4+Ob2BRbptQZNdbtIQlUZMnCqrYn7D8n9ZRCc7ZxtRn0YN623Al6xsfFPaM3iPX2TkJZrfRHpAyvZ
        Njv6XwBg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9Rgu-008DFh-Cp; Mon, 17 Jan 2022 13:04:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 70B7C300237;
        Mon, 17 Jan 2022 14:04:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 27F832D675215; Mon, 17 Jan 2022 14:04:54 +0100 (CET)
Date:   Mon, 17 Jan 2022 14:04:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@posk.io>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca
Subject: Re: [RFC][PATCH 3/3] sched: User Mode Concurency Groups
Message-ID: <YeVpdj/OP+qfAztn@hirez.programming.kicks-ass.net>
References: <20211214204445.665580974@infradead.org>
 <20211214205358.701701555@infradead.org>
 <20211221171900.GA580323@dev-hv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221171900.GA580323@dev-hv>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 05:19:00PM +0000, Peter Oskolkov wrote:
> On Tue, Dec 14, 2021 at 09:44:48PM +0100, Peter Zijlstra wrote:
> > +static struct task_struct *umcg_get_task(u32 tid)
> > +{
> > +	struct task_struct *tsk = NULL;
> > +
> > +	if (tid) {
> > +		rcu_read_lock();
> > +		tsk = find_task_by_vpid(tid);
> > +		if (tsk && current->mm == tsk->mm && tsk->umcg_task)
> 
> This essentially limits all operations to a single mm/process.
> Fine for now, but a fast remote context switch is also a valid use
> case. It is not directly related to userspace scheduling, so I'm
> just mentioning it here. Maybe server-to-server cross-process
> context switches should be allowed for the same user/cgroup? (Again,
> this is for later to consider).

Doing cross-address-space UMCG will be a massive effort, too much
(pretty much everything) in this implementation assumes things are
directly addressable.

> > +			get_task_struct(tsk);
> > +		else
> > +			tsk = NULL;
> > +		rcu_read_unlock();
> > +	}
> > +
> > +	return tsk;
> > +}
