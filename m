Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA5A4E5A9F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 22:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344892AbiCWV0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 17:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344878AbiCWV0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 17:26:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D577C161
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 14:25:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0EBE616DD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 21:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B2AC340ED;
        Wed, 23 Mar 2022 21:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648070721;
        bh=UNfONMtlF855BsJew0qEGgqnLnCWd3MQfe8qfpIICXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SY0pUtLwEFmemMc6BZVriNke9zLCOi/pYPhuWuejyDUBd70A8xAnFJbqzgllZ6rT5
         HoCLYgkEjppmpltqvKChQT37aZgltqQXNv2iWUrVVS3vSR+/tTJmWQ8vZh7RAxDcOz
         3sJeUqLuSZShT/0AGNS+DKzuT8jolHvE+e8KqCq2n3yIQWnbkMAVwEbe/DQSe1PUKP
         QAlDU25zXQktF1giyAYmRkOqiOxe68tKJZyfleBt3/VrDB7DoglaKeKCZ93+NGalht
         /wSk+1BLdeDsXHv7uD+ld6Jjy21m28vAMEGeGKiAUrlxHxyRMOWD2t68D9BujI4gYf
         CtD4s/qFa7y0w==
Date:   Wed, 23 Mar 2022 14:25:19 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [GIT PULL] f2fs for 5.18
Message-ID: <YjuQP/L3EnAF/NE8@google.com>
References: <YjjihIZuvZpUjaSs@google.com>
 <CAHk-=wgsmvoJFKFWxQ2orEVUOWH1agk9iUNZ=-DFh5OXZL=Ldw@mail.gmail.com>
 <YjrNRpbo/i3tgbAA@infradead.org>
 <YjtPUec8jiqUXGuf@google.com>
 <5acaaf61-5419-178d-c805-62f979697653@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5acaaf61-5419-178d-c805-62f979697653@redhat.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23, Waiman Long wrote:
> On 3/23/22 12:48, Jaegeuk Kim wrote:
> > On 03/23, Christoph Hellwig wrote:
> > > On Tue, Mar 22, 2022 at 10:22:50AM -0700, Linus Torvalds wrote:
> > > > On Mon, Mar 21, 2022 at 1:39 PM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> > > > > In this cycle, f2fs has some performance improvements for Android workloads such
> > > > > as using read-unfair rwsems [...]
> > > > I've pulled this, but that read-unfair rwsem code looks incredibly
> > > > dodgy. Doing your own locking is always a bad sign, and it ahs
> > > > traditionally come back to bite us pretty much every time. At least it
> > > > uses real lock primitives, just in a really odd way.
> > > FYI, Peter and I both pointed this out when the patches were posted
> > > and NAKed the patch, but the feedback was ignored.
> > Christoph, I proposed,
> > 
> > "I've been waiting for a generic solution as suggested here. Until then, I'd like
> > to keep this in f2fs *only* in order to ship the fix in products. Once there's
> > a right fix, let me drop or revise this patch again."
> > 
> > https://lore.kernel.org/linux-f2fs-devel/YhZzV11+BlgI1PBd@google.com/
> > 
> I suspect f2fs may also need the 617f3ef95177 ("locking/rwsem: Remove reader
> optimistic spinning") to give higher priority to writer. Please let me know
> the test result when you are able to test v5.15 LTS to see if these commits
> are able to address the f2fs issue.

Sure, I'll keep an eye on it, but next kernel is likely to be applied to the
products in next year. It may take some time. :(

> 
> I have some ideas of making a reader-unfair rwsem, but that requires either
> the introduction of a set of new down_read() variants or keeping the unfair
> state in the rwsem itself. I would like to make sure that there is really a
> need for such a thing before working on it.
> 
> Cheers,
> Longman
> 
