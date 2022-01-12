Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506F248C599
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243150AbiALOG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239995AbiALOG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:06:27 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFF7C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 06:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+j1dla8yYdTDIkB0+h/HiKBaQzQ6SzSOKXqcY9iZad0=; b=OJm2Ml5A8vUj2ThKvkhxcAzzxp
        HaSo9ZEp0/JRAs0+n0PIEjYuGA0C/f7yL8xUAzQD1iLVA1tmI0VssQTbjo+wxreUIXhKasUNW+EiK
        53WIoe56QZcE9kaqZVzhmKdswZPAjfqiyoOJ5peBVqmMbeX+exDshrQXjqq+dZTsa/mbHmoo0a/V7
        p1keNNzCZOxMOhHJiM8e3uyPMQ7i4Gd0O2eCkoGaBSgShhycgfq7JfDFPMKuVWTBdENEKDPoJkMT5
        Z3+BJxLpH5mQf3eONrVqMxF2bFLZnzKrQegTrj1KrtXb8ZpJ08AhCRSEImrJDJ2Hl8ob59xD5D4/s
        +dqwm9ow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7eGU-000oJp-Vj; Wed, 12 Jan 2022 14:06:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 928AF300222;
        Wed, 12 Jan 2022 15:06:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7345B29CA46E8; Wed, 12 Jan 2022 15:06:12 +0100 (CET)
Date:   Wed, 12 Jan 2022 15:06:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tim Murray <timmurray@google.com>
Cc:     Waiman Long <longman@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] f2fs: move f2fs to use reader-unfair rwsems
Message-ID: <Yd7gVLdHW11TQUAi@hirez.programming.kicks-ass.net>
References: <20220108164617.3130175-1-jaegeuk@kernel.org>
 <YdvoxkAAquI17UbX@infradead.org>
 <a23a3226-95d9-9835-c1c7-2d13f4a1ee16@redhat.com>
 <CAEe=SxnWeK0pSfijPKJSTxBiMgD1Ev69fV3qSTCgWASk0b3vhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEe=SxnWeK0pSfijPKJSTxBiMgD1Ev69fV3qSTCgWASk0b3vhA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 11:41:23AM -0800, Tim Murray wrote:

> 1. f2fs-ckpt thread is running f2fs_write_checkpoint(), holding the
> cp_rwsem write lock while doing so via f2fs_lock_all() in
> block_operations().
> 2. Random very-low-priority thread A makes some other f2fs call that
> tries to get the cp_rwsem read lock by atomically adding on the rwsem,
> fails and deschedules in uninterruptible sleep. cp_rwsem now has a
> non-zero reader count but is write-locked.
> 3. f2fs-ckpt thread releases the cp_rwsem write lock. cp_rwsem now has
> a non-zero reader count and is not write-locked, so is reader-locked.
> 4. Other threads call fsync(), which requests checkpoints from
> f2fs-ckpt, and block on a completion event that f2fs-ckpt dispatches.
> cp_rwsem still has a non-zero reader count because the low-prio thread
> A from (2) has not been scheduled again yet.
> 5. f2fs-ckpt wakes up to perform checkpoints, but it stalls on the
> write lock via cmpxchg in block_operations() until the low-prio thread
> A has run and released the cp_rwsem read lock. Because f2fs-ckpt can't
> run, all fsync() callers are also effectively blocked by the
> low-priority thread holding the read lock.
> 
> I think this is the rough shape of the problem (vs readers holding the
> lock for too long or something like that) because the low-priority
> thread is never run between when it is initially made runnable by
> f2fs-ckpt and when it runs tens/hundreds of milliseconds later then
> immediately unblocks f2fs-ckpt.

*urgh*... so you're making the worst case less likely but fundamentally
you don't change anything.

If one of those low prio threads manages to block while holding
cp_rwsem your checkpoint thread will still block for a very long time.

So while you improve the average case, the worst case doesn't improve
much I think.

Also, given that this is a system wide rwsem, would percpu-rwsem not be
'better' ? Arguably with the same hack cgroups uses for it (see
cgroup_init()) to lower the cost of percpu_down_write().

Now, I'm not a filesystem developer and I'm not much familiar with the
problem space, but this locking reads like a fairly big problem. I'm not
sure optimizing the lock is the answer.


