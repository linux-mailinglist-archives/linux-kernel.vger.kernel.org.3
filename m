Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329A349B3DB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 13:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447801AbiAYMUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 07:20:19 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:53356 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354562AbiAYMR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 07:17:58 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 770941F380;
        Tue, 25 Jan 2022 12:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643113072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hVqHXUz3Jk2sVZPobpwss8wYXdEwQhEkUDfTqU6jT1c=;
        b=tuKwVeRGyMDb2VZ7lsq2tT/lEEKkXD4V1KG7HhiPQXYjM1MMrNCHHZ7auGcys1mCftKDGC
        s0LWiIIeHKRISWuaIq2GSqcHD4RQYF2b627WVXxihUHuHddAruSb/ORBGoMtaYMNQ3u+JP
        4v1SxOFrZZ3r+QYYJk3EgvhnrmZSj20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643113072;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hVqHXUz3Jk2sVZPobpwss8wYXdEwQhEkUDfTqU6jT1c=;
        b=VCZjPdrGnM7d1HUGXoXQd3hRCeAU1h0LWuD+W314V+Qhasb2GjNlTWFT4KaIBmvzXw7IVA
        cUB2oZsAwISCrDCg==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 60066A3B8A;
        Tue, 25 Jan 2022 12:17:52 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8EB67A05E6; Tue, 25 Jan 2022 13:17:46 +0100 (CET)
Date:   Tue, 25 Jan 2022 13:17:46 +0100
From:   Jan Kara <jack@suse.cz>
To:     Richard Palethorpe <rpalethorpe@suse.de>
Cc:     Jan Kara <jack@suse.cz>, Cyril Hrubis <chrubis@suse.cz>,
        Miklos Szeredi <mszeredi@redhat.com>, lkp@intel.com,
        Chi Wu <wuchi.zero@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@fb.com>,
        lkp@lists.01.org, kernel test robot <oliver.sang@intel.com>,
        Sedat Dilek <sedat.dilek@gmail.com>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ltp@lists.linux.it
Subject: Re: [LTP] [mm/page]  ab19939a6a: ltp.msync04.fail
Message-ID: <20220125121746.wrs4254pfs2mwexb@quack3.lan>
References: <20210912123429.GA25450@xsang-OptiPlex-9020>
 <YT8HqsXsHFeMdDxS@yuki>
 <20210917121331.GA14905@quack2.suse.cz>
 <87o840xiel.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o840xiel.fsf@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25-01-22 09:27:30, Richard Palethorpe wrote:
> Hello,
> 
> Jan Kara <jack@suse.cz> writes:
> 
> > On Mon 13-09-21 10:11:22, Cyril Hrubis wrote:
> >> Hi!
> >> > FYI, we noticed the following commit (built with gcc-9):
> >> > 
> >> > commit: ab19939a6a5010cba4e9cb04dd8bee03c72edcbd ("mm/page-writeback: Fix performance when BDI's share of ratio is 0.")
> >> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >> > 
> >> > 
> >> > in testcase: ltp
> >> > version: ltp-x86_64-14c1f76-1_20210907
> >> > with following parameters:
> >> > 
> >> > 	disk: 1HDD
> >> > 	fs: xfs
> >> > 	test: syscalls-03
> >> > 	ucode: 0xe2
> >> > 
> >> > test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> >> > test-url: http://linux-test-project.github.io/
> >> 
> >> The msync04 test formats a device with a diffrent filesystems, for each
> >> filesystem it maps a file, writes to the mapped page and the checks a
> >> dirty bit in /proc/kpageflags before and after msync() on that page.
> >> 
> >> This seems to be broken after this patch for ntfs over FUSE and it looks
> >> like the page does not have a dirty bit set right after it has been
> >> written to.
> >> 
> >> Also I guess that we should increase the number of the pages we dirty or
> >> attempt to retry since a single page may be flushed to the storage if we
> >> are unlucky and the process is preempted between the write and the
> >> initial check for the dirty bit.
> >
> > Yes, I agree. The most likely explanation I see for this is that the
> > identified commit results in waking flush worker earlier so it may now
> > succeed in cleaning the page before get_dirty_bit() in the LTP testcase
> > manages to see it. This is a principial race in this testcase, you can
> > perhaps make it less likely but not completely fix it AFAICT.
> 
> If the dirty bit is not set, then I guess dropping the pagecache will
> not write anything to the underlying storage?

Correct.

> So when we see no dirty bit is set, we can drop the pagecache then read
> the file to check the value was written correctly? If so then we can
> exit with TCONF saying msync couldn't be tested because the storage was
> written to too quickly.

Yes, that would work.

> Also I guess we can optimize the get_dirty_bit function. It's doing 3
> syscalls instead of 1 AFAICT.

And this could reduce the race window. So nice I guess.

But IMHO what would be a more sensible test is that msync is indeed persisting
the data. So something like: mmap file, write to mmap, msync, abort fs,
mount fs again, check the data is there. We do have framework for stuff
like this in fstests (but we don't test msync AFAIK, only fsync), not sure
if LTP has something for this as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
