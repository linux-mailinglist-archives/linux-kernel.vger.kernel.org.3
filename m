Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E624D6D91
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 09:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiCLIba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 03:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiCLIb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 03:31:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2802E291B8F
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 00:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647073820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bXLQcaZ+lfbTrZcLRD6Ak8e0Z+SxGQP7BwbnusBAwsM=;
        b=Ti6zC8TAqvbBVhLliPZzEXRqbYTH7WLL0e9GmI/7cAPpSwaf0XCKD6gRV1Iw6xLyXjODEG
        8IXGHvbt23NEdWLSsEhwahfN/rAI0vI/pKXsi4s3mwujzt2c6H57xAo7fISilGu1U+rqlp
        5zSAkNgRVFVZToCPqYfTxNEXIwuimY4=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-Vek947TJMxOjvBPPcabx0g-1; Sat, 12 Mar 2022 03:30:19 -0500
X-MC-Unique: Vek947TJMxOjvBPPcabx0g-1
Received: by mail-pg1-f197.google.com with SMTP id h12-20020a63530c000000b0037c8f45bf1bso6226314pgb.7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 00:30:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bXLQcaZ+lfbTrZcLRD6Ak8e0Z+SxGQP7BwbnusBAwsM=;
        b=oTuV0DfRZE5/5Ds44BblSvIsp9XH5jstiJRiDgwFRuOnQ1iiar2Xtn8LqE1eeWELZW
         xHbwT8MToJKGvQoOW+c3XX82itDGQ6zUZDFKCblBY2Mek83q78Fi/7T9IOMJJRxs191B
         F/e6PZmrLYrMZbzSVUTRvHBsDbLaIAjiFdtFfNcxQK/NX14LDua+xkE1MlCK0wEvvBTa
         O+MaULPucaiIut1e87xE8YT4kg5GEdeJXstbwkBRx/1vgWw+ZT/YeqQsbixgHX4anMYO
         gU12M+SXWTVeK9Uo0vReYJlEsepBjSoovUVpE1ggURD4Xe6f/ZYrELfNeXuM3shZuvdq
         p9mQ==
X-Gm-Message-State: AOAM5312hvZn0fiQJTfGkHNYjEaWvOKIp2wCK4vKQhpU/j71RUDvs6Kz
        54/Xx4GSrgnDwbKyCWKq5ZChGe/gZ9ebbM3zMkw7bYdMJQhBn19G+Tg9l8LRtYYYhSp91HVU+QQ
        OV6J+ucg8/2FRvuS7znjqKj6RJrL7CNtueF0/A6N1jIKVJKh9wxMlVTepv5WTE6jMjG7kmNPqTg
        ==
X-Received: by 2002:a17:90b:3ece:b0:1bf:16ac:7a1b with SMTP id rm14-20020a17090b3ece00b001bf16ac7a1bmr14955355pjb.236.1647073817646;
        Sat, 12 Mar 2022 00:30:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy5BNfS+5sXdHtEhhA4PmP+4R8hBxs9nG240NzZ9/QsgRe7q+MbwM8b60+FflZ6MChtAR63AQ==
X-Received: by 2002:a17:90b:3ece:b0:1bf:16ac:7a1b with SMTP id rm14-20020a17090b3ece00b001bf16ac7a1bmr14955317pjb.236.1647073817130;
        Sat, 12 Mar 2022 00:30:17 -0800 (PST)
Received: from [10.72.12.132] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s30-20020a056a001c5e00b004f75773f3fcsm12644829pfw.119.2022.03.12.00.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Mar 2022 00:30:16 -0800 (PST)
Subject: Re: [RFC PATCH 1/2] ceph: add support for encrypted snapshot names
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220310172616.16212-1-lhenriques@suse.de>
 <20220310172616.16212-2-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <fdf774cd-3cca-14e5-d5aa-44de70bb89f0@redhat.com>
Date:   Sat, 12 Mar 2022 16:30:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220310172616.16212-2-lhenriques@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/11/22 1:26 AM, Luís Henriques wrote:
> Since filenames in encrypted directories are already encrypted and shown
> as a base64-encoded string when the directory is locked, snapshot names
> should show a similar behaviour.
>
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>   fs/ceph/dir.c   |  9 +++++++++
>   fs/ceph/inode.c | 13 +++++++++++++
>   2 files changed, 22 insertions(+)
>
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 6df2a91af236..123e3b9c8161 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -1075,6 +1075,15 @@ static int ceph_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
>   		op = CEPH_MDS_OP_MKSNAP;
>   		dout("mksnap dir %p snap '%pd' dn %p\n", dir,
>   		     dentry, dentry);
> +		/*
> +		 * Encrypted snapshots require d_revalidate to force a
> +		 * LOOKUPSNAP to cleanup dcache
> +		 */
> +		if (IS_ENCRYPTED(dir)) {
> +			spin_lock(&dentry->d_lock);
> +			dentry->d_flags |= DCACHE_NOKEY_NAME;

I think this is not correct fix of this issue.

Actually this dentry's name is a KEY NAME, which is human readable name.

DCACHE_NOKEY_NAME means the base64_encoded names. This usually will be 
set when filling a new dentry if the directory is locked. If the 
directory is unlocked the directory inode will be set with the key.

The root cause should be the snapshot's inode doesn't correctly set the 
encrypt stuff when you are reading from it.

NOTE: when you are 'ls -l .snap/snapXXX' the snapXXX dentry name is 
correct, it's just corrupted for the file or directory names under snapXXX/.


> +			spin_unlock(&dentry->d_lock);
> +		}
>   	} else if (ceph_snap(dir) == CEPH_NOSNAP) {
>   		dout("mkdir dir %p dn %p mode 0%ho\n", dir, dentry, mode);
>   		op = CEPH_MDS_OP_MKDIR;
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index b573a0f33450..81d3d554d261 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -182,6 +182,19 @@ struct inode *ceph_get_snapdir(struct inode *parent)
>   	ci->i_rbytes = 0;
>   	ci->i_btime = ceph_inode(parent)->i_btime;
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
> +	}

Here I think Jeff has already commented it in your last version, it 
should fail by returning NULL ?

- Xiubo

>   	if (inode->i_state & I_NEW) {
>   		inode->i_op = &ceph_snapdir_iops;
>   		inode->i_fop = &ceph_snapdir_fops;
>

