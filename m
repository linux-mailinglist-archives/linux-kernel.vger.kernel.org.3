Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4247493688
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352522AbiASIsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237729AbiASIsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:48:16 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4A5C061574;
        Wed, 19 Jan 2022 00:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=id804dbsfqejPK5oRefHchyYSiupvM/8xrLRLyc6bqE=; b=DrCxgNBqn8qYFuoVPtXZH+3ZEQ
        v1EmQwU7CA2xtAsN/J1fhnoyuGpLjlug3F6wyfSoIiXsc5T33lhJBVuMYABLjCUS0w+uu+x23Ccj4
        NiyO+h5WA2nHTlI9HSgyyKsAMFuSQT3Kr8z+cQ1nx6l3tfCgIWiAQCQD18WkZ9YWu+ECRDkdD2/Ls
        z7G8BfnFY8d5LtNwL4JPxhBXQqzVmVSlLILtVBpz/IqHLvpYauR5MrvjbmW3+8SoRasbN2XtgcNiq
        JoxYpX5uy0lwGVMSbeMd5pi8it9pA6NHyoFjZtyCL5ZRV0ms4wi3JAG3fpkzihFp1ZFthlqTWfpsu
        IypY5rdg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nA6cz-0020O1-T1; Wed, 19 Jan 2022 08:47:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 05513300140;
        Wed, 19 Jan 2022 09:47:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CD1F8203C6487; Wed, 19 Jan 2022 09:47:33 +0100 (CET)
Date:   Wed, 19 Jan 2022 09:47:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@google.com>
Cc:     Peter Oskolkov <posk@posk.io>, mingo@redhat.com,
        tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, avagin@google.com, jannh@google.com,
        tdelisle@uwaterloo.ca
Subject: Re: [RFC][PATCH 3/3] sched: User Mode Concurency Groups
Message-ID: <YefQJXn3x3JJtB1d@hirez.programming.kicks-ass.net>
References: <20211214204445.665580974@infradead.org>
 <20211214205358.701701555@infradead.org>
 <20211221171900.GA580323@dev-hv>
 <YeGEM7TP3tekBVEh@hirez.programming.kicks-ass.net>
 <YeaRx9oDp08ABvyU@hirez.programming.kicks-ass.net>
 <CAPNVh5cdGiDqut90kUo-HXyya6Nbz_CjuUObYXfprgDhQHnUmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPNVh5cdGiDqut90kUo-HXyya6Nbz_CjuUObYXfprgDhQHnUmg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 10:19:21AM -0800, Peter Oskolkov wrote:
> ============= worker-to-worker context switches
> 
> One example: absl::Mutex (https://abseil.io/about/design/mutex) has
> google-internal extensions that are "fiber aware". More specifically,
> consider this situation:
> 
> - worker W1 acqured the mutex and is doing its work
> - worker W2 calls mutex::lock()
>   mutex::lock(), being aware of workers, understands that W2 is going to sleep;
>   so instead of just doing so, waking the server, and letting
>   the server figure out what to run in place of the sleeping worker,
> mutex::lock()
>   calls into the userspace scheduler in the context of W2 running, and the
>   userspace scheduler then picks W3 to run and does W2->W3 context switch.
> 
> The optimization above replaces W2->Server and Server->W3 context switches
> with a single W2->W3 context switch, which is a material performance gain.

Yes, I've also already reconsidered. Things like pipelines and other
fixed order scheduling policies will greatly benefit from
worker-to-worker switching.

But I think all of them are explicit. That is, we can limit the
::next_tid usage to sys_umcg_wait() and never look at it for implicit
blocks.

> In addition, when W1 calls mutex::unlock(), the scheduling code determines
> that W2 is waiting on the mutex, and thus calls W2::wake() from the context of
> running W1 (you asked earlier why do we need "WAKE_ONLY").

This I'm not at all convinced on. That sounds like it will violate the
1:1 thing.
