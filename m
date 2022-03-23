Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BE04E564C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 17:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239177AbiCWQ2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 12:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238564AbiCWQ2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:28:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2D0E093
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 09:26:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AE4D617ED
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 16:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B50C340E8;
        Wed, 23 Mar 2022 16:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648052806;
        bh=CuBjkLYRVIIbPFpIa1Vl/F+x4Z7zFyfHbwVgo+ZjRio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GvcXdybUQM9gcIggCekgj5mnNxjvBi72554H//JkbF6fQPFJIgDbDbZPvBnj5z19u
         fZXv1v3djBOYB+hysQsnADJtiCrUJjbv+4BlgCBsVrYcqXlWw/qBxW72kH0j6/EiPM
         JXngEyhQWZqh/wcv1dDYhyu4eeyxG1kTLp0+FQUFSBd4aMKMWILjRBrhgwFb+XWuWE
         BGql5CU7E8s4+tEx3RI300EvwKcbNRDxov5lbxMuDpAn8I3a2AQop4jxZk86Dx6AE0
         I14kSjNfnYcmVaHbh7PCNpgNBoXB/WeeVMbLIcBEWL7AMeOCCPWSZNESvo/gW0Mztt
         eAR6Jo9nyHNAQ==
Date:   Wed, 23 Mar 2022 09:26:44 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tim Murray <timmurray@google.com>,
        Waiman Long <longman@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [GIT PULL] f2fs for 5.18
Message-ID: <YjtKRAgFmBfgU0al@google.com>
References: <YjjihIZuvZpUjaSs@google.com>
 <CAHk-=wgsmvoJFKFWxQ2orEVUOWH1agk9iUNZ=-DFh5OXZL=Ldw@mail.gmail.com>
 <51cded74-3135-eed8-06d3-0b2165e3b379@redhat.com>
 <CAHk-=wi=Xsekgj7zfw_vpOM673CG24vznmz-yx9G05rWSAAYXg@mail.gmail.com>
 <CAEe=Sxmcn5+YUXBQhxDpzZVJu_T6S6+EURDqrP9uUS-PHGyuSg@mail.gmail.com>
 <CAHk-=whGKUyJpi0dTQJjyJxdmG+WCeKkJJyycpOaUW0De17h_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whGKUyJpi0dTQJjyJxdmG+WCeKkJJyycpOaUW0De17h_Q@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/22, Linus Torvalds wrote:
> On Tue, Mar 22, 2022 at 5:34 PM Tim Murray <timmurray@google.com> wrote:
> >
> > AFAICT, what's happening is that rwsem_down_read_slowpath
> > modifies sem->count to indicate that there's a pending reader while
> > f2fs_ckpt holds the write lock, and when f2fs_ckpt releases the write
> > lock, it wakes pending readers and hands the lock over to readers.
> > This means that any subsequent attempt to grab the write lock from
> > f2fs_ckpt will stall until the newly-awakened reader releases the read
> > lock, which depends on the readers' arbitrarily long scheduling
> > delays.
> 
> Ugh.
> 
> So I'm looking at some of this, and you have things like this:
> 
>         f2fs_down_read(&F2FS_I(inode)->i_sem);
>         cp_reason = need_do_checkpoint(inode);
>         f2fs_up_read(&F2FS_I(inode)->i_sem);
> 
> which really doesn't seem to want a sleeping lock at all.
> 
> In fact, it's not clear that it has any business serializing with IO
> at all. It seems to just check very basic inode state. Very strange.
> It's the kind of thing that the VFS layer tends to use te i_lock
> *spinlock* for.

Um.. let me check this i_sem, introduced by
d928bfbfe77a ("f2fs: introduce fi->i_sem to protect fi's info").

OTOH, I was suspecting the major contetion would be
	f2fs_lock_op -> f2fs_down_read(&sbi->cp_rwsem);
, which was used for most of filesystem operations.

And, when we need to do checkpoint, we'd like to block internal operations by
	f2fs_lock_all -> f2fs_down_write(&sbi->cp_rwsem);

So, what I expected was giving the highest priority to the checkpoint thread
by grabbing down_write to block all the other readers.

> 
> And perhaps equally oddly, then when you do f2fs_issue_checkpoint(),
> _that_ code uses fancy lockless lists.
> 
> I'm probably mis-reading it.
> 
>              Linus
