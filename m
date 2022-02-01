Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D5F4A65B6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 21:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbiBAUc7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Feb 2022 15:32:59 -0500
Received: from albireo.enyo.de ([37.24.231.21]:54248 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234508AbiBAUc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 15:32:57 -0500
Received: from [172.17.203.2] (port=56927 helo=deneb.enyo.de)
        by albireo.enyo.de ([172.17.140.2]) with esmtps (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        id 1nEzpc-00HFx1-5m; Tue, 01 Feb 2022 20:32:52 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.94.2)
        (envelope-from <fw@deneb.enyo.de>)
        id 1nEzpb-000PPY-Ti; Tue, 01 Feb 2022 21:32:51 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        David Laight <David.Laight@ACULAB.COM>,
        carlos <carlos@redhat.com>, Peter Oskolkov <posk@posk.io>
Subject: Re: [RFC PATCH 2/3] rseq: extend struct rseq with per thread group
 vcpu id
References: <20220201192540.10439-1-mathieu.desnoyers@efficios.com>
        <20220201192540.10439-2-mathieu.desnoyers@efficios.com>
        <87bkzqz75q.fsf@mid.deneb.enyo.de>
        <1075473571.25688.1643746930751.JavaMail.zimbra@efficios.com>
Date:   Tue, 01 Feb 2022 21:32:51 +0100
In-Reply-To: <1075473571.25688.1643746930751.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Tue, 1 Feb 2022 15:22:10 -0500
        (EST)")
Message-ID: <87sft2xr7w.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

> ----- On Feb 1, 2022, at 3:03 PM, Florian Weimer fw@deneb.enyo.de wrote:
>
>> * Mathieu Desnoyers:
>> 
>>> If a thread group has fewer threads than cores, or is limited to run on
>>> few cores concurrently through sched affinity or cgroup cpusets, the
>>> virtual cpu ids will be values close to 0, thus allowing efficient use
>>> of user-space memory for per-cpu data structures.
>> 
>> From a userspace programmer perspective, what's a good way to obtain a
>> reasonable upper bound for the possible tg_vcpu_id values?
>
> Some effective upper bounds:
>
> - sysconf(3) _SC_NPROCESSORS_CONF,
> - the number of threads which exist concurrently in the process,
> - the number of cpus in the cpu affinity mask applied by sched_setaffinity,
>   except in corner-case situations such as cpu hotplug removing all cpus from
>   the affinity set,
> - cgroup cpuset "partition" limits,

Affinity masks and _SC_NPROCESSORS_CONF can be off by more than an
order of magnitude compared to the cgroup cpuset, I think, and those
aren't even that atypical configurations.

The number of concurrent threads sounds more tractable, but I'm
worried about things creating threads behind libc's back (perhaps
io_uring?).  So it couldn't be a hard upper bound.

I'm worried about querying anything cgroup-related because these APIs
have a reputation for being slow, convoluted, and unstable
(effectively not subject to the “don't break userspace” rule).
Hopefully I'm wrong about that.

>> I believe not all users of cgroup cpusets change the affinity mask.
>
> AFAIR the sched affinity mask is tweaked independently of the cgroup cpuset.
> Those are two mechanisms both affecting the scheduler task placement.

There are container hosts out there that synthesize an affinity mask
that matches the CPU allocation, assuming that anyone who calls
sched_getaffinity only does so for counting the number of set bits.

> I would expect the user-space code to use some sensible upper bound as a
> hint about how many per-vcpu data structure elements to expect (and how many
> to pre-allocate), but have a "lazy initialization" fall-back in case the
> vcpu id goes up to the number of configured processors - 1. And I suspect
> that even the number of configured processors may change with CRIU.

Sounds reasonable.

>> Is the switch really useful?  I suspect it's faster to just write as
>> much as possible all the time.  The switch should be well-predictable
>> if running uniform userspace, but still …
>
> The switch ensures the kernel don't try to write to a memory area beyond
> the rseq size which has been registered by user-space. So it seems to be
> useful to ensure we don't corrupt user-space memory. Or am I missing your
> point ?

Due to the alignment, I think you'd only ever see 32 and 64 bytes for
now?

I'd appreciate if you could put the maximm supported size and possibly
the alignment in the auxiliary vector, so that we don't have to rseq
system calls in a loop on process startup.
