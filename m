Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACDA4A654B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 21:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbiBAUDY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Feb 2022 15:03:24 -0500
Received: from albireo.enyo.de ([37.24.231.21]:53550 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234665AbiBAUDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 15:03:22 -0500
Received: from [172.17.203.2] (port=47847 helo=deneb.enyo.de)
        by albireo.enyo.de ([172.17.140.2]) with esmtps (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        id 1nEzMv-00H7gd-QZ; Tue, 01 Feb 2022 20:03:13 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.94.2)
        (envelope-from <fw@deneb.enyo.de>)
        id 1nEzMv-000OiE-CV; Tue, 01 Feb 2022 21:03:13 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        David.Laight@ACULAB.COM, carlos@redhat.com,
        Peter Oskolkov <posk@posk.io>
Subject: Re: [RFC PATCH 2/3] rseq: extend struct rseq with per thread group
 vcpu id
References: <20220201192540.10439-1-mathieu.desnoyers@efficios.com>
        <20220201192540.10439-2-mathieu.desnoyers@efficios.com>
Date:   Tue, 01 Feb 2022 21:03:13 +0100
In-Reply-To: <20220201192540.10439-2-mathieu.desnoyers@efficios.com> (Mathieu
        Desnoyers's message of "Tue, 1 Feb 2022 14:25:39 -0500")
Message-ID: <87bkzqz75q.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

> If a thread group has fewer threads than cores, or is limited to run on
> few cores concurrently through sched affinity or cgroup cpusets, the
> virtual cpu ids will be values close to 0, thus allowing efficient use
> of user-space memory for per-cpu data structures.

From a userspace programmer perspective, what's a good way to obtain a
reasonable upper bound for the possible tg_vcpu_id values?

I believe not all users of cgroup cpusets change the affinity mask.

> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index 13f6d0419f31..37b43735a400 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -86,10 +86,14 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
>  	struct rseq __user *rseq = t->rseq;
>  	u32 cpu_id = raw_smp_processor_id();
>  	u32 node_id = cpu_to_node(cpu_id);
> +	u32 tg_vcpu_id = task_tg_vcpu_id(t);
>  
>  	if (!user_write_access_begin(rseq, t->rseq_len))
>  		goto efault;
>  	switch (t->rseq_len) {
> +	case offsetofend(struct rseq, tg_vcpu_id):
> +		unsafe_put_user(tg_vcpu_id, &rseq->tg_vcpu_id, efault_end);
> +		fallthrough;
>  	case offsetofend(struct rseq, node_id):
>  		unsafe_put_user(node_id, &rseq->node_id, efault_end);
>  		fallthrough;

Is the switch really useful?  I suspect it's faster to just write as
much as possible all the time.  The switch should be well-predictable
if running uniform userspace, but still …
