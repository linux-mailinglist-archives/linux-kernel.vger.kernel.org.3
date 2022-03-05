Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747704CE4DD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 13:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiCEMou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 07:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiCEMot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 07:44:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35BCE1CC7FD
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 04:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646484239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y9DMcHNF6Q5hsRov5tA0bx8gObhioE41OPn/GJ5m62E=;
        b=BK6O+jn/o2xeShsyU6psoRUmQJetKsBFqiVL36CuT6VPpQuqu5N8580lKIiPwRvQmkFPaS
        RYDuKJsCHwWNOmE+eqTrYMpNpIxFXnUo519GsO/wixO79msYvdvLE9NObFSt5k8192dvBc
        ZIQfXfnvW1Itp6+EF0ZHFE2m75ZoSKk=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-RvHlIy37Py2BpCBjNY7yKw-1; Sat, 05 Mar 2022 07:43:58 -0500
X-MC-Unique: RvHlIy37Py2BpCBjNY7yKw-1
Received: by mail-pf1-f197.google.com with SMTP id x8-20020aa79ac8000000b004f6caa3e63dso2090591pfp.17
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 04:43:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=y9DMcHNF6Q5hsRov5tA0bx8gObhioE41OPn/GJ5m62E=;
        b=v+L/xUB38rJGjtnArAhRXvS8rul7N89DX6WdTmMs/UH5gBexcqhDRehIQHPxg8AbLD
         gIimu62AObM0w1VfuC1uR+Ay4SJhMYdk1dr+Lzf1cFUgVQQxvuA2pTAO54c+dkoTNHw1
         kdrgUyZJtDlnw+qJ6UIX0SsQVetmRGMK1RzAy6yH/SLkiliqsMH7JY+aU/fdomRQZ08Q
         ZwLRmCmG6bZ8VeRF5orn79YxuWnOSFDIrE7hU+eQ4OuUtDf42Qhw1/18zs9OG9zRjFWA
         cCCAwSEsUeXHS2nFtkGkV/ILROhElOQxhXuO1urExqz0bNHygreQArzI1MlBQhPx/66j
         oypw==
X-Gm-Message-State: AOAM531Zq82U51GsNY+Lfg7+J8BlqI37OdxAdmiMu+Es2p9dWLQfuX2G
        ahVMzxU0QxR2NcRcNW6kaNL93fwpqorEK0rjqgsIunE39g5noEGFUA/tJnuLiHHs+PQpc10d5dZ
        BBqTeUXfsmTjyK3ijnTXMT9ANNwWvNp+WbinWXtd/YUKYR6Xr/suhlm4TzFiJd2iSqRYCn3VY0Q
        ==
X-Received: by 2002:a17:902:d485:b0:151:addf:15a2 with SMTP id c5-20020a170902d48500b00151addf15a2mr3267145plg.2.1646484236742;
        Sat, 05 Mar 2022 04:43:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyj4OOcRGZ03ZRL2cY0F8oICrjeXYA7L+F5luCfeHTZM2uNL0U8vTVBNMgly98lIJXClk4aLQ==
X-Received: by 2002:a17:902:d485:b0:151:addf:15a2 with SMTP id c5-20020a170902d48500b00151addf15a2mr3267119plg.2.1646484236360;
        Sat, 05 Mar 2022 04:43:56 -0800 (PST)
Received: from [10.72.13.171] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id bh3-20020a056a02020300b00378b62df320sm6877474pgb.73.2022.03.05.04.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Mar 2022 04:43:55 -0800 (PST)
Subject: Re: [PATCH 3/3] ceph: add support for encrypted snapshot names
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220304161403.19295-1-lhenriques@suse.de>
 <20220304161403.19295-4-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <7e78567d-5729-9890-a309-d75b6c1c098e@redhat.com>
Date:   Sat, 5 Mar 2022 20:43:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220304161403.19295-4-lhenriques@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/5/22 12:14 AM, Luís Henriques wrote:
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
> index 934402f5e9e6..17d2f18a1fd1 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -1069,6 +1069,15 @@ static int ceph_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
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
> +			spin_unlock(&dentry->d_lock);
> +		}

Yeah, this fix looks cool.


>   	} else if (ceph_snap(dir) == CEPH_NOSNAP) {
>   		dout("mkdir dir %p dn %p mode 0%ho\n", dir, dentry, mode);
>   		op = CEPH_MDS_OP_MKDIR;
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 8b0832271fdf..357335a11384 100644
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
>   	if (inode->i_state & I_NEW) {
>   		inode->i_op = &ceph_snapdir_iops;
>   		inode->i_fop = &ceph_snapdir_fops;
>

