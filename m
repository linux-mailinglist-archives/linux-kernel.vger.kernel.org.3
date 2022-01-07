Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81841487D4B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 20:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbiAGTs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 14:48:58 -0500
Received: from mail.efficios.com ([167.114.26.124]:59294 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbiAGTs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 14:48:57 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9D4E137B045;
        Fri,  7 Jan 2022 14:48:56 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id fTpqQIXgoNXS; Fri,  7 Jan 2022 14:48:56 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id F30DD37B238;
        Fri,  7 Jan 2022 14:48:55 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com F30DD37B238
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1641584936;
        bh=xOfL8rk+p6YmScj8ALAnNOj0+ktpI7b9BaqArZcDaGA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=IOURN8aaErWwGrynI7nb0kcv2+eedLHGh9/etEIrkNYETwrSrY8FIhiG33Mz6pE/x
         0n3fjYEIM1G2E2XmAZLevm/Vt5Yttx0iur3dHSydQvJgpStCwVmv8ksuTpHEKWZbjj
         wUyFjUxsAVeL5nAL87+JL1vjfF/AoGowiDJhjOp6rY/V1zDhx2C2zK/y6EXnd1yQXi
         AQ/lYElDu8NLfIB6sseyz6IXR4zp9NGAcH3gZNSNyxGMTah9z3cQJhD2dF010IZYq+
         AVZqpWP4MGE984y6HnOLC+GVJFNwLDsPTCa3MwOAAv1ALksRpcZbP6ovivYWJiaMOQ
         ULGYo8WPzzaAA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IE8Nooonnfh9; Fri,  7 Jan 2022 14:48:55 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id E20A437B042;
        Fri,  7 Jan 2022 14:48:55 -0500 (EST)
Date:   Fri, 7 Jan 2022 14:48:55 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        carlos <carlos@redhat.com>
Message-ID: <1968088162.13310.1641584935813.JavaMail.zimbra@efficios.com>
In-Reply-To: <87a6g7ny0j.fsf@mid.deneb.enyo.de>
References: <20220107170302.8325-1-mathieu.desnoyers@efficios.com> <87a6g7ny0j.fsf@mid.deneb.enyo.de>
Subject: Re: [RFC PATCH] rseq: x86: implement abort-at-ip extension
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF95 (Linux)/8.8.15_GA_4177)
Thread-Topic: rseq: x86: implement abort-at-ip extension
Thread-Index: 3gt3DeiK7OZf0kNeFIUwJ9FIkzAsPQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 7, 2022, at 2:31 PM, Florian Weimer fw@deneb.enyo.de wrote:

> * Mathieu Desnoyers:
> 
>> Allow rseq critical section abort handlers to optionally figure out at
>> which instruction pointer the rseq critical section was aborted.
>>
>> This allows implementing rseq critical sections containing loops, in
>> which case the commit side-effect cannot be the last instruction. This
>> is useful to implement adaptative mutexes aware of preemption in
>> user-space. (see [1])
> 
> Could you write the program counter to the rseq area instead?  This
> would avoid discussing which register to clobber.

Using the rseq area for that purpose would be problematic for nested signal
handlers with rseq critical sections. If a signal happens to be delivered
right after the abort ip adjustment, its signal handler containing a rseq
critical section could overwrite the relevant "abort-at-ip" field in the
rseq per-thread area before it has been read by the abort handler interrupted
by the signal.

Making this architecture-agnostic is indeed a laudable goal, but I don't
think the rseq per-thread area is a good fit for this.

I also though about making the clobbered register configurable on a
per-critical-section basis, but I rather think that it would be
overengineered: too much complexity for the gain. Unless there are
very strong reasons for choosing one register over another on a per
use-case basis ?

I guess if we ever care about the state of a given register within a given
range of instructions, we may lose that information if it is overwritten
by the abort-at-ip value. For instance, in my adaptative mutex prototype,
I use the Zero Flag to check if cmpxchg has succeeded. But if I would have
wanted to use the register modified by cmpxchg, and it would happen to be
clobbered by the abort-at-ip on abort, then it limits what the abort handler
can observe. It's fine as long as instructions can select what registers they
operate on, but instructions like cmpxchg AFAIR work on specific registers,
which might warrant making the abort-at-ip register configurable per
critical section. But maybe just choosing a register for abort-at-ip which
is not typically used by instructions that rely on hardcoded registers might
be sufficient.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
