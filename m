Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F70D48C669
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354244AbiALOrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:47:32 -0500
Received: from mail.efficios.com ([167.114.26.124]:58838 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239916AbiALOrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:47:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9A01E2563E2;
        Wed, 12 Jan 2022 09:47:30 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id rWaN6AbcvVWA; Wed, 12 Jan 2022 09:47:30 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2E065256521;
        Wed, 12 Jan 2022 09:47:30 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2E065256521
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1641998850;
        bh=BcnDtVFo4lej1Dp/uixgYGKV0F0M2FHui42BqigyqPA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=t3n+ikMe5EOtgTTOWx/7FpHB/4sDBZBhX80ljnF0WzVHKjxL0Jp54VcDXRpUMBLHb
         KJYwio9eY3XLcSj+15Crc3zuVGDW5MvnOkSXWPZoYVuAt0ZIDpAvITUfmWlBdpA+0B
         GRvF32v+4avJFvoiMHedC+o/79yUe5wi/TzArclpaxFJ/ooQcvIIA2WFOhVQs0rLgQ
         Avql3s7a8BFDxqaoRWWaIbFeFil1cNd5qjItJKd4HHK9bAd6ljQUa4C+QO/RLTYhtB
         bQMJhSBrefSNpNVb4VoqomtIAJPCbj1CkP+NBmO677gnPoS1Al0FPBYwqabwaRQome
         i5lndUViNnEtw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5f3vQPSP2xnF; Wed, 12 Jan 2022 09:47:30 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 1785D2563E1;
        Wed, 12 Jan 2022 09:47:30 -0500 (EST)
Date:   Wed, 12 Jan 2022 09:47:29 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        David Laight <David.Laight@ACULAB.COM>,
        carlos <carlos@redhat.com>
Message-ID: <1475639366.24565.1641998849957.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220112084617.32bjjo774n7vvyct@wittgenstein>
References: <20220110171611.8351-1-mathieu.desnoyers@efficios.com> <20220111110556.inteixgtl5vpmka7@wittgenstein> <1626924888.21447.1641922985771.JavaMail.zimbra@efficios.com> <20220112084617.32bjjo774n7vvyct@wittgenstein>
Subject: Re: [RFC PATCH v2 1/2] rseq: x86: implement abort-at-ip extension
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4177)
Thread-Topic: rseq: x86: implement abort-at-ip extension
Thread-Index: wXhmkkkMiFRXr8tNEYqfVGV2Lo6qQg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 12, 2022, at 3:46 AM, Christian Brauner christian.brauner@ubuntu.com wrote:

> On Tue, Jan 11, 2022 at 12:43:05PM -0500, Mathieu Desnoyers wrote:
[...]
>> >> + *
>> >> + * rseq critical sections defined with the RSEQ_CS_FLAG_ABORT_AT_IP flag
>> >> + * have the following behavior on abort: when the stack grows down: the
>> >> + * stack pointer is decremented to skip the redzone, and decremented of
>> >> + * the pointer size.  The aborted address (abort-at-ip) is stored at
>> >> + * this stack pointer location.  The user-space abort handler needs to
>> >> + * pop the abort-at-ip address from the stack, and add the redzone size
>> >> + * to the stack pointer.
>> >> + *
>> >> + * TODO: describe stack grows up.
>> > 
>> > Is this intentional or did you forget? :)
>> 
>> Since I did not implement abort-at-ip on stack-grows-up architectures, I felt
>> it would be too early to describe the algorithm. I can simply remove the TODO
>> altogether and we'll take care of it when we get there ? If I had to try to
>> wordsmith it, it would look like e.g.:
>> 
>>  *                                    [...] When the stack grows up: the
>>  * stack pointer is incremented to skip the redzone, and incremented of
>>  * the pointer size.  The aborted address (abort-at-ip) is stored immediately
>>  * under this stack pointer location.  The user-space abort handler needs to
>>  * pop the abort-at-ip address from the stack, and subtract the redzone size
>>  * from the stack pointer.
>> 
>> [ Please let me know if I got somehow confused in my understanding of stack
>> grows
>> up architectures. ]
>> 
>> I'm also unsure whether any of the stack grows up architecture have redzones ?
> 
> I don't think so? From when I last touched that piece of arch code when
> massaging copy_thread() I only remember parisc as having an upwards
> growing stack.
> 
>> From a quick grep for redzone in Linux arch/, only openrisc, powerpc64 and
> > x86-64 appear to have redzones.

I figured it was kind of silly to special-case arch-agnostic comments for stack
grows up/down, how about the following instead ?

 * rseq critical sections defined with the RSEQ_CS_FLAG_ABORT_AT_IP flag
 * have the following behavior on abort: the stack pointer is adjusted to
 * skip over the redzone [*], and the aborted address (abort-at-ip) is pushed
 * at this stack pointer location.  The user-space abort handler needs to pop
 * the abort-at-ip address from the stack, and adjust the stack pointer to skip
 * back over the redzone.
 *
 * [*] The openrisc, powerpc64 and x86-64 architectures define a "redzone" as a
 *     stack area beyond the stack pointer which can be used by the compiler
 *     to store local variables in leaf functions.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
