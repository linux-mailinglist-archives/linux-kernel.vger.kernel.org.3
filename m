Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4056F4F5F8B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbiDFNU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbiDFNUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:20:45 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFB13CAF2D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 03:01:02 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id t25so3166064lfg.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 03:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ce0iJzgCIHHOpZmIxOx1PZ02f2jXcsJcbDW9EK00h6E=;
        b=a0YqmMBXrk5NUm0SO4wg2X/pZ/UOk3/9o8rdLBpRprpeD0IcisnKmwgC5vqchY4Tnf
         zCkYwqdhNQ1egj/bWCE1I+wgu4I2zvzfFEaCesESgcJ9Axx0G8Jjq3mKqFyNKUiq4YNN
         2siTOcum3TWZvmMzB0T2Y6eXP2QV0z20r3TaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ce0iJzgCIHHOpZmIxOx1PZ02f2jXcsJcbDW9EK00h6E=;
        b=1/SALaw0F+CxRvCXrfUn8Wc6umUmrMMw2gVGrsq9oS7P3qeUeaUo+c91BCnscusNcB
         u15FWFwuI9gMJdiIUsnu01/JJRSou5o6LZvEERcJOoDflV+W8xYlPEwO4lZByZ5dXq95
         /bcNb5LJnkw2f0QQ/9XZFvyQpA6YeR18pkm5pw6HLQcPTBV4VJwrYn3OmdEvD9NId9jS
         MnzEPWZK6ImhOOoHnXGSgPLAEQEDiCX/Egtx+prNajmuaXI2DUGW6eOVRpy/AM38MAE9
         K25k+grm0WdtXiTj2BuMvH/OLCknOq2MfpC/THTnsmyn4XKdGHLIFj2s0ykZfQeQMSTG
         46MQ==
X-Gm-Message-State: AOAM532+EybHEZWdsnzsvRnXLWUjhdK/4n0UAzz36YDmmTI31124aneQ
        K8UdQqmRRLNalsmNDoWe8PeFF8UFjIt7Q5zo
X-Google-Smtp-Source: ABdhPJzaZfOxf4PkYGYckjccQ8y6xANyGEfvkaJdnTNvh8UqtItuiRLFR/X3n73TsiTSCKXIgY2Y1A==
X-Received: by 2002:a05:6512:3d8e:b0:44a:3ad1:8bae with SMTP id k14-20020a0565123d8e00b0044a3ad18baemr5352184lfv.231.1649239251588;
        Wed, 06 Apr 2022 03:00:51 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d23-20020a056512369700b0045080f3fcd5sm757273lfs.114.2022.04.06.03.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 03:00:50 -0700 (PDT)
Message-ID: <0ec367bf-8609-3139-2984-6df3bb3cd28c@rasmusvillemoes.dk>
Date:   Wed, 6 Apr 2022 12:00:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 0/2] RT scheduling policies for workqueues
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Tejun Heo <tj@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
        Peter Hurley <peter@hurleysoftware.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Esben Haabendal <esben@geanix.com>,
        Steven Walter <stevenrwalter@gmail.com>,
        linux-kernel@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?UTF-8?Q?Andr=c3=a9_Pribil?= <a.pribil@beck-ipc.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-rt-users@vger.kernel.org
References: <20220323145600.2156689-1-linux@rasmusvillemoes.dk>
 <YkGIhYKJG+w4L7ge@linutronix.de>
 <20220328100927.5ax34nea7sp7jdsy@pengutronix.de>
 <YkHyzcfiyjLfIVOo@slm.duckdns.org> <YkKnlUUsufZPiZxM@linutronix.de>
 <8b21ad64-ea9c-84f2-c798-222c9383e3de@rasmusvillemoes.dk>
 <YkbEDoPBKzVUqNLb@linutronix.de>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <YkbEDoPBKzVUqNLb@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2022 11.21, Sebastian Andrzej Siewior wrote:
