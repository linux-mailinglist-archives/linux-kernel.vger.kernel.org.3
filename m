Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB00456330F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbiGAL7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbiGAL7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:59:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B098823B9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 04:59:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E9D7E1FF6F;
        Fri,  1 Jul 2022 11:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656676768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n1i6a6wqj+/VQ24IactaJpqGxxpT8s+T7RTgNJB5WgU=;
        b=EdDp/Om5y+GSsm4uo77YMP1YS4W8fW0kueRLfPJMUUffB4fvQUh7Tmx5XRFt7wI1AKRqX0
        39lSuDxpdMZoR6lTiiugHDDUT6ZJHiVQKKvNR7zE168W771PSxLi1PjC6rEh10nugg5uSn
        mKdLASyWRoom+0PqSuFo0kh2660gGS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656676768;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n1i6a6wqj+/VQ24IactaJpqGxxpT8s+T7RTgNJB5WgU=;
        b=7q0BV+jlDOxKwSYDbmjL3CuHZsL4tqipCutxkZv8jewH/ojqX515p57usTHYHDBPZslM7b
        NAHJO1J0WPwHOlDA==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BB9D12C141;
        Fri,  1 Jul 2022 11:59:28 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 317F5A063E; Fri,  1 Jul 2022 13:59:28 +0200 (CEST)
Date:   Fri, 1 Jul 2022 13:59:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ioannis Angelakopoulos <iangelak@fb.com>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "jack@suse.com" <jack@suse.com>, "boris@bur.io" <boris@bur.io>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Modeling wait events with Lockdep
Message-ID: <20220701115928.62kr7lpfs4i4ivrt@quack3.lan>
References: <4dc41ba5-f9d4-2d26-fdec-881405029046@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dc41ba5-f9d4-2d26-fdec-881405029046@fb.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu 30-06-22 23:05:07, Ioannis Angelakopoulos wrote:
> I would like to ask some questions regarding modeling waiting for events 
> (i.e the wait_event) in Linux using Lockdep.
> I am trying to model these events in btrfs since there are deadlocks 
> detected involving waiting for events and Lockdep is not currently able 
> to address them (e.g., 
> https://lore.kernel.org/linux-btrfs/cover.1655147296.git.josef@toxicpanda.com/).
> 
> I am very new to Lockdep so I would like to know, what would be the 
> correct way of implementing these models using Lockdep?
>
> I noticed that JBD2 uses a read-write lockdep map. It takes the read 
> lockdep map when it creates a transaction handle and unlocks the read 
> lockdep map when it frees the handle. Also, every time the thread has to 
> wait for resources (e.g., transaction credits) and the handle is not 
> supposed to be alive, the thread locks and unlocks immediately the write 
> lockdep map before the waiting event (maybe I understood something wrong 
> here?).

No this is correct.

> Is this the only Lockdep model that can be used for these 
> waiting events?

We've used this model because what jbd2 with transaction handles is that
essentially every existing journal handle is a reference to the running
transaction - this reference is modeled by 'read acquisition' - and
transaction commit and consequently places waiting for more journal space
has to wait for all outstanding handles - this wait is modeled by the
'write acquisition'.

But certainly there are different wait-wake schemes that could be modeled
differently with lockdep.

> For your reference, here are 2 examples that we are trying to annotate 
> with Lockdep and we would like to know if we are on the correct track.
> 
> In the first example it makes sense to use the JBD2 model, however we 
> are not sure how to apply the model in the second case. The comments 
> indicate our concerns.
> 
> ------------------------------
> Simple Case:
> 
> TA
> rwsem_acquire_read(lockdep_map);
> cond=false
> do_work()
> cond=true
> rwsem_release_read(lockdep_map);
> signal(w)
> 
> TB
> rwsem_acquire(lockdep_map);
> rswem_release(lockdep_map);
> wait_event(w, cond==true)
> 
> Advanced Case:
> 
> TA
> rwsem_acquire_read(lockdep_map)
> cond=false
> // exits while holding the lock
> 
> TB
> cond=true
> rwsem_release_read(lockdep_map) // We do not know that we hold the lock
> signal(w)
> 
> TC
> rwsem_acquire(lockdep_map);
> rswem_release(lockdep_map);
> wait_event(w, cond==true)

So this is difficult to track with lockdep because lockdep supports only
task-local locking so when "resource ownership" moves between tasks things
are difficult to track. How we usually do this (e.g. we did something
similar in fs/aio.c where filesystem freeze protection is acquired on IO
submission and we release it on IO completion from a different task /
context) is that we do:

TA
rwsem_acquire_read(lockdep_map)
cond=false
// push this as far as it is reasonably possible in TA to allow lockdep to
// track what needs to be done in TA while waiting for TB to do work
rwsem_release_read(lockdep_map)

TB
// Tell lockdep TB has inherited the resource, push this as early as
// reasonably possible to allow lockdep track most dependencies
rwsem_acquire_read(lockdep_map)
cond=true
signal(w)
rwsem_release_read(lockdep_map)

It is not perfect and some dependencies may be missed but it's better than
nothing.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
