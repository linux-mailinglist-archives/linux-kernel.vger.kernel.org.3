Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3A94C3EA3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 07:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237963AbiBYGzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 01:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiBYGzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 01:55:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8435F2C032C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 22:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645772112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PWyr1+nn1ycpMnL9tgTudXWXj3ncKczWOpiUDmDKaMU=;
        b=feBSXBcc+Sg9Y3G8aJrY+8XLQ1yrn3rwFPz/0Lzdc/mtRM2z29tni+4StI03AjrXXu1laG
        SmoCVOLPpzLCvc/TW7FnrEqn8ChjX+D8OpSvHiaBHYekrpWYAZO0xfm1qhtHeeD4tZZ0j+
        aIX5i4ZQi4RCG/XGjKCOgIgMvcjJ+tw=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-Q0tttZhhMZ25E8DMrmSsrg-1; Fri, 25 Feb 2022 01:55:11 -0500
X-MC-Unique: Q0tttZhhMZ25E8DMrmSsrg-1
Received: by mail-pf1-f198.google.com with SMTP id d5-20020a623605000000b004e01ccd08abso2632184pfa.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 22:55:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PWyr1+nn1ycpMnL9tgTudXWXj3ncKczWOpiUDmDKaMU=;
        b=3jW32BRfXqcwxOcsvfqGZX7e/5YWx5QUpcIYkM3YOEFxUCgfoZtV4aqIv+nKMNPCvK
         LQXx3V8vB8lTYP1Ll6HyvfMyWxrS5Gv/euuhCR5czvV2CGo6hdzIx27da9gXsWR4vVyw
         JzxzgRsA3dP4JyFk9gwglRA4AoSqVobrxJvP6NbdnxrIaELEXI/42ORqx/N0TkIAWCsO
         OAi1YT6cMdZTOcGZTtxtzOhwByN95nihXhiKyNq6nacqYDhN3A+pzezq1go6oueEsuXX
         +oLDSpsOD0D3DehelK7bgFyBXntFwEb+9iXu7eyFrsAevOt7BjlgVVT7j6cjFkeNwj6t
         81SQ==
X-Gm-Message-State: AOAM530e73WQva1mCuU+0phK8n5Bqmvto+0rbM68ugFMaZFYjygF+M/x
        ybPTl3g+BFKAIy5gWYDzKUO9zNc7kPaIyOGIoo0QCbZ6m+sTOFrNy7FO8u2j164N5TXqGxOEX4v
        Yoe9FhIKX4SnlEBNT6gB7M2lHTuCQqHSb+lMP9pxaTjkLUHq9Rw9KBm7HW75a0JLR5mPXTSxgxQ
        ==
X-Received: by 2002:a17:902:bc42:b0:14f:e6d0:fb7b with SMTP id t2-20020a170902bc4200b0014fe6d0fb7bmr5888118plz.127.1645772109942;
        Thu, 24 Feb 2022 22:55:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxtd3ZsH2CuHzm/9LXkb+uvUEeUpL2X1D92aAAfH0lysp6YrwdKIgEP8tYr93QlRapJJ1M5dA==
X-Received: by 2002:a17:902:bc42:b0:14f:e6d0:fb7b with SMTP id t2-20020a170902bc4200b0014fe6d0fb7bmr5888093plz.127.1645772109411;
        Thu, 24 Feb 2022 22:55:09 -0800 (PST)
Received: from [10.72.12.114] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y5-20020a056a00180500b004e1bea9c587sm1889962pfa.67.2022.02.24.22.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 22:55:08 -0800 (PST)
Subject: Re: [RFC PATCH] ceph: add support for encrypted snapshot names
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220224112142.18052-1-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <7d2a798d-ce32-4bf7-b184-267bb79f44e3@redhat.com>
Date:   Fri, 25 Feb 2022 14:55:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220224112142.18052-1-lhenriques@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/24/22 7:21 PM, Luís Henriques wrote:
> Since filenames in encrypted directories are already encrypted and shown
> as a base64-encoded string when the directory is locked, snapshot names
> should show a similar behaviour.
>
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>   fs/ceph/dir.c   | 15 +++++++++++++++
>   fs/ceph/inode.c | 10 +++++++++-
>   2 files changed, 24 insertions(+), 1 deletion(-)
>
> Support on the MDS for names that'll be > MAX_NAME when base64 encoded is
> still TBD.  I thought it would be something easy to do, but snapshots
> don't seem to make use of the CDir/CDentry (which is where alternate_name
> is stored on the MDS).  I'm still looking into this, but I may need some
> help there :-(
>
> Cheers,
> --
> Luís
>
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index a449f4a07c07..20ae600ee7cd 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -1065,6 +1065,13 @@ static int ceph_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
>   		op = CEPH_MDS_OP_MKSNAP;
>   		dout("mksnap dir %p snap '%pd' dn %p\n", dir,
>   		     dentry, dentry);
> +		/* XXX missing support for alternate_name in snapshots */
> +		if (IS_ENCRYPTED(dir) && (dentry->d_name.len >= 189)) {
> +			dout("encrypted snapshot name too long: %pd len: %d\n",
> +			     dentry, dentry->d_name.len);
> +			err = -ENAMETOOLONG;
> +			goto out;
> +		}
>   	} else if (ceph_snap(dir) == CEPH_NOSNAP) {
>   		dout("mkdir dir %p dn %p mode 0%ho\n", dir, dentry, mode);
>   		op = CEPH_MDS_OP_MKDIR;
> @@ -1109,6 +1116,14 @@ static int ceph_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
>   	    !req->r_reply_info.head->is_target &&
>   	    !req->r_reply_info.head->is_dentry)
>   		err = ceph_handle_notrace_create(dir, dentry);
> +
> +	/*
> +	 * If we have created a snapshot we need to clear the cache, otherwise
> +	 * snapshot will show encrypted filenames in readdir.
> +	 */

Do you mean dencrypted filenames ?

- Xiubo


> +	if (ceph_snap(dir) == CEPH_SNAPDIR)
> +		d_drop(dentry);
> +
>   out_req:
>   	ceph_mdsc_put_request(req);
>   out:
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 8b0832271fdf..080824610b73 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -182,6 +182,13 @@ struct inode *ceph_get_snapdir(struct inode *parent)
>   	ci->i_rbytes = 0;
>   	ci->i_btime = ceph_inode(parent)->i_btime;
>   
> +	/* if encrypted, just borough fscrypt_auth from parent */
> +	if (IS_ENCRYPTED(parent)) {
> +		struct ceph_inode_info *pci = ceph_inode(parent);
> +		inode->i_flags |= S_ENCRYPTED;
> +		ci->fscrypt_auth_len = pci->fscrypt_auth_len;
> +		ci->fscrypt_auth = pci->fscrypt_auth;
> +	}
>   	if (inode->i_state & I_NEW) {
>   		inode->i_op = &ceph_snapdir_iops;
>   		inode->i_fop = &ceph_snapdir_fops;
> @@ -632,7 +639,8 @@ void ceph_free_inode(struct inode *inode)
>   
>   	kfree(ci->i_symlink);
>   #ifdef CONFIG_FS_ENCRYPTION
> -	kfree(ci->fscrypt_auth);
> +	if (ceph_snap(inode) != CEPH_SNAPDIR)
> +		kfree(ci->fscrypt_auth);
>   #endif
>   	fscrypt_free_inode(inode);
>   	kmem_cache_free(ceph_inode_cachep, ci);
>

