Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664284E513D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 12:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243883AbiCWLXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 07:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243864AbiCWLXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 07:23:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097027938A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 04:21:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648034518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y1DDIKvSFBHGvys+scil0oGzmCVScxpU1UzE7+Rqw74=;
        b=AiOGH3vWEa+aNlAqH0iIM0ykEkLFsWCBYWVQRHaTuiAf7sPlM0H81aXMJoMkywGQueRhVO
        KFEU+NtNbfGsb45qKK5Y4gGpZPyaqFhcQ7qct87/XX5xY4xSsALJ2qjkhxwOe85jnbOPGd
        6kAmKbVACJD8ZpL7NyvmqFPB/P6BpfLm9pE2VSc9c3TqBwgKa+iV7rtUb30fqWieFCOuRb
        a7qwLYK7pEhORnj6DlHADvywZ824pw/oM83NpipS1I8EB7p1tg3HUfEjkUshaZiS/roWt4
        bCl/HAjD9YxQgn4xHhFUKQju1qMNKO9balJIy5Ick14yNm6h3uJvKpeTveln2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648034518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y1DDIKvSFBHGvys+scil0oGzmCVScxpU1UzE7+Rqw74=;
        b=Q8ixCOEqgiWjt8lU2QDdeWx2M6WrHcJ3U6D+75dfEaTia2HrbO7aOCoZiq/Ux2Skn8Bpw4
        HcMDEAT9d7YTRKBA==
To:     Steven Price <steven.price@arm.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2] cpu/hotplug: Set st->cpu earlier
In-Reply-To: <a704e21e-c1a6-6ffd-439c-e715a2633319@arm.com>
References: <20220316153637.288199-1-steven.price@arm.com>
 <878rt2atre.ffs@tglx> <bc66bee6-7c99-b289-f5e9-ccaf03d5605d@arm.com>
 <87wngla932.ffs@tglx> <a704e21e-c1a6-6ffd-439c-e715a2633319@arm.com>
Date:   Wed, 23 Mar 2022 12:21:48 +0100
Message-ID: <87czicap83.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23 2022 at 10:10, Steven Price wrote:
> On 22/03/2022 22:58, Thomas Gleixner wrote:
>> Indeed. But the description is not the only problem here:
>> 
>> It's completely uncomprehensible from the code in _cpu_up() _WHY_ this
>> 
>>      st->cpu = cpu;
>>      
>> assignment has to be there.
>> 
>> It's non-sensical if you really think about it, right?
>
> I entirely agree, and I did ask in my v1 posting[1] if anyone could
> point me to a better place to do the assignment. Vincent suggested
> moving it earlier in _cpu_up() which is this v2.
>
> But it still seems out-of-place to me. I've just had a go at simply
> removing the 'cpu' member and it doesn't look too bad. I'll post that
> patch as a follow up. I'm open to other suggestions for the best way to
> fix this.

Yes, we can do that. The alternative solution is to initialize the
states once upfront. Something like the uncompiled below.

Thanks,

        tglx
---
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -714,15 +714,6 @@ static int cpuhp_up_callbacks(unsigned i
 /*
  * The cpu hotplug threads manage the bringup and teardown of the cpus
  */
-static void cpuhp_create(unsigned int cpu)
-{
-	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
-
-	init_completion(&st->done_up);
-	init_completion(&st->done_down);
-	st->cpu = cpu;
-}
-
 static int cpuhp_should_run(unsigned int cpu)
 {
 	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
@@ -882,15 +873,28 @@ static int cpuhp_kick_ap_work(unsigned i
 
 static struct smp_hotplug_thread cpuhp_threads = {
 	.store			= &cpuhp_state.thread,
-	.create			= &cpuhp_create,
 	.thread_should_run	= cpuhp_should_run,
 	.thread_fn		= cpuhp_thread_fun,
 	.thread_comm		= "cpuhp/%u",
 	.selfparking		= true,
 };
 
+static __init void cpuhp_init_state(void)
+{
+	struct cpuhp_cpu_state *st;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		st = per_cpu_ptr(&cpuhp_state, cpu);
+		init_completion(&st->done_up);
+		init_completion(&st->done_down);
+		st->cpu = cpu;
+	}
+}
+
 void __init cpuhp_threads_init(void)
 {
+	cpuhp_init_state();
 	BUG_ON(smpboot_register_percpu_thread(&cpuhp_threads));
 	kthread_unpark(this_cpu_read(cpuhp_state.thread));
 }
