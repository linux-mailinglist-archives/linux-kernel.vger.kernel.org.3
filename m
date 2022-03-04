Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E219D4CDC58
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241638AbiCDS0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbiCDS0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:26:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E8F1BD9AB;
        Fri,  4 Mar 2022 10:25:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB4D1B82A88;
        Fri,  4 Mar 2022 18:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11098C340E9;
        Fri,  4 Mar 2022 18:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646418346;
        bh=l0FlQzAMsxaYplXdIdyynX482admzfc4/JVxFMppzT8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qsuplynDE6XcT1GR1C2LVZUv4vKClCPjkbdAokkOjqZD4uKxHJ4Bf8FQxQhT4Ej1t
         oN0VvBtqXDdhKBkFIWeoHsDx1Rqx6XC2LWiRIukNB9ebyYfqLdGfPS7aUVcXzJyeUG
         //fZItt7kucmDN8TsCk3ss5DgaySF0a7vKgsCjSUxXjdzJMjJ5BkFUrnSSkwIu1c1J
         MZNv/vmXgodsJmjI66OItdbZMxVDKB76KRXb4D8EYPLk+73udYSqix8ejUJG15aBti
         O7g/kcfXsUksH3304YHIMINjEbEX9rPabPIswI0obaeI4RwdgQ9H5YOaAcDdbZTEND
         YgWZuj9lJGzmA==
Message-ID: <c3d26fbd7691155cedc06dd44344d868f4d9112a.camel@kernel.org>
Subject: Re: [PATCH 3/3] ceph: add support for encrypted snapshot names
From:   Jeff Layton <jlayton@kernel.org>
To:     =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 04 Mar 2022 13:25:44 -0500
In-Reply-To: <20220304161403.19295-4-lhenriques@suse.de>
References: <20220304161403.19295-1-lhenriques@suse.de>
         <20220304161403.19295-4-lhenriques@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-03-04 at 16:14 +0000, Luís Henriques wrote:
> Since filenames in encrypted directories are already encrypted and shown
> as a base64-encoded string when the directory is locked, snapshot names
> should show a similar behaviour.
> 
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>  fs/ceph/dir.c   |  9 +++++++++
>  fs/ceph/inode.c | 13 +++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 934402f5e9e6..17d2f18a1fd1 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -1069,6 +1069,15 @@ static int ceph_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
>  		op = CEPH_MDS_OP_MKSNAP;
>  		dout("mksnap dir %p snap '%pd' dn %p\n", dir,
>  		     dentry, dentry);
> +		/*
> +		 * Encrypted snapshots require d_revalidate to force a
> +		 * LOOKUPSNAP to cleanup dcache
> +		 */
> +		if (IS_ENCRYPTED(dir)) {
> +			spin_lock(&dentry->d_lock);
> +			dentry->d_flags |= DCACHE_NOKEY_NAME;
> +			spin_unlock(&dentry->d_lock);
> +		}
>  	} else if (ceph_snap(dir) == CEPH_NOSNAP) {
>  		dout("mkdir dir %p dn %p mode 0%ho\n", dir, dentry, mode);
>  		op = CEPH_MDS_OP_MKDIR;
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 8b0832271fdf..357335a11384 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -182,6 +182,19 @@ struct inode *ceph_get_snapdir(struct inode *parent)
>  	ci->i_rbytes = 0;
>  	ci->i_btime = ceph_inode(parent)->i_btime;
>  
> +	/* if encrypted, just borrow fscrypt_auth from parent */
> +	if (IS_ENCRYPTED(parent)) {
> +		struct ceph_inode_info *pci = ceph_inode(parent);
> +
> +		ci->fscrypt_auth = kmemdup(pci->fscrypt_auth,
> +					   pci->fscrypt_auth_len,
> +					   GFP_KERNEL);
> +		if (ci->fscrypt_auth) {
> +			inode->i_flags |= S_ENCRYPTED;
> +			ci->fscrypt_auth_len = pci->fscrypt_auth_len;
> +		} else
> +			dout("Failed to alloc memory for fscrypt_auth in snapdir\n");

Should we return an error in this case?

> +	}
>  	if (inode->i_state & I_NEW) {
>  		inode->i_op = &ceph_snapdir_iops;
>  		inode->i_fop = &ceph_snapdir_fops;

Seems simple and straightforward at first glance.
-- 
Jeff Layton <jlayton@kernel.org>
