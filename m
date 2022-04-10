Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D214FAB68
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 03:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbiDJBiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 21:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbiDJBiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 21:38:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A98F89FEE
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 18:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649554557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6bdrTdEpXoC+pRTN3T6C67mZheo1ZjP0xTUA8lSZ2Xg=;
        b=W7XiMUBAU7UkD+K0LFCTRwTe/FgP4DITvjNWQXjGQpP//+kawHTqU1ZVyidCBioXcMlOrP
        TOqdNESUuoD9IZx5uji2dSQlxDsEF/YhQRFGanGqCcav1EWsrYSdUfZeBCnHrTgAX94kk3
        QznQ16j4jtl+yvYU7Bc0nllc2E7YLms=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-il_d94-9PNmodifyZa73cQ-1; Sat, 09 Apr 2022 21:35:56 -0400
X-MC-Unique: il_d94-9PNmodifyZa73cQ-1
Received: by mail-pj1-f72.google.com with SMTP id l2-20020a17090ad10200b001ca56de815aso6652465pju.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 18:35:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6bdrTdEpXoC+pRTN3T6C67mZheo1ZjP0xTUA8lSZ2Xg=;
        b=sthwp9PBEH67rwgf7NVYxHZXA2BGpL6nRed/rcjQuSM5DKARo5jq3/R/6mkiv9u0Qo
         OaZ8iijieZ6/rSaV6FCtMSmh3iL9N7rAhk7/E+3DV4lpdo4xCC1+uG9ZXYct9zsuaouJ
         z7TPEwgzfOmr3LvaaOv4XYg+5xpp6XQSVox51LAbvpeavjMRn38XJ5xdb7nBSI78HIu/
         Sf8AYSBjxqyt/K9vyjKuH9Ihr8TxD380v3hTlehI4FcOdNejhA8rrXwOoB1Yv51PgScW
         HBBcOb43JPf1RdORuCQzCSlvUiqs/mczU2W4MjbXB3KBA3bd2f6FTOj/niLi+dHhPaTt
         ZW8g==
X-Gm-Message-State: AOAM531bgFM5KOShas2UCXt4Lu7Znmizwz41ohmBxS4GNuH/sSjxVL/o
        MKsXi47WrMOAgU0aWUS4COhj5mxY25HwLd33OktJA/kRq9gTFwZrgdb9+CS9umFhPEdTMa8H835
        Vn8KJ8iW4ViZQBA9PY4Y7oifdqiGZkkJFJAsZFgMx3Uf1T2vw6fL1hb0tbMEG4nItd0nVsuuzYA
        ==
X-Received: by 2002:a65:554c:0:b0:39c:ec55:3149 with SMTP id t12-20020a65554c000000b0039cec553149mr10322444pgr.372.1649554554823;
        Sat, 09 Apr 2022 18:35:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+nuE8WXZx11sQrwKJH19Z9/KpqHfoZ/RQEX2751CNQp6WtaHMVSwxbh7srPiFuoYv00hgXQ==
X-Received: by 2002:a65:554c:0:b0:39c:ec55:3149 with SMTP id t12-20020a65554c000000b0039cec553149mr10322428pgr.372.1649554554240;
        Sat, 09 Apr 2022 18:35:54 -0700 (PDT)
Received: from [10.72.12.194] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y16-20020a63b510000000b00398d8b19bbfsm25650856pge.23.2022.04.09.18.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 18:35:53 -0700 (PDT)
Subject: Re: [PATCH v4] ceph: invalidate pages when doing direct/sync writes
To:     Jeff Layton <jlayton@kernel.org>,
        =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220407151521.7968-1-lhenriques@suse.de>
 <0133ed11-bb90-9337-e787-66851cbbc379@redhat.com>
 <947af0b22bf50affa504bc0ca45fb0e290fc7805.camel@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <bf1758b0-5a0f-5c9f-ecdf-e3031fdd9678@redhat.com>
