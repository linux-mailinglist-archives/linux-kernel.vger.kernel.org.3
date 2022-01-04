Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FBC483A8D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 03:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbiADCXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 21:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiADCXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 21:23:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844E6C061761;
        Mon,  3 Jan 2022 18:23:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BA6BB81097;
        Tue,  4 Jan 2022 02:23:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00834C36AEE;
        Tue,  4 Jan 2022 02:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641263008;
        bh=yo9K4eq2nWadi9n6DwMwrPKCkaxagJTXM9A8ulfkQvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c8M83bGTv8L2s2HzYnVqk+GSjNh1zjYBlrwZAwAl5Ip4esLJANiokzg1EzmzIgRZ0
         KXP56vnrJ8D7Gv7tRnBLnlaJE/a1PmDwiSY3f6CNW9Fu+u7BbQRs90H8ehdgBLbvpN
         JrTYCS96SJQe8LEzUOuirVHMsQmXfJHWpE8Jkha+9azmYCCssgCbYavG+ovUuqdhDe
         MSPe1JRMvZqFCgFbGHx/5WyVGtdHNQJwtJb3nbZnV33i40SuvjjYMnzpOt7152aYjY
         6JiZ9qu+s6wsi8kiB5s5oAb36QF7jpKsfg96SuPGDgyUR80K8EtRNK4zgk8qmrS6Dn
         lsV0x0sKwLvMA==
Date:   Mon, 3 Jan 2022 18:23:27 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Hao Sun <sunhao.th@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs@vger.kernel.org
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 xlog_cil_commit
Message-ID: <20220104022327.GD31606@magnolia>
References: <CACkBjsbaCmZK2wUExMqu_KKBr2jnEi-T6iEr=vzw4YS5g5DOOQ@mail.gmail.com>
 <20211006154327.GH24307@magnolia>
 <20211006222749.GE54211@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006222749.GE54211@dread.disaster.area>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 09:27:49AM +1100, Dave Chinner wrote:
> On Wed, Oct 06, 2021 at 08:43:27AM -0700, Darrick J. Wong wrote:
> > On Wed, Oct 06, 2021 at 04:14:43PM +0800, Hao Sun wrote:
> > > Hello,
> > > 
> > > When using Healer to fuzz the latest Linux kernel, the following crash
> > > was triggered.
> > > 
> > > HEAD commit: 0513e464f900 Merge tag 'perf-tools-fixes-for-v5.15-2021-09-27'
> > > git tree: upstream
> > > console output:
> > > https://drive.google.com/file/d/1vm5fDM220kkghoiGa3Aw_Prl4O_pqAXF/view?usp=sharing
> > > kernel config: https://drive.google.com/file/d/1Jqhc4DpCVE8X7d-XBdQnrMoQzifTG5ho/view?usp=sharing
> > > 
> > > Sorry, I don't have a reproducer for this crash, hope the symbolized
> > > report can help.
> > > If you fix this issue, please add the following tag to the commit:
> > > Reported-by: Hao Sun <sunhao.th@gmail.com>
> > 
> > So figure out how to fix the problem and send a patch.  You don't get to
> > hand out fixit tasks like you're some kind of manager for people you
> > don't employ.
> 
> I fully agree with this Darrick but, OTOH, the cynical, jaded
> engineer in me says "I don't think people that run bots and
> copy/paste their output to mailing lists have the capability to fix
> the problems the bots find."

They gotta learn to level up (or leave us alone) somehow...

> Quite frankly, it's even more of a waste of our time trying to
> review crap patches and make suggestions to fix it and then going
> around the review loop 15 times getting nowhere like we have in teh
> past.
> 
> So, kvmalloc() sucks dogs balls, as I pointed out in this recent
> patch in the intent whiteouts series:
> 
> https://lore.kernel.org/linux-xfs/20210902095927.911100-8-david@fromorbit.com/
> 
> Because of the crap implementation of kvmalloc(), we can't just pass
> __GFP_NOFAIL because that will cause it to try to run
> kmalloc_node(__GFP_NORETRY | __GFP_NOFAIL) and that will cause heads
> to go all explodey. Not to mention that kvmalloc won't even allow
> GFP_NOFS to be passed and still actually do the vmalloc() fallback.
> 
> So, basically, we've got to go back to doing an open coded kvmalloc
> loop here that cannot fail. Because kvmalloc can fail and we can't
> tell it that it must succeed or die trying.
> 
> That's what the above patch does - gets rid of the garbage kvmalloc
> direct reclaim -> memory compaction behaviour, and wraps it in a
> loop so that the fail-fast memory allocation semantics it uses does
> not end up in a shadow buffer allocation failure.
> 
> So, yeah, I've already fixed this in my trees....

Er, do you want me to queue that patch for 5.17?  I had assumed it was
only really needed for allison's patches, but I don't mind pushing it
in sooner.

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
