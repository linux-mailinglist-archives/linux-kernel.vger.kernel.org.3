Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155044F6095
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbiDFNt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbiDFNtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:49:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3D2754810C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 04:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649243894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T51nUGVFPsaMwX8h/2sdMdqNeNEULQqvsXIM6IrN6Fo=;
        b=i30Sw88YzN3DFmGrmZDIkBQkO2iL4MAaK/yeVxMocKEIfrqM4/0ifanvE+fYIS3JG50NMV
        +M+UBwBbIWRBHHtGIlFefYIpmiUyfY4Iexo0nJdD9dw6GT3z3qZR/QaVuzOYkw4czMFs09
        vmaBeN2jX7ZpXwk6CvQQJdftIJoM6cs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-338-lW1EL5XgO7eJ0ieOnyaJtg-1; Wed, 06 Apr 2022 07:18:12 -0400
X-MC-Unique: lW1EL5XgO7eJ0ieOnyaJtg-1
Received: by mail-pj1-f70.google.com with SMTP id rm11-20020a17090b3ecb00b001c713925e58so3621918pjb.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 04:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=T51nUGVFPsaMwX8h/2sdMdqNeNEULQqvsXIM6IrN6Fo=;
        b=cT2e1ZlBF90QsdptMBlT5H/0sIdE2/b009ERqppapNVNXHe2LbFlu+G6F8FmoeRTLr
         0qBRegvw+G1whE7ujXIyPNbASuXxo30xxI2eEgxjIhbULExnjtaT8izFJ9jAKJUJ6FxV
         r+USBpB8nXQer7efDrLiPHg+ZcvxzvO0ksymMGR2O3CEs7Dg175fK4ZbZ/SW4AwCaJ2g
         AfeY/DtmziAamsyBZqHnJRmxMQr3VPEYdYIskBylUA70Rw2wKefJ8tq/wgyxQmB6CN0H
         skKXuipAELgq/Ta2EdY7KxWDp8+nXEEOLEURW1zlRjMk4B91de1oFEU5t65tTyGz4V8b
         LvMA==
X-Gm-Message-State: AOAM533qM/vcG0QI/emCZfmwWAbDXVElnU3xs54Msmy73gGbArUwR5nH
        Ifn7J9EK+z16I2zBhIZJxIA8aitw502AE92aLhuJ5dpg4Qn9zz3PGfp9XDdJpSZOZjXOVFvbxSK
        yseAYjV2BM3ZJy5SyWtsG8VTYaUfvnUzGjC+7kK9MvM9rR2DfJwSUhr3TTi0N7zkoOjw8h5xlTw
        ==
X-Received: by 2002:a63:7258:0:b0:398:7298:c4b6 with SMTP id c24-20020a637258000000b003987298c4b6mr6699800pgn.436.1649243891038;
        Wed, 06 Apr 2022 04:18:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8t21PSJeeAJdSmJKtGQjbB4egYfrj8qXnO9fjKJ7QjnIrdPXcNk67JzQEAwqrRHW2XAtrkw==
X-Received: by 2002:a63:7258:0:b0:398:7298:c4b6 with SMTP id c24-20020a637258000000b003987298c4b6mr6699767pgn.436.1649243890639;
        Wed, 06 Apr 2022 04:18:10 -0700 (PDT)
Received: from [10.72.13.31] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id ay9-20020a056a00300900b004fae1346aa1sm17350811pfb.122.2022.04.06.04.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 04:18:09 -0700 (PDT)
Subject: Re: [PATCH v2] ceph: invalidate pages when doing DIO in encrypted
 inodes
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220401133243.1075-1-lhenriques@suse.de>
 <d6407dd1-b6df-4de4-fe37-71b765b2088a@redhat.com>
 <878rsia391.fsf@brahms.olymp>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <6ba91390-83e8-8702-2729-dc432abd3cc5@redhat.com>
Date:   Wed, 6 Apr 2022 19:18:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <878rsia391.fsf@brahms.olymp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/6/22 6:57 PM, Luís Henriques wrote:
> Xiubo Li <xiubli@redhat.com> writes:
>
>> On 4/1/22 9:32 PM, Luís Henriques wrote:
>>> When doing DIO on an encrypted node, we need to invalidate the page cache in
>>> the range being written to, otherwise the cache will include invalid data.
>>>
>>> Signed-off-by: Luís Henriques <lhenriques@suse.de>
>>> ---
>>>    fs/ceph/file.c | 11 ++++++++++-
>>>    1 file changed, 10 insertions(+), 1 deletion(-)
>>>
>>> Changes since v1:
>>> - Replaced truncate_inode_pages_range() by invalidate_inode_pages2_range
>>> - Call fscache_invalidate with FSCACHE_INVAL_DIO_WRITE if we're doing DIO
>>>
>>> Note: I'm not really sure this last change is required, it doesn't really
>>> affect generic/647 result, but seems to be the most correct.
>>>
>>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>>> index 5072570c2203..b2743c342305 100644
>>> --- a/fs/ceph/file.c
>>> +++ b/fs/ceph/file.c
>>> @@ -1605,7 +1605,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
>>>    	if (ret < 0)
>>>    		return ret;
>>>    -	ceph_fscache_invalidate(inode, false);
>>> +	ceph_fscache_invalidate(inode, (iocb->ki_flags & IOCB_DIRECT));
>>>    	ret = invalidate_inode_pages2_range(inode->i_mapping,
>>>    					    pos >> PAGE_SHIFT,
>>>    					    (pos + count - 1) >> PAGE_SHIFT);
>> The above has already invalidated the pages, why doesn't it work ?
> I suspect the reason is because later on we loop through the number of
> pages, call copy_page_from_iter() and then ceph_fscrypt_encrypt_pages().

Checked the 'copy_page_from_iter()', it will do the kmap for the pages 
but will kunmap them again later. And they shouldn't update the 
i_mapping if I didn't miss something important.

For 'ceph_fscrypt_encrypt_pages()' it will encrypt/dencrypt the context 
inplace, IMO if it needs to map the page and it should also unmap it 
just like in 'copy_page_from_iter()'.

I thought it possibly be when we need to do RMW, it may will update the 
i_mapping when reading contents, but I checked the code didn't find any 
place is doing this. So I am wondering where tha page caches come from ? 
If that page caches really from reading the contents, then we should 
discard it instead of flushing it back ?

BTW, what's the problem without this fixing ? xfstest fails ?


-- Xiubo

> Cheers,

