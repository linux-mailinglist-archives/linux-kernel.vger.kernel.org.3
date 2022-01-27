Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDDC49E257
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236652AbiA0M0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiA0M0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:26:51 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB16C061714;
        Thu, 27 Jan 2022 04:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xCYE4SmkeSrJ/gO0loi27APL7J8Db6LU2KX4K0PIjaI=; b=A30XOGuJA/JxBw4lIYvZJ/9x2j
        0k8YY2KWX97rf6IFh3fwraK1Gvl801c0RPrWiKA7VSER0jW+KZKlJ9VSE6T1I7mV84wCc/7hHPIRZ
        q9fLE3bCZmOEAgqrw1Nq+DY90K8AgD5+LOgXzhY5xsPUf32D7QsmO3BcZ2XYV9/znw1Ng0WM+HWX6
        HlcjbQY/ILaKk3zPrXlBkR9NmOTzQ18Z/dq7HNONjMU+X93Pt5K5DhO+D/FoKOjs3yDbeFB4n1dpH
        emS+RF/gag6W6gfxdTPpG16xiI/s0sRVUYV47AvsDBegvX+Kdg6bfeJPI/z39+V8Nq7u6R1DLvzZ3
        t0uYPFTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nD3r9-004AGk-BN; Thu, 27 Jan 2022 12:26:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8FFC93002A6;
        Thu, 27 Jan 2022 13:26:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 79F342B52092A; Thu, 27 Jan 2022 13:26:26 +0100 (CET)
Date:   Thu, 27 Jan 2022 13:26:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca, mark.rutland@arm.com,
        posk@posk.io
Subject: Re: [RFC][PATCH v2 5/5] sched: User Mode Concurency Groups
Message-ID: <YfKPcrc4qp5HeIjC@hirez.programming.kicks-ass.net>
References: <20220120155517.066795336@infradead.org>
 <20220120160822.914418096@infradead.org>
 <Ye67uQa4CwUuQJVY@geo.homenetwork>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye67uQa4CwUuQJVY@geo.homenetwork>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 10:46:17PM +0800, Tao Zhou wrote:
> > +/**
> > + * sys_umcg_wait: transfer running context
> > + *
> > + * Called like:
> > + *
> > + *	self->state = UMCG_TASK_RUNNABLE | UMCG_TF_COND_WAIT;
> > + *	...
> > + *	sys_umcg_wait(0, time);
> > + *
> > + * The syscall will clear TF_COND_WAIT and wait until state becomes RUNNING.
> > + * The code '...' must not contain syscalls
> > + *
> > + * If self->next_tid is set and indicates a valid UMCG task with RUNNABLE state
> > + * that task will be made RUNNING and woken -- transfering the running context
> > + * to that task. In this case self->next_tid is modified with TID_RUNNING to
> > + * indicate self->next_tid is consumed.
> > + *
> > + * If self->next has TID_RUNNING set, it is validated the related task has
> 
> /self->next/self->next_tid/

Yeah, there's more of that, I'll be sure to go re-read all the comments.

