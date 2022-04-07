Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2062E4F87A5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 21:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244608AbiDGTFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 15:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiDGTF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:05:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2F0823009F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 12:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649358203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pon5Ck2XRRCFnZm9wVEec+ZiDBI1n0xXQ/6Hgy8EXoM=;
        b=gR2/KMeMnw7VtWhP/0dpR4+aMHXcBci+RHnQJTs8CS6AE0ZHBOQIJxO/9IF++vMo17UVW0
        p61OiCtFsqFmTqkbzYRlj5FUbUM/DnTxcWHWOTRt8Tt8KDKt7MFC5AbaMXZj3TdMcYqlpl
        oRWVw8rQhG/5NPUC79q5Dz9m1OTa1ws=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-N5ew9Ys-PMqZECacKm3pTw-1; Thu, 07 Apr 2022 15:03:18 -0400
X-MC-Unique: N5ew9Ys-PMqZECacKm3pTw-1
Received: by mail-pf1-f200.google.com with SMTP id t4-20020a628104000000b005056f132662so874860pfd.21
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 12:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pon5Ck2XRRCFnZm9wVEec+ZiDBI1n0xXQ/6Hgy8EXoM=;
        b=Zyvb2mMebqRo0r6eDFbRWq2Y8N3DtRM8Rk1VMH7UtYxAP0XGGHkqsfKAX8BI8A6/kO
         iJr85cjrVywdMzXI8JfswwaDfRdTKeXElHEvhgN5gMiykk3PnOqHsGI02iVX2iENhXdY
         OQNXqRToXh/KmAf9laDcFpRSiEXk+59A3eArrivela9U+KtYcaaNkJ+u35mraqkIC5Xi
         qrv6UQxxzrr4fIc4um3Qlg6mgByNAmMa/5BhtQ3mCrujRUh8MrJge7Nt3jJY0kSUCUPV
         eC8mlqZM6HbcT4xlxe0JH65CwP0bNKLd6GcOP49cTeWNzC2xYI1mirr2RS+kGaVEC+r9
         DVbg==
X-Gm-Message-State: AOAM530ZqZSYdVxf2+avK12fPMbU5Nd+8qXcxMSGxfwvdXFkCT4mztMq
        sdjoyFvwKF64gXGpRT5akKFD+5JA4WsSXjlCOPysk/b1vGW3GfNgI7SzwS+pxUWhvQjfpA+uyRi
        mQcaSxT3gOjAK4n3e6IZP57RRH8gF2y2AqsLsDnoq48h3ZxPNbAEF/HElkcUvFseB5Pza6iQ3Vw
        ==
X-Received: by 2002:a17:90a:d0c5:b0:1c9:ec78:18e5 with SMTP id y5-20020a17090ad0c500b001c9ec7818e5mr17533278pjw.53.1649358197685;
        Thu, 07 Apr 2022 12:03:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylnAgooOiWm/xSsqvqv4wdUxkJJGLLkqcAUyb8cQzjPAYjuA6jtOkqXKk4Z5O9DTdmxReeoA==
X-Received: by 2002:a17:90a:d0c5:b0:1c9:ec78:18e5 with SMTP id y5-20020a17090ad0c500b001c9ec7818e5mr17533238pjw.53.1649358197272;
        Thu, 07 Apr 2022 12:03:17 -0700 (PDT)
Received: from [10.72.12.194] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 132-20020a62168a000000b004f40e8b3133sm24024855pfw.188.2022.04.07.12.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 12:03:16 -0700 (PDT)
Subject: Re: [PATCH v4] ceph: invalidate pages when doing direct/sync writes
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220407151521.7968-1-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <385d353d-56d8-8f2a-b468-2aae048f59ef@redhat.com>
Date:   Fri, 8 Apr 2022 03:03:10 +0800
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
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
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

IMO we'd better use truncate_inode_pages_range() after write. The above 
means it's possibly will write the dirty pagecache back, which will 
overwrite and corrupt the disk data just wrote.

Though it seems impossible that these pagecaches will be marked dirty, 
but this call is misleading ?

-- Xiubo

> +				inode->i_mapping,
> +				pos >> PAGE_SHIFT,
> +				(pos + len - 1) >> PAGE_SHIFT);
> +		if (ret < 0) {
> +			dout("invalidate_inode_pages2_range returned %d\n",
> +			     ret);
> +			ret = 0;
> +		}
>   		pos += len;
>   		written += len;
>   		dout("sync_write written %d\n", written);
>

