Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76274F8C21
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiDHCtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 22:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiDHCtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 22:49:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0DDBBF64
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 19:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649386065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hqW8d1OLA7Y9iadlUnkgKcFa9rHdusyjgClqd2kz4/g=;
        b=I0OMt4LPgKgMLYV8z+AMjtqIx7gD0B6VrRgZ3n4VTY1lCcSWjP3mTGuV5qM2ZTBXvg0zWx
        DQqITPvDDR2/OXoloK6Eqt251oHeCayESmmc7Gz5j9U5XLA/vRqEmLIF9Uo989WBz57/CV
        BO8yg8zV2D9H7CqN6ATOSbJ8xhKy4e8=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661--skMFhfdMLGEazMx6UMEgg-1; Thu, 07 Apr 2022 22:47:44 -0400
X-MC-Unique: -skMFhfdMLGEazMx6UMEgg-1
Received: by mail-pf1-f199.google.com with SMTP id d5-20020a62f805000000b0050566b4f4c0so2176302pfh.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 19:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hqW8d1OLA7Y9iadlUnkgKcFa9rHdusyjgClqd2kz4/g=;
        b=i9EKbH3p8SbXiX2xzxzKrBqEznODOT88OMY+hYxZOqJTrDG5muiaPl/ufcdQ/Y5OZn
         zYraGHENCqxBZWNYjh6Zh6h5QHuLwq1IHxVqDghaZyGf/jSYeOUAAm9Rnnm9kAlw8Szn
         1hgURrj2etIFUy97K5um2XbVV9hSZHHti+MLQ5o/ipHi1rx3n0TFMvOrSMZbvTLR12SB
         wyQR2O7hFgiMU+ezCNZTpOIvnejGqNwHOQoS1oaToqdScyfzW80wIVmBi/C9X5c5bAg4
         pNyA6QDx3fIHJBvZCyMUQA6l7a9IXS1NsZr2bizM5gNNJZs9LH/4qRiNhB64IrL3pH1G
         oamw==
X-Gm-Message-State: AOAM533ELya3HsO30J/nFEt2la9IWBUZR3tekNFzgvx8avgXjCF3idkB
        7hc1Cov5zpjqbT3pznLPsLisCLPlV0ZB4SBFkSfMsCmUqhKbT0R8nt4DSJ3KEvCf0rWUW2hmrB5
        PUMT6SX0O+SuomskfhvkcGzj/8foKlqRaPMGfVcYAgxBkS1WKgXs6/7ibp8/uDx+0ZzqbZ6tFXQ
        ==
X-Received: by 2002:a17:90b:2242:b0:1c6:80e3:71b6 with SMTP id hk2-20020a17090b224200b001c680e371b6mr19189246pjb.152.1649386063443;
        Thu, 07 Apr 2022 19:47:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrA8ySa9lcDYRnbcJPHwP5hG2NP90cq3X0zXkIlasV1evG8cuqWmpvkSQ3C2jpmxqZf/n39Q==
X-Received: by 2002:a17:90b:2242:b0:1c6:80e3:71b6 with SMTP id hk2-20020a17090b224200b001c680e371b6mr19189228pjb.152.1649386063072;
        Thu, 07 Apr 2022 19:47:43 -0700 (PDT)
Received: from [10.72.12.194] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v16-20020aa78090000000b0050583cb0adbsm436241pff.196.2022.04.07.19.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 19:47:42 -0700 (PDT)
Subject: Re: [PATCH v4] ceph: invalidate pages when doing direct/sync writes
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220407151521.7968-1-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <0133ed11-bb90-9337-e787-66851cbbc379@redhat.com>
Date:   Fri, 8 Apr 2022 10:47:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220407151521.7968-1-lhenriques@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/7/22 11:15 PM, Luís Henriques wrote:
> When doing a direct/sync write, we need to invalidate the page cache in
> the range being written to.  If we don't do this, the cache will include
> invalid data as we just did a write that avoided the page cache.
>
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>   fs/ceph/file.c | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)
>
> Changes since v3:
> - Dropped initial call to invalidate_inode_pages2_range()
> - Added extra comment to document invalidation
>
> Changes since v2:
> - Invalidation needs to be done after a write
>
> Changes since v1:
> - Replaced truncate_inode_pages_range() by invalidate_inode_pages2_range
> - Call fscache_invalidate with FSCACHE_INVAL_DIO_WRITE if we're doing DIO
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 5072570c2203..97f764b2fbdd 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1606,11 +1606,6 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
>   		return ret;
>   
>   	ceph_fscache_invalidate(inode, false);
> -	ret = invalidate_inode_pages2_range(inode->i_mapping,
> -					    pos >> PAGE_SHIFT,
> -					    (pos + count - 1) >> PAGE_SHIFT);
> -	if (ret < 0)
> -		dout("invalidate_inode_pages2_range returned %d\n", ret);
>   
>   	while ((len = iov_iter_count(from)) > 0) {
>   		size_t left;
> @@ -1938,6 +1933,20 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
>   			break;
>   		}
>   		ceph_clear_error_write(ci);
> +
> +		/*
> +		 * we need to invalidate the page cache here, otherwise the
> +		 * cache will include invalid data in direct/sync writes.
> +		 */
> +		ret = invalidate_inode_pages2_range(
> +				inode->i_mapping,
> +				pos >> PAGE_SHIFT,
> +				(pos + len - 1) >> PAGE_SHIFT);
> +		if (ret < 0) {
> +			dout("invalidate_inode_pages2_range returned %d\n",
> +			     ret);
> +			ret = 0;

For this, IMO it's not safe. If we just ignore it the pagecache will 
still have invalid data.

I think what the 'ceph_direct_read_write()' does is more correct, it 
will make sure all the dirty pages are writeback from the pagecaches by 
using 'invalidate_inode_pages2_range()' without blocking and later will 
do the invalidate blocked by using 'truncate_inode_pages_range()' if 
some pages are not unmaped in 'invalidate_inode_pages2_range()' when EBUSY.

This can always be sure that the pagecache has no invalid data after 
write finishes. I think why it use the truncate helper here is because 
it's safe and there shouldn't have any buffer write happen for DIO ?

But from my understanding the 'ceph_direct_read_write()' is still buggy. 
What if the page fault happen just after 'truncate_inode_pages_range()' 
? Will this happen ? Should we leave this to use the file lock to 
guarantee it in user space ?

Thought ?

-- Xiubo

> +		}
>   		pos += len;
>   		written += len;
>   		dout("sync_write written %d\n", written);
>

