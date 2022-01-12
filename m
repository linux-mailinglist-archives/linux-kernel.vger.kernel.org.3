Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D3C48CD55
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 22:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiALVBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 16:01:15 -0500
Received: from albireo.enyo.de ([37.24.231.21]:37268 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbiALVA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 16:00:57 -0500
Received: from [172.17.203.2] (port=33343 helo=deneb.enyo.de)
        by albireo.enyo.de ([172.17.140.2]) with esmtps (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        id 1n7kjV-00GoGu-Dj; Wed, 12 Jan 2022 21:00:37 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.94.2)
        (envelope-from <fw@deneb.enyo.de>)
        id 1n7kjV-003dn8-32; Wed, 12 Jan 2022 22:00:37 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        carlos <carlos@redhat.com>
Subject: Re: [RFC PATCH] rseq: x86: implement abort-at-ip extension
References: <20220107170302.8325-1-mathieu.desnoyers@efficios.com>
        <87a6g7ny0j.fsf@mid.deneb.enyo.de>
        <1968088162.13310.1641584935813.JavaMail.zimbra@efficios.com>
        <87y23l6l2j.fsf@mid.deneb.enyo.de>
        <Yd71+Da44h9Ge0+s@hirez.programming.kicks-ass.net>
        <87sftt6j0u.fsf@mid.deneb.enyo.de>
        <396330808.24806.1642005485899.JavaMail.zimbra@efficios.com>
Date:   Wed, 12 Jan 2022 22:00:37 +0100
In-Reply-To: <396330808.24806.1642005485899.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Wed, 12 Jan 2022 11:38:05 -0500
        (EST)")
Message-ID: <87h7a87jpm.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

> ----- On Jan 12, 2022, at 11:00 AM, Florian Weimer fw@deneb.enyo.de wrote:
>
>> * Peter Zijlstra:
>> 
>>> On Wed, Jan 12, 2022 at 04:16:36PM +0100, Florian Weimer wrote:
>>>
>>>> You could perhaps push a signal frame onto the stack.  It's going to
>>>> be expensive, but it's already in the context switch path, so maybe it
>>>> does not matter.
>>>
>>> Please no! Signals are a trainwreck that need change (see the whole
>>> AVX-512 / AMX saga), we shouldn't use more of that just cause.
>> 
>> If it's a signal, it should be modeled as such.  I think it's pretty
>> close to a synchronous signal.

(an asynchronous signal)

> Florian, just to validate here: is your argument about AVX-512/AMX or about
> rseq abort-at-ip ?

rseq abort-at-ip.  I wonder if it is possible to use regular stack
unwinding (through the signal frame) to figure out where the abort
happened, and use the existing cleanup handler functionality in GCC.
(Although -fnon-call-exceptions is not quite up to this, but in theory
we would have to fix this for POSIX asynchronous cancellation/Ada
asynchronous transfer of control support anyway.)
