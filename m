Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90415154D2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 21:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380390AbiD2ToD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 15:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380409AbiD2Tn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 15:43:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD3625EBB;
        Fri, 29 Apr 2022 12:40:35 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651261233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G90v80vwxgYebC2KpfsavbID4TjF7nvhmIxKehMfUYQ=;
        b=pZPNUNH38ZyrulW1gVyK7RQHeNmUxDGxyKgocGuGA19UkVDw77lNYg5EFi5BwOeT7yETco
        NHonRRs0NIfW1kh5aDjhpTxWrIMx4AY1us7hehofLPLMe8YzWT/vm+qXNP1frMm0vKEf9J
        HJqztNhv0R65XwUzK5gzW2SZBFkErw6J/T+pX4SFSHswSIIkaw58lDe2Gv84rDnJDbfgJs
        av7E0MHU9UfZa44TGzDjD1gXQKExFbwGQgW/oYUWT3LmPHgt5iHkKmiRZqBS7mozdSPbyD
        aSGHodTcutREinGB0y8eVSGWQwUBrvf+x60WIPHXr5P6e7B+AO2y9tEsUFYRMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651261233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G90v80vwxgYebC2KpfsavbID4TjF7nvhmIxKehMfUYQ=;
        b=Dco0825afeNJzSw4/gXGisLWZg8ApVZ3M34zsr6XMae0tshtLBu71pGg4BXyHcfj75GOAZ
        KTZTrUdUTEoRe1CQ==
To:     Marc Zyngier <maz@kernel.org>, Thomas Pfaff <tpfaff@pcs.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v2] irq/core: synchronize irq_thread startup
In-Reply-To: <87sfpv98j0.wl-maz@kernel.org>
References: <1e3f96b7-9294-1534-e83b-efe3602f876f@pcs.com>
 <87sfpv98j0.wl-maz@kernel.org>
Date:   Fri, 29 Apr 2022 21:40:32 +0200
Message-ID: <87fslvoez3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29 2022 at 17:08, Marc Zyngier wrote:
> On Fri, 29 Apr 2022 12:52:48 +0100,
> Thomas Pfaff <tpfaff@pcs.com> wrote:

 > +static void wait_for_irq_thread_startup(struct irq_desc *desc,
 > +		struct irqaction *action)

 and this would be wait_for_irq_thread_ready().

which is sill a misnomer as this actually wakes and waits.

>> @@ -1522,6 +1548,8 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
>>  		}
>>  	}
>>  
>> +	init_waitqueue_head(&desc->wait_for_threads);
>> +
>
> I'm trying to convince myself that this one is safe.
>
> It was so far only done when registering the first handler of a
> threaded interrupt, while it is now done on every call to
> __setup_irq().  However, this is now done outside of the protection of
> any of the locks, meaning that a concurrent __setup_irq() for a shared
> interrupt can now barge in and corrupt the wait queue.
>
> So I don't think this is right. You may be able to hoist the
> request_lock up, but I haven't checked what could break, if anything.

It can't be moved here, but I can see why Thomas wants to move it. With
a spurious wakeup of the irq thread (should not happen), the thread
would try to invoke wake_up() on a non initialize wait queue head.

Something like this should do the trick.

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 939d21cd55c3..0099b87dd853 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -407,6 +407,7 @@ static struct irq_desc *alloc_desc(int irq, int node, unsigned int flags,
 	lockdep_set_class(&desc->lock, &irq_desc_lock_class);
 	mutex_init(&desc->request_mutex);
 	init_rcu_head(&desc->rcu);
+	init_waitqueue_head(&desc->wait_for_threads);
 
 	desc_set_defaults(irq, desc, node, affinity, owner);
 	irqd_set(&desc->irq_data, flags);
@@ -575,6 +576,7 @@ int __init early_irq_init(void)
 		raw_spin_lock_init(&desc[i].lock);
 		lockdep_set_class(&desc[i].lock, &irq_desc_lock_class);
 		mutex_init(&desc[i].request_mutex);
+		init_waitqueue_head(&desc[i].wait_for_threads);
 		desc_set_defaults(i, &desc[i], node, NULL, NULL);
 	}
 	return arch_early_irq_init();
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c03f71d5ec10..6a0942f4d068 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1683,8 +1683,6 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	}
 
 	if (!shared) {
-		init_waitqueue_head(&desc->wait_for_threads);
-
 		/* Setup the type (level, edge polarity) if configured: */
 		if (new->flags & IRQF_TRIGGER_MASK) {
 			ret = __irq_set_trigger(desc,

Thanks,

        tglx
