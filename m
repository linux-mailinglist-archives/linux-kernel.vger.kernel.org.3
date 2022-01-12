Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB3648CDBD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 22:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbiALVYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 16:24:17 -0500
Received: from mail.efficios.com ([167.114.26.124]:49484 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbiALVYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 16:24:13 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 535292A2381;
        Wed, 12 Jan 2022 16:24:11 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SM4v0cS9wioc; Wed, 12 Jan 2022 16:24:10 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BFC692A230B;
        Wed, 12 Jan 2022 16:24:10 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BFC692A230B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1642022650;
        bh=nNmEHbfn/2f0BLpXzhhRYHjAox2/MyoSvJLFh/QxHNs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=gfaSWHLyLJe8bGYQ3XPlX58cND96ZrwwwFTebc755HxuruC75BwNGS0ZcFHYS2GBZ
         0YK7Beqw7VTJXWg2QTAlE5FcbP6mIkyX3nUdSrr7lsTegJbuc3mZ41wROzAdW4ibfu
         iqqfjSV5sJCUuOADmgyQOlhbB9EqX/fRjVA5H4XoaxjVFgKoY7aZ/w2by2khGmBa8Q
         Zdp9tHyagI2qhGXrY50IFNAKvgnGouADFKIBPDpnH1HoGciFD+P2/1o4RunJRwMzK7
         dGIXRWdTHaXSSe15CnYn7pBWeYbuVdTxz98yfVoExPeltTLSnQmHWFllgc/awnwVGG
         DLbkFT5omZQwA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Zq7f5bDcJAyU; Wed, 12 Jan 2022 16:24:10 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id ABCBB2A2138;
        Wed, 12 Jan 2022 16:24:10 -0500 (EST)
Date:   Wed, 12 Jan 2022 16:24:10 -0500 (EST)
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
Message-ID: <22043919.26476.1642022650520.JavaMail.zimbra@efficios.com>
In-Reply-To: <87h7a87jpm.fsf@mid.deneb.enyo.de>
References: <20220107170302.8325-1-mathieu.desnoyers@efficios.com> <87a6g7ny0j.fsf@mid.deneb.enyo.de> <1968088162.13310.1641584935813.JavaMail.zimbra@efficios.com> <87y23l6l2j.fsf@mid.deneb.enyo.de> <Yd71+Da44h9Ge0+s@hirez.programming.kicks-ass.net> <87sftt6j0u.fsf@mid.deneb.enyo.de> <396330808.24806.1642005485899.JavaMail.zimbra@efficios.com> <87h7a87jpm.fsf@mid.deneb.enyo.de>
Subject: Re: [RFC PATCH] rseq: x86: implement abort-at-ip extension
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4177)
Thread-Topic: rseq: x86: implement abort-at-ip extension
Thread-Index: TyJ4biqxcQeKbxCn5uRQYxCVi1wgcg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 12, 2022, at 4:00 PM, Florian Weimer fw@deneb.enyo.de wrote:

> * Mathieu Desnoyers:
> 
>> ----- On Jan 12, 2022, at 11:00 AM, Florian Weimer fw@deneb.enyo.de wrote:
>>
>>> * Peter Zijlstra:
>>> 
>>>> On Wed, Jan 12, 2022 at 04:16:36PM +0100, Florian Weimer wrote:
>>>>
>>>>> You could perhaps push a signal frame onto the stack.  It's going to
>>>>> be expensive, but it's already in the context switch path, so maybe it
>>>>> does not matter.
>>>>
>>>> Please no! Signals are a trainwreck that need change (see the whole
>>>> AVX-512 / AMX saga), we shouldn't use more of that just cause.
>>> 
>>> If it's a signal, it should be modeled as such.  I think it's pretty
>>> close to a synchronous signal.
> 
> (an asynchronous signal)
> 
>> Florian, just to validate here: is your argument about AVX-512/AMX or about
>> rseq abort-at-ip ?
> 
> rseq abort-at-ip.  I wonder if it is possible to use regular stack
> unwinding (through the signal frame) to figure out where the abort
> happened, and use the existing cleanup handler functionality in GCC.
> (Although -fnon-call-exceptions is not quite up to this, but in theory
> we would have to fix this for POSIX asynchronous cancellation/Ada
> asynchronous transfer of control support anyway.)

OK, so if we take x86-64 as an example, the abort would do:

/* Skip redzone and sigframe */
regs->sp -= 128 + sizeof(struct rt_sigframe);

It's unclear to me what should be the size of rt_sigframe here. Should it
include floating point state as well ?

Then at regs->sp, we can store a signal frame. The interesting bits would
go into (struct rt_sigframe  __user *)->uc which is a struct sigcontext.
It would contain all register state at the point where the critical section
was aborted.

The only register state we really care about is sigcontext "rip", given that
the userspace abort handler can save all other relevant registers by itself.

Then should we populate the other struct rt_sigframe fields or just zero them ?
I wonder what the meaning of "pretcode" and "struct siginfo" would be in the
context of an rseq abort ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
