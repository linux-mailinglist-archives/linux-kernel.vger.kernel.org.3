Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFFB4F61D9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbiDFOd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbiDFOdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:33:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42FF95A6290
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 03:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649242632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CLEUfzP7V1U1D4TPRCoAdSvmcyEwuTYxfJcwrVTrZLs=;
        b=cXIhCfoavPk3yTtu2aIpLVQRywwxFt4m8cSnn3yM8oezvJyniRTEbiabaFy/7XjqwwQssg
        vhiq+SPGMljwt+0icESQ+EjZ647A3Tb2aTho6v9+VkkVA2qYhZh/S5WuCiioa/gt7MItDw
        S5c/K5JrvIp7UAVI7Mtnsz903lbXmrw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-IGO3JEaXOn6q2LYR5X7fqg-1; Wed, 06 Apr 2022 06:57:12 -0400
X-MC-Unique: IGO3JEaXOn6q2LYR5X7fqg-1
Received: by mail-pj1-f70.google.com with SMTP id w3-20020a17090ac98300b001b8b914e91aso1499238pjt.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 03:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=CLEUfzP7V1U1D4TPRCoAdSvmcyEwuTYxfJcwrVTrZLs=;
        b=xhcplPGrgIpr5Y8WsJCortfcGLF+OcciCjGxZHTqdRG4C2dje/mH9KTVIpR9lNZckH
         iykSqsuGBnFKRSH8LeSlOyemxtXZwTkk5yjDrOdN5hnSOiVjMGIrBQqFQLnYMq+zakcG
         mYHe2bOmstjITUPRjZrQ/Le6PNbZoZPBOymorhziwHTzLvTfPEIUdA6vb7adD3ggESUw
         meAwn96fPm81ritGDGUcRELPb3iBI/mmIAHTnVfEduXhw07Bl7nKLSE2OiA1EXigFFo4
         +qG0RnxB2WRl7wdlEWXha4ZWBb8VEZA3Frj2U9ZCJFiSuxWo72ve1EgHU+qkm0pZFc7X
         MLCg==
X-Gm-Message-State: AOAM5306fLYRtDJ1PJkGEI7P/BdXOeaqZ8rhA6iOQ2q06Tpoiirpmh4P
        5/P+5cgx33/NXvfLN3GhDHYTac9Q+Yr+C4Kp05uMP3+ZAQfmZAHrHxqYrZILZusS3PcvSaBgCb1
        0xo72M5Ga/O/c+IXgsw5lwGXDnnsk6hyLklXD6nWcpZNHwQ1p8rF21XFNALH9/PvFGEr/qWlzeg
        ==
X-Received: by 2002:a17:902:c94c:b0:154:45c6:fbea with SMTP id i12-20020a170902c94c00b0015445c6fbeamr8070320pla.117.1649242630617;
        Wed, 06 Apr 2022 03:57:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjzQPGc5o/jOgRyYCPg9MggcTrzmcnrWA8qdPmr0rX7qUFNgcHSOLTjHMgqRPHp3D0zoMsKw==
X-Received: by 2002:a17:902:c94c:b0:154:45c6:fbea with SMTP id i12-20020a170902c94c00b0015445c6fbeamr8070295pla.117.1649242630261;
        Wed, 06 Apr 2022 03:57:10 -0700 (PDT)
Received: from [10.72.13.31] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y2-20020a056a00190200b004fa865d1fd3sm18859324pfi.86.2022.04.06.03.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 03:57:09 -0700 (PDT)
Subject: Re: [PATCH v2] ceph: invalidate pages when doing DIO in encrypted
 inodes
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220401133243.1075-1-lhenriques@suse.de>
 <5146f7a8-94c1-a7aa-db2d-d3ae98c5b83a@redhat.com>
 <87fsmqa3jj.fsf@brahms.olymp>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <6d8df20e-d99a-0f80-f3e1-3c661351759c@redhat.com>
Date:   Wed, 6 Apr 2022 18:57:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87fsmqa3jj.fsf@brahms.olymp>
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


On 4/6/22 6:50 PM, Luís Henriques wrote:
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
>>> @@ -1895,6 +1895,15 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
>>>    		req->r_inode = inode;
>>>    		req->r_mtime = mtime;
>>>    +		if (IS_ENCRYPTED(inode) && (iocb->ki_flags & IOCB_DIRECT)) {
>>> +			ret = invalidate_inode_pages2_range(
>>> +				inode->i_mapping,
>>> +				write_pos >> PAGE_SHIFT,
>>> +				(write_pos + write_len - 1) >> PAGE_SHIFT);
>>> +			if (ret < 0)
>>> +				dout("invalidate_inode_pages2_range returned %d\n", ret);
>>> +		}
>> Shouldn't we fail it if the 'invalidate_inode_pages2_range()' fails here ?
> Yeah, I'm not really sure.  I'm simply following the usual pattern where
> an invalidate_inode_pages2_range() failure is logged and ignored.  And
> this is not ceph-specific, other filesystems seem to do the same thing.

I think it should be they are using this to invalidate the range only, 
do not depend on it to writeback the dirty pages.

Such as they may will call 'filemap_fdatawrite_range()', etc.

I saw in the beginning of the 'ceph_sync_write()', it will do 
'filemap_write_and_wait_range()' too. So the dirty pages should have 
already flushed.

-- Xiubo



> Cheers,

