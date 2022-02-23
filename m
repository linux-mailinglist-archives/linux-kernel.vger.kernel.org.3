Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5004C0D7E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238717AbiBWHmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236278AbiBWHmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:42:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64B33B298
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UUDMqr/9c1gNA/wamWMnwltjDT92zuHM5PlATkNE7uw=; b=knZxiD9W6pRdpjcOchY0fSbRZR
        TuX7xUFcdsrpfwV71LIZFOUZdYME9PbodVM8OlD9ckYCHq7+g7pkI7gveYqEcn19vo1h8el7P7AXC
        1mlrWZ3BikTpHCM40cJUPGsz7RP2HKehF0FmgMFveF/UMFqfPmPGUkN64YwrVOzTaD33TupF3ngnj
        KrEiIHAC2p9PbwASviKdVZbh9jgQlkuH3eKJTMlvCyTM+U91+FYI0ja+C7wHvvN74hRFb5gz95CJy
        egwLl1rGprTjkvVpVVv9pygIkadMFj8FaFPZE/Uh27euKaX7zniv9e5rkfQ+Xj132fVaVLw7wCI8C
        0l+g6oVA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMmI1-00D9pM-CA; Wed, 23 Feb 2022 07:42:21 +0000
Date:   Tue, 22 Feb 2022 23:42:21 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tim Murray <timmurray@google.com>,
        Waiman Long <longman@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] f2fs: move f2fs to use reader-unfair rwsems
Message-ID: <YhXlXY28XiG7lVH1@infradead.org>
References: <20220108164617.3130175-1-jaegeuk@kernel.org>
 <YdvoxkAAquI17UbX@infradead.org>
 <a23a3226-95d9-9835-c1c7-2d13f4a1ee16@redhat.com>
 <CAEe=SxnWeK0pSfijPKJSTxBiMgD1Ev69fV3qSTCgWASk0b3vhA@mail.gmail.com>
 <Yd7gVLdHW11TQUAi@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd7gVLdHW11TQUAi@hirez.programming.kicks-ass.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like this patch landed in linux-next despite all the perfectly
reasonable objections.  Jaegeuk, please drop it again.

On Wed, Jan 12, 2022 at 03:06:12PM +0100, Peter Zijlstra wrote:
> On Mon, Jan 10, 2022 at 11:41:23AM -0800, Tim Murray wrote:
> 
> > 1. f2fs-ckpt thread is running f2fs_write_checkpoint(), holding the
> > cp_rwsem write lock while doing so via f2fs_lock_all() in
> > block_operations().
> > 2. Random very-low-priority thread A makes some other f2fs call that
> > tries to get the cp_rwsem read lock by atomically adding on the rwsem,
> > fails and deschedules in uninterruptible sleep. cp_rwsem now has a
> > non-zero reader count but is write-locked.
> > 3. f2fs-ckpt thread releases the cp_rwsem write lock. cp_rwsem now has
> > a non-zero reader count and is not write-locked, so is reader-locked.
> > 4. Other threads call fsync(), which requests checkpoints from
> > f2fs-ckpt, and block on a completion event that f2fs-ckpt dispatches.
> > cp_rwsem still has a non-zero reader count because the low-prio thread
> > A from (2) has not been scheduled again yet.
> > 5. f2fs-ckpt wakes up to perform checkpoints, but it stalls on the
> > write lock via cmpxchg in block_operations() until the low-prio thread
> > A has run and released the cp_rwsem read lock. Because f2fs-ckpt can't
> > run, all fsync() callers are also effectively blocked by the
> > low-priority thread holding the read lock.
> > 
> > I think this is the rough shape of the problem (vs readers holding the
> > lock for too long or something like that) because the low-priority
> > thread is never run between when it is initially made runnable by
> > f2fs-ckpt and when it runs tens/hundreds of milliseconds later then
> > immediately unblocks f2fs-ckpt.
> 
> *urgh*... so you're making the worst case less likely but fundamentally
> you don't change anything.
> 
> If one of those low prio threads manages to block while holding
> cp_rwsem your checkpoint thread will still block for a very long time.
> 
> So while you improve the average case, the worst case doesn't improve
> much I think.
> 
> Also, given that this is a system wide rwsem, would percpu-rwsem not be
> 'better' ? Arguably with the same hack cgroups uses for it (see
> cgroup_init()) to lower the cost of percpu_down_write().
> 
> Now, I'm not a filesystem developer and I'm not much familiar with the
> problem space, but this locking reads like a fairly big problem. I'm not
> sure optimizing the lock is the answer.
> 
> 
---end quoted text---
