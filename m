Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631CA5372F7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 01:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbiE2Xgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 19:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiE2Xgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 19:36:37 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B55DB630A;
        Sun, 29 May 2022 16:36:34 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 4C2A953458E;
        Mon, 30 May 2022 09:36:31 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nvSST-000OUT-Eu; Mon, 30 May 2022 09:36:29 +1000
Date:   Mon, 30 May 2022 09:36:29 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [GIT PULL] xfs: new code for 5.19
Message-ID: <20220529233629.GY1098723@dread.disaster.area>
References: <20220526022053.GY2306852@dread.disaster.area>
 <CAHk-=wg8R2sYVKi7bgwVN8n-exN766PSJwYg+18SLbR=+vQtVA@mail.gmail.com>
 <20220526035317.GI1098723@dread.disaster.area>
 <CAOQ4uxg_O_dC2Le7RZDTaBqtA650jD6BLZE24rpZXx=xpEedkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg_O_dC2Le7RZDTaBqtA650jD6BLZE24rpZXx=xpEedkg@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62940380
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
        a=7-415B0cAAAA:8 a=wNBJl4j-QUBApV6RE_4A:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2022 at 10:32:58AM +0300, Amir Goldstein wrote:
> > > I might wish that your merge commit messages were a bit more
> > > consistent about the merge details ("why and what"), but you are most
> > > definitely not the only one with that, and a number of them are quite
> > > nice (ie the merge of the large extent counters has a nice informative
> > > commit message, as does the rmap speedup one).
> >
> > Those one came from pull requests with informative signed
> > tags. We're trying to move more of our development processes to
> > using signed pull reqs when eveything is done, so this hopefully
> > will happen more often.
> >
> > > And then some of them are the uninformative one-lines that just say
> > > "Merge branch X"
> >
> > Yeah, those are merges from local topic branches where I pulled in
> > individual patches or entire series from the mailing list via 'b4 am
> > -o - <msg_id> | git am -s'. AFAICT there is no way to have this
> > retain the patch series cover letter, which generally contains what
> > I would want to be putting into the merge commit message.
> >
> > I'll keep that in mind for future composes, though I do wish there
> > was an easy way to just have b4/git manage cover letters as part of
> > the topic branch so they can feed into local merge commits just as
> > easily remote pulls do....
> >
> 
> There is.
> I have been hacking on b4 and found many hidden features :)
> 
> b4 am 20220510202800.40339-1-catherine.hoang@oracle.com -n
> xfs-5.19-quota-warn-remove.mbx
> git am -s xfs-5.19-quota-warn-remove.mbx
> git tag -F xfs-5.19-quota-warn-remove.cover xfs-5.19-quota-warn-remove

That's a tag on a commit, not a persistent object associated with a
branch. I've considered this, but if I append a new commit, rebase
the branch, or do anything I normally do with topic branches, then
that tag ends up pointing at the wrong commit or even a non-existent
commit. It just adds another thing to forget/get wrong when managing
topic branches for merge. i.e. it doesn't make things simpler.

As it is, I use guilt for managing the contents of all my git
branches in all my git trees. I already have a local hack in guilt
to use the first commit of a series as the series description/cover
letter. I pass a special flag to 'guilt patchbomb' and it turns the
first commit into the cover letter for editing and sending. With
this, I have an object associated with the topic branch that follows
all operations on the branch (including rebases) and so is always
there in the same place.

However, I can't use such topic branches for merges - the series
description commit needs to be purged and the series rebased before
I merge it. You can see this in this old branch here:

https://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs.git/log/?h=xfs-iunlink-item

In that branch there are actually two description commits:

https://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs.git/commit/?h=xfs-iunlink-item&id=35d3b6ac52b5870484182d476cb253021e44acc5
https://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs.git/commit/?h=xfs-iunlink-item&id=a561cb0e09fa7886d034be0ae94f5f77d327014d

because the second line of development (unlinked inode mods) was
dependent on another set of patches (async inode reclaim).

That's the text and changelog for the cover letter for that specific
line of development. As a "here's a topic branch with all the
changes in it" push, I didn't sanitise them.

I think what I'm going to end up doing is add a 'guilt am' command
that runs b4, extracts the cover letter as an internal guilt file
(in .git/patches/<branch>/series-description) and add a `guilt
series -d [-e]` command to print or edit it directly. Then that file
exists, guilt patchbomb will just pick it up. If I add a `guilt
merge` wrapper then it will get picked up as the merge description
automatically, too...

This way the cover letter follows the topic branch no matter what I
do with the branch once I've downloaded it from the mailing list,
and it doesn't show up in the commit history and hence I can merge
the branches easily.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
