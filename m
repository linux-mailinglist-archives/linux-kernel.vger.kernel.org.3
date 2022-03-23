Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259BF4E56E5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 17:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245565AbiCWQuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 12:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245566AbiCWQt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:49:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A80BE27
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 09:48:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8BFBB81F67
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 16:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312B9C340E8;
        Wed, 23 Mar 2022 16:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648054099;
        bh=KZysVJrReQA7i1Z1nRSDq4ryI+V0LIK35Q/WCAy5knM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kp0Ve9OH3/g0gQycRRJwUAl727z9uGUeetTB8IEQo4X9sqVNZ3Q2cZswd8Ncp9YFs
         l0lIZJoQGYohEDJjw2V7mkP65cBS/azJzO9PXy+q0YaCzY+Sp6xRBVHArVASk6PDqa
         R24FtNd2pjlMiUWtVeX/adzRoPj/xJqWx6KWT15EMq2UiTI5Dg6kaX2t0GpRvXbgC1
         0A7suf+GxwDWZKyioMW7Vwl4QxmE3VcoHG0DCpkKmF+9KxWCl9F7//FlOr0RPO6KDH
         wqdoJuz0Tnm5Gm0leMonwMHRwv8niqJrlvjRnm4fHR4ZxTgVQhMP6d/y0VBd9DCuuF
         En/iOcQ7w/yNA==
Date:   Wed, 23 Mar 2022 09:48:17 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [GIT PULL] f2fs for 5.18
Message-ID: <YjtPUec8jiqUXGuf@google.com>
References: <YjjihIZuvZpUjaSs@google.com>
 <CAHk-=wgsmvoJFKFWxQ2orEVUOWH1agk9iUNZ=-DFh5OXZL=Ldw@mail.gmail.com>
 <YjrNRpbo/i3tgbAA@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjrNRpbo/i3tgbAA@infradead.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23, Christoph Hellwig wrote:
> On Tue, Mar 22, 2022 at 10:22:50AM -0700, Linus Torvalds wrote:
> > On Mon, Mar 21, 2022 at 1:39 PM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> > >
> > > In this cycle, f2fs has some performance improvements for Android workloads such
> > > as using read-unfair rwsems [...]
> > 
> > I've pulled this, but that read-unfair rwsem code looks incredibly
> > dodgy. Doing your own locking is always a bad sign, and it ahs
> > traditionally come back to bite us pretty much every time. At least it
> > uses real lock primitives, just in a really odd way.
> 
> FYI, Peter and I both pointed this out when the patches were posted
> and NAKed the patch, but the feedback was ignored.

Christoph, I proposed,

"I've been waiting for a generic solution as suggested here. Until then, I'd like
to keep this in f2fs *only* in order to ship the fix in products. Once there's
a right fix, let me drop or revise this patch again."

https://lore.kernel.org/linux-f2fs-devel/YhZzV11+BlgI1PBd@google.com/
