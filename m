Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401A44F7140
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 03:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241157AbiDGBar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 21:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240518AbiDGBUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 21:20:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85BE83ED23
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 18:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649294271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oftguGULgVRWRjOyIsHV27HWOXL6G25bU/S7ICr320k=;
        b=Meg88wFXP+TK8/FopeA8Mj1sYgewg8U2uurq7/W/Uzri5rowFmdAWGkX9Ag5+zUO6MnyET
        bmwbRRMyUKL6ZsD5p5w9+bn1GIyVmtByqehsdPETBMdkKc5YYQvwIcFEEwWwOcSsQ+4vJK
        gEb63+zgqCmv88cU66PWWwvaZv7LkGE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-572-5rZsKNETOIyikl4izkmILg-1; Wed, 06 Apr 2022 21:17:48 -0400
X-MC-Unique: 5rZsKNETOIyikl4izkmILg-1
Received: by mail-pj1-f70.google.com with SMTP id q7-20020a17090a7a8700b001ca823ceb16so2198826pjf.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 18:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=oftguGULgVRWRjOyIsHV27HWOXL6G25bU/S7ICr320k=;
        b=3KC+8LGL3C3wTvJLwM7v9y5WFJMl/hdRL/9qnLODH4/SUsfwQ9j86s2SgM/1hZ6uLJ
         UAjBv31eHae0RwjkeJclxDY8wGVD346u7qw5egIjszAgf+UnHE9TmhE0xsERYs+zRilu
         uyG9YUi3PcHpnjje8V/3ipsqpfYFW59AwW51S5E9M28/UZYj9AcnMyUmVe5CKAh4USUN
         a9zToG9MNzhgr76KZ9wWeyG8BpErikslqaiHJQp3q8v/+vtF53IoJgmvtnFRP4wNSdJO
         84nyahDU68fwGlCMNhs5rhGpxYAA8S/lxLrkCzTMjtMLN5we9SCJtkpY+2Yehn6Vd70l
         ceYQ==
X-Gm-Message-State: AOAM5336G4i6wpLWu5N//J4jC7D7CFyouyLEjg1x/YMRl+DWWQqBIk9R
        gJnM/9OAVylKV6rmfccdN33XRzZfUKtNBATYcmwANdIrwrkeE7V+0V8dlW1hrNqheHQQorbnPC2
        /gdsqNl1HmbYOF/8ySmb3SgLZtj+JzA4YilBAE11zFr0iubJ2+vXrlQISdM73SI3KrI/hvwlzNw
        ==
X-Received: by 2002:a65:6855:0:b0:382:59e5:b6e5 with SMTP id q21-20020a656855000000b0038259e5b6e5mr9334244pgt.586.1649294266472;
        Wed, 06 Apr 2022 18:17:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXt8Kl8wFPHt3m+Avpv3+/5HQr3cNGJMXf8DFd6n/mZPvNtrEmJSEcZxHnoVcqeCy0LVkwpw==
X-Received: by 2002:a65:6855:0:b0:382:59e5:b6e5 with SMTP id q21-20020a656855000000b0038259e5b6e5mr9334227pgt.586.1649294266175;
        Wed, 06 Apr 2022 18:17:46 -0700 (PDT)
Received: from [10.72.13.31] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g70-20020a636b49000000b003823dd39d41sm16907314pgc.64.2022.04.06.18.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 18:17:45 -0700 (PDT)
Subject: Re: [PATCH v2] ceph: invalidate pages when doing DIO in encrypted
 inodes
To:     Jeff Layton <jlayton@kernel.org>,
        =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>
Cc:     Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220401133243.1075-1-lhenriques@suse.de>
 <d6407dd1-b6df-4de4-fe37-71b765b2088a@redhat.com>
 <878rsia391.fsf@brahms.olymp>
 <6ba91390-83e8-8702-2729-dc432abd3cc5@redhat.com>
 <87zgky8n0o.fsf@brahms.olymp>
 <6306fba71325483a1ea22fa73250c8777ea647d7.camel@kernel.org>
 <321104e6-36db-c143-a7ba-58f9199e6fb7@redhat.com>
 <f0ed169ed02fe810076e959e9ec5455d9de4b4ff.camel@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <7023b537-e7b6-0dd9-42bf-9d601ef69b58@redhat.com>
Date:   Thu, 7 Apr 2022 09:17:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <f0ed169ed02fe810076e959e9ec5455d9de4b4ff.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
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


