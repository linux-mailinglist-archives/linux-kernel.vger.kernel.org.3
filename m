Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A1D4BB03D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 04:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiBRDZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 22:25:51 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiBRDZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 22:25:50 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5365F4F441
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 19:25:35 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKttj-002drd-3Z; Fri, 18 Feb 2022 03:25:31 +0000
Date:   Fri, 18 Feb 2022 03:25:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/7] kernfs: Introduce hashed rw-sem to replace per-fs
 kernfs_rwsem.
Message-ID: <Yg8Rq2H1C1ihFqds@zeniv-ca.linux.org.uk>
References: <20220214120322.2402628-1-imran.f.khan@oracle.com>
 <20220214120322.2402628-7-imran.f.khan@oracle.com>
 <YgxXh3clQqpxUPba@zeniv-ca.linux.org.uk>
 <bfdef75d-4343-2734-2723-d8546df37c69@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfdef75d-4343-2734-2723-d8546df37c69@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 03:57:09PM +1100, Imran Khan wrote:

> Agree. I missed the point of changing parent during wait of rwsem. Could
> you please let me know if following approach is acceptable in this case:
> 
> 1. Note kn->parent
> 2. down_write_
> 3. After acquiring the rwsems check if current kn->parent is same as the
> earlier noted one and if so proceed otherwise invoke down_write_ again
> as per current kn->parent.
> 
> Once we have taken the rwsems and found that kn->parent did not change
> during wait we can proceed safely till corresponding up_write_

Maybe...  TBH, kernfs_remove_ns() calling conventions suck; "move this
(wherever it is) there under that name", especially combined with
topology-modifying moves, makes life very unpleasant for callers who
want to use it safely.  And I'm not at all sure they manage (or care to)
use it safely...

There are very few sources of cross-directory moves in the entire system.
One is cross-directory cgroup rename(2) (already serialized on per-fs basis
on VFS level), another is device_move().  Which is uncommon (5 callers
in the entire system, one in drivers/media/usb/pvrusb2/, another in
drivers/s390/cio, 3 more in net/bluetooth) and AFAICS unsafe wrt e.g.
kobject_get_path().  Not for kernfs data structures - unsafe use of
kobject->parent pointers.  I could be wrong - that's just from some grepping
around, but it looks like a use-after-free race in the best case.

So changes of kn->parent can be considered a very cold path.  Just make sure
you pin the damn thing, so it won't disapper away from under you while you
are grabbing the locks.

> I have run my tests with lockdep enabled as well. Could you please let
> me know if there is something that can be done as proof of correctness.
> For sanity of patches, my current tests include LTP sysfs tests, CPU
> hotplugging and cgroup access/creation/removal. I am booting oracle
> linux as well which involves cgroupfs access(via systemd). If you could
> suggest some other tests I can execute those as well.
> 
> Also regarding locking rules, I am not sure where to mention it. If I
> put accompanying comments, at all the places where I am taking hashed
> rwsems, to explain why lock corresponding to a node or corresponding to
> its parent is being taken, will that be enough as description of locking
> rules.

A separate text, along the lines of "foo->bar is modified only when we
are holding this, this and that; any of those is sufficient to stabilize
it.  Locking order is such-and-such.  Such-and-such predicate is guaranteed
to be true when you acquire this lock and must be true again by the time
you drop it.", etc.  Some of that might go into the comments somewhere
in source (e.g. when it's about data structures dealt with only one
file, or in the header where the data structures are declared), some -
in a separate text, perhaps in fs/kernfs/, perhaps in Documentation/filesystems/)

And, of course, there's the cover letter of series and commit messages.

> > I agree that sysfs locking had always been an atrocity - "serialize
> > everything, we can't be arsed to think of that" approach had been there
> > from the day one.  However, that's precisely the reason why replacement
> > needs a very careful analysis.  For all I know, you might've done just
> > that, but you are asking reviewers to reproduce that work independently.
> > Or to hope that you've gotten it right and nod through the entire thing.
> > Pardon me, but I know how easy it is to miss something while doing that
> > kind of work - been there, done that.
> 
> I understand your concern but I am not asking reviewers to reproduce
> this work independently :). If I can get to know what things can
> be/should be tested further in this regard, I can do those tests.
> Since the start of this work, I have been also running my tests with
> lockdep and KASAN enabled as well and those tests have flagged some
> issues which I have addressed.
> 
> I will certainly address your review comments in next version but in the
> meantime if you have some suggestions regarding testing or description
> of locking rules, please let me know.

Tests are useful, but if we can't reason about the behaviour of code...
