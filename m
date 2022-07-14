Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFFA575155
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 17:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239834AbiGNPB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 11:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239817AbiGNPB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 11:01:26 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EF45E33B;
        Thu, 14 Jul 2022 08:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SD+E46jleghc1zhKhR9PveNf5aZVNxzYDkkNEuLw6xs=; b=jPDf1sXvRlPt3kdJgvEDxX2uey
        IoOgOI2HYUqGtfmOWtAn/eLsTaubeRmEpDtlThTCaZPwh0qo4P1axzKtPseySrD5Z6TKVVf6Gx+J8
        gwHyY7HD7pLZ1C4EqAV8nJIwcWGj3NENks9j2m0vCDOYMwuT0t/E8/6AY7TNYUuCW6X3CRo4Li2Mg
        xHCkAj6UAHswTSl4wssGSfxEJ09ev0/AyK87B61JTyjy5th087ygs0og9jduneGmc4yOxzyUrwNim
        vtVDigEUVgARQqcOg7FQ/RTTbMkFszxNB9lNYZHadrXPaLU5tdUk2FYt8K8vRzOMUWBB0z3KTOu63
        yl6BYIoA==;
Received: from [177.139.47.106] (helo=[192.168.15.109])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oC0L8-00GV8X-3S; Thu, 14 Jul 2022 17:01:18 +0200
Message-ID: <8bfd13a7-ed02-00dd-63a1-7144f2e55ef0@igalia.com>
Date:   Thu, 14 Jul 2022 12:00:59 -0300
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
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <74ba5239-27b0-299e-717c-595680cd52f9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

Thanks for the feedback.

Às 08:01 de 14/07/22, Andrey Semashev escreveu:
> On 7/14/22 06:18, André Almeida wrote:
[...]
>>
>> Feedback? Who else should I CC?
> 
> Just a few questions:
> 
> Do I understand correctly that notifiers won't be able to wake up
> waiters unless they know on which node they are waiting?
> 

If userspace is using NUMA_FLAG, yes. Otherwise all futexes would be
located in the default node, and userspace doesn't need to know which
one is the default.

> Is it possible to wait on a futex on different nodes?

Yes, given that you specify `.hint = id` with the proper node id.

> 
> Is it possible to wake waiters on a futex on all nodes? When a single
> (or N, where N is not "all") waiter is woken, which node is selected? Is
> there a rotation of nodes, so that nodes are not skewed in terms of
> notified waiters?

Regardless of which node the waiter process is running, what matter is
in which node the futex hash table is. So for instance if we have:

	struct futex32_numa f = {.value = 0, hint = 2};

And now we add some waiters for this futex:

Thread 1, running on node 3:

	futex_wait(&f, 0, FUTEX_NUMA | FUTEX_32, NULL);

Thread 2, running on node 0:

	futex_wait(&f, 0, FUTEX_NUMA | FUTEX_32, NULL);

Thread 3, running on node 2:

	futex_wait(&f, 0, FUTEX_NUMA | FUTEX_32, NULL);

And then, Thread 4, running on node 3:

	futex_wake(&f, 2, FUTEX_NUMA | FUTEX_32);

Now, two waiter would wake up (e.g. T1 and T3, node 3 and 2) and they
are from different nodes. futex_wake() doesn't provide guarantees of
which waiter will be selected, so I can't say which node would be
selected. There's no policy for fairness/starvation for futex_wake(). Do
you think this would be important for the NUMA case?

Let me know if this clarifies your questions.