Date:   Sun, 10 Apr 2022 09:35:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <947af0b22bf50affa504bc0ca45fb0e290fc7805.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/8/22 8:04 PM, Jeff Layton wrote:
> On Fri, 2022-04-08 at 10:47 +0800, Xiubo Li wrote:
>> On 4/7/22 11:15 PM, Luís Henriques wrote:
>>> When doing a direct/sync write, we need to invalidate the page cache in
>>> the range being written to.  If we don't do this, the cache will include
>>> invalid data as we just did a write that avoided the page cache.
>>>
>>> Signed-off-by: Luís Henriques <lhenriques@suse.de>
>>> ---
>>>    fs/ceph/file.c | 19 ++++++++++++++-----
>>>    1 file changed, 14 insertions(+), 5 deletions(-)
>>>
>>> Changes since v3:
>>> - Dropped initial call to invalidate_inode_pages2_range()
>>> - Added extra comment to document invalidation
>>>
>>> Changes since v2:
>>> - Invalidation needs to be done after a write
>>>
>>> Changes since v1:
>>> - Replaced truncate_inode_pages_range() by invalidate_inode_pages2_range
>>> - Call fscache_invalidate with FSCACHE_INVAL_DIO_WRITE if we're doing DIO
>>>
>>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>>> index 5072570c2203..97f764b2fbdd 100644
>>> --- a/fs/ceph/file.c
>>> +++ b/fs/ceph/file.c
>>> @@ -1606,11 +1606,6 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
>>>    		return ret;
>>>    
>>>    	ceph_fscache_invalidate(inode, false);
>>> -	ret = invalidate_inode_pages2_range(inode->i_mapping,
>>> -					    pos >> PAGE_SHIFT,
>>> -					    (pos + count - 1) >> PAGE_SHIFT);
>>> -	if (ret < 0)
>>> -		dout("invalidate_inode_pages2_range returned %d\n", ret);
>>>    
>>>    	while ((len = iov_iter_count(from)) > 0) {
>>>    		size_t left;
>>> @@ -1938,6 +1933,20 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
>>>    			break;
>>>    		}
>>>    		ceph_clear_error_write(ci);
>>> +
>>> +		/*
>>> +		 * we need to invalidate the page cache here, otherwise the
>>> +		 * cache will include invalid data in direct/sync writes.
>>> +		 */
>>> +		ret = invalidate_inode_pages2_range(
>>> +				inode->i_mapping,
>>> +				pos >> PAGE_SHIFT,
>>> +				(pos + len - 1) >> PAGE_SHIFT);
>>> +		if (ret < 0) {
>>> +			dout("invalidate_inode_pages2_range returned %d\n",
>>> +			     ret);
>>> +			ret = 0;
>> For this, IMO it's not safe. If we just ignore it the pagecache will
>> still have invalid data.
>>
> That data is not invalid. It's dirty data from a buffered write that
> raced with the DIO/sync write we're handling here. i.e. another write
> came in while we were already processing the DIO write, but after the
> point where we called filemap_write_and_wait.
>
> When two write() calls to the same data are racing like that, the
> outcome is undefined. We can't be certain which one will prevail as the
> kernel could handle them in either order.

Okay, I think you are right.

-- Xiubo

>
> The good news with Ceph/RADOS is that you shouldn't end up with a torn
> write, unless the write happens to span multiple objects. Not much we
> can do about that though.
>
>> I think what the 'ceph_direct_read_write()' does is more correct, it
>> will make sure all the dirty pages are writeback from the pagecaches by
>> using 'invalidate_inode_pages2_range()' without blocking and later will
>> do the invalidate blocked by using 'truncate_inode_pages_range()' if
>> some pages are not unmaped in 'invalidate_inode_pages2_range()' when EBUSY.
>>
> I'm not convinced this is any better, and it's attempting to impose a
> deterministic outcome on a situation that is non-deterministic by
> nature.
>
>> This can always be sure that the pagecache has no invalid data after
>> write finishes. I think why it use the truncate helper here is because
>> it's safe and there shouldn't have any buffer write happen for DIO ?
>>
>> But from my understanding the 'ceph_direct_read_write()' is still buggy.
>> What if the page fault happen just after 'truncate_inode_pages_range()'
>> ? Will this happen ? Should we leave this to use the file lock to
>> guarantee it in user space ?
>>
>> Thought ?
> Again, we can't really predict what the outcome of two racing writes to
> the same area will do, so I don't see that there is a problem.
>

