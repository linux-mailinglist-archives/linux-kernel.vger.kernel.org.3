Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0E54F7340
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 05:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240069AbiDGDYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 23:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240455AbiDGDWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 23:22:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14413136C0A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 20:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649301557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HxLz3zyHyqBNEl5mzLYOYDAekjUvwtI7JSOgfNa7qL0=;
        b=W32fv6OMSaSmxoAiJ8Jfi8HgwVzkUK25h+DYq7YxG8EeA12IiPgWKNdW7nIqBefE0KJR/r
        2SOUgi9HFffUGwal0fQfM2dCBGNdm6d+VxQeNeRBFHZqUKAQkdHhm6WEDuVF9qAO4e4M8s
        BMQ9o6yUsCFYvGPNIIz9JyMRjCshWJE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-318-LiLMm_LqO36FX2BuPpmi3g-1; Wed, 06 Apr 2022 23:19:16 -0400
X-MC-Unique: LiLMm_LqO36FX2BuPpmi3g-1
Received: by mail-pj1-f71.google.com with SMTP id oj16-20020a17090b4d9000b001c7552b7546so4979067pjb.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 20:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HxLz3zyHyqBNEl5mzLYOYDAekjUvwtI7JSOgfNa7qL0=;
        b=0mUIbM18K5G3Vw6eJpwaYGRKFffRZuyVkdc+I8sZdjrg8E+aiTfjHuByhshS3boY20
         wSNO7X7KfcW7aWUt25ovSchxB/Wa2BkfW1HpueQWs5QVaoFPJaPufAzggS66/Bhus6tR
         1h3PRhta0lRN7E3CpnNMwWwUTQ5mLEDt8ZNAomqrS35AwGPr39/iEcbiYA6aHLnHy1GA
         3iUNUPsJ6A5/hHBBaZdCL6EKO1Zc3tZoNB9nA63qi2cjnCoOH7G4ydCu7xIR1b5bgq8o
         Q+lB2TvvMf4jGbvUv3ccMD3NO+lZHaMi3EKhaFNLhI9HgglfBkb7j2lwfd66Q4va/r4k
         3C8A==
X-Gm-Message-State: AOAM532JbM+SeHfuP5/uKfUZeQ/QvqxrnjP8tCypBgR0QW6UcNm3SBkY
        yOgV/PvuavzQaasRQOPNjsWAHmiplN5kxWCJI6zvKtltzLhI6LQja8M+q21q94CJ8HIkgEYK6Ts
        F31iZDmpm0XNK/LIdBgdXGwLrMnW6ZMwZmDi0Bzfq6wbkvMwO6Jw4Nif/lfPTHCokCszJQMIwdQ
        ==
X-Received: by 2002:a17:903:32c9:b0:154:3a2d:fa89 with SMTP id i9-20020a17090332c900b001543a2dfa89mr11669548plr.3.1649301554749;
        Wed, 06 Apr 2022 20:19:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy47UeQA/BP4Recw3IDaoEcCmADnEMZ9FV5jr8lqu5QzGPbvQbcgymjzAy4WASLErv/HqHk3g==
X-Received: by 2002:a17:903:32c9:b0:154:3a2d:fa89 with SMTP id i9-20020a17090332c900b001543a2dfa89mr11669531plr.3.1649301554379;
        Wed, 06 Apr 2022 20:19:14 -0700 (PDT)
Received: from [10.72.13.31] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7820e000000b004f7134a70cdsm20010617pfi.61.2022.04.06.20.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 20:19:13 -0700 (PDT)
Subject: Re: [PATCH v2] ceph: invalidate pages when doing DIO in encrypted
 inodes
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220401133243.1075-1-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <cd8418a0-e0dc-c5ae-d49d-6248bb6fc4d6@redhat.com>
Date:   Thu, 7 Apr 2022 11:19:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220401133243.1075-1-lhenriques@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

Please try the following patch, to see could it resolve your issue:


diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 5d39d8e54273..3507e4066de4 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2011,6 +2011,7 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, 
struct iov_iter *to)
                      ceph_cap_string(got));

                 if (ci->i_inline_version == CEPH_INLINE_NONE) {
+ filemap_invalidate_lock(inode->i_mapping);
                         if (!retry_op &&
                             (iocb->ki_flags & IOCB_DIRECT) &&
                             !IS_ENCRYPTED(inode)) {
@@ -2021,6 +2022,7 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, 
struct iov_iter *to)
                         } else {
                                 ret = ceph_sync_read(iocb, to, &retry_op);
                         }
+ filemap_invalidate_unlock(inode->i_mapping);
                 } else {
                         retry_op = READ_INLINE;
                 }
@@ -2239,11 +2241,13 @@ static ssize_t ceph_write_iter(struct kiocb 
*iocb, struct iov_iter *from)

                 /* we might need to revert back to that point */
                 data = *from;
+               filemap_invalidate_lock(inode->i_mapping);
                 if ((iocb->ki_flags & IOCB_DIRECT) && !IS_ENCRYPTED(inode))
                         written = ceph_direct_read_write(iocb, &data, 
snapc,
&prealloc_cf);
                 else
                         written = ceph_sync_write(iocb, &data, pos, snapc);
+               filemap_invalidate_unlock(inode->i_mapping);
                 if (direct_lock)
                         ceph_end_io_direct(inode);
                 else



On 4/1/22 9:32 PM, Luís Henriques wrote:
> When doing DIO on an encrypted node, we need to invalidate the page cache in
> the range being written to, otherwise the cache will include invalid data.
>
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>   fs/ceph/file.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> Changes since v1:
> - Replaced truncate_inode_pages_range() by invalidate_inode_pages2_range
> - Call fscache_invalidate with FSCACHE_INVAL_DIO_WRITE if we're doing DIO
>
> Note: I'm not really sure this last change is required, it doesn't really
> affect generic/647 result, but seems to be the most correct.
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 5072570c2203..b2743c342305 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1605,7 +1605,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
>   	if (ret < 0)
>   		return ret;
>   
> -	ceph_fscache_invalidate(inode, false);
> +	ceph_fscache_invalidate(inode, (iocb->ki_flags & IOCB_DIRECT));
>   	ret = invalidate_inode_pages2_range(inode->i_mapping,
>   					    pos >> PAGE_SHIFT,
>   					    (pos + count - 1) >> PAGE_SHIFT);
> @@ -1895,6 +1895,15 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
>   		req->r_inode = inode;
>   		req->r_mtime = mtime;
>   
> +		if (IS_ENCRYPTED(inode) && (iocb->ki_flags & IOCB_DIRECT)) {
> +			ret = invalidate_inode_pages2_range(
> +				inode->i_mapping,
> +				write_pos >> PAGE_SHIFT,
> +				(write_pos + write_len - 1) >> PAGE_SHIFT);
> +			if (ret < 0)
> +				dout("invalidate_inode_pages2_range returned %d\n", ret);
> +		}
> +
>   		/* Set up the assertion */
>   		if (rmw) {
>   			/*
>