On 4/6/22 9:41 PM, Jeff Layton wrote:
> On Wed, 2022-04-06 at 21:10 +0800, Xiubo Li wrote:
>> On 4/6/22 7:48 PM, Jeff Layton wrote:
>>> On Wed, 2022-04-06 at 12:33 +0100, Luís Henriques wrote:
>>>> Xiubo Li <xiubli@redhat.com> writes:
>>>>
>>>>> On 4/6/22 6:57 PM, Luís Henriques wrote:
>>>>>> Xiubo Li <xiubli@redhat.com> writes:
>>>>>>
>>>>>>> On 4/1/22 9:32 PM, Luís Henriques wrote:
>>>>>>>> When doing DIO on an encrypted node, we need to invalidate the page cache in
>>>>>>>> the range being written to, otherwise the cache will include invalid data.
>>>>>>>>
>>>>>>>> Signed-off-by: Luís Henriques <lhenriques@suse.de>
>>>>>>>> ---
>>>>>>>>      fs/ceph/file.c | 11 ++++++++++-
>>>>>>>>      1 file changed, 10 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> Changes since v1:
>>>>>>>> - Replaced truncate_inode_pages_range() by invalidate_inode_pages2_range
>>>>>>>> - Call fscache_invalidate with FSCACHE_INVAL_DIO_WRITE if we're doing DIO
>>>>>>>>
>>>>>>>> Note: I'm not really sure this last change is required, it doesn't really
>>>>>>>> affect generic/647 result, but seems to be the most correct.
>>>>>>>>
>>>>>>>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>>>>>>>> index 5072570c2203..b2743c342305 100644
>>>>>>>> --- a/fs/ceph/file.c
>>>>>>>> +++ b/fs/ceph/file.c
>>>>>>>> @@ -1605,7 +1605,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
>>>>>>>>      	if (ret < 0)
>>>>>>>>      		return ret;
>>>>>>>>      -	ceph_fscache_invalidate(inode, false);
>>>>>>>> +	ceph_fscache_invalidate(inode, (iocb->ki_flags & IOCB_DIRECT));
>>>>>>>>      	ret = invalidate_inode_pages2_range(inode->i_mapping,
>>>>>>>>      					    pos >> PAGE_SHIFT,
>>>>>>>>      					    (pos + count - 1) >> PAGE_SHIFT);
>>>>>>> The above has already invalidated the pages, why doesn't it work ?
>>>>>> I suspect the reason is because later on we loop through the number of
>>>>>> pages, call copy_page_from_iter() and then ceph_fscrypt_encrypt_pages().
>>>>> Checked the 'copy_page_from_iter()', it will do the kmap for the pages but will
>>>>> kunmap them again later. And they shouldn't update the i_mapping if I didn't
>>>>> miss something important.
>>>>>
>>>>> For 'ceph_fscrypt_encrypt_pages()' it will encrypt/dencrypt the context inplace,
>>>>> IMO if it needs to map the page and it should also unmap it just like in
>>>>> 'copy_page_from_iter()'.
>>>>>
>>>>> I thought it possibly be when we need to do RMW, it may will update the
>>>>> i_mapping when reading contents, but I checked the code didn't find any
>>>>> place is doing this. So I am wondering where tha page caches come from ? If that
>>>>> page caches really from reading the contents, then we should discard it instead
>>>>> of flushing it back ?
>>>>>
>>>>> BTW, what's the problem without this fixing ? xfstest fails ?
>>>> Yes, generic/647 fails if you run it with test_dummy_encryption.  And I've
>>>> also checked that the RMW code was never executed in this test.
>>>>
>>>> But yeah I have assumed (perhaps wrongly) that the kmap/kunmap could
>>>> change the inode->i_mapping.
>>>>
>>> No, kmap/unmap are all about high memory and 32-bit architectures. Those
>>> functions are usually no-ops on 64-bit arches.
>> Yeah, right.
>>
>> So they do nothing here.
>>
>>>> In my debugging this seemed to be the case
>>>> for the O_DIRECT path.  That's why I added this extra call here.
>>>>
>>> I agree with Xiubo that we really shouldn't need to invalidate multiple
>>> times.
>>>
>>> I guess in this test, we have a DIO write racing with an mmap read
>>> Probably what's happening is either that we can't invalidate the page
>>> because it needs to be cleaned, or the mmap read is racing in just after
>>> the invalidate occurs but before writeback.
>> This sounds a possible case.
>>
>>
>>> In any case, it might be interesting to see whether you're getting
>>> -EBUSY back from the new invalidate_inode_pages2 calls with your patch.
>>>
>> If it's really this case maybe this should be retried some where ?
>>
> Possibly, or we may need to implement ->launder_folio.
>
> Either way, we need to understand what's happening first and then we can
> figure out a solution for it.

Yeah, make sense.


