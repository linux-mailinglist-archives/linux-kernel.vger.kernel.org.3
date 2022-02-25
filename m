Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571664C3DEF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 06:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237572AbiBYFhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 00:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbiBYFhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 00:37:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D57027CE7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 21:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645767394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/EmBOuIHlG591wLcgnhpf7mq1SLYtaesSG4JYPO3Ae4=;
        b=QPSUZ9iVfS68lqtMpbX+jS7c2Bnux5thcdaH1nsixJC4AKgJ9dwZ8TwaDBQdbqDGkro2/p
        hPPzbswDkYl3TadYBASVPxhbxnY9r565pogGeuU6ETPmAwB8qOQtjLUS31h2G0fQJPeyj7
        EiIrtXEQ9SxwGeP4NKa1q2xxIF2c1i8=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-94-syIzx75sM0KvZNMOf8G0mA-1; Fri, 25 Feb 2022 00:36:32 -0500
X-MC-Unique: syIzx75sM0KvZNMOf8G0mA-1
Received: by mail-pg1-f200.google.com with SMTP id x4-20020a63b344000000b00375662f4a7bso2137015pgt.15
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 21:36:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/EmBOuIHlG591wLcgnhpf7mq1SLYtaesSG4JYPO3Ae4=;
        b=z9UWVBiX37d2MnN07ApV9u5dJyLPP8L3C73MzaYYOvNC0IkSQGfrRpe+ozEur2YXQ+
         bYLMPsh0yXDQqk3tkvZatbrithGcbvMAP3rwuQGgy2KfejSSHHbsx6edgotFyPf7oWWE
         QY9kD63VlakTxYAaWx+fpIfHAf0F+ASn7uJm7zfN6Y8KUbiSEqjj/SS5kS8ndcvc7n/2
         7GCl8AOa7GGk2HGi4/B+GrEUNAhPH7n3dfNQ7LhHelB9wDakXd4bqa2BtLqCbs3KneiF
         Tg4OiYPltB5rO8P5OULpWTc1W3OuPyYC6Dkz4wFFTRq9EazJJjI+YthfsvDOvtDZkhh9
         mXGA==
X-Gm-Message-State: AOAM533pa3QcqsDYnm2roS0C3vC/Tgv3CVom+o+zSjC3eBdm6d+mFM4r
        SXmUYcf+tnCf5feLRV7clhaPU4LoT5q3Z7BkWkC/19QUuTDrsqXOh3glEKc0mHohq2Zugc+34uK
        sPj25/E3gah86WgxywZgSyTk6I6AE3C1mNlRSJgdshfxOMN86Rzv1yN5pbL+4g8UDYvIk4wHELA
        ==
X-Received: by 2002:a17:902:f70d:b0:14f:a1e1:b9b3 with SMTP id h13-20020a170902f70d00b0014fa1e1b9b3mr5870760plo.36.1645767391314;
        Thu, 24 Feb 2022 21:36:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwiiXsd4xahPwiW6r0AIofmiUU0MlMH3nliR/roKSNeVm9RBYdvRY2BJ9FFuPjqkgJwyFWaPw==
X-Received: by 2002:a17:902:f70d:b0:14f:a1e1:b9b3 with SMTP id h13-20020a170902f70d00b0014fa1e1b9b3mr5870730plo.36.1645767390901;
        Thu, 24 Feb 2022 21:36:30 -0800 (PST)
Received: from [10.72.12.114] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u37-20020a056a0009a500b004e1414d69besm1398278pfg.151.2022.02.24.21.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 21:36:30 -0800 (PST)
Subject: Re: [RFC PATCH] ceph: add support for encrypted snapshot names
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220224112142.18052-1-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <27801620-b3fd-d556-c100-409632f91661@redhat.com>
Date:   Fri, 25 Feb 2022 13:36:24 +0800
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
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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

Yeah, good catch. The snapshot handler in MDS hasn't handled this case 
yet, though the kclient has passed it to MDS server.

The snapshot alternate_name raw ciphertext should be stored in SnapInfo 
struct along with the 'name'.


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

We should fix the MDS side bug and then this workaroud will be no needed.

- Xiubo

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

