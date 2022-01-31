Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51C04A5163
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 22:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358112AbiAaVW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 16:22:27 -0500
Received: from mail.efficios.com ([167.114.26.124]:47656 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344273AbiAaVW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:22:27 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 857BB2DEED3;
        Mon, 31 Jan 2022 16:22:26 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jXE3ALfzYyaf; Mon, 31 Jan 2022 16:22:26 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E5F762DEED2;
        Mon, 31 Jan 2022 16:22:25 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E5F762DEED2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643664145;
        bh=txvdeBRJIDSoZj38nmz9gg5nsHrUcXP/5rIWAEfpaso=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=L4rsQtMLGx0I48XwJvbPkrjb+MHXSUlRGQDhWqBk9q75a7Ixqy6+F59FUewmwSH1L
         z2eij1ecOAagoOfYqAvag1UlC+ogUHlKUdChHI+EjXY4jAU9fXlQRKkrH4Z6Lu4w9f
         KF0iK50urDnOzHrcUBWsr9XgfEh/CAs+NsjB9V98TYDODttmSBuBTNoLlKyHu4jBC+
         FEPSadXstQlIyG563ejCLe42HYkXaHMJSRBE5nHBMOGajgmDpPNzLbsnIc1k/mwceD
         ah4QJ7Z3s/3g9z3u5gIwCKI7drjNXVjxHHEz8hDge86JykcPZ5Oqg8Pv4+YHPQdHQc
         4zfe1l5oWWrpQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9AYpGWRqql9X; Mon, 31 Jan 2022 16:22:25 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id CC5CE2DF13A;
        Mon, 31 Jan 2022 16:22:25 -0500 (EST)
Date:   Mon, 31 Jan 2022 16:22:25 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        David Laight <David.Laight@ACULAB.COM>,
        carlos <carlos@redhat.com>, Peter Oskolkov <posk@posk.io>
Message-ID: <1978385715.23580.1643664145710.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220131205531.17873-1-mathieu.desnoyers@efficios.com>
References: <20220131205531.17873-1-mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH 1/2] rseq: extend struct rseq with numa node id
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4203)
Thread-Topic: rseq: extend struct rseq with numa node id
Thread-Index: 3gTKn3cvSA+Z8hanV+kH2gipUJJE8w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 31, 2022, at 3:55 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> Adding the NUMA node id to struct rseq is a straightforward thing to do,
> and a good way to figure out if anything in the user-space ecosystem
> prevents extending struct rseq.
> 
> This NUMA node id field allows memory allocators such as tcmalloc to
> take advantage of fast access to the current NUMA node id to perform
> NUMA-aware memory allocation.
> 
> It is also useful for implementing NUMA-aware user-space mutexes.
> 

[...]

> +	__u32 padding1[3];
> +
> +	/*
> +	 * This is the end of the original rseq ABI.
> +	 * This is a valid end of rseq ABI for the purpose of rseq registration
> +	 * rseq_len.
> +	 * The original rseq ABI use "sizeof(struct rseq)" on registration,
> +	 * thus requiring the padding above.
> +	 */
> +
> +	/*
> +	 * Restartable sequences node_id_start field. Updated by the
> +	 * kernel. Read by user-space with single-copy atomicity
> +	 * semantics. This field should only be read by the thread which
> +	 * registered this data structure. Aligned on 32-bit. Always
> +	 * contains a value in the range of possible NUMA node IDs, although the
> +	 * value may not be the actual current NUMA node ID (e.g. if rseq is not
> +	 * initialized). This NUMA node ID number value should always be compared
> +	 * against the value of the node_id field before performing a rseq
> +	 * commit or returning a value read from a data structure indexed using
> +	 * the node_id_start value.
> +	 */
> +	__u32 node_id_start;

Considering that the same "node id" is shared across various cores, I don't expect
it to be of much use in a rseq critical section comparison. That differs from the
"cpu id" (really the core ID), or the eventual concept of "vcpu id" as developed
internally at Google, which are identifiers which are guaranteed to be unique
within a process, and unchanged, for the duration of the rseq critical section.

Also, having these node_id* fields after the original end of the struct rseq
means user-space would have to check whether the glibc's __rseq_size is large
enough to contain those node_id* fields before loading them, which means there
needs to be at least one comparison before using the fields, therefore defeating
the purpose of the "*_id_start" trick.

So for those two reasons, I think just the "node_id" field would be sufficient
(no node_id_start field).

This brings another question though: should we then place the "node_id" field
in the original struct rseq padding or after ?

If we place it in the original padding, then glibc-2.35 would have enough
space to contain this field, but we would need to add a new sys_rseq flag to
query whether the node_id field is supported by the kernel, for use by
applications and glibc.

However, if we choose to place the new node_id field after the original
padding, applications can simply check with the __rseq_size exposed by
glibc to detect whether this field is there and populated. I have a
preference for this last approach as this looks less like a "one-off"
hack, and a more future-proof way to extend struct rseq.

Thoughts ?

Thanks,

Mathieu

> +
> +	/*
> +	 * Restartable sequences node_id field. Updated by the kernel.
> +	 * Read by user-space with single-copy atomicity semantics. This
> +	 * field should only be read by the thread which registered this
> +	 * data structure. Aligned on 32-bit. Values
> +	 * RSEQ_ID_UNINITIALIZED and RSEQ_ID_REGISTRATION_FAILED
> +	 * have a special semantic: the former means "rseq uninitialized",
> +	 * and latter means "rseq initialization failed". This value is
> +	 * meant to be read within rseq critical sections and compared
> +	 * with the node_id_start value previously read, before performing
> +	 * the commit instruction, or read and compared with the
> +	 * node_id_start value before returning a value loaded from a data
> +	 * structure indexed using the node_id_start value.
> +	 */
> +	__u32 node_id;
> +
> +	/*
> +	 * This is a valid end of rseq ABI for the purpose of rseq registration
> +	 * rseq_len. Use the offset immediately after the node_id field as
> +	 * rseq_len.
> +	 */
> } __attribute__((aligned(4 * sizeof(__u64))));
> 
-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
