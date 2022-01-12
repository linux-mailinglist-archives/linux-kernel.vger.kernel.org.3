Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46EC48C727
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 16:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245705AbiALPYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 10:24:15 -0500
Received: from mail.efficios.com ([167.114.26.124]:43292 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239638AbiALPYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:24:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1D840256AD7;
        Wed, 12 Jan 2022 10:24:14 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Yu5SzVRVX3wZ; Wed, 12 Jan 2022 10:24:13 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9405E2569FC;
        Wed, 12 Jan 2022 10:24:13 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9405E2569FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1642001053;
        bh=khNFZZCALdguJbA4GqpocK2qhvdCNT10jDgdgCLUyz4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=tyFXRUGaclxtF0A9stO+5Md9kvttN2ssiRMz8QI8snMPWPPotfSSkQCsmgjj6x9Uh
         Sc35/HeSRa76vaFyyjdzVokAdAonNEDQLZq2R9DbfvQ49byU46SA7jmavYHhxAmVcp
         5rUU/hcjEl749tcT7DXEKEr1m96sqOaZDu5LkNpTd/7VwiCF4xU3J1kv2QvnINmYmO
         2CLS1c3zF5sfhaGR9GiCc3FYF2OaClfe4cz6EO7pzUVsDwHOQvuesBixPegvzc6OCS
         QMZ6tmLDC4pZuDCQFQ+aHuF398nbfhWUZ727ksLLASiInGyXVjUUbWUoBLkfPZf6+B
         7Fb82Y2UnYlNg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hGNTZmH07Ibj; Wed, 12 Jan 2022 10:24:13 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 804882569FB;
        Wed, 12 Jan 2022 10:24:13 -0500 (EST)
Date:   Wed, 12 Jan 2022 10:24:13 -0500 (EST)
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
Message-ID: <2040942183.24657.1642001053391.JavaMail.zimbra@efficios.com>
In-Reply-To: <0088806280f54211b3f90b2c1a82a140@AcuMS.aculab.com>
References: <20220110171611.8351-1-mathieu.desnoyers@efficios.com> <20220111110556.inteixgtl5vpmka7@wittgenstein> <1626924888.21447.1641922985771.JavaMail.zimbra@efficios.com> <20220112084617.32bjjo774n7vvyct@wittgenstein> <1475639366.24565.1641998849957.JavaMail.zimbra@efficios.com> <71e7d09733df4a899d12b7ef25198bbc@AcuMS.aculab.com> <1953851780.24610.1641999934047.JavaMail.zimbra@efficios.com> <0088806280f54211b3f90b2c1a82a140@AcuMS.aculab.com>
Subject: Re: [RFC PATCH v2 1/2] rseq: x86: implement abort-at-ip extension
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4177)
Thread-Topic: rseq: x86: implement abort-at-ip extension
Thread-Index: AdgHxNJPmHALYHCBSGGqQq0pyoAGXDSYsRN7NJggl0DQZ+TsQA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 12, 2022, at 10:15 AM, David Laight David.Laight@ACULAB.COM wrote:

> From: Mathieu Desnoyers
>> Sent: 12 January 2022 15:06
>> 
>> ----- On Jan 12, 2022, at 9:58 AM, David Laight David.Laight@ACULAB.COM wrote:
>> 
>> >>  * [*] The openrisc, powerpc64 and x86-64 architectures define a "redzone" as a
>> >>  *     stack area beyond the stack pointer which can be used by the compiler
>> >>  *     to store local variables in leaf functions.
>> >
>> > I wonder if that is really worth the trouble it causes!
>> > By the time a function is spilling values to stack the cost
>> > of a %sp update is almost certainly noise.
>> >
>> > Someone clearly thought it was a 'good idea (tm)'.
>> 
>> I must admit that I've been surprised to learn about these redzones. Thanks for
>> pointing them out to me, it was clearly a blind spot. I suspect it would be
>> useful
>> to introduce per-architecture KERNEL_REDZONE, USER_REDZONE and
>> COMPAT_USER_REDZONE
>> with a asm-generic version defining them to 0, with proper documentation. It
>> would
>> make it clearer to kernel developers working on stuff similar to signal handler
>> delivery that they need to consider these carefully.
> 
> They can never be used in kernel - any ISR would overwrite them.

arch/powerpc/include/asm/ptrace.h define those for ppc64:

113:#define USER_REDZONE_SIZE	512
114:#define KERNEL_REDZONE_SIZE	288

and then uses the kernel redzone size for:

#define STACK_INT_FRAME_SIZE    (sizeof(struct pt_regs) + \
                                 STACK_FRAME_OVERHEAD + KERNEL_REDZONE_SIZE)

which AFAIU should ensure that ISR don't overwrite the redzone within the kernel.

Thanks,

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
