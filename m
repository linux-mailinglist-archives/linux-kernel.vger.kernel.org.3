Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B6B4A6716
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 22:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbiBAVaY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Feb 2022 16:30:24 -0500
Received: from albireo.enyo.de ([37.24.231.21]:55702 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232084AbiBAVaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 16:30:23 -0500
Received: from [172.17.203.2] (port=60055 helo=deneb.enyo.de)
        by albireo.enyo.de ([172.17.140.2]) with esmtps (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        id 1nF0j8-00HVPD-Hm; Tue, 01 Feb 2022 21:30:14 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.94.2)
        (envelope-from <fw@deneb.enyo.de>)
        id 1nF0j8-000Qtd-63; Tue, 01 Feb 2022 22:30:14 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        David Laight <David.Laight@ACULAB.COM>,
        carlos <carlos@redhat.com>, Peter Oskolkov <posk@posk.io>
Subject: Re: [RFC PATCH 2/3] rseq: extend struct rseq with per thread group
 vcpu id
References: <20220201192540.10439-1-mathieu.desnoyers@efficios.com>
        <20220201192540.10439-2-mathieu.desnoyers@efficios.com>
        <87bkzqz75q.fsf@mid.deneb.enyo.de>
        <1075473571.25688.1643746930751.JavaMail.zimbra@efficios.com>
        <87sft2xr7w.fsf@mid.deneb.enyo.de>
        <1339477886.25835.1643750440726.JavaMail.zimbra@efficios.com>
Date:   Tue, 01 Feb 2022 22:30:14 +0100
In-Reply-To: <1339477886.25835.1643750440726.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Tue, 1 Feb 2022 16:20:40 -0500
        (EST)")
Message-ID: <87o83qxok9.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

> ----- On Feb 1, 2022, at 3:32 PM, Florian Weimer fw@deneb.enyo.de wrote:
> [...]
>> 
>>>> Is the switch really useful?  I suspect it's faster to just write as
>>>> much as possible all the time.  The switch should be well-predictable
>>>> if running uniform userspace, but still …
>>>
>>> The switch ensures the kernel don't try to write to a memory area beyond
>>> the rseq size which has been registered by user-space. So it seems to be
>>> useful to ensure we don't corrupt user-space memory. Or am I missing your
>>> point ?
>> 
>> Due to the alignment, I think you'd only ever see 32 and 64 bytes for
>> now?
>
> Yes, but I would expect the rseq registration arguments to have a rseq_len
> of offsetofend(struct rseq, tg_vcpu_id) when userspace wants the tg_vcpu_id
> feature to be supported (but not the following features).

But if rseq is managed by libc, it really has to use the full size
unconditionally.  I would even expect that eventually, the kernel only
supports the initial 32, maybe 64 for a few early extension, and the
size indicated by the auxiliary vector.

Not all of that area would be ABI, some of it would be used by the
vDSO only and opaque to userspace application (with applications/libcs
passing __rseq_offset as an argument to these functions).

>> I'd appreciate if you could put the maximm supported size and possibly
>> the alignment in the auxiliary vector, so that we don't have to rseq
>> system calls in a loop on process startup.
>
> Yes, it's a good idea. I'm not too familiar with the auxiliary vector.
> Are we talking about the kernel's
>
> fs/binfmt_elf.c:fill_auxv_note()
>
> ?

Indeed.
