Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6775386A5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 19:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240574AbiE3ROy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 13:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbiE3ROx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 13:14:53 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B3F427C4
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 10:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=jMYehlB9aLUgQ1tstMwnwZ61QG62rksDqgFFcnCVQnw=; b=SxpdlH8dBDao2azwBPGR9+mrEN
        En4n+oBmoxWawuMZDsQr+06EOwQkYJffGfhbDibikM/ERYN8ckVsJN6vHrE+OaNxR356uQmSTb0+I
        VLB3AqCOCt6YYrBS3SPYsndOA9htD013UdvbbAcuDTm+DOy4LZQyTCovz6tJubDzlQXEul7X5MBa+
        Vb3mFPHwe7pz/5OBl6sSpkLV9rZA7eIWlvfALjP1b0VkUCoFFxBLc/hMDEHR5Aw5dKTOxwSznlT0x
        EiPjleRqEf7w/sRaFmfi3F/Brqpg2MbtsAI/g649Bc24vYqhkXeT5exMQYHJIr5TKc/qlYhpOH4VR
        oVweRXI2fVeuCLEBV6dwmT5/71nWlz6zxPlMTLk9UJhnw0dZi0kK2GkpHjY36IgYZj3sRD+kIYqd8
        lfNx4MVfYpS57tzcNrxqWPHBfB9OVFniPco3ENau3DfnTI06gMdD1XPsdedmmkrk8woubmwpaW7ey
        FNbOw7KHDQSMfVydSmu4Po3GAIjwptYKKSqX8c6Ix/Tfrx9fbtad94ggoCrpna0zTtDLgG6W2ykqD
        VbpfjokQ4yLm8w+AdaIWxQfpV1t5ij8xmLfFtuN2FSz+E/Vj75o8dy03x8FFIJL4ctpWbpIv7c+KO
        Ma6/dsUBmXi5glfzHffEi7vpWX7qHM6SElNFJdZhQ=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Jianyong Wu <jianyong.wu@arm.com>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] 9p: Fix refcounting during full path walks for fid lookups
Date:   Mon, 30 May 2022 19:14:43 +0200
Message-ID: <43525959.9j6oIFhYhY@silver>
In-Reply-To: <20220527000003.355812-2-tyhicks@linux.microsoft.com>
References: <20220527000003.355812-1-tyhicks@linux.microsoft.com>
 <20220527000003.355812-2-tyhicks@linux.microsoft.com>
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

On Freitag, 27. Mai 2022 01:59:59 CEST Tyler Hicks wrote:
> Decrement the refcount of the parent dentry's fid after walking
> each path component during a full path walk for a lookup. Failure to do
> so can lead to fids that are not clunked until the filesystem is
> unmounted, as indicated by this warning:
> 
>  9pnet: found fid 3 not clunked

That explains why I saw so many fids not being clunked with recent Linux 
kernel versions while doing some 9p protocol debugging with QEMU recently.

> The improper refcounting after walking resulted in open(2) returning
> -EIO on any directories underneath the mount point when using the virtio
> transport. When using the fd transport, there's no apparent issue until
> the filesytem is unmounted and the warning above is emitted to the logs.

Actually I never saw that open() = -EIO error. Do you have a reproducer?

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
> @@ -152,7 +152,7 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct
> dentry *dentry, const unsigned char **wnames, *uname;
>  	int i, n, l, clone, access;
>  	struct v9fs_session_info *v9ses;
> -	struct p9_fid *fid, *old_fid = NULL;
> +	struct p9_fid *fid, *old_fid;
> 
>  	v9ses = v9fs_dentry2v9ses(dentry);
>  	access = v9ses->flags & V9FS_ACCESS_MASK;
> @@ -194,13 +194,12 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct
> dentry *dentry, if (IS_ERR(fid))
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

Hmm, wouldn't it then be possible that the root fid is returned with refcount 
being 2 here?

>  	/*
>  	 * Do a multipath walk with attached root.
>  	 * When walking parent we need to make sure we
> @@ -212,6 +211,7 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct
> dentry *dentry, fid = ERR_PTR(n);
>  		goto err_out;
>  	}
> +	old_fid = fid;
>  	clone = 1;
>  	i = 0;
>  	while (i < n) {
> @@ -221,15 +221,8 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct
> dentry *dentry, * walk to ensure none of the patch component change
>  		 */
>  		fid = p9_client_walk(fid, l, &wnames[i], clone);
> +		p9_client_clunk(old_fid);
>  		if (IS_ERR(fid)) {
> -			if (old_fid) {
> -				/*
> -				 * If we fail, clunk fid which are 
mapping
> -				 * to path component and not the last 
component
> -				 * of the path.
> -				 */
> -				p9_client_clunk(old_fid);
> -			}
>  			kfree(wnames);
>  			goto err_out;
>  		}

So this is the actual fix mentioned in the commit log. Makes sense.

Nitpicking: Wouldn't it be a bit cleaner to set old_fid solely within the 
while loop and just before overwriting fid? And as we now have bumped to
-std=C11, probably making old_fid a local variable within loop scope only?

Best regards,
Christian Schoenebeck



