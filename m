Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B28853A938
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 16:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354851AbiFAO33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 10:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354673AbiFAO3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:29:16 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A778AF599
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 07:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=7cBQ5UAi34wf6hVucTSFDDQUv/4kX0jsV9pUciZ6rdI=; b=v/Oug87JxQcoMZTq3LO5us+JPV
        3kAT9ABt6auUcZ2aaPD7rpo39mgPpZgel1sOdkfx9PO2Z9TsJCUMa+7QJneNadzG2E3d8Oe2lVYmQ
        09l1oS8AX0ksw0sHQN5Hjq5vCtfhtFOibWgqS53lIGYAh7zkLIZtQe8E+fZuRInWfLjk0wUAYv4cv
        U8SNd58hPLmxua+mGLhJarCB1RVjI35R5ec9OheLiKLz+B475BbYrshD+isfSMzQooixfKz2YbLZK
        oqYz0Hs7AvGkeoMJm/cPiCtSc6G+qQVQmGFji+dRDhh5CEd2yYGABpheeoXZo8DOyRSUkrTR7ow3r
        8nZP1F+5Qj3sxQ+yBsQaB9t67MNOzg90yA9Dg1ehiAhoe689MF3Li8y9/HMV8fjfSOMsW2k8pnlQg
        tttTPqfEHElnMb0/WreuE2VsF5ohnugk8shS8E5NvYa18XeD0WJCBs2rBQIIO425yZHDKLN+e0UTc
        GFSwZVrpCI5CsZBXWe1GV+mJiAiPsj7qdLmvLmtzIcxmyxlk3RSLBgnsJ/NgjA4ma+VhXSHprMUlB
        Y3T00gV6PjEyyBuPOHMYAF27b0TcWuakKDz2DTZ1c5DWcXAruiueGfWH3b1Fh1rE8vwts1os4ConN
        ErRRwlqM77qI6b8CVzTQKUQhguvEJFJlCqdGZqNYM=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jianyong Wu <jianyong.wu@arm.com>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] 9p: Fix refcounting during full path walks for fid lookups
Date:   Wed, 01 Jun 2022 16:28:49 +0200
Message-ID: <1849605.JvGbLJQp6r@silver>
In-Reply-To: <20220531142829.GA6868@sequoia>
References: <20220527000003.355812-1-tyhicks@linux.microsoft.com>
 <43525959.9j6oIFhYhY@silver> <20220531142829.GA6868@sequoia>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dienstag, 31. Mai 2022 16:28:29 CEST Tyler Hicks wrote:
