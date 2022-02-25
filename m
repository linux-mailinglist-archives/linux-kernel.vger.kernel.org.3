Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FE74C4D05
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiBYR4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiBYR4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:56:38 -0500
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08262399F7;
        Fri, 25 Feb 2022 09:56:04 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 05BFA3E558B;
        Fri, 25 Feb 2022 12:56:03 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 05FD2Mwp0P8V; Fri, 25 Feb 2022 12:56:02 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 90BBC3E534A;
        Fri, 25 Feb 2022 12:56:02 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 90BBC3E534A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1645811762;
        bh=UZBF1MX+MsRdrx0sRIjt/JRrGJyA18uNtUUTbZ/w8N0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=VBKkUBKpJ2zqL2ReHJHf+2UG5vnUROG9YalzHEMIGg6uuZIPNgYHi6PYdE2Y3EVkb
         xtPMdJgx2NCMBPaoN7QbLhm/b1989kRh9nQxDs6rpkZfV9qE9TtrVcDrVjAGbitqlL
         v/VEUKaXRyQha3Zun3T2kjrqJ6ipLbAK8+gd15bdv6bInODwbhvNV/NimyZVS6tkZy
         L7zIYrlNGbW5TEiltdr48UByW24s/P0RqTxs282CXww6c/YuHQVEunj7fw+UZVE+1M
         kVojxsxJbbsT7TiOBbjz5pWYyqAZyyttYbsENlJnvnHNFlO9rV/Z/G1yurXvJbj0Lb
         5Jgm1dVmqi+cg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8uQIs6konwCS; Fri, 25 Feb 2022 12:56:02 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 7B2E83E558A;
        Fri, 25 Feb 2022 12:56:02 -0500 (EST)
Date:   Fri, 25 Feb 2022 12:56:02 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        David Laight <David.Laight@ACULAB.COM>,
        carlos <carlos@redhat.com>, Peter Oskolkov <posk@posk.io>
Message-ID: <1323451367.108396.1645811762372.JavaMail.zimbra@efficios.com>
In-Reply-To: <87k0dikfxa.fsf@meer.lwn.net>
References: <20220218210633.23345-1-mathieu.desnoyers@efficios.com> <20220218210633.23345-10-mathieu.desnoyers@efficios.com> <87k0dikfxa.fsf@meer.lwn.net>
Subject: Re: [RFC PATCH v2 09/11] sched: Introduce per memory space current
 virtual cpu id
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF97 (Linux)/8.8.15_GA_4232)
Thread-Topic: sched: Introduce per memory space current virtual cpu id
Thread-Index: lCW3kQh5ZH1hwRJzi/Qgd8U7jX6j3g==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 25, 2022, at 12:35 PM, Jonathan Corbet corbet@lwn.net wrote:

> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:
> 
>> This feature allows the scheduler to expose a current virtual cpu id
>> to user-space. This virtual cpu id is within the possible cpus range,
>> and is temporarily (and uniquely) assigned while threads are actively
>> running within a memory space. If a memory space has fewer threads than
>> cores, or is limited to run on few cores concurrently through sched
>> affinity or cgroup cpusets, the virtual cpu ids will be values close
>> to 0, thus allowing efficient use of user-space memory for per-cpu
>> data structures.
> 
> So I have one possibly (probably) dumb question: if I'm writing a
> program to make use of virtual CPU IDs, how do I know what the maximum
> ID will be?  It seems like one of the advantages of this mechanism would
> be not having to be prepared for anything in the physical ID space, but
> is there any guarantee that the virtual-ID space will be smaller?
> Something like "no larger than the number of threads", say?

Hi Jonathan,

This is a very relevant question. Let me quote what I answered to Florian
on the last round of review for this series:

Some effective upper bounds for the number of vcpu ids observable in a process:

- sysconf(3) _SC_NPROCESSORS_CONF,
- the number of threads which exist concurrently in the process,
- the number of cpus in the cpu affinity mask applied by sched_setaffinity,
  except in corner-case situations such as cpu hotplug removing all cpus from
  the affinity set,
- cgroup cpuset "partition" limits,

Note that AFAIR non-partition cgroup cpusets allow a cgroup to "borrow"
additional cores from the rest of the system if they are idle, therefore
allowing the number of concurrent threads to go beyond the specified limit.

AFAIR the sched affinity mask is tweaked independently of the cgroup cpuset.
Those are two mechanisms both affecting the scheduler task placement.

I would expect the user-space code to use some sensible upper bound as a
hint about how many per-vcpu data structure elements to expect (and how many
to pre-allocate), but have a "lazy initialization" fall-back in case the
vcpu id goes up to the number of configured processors - 1. And I suspect
that even the number of configured processors may change with CRIU.

If the above explanation makes sense (please let me know if I am wrong
or missed something), I suspect I should add it to the commit message.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
