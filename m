Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4223D534985
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 05:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344669AbiEZDx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 23:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbiEZDxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 23:53:23 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D509BDA27;
        Wed, 25 May 2022 20:53:21 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id B202B5345DA;
        Thu, 26 May 2022 13:53:20 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nu4Yn-00GTx8-PL; Thu, 26 May 2022 13:53:17 +1000
Date:   Thu, 26 May 2022 13:53:17 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-xfs <linux-xfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [GIT PULL] xfs: new code for 5.19
Message-ID: <20220526035317.GI1098723@dread.disaster.area>
References: <20220526022053.GY2306852@dread.disaster.area>
 <CAHk-=wg8R2sYVKi7bgwVN8n-exN766PSJwYg+18SLbR=+vQtVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg8R2sYVKi7bgwVN8n-exN766PSJwYg+18SLbR=+vQtVA@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=628ef9b1
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=7-415B0cAAAA:8 a=VwQbUJbxAAAA:8
        a=AZJ49GfAMOZNuDr3qUMA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
        a=AjGcO6oz07-iQ99wixmX:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 07:56:31PM -0700, Linus Torvalds wrote:
> On Wed, May 25, 2022 at 7:21 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > Can you please pull the XFS updates for 5.19 from the tag listed
> > below? It merges cleanly with the TOT kernel I just pulled a couple
> > of minutes ago, though the diffstat I got on merge:
> >
> > 105 files changed, 4862 insertions(+), 2773 deletions(-)
> >
> > is slightly different to the diffstat the pull request generated.
> 
> Funky. I get the same diffstat that you list below in the pull
> request, not the above.
> 
> Different diff algorithms do get different results, so the actual line
> numbers vary a bit with the default myers vs minimal vs patience vs
> histogram algorithms. But while that changes line numbers, it
> shouldn't then change the actual number of files...
> 
> I wonder what the difference is, but I'm not going to delve into it
> further since what I see matches the pull request and it all looks
> fine.
> 
> I do notice that if I use
> 
>    git diff -C10 ..
> 
> to make git more eagerly find file copies, I get
> 
>  [...]
>  104 files changed, 4444 insertions(+), 3125 deletions(-)
>  copy fs/xfs/{xfs_bmap_item.c => xfs_attr_item.c} (13%)
>  create mode 100644 fs/xfs/xfs_attr_item.h
> 
> and adding "-B/10%" to make git also look for rewrites (ie files that
> might be better shown as "remove file and then re-add") gives:
> 
>  [..]
>  104 files changed, 5449 insertions(+), 4130 deletions(-)
>  rewrite fs/xfs/libxfs/xfs_attr.c (43%)
>  copy fs/xfs/{xfs_bmap_item.c => xfs_attr_item.c} (13%)
>  create mode 100644 fs/xfs/xfs_attr_item.h
>  rewrite fs/xfs/xfs_log.h (31%)
>  rewrite fs/xfs/xfs_message.h (30%)
> 
> so it might be something along those lines where our git configs
> differ. I couldn't get it to give "105 files", though.
> 
> Not important. I just got curious.

Weird.

> And it might also be as simple as you just having had something else
> in your tree at the same time, that you didn't want to send, but
> forgot about when you did the test-merge. That would be the simplest
> explanation..

$ git reset --hard origin/master
Updating files: 100% (6994/6994), done.
HEAD is now at d7227785e384 Merge tag 'sound-5.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
$ git merge xfs-5.19-for-next 
Auto-merging fs/xfs/xfs_file.c
Auto-merging fs/xfs/xfs_log_cil.c
Auto-merging fs/xfs/xfs_super.c
Merge made by the 'ort' strategy.
 fs/xfs/Makefile                    |    1 +
....
 fs/xfs/xfs_xattr.c                 |    2 +-
 105 files changed, 4862 insertions(+), 2773 deletions(-)
 create mode 100644 fs/xfs/xfs_attr_item.c
 create mode 100644 fs/xfs/xfs_attr_item.h
$

> > If I've made any mistakes or done stuff that is considered wrong or
> > out of date, let me know and I'll fix them up - it's been a while
> > since I built a tree for upstream merge.
> 
> It all looks fine.
> 
> I might wish that your merge commit messages were a bit more
> consistent about the merge details ("why and what"), but you are most
> definitely not the only one with that, and a number of them are quite
> nice (ie the merge of the large extent counters has a nice informative
> commit message, as does the rmap speedup one).

Those one came from pull requests with informative signed
tags. We're trying to move more of our development processes to
using signed pull reqs when eveything is done, so this hopefully
will happen more often.

> And then some of them are the uninformative one-lines that just say
> "Merge branch X"

Yeah, those are merges from local topic branches where I pulled in
individual patches or entire series from the mailing list via 'b4 am
-o - <msg_id> | git am -s'. AFAICT there is no way to have this
retain the patch series cover letter, which generally contains what
I would want to be putting into the merge commit message.

I'll keep that in mind for future composes, though I do wish there
was an easy way to just have b4/git manage cover letters as part of
the topic branch so they can feed into local merge commits just as
easily remote pulls do....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
