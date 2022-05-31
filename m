Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED92C539328
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 16:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345268AbiEaO2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 10:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244389AbiEaO2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 10:28:50 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 867AA8A329
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 07:28:48 -0700 (PDT)
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9DCC020BE49E;
        Tue, 31 May 2022 07:28:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9DCC020BE49E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1654007328;
        bh=ryNbELSrN1UgeAm1L5RK1KAe6rt4cp/z+pMhBtO69Bc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IT38DGMfxOc0gs/w6HpQF+GUYMrKwnWz1ZY0U2y8afLHLGsV08aw/xB5pnutYT0VW
         lkDCSUIL1xZzUOC8Jv4kuloC2otZyj2qSHj5E940cbnsVbCkOYn7bMREOm5cmF4V94
         mizwZNF8eBBqob3iQ/nYyvV1bSIoU4wyr2lW2lUs=
Date:   Tue, 31 May 2022 09:28:29 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jianyong Wu <jianyong.wu@arm.com>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] 9p: Fix refcounting during full path walks for
 fid lookups
Message-ID: <20220531142829.GA6868@sequoia>
References: <20220527000003.355812-1-tyhicks@linux.microsoft.com>
 <20220527000003.355812-2-tyhicks@linux.microsoft.com>
 <43525959.9j6oIFhYhY@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43525959.9j6oIFhYhY@silver>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-30 19:14:43, Christian Schoenebeck wrote:
> On Freitag, 27. Mai 2022 01:59:59 CEST Tyler Hicks wrote:
> > Decrement the refcount of the parent dentry's fid after walking
> > each path component during a full path walk for a lookup. Failure to do
> > so can lead to fids that are not clunked until the filesystem is
> > unmounted, as indicated by this warning:
> > 
> >  9pnet: found fid 3 not clunked
> 
> That explains why I saw so many fids not being clunked with recent Linux 
> kernel versions while doing some 9p protocol debugging with QEMU recently.

In addition to this refcounting bug, there's another one that I noticed
while running fstests. My series does not fix it and I haven't had a
chance to look into it more. The generic/531 test triggers it.

 https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/tests/generic/531

> 
> > The improper refcounting after walking resulted in open(2) returning
> > -EIO on any directories underneath the mount point when using the virtio
> > transport. When using the fd transport, there's no apparent issue until
> > the filesytem is unmounted and the warning above is emitted to the logs.
> 
> Actually I never saw that open() = -EIO error. Do you have a reproducer?

The reproducer that I have is binary only (fairly large and runs a bunch
of different tests) and is used to regression test the Windows Subsystem
for Linux 2 (WSL2) host <-> guest filesystem sharing. Now that I think
about it, I'm not sure if the open() = -EIO error happens with other 9p
servers.

I can try to tease out the exact sequence of filesystem operations from
this test binary but it might take me a bit. It looks like it has to do
with switching UIDs, which could make sense because different users may
not be connected to the filesystem yet (the conditional block that does
p9_client_attach() and v9fs_fid_add()).

> 
> > In some cases, the user may not yet be attached to the filesystem and a
> > new root fid, associated with the user, is created and attached to the
> > root dentry before the full path walk is performed. Increment the new
> > root fid's refcount to two in that situation so that it can be safely
> > decremented to one after it is used for the walk operation. The new fid
> > will still be attached to the root dentry when
> > v9fs_fid_lookup_with_uid() returns so a final refcount of one is
> > correct/expected.
> > 
> > Fixes: 6636b6dcc3db ("9p: add refcount to p9_fid struct")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > ---
> >  fs/9p/fid.c | 17 +++++------------
> >  1 file changed, 5 insertions(+), 12 deletions(-)
> > 
> > diff --git a/fs/9p/fid.c b/fs/9p/fid.c
> > index 79df61fe0e59..5a469b79c1ee 100644
> > --- a/fs/9p/fid.c
> > +++ b/fs/9p/fid.c
> > @@ -152,7 +152,7 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct
> > dentry *dentry, const unsigned char **wnames, *uname;
> >  	int i, n, l, clone, access;
> >  	struct v9fs_session_info *v9ses;
> > -	struct p9_fid *fid, *old_fid = NULL;
> > +	struct p9_fid *fid, *old_fid;
> > 
> >  	v9ses = v9fs_dentry2v9ses(dentry);
> >  	access = v9ses->flags & V9FS_ACCESS_MASK;
> > @@ -194,13 +194,12 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct
> > dentry *dentry, if (IS_ERR(fid))
> >  			return fid;
> > 
> > +		refcount_inc(&fid->count);
> >  		v9fs_fid_add(dentry->d_sb->s_root, fid);
> >  	}
> >  	/* If we are root ourself just return that */
> > -	if (dentry->d_sb->s_root == dentry) {
> > -		refcount_inc(&fid->count);
> > +	if (dentry->d_sb->s_root == dentry)
> >  		return fid;
> > -	}
> 
> Hmm, wouldn't it then be possible that the root fid is returned with refcount 
> being 2 here?

Yes and I think that's correct. One refcount taken for adding the root
fid to the root dentry and another refcount taken for the original
purpose of the lookup.

Reverting this portion of the change and re-testing with the reproducer
triggers a refcount underflow.

> 
> >  	/*
> >  	 * Do a multipath walk with attached root.
> >  	 * When walking parent we need to make sure we
> > @@ -212,6 +211,7 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct
> > dentry *dentry, fid = ERR_PTR(n);
> >  		goto err_out;
> >  	}
> > +	old_fid = fid;
> >  	clone = 1;
> >  	i = 0;
> >  	while (i < n) {
> > @@ -221,15 +221,8 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct
> > dentry *dentry, * walk to ensure none of the patch component change
> >  		 */
> >  		fid = p9_client_walk(fid, l, &wnames[i], clone);
> > +		p9_client_clunk(old_fid);
> >  		if (IS_ERR(fid)) {
> > -			if (old_fid) {
> > -				/*
> > -				 * If we fail, clunk fid which are 
> mapping
> > -				 * to path component and not the last 
> component
> > -				 * of the path.
> > -				 */
> > -				p9_client_clunk(old_fid);
> > -			}
> >  			kfree(wnames);
> >  			goto err_out;
> >  		}
> 
> So this is the actual fix mentioned in the commit log. Makes sense.

I think the refcount_inc() change for the root fid is an important and
required part of the fix.

> Nitpicking: Wouldn't it be a bit cleaner to set old_fid solely within the 
> while loop and just before overwriting fid? And as we now have bumped to
> -std=C11, probably making old_fid a local variable within loop scope only?

You're right that it would be cleaner for the purposes of this single
patch. In a followup patch in this series, I start tracking the root fid
with a root_fid variable and that requires "old_fid = root_fid" before
we enter the loop and then "old_fid = fid" inside of the loop.

Tyler

> 
> Best regards,
> Christian Schoenebeck
> 
> 
> 
