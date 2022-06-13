Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65CE549FA0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbiFMUl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242261AbiFMUk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:40:59 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FBB45B887
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:38:11 -0700 (PDT)
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id BDFC520C154C;
        Mon, 13 Jun 2022 12:38:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BDFC520C154C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1655149091;
        bh=Nlhe89f21s2Nn6sZlzNNWxjIOhCd8EeCNee7Yy+xEvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ikjQZmtHOZ+WLe7eXSv06sgC+WIMy6qYOHsYl7R3s+ezYufbTNoh1MQu0ZSQzrnng
         xYlX8CztPE8odeMby13fHDEYRtASMSs4m0XSf4+JW3cYWTVZbxjIdlxMwQbapVww7H
         VaYAyOL+V7jxcNjtFFJJebiJadQAYuPPUzUWKM6k=
Date:   Mon, 13 Jun 2022 14:38:07 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Jianyong Wu <jianyong.wu@arm.com>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] 9p: Fix refcounting during full path walks for
 fid lookups
Message-ID: <20220613193807.GF7401@sequoia>
References: <20220527000003.355812-1-tyhicks@linux.microsoft.com>
 <20220527000003.355812-2-tyhicks@linux.microsoft.com>
 <YqUifCFPTG8Qmn7a@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqUifCFPTG8Qmn7a@codewreck.org>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-12 08:17:16, Dominique Martinet wrote:
> Tyler Hicks wrote on Thu, May 26, 2022 at 06:59:59PM -0500:
> > Decrement the refcount of the parent dentry's fid after walking
> > each path component during a full path walk for a lookup. Failure to do
> > so can lead to fids that are not clunked until the filesystem is
> > unmounted, as indicated by this warning:
> > 
> >  9pnet: found fid 3 not clunked
> > 
> > The improper refcounting after walking resulted in open(2) returning
> > -EIO on any directories underneath the mount point when using the virtio
> > transport. When using the fd transport, there's no apparent issue until
> > the filesytem is unmounted and the warning above is emitted to the logs.
> > 
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
> > @@ -152,7 +152,7 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
> >  	const unsigned char **wnames, *uname;
> >  	int i, n, l, clone, access;
> >  	struct v9fs_session_info *v9ses;
> > -	struct p9_fid *fid, *old_fid = NULL;
> > +	struct p9_fid *fid, *old_fid;
> >  
> >  	v9ses = v9fs_dentry2v9ses(dentry);
> >  	access = v9ses->flags & V9FS_ACCESS_MASK;
> > @@ -194,13 +194,12 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
> >  		if (IS_ERR(fid))
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
> >  	/*
> >  	 * Do a multipath walk with attached root.
> >  	 * When walking parent we need to make sure we
> > @@ -212,6 +211,7 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
> >  		fid = ERR_PTR(n);
> >  		goto err_out;
> >  	}
> > +	old_fid = fid;
> >  	clone = 1;
> >  	i = 0;
> >  	while (i < n) {
> > @@ -221,15 +221,8 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
> >  		 * walk to ensure none of the patch component change
> >  		 */
> >  		fid = p9_client_walk(fid, l, &wnames[i], clone);
> > +		p9_client_clunk(old_fid);
> 
> hmm, if we're not cloning then fid == old_fid and the refcount is not
> increased? (I think... I didn't even realize/remember that walk had a
> no-clone mode, sorry.)
> 
> So we'd only need to clunk if old fid here if we're cloning (old fid is
> the initial root fid), but I'm not sure how to test this path as I
> couldn't think of any pattern that'd trigger a multi-level lookup,
> so I'm not 100% sure; I'll try a bit more.

Yes, you're correct. Nice catch!

Tyler

> 
> -- 
> Dominique
> 
