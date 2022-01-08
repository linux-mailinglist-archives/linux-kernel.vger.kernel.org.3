Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE15488095
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 02:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiAHBdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 20:33:37 -0500
Received: from mail.efficios.com ([167.114.26.124]:55518 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbiAHBde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 20:33:34 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E1C5937D26C;
        Fri,  7 Jan 2022 20:33:33 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id CueKu7_PTaPK; Fri,  7 Jan 2022 20:33:33 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9E6C937D605;
        Fri,  7 Jan 2022 20:33:33 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9E6C937D605
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1641605613;
        bh=zs3mrnBsLhYeroMuTKJk/TqjMUFWWyfhrso2Mz8iNoA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=WovgtdjXG2SapFxa0fdwh+l8XMT/+8rzdYyjN3vv2uAarbqs2Vf69K6HoLwusZZ31
         kVlp9glMrv1c1XtLR5P8pHdJEaTAedzQGFNrOxT3Da9tFzh13V4W87NpTboEpU85s0
         1JcLVYmqoGoG7dNCKiXAy/Tq/FP1zwWW8/Yt1cCQ6fcx3cMlA+db9d5fUxcRJAVZqQ
         AKe9kJDKXf5HpG+N8KcMlHu86B+QJod7pNrm40OsXlhi/maYdm9aT6PLEERLmpQP+J
         MaySh/jEjqGRwjNeElmS234Y+iHtmNVWZ/Dqo355UaGWNbKghvoMwyeo/iIgY8qemL
         Xox9vSZb/Hmwg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7o2BUmHlX3FV; Fri,  7 Jan 2022 20:33:33 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 8DF3237D604;
        Fri,  7 Jan 2022 20:33:33 -0500 (EST)
Date:   Fri, 7 Jan 2022 20:33:33 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Florian Weimer <fw@deneb.enyo.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        carlos <carlos@redhat.com>
Message-ID: <1752185722.14562.1641605613561.JavaMail.zimbra@efficios.com>
In-Reply-To: <333385690.14559.1641604090435.JavaMail.zimbra@efficios.com>
References: <20220107170302.8325-1-mathieu.desnoyers@efficios.com> <87a6g7ny0j.fsf@mid.deneb.enyo.de> <1968088162.13310.1641584935813.JavaMail.zimbra@efficios.com> <1300078200.13848.1641590867024.JavaMail.zimbra@efficios.com> <701ff3888b3f42f4a6a1dded84b79078@AcuMS.aculab.com> <333385690.14559.1641604090435.JavaMail.zimbra@efficios.com>
Subject: Re: [RFC PATCH] rseq: x86: implement abort-at-ip extension
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF95 (Linux)/8.8.15_GA_4177)
Thread-Topic: rseq: x86: implement abort-at-ip extension
Thread-Index: AdgEFboSAErst/O1Thaz4M9J8smUeRwcvnzKreT/0YI=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 7, 2022, at 8:08 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Jan 7, 2022, at 5:27 PM, David Laight David.Laight@ACULAB.COM wrote:
> 
>>> That being said, there might be an architecture agnostic alternative available.
>>> On abort of a RSEQ_CS_FLAG_ABORT_AT_IP critical section, we could let the kernel
>>> decrement/increment the stack pointer to make room for a pointer (depending if
>>> the
>>> stack grows down or up). It would then store the abort-at-ip value at the top of
>>> stack.
>> 
>> Stack redzone in a leaf function?
> 
> Good point!
> 
> For x86-64 for instance, which has a redzone of 128 bytes, there are a few
> alternatives.
> On abort:
> 
> Approach A) Move the stack pointer as little as possible
> 
>   1. On abort in kernel:
>   1.1 Subtract 8 bytes from the stack pointer
>   1.2 Store the abort-at-ip value at stack pointer - 128
>   2. In abort handler (userspace)
>   2.1 user-space knows that it can find the abort-at-ip value at stack pointer -
>   128
>   2.2 after using that value, the abort handler needs to add 8 bytes to the stack
>   pointer
> 
> Approach B) Move the stack pointer to skip the entire redzone
> 
>   1. On abort in kernel:
>   1.1 Subtract 128 bytes from the stack pointer
>   1.2 Store the abort-at-ip value at stack pointer - 8 (basically within a new red
>   zone)
>   2. In abort handler (userspace)
>   2.1 user-space knows that it can find the abort-at-ip value at stack pointer - 8
>   2.2 after using that value, the abort handler needs to add 128 bytes to the
>   stack pointer

Or approach C)

  1. On abort in kernel:
  1.1 Subtract 136 bytes from the stack pointer
  1.2 Store the abort-at-ip value at stack pointer
  2. In abort handler (userspace)
  2.1 user-space knows that it can find the abort-at-ip value at stack pointer, so
      it can pop it from the stack
  2.2 after popping that value, the abort handler needs to add 128 bytes to the stack pointer

So far, approach C seems to be the most elegant IMHO.

Thanks,

Mathieu


> 
> I suspect both approaches should work.
> 
> Any preference or other ideas ?
> 
> Thanks,
> 
> Mathieu
> 
>> 
>> -
>> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT,
>> UK
>> Registration No: 1397386 (Wales)
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
