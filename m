Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1D84F63A6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbiDFPn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236261AbiDFPnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:43:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DF234E6F66
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 06:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649250617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yd6as5x4Uder5Km5LfKQ4Jc4Svl079Qfrglg3q3KIGk=;
        b=HpSae94zP5Mh/o4U9jcoJgPQD3oJOP2oDtFkkPjVj4lX/NgVzy5cuNTStVVNGn0CaxTgqL
        MVq/gJ/CzfiaJy+qsz9X+tME/fgEuHJWN3ChDvpwpswkBhBhijSKPDyqhp9XM+L6ME7vb0
        baDpc0M+AdGa0irgCnTp1yfSklIZAC8=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-vbbORDxsOwKnBDYmN34Sag-1; Wed, 06 Apr 2022 09:10:16 -0400
X-MC-Unique: vbbORDxsOwKnBDYmN34Sag-1
Received: by mail-pf1-f197.google.com with SMTP id 138-20020a621690000000b004fa807ac59aso1511220pfw.19
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 06:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yd6as5x4Uder5Km5LfKQ4Jc4Svl079Qfrglg3q3KIGk=;
        b=M8Ie6Cy4PSXdiPy/e6r5LOjovELkMlfnfv4XL7RLAmm0fn5RrkCbm220rqbXOCVvV/
         9Nmt2v38PTLCpRHA+ZLqYlF/P8jTWqdtAtvZs2yFny+87rIA0PLfNRe0PedD7ZkC8aMb
         iJ2kuydy7NACWfH7t4hyx8o6WyNydM3FlpWchnuXhGj/777VX0qRxmpD3bEktopQQES9
         6DM57hj67C0hsdp95ezgvN2cbVIB4KkAay6xy0oaKFfJS5ZRum71ww6Y4sJFaGYBLgFx
         KTcVs12qCxATeU7DRQlw3KrroNS2m4Xl6TkY0gnxzXMXSjKyLOt7dWerA7WGJ7VOkub2
         VVjQ==
X-Gm-Message-State: AOAM530kjbwZut56vJmEacUhZLKf2EaMwUTx+aZAoX/iMW1GaEy1CB31
        oOHARxFtWS4kQHZMEq1pN91lq/TcywThijEuR08CsnsNyYqFdtVr9Pv+imEr5oIi4mo/X6ZDjHs
        s50ybziuBfpr3l/ioTiigJBvW1eESFRBDq1LDFEnQfm/BhfYnUASLQklT05eKmRATA7DUsJv3Ow
        ==
X-Received: by 2002:a17:902:ec8c:b0:154:2e86:dd51 with SMTP id x12-20020a170902ec8c00b001542e86dd51mr8499226plg.99.1649250614718;
        Wed, 06 Apr 2022 06:10:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvbAXpSSJUN/XclP4SvB61CbwxC/5xeSpV0OVsNgIMTBh7V98gA3lkyZQfVkB3JKBtgVNG1g==
X-Received: by 2002:a17:902:ec8c:b0:154:2e86:dd51 with SMTP id x12-20020a170902ec8c00b001542e86dd51mr8499189plg.99.1649250614344;
        Wed, 06 Apr 2022 06:10:14 -0700 (PDT)
Received: from [10.72.13.31] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h20-20020a056a001a5400b004fb1b4b010asm19651730pfv.162.2022.04.06.06.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 06:10:13 -0700 (PDT)
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
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <321104e6-36db-c143-a7ba-58f9199e6fb7@redhat.com>
Date:   Wed, 6 Apr 2022 21:10:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <6306fba71325483a1ea22fa73250c8777ea647d7.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
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


On 4/6/22 7:48 PM, Jeff Layton wrote:
> On Wed, 2022-04-06 at 12:33 +0100, Luís Henriques wrote:
>> Xiubo Li <xiubli@redhat.com> writes:
>>
>>> On 4/6/22 6:57 PM, Luís Henriques wrote:
>>>> Xiubo Li <xiubli@redhat.com> writes:
>>>>
>>>>> On 4/1/22 9:32 PM, Luís Henriques wrote:
>>>>>> When doing DIO on an encrypted node, we need to invalidate the page cache in
>>>>>> the range being written to, otherwise the cache will include invalid data.
>>>>>>
>>>>>> Signed-off-by: Luís Henriques <lhenriques@suse.de>
>>>>>> ---
>>>>>>     fs/ceph/file.c | 11 ++++++++++-
>>>>>>     1 file changed, 10 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> Changes since v1:
>>>>>> - Replaced truncate_inode_pages_range() by invalidate_inode_pages2_range
>>>>>> - Call fscache_invalidate with FSCACHE_INVAL_DIO_WRITE if we're doing DIO
>>>>>>
>>>>>> Note: I'm not really sure this last change is required, it doesn't really
>>>>>> affect generic/647 result, but seems to be the most correct.
>>>>>>
>>>>>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>>>>>> index 5072570c2203..b2743c342305 100644
>>>>>> --- a/fs/ceph/file.c
>>>>>> +++ b/fs/ceph/file.c
>>>>>> @@ -1605,7 +1605,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
>>>>>>     	if (ret < 0)
>>>>>>     		return ret;
>>>>>>     -	ceph_fscache_invalidate(inode, false);
>>>>>> +	ceph_fscache_invalidate(inode, (iocb->ki_flags & IOCB_DIRECT));
>>>>>>     	ret = invalidate_inode_pages2_range(inode->i_mapping,
>>>>>>     					    pos >> PAGE_SHIFT,
>>>>>>     					    (pos + count - 1) >> PAGE_SHIFT);
>>>>> The above has already invalidated the pages, why doesn't it work ?
>>>> I suspect the reason is because later on we loop through the number of
>>>> pages, call copy_page_from_iter() and then ceph_fscrypt_encrypt_pages().
>>> Checked the 'copy_page_from_iter()', it will do the kmap for the pages but will
>>> kunmap them again later. And they shouldn't update the i_mapping if I didn't
>>> miss something important.
>>>
>>> For 'ceph_fscrypt_encrypt_pages()' it will encrypt/dencrypt the context inplace,
>>> IMO if it needs to map the page and it should also unmap it just like in
>>> 'copy_page_from_iter()'.
>>>
>>> I thought it possibly be when we need to do RMW, it may will update the
>>> i_mapping when reading contents, but I checked the code didn't find any
>>> place is doing this. So I am wondering where tha page caches come from ? If that
>>> page caches really from reading the contents, then we should discard it instead
>>> of flushing it back ?
>>>
>>> BTW, what's the problem without this fixing ? xfstest fails ?
>> Yes, generic/647 fails if you run it with test_dummy_encryption.  And I've
>> also checked that the RMW code was never executed in this test.
>>
>> But yeah I have assumed (perhaps wrongly) that the kmap/kunmap could
>> change the inode->i_mapping.
>>
> No, kmap/unmap are all about high memory and 32-bit architectures. Those
> functions are usually no-ops on 64-bit arches.

Yeah, right.

So they do nothing here.

>> In my debugging this seemed to be the case
>> for the O_DIRECT path.  That's why I added this extra call here.
>>
> I agree with Xiubo that we really shouldn't need to invalidate multiple
> times.
>
> I guess in this test, we have a DIO write racing with an mmap read
> Probably what's happening is either that we can't invalidate the page
> because it needs to be cleaned, or the mmap read is racing in just after
> the invalidate occurs but before writeback.

This sounds a possible case.


> In any case, it might be interesting to see whether you're getting
> -EBUSY back from the new invalidate_inode_pages2 calls with your patch.
>
If it's really this case maybe this should be retried some where ?

-- Xiubo


