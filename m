Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374FB48C6C4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 16:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354443AbiALPFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 10:05:44 -0500
Received: from mail.efficios.com ([167.114.26.124]:37014 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348032AbiALPFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:05:35 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id DC2C0256756;
        Wed, 12 Jan 2022 10:05:34 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id LP9esjWTT2mL; Wed, 12 Jan 2022 10:05:34 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 456C92565D5;
        Wed, 12 Jan 2022 10:05:34 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 456C92565D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1641999934;
        bh=+iUEccd7drZTeuR4f7YzCJIgxU8t9H+YvbeucnM5mMg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=T17CrfyvbDZJhUwy5q8Id+CqZhBKv+R1IXgpx8TYklCEYgtgfgP70DnNxdgTSOc/U
         m6Iw37ZRyMAq+XPOEWaUqY3hlbPkwL8NpE68y4TOOOFp+AaaJ1Hpxo4aonzjybZURZ
         V/CycUJKSWEmcMtf7daa3KfVZaS3eWwD26Jl6ZDjVH5leaE/9FhCurfoL/WptzqqmY
         NXuLIfrXMktzE4i4K3fdMtbIeCnZ+8uavt3GlcjnvZssRi3r0IRs5jYkdfKnCu74MM
         YQnq6zg3X3TbMZtKdR47n0oR9V6kQX4NVek1EAZ3shsiaIVfURd10ZvwHs2d3i+I72
         wCLfAckYxdXmQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id R-1ccebGqD7y; Wed, 12 Jan 2022 10:05:34 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 315472567CF;
        Wed, 12 Jan 2022 10:05:34 -0500 (EST)
Date:   Wed, 12 Jan 2022 10:05:34 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Brauner <brauner@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, carlos <carlos@redhat.com>
Message-ID: <1953851780.24610.1641999934047.JavaMail.zimbra@efficios.com>
In-Reply-To: <71e7d09733df4a899d12b7ef25198bbc@AcuMS.aculab.com>
References: <20220110171611.8351-1-mathieu.desnoyers@efficios.com> <20220111110556.inteixgtl5vpmka7@wittgenstein> <1626924888.21447.1641922985771.JavaMail.zimbra@efficios.com> <20220112084617.32bjjo774n7vvyct@wittgenstein> <1475639366.24565.1641998849957.JavaMail.zimbra@efficios.com> <71e7d09733df4a899d12b7ef25198bbc@AcuMS.aculab.com>
Subject: Re: [RFC PATCH v2 1/2] rseq: x86: implement abort-at-ip extension
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4177)
Thread-Topic: rseq: x86: implement abort-at-ip extension
Thread-Index: AdgHxNJPmHALYHCBSGGqQq0pyoAGXDSYsRN7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 12, 2022, at 9:58 AM, David Laight David.Laight@ACULAB.COM wrote:

>>  * [*] The openrisc, powerpc64 and x86-64 architectures define a "redzone" as a
>>  *     stack area beyond the stack pointer which can be used by the compiler
>>  *     to store local variables in leaf functions.
> 
> I wonder if that is really worth the trouble it causes!
> By the time a function is spilling values to stack the cost
> of a %sp update is almost certainly noise.
> 
> Someone clearly thought it was a 'good idea (tm)'.

I must admit that I've been surprised to learn about these redzones. Thanks for
pointing them out to me, it was clearly a blind spot. I suspect it would be useful
to introduce per-architecture KERNEL_REDZONE, USER_REDZONE and COMPAT_USER_REDZONE
with a asm-generic version defining them to 0, with proper documentation. It would
make it clearer to kernel developers working on stuff similar to signal handler
delivery that they need to consider these carefully.

Mathieu

> 
>	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT,
> UK
> Registration No: 1397386 (Wales)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
