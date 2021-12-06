Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D4246A4EF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347593AbhLFS4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:56:04 -0500
Received: from mail.efficios.com ([167.114.26.124]:46230 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347579AbhLFS4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:56:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C6E8838C720;
        Mon,  6 Dec 2021 13:52:33 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id OQ0tPzPYJ2w6; Mon,  6 Dec 2021 13:52:33 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2219B38C642;
        Mon,  6 Dec 2021 13:52:33 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2219B38C642
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1638816753;
        bh=xXF4bUstm3HBUcQ+ZBSSuG91QvQbgtEGQvkNdowKo9s=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=cLRjmVaAChXYWszcxKowzAG5huHtOAYTdFEKo0fUZRmRPI6DPlYjfIaBiMYGBFMaW
         a+9/UO5+S5OVkyAaa/DI8NSMHXcMzx9hvAsR3tehChUa1rCPlMiSqJiyzliziDdFvx
         Ar9MNR8PK0qriceDTL43lD8uarBE4cxJQDNgiXKs08DuJNCp4fcVobSCwjUG3p1/Du
         k5EHLMuvR8MMZXFMRreKepq0QefE6LY2mMpkVxonj/7PCYXGbvDxzq4ayq2ryDFVwZ
         N0fv86VxJTXnl65CucXRzQ7ZCsaQevVzAfnUynC7B/5qt5nuyaZRkPUO9mAl6TAWLE
         pOfoaN3MBuefQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5yxAwpGLvtvR; Mon,  6 Dec 2021 13:52:33 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 139B338C2FC;
        Mon,  6 Dec 2021 13:52:33 -0500 (EST)
Date:   Mon, 6 Dec 2021 13:52:33 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>, paulmck <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1614144911.15213.1638816753026.JavaMail.zimbra@efficios.com>
In-Reply-To: <871r2podt9.fsf@oldenburg.str.redhat.com>
References: <cover.1638798186.git.fweimer@redhat.com> <9c58724d604e160ebda5f667331fa41416c0d12b.1638798186.git.fweimer@redhat.com> <1780152866.15126.1638809966443.JavaMail.zimbra@efficios.com> <871r2podt9.fsf@oldenburg.str.redhat.com>
Subject: Re: [PATCH 2/5] nptl: Add rseq registration
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4173 (ZimbraWebClient - FF94 (Linux)/8.8.15_GA_4177)
Thread-Topic: nptl: Add rseq registration
Thread-Index: 9IjY+JUUfOpDSXj8/pfTcfUohvCcbQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Adding other kernel rseq maintainers in CC. ]

----- On Dec 6, 2021, at 12:14 PM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
> 
>> ----- On Dec 6, 2021, at 8:46 AM, Florian Weimer fweimer@redhat.com wrote:
>> [...]
>>> @@ -406,6 +407,9 @@ struct pthread
>>>   /* Used on strsignal.  */
>>>   struct tls_internal_t tls_state;
>>> 
>>> +  /* rseq area registered with the kernel.  */
>>> +  struct rseq rseq_area;
>>
>> The rseq UAPI requires that the fields within the rseq_area
>> are read-written with single-copy atomicity semantics.
>>
>> So either we define a "volatile struct rseq" here, or we'll need
>> to wrap all accesses with the proper volatile casts, or use the
>> relaxed_mo atomic accesses.
> 
> Under the C memory model, neither volatile nor relaxed MO result in
> single-copy atomicity semantics.  So I'm not sure what to make of this.
> Surely switching to inline assembly on all targets is over the top.
> 
> I think we can rely on a plain read doing the right thing for us.

AFAIU, the plain read does not prevent the compiler from re-loading the
value in case of high register pressure.

Accesses to rseq fields such as cpu_id need to be done as if those were
concurrently modified by a signal handler nesting on top of the user-space
code, with the particular twist that blocking signals has no effect on
concurrent updates.

I do not think we need to do the load in assembly. I was under the impression
that both volatile load and relaxed MO result in single-copy atomicity
semantics for an aligned pointer. Perhaps Paul, Peter, Boqun have something
to add here ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
