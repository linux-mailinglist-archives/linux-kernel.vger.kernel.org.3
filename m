Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FC24F5A9F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238598AbiDFKBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 06:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244309AbiDFKAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 06:00:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8293A4B3386
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 23:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649226529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l/O6WJnzHeES5MzV1iHizq7+45V776U6yPTcrafzRys=;
        b=F3MBjAZxdmG7U0BXiXbyjSLxdakTuLOO8ABuOd5kNDIdCC6GQkvxfyfmuF2nfA+7u9D0KO
        SqEsgXDzGitHRlNZVjfmq/dPX7qgYeHcrLDPPz9FLeRkw1YaOGyeXnGsTzJXBWBHLSVhqH
        k18newDT0wFNLzheKFK/DhFtsz+L8GA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-fJWpoN9aN5yisBIgDISQmA-1; Wed, 06 Apr 2022 02:28:48 -0400
X-MC-Unique: fJWpoN9aN5yisBIgDISQmA-1
Received: by mail-pj1-f70.google.com with SMTP id rm11-20020a17090b3ecb00b001c713925e58so3187859pjb.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 23:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=l/O6WJnzHeES5MzV1iHizq7+45V776U6yPTcrafzRys=;
        b=tU3cSg+AH5a3h/CbnfNMwseEOJuikRtNKJdWZGe+s4MRoVGj8luEQfhwMKcmMhKhML
         tCcaXFj6Q6fvt9aQD1MnvmiFNF9LW/I20t/c68vLVtXcSfgUt0FuTsiyCZRKIkAR2XE2
         vwhhSJcohiA3kk8u2qKLC80h3mBLZQwviB55BDnnjWgmmI/OMrSRWqzc/guaX749iumV
         yISrKlrut+iLCjNNeD+8ZVvfdkWjfPmyX4tGBc3/mjmbbP/H9TzjTtoorfNMomG1vaKN
         vn8yv98F6vc5hbfhr0dT6nMsP103XzFg9ngiDL0zvPWNDzX6Uht4iz3xIs23CDTSxB5Z
         0qXw==
X-Gm-Message-State: AOAM530JDjVEUYt0Uyf4uLP8hZukd2Gh+G7NcgH7Fj6K1YITBLwp+2Ux
        n0ROy0VCisgZQe6AYnl8LuARoBsxjLjzSpgDyS9+s5nl0op8mRAgjmCEowOgUxNmDC++V4nvWy+
        R4skGszjAiMsdMTKE6GDxRMEIqBwnmN6m2A3+VkGqt9R13K3F8fRTNlNv57LRgnXd7umUEfTyCA
        ==
X-Received: by 2002:a17:903:1210:b0:151:fa59:95ef with SMTP id l16-20020a170903121000b00151fa5995efmr7366395plh.57.1649226526833;
        Tue, 05 Apr 2022 23:28:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZvWs4H8FX933o5QmfCgBqAZoT7G4kIpX1kSIZuQfv64mCK+4K29iDcIHPX48Uz7K6jAic+g==
X-Received: by 2002:a17:903:1210:b0:151:fa59:95ef with SMTP id l16-20020a170903121000b00151fa5995efmr7366376plh.57.1649226526509;
        Tue, 05 Apr 2022 23:28:46 -0700 (PDT)
Received: from [10.72.13.31] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f15-20020a056a001acf00b004fb2ad05521sm17845124pfv.215.2022.04.05.23.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 23:28:45 -0700 (PDT)
Subject: Re: [PATCH v2] ceph: invalidate pages when doing DIO in encrypted
 inodes
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220401133243.1075-1-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <d6407dd1-b6df-4de4-fe37-71b765b2088a@redhat.com>
Date:   Wed, 6 Apr 2022 14:28:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220401133243.1075-1-lhenriques@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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

The above has already invalidated the pages, why doesn't it work ?

-- Xiubo

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

