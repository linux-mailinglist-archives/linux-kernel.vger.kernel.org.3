Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946EC48C6F0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 16:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354497AbiALPQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 10:16:53 -0500
Received: from albireo.enyo.de ([37.24.231.21]:55424 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354485AbiALPQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:16:45 -0500
Received: from [172.17.203.2] (port=47567 helo=deneb.enyo.de)
        by albireo.enyo.de ([172.17.140.2]) with esmtps (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        id 1n7fMa-00Fx93-B6; Wed, 12 Jan 2022 15:16:36 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.94.2)
        (envelope-from <fw@deneb.enyo.de>)
        id 1n7fMa-003TtF-1b; Wed, 12 Jan 2022 16:16:36 +0100
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
Date:   Wed, 12 Jan 2022 16:16:36 +0100
In-Reply-To: <1968088162.13310.1641584935813.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Fri, 7 Jan 2022 14:48:55 -0500
        (EST)")
Message-ID: <87y23l6l2j.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

> ----- On Jan 7, 2022, at 2:31 PM, Florian Weimer fw@deneb.enyo.de wrote:
>
>> * Mathieu Desnoyers:
>> 
>>> Allow rseq critical section abort handlers to optionally figure out at
>>> which instruction pointer the rseq critical section was aborted.
>>>
>>> This allows implementing rseq critical sections containing loops, in
>>> which case the commit side-effect cannot be the last instruction. This
>>> is useful to implement adaptative mutexes aware of preemption in
>>> user-space. (see [1])
>> 
>> Could you write the program counter to the rseq area instead?  This
>> would avoid discussing which register to clobber.
>
> Using the rseq area for that purpose would be problematic for nested signal
> handlers with rseq critical sections. If a signal happens to be delivered
> right after the abort ip adjustment, its signal handler containing a rseq
> critical section could overwrite the relevant "abort-at-ip" field in the
> rseq per-thread area before it has been read by the abort handler interrupted
> by the signal.
>
> Making this architecture-agnostic is indeed a laudable goal, but I don't
> think the rseq per-thread area is a good fit for this.
>
> I also though about making the clobbered register configurable on a
> per-critical-section basis, but I rather think that it would be
> overengineered: too much complexity for the gain. Unless there are
> very strong reasons for choosing one register over another on a per
> use-case basis ?

You could perhaps push a signal frame onto the stack.  It's going to
be expensive, but it's already in the context switch path, so maybe it
does not matter.
