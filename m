Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBC04A713E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238785AbiBBNI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:08:57 -0500
Received: from mail.efficios.com ([167.114.26.124]:55572 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiBBNI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:08:56 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1647B34ECF1;
        Wed,  2 Feb 2022 08:08:56 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id iTcKd-Q8oOys; Wed,  2 Feb 2022 08:08:55 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9A13334ECF0;
        Wed,  2 Feb 2022 08:08:55 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9A13334ECF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643807335;
        bh=vzO0p5w5j7FZ4ViC/C4AbqNMVeUQHoVdH0umaEKhaX8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=KLgBxHkf93QCuZ3WY8v/zAlE1UWPlw3hnI4czYXnJxuEEBSd5a2Haw2+OQWFkuz8b
         Z34IyD5fi3wkpzf9sa264PdCaWwo7L44IFC+QtUHFJPFMaQM/dhr76D+5z/gO/UolN
         qQIXZituMAETOD9Dbkp3RFbca0FP6PtRDehTDfYmvbybfmxGzJ9Cyv8/sdi9fREjef
         Dv2UvYQ7png3U3WLXRPr1FHphItE/4cJA3Jf01SD+SC+bytkWOMbk9P8Rw61wgpAcR
         FRcm+d+VsoJsV6CYMjEiO6BZ43FKVKXuvt7dUkGbV7OPWq57wF24n8w1FyBuFs1yhZ
         9a99UaKcR/jCQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GwcRLFcMm8Lg; Wed,  2 Feb 2022 08:08:55 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 7CEBE34EEEE;
        Wed,  2 Feb 2022 08:08:55 -0500 (EST)
Date:   Wed, 2 Feb 2022 08:08:55 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Chris Kennelly <ckennelly@google.com>,
        Paul Turner <pjt@google.com>, Peter Oskolkov <posk@posk.io>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Message-ID: <770517862.27112.1643807335312.JavaMail.zimbra@efficios.com>
In-Reply-To: <1375227765.27051.1643801804042.JavaMail.zimbra@efficios.com>
References: <432231420.24682.1643727496135.JavaMail.zimbra@efficios.com> <CAEE+ybn_Cp1-T=2uB7xJqU2gEU-PxzsaV5jqCOupNp2cx_bK-Q@mail.gmail.com> <87mtja1fuz.fsf@oldenburg.str.redhat.com> <875ypx1x0d.fsf@oldenburg.str.redhat.com> <1375227765.27051.1643801804042.JavaMail.zimbra@efficios.com>
Subject: Re: Aligning tcmalloc with glibc 2.35 rseq ABI
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4203)
Thread-Topic: Aligning tcmalloc with glibc 2.35 rseq ABI
Thread-Index: bfYiCaJUUsTdq41BtJE3Fb9JJIH1YGMmnFBS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 2, 2022, at 6:36 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Feb 2, 2022, at 3:41 AM, Florian Weimer fweimer@redhat.com wrote:
> 
>> * Florian Weimer:
>> 
>>> * Chris Kennelly:
>>>
>>>> Thanks for the heads up.
>>>>
>>>> I did have a question about whether the new protocol would introduce
>>>> an extra memory reference while initializing a critical section.
>>>>
>>>> * With initial-exec TLS, I can directly reference __rseq_abi.
>>>> * With the new ABI, I might need to ask glibc for the address of the
>>>> registered rseq structure in its thread data.
>>>
>>> You can write __rseq_offset to a static/hidden variable in an ELF
>>> constructor, and then use pretty much the same assembler sequences as
>>> for initial-exec TLS on most architectures.
>> 
>> And now I'm kind of worried that we should be using ptrdiff_t for
>> __rseq_offset because that's what the initial-exec relocations use. 8-/
> 
> I suspect the underlying question here is: how likely is it that a libc
> requires an offset of more than 2GB either way from the thread pointer
> to allocate its rseq thread area on a 64-bit architecture ?

More to the point: is ptrdiff_t the correct type here ? I think so.
Do we want to revert the ABI and wait another 6 months before we
bring back rseq into glibc just for this ? I'm not sure this limitation
justifies it.

So if there is a quick way to fix that before the official 2.35 release,
I'm all for it, otherwise I cannot say that __rseq_offset being an "int"
rather than a "ptrdiff_t" will make much real-life difference (unless
I'm proven wrong). But we will be stuck with this quirk forever.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
