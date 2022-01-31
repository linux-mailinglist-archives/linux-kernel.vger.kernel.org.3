Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444334A514D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 22:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380109AbiAaVTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 16:19:17 -0500
Received: from albireo.enyo.de ([37.24.231.21]:33272 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241083AbiAaVTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:19:16 -0500
Received: from [172.17.203.2] (port=40553 helo=deneb.enyo.de)
        by albireo.enyo.de ([172.17.140.2]) with esmtps (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        id 1nEe4r-00CoZr-Hd; Mon, 31 Jan 2022 21:19:09 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.94.2)
        (envelope-from <fw@deneb.enyo.de>)
        id 1nEe4r-000tNN-6V; Mon, 31 Jan 2022 22:19:09 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        David.Laight@ACULAB.COM, carlos@redhat.com,
        Peter Oskolkov <posk@posk.io>
Subject: Re: [RFC PATCH 1/2] rseq: extend struct rseq with numa node id
References: <20220131205531.17873-1-mathieu.desnoyers@efficios.com>
Date:   Mon, 31 Jan 2022 22:19:09 +0100
In-Reply-To: <20220131205531.17873-1-mathieu.desnoyers@efficios.com> (Mathieu
        Desnoyers's message of "Mon, 31 Jan 2022 15:55:30 -0500")
Message-ID: <8735l3k3hu.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

> Adding the NUMA node id to struct rseq is a straightforward thing to do,
> and a good way to figure out if anything in the user-space ecosystem
> prevents extending struct rseq.
>
> This NUMA node id field allows memory allocators such as tcmalloc to
> take advantage of fast access to the current NUMA node id to perform
> NUMA-aware memory allocation.
>
> It is also useful for implementing NUMA-aware user-space mutexes.

It can be used to implement getcpu purely in userspace, too.  I had
plan to hack this together with a node ID cache in TLS, which should
offer pretty much the same functionality (except for weird CPU
topology changes which alter the node ID of a previously used CPU).

However, I do not understand the need for two fields here.  Why isn't
one enough?

One field would also avoid the need to mess with rseq_cpu_id_state,
maintaining API compatibility.
