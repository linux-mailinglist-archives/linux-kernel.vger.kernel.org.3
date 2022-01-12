Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0ED48C731
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 16:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354626AbiALP0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 10:26:35 -0500
Received: from mail.efficios.com ([167.114.26.124]:44074 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354546AbiALP0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:26:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BD59C256B27;
        Wed, 12 Jan 2022 10:26:32 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ywqNQ_Y1SLBR; Wed, 12 Jan 2022 10:26:32 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3DF70256B26;
        Wed, 12 Jan 2022 10:26:32 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3DF70256B26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1642001192;
        bh=rGGJGHjEQWCw2EbTCdbcCnpbFwo6zy6FqMyQlybEF2A=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=kzwC2oqhbik0JW5pBB8AB53Mkg+AUU0bPq9gKzWLHyHpORdbhR+ZGRxPycDzMfuIY
         +4O6gLG83Ep9n0ymoIdj2L9HYgJ/29Hi+MWS9LrFlDa3FG6MJstjygnmw9YVs2snly
         EsQtkZo3o8v8xE5JGs9YU1vTJzghhfRPjYrMJYi5b+G5fFF85CleuPNEQ0jsd4VfoJ
         gN2onxBvuFwqdNlMYjYjhCbdRyNTehZFxGvZwVNVXI8rTmA8qO9bjiOG1sU3FZQOkK
         LT5WQTqc5JqnrdoJSodNIg1ifkX0Ijim7eppqA6nexs/lEVPaK/sVpRWHND+nWULjl
         +Ggkyw4/XU+ZQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8ZuMFzoGb8TO; Wed, 12 Jan 2022 10:26:32 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 2BC48256ADF;
        Wed, 12 Jan 2022 10:26:32 -0500 (EST)
Date:   Wed, 12 Jan 2022 10:26:32 -0500 (EST)
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
Message-ID: <688677480.24662.1642001192132.JavaMail.zimbra@efficios.com>
In-Reply-To: <87y23l6l2j.fsf@mid.deneb.enyo.de>
References: <20220107170302.8325-1-mathieu.desnoyers@efficios.com> <87a6g7ny0j.fsf@mid.deneb.enyo.de> <1968088162.13310.1641584935813.JavaMail.zimbra@efficios.com> <87y23l6l2j.fsf@mid.deneb.enyo.de>
Subject: Re: [RFC PATCH] rseq: x86: implement abort-at-ip extension
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4177)
Thread-Topic: rseq: x86: implement abort-at-ip extension
Thread-Index: ikLHFitF/BUFuQSDCDNnlnEWeAUhFQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 12, 2022, at 10:16 AM, Florian Weimer fw@deneb.enyo.de wrote:

> * Mathieu Desnoyers:
> 
>> ----- On Jan 7, 2022, at 2:31 PM, Florian Weimer fw@deneb.enyo.de wrote:
>>
>>> * Mathieu Desnoyers:
>>> 
>>>> Allow rseq critical section abort handlers to optionally figure out at
>>>> which instruction pointer the rseq critical section was aborted.
>>>>
>>>> This allows implementing rseq critical sections containing loops, in
>>>> which case the commit side-effect cannot be the last instruction. This
>>>> is useful to implement adaptative mutexes aware of preemption in
>>>> user-space. (see [1])
>>> 
>>> Could you write the program counter to the rseq area instead?  This
>>> would avoid discussing which register to clobber.
>>
>> Using the rseq area for that purpose would be problematic for nested signal
>> handlers with rseq critical sections. If a signal happens to be delivered
>> right after the abort ip adjustment, its signal handler containing a rseq
>> critical section could overwrite the relevant "abort-at-ip" field in the
>> rseq per-thread area before it has been read by the abort handler interrupted
>> by the signal.
>>
>> Making this architecture-agnostic is indeed a laudable goal, but I don't
>> think the rseq per-thread area is a good fit for this.
>>
>> I also though about making the clobbered register configurable on a
>> per-critical-section basis, but I rather think that it would be
>> overengineered: too much complexity for the gain. Unless there are
>> very strong reasons for choosing one register over another on a per
>> use-case basis ?
> 
> You could perhaps push a signal frame onto the stack.  It's going to
> be expensive, but it's already in the context switch path, so maybe it
> does not matter.

The route I'm taking in my subsequent version of the patch is very close to
pushing a signal frame: on abort, skip the redzone, and push the abort-at-ip
pointer. Then abort handler is then expected to pop the abort-at-ip pointer
and unskip the redzone.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
