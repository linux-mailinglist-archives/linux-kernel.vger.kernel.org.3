Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E24574B5E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238566AbiGNLBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237030AbiGNLBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:01:08 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77055564EF;
        Thu, 14 Jul 2022 04:01:07 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id w2so1721646ljj.7;
        Thu, 14 Jul 2022 04:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bRaGXzVsvXrp9o5BPxAa6QcDd4JsOvIWMxX4WmnVZY4=;
        b=U7kw7ZYsgQjQ8Dj5Ii7ZALQ4i0Ay6GsdAT3jLgvD0oXeJzMIIgwqmDug0QeoD5EMhC
         lkUaRsQjGoq6Hb2+NQilhFrQRSp6AxR4WJnH4FrNrHi8j2/XiE4YwoQSaOIsPtQmgB+L
         QW7/VNyjHxGKzYXXnX15Knfgl+dP2xyvKCXPAms2BA/XHGVkhEGuG2xHK4ZEavFl0OKO
         DdyvT8Txo2pITpMnqqUhf1taDfAt/Z+XVOslk35y4tWkG4hZyGR1rUG5uIZhiIsCN7tE
         h5/axgSTLvEYBe1WlWCNwtStaVTZ+I9A1/ZndvQY/WEAjHFqpVhUfu/bR/gnwhOddpP8
         v0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bRaGXzVsvXrp9o5BPxAa6QcDd4JsOvIWMxX4WmnVZY4=;
        b=4jyYpPd3FOaBUs2bN0FJD0TSNQYQAOG3QvEWCLUL+Baq2WE7XAThTZsTEXOZ/ptjno
         xKS8iDC3/JF9oOSbIEHZ/6mVlUMTqaMlKryxOx/Kd4OZkv+xGFxhOZLY1+nu2Zu2FTpt
         06vMjw302MimkiSsny7MVrRoAjq3WllnKAHgSvNokfg3XmNuavVSGXw/mCCsF+VWcrh6
         ipZk/rbLPZkfshBwz44w1vDqQLmPpk51bVojl33vWFipGlHlMvm9WGDc75hnTW6W9YmO
         C2dog36vyZ4/LrW7k8NqE1lTqxju8wMeMyl28ppSCaJKY6whPAOPkXqLOvpeTwAhvioO
         yT7Q==
X-Gm-Message-State: AJIora9X9IfIRBVova4X3DhppRpzskQld4Wc5Zh6bMEV5OZmeis12pa4
        L3CFrF+0WZpSylu34QLXBxc=
X-Google-Smtp-Source: AGRyM1uSKOlQOCjmCNWVBaZdNHAasytESWuj89vkdO3z3UYcRr2rkd5t7vGNvPhyQBxNsucZD+dRSw==
X-Received: by 2002:a2e:98da:0:b0:25d:91a7:22eb with SMTP id s26-20020a2e98da000000b0025d91a722ebmr3037580ljj.46.1657796465704;
        Thu, 14 Jul 2022 04:01:05 -0700 (PDT)
Received: from [192.168.1.2] (broadband-188-32-106-30.ip.moscow.rt.ru. [188.32.106.30])
        by smtp.gmail.com with ESMTPSA id e2-20020a2e9842000000b00258fd1ba2e7sm224521ljj.84.2022.07.14.04.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 04:01:05 -0700 (PDT)
Message-ID: <74ba5239-27b0-299e-717c-595680cd52f9@gmail.com>
Date:   Thu, 14 Jul 2022 14:01:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC] futex2: add NUMA awareness
Content-Language: en-US
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, fweimer@redhat.com,
        libc-alpha@sourceware.org, Davidlohr Bueso <dave@stgolabs.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <36a8f60a-69b2-4586-434e-29820a64cd88@igalia.com>
From:   Andrey Semashev <andrey.semashev@gmail.com>
In-Reply-To: <36a8f60a-69b2-4586-434e-29820a64cd88@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/22 06:18, André Almeida wrote:
> Hi,
> 
> futex2 is an ongoing project with the goal to create a new interface for
> futex that solves ongoing issues with the current syscall.
> 
> One of this problems is the lack of NUMA awareness for futex operations.
> This RFC is aimed to gather feedback around the a NUMA interface proposal.
> 
>  * The problem
> 
> futex has a single, global hash table to store information of current
> waiters to be queried by wakers. This hash table is stored in a single
> node in non-uniform machines. This means that a process running in other
> nodes will have some overhead using futex, given that it will need to
> access the table in a different node.
> 
>  * A solution
> 
> For NUMA machines, it would be allocated a table per node. Processes
> then would be able to use the local table to avoid sharing data with
> other nodes.
> 
>  * The interface
> 
> Userspace needs to specify which node would like to use to store/query
> the futex table. The common case would be to operate on the current
> node, but some cases could required to operate in another one.
> 
> Before getting to the NUMA part, a quick recap of the syscalls interface
> of futex2:
> 
> futex_wait(void *uaddr, unsigned int val, unsigned int flags,
>            struct timespec *timo)
> 
> futex_wake(void *uaddr, unsigned long nr_wake, unsigned int flags)
> 
> struct futex_requeue {
> 	void *uaddr;
> 	unsigned int flags;
> };
> 
> futex_requeue(struct futex_requeue *rq1, struct futex_requeue *rq2,
> 	      unsigned int nr_wake, unsigned int nr_requeue,
> 	      u64 cmpval, unsigned int flags)
> 
> 
> As requeue already has 6 arguments, we can't add an argument for the
> node ID, we need to pack it in a struct. So then we have
> 
> struct futexX_numa {
>         __uX value;
>         __sX hint;
> };
> 
> Where X can be 8, 16, 32 or 64 (futex2 supports variable sized futexes).
> `value` is the futex value and `hint` can be -1 for the current node, or
> [0, MAX_NUMA_NODES) to specify a node. Example:
> 
> struct futex32_numa f = {.value = 0, hint = -1};
> 
> ...
> 
> futex_wait(&f, 0, FUTEX_NUMA | FUTEX_32, NULL);
> 
> Then &f would be used as the futex address, as expected, and this would
> be used for the current node. If an app is expecting to have calls from
> different nodes then it should do for instance:
> 
> struct futex32_numa f = {.value = 0, hint = 2};
> 
> For non-NUMA apps, a call without FUTEX_NUMA flag would just use the
> first node as default.
> 
> Feedback? Who else should I CC?

Just a few questions:

Do I understand correctly that notifiers won't be able to wake up
waiters unless they know on which node they are waiting?

Is it possible to wait on a futex on different nodes?

Is it possible to wake waiters on a futex on all nodes? When a single
(or N, where N is not "all") waiter is woken, which node is selected? Is
there a rotation of nodes, so that nodes are not skewed in terms of
notified waiters?