> On 2022-03-29 10:33:19 [+0200], Rasmus Villemoes wrote:
>> On 29/03/2022 08.30, Sebastian Andrzej Siewior wrote:
>>> On 2022-03-28 07:39:25 [-1000], Tejun Heo wrote:
>>>> Hello,
>>> Hi,
>>>
>>>> I wonder whether it'd be useful to provide a set of wrappers which can make
>>>> switching between workqueue and kworker easy. Semantics-wise, they're
>>>> already mostly aligned and it shouldn't be too difficult to e.g. make an
>>>> unbounded workqueue be backed by a dedicated kthread_worker instead of
>>>> shared pool depending on a flag, or even allow switching dynamically.
>>
>> Well, that would certainly not make it any easier for userspace to
>> discover the thread it needs to chrt().
> 
> It should be configured within the tty-layer and not making a working RT
> just because it is possible.

I'm sorry, I can't parse that sentence.

The tty-layer cannot possibly set the right RT priorities, only the
application/userspace/the BSP developer knows what is right. The kernel
has rightly standardized on just the two sched_set_fifo and
sched_set_fifo_low; the admin must configure the system, but that also
requires that the admin has access to knobs to actually do that.
>>
>> Here's another idea: In an ideal world, the irq thread itself [people
>> caring about latency use threaded interrupts] could just do the work
>> immediately - then the admin only has one kernel thread to properly
>> configure. However, as Sebastian pointed out, doing that leads to a
>> lockdep splat [1], and it also means that there's no work item involved,
>> so some other thread calling tty_buffer_flush_work() might not actually
>> wait for a concurrent flush_to_ldisc() to finish. So could we create a
>> struct hybrid_work { } which, when enqueued, does something like
>>
>>   bool current_is_irqthread(void) { return in_task() &&
>> kthread_func(current) == irq_thread; }
>>
>> hwork_queue(struct hybrid_work *hwork, struct workqueue_struct *wq)
>>   if (current_is_irqthread()) {
>>     task_work_add(current, &hwork->twork)
>>   } else {
>>     queue_work(wq, &hwork->work);
>>   }
>>
>> (with extra bookkeeping so _flush  and _cancel_sync methods can also be
>> created). It would require irqthread to learn to run its queued
>> task_works in its main loop, which in turn would require finding some
>> other way to do the irq_thread_dtor() cleanup, but that should be doable.
>>
>> While the implementation of hybrid_work might be a bit complex, I think
>> this would have potential for being used in other situations, and for
>> the users, the API would be as simple as the current workqueue/struct
>> kwork APIs. By letting the irq thread do more/all of the work, we'd
>> probably also win some latency due to fewer threads involved and better
>> cache locality. And the admin/BSP is already setting the rt priorities
>> of the [irq/...] threads.
> 
> Hmmm. Sounds complicated. Especially the part where irqthread needs to
> deal with irq_thread_dtor in another way.

Well, we wouldn't need to use the task_work mechanism, we could also add
a list_head to struct irqaction {} aka the irq thread's kthread_data().

> If this is something we want for everyone and not just for the "low
> latency" attribute because it seems to make sense for everyone, would it
> work to add the data in one step and then flush it once all locks are
> dropped? The UART driver could be extended to a threaded handler if it
> is not desired/ possible to complete in the primary handler.

Yes, the idea is certainly to create something which is applicable more
generally than just for the tty problem. There are lots of places where
one ends up with a somewhat silly situation in that the driver's irq
handler is carefully written to not do much more than just schedule a
work item, so with the -RT patch set, we wake a task so it can wake a
task so it can ... And it also means that the admin might have carefully
adjusted the rt priority of the irq/foobar kernel thread and the
consuming application, but that doesn't matter when there's some random
SCHED_OTHER task in between - i.e. exactly the tty problem.

I guess I should write some real patches to explain what I mean more
clearly.

Rasmus
