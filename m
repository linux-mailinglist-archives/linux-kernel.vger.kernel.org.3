Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E90853073F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 03:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbiEWBsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 21:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbiEWBr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 21:47:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FE4613FA2
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 18:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653270472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WT+3xtm/1G1Mw0jgI/ctgPUxHtE39wZNH4Ie2eOh0q4=;
        b=ByENKXBXyL/weiRMszwhHpY8zV/cmViXaCy+nNW4mh9k1uJoULQzrxKBPVp0FUPx+MpKAD
        7Kqs7wnDfr1L7B1o1HsACFhO6B0pIGFjiNtk/J4QRLybSZNCqyh/d0/Ijvi0PJvT1Bu9Kz
        Wv7O6fTh0BG9VvHrxhfoCR3FRaHbzy0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-cbYKzbXUOUarL_fAcz5ilA-1; Sun, 22 May 2022 21:47:49 -0400
X-MC-Unique: cbYKzbXUOUarL_fAcz5ilA-1
Received: by mail-pl1-f198.google.com with SMTP id jg18-20020a17090326d200b0016178ae1c69so7181827plb.6
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 18:47:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WT+3xtm/1G1Mw0jgI/ctgPUxHtE39wZNH4Ie2eOh0q4=;
        b=bnBpNK0c/6DMKIU/zdEaU2nT0xGPTc3iKw/gldeprhG9gEfRzvPu+E8d9RIi9O5kL5
         OAn+1GnDIVJmt8GlQ/NaR2TdM18KK3IIjlm0S9WRTMS/fe/8ftbMG8TmlDHYybehnG9t
         6rtaKuldV09cMDlXGwc6uDw7mFMHzljQM3VxgebuGAMJifcC8dX2IW6Cl3/kaZQawdIa
         vPx5r4NU8KUoI2lUEOyH2Q+HObOWVRIOV0v+SBxw1l01YR97uANC6C5RSnWh6gnOqbAo
         6MLzn6HKQDUNNgVsRu0OvogKLLOscYkU9gvzOt70Pawy5TuTpI3VL+H3niHiObCFtYtp
         otLA==
X-Gm-Message-State: AOAM531FBiJh3yCnq8+tnppofetoa+2TJ/U6mYCcRP5n6hQQWzhN67AR
        AlQfH5jxgwmSEWW3pKGhckJqJ4N0FqW1CfUXQnp2MFNFahIF9Yn7mrTMfyJ4IyO9HhpBHHW5Arn
        sjtiYBZM6iK9asNij5/QHBib1NNQGYdB5uGiPhAYSl20IQKX387GAfFvb0aM+vfnN8psD01thGg
        ==
X-Received: by 2002:a63:241:0:b0:3c5:fc11:ab56 with SMTP id 62-20020a630241000000b003c5fc11ab56mr18700305pgc.193.1653270467807;
        Sun, 22 May 2022 18:47:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOaa+JuRwD54B1yigi3Hc4SldL7sk0522tuSkQEjq8Sd8A5z03QukfHyL+m11L7qlmnHbKBA==
X-Received: by 2002:a63:241:0:b0:3c5:fc11:ab56 with SMTP id 62-20020a630241000000b003c5fc11ab56mr18700281pgc.193.1653270467437;
        Sun, 22 May 2022 18:47:47 -0700 (PDT)
Received: from [10.72.12.81] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n11-20020a170902f60b00b0015ef27092aasm3733780plg.190.2022.05.22.18.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 18:47:46 -0700 (PDT)
Subject: Re: [RFC PATCH] ceph: try to prevent exceeding the MDS maximum xattr
 size
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220520115426.438-1-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <13988024-efc7-2ab1-036a-eb1d2b2fbd15@redhat.com>
Date:   Mon, 23 May 2022 09:47:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220520115426.438-1-lhenriques@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/20/22 7:54 PM, Luís Henriques wrote:
> The MDS tries to enforce a limit on the total key/values in extended
> attributes.  However, this limit is enforced only if doing a synchronous
> operation (MDS_OP_SETXATTR) -- if we're buffering the xattrs, the MDS
> doesn't have a chance to enforce these limits.
>
> This patch forces the usage of the synchronous operation if xattrs size hits
> the maximum size that is set on the MDS by default (64k).
>
> While there, fix a dout() that would trigger a printk warning:
>
> [   98.718078] ------------[ cut here ]------------
> [   98.719012] precision 65536 too large
> [   98.719039] WARNING: CPU: 1 PID: 3755 at lib/vsprintf.c:2703 vsnprintf+0x5e3/0x600
> ...
>
> URL: https://tracker.ceph.com/issues/55725
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>   fs/ceph/xattr.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index afec84088471..09751a5f028c 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -15,6 +15,12 @@
>   #define XATTR_CEPH_PREFIX "ceph."
>   #define XATTR_CEPH_PREFIX_LEN (sizeof (XATTR_CEPH_PREFIX) - 1)
>   
> +/*
> + * Maximum size of xattrs the MDS can handle per inode by default.  This
> + * includes the attribute name and 4+4 bytes for the key/value sizes.
> + */
> +#define MDS_MAX_XATTR_PAIRS_SIZE (1<<16) /* 64K */

The max size is changeable in MDS side. Possibly we should do something 
as mentioned in your ceph PR [1].

@Jeff, any better idea ?


[1] 
https://github.com/ceph/ceph/pull/46357/commits/741f8ba36f14774834c0d5618519425ccf1ccc85#r878966753

Thanks.

-- Xiubo


> +
>   static int __remove_xattr(struct ceph_inode_info *ci,
>   			  struct ceph_inode_xattr *xattr);
>   
> @@ -1078,7 +1084,7 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
>   			flags |= CEPH_XATTR_REMOVE;
>   	}
>   
> -	dout("setxattr value=%.*s\n", (int)size, value);
> +	dout("setxattr value size: ld\n", size);
>   
>   	/* do request */
>   	req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
> @@ -1176,8 +1182,13 @@ int __ceph_setxattr(struct inode *inode, const char *name,
>   	spin_lock(&ci->i_ceph_lock);
>   retry:
>   	issued = __ceph_caps_issued(ci, NULL);
> -	if (ci->i_xattrs.version == 0 || !(issued & CEPH_CAP_XATTR_EXCL))
> +	required_blob_size = __get_required_blob_size(ci, name_len, val_len);
> +	if ((ci->i_xattrs.version == 0) || !(issued & CEPH_CAP_XATTR_EXCL) ||
> +	    (required_blob_size >= MDS_MAX_XATTR_PAIRS_SIZE)) {
> +		dout("%s do sync setxattr: version: %llu blob size: %d\n",
> +		     __func__, ci->i_xattrs.version, required_blob_size);
>   		goto do_sync;
> +	}
>   
>   	if (!lock_snap_rwsem && !ci->i_head_snapc) {
>   		lock_snap_rwsem = true;
> @@ -1193,8 +1204,6 @@ int __ceph_setxattr(struct inode *inode, const char *name,
>   	     ceph_cap_string(issued));
>   	__build_xattrs(inode);
>   
> -	required_blob_size = __get_required_blob_size(ci, name_len, val_len);
> -
>   	if (!ci->i_xattrs.prealloc_blob ||
>   	    required_blob_size > ci->i_xattrs.prealloc_blob->alloc_len) {
>   		struct ceph_buffer *blob;
>

