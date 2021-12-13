Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B44473560
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242604AbhLMT5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:57:05 -0500
Received: from mail.efficios.com ([167.114.26.124]:60324 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242614AbhLMT4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:56:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id AA6C031D36B;
        Mon, 13 Dec 2021 14:56:54 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id IMuzMolWCzAa; Mon, 13 Dec 2021 14:56:54 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5ED9C31D36A;
        Mon, 13 Dec 2021 14:56:54 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5ED9C31D36A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1639425414;
        bh=0WsXqAeaT7G+gn3g5kX7pvAiaX8+LtEOV9YE2p3nhS4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=EJKuywryqnEXCYiTn5azK3eyGpAaMCoIAnVz3GRao3Rm86NetxL6a9dzia4Sq90r3
         iefHL1nXevjyeb6XA3gNf6ENsOONrEZc57MCK5qpJms4nV+6BrqXJjFjUN/mCTMUIt
         6iiaiPQR3zRgxS18LIcyfqJfN9gTccnk2ozZws5fAGOvxq/iP/71sR2HI72TdomG6/
         J5DVfZwFwTWxHac0Y4+MsDwzgm1mG38XD1d288G8k4qvimaX2HMhh4yowtN49tGtc/
         uF4O636LuXC2nu4eu0XcBJJtyjx2dUAM3w+hUC7y1XTWU0JGKjeHBHw/M41LxdVq85
         CbEyNy5+JURLw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 861ojEOUOcXI; Mon, 13 Dec 2021 14:56:54 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 4C0BE31D627;
        Mon, 13 Dec 2021 14:56:54 -0500 (EST)
Date:   Mon, 13 Dec 2021 14:56:54 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-api <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>
Message-ID: <1424606270.30586.1639425414221.JavaMail.zimbra@efficios.com>
In-Reply-To: <87ilvstia9.fsf@oldenburg.str.redhat.com>
References: <87tufctk82.fsf@oldenburg.str.redhat.com> <697825714.30478.1639423180784.JavaMail.zimbra@efficios.com> <87ilvstia9.fsf@oldenburg.str.redhat.com>
Subject: Re: rseq + membarrier programming model
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4173 (ZimbraWebClient - FF94 (Linux)/8.8.15_GA_4177)
Thread-Topic: rseq + membarrier programming model
Thread-Index: nLdOx+5PjIXZKj0fT2igMxPWoDeoRA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Dec 13, 2021, at 2:29 PM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
> 
>>> Could it fall back to
>>> MEMBARRIER_CMD_GLOBAL instead?
>>
>> No. CMD_GLOBAL does not issue the required rseq fence used by the
>> algorithm discussed. Also, CMD_GLOBAL has quite a few other shortcomings:
>> it takes a while to execute, and is incompatible with nohz_full kernels.
> 
> What about using sched_setcpu to move the current thread to the same CPU
> (and move it back afterwards)?  Surely that implies the required sort of
> rseq barrier that MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ with
> MEMBARRIER_CMD_FLAG_CPU performs?

I guess you refer to using sched_setaffinity(2) there ? There are various
reasons why this may fail. For one, the affinity mask is a shared global
resource which can be changed by external applications. Also, setting
the affinity is really just a hint. In the presence of cpu hotplug and
or cgroup cpuset, it is known to lead to situations where the kernel
just gives up and provides an affinity mask including all CPUs.
Therefore, using sched_setaffinity() and expecting to be pinned to
a specific CPU for correctness purposes seems brittle.

But _if_ we'd have something like a sched_setaffinity which we can
trust, yes, temporarily migrating to the target CPU, and observing that
we indeed run there, would AFAIU provide the same guarantee as the rseq
fence provided by membarrier. It would have a higher overhead than
membarrier as well.

> 
> That is possible even without membarrier, so I wonder why registration
> of intent is needed for MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ.

I would answer that it is not possible to do this _reliably_ today
without membarrier (see above discussion of cpu hotplug, cgroups, and
modification of cpu affinity by external processes).

AFAIR, registration of intent for MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
is mainly there to provide a programming model similar to private expedited
plain and core-sync cmds.

The registration of intent allows the kernel to further tweak what is
done internally and make tradeoffs which only impact applications
performing the registration.

> 
>> In order to make sure the programming model is the same for expedited
>> private/global plain/sync-core/rseq membarrier commands, we require that
>> each process perform a registration beforehand.
> 
> Hmm.  At least it's not possible to unregister again.
> 
> But I think it would be really useful to have some of these barriers
> available without registration, possibly in a more expensive form.

What would be wrong with doing a membarrier private-expedited-rseq registration
on libc startup, and exposing a glibc tunable to allow disabling this ?

Thanks,

Mathieu


> 
> Thanks,
> Florian

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
