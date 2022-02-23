Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD1D4C1A2C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 18:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243511AbiBWRsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 12:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243523AbiBWRsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 12:48:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3AD1AD80
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 09:48:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 076EFB81FE7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 17:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FF5C340EC;
        Wed, 23 Feb 2022 17:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645638489;
        bh=1xDX2DoP/sSqEDn7SnmAcFIOAmtI6AhwaDrx27SiKAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AtTbN93mKgAaUD6y9AUZ6pOJajHs3CjxeaMjc8wl9DHeIB5ZDQhcoBcLSjL4dqtPc
         1n2r2n4n7WpOaLIrurD/x+Tj7q3ONa0NiWgymKwnP477PrUXigyIIjm7zYt2A/N0ky
         mAVXwCzTNJkKelE314XUtXWSENJvpslCS17ZGfxUijW/mOz4zLn4rphh3/+xYPkePI
         H2aCKsydVOsvIeHb+1hwBTyUAPYffeTs4FqkUW80dXJbz0Oi/bP4Nbale5t4/YuYln
         TvFPWJAECazr2yI2XuUnXrc20YOhyW3wmp/5ObJIHo/8C7eZYLEmPZ2fmH84+YLrOD
         6BvLKZJyLOeqQ==
Date:   Wed, 23 Feb 2022 09:48:07 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Tim Murray <timmurray@google.com>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] f2fs: move f2fs to use reader-unfair rwsems
Message-ID: <YhZzV11+BlgI1PBd@google.com>
References: <20220108164617.3130175-1-jaegeuk@kernel.org>
 <YdvoxkAAquI17UbX@infradead.org>
 <a23a3226-95d9-9835-c1c7-2d13f4a1ee16@redhat.com>
 <CAEe=SxnWeK0pSfijPKJSTxBiMgD1Ev69fV3qSTCgWASk0b3vhA@mail.gmail.com>
 <Yd7gVLdHW11TQUAi@hirez.programming.kicks-ass.net>
 <YhXlXY28XiG7lVH1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhXlXY28XiG7lVH1@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22, Christoph Hellwig wrote:
> It looks like this patch landed in linux-next despite all the perfectly
> reasonable objections.  Jaegeuk, please drop it again.

I've been waiting for a generic solution as suggested here. Until then, I'd like
to keep this in f2fs *only* in order to ship the fix in products. Once there's
a right fix, let me drop or revise this patch again.

> 
> On Wed, Jan 12, 2022 at 03:06:12PM +0100, Peter Zijlstra wrote:
> > On Mon, Jan 10, 2022 at 11:41:23AM -0800, Tim Murray wrote:
> > 
> > > 1. f2fs-ckpt thread is running f2fs_write_checkpoint(), holding the
> > > cp_rwsem write lock while doing so via f2fs_lock_all() in
> > > block_operations().
> > > 2. Random very-low-priority thread A makes some other f2fs call that
> > > tries to get the cp_rwsem read lock by atomically adding on the rwsem,
> > > fails and deschedules in uninterruptible sleep. cp_rwsem now has a
> > > non-zero reader count but is write-locked.
> > > 3. f2fs-ckpt thread releases the cp_rwsem write lock. cp_rwsem now has
> > > a non-zero reader count and is not write-locked, so is reader-locked.
> > > 4. Other threads call fsync(), which requests checkpoints from
> > > f2fs-ckpt, and block on a completion event that f2fs-ckpt dispatches.
> > > cp_rwsem still has a non-zero reader count because the low-prio thread
> > > A from (2) has not been scheduled again yet.
> > > 5. f2fs-ckpt wakes up to perform checkpoints, but it stalls on the
> > > write lock via cmpxchg in block_operations() until the low-prio thread
> > > A has run and released the cp_rwsem read lock. Because f2fs-ckpt can't
> > > run, all fsync() callers are also effectively blocked by the
> > > low-priority thread holding the read lock.
> > > 
> > > I think this is the rough shape of the problem (vs readers holding the
> > > lock for too long or something like that) because the low-priority
> > > thread is never run between when it is initially made runnable by
> > > f2fs-ckpt and when it runs tens/hundreds of milliseconds later then
> > > immediately unblocks f2fs-ckpt.
> > 
> > *urgh*... so you're making the worst case less likely but fundamentally
> > you don't change anything.
> > 
> > If one of those low prio threads manages to block while holding
> > cp_rwsem your checkpoint thread will still block for a very long time.
> > 
> > So while you improve the average case, the worst case doesn't improve
> > much I think.
> > 
> > Also, given that this is a system wide rwsem, would percpu-rwsem not be
> > 'better' ? Arguably with the same hack cgroups uses for it (see
> > cgroup_init()) to lower the cost of percpu_down_write().
> > 
> > Now, I'm not a filesystem developer and I'm not much familiar with the
> > problem space, but this locking reads like a fairly big problem. I'm not
> > sure optimizing the lock is the answer.
> > 
> > 
> ---end quoted text---
