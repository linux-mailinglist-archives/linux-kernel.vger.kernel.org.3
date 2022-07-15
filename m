Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B3D575F24
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbiGOKKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbiGOKJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:09:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFB986890
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 03:07:48 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E09BA1FCE2;
        Fri, 15 Jul 2022 10:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657879666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ldpR4C0WJD3AizYWKcDs7wPdesOgYok/aIuXipF+mYM=;
        b=YtZ4afVyFHB4V5zX8YXd/GQiUeYWLHQMQvGWb4cOMjHpRUuLjmY8dhMT4Q2B+gbo3jEK4d
        gVTuZRjFt4wHUcN1/4Nj3J1MmSeXI6uGUArPrUNQ0xsOvvhO19LcwmWZAvKkMstq8dQcGf
        a+F1MkZnzOylHGNHs6GMlSEGBtMjg6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657879666;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ldpR4C0WJD3AizYWKcDs7wPdesOgYok/aIuXipF+mYM=;
        b=/K53UT486Qo6p5opz7fiHI/OUusoh3E87aeuznV8apcKk/mJHKSaGzmdcRBQRahIc8uXvS
        T65e2/2RPYCqt1Ag==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E6F612C141;
        Fri, 15 Jul 2022 10:07:45 +0000 (UTC)
Date:   Fri, 15 Jul 2022 11:07:38 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Libo Chen <libo.chen@oracle.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>, peterz@infradead.org,
        vincent.guittot@linaro.org, 21cnbao@gmail.com,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] sched/fair: no sync wakeup from interrupt context
Message-ID: <20220715100738.GD3493@suse.de>
References: <20220711224704.1672831-1-libo.chen@oracle.com>
 <2c0c61a1c4c54d06905279a9a724a9390d9ee5c3.camel@linux.intel.com>
 <0917f479-b6aa-19de-3d6a-6fd422df4d21@oracle.com>
 <20220714141834.GC3493@suse.de>
 <0c0dab83-807d-317e-af1a-7bd898626b86@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c0dab83-807d-317e-af1a-7bd898626b86@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 01:21:14PM -0700, Libo Chen wrote:
> > state explicitly that "the interrupt CPU isn't as performance critical as
> > cache from its previous CPU" so that assumption was incorrect, at least
> > in your case. I don't have a counter example where the interrupt data *is*
> > more important than any other cache-hot data so the check can go.
> > 
> > I think a revert would not achieve what you want as a plain revert would
> > still allow an interrupt to pull a task from an arbitrary location as sync
> This is the tricky part, I didn't explain it well. For rds-stress, it's a
> lot (~30%) better to allow pulling across nodes when the waking CPU is idle.

Ah, the exact opposite then.

> I think this may be an example of interrupt data being more important.
> Something
> like below will help a lot for this particular benchmark (rds-stress):
> 
> if (available_idle_cpu(this_cpu))
>         return this_cpu;
> 

I see but this will likely regress for workloads that receive interrupts on
arbitrary CPUs that are not related to the tasks preferred location. This
can happen for IO completions for example where interrupts can be delivered
round-robin to many CPUs in the system. It's all described in the changelog
for 7332dec055f2

	Unfortunately, depending on the type of interrupt and IRQ
	configuration, there may not be a strong relationship between the
	CPU an interrupt was delivered on and the CPU a task was running
	on. For example, the interrupts could all be delivered to CPUs on
	one particular node due to the machine topology or IRQ affinity
	configuration. Another example is an interrupt for an IO completion
	which can be delivered to any CPU where there is no guarantee the
	data is either cache hot or even local.

> still pulls
> the wakee task to that CPU across nodes irrespective of its previous CPU.
> And that's
> what this patch tries to address.
> 

> Mel, I am thinking about a follow-up patch like below then we can continue
> the discussion
> there since this is kinda a separate issue:
> 
> -	if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
> -		return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
> -
> 
> +       if (available_idle_cpu(this_cpu))
> +               if (cpus_share_cache(this_cpu, prev_cpu))
> +                       return available_idle_cpu(prev_cpu) ? prev_cpu :
> this_cpu;
> +       else
> +               return this_cpu;
> 

That will also pull tasks cross-node and while it might work well for a
network stress test, it will hurt other cases where the interrupt data
is relatively unimportant to the waking task.

-- 
Mel Gorman
SUSE Labs
