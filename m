Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DD550A529
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390478AbiDUQ1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiDUQOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:14:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7E42B241
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:11:58 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650557517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Co+vGxQAnvjE28xN2iS2qSyvQ7+qNi2mwvNPw4R/fZk=;
        b=BaypSsIzdcER11NDsYhBqeiO6h0kW1VoNrXw1mRnOiGjw3zHAcrg4LrD53LAUGez4e1C6+
        jHr7Fp2APUeu3QTYZmVAhm2BRkitxZF5ud6TcRQ9fGMoTMeYRwhBPVRRhjvai6KzZ5EHKA
        0dnpx2UM0sCZ5fV8DbyY1Gb8CXi6+y+WkjrVpg2SmWsgSlTdJ4j4dhFi+Z27KY9Gr3yxX/
        JdOWhxwu84Nhn3EtEqrih12el44uy3fu7hybJwXJGib1INO194dEaCv8GNHE8F6759DL8t
        1vDYugl5oVAakWK7O0xugEAt8j+DczJsOLJmyXjtIzkXaTQMPQnvAfFmHKoVlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650557517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Co+vGxQAnvjE28xN2iS2qSyvQ7+qNi2mwvNPw4R/fZk=;
        b=fHDsl12W3lskK/WA5YoKeFFXgA5KMSxzJTX0I707X/zEBoI1l9pDlwdCg+GJuE7vBBVcKF
        3GShvFgeXx5JODDA==
To:     Pingfan Liu <kernelfans@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Baokun Li <libaokun1@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Price <steven.price@arm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 7/9] irq: remove needless lock in takedown_cpu()
In-Reply-To: <20220420140521.45361-8-kernelfans@gmail.com>
References: <20220420140521.45361-1-kernelfans@gmail.com>
 <20220420140521.45361-8-kernelfans@gmail.com>
Date:   Thu, 21 Apr 2022 18:11:56 +0200
Message-ID: <87y1zys9f7.ffs@tglx>
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

On Wed, Apr 20 2022 at 22:05, Pingfan Liu wrote:

First of all, the subject prefix for the core interrupt subsystem is
'genirq' and the sentence after the colon starts with an uppercase
letter. See:

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html

> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index d0a9aa0b42e8..94a6b512c26d 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1033,18 +1033,16 @@ static int takedown_cpu(unsigned int cpu)
>  	kthread_park(st->thread);
>  
>  	/*
> -	 * Prevent irq alloc/free while the dying cpu reorganizes the
> -	 * interrupt affinities.
> +	 * RCU keeps watching 'cpu' until do_idle()->rcu_report_dead().
> +	 * And cpu_stopper's fn is dispatched with preemption disabled.
> +	 * So it can not occur to release a irq_desc.
>  	 */
> -	irq_lock_sparse();

Not everything is about RCU here. You really need to look at all moving
parts:

irq_migrate_all_off_this_cpu() relies on the allocated_irqs bitmap and
the sparse tree to be in consistent state, which is only guaranteed when
the sparse lock is held.

I'm not sure what you are trying to solve here. Not taking sparse_irq_lock
here is not gaining anything.

Thanks,

        tglx
