Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47534A65C8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 21:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239365AbiBAUgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 15:36:50 -0500
Received: from mail.efficios.com ([167.114.26.124]:49074 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiBAUgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 15:36:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 343D6348722;
        Tue,  1 Feb 2022 15:36:49 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Dd51x-zVMZyC; Tue,  1 Feb 2022 15:36:48 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BA11B348721;
        Tue,  1 Feb 2022 15:36:48 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BA11B348721
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643747808;
        bh=9iBSk44Ww+muw9nnfZnzpoja3Pj6yjk4ZeskuFm7F7Q=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=A87I8jVYpF2TdPAX7fzuTrU30Q0rn7bneNleKyftKIJIxgDEt1AV02AuQJmgokz8g
         v9rsOePjQwqOAsfQ5Fwjq+PbqT0+d/cjs+Vukp1dH6KQCZcOPE64hn1PqY8WE8dRZw
         ZuCzpDXyD27Ke5UjRqFa20qVjUH9NSUsaSV7oD/vWMWliwWZNl63ceLG5/YzOC7jtU
         V91+t8UygBl23w1QjkHoa3B+LACG8d+5jrVqoMddm+AcdGL6QifitKcLp1Zk+CZ6/B
         /h0YpLOHIlcMwm+ieieXoHt6Ac8mGeiSVmDsFMAotsg5tT03qDEBo+6OgqkFS8nn3l
         s00h/VP7XZAVg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id j3uo8KmGS4Pz; Tue,  1 Feb 2022 15:36:48 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id A67A9348695;
        Tue,  1 Feb 2022 15:36:48 -0500 (EST)
Date:   Tue, 1 Feb 2022 15:36:48 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        David Laight <David.Laight@aculab.com>,
        carlos <carlos@redhat.com>
Message-ID: <1606681746.25743.1643747808563.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAFTs51XUwhPJ9BzygJPD0pWFEEwu6hSnO7r=-i8B8R6x0oK6CA@mail.gmail.com>
References: <20220201143425.19907-1-mathieu.desnoyers@efficios.com> <CAFTs51XUwhPJ9BzygJPD0pWFEEwu6hSnO7r=-i8B8R6x0oK6CA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] rseq: extend struct rseq with numa node id
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4203)
Thread-Topic: rseq: extend struct rseq with numa node id
Thread-Index: qnHsMEmyHzPgx8IXv5sGUbO6RLx+vg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 1, 2022, at 2:28 PM, Peter Oskolkov posk@posk.io wrote:

Hi Peter,

[...]

>>  TRACE_EVENT(rseq_ip_fixup,
>> diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
>> index 77ee207623a9..386c25b5bbdb 100644
>> --- a/include/uapi/linux/rseq.h
>> +++ b/include/uapi/linux/rseq.h
>> @@ -130,6 +130,30 @@ struct rseq {
>>          *     this thread.
>>          */
>>         __u32 flags;
>> +
>> +       __u32 padding1[3];
> 
> I don't fully understand why this padding is needed here. The comment
> below sounds like there was something in "the original rseq API", but
> was later removed, as this patch clearly adds padding after flags, but
> even the first rseq patch had 'flags' as the last field in struct
> rseq...

The struct rseq has an explicit alignment attribute of 32 bytes, which means
that even though we populate 20 bytes up to (including) the flags field, there is
implicitly 12 bytes or padding at the end of that structure. The size of the rseq_len
argument expected by the rseq system call since 4.18 is sizeof(struct rseq), which is
32 bytes (including the implicit padding).

So if we want to use the structure size as a way to indicate available features,
we need to explicitly express the padding field (12 bytes), and start using offsetofend()
on the following fields to allow per-field feature granularity without requiring
additional padding in the future.

If in the original rseq implementation we would have expected offsetofend() of the
flags fields as rseq_len, then we would not need those silly 12 bytes of padding,
but here we are.

> 
> Also have you considered adding an explicit 'version' field, or
> something more sophisticated than 'len'? I remember about a year ago
> you had an rfc patch(set) addressing rseq versioning, but I don't
> think it got merged? You had some concerns about using 'len' then...

It's vague in my memory, but I slightly recall aiming at using those 12-bytes of
padding for new feature extensions, in which case a version field would have helped.
But it appears we will very soon run out of space there and need to extend the
structure size anyway, so trying to re-purpose those 12 bytes might not be worth
the complexity.

Considering the userspace ABI exposed by glibc 2.35 (__rseq_offset, __rseq_size,
__rseq_flags), the "size" of the rseq structure becomes a really good fit for
available feature description across the entire ecosystem consisting of the kernel,
libc, and user applications. If we add a "version" field in there, then applications
would have to check yet one more thing in addition to the __rseq_size, which I
don't think is worthwhile.

> 
>> +
>> +       /*
>> +        * This is the end of the original rseq ABI.
>> +        * This is a valid end of rseq ABI for the purpose of rseq registration
>> +        * rseq_len.
>> +        * The original rseq ABI use "sizeof(struct rseq)" on registration,
>> +        * thus requiring the padding above.
>> +        */
>> +
>> +       /*
>> +        * Restartable sequences node_id field. Updated by the kernel. Read by
>> +        * user-space with single-copy atomicity semantics. This field should
>> +        * only be read by the thread which registered this data structure.
>> +        * Aligned on 32-bit. Contains the current NUMA node ID.
>> +        */
>> +       __u32 node_id;
>> +
>> +       /*
>> +        * This is a valid end of rseq ABI for the purpose of rseq registration
>> +        * rseq_len. Use the offset immediately after the node_id field as
>> +        * rseq_len.
>> +        */
>>  } __attribute__((aligned(4 * sizeof(__u64))));

Thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
