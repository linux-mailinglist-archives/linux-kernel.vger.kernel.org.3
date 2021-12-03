Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546F046734D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 09:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379227AbhLCIg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 03:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379202AbhLCIg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 03:36:56 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC326C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 00:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a395hufFAaA8i2KMNT8vcKv0fNMIa85KJAEXQSVEeSM=; b=W2jwhSZwoCkLucDhOuhbFZlIXF
        of1YeLKj+ygPpXw0PZ9A3V5aFS5ETJf7T+EncgOzMJRl8G6EbgR4YlYucH5epstssPnTAtuyyZrKR
        8slCdlkIRYpClsXql04ntoAoNsWcCNXiFpKyUUvQd5fKA6SBOC9PePlEPKLVKKh8+fn80MgsyGg/B
        3PXmI+24QUNWnyXv4DKE9G37iEGC4ByI+8QGZ3Epn41qCX++1mFnsWtMi+qV0j7MkR0DV0biTOdBG
        WkMic+cPgJF4zrz0ztwgT/QyUfjoB2SsT8wjpjdLzIyVNUzQFPj3XMPBWTGgShGwc/+4gY5sfD1Br
        e1Dk5AYw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mt40K-001xnK-0j; Fri, 03 Dec 2021 08:33:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2F8E4300243;
        Fri,  3 Dec 2021 09:33:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DF18830321BA0; Fri,  3 Dec 2021 09:33:14 +0100 (CET)
Date:   Fri, 3 Dec 2021 09:33:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v2 0/2] locking: Fix racy reads of owner->on_cpu
Message-ID: <YanWSh2miL6E+aZR@hirez.programming.kicks-ass.net>
References: <20211203075935.136808-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203075935.136808-1-wangkefeng.wang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 03:59:33PM +0800, Kefeng Wang wrote:
> v2:
> - adding owner_on_cpu() refactor, shared by mutex/rtmutex/rwsem
> 
> v1: https://lore.kernel.org/all/20211202101238.33546-1-elver@google.com/
> 
> Kefeng Wang (1):
>   locking: Make owner_on_cpu() into <linux/sched.h>
> 
> Marco Elver (1):
>   locking: Mark racy reads of owner->on_cpu
> 
>  include/linux/sched.h    |  9 +++++++++
>  kernel/locking/mutex.c   | 11 ++---------
>  kernel/locking/rtmutex.c |  5 ++---
>  kernel/locking/rwsem.c   |  9 ---------
>  4 files changed, 13 insertions(+), 21 deletions(-)

Thanks!
