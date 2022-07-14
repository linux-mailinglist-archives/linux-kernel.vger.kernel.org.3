Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9715741CF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 05:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbiGNDTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 23:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbiGNDTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 23:19:32 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AAF240A6;
        Wed, 13 Jul 2022 20:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=hlVc3S338Hs1/PiwG/AKrI6AGgY3YdI9TqJMD9Bi1PE=; b=X+EIsxb/17qPVsjsj7DTQ1KetF
        oyWGhlb840NRd9rsQLLwQAdYvhzpN/K1TJ/w/6GtgvC+EQ/7rY1hMl574NvgC5gTn6Fc5kfCA2+2z
        eYyd2bL0cB9UvtEX8FZKm515zrK0gVspoy353swryS/WWZsV1pNs/Xq9dK4rwUYWKddMJ7pZLas/i
        rq7iuLekWhdzuSqVwgZkVs+TcC77nhFLMa7v10/15Eu+Uzb/JEky+NyU9ndCevCvPnq3uf7Csu6sz
        Yl9LNhfIZFTSnbcGgbO9Awpu6DvDU0sMcCshibs8vv9MA9EcNbWlFkb7OaRK0kChrGVZ6qyaNcjqu
        G3i3zhgw==;
Received: from [177.139.47.106] (helo=[192.168.15.109])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oBpNd-00Fohe-Gr; Thu, 14 Jul 2022 05:19:09 +0200
Message-ID: <36a8f60a-69b2-4586-434e-29820a64cd88@igalia.com>
Date:   Thu, 14 Jul 2022 00:18:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
Subject: [RFC] futex2: add NUMA awareness
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, fweimer@redhat.com,
        libc-alpha@sourceware.org,
        Andrey Semashev <andrey.semashev@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

futex2 is an ongoing project with the goal to create a new interface for
futex that solves ongoing issues with the current syscall.

One of this problems is the lack of NUMA awareness for futex operations.
This RFC is aimed to gather feedback around the a NUMA interface proposal.

 * The problem

futex has a single, global hash table to store information of current
waiters to be queried by wakers. This hash table is stored in a single
node in non-uniform machines. This means that a process running in other
nodes will have some overhead using futex, given that it will need to
access the table in a different node.

 * A solution

For NUMA machines, it would be allocated a table per node. Processes
then would be able to use the local table to avoid sharing data with
other nodes.

 * The interface

Userspace needs to specify which node would like to use to store/query
the futex table. The common case would be to operate on the current
node, but some cases could required to operate in another one.

Before getting to the NUMA part, a quick recap of the syscalls interface
of futex2:

futex_wait(void *uaddr, unsigned int val, unsigned int flags,
           struct timespec *timo)

futex_wake(void *uaddr, unsigned long nr_wake, unsigned int flags)

struct futex_requeue {
	void *uaddr;
	unsigned int flags;
};

futex_requeue(struct futex_requeue *rq1, struct futex_requeue *rq2,
	      unsigned int nr_wake, unsigned int nr_requeue,
	      u64 cmpval, unsigned int flags)


As requeue already has 6 arguments, we can't add an argument for the
node ID, we need to pack it in a struct. So then we have

struct futexX_numa {
        __uX value;
        __sX hint;
};

Where X can be 8, 16, 32 or 64 (futex2 supports variable sized futexes).
`value` is the futex value and `hint` can be -1 for the current node, or
[0, MAX_NUMA_NODES) to specify a node. Example:

struct futex32_numa f = {.value = 0, hint = -1};

...

futex_wait(&f, 0, FUTEX_NUMA | FUTEX_32, NULL);

Then &f would be used as the futex address, as expected, and this would
be used for the current node. If an app is expecting to have calls from
different nodes then it should do for instance:

struct futex32_numa f = {.value = 0, hint = 2};

For non-NUMA apps, a call without FUTEX_NUMA flag would just use the
first node as default.

Feedback? Who else should I CC?

Thanks,
	André
