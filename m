Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A334A516B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 22:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380980AbiAaV0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 16:26:11 -0500
Received: from mail.efficios.com ([167.114.26.124]:49002 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244272AbiAaV0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:26:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 539612DF147;
        Mon, 31 Jan 2022 16:26:09 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id CaT8eJAiAiGs; Mon, 31 Jan 2022 16:26:06 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3D82D2DEE7B;
        Mon, 31 Jan 2022 16:26:06 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3D82D2DEE7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643664366;
        bh=LgxHjN6gBiTflkLh1heUnmcfUSp0BEYeZqCSwhmrXAw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=iGXxQRNBwGtwM5/ykoScBfnzosul/Spk7POHhBooZeeWlvKTJqw/nOBCdIy+15MO3
         dtYkztRBw+IujS2svr/B4EQjZQH6qQiNN9yT9HUvEGgHVp0H8stAJgEXxjao9fae1O
         Igbmw3PQl0E9r+kmAHnkTBYQI2R7ljTGvynf5V4SAxPY3NbrFcKxf9PAK1O/q8ZpEj
         gQGryd5wGXUNAI0RJggRyzsC/kzMSPqxJfqx5f2qZGmSmdg0myRyFxwhWIhJolYAAD
         mddul1kNFwDX8IxfkhB+Y2nM08GFSVuyKaYsPLdro6DQ7pe8/0C1rRtaFULLuTLXCI
         0Ea5qOUGX7oFQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8kmlhCAaVMv2; Mon, 31 Jan 2022 16:26:06 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 2785A2DF0E8;
        Mon, 31 Jan 2022 16:26:06 -0500 (EST)
Date:   Mon, 31 Jan 2022 16:26:06 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        David Laight <David.Laight@ACULAB.COM>,
        carlos <carlos@redhat.com>, Peter Oskolkov <posk@posk.io>
Message-ID: <1424193545.23589.1643664366116.JavaMail.zimbra@efficios.com>
In-Reply-To: <8735l3k3hu.fsf@mid.deneb.enyo.de>
References: <20220131205531.17873-1-mathieu.desnoyers@efficios.com> <8735l3k3hu.fsf@mid.deneb.enyo.de>
Subject: Re: [RFC PATCH 1/2] rseq: extend struct rseq with numa node id
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4203)
Thread-Topic: rseq: extend struct rseq with numa node id
Thread-Index: 4Z0ERdYlClpVqtwHpztF1PAC4AXw6A==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 31, 2022, at 4:19 PM, Florian Weimer fw@deneb.enyo.de wrote:

> * Mathieu Desnoyers:
> 
>> Adding the NUMA node id to struct rseq is a straightforward thing to do,
>> and a good way to figure out if anything in the user-space ecosystem
>> prevents extending struct rseq.
>>
>> This NUMA node id field allows memory allocators such as tcmalloc to
>> take advantage of fast access to the current NUMA node id to perform
>> NUMA-aware memory allocation.
>>
>> It is also useful for implementing NUMA-aware user-space mutexes.
> 
> It can be used to implement getcpu purely in userspace, too.  I had
> plan to hack this together with a node ID cache in TLS, which should
> offer pretty much the same functionality (except for weird CPU
> topology changes which alter the node ID of a previously used CPU).

I suspect that any approach based on a user-space cache will break with
respect to CRIU. That is one big advantage of using the rseq thread area
for this.

> 
> However, I do not understand the need for two fields here.  Why isn't
> one enough?

As stated in my self-reply, I don't think those two fields are needed
after all.

> 
> One field would also avoid the need to mess with rseq_cpu_id_state,
> maintaining API compatibility.

True. However considering that we plan to remove the buggy "rseq_cs.ptr"
fields from the API, that rseq.h UAPI compatibility does not seem to be
very much relevant.

But still, it's better if we can avoid breaking API, agreed. And the
"node_id_start" does not appear to be needed after all.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
