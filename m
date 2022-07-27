Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DBA5831DB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 20:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiG0SUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 14:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243537AbiG0ST2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 14:19:28 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64815B3;
        Wed, 27 Jul 2022 10:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Qjt6jgON/IXxK9vUL+bWcu11UAynI91N7Vvf+lXsDnA=; b=Y4W3ohKogtIsv5sO1rsWnXkRxi
        5K5uHf++cajTI1O4kH4egHglOMQeus8wDRum4prR6t6udBPNq07JZ54X79r4UJMJH02fEC/I/Y2sH
        v65heA7zDLHxHvS7rJjLO4xZmNTPmCVFKs7E5Ga7iwzyEign4+hVEJIq+EcgFwm0YchyRH8C30w+k
        KvERPaM0VaUp4n5N1AbSp9VJhr65btxexX2f+3qEBO83EjsA7A7FATL+HTj44yU92peMLVxFAO/ZF
        eM0DzRb3pPzswO/t+XgtST8E7yS5ado6s5eooxQT2jZbRizD2JSFUDndZq31sVfRbYs2WKLld3mkG
        AyDYg3xw==;
Received: from 201-13-50-220.dsl.telesp.net.br ([201.13.50.220] helo=[192.168.15.109])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oGkhC-008yIs-Ri; Wed, 27 Jul 2022 19:19:42 +0200
Message-ID: <9ef24c18-775b-000a-5a03-4e4fe0f1c83c@igalia.com>
Date:   Wed, 27 Jul 2022 14:19:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC] futex2: add NUMA awareness
Content-Language: en-US
To:     Andrey Semashev <andrey.semashev@gmail.com>
Cc:     linux-api@vger.kernel.org, fweimer@redhat.com,
        linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        libc-alpha@sourceware.org, Davidlohr Bueso <dave@stgolabs.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <36a8f60a-69b2-4586-434e-29820a64cd88@igalia.com>
 <74ba5239-27b0-299e-717c-595680cd52f9@gmail.com>
 <8bfd13a7-ed02-00dd-63a1-7144f2e55ef0@igalia.com>
 <3995754e-064b-6091-ccb0-224c3e698af2@gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <3995754e-064b-6091-ccb0-224c3e698af2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Às 13:42 de 22/07/22, Andrey Semashev escreveu:
> On 7/14/22 18:00, André Almeida wrote:
>> Hi Andrey,
>>
>> Thanks for the feedback.
>>
>> Às 08:01 de 14/07/22, Andrey Semashev escreveu:
>>> On 7/14/22 06:18, André Almeida wrote:
>> [...]
>>>>
>>>> Feedback? Who else should I CC?
>>>
>>> Just a few questions:
>>>
>>> Do I understand correctly that notifiers won't be able to wake up
>>> waiters unless they know on which node they are waiting?
>>>
>>
>> If userspace is using NUMA_FLAG, yes. Otherwise all futexes would be
>> located in the default node, and userspace doesn't need to know which
>> one is the default.
>>
>>> Is it possible to wait on a futex on different nodes?
>>
>> Yes, given that you specify `.hint = id` with the proper node id.
> 
> So any given futex_wake(FUTEX_NUMA) operates only within its node, right?
> 
>>> Is it possible to wake waiters on a futex on all nodes? When a single
>>> (or N, where N is not "all") waiter is woken, which node is selected? Is
>>> there a rotation of nodes, so that nodes are not skewed in terms of
>>> notified waiters?
>>
>> Regardless of which node the waiter process is running, what matter is
>> in which node the futex hash table is. So for instance if we have:
>>
>> 	struct futex32_numa f = {.value = 0, hint = 2};
>>
>> And now we add some waiters for this futex:
>>
>> Thread 1, running on node 3:
>>
>> 	futex_wait(&f, 0, FUTEX_NUMA | FUTEX_32, NULL);
>>
>> Thread 2, running on node 0:
>>
>> 	futex_wait(&f, 0, FUTEX_NUMA | FUTEX_32, NULL);
>>
>> Thread 3, running on node 2:
>>
>> 	futex_wait(&f, 0, FUTEX_NUMA | FUTEX_32, NULL);
>>
>> And then, Thread 4, running on node 3:
>>
>> 	futex_wake(&f, 2, FUTEX_NUMA | FUTEX_32);
>>
>> Now, two waiter would wake up (e.g. T1 and T3, node 3 and 2) and they
>> are from different nodes. futex_wake() doesn't provide guarantees of
>> which waiter will be selected, so I can't say which node would be
>> selected.
> 
> In this example, T1, T2 and T3 are all blocking on node 2 (since all of
> them presumably specify hint == 2), right? In this sense, it doesn't
> matter which node they are running on, what matters is what node they
> block on.

yes

> 
> What I'm asking is can I wake all threads blocked on all nodes on the
> same futex? That is, is the following possible?
> 
>   // I'm using hint == -1 to indicate the current node
>   // of the calling thread for waiters and all nodes for notifiers
>   struct futex32_numa f = {.value = 0, .hint = -1};
> 
>   Thread 1, running on node 3, blocks on node 3:
> 
>   futex_wait(&f, 0, FUTEX_NUMA | FUTEX_32, NULL);
> 
>   Thread 2, running on node 0, blocks on node 0:
> 
>   futex_wait(&f, 0, FUTEX_NUMA | FUTEX_32, NULL);
> 
>   Thread 3, running on node 2, blocks on node 2:
> 
>   futex_wait(&f, 0, FUTEX_NUMA | FUTEX_32, NULL);
> 
>   And then, Thread 4, running on whatever node:
> 
>   futex_wake(&f, -1, FUTEX_NUMA | FUTEX_32);

this futex_wake will wake all futexes waiting on the node that called
futex_wake(), waking only one futex in this example. They are __not__
the same futex. If they have different nodes, they would have different
information inside the kernel.

if you want to wake them all with the same futex_wake(), they need to be
waiting on the same node.

> 
> Here, futex_wake would wake T1, T2 and T3. Or:
> 
>   futex_wake(&f, 1, FUTEX_NUMA | FUTEX_32);

this would behave exactly as the futex_wake() above.

> 
> Here, futex_wake would wake any one of T1, T2 or T3.
> 
>> There's no policy for fairness/starvation for futex_wake(). Do
>> you think this would be important for the NUMA case?
> 
> I'm not sure yet. If there isn't a cross-node behavior like in my
> example above then, I suppose, it falls to the userspace to ensure fair
> rotation of the wakeups on different nodes. If there is functionality
> like this, I imagine, some sort of fairness would be desired.
