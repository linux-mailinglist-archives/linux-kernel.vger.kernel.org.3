Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331BF5477E6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 01:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiFKXRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 19:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiFKXRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 19:17:43 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514F72B243
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 16:17:39 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 77974C01F; Sun, 12 Jun 2022 01:17:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1654989458; bh=51Zpk5kYQNoaNHj5xDV/BEXLNsTdPQOa3HXVja3g0+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1/Uiym/anbOFwI+jcwxEZu2zWHFhmcbYuqxmPVikZTekj/Dk+3aBRetoNDmjgXGZq
         DZ6vI343NnICHZXex2QExfl/pidMiBwsI7GAEnWZy7BobBsK0u+w1hvxpIVsAJeTuz
         VAut/K3TViHA9atLBAzDPlbdJK3RUn2otlfB73gI2y5kp6CXf4rAUr4iQ0V3qNKWW3
         M0cO2usnwAicuXd5/9Rl8G6vtdBVZRUdUEbXLzky47zhdS0SAfLhteyZ3OEFd1/K86
         EHLwOD5y2Riza/8Vao5Dmccf6osg1Dc150CF7qxhXufDnoJvFFiTDu0jDIJeRtgPwV
         2XpeVlO6X7+zQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 4ED0AC009;
        Sun, 12 Jun 2022 01:17:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1654989457; bh=51Zpk5kYQNoaNHj5xDV/BEXLNsTdPQOa3HXVja3g0+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y5rF06hnrV/kr2HQYwaXZTuO/OaUIXfl7S5AcXhEJF0gGIMGpP4SUl10YGzBZvsL8
         pQ2GjYw0+8VESlpEHZR1bRITOjwSsc7P2Ilej7UaC42Bcbu3HokPhORJAQzZoYDgS2
         VeXel+euGfr46iLT10K8gF/UcuYHdaOWwFD213qbDAEwIoM0JR8N01+A2GREg7TpEr
         A9fgi+YIVluV/Wx8V3Av+HsNAJJH+eMzZ+DhOT4HiNx3NyJBVoMHza0Srv/uvaNjKH
         mhTytVGj1dDPwDYAS6fxAMislhVBvtiIUiv1bTLiVZfNNV5BnJlRDJGSC+VqLWBX7r
         m60WvEx8N1ffw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 71a9de38;
        Sat, 11 Jun 2022 23:17:31 +0000 (UTC)
Date:   Sun, 12 Jun 2022 08:17:16 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Jianyong Wu <jianyong.wu@arm.com>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] 9p: Fix refcounting during full path walks for
 fid lookups
Message-ID: <YqUifCFPTG8Qmn7a@codewreck.org>
References: <20220527000003.355812-1-tyhicks@linux.microsoft.com>
 <20220527000003.355812-2-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220527000003.355812-2-tyhicks@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tyler Hicks wrote on Thu, May 26, 2022 at 06:59:59PM -0500:
> Decrement the refcount of the parent dentry's fid after walking
> each path component during a full path walk for a lookup. Failure to do
> so can lead to fids that are not clunked until the filesystem is
> unmounted, as indicated by this warning:
> 
>  9pnet: found fid 3 not clunked
> 
> The improper refcounting after walking resulted in open(2) returning
> -EIO on any directories underneath the mount point when using the virtio
> transport. When using the fd transport, there's no apparent issue until
> the filesytem is unmounted and the warning above is emitted to the logs.
> 
> In some cases, the user may not yet be attached to the filesystem and a
> new root fid, associated with the user, is created and attached to the
> root dentry before the full path walk is performed. Increment the new
> root fid's refcount to two in that situation so that it can be safely
> decremented to one after it is used for the walk operation. The new fid
> will still be attached to the root dentry when
> v9fs_fid_lookup_with_uid() returns so a final refcount of one is
> correct/expected.
> 
> Fixes: 6636b6dcc3db ("9p: add refcount to p9_fid struct")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---
>  fs/9p/fid.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/9p/fid.c b/fs/9p/fid.c
> index 79df61fe0e59..5a469b79c1ee 100644
> --- a/fs/9p/fid.c
> +++ b/fs/9p/fid.c
> @@ -152,7 +152,7 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
>  	const unsigned char **wnames, *uname;
>  	int i, n, l, clone, access;
>  	struct v9fs_session_info *v9ses;
> -	struct p9_fid *fid, *old_fid = NULL;
> +	struct p9_fid *fid, *old_fid;
>  
>  	v9ses = v9fs_dentry2v9ses(dentry);
>  	access = v9ses->flags & V9FS_ACCESS_MASK;
> @@ -194,13 +194,12 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
>  		if (IS_ERR(fid))
>  			return fid;
>  
> +		refcount_inc(&fid->count);
>  		v9fs_fid_add(dentry->d_sb->s_root, fid);
>  	}
>  	/* If we are root ourself just return that */
> -	if (dentry->d_sb->s_root == dentry) {
> -		refcount_inc(&fid->count);
> +	if (dentry->d_sb->s_root == dentry)
>  		return fid;
> -	}
>  	/*
>  	 * Do a multipath walk with attached root.
>  	 * When walking parent we need to make sure we
> @@ -212,6 +211,7 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
>  		fid = ERR_PTR(n);
>  		goto err_out;
>  	}
> +	old_fid = fid;
>  	clone = 1;
>  	i = 0;
>  	while (i < n) {
> @@ -221,15 +221,8 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
>  		 * walk to ensure none of the patch component change
>  		 */
>  		fid = p9_client_walk(fid, l, &wnames[i], clone);
> +		p9_client_clunk(old_fid);

hmm, if we're not cloning then fid == old_fid and the refcount is not
increased? (I think... I didn't even realize/remember that walk had a
no-clone mode, sorry.)

So we'd only need to clunk if old fid here if we're cloning (old fid is
the initial root fid), but I'm not sure how to test this path as I
couldn't think of any pattern that'd trigger a multi-level lookup,
so I'm not 100% sure; I'll try a bit more.

-- 
Dominique
