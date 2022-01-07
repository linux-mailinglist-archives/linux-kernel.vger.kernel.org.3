Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5315487E42
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 22:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiAGV1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 16:27:49 -0500
Received: from mail.efficios.com ([167.114.26.124]:34252 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiAGV1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 16:27:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BD2EF37BD41;
        Fri,  7 Jan 2022 16:27:47 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id P420h2c_cXgU; Fri,  7 Jan 2022 16:27:47 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 39E0C37BB66;
        Fri,  7 Jan 2022 16:27:47 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 39E0C37BB66
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1641590867;
        bh=wfuaRpCRpCY8Tb4bfdjUHAUsYLMAX74Njj1pgAYmeo8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Nmq3CLL2jM9SJv9IH9Y/vERTJdgIsEwbiTazLqpKWqLkANv4331AJVHFBzXUjrR4P
         t1OjzL8gZbnseZaGF2FcYXeifcBotv+Ji/sMi9peElzoqGcRniPijX+J5XDEnhg8hP
         SPG9lPnMUk7FoK1TpPWWCJ0JhXYm3DCq/HzrYIGp+g5cWT6ueKmCSDWHoHZmCHSFLy
         48ezOrKSbMgoiVbS9RSsqVVDa8ae/BQHu0ZbomX4sz9+S9Jm04lE7h4JrR03v67+Bi
         Lo8e5K7XvARYIAfEwG7uE17LW8BuogqH6u8tn5P7KXnj+jDUSgPTBZxA7nGxg8mOsc
         NBUTZ0DnLIOTA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Z5vwNaqddgDm; Fri,  7 Jan 2022 16:27:47 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 27EEC37BCE0;
        Fri,  7 Jan 2022 16:27:47 -0500 (EST)
Date:   Fri, 7 Jan 2022 16:27:47 -0500 (EST)
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
Message-ID: <1300078200.13848.1641590867024.JavaMail.zimbra@efficios.com>
In-Reply-To: <1968088162.13310.1641584935813.JavaMail.zimbra@efficios.com>
References: <20220107170302.8325-1-mathieu.desnoyers@efficios.com> <87a6g7ny0j.fsf@mid.deneb.enyo.de> <1968088162.13310.1641584935813.JavaMail.zimbra@efficios.com>
Subject: Re: [RFC PATCH] rseq: x86: implement abort-at-ip extension
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF95 (Linux)/8.8.15_GA_4177)
Thread-Topic: rseq: x86: implement abort-at-ip extension
Thread-Index: 3gt3DeiK7OZf0kNeFIUwJ9FIkzAsPQxQ8i2E
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 7, 2022, at 2:48 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Jan 7, 2022, at 2:31 PM, Florian Weimer fw@deneb.enyo.de wrote:
> 
>> * Mathieu Desnoyers:
>> 
>>> Allow rseq critical section abort handlers to optionally figure out at
>>> which instruction pointer the rseq critical section was aborted.
>>>
>>> This allows implementing rseq critical sections containing loops, in
>>> which case the commit side-effect cannot be the last instruction. This
>>> is useful to implement adaptative mutexes aware of preemption in
>>> user-space. (see [1])
>> 
>> Could you write the program counter to the rseq area instead?  This
>> would avoid discussing which register to clobber.
> 
> Using the rseq area for that purpose would be problematic for nested signal
> handlers with rseq critical sections. If a signal happens to be delivered
> right after the abort ip adjustment, its signal handler containing a rseq
> critical section could overwrite the relevant "abort-at-ip" field in the
> rseq per-thread area before it has been read by the abort handler interrupted
> by the signal.
> 
> Making this architecture-agnostic is indeed a laudable goal, but I don't
> think the rseq per-thread area is a good fit for this.
> 
> I also though about making the clobbered register configurable on a
> per-critical-section basis, but I rather think that it would be
> overengineered: too much complexity for the gain. Unless there are
> very strong reasons for choosing one register over another on a per
> use-case basis ?
> 
> I guess if we ever care about the state of a given register within a given
> range of instructions, we may lose that information if it is overwritten
> by the abort-at-ip value. For instance, in my adaptative mutex prototype,
> I use the Zero Flag to check if cmpxchg has succeeded. But if I would have
> wanted to use the register modified by cmpxchg, and it would happen to be
> clobbered by the abort-at-ip on abort, then it limits what the abort handler
> can observe. It's fine as long as instructions can select what registers they
> operate on, but instructions like cmpxchg AFAIR work on specific registers,
> which might warrant making the abort-at-ip register configurable per
> critical section. But maybe just choosing a register for abort-at-ip which
> is not typically used by instructions that rely on hardcoded registers might
> be sufficient.
> 
> Thoughts ?

That being said, there might be an architecture agnostic alternative available.
On abort of a RSEQ_CS_FLAG_ABORT_AT_IP critical section, we could let the kernel
decrement/increment the stack pointer to make room for a pointer (depending if the
stack grows down or up). It would then store the abort-at-ip value at the top of
stack.

The abort handler would be expected to use this top of stack abort-at-ip value,
and would be required to increment/decrement (depending on the stack direction)
the stack pointer back to its rightful value before the end of the assembly block.

Thoughts ?

Thanks,

Mathieu

> 
> Thanks,
> 
> Mathieu
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