> On 2022-05-30 19:14:43, Christian Schoenebeck wrote:
> > On Freitag, 27. Mai 2022 01:59:59 CEST Tyler Hicks wrote:
> > > Decrement the refcount of the parent dentry's fid after walking
> > > each path component during a full path walk for a lookup. Failure to do
> > > so can lead to fids that are not clunked until the filesystem is
> > > 
> > > unmounted, as indicated by this warning:
> > >  9pnet: found fid 3 not clunked
> > 
> > That explains why I saw so many fids not being clunked with recent Linux
> > kernel versions while doing some 9p protocol debugging with QEMU recently.
> 
> In addition to this refcounting bug, there's another one that I noticed
> while running fstests. My series does not fix it and I haven't had a
> chance to look into it more. The generic/531 test triggers it.
> 
>  https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/tests/generic/5
> 31
> > > The improper refcounting after walking resulted in open(2) returning
> > > -EIO on any directories underneath the mount point when using the virtio
> > > transport. When using the fd transport, there's no apparent issue until
> > > the filesytem is unmounted and the warning above is emitted to the logs.
> > 
> > Actually I never saw that open() = -EIO error. Do you have a reproducer?
> 
> The reproducer that I have is binary only (fairly large and runs a bunch
> of different tests) and is used to regression test the Windows Subsystem
> for Linux 2 (WSL2) host <-> guest filesystem sharing. Now that I think
> about it, I'm not sure if the open() = -EIO error happens with other 9p
> servers.
> 
> I can try to tease out the exact sequence of filesystem operations from
> this test binary but it might take me a bit. It looks like it has to do
> with switching UIDs, which could make sense because different users may
> not be connected to the filesystem yet (the conditional block that does
> p9_client_attach() and v9fs_fid_add()).
> 
> > > In some cases, the user may not yet be attached to the filesystem and a
> > > new root fid, associated with the user, is created and attached to the
> > > root dentry before the full path walk is performed. Increment the new
> > > root fid's refcount to two in that situation so that it can be safely
> > > decremented to one after it is used for the walk operation. The new fid
> > > will still be attached to the root dentry when
> > > v9fs_fid_lookup_with_uid() returns so a final refcount of one is
> > > correct/expected.
> > > 
> > > Fixes: 6636b6dcc3db ("9p: add refcount to p9_fid struct")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > > ---
> > > 
> > >  fs/9p/fid.c | 17 +++++------------
> > >  1 file changed, 5 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/fs/9p/fid.c b/fs/9p/fid.c
> > > index 79df61fe0e59..5a469b79c1ee 100644
> > > --- a/fs/9p/fid.c
> > > +++ b/fs/9p/fid.c
> > > @@ -152,7 +152,7 @@ static struct p9_fid
> > > *v9fs_fid_lookup_with_uid(struct
> > > dentry *dentry, const unsigned char **wnames, *uname;
> > > 
> > >  	int i, n, l, clone, access;
> > >  	struct v9fs_session_info *v9ses;
> > > 
> > > -	struct p9_fid *fid, *old_fid = NULL;
> > > +	struct p9_fid *fid, *old_fid;
> > > 
> > >  	v9ses = v9fs_dentry2v9ses(dentry);
> > >  	access = v9ses->flags & V9FS_ACCESS_MASK;
> > > 
> > > @@ -194,13 +194,12 @@ static struct p9_fid
> > > *v9fs_fid_lookup_with_uid(struct
> > > dentry *dentry, if (IS_ERR(fid))
> > > 
> > >  			return fid;
> > > 
> > > +		refcount_inc(&fid->count);
> > > 
> > >  		v9fs_fid_add(dentry->d_sb->s_root, fid);
> > >  	
> > >  	}
> > >  	/* If we are root ourself just return that */
> > > 
> > > -	if (dentry->d_sb->s_root == dentry) {
> > > -		refcount_inc(&fid->count);
> > > +	if (dentry->d_sb->s_root == dentry)
> > > 
> > >  		return fid;
> > > 
> > > -	}
> > 
> > Hmm, wouldn't it then be possible that the root fid is returned with
> > refcount being 2 here?
> 
> Yes and I think that's correct. One refcount taken for adding the root
> fid to the root dentry and another refcount taken for the original
> purpose of the lookup.
> 
> Reverting this portion of the change and re-testing with the reproducer
> triggers a refcount underflow.

Right, I still have some knowledge gaps in the kernel's 9p code base. I was 
actually rather confused about p9_client_clunk() which I just realized 
actually does the refcount decrement and then conditionally sends out the 
'Tclunk' message on refcount zero only.

So yes, it looks fine to me:

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

> > >  	/*
> > >  	
> > >  	 * Do a multipath walk with attached root.
> > >  	 * When walking parent we need to make sure we
> > > 
> > > @@ -212,6 +211,7 @@ static struct p9_fid
> > > *v9fs_fid_lookup_with_uid(struct
> > > dentry *dentry, fid = ERR_PTR(n);
> > > 
> > >  		goto err_out;
> > >  	
> > >  	}
> > > 
> > > +	old_fid = fid;
> > > 
> > >  	clone = 1;
> > >  	i = 0;
> > >  	while (i < n) {
> > > 
> > > @@ -221,15 +221,8 @@ static struct p9_fid
> > > *v9fs_fid_lookup_with_uid(struct
> > > dentry *dentry, * walk to ensure none of the patch component change
> > > 
> > >  		 */
> > >  		
> > >  		fid = p9_client_walk(fid, l, &wnames[i], clone);
> > > 
> > > +		p9_client_clunk(old_fid);
> > > 
> > >  		if (IS_ERR(fid)) {
> > > 
> > > -			if (old_fid) {
> > > -				/*
> > > -				 * If we fail, clunk fid which are
> > 
> > mapping
> > 
> > > -				 * to path component and not the last
> > 
> > component
> > 
> > > -				 * of the path.
> > > -				 */
> > > -				p9_client_clunk(old_fid);
> > > -			}
> > > 
> > >  			kfree(wnames);
> > >  			goto err_out;
> > >  		
> > >  		}
> > 
> > So this is the actual fix mentioned in the commit log. Makes sense.
> 
> I think the refcount_inc() change for the root fid is an important and
> required part of the fix.
> 
> > Nitpicking: Wouldn't it be a bit cleaner to set old_fid solely within the
> > while loop and just before overwriting fid? And as we now have bumped to
> > -std=C11, probably making old_fid a local variable within loop scope only?
> 
> You're right that it would be cleaner for the purposes of this single
> patch. In a followup patch in this series, I start tracking the root fid
> with a root_fid variable and that requires "old_fid = root_fid" before
> we enter the loop and then "old_fid = fid" inside of the loop.

s/while/for/ would do the trick I guess. Not a big deal though.

Best regards,
Christian Schoenebeck


