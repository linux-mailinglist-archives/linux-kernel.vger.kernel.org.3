Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C47F4F7E7B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 13:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243580AbiDGL5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbiDGL5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:57:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCAF1C60CA;
        Thu,  7 Apr 2022 04:55:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DFBB0210DF;
        Thu,  7 Apr 2022 11:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649332499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TmJu1bnEAMh5pbHkvMLNhGJCq6uUbOv6A+Hs8FTA6Yc=;
        b=QVWCoPQuwb1k6e0tUsR7Ai53R5YG2BOaLDZGWn6n/F6y+vLXUorF39TAQoNl9zyfUfF/aF
        NIFhd5lG+hlB5J07/9dEAe+yFWViXNmxQdZSMZDALJnxiroMYhomiLwHmdMN+uCWaVZ8wB
        ze3mYBkGwmLO32SEC7je+bMin80cR9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649332499;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TmJu1bnEAMh5pbHkvMLNhGJCq6uUbOv6A+Hs8FTA6Yc=;
        b=UfAU6GOIAHWUsULz1IyM5Sns/azTmnLVjUYktdI9vv2TGVwHmHeYEm0v+J53GpNFz9qjiP
        Tr4hvmSo+lGsI/BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8848513A66;
        Thu,  7 Apr 2022 11:54:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZlhdHhPRTmI8ewAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 07 Apr 2022 11:54:59 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id b8590e82;
        Thu, 7 Apr 2022 11:55:22 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ceph: invalidate pages when doing DIO in encrypted
 inodes
References: <20220401133243.1075-1-lhenriques@suse.de>
        <d6407dd1-b6df-4de4-fe37-71b765b2088a@redhat.com>
        <878rsia391.fsf@brahms.olymp>
        <6ba91390-83e8-8702-2729-dc432abd3cc5@redhat.com>
        <87zgky8n0o.fsf@brahms.olymp>
        <6306fba71325483a1ea22fa73250c8777ea647d7.camel@kernel.org>
        <321104e6-36db-c143-a7ba-58f9199e6fb7@redhat.com>
        <f0ed169ed02fe810076e959e9ec5455d9de4b4ff.camel@kernel.org>
        <7023b537-e7b6-0dd9-42bf-9d601ef69b58@redhat.com>
Date:   Thu, 07 Apr 2022 12:55:22 +0100
In-Reply-To: <7023b537-e7b6-0dd9-42bf-9d601ef69b58@redhat.com> (Xiubo Li's
        message of "Thu, 7 Apr 2022 09:17:40 +0800")
Message-ID: <87pmlt85w5.fsf@brahms.olymp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xiubo Li <xiubli@redhat.com> writes:

> On 4/6/22 9:41 PM, Jeff Layton wrote:
>> On Wed, 2022-04-06 at 21:10 +0800, Xiubo Li wrote:
>>> On 4/6/22 7:48 PM, Jeff Layton wrote:
>>>> On Wed, 2022-04-06 at 12:33 +0100, Lu=C3=ADs Henriques wrote:
>>>>> Xiubo Li <xiubli@redhat.com> writes:
>>>>>
>>>>>> On 4/6/22 6:57 PM, Lu=C3=ADs Henriques wrote:
>>>>>>> Xiubo Li <xiubli@redhat.com> writes:
>>>>>>>
>>>>>>>> On 4/1/22 9:32 PM, Lu=C3=ADs Henriques wrote:
>>>>>>>>> When doing DIO on an encrypted node, we need to invalidate the pa=
ge cache in
>>>>>>>>> the range being written to, otherwise the cache will include inva=
lid data.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>>>>>>>>> ---
>>>>>>>>>      fs/ceph/file.c | 11 ++++++++++-
>>>>>>>>>      1 file changed, 10 insertions(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> Changes since v1:
>>>>>>>>> - Replaced truncate_inode_pages_range() by invalidate_inode_pages=
2_range
>>>>>>>>> - Call fscache_invalidate with FSCACHE_INVAL_DIO_WRITE if we're d=
oing DIO
>>>>>>>>>
>>>>>>>>> Note: I'm not really sure this last change is required, it doesn'=
t really
>>>>>>>>> affect generic/647 result, but seems to be the most correct.
>>>>>>>>>
>>>>>>>>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>>>>>>>>> index 5072570c2203..b2743c342305 100644
>>>>>>>>> --- a/fs/ceph/file.c
>>>>>>>>> +++ b/fs/ceph/file.c
>>>>>>>>> @@ -1605,7 +1605,7 @@ ceph_sync_write(struct kiocb *iocb, struct =
iov_iter *from, loff_t pos,
>>>>>>>>>      	if (ret < 0)
>>>>>>>>>      		return ret;
>>>>>>>>>      -	ceph_fscache_invalidate(inode, false);
>>>>>>>>> +	ceph_fscache_invalidate(inode, (iocb->ki_flags & IOCB_DIRECT));
>>>>>>>>>      	ret =3D invalidate_inode_pages2_range(inode->i_mapping,
>>>>>>>>>      					    pos >> PAGE_SHIFT,
>>>>>>>>>      					    (pos + count - 1) >> PAGE_SHIFT);
>>>>>>>> The above has already invalidated the pages, why doesn't it work ?
>>>>>>> I suspect the reason is because later on we loop through the number=
 of
>>>>>>> pages, call copy_page_from_iter() and then ceph_fscrypt_encrypt_pag=
es().
>>>>>> Checked the 'copy_page_from_iter()', it will do the kmap for the pag=
es but will
>>>>>> kunmap them again later. And they shouldn't update the i_mapping if =
I didn't
>>>>>> miss something important.
>>>>>>
>>>>>> For 'ceph_fscrypt_encrypt_pages()' it will encrypt/dencrypt the cont=
ext inplace,
>>>>>> IMO if it needs to map the page and it should also unmap it just lik=
e in
>>>>>> 'copy_page_from_iter()'.
>>>>>>
>>>>>> I thought it possibly be when we need to do RMW, it may will update =
the
>>>>>> i_mapping when reading contents, but I checked the code didn't find =
any
>>>>>> place is doing this. So I am wondering where tha page caches come fr=
om ? If that
>>>>>> page caches really from reading the contents, then we should discard=
 it instead
>>>>>> of flushing it back ?
>>>>>>
>>>>>> BTW, what's the problem without this fixing ? xfstest fails ?
>>>>> Yes, generic/647 fails if you run it with test_dummy_encryption.  And=
 I've
>>>>> also checked that the RMW code was never executed in this test.
>>>>>
>>>>> But yeah I have assumed (perhaps wrongly) that the kmap/kunmap could
>>>>> change the inode->i_mapping.
>>>>>
>>>> No, kmap/unmap are all about high memory and 32-bit architectures. Tho=
se
>>>> functions are usually no-ops on 64-bit arches.
>>> Yeah, right.
>>>
>>> So they do nothing here.
>>>
>>>>> In my debugging this seemed to be the case
>>>>> for the O_DIRECT path.  That's why I added this extra call here.
>>>>>
>>>> I agree with Xiubo that we really shouldn't need to invalidate multiple
>>>> times.
>>>>
>>>> I guess in this test, we have a DIO write racing with an mmap read
>>>> Probably what's happening is either that we can't invalidate the page
>>>> because it needs to be cleaned, or the mmap read is racing in just aft=
er
>>>> the invalidate occurs but before writeback.
>>> This sounds a possible case.
>>>
>>>
>>>> In any case, it might be interesting to see whether you're getting
>>>> -EBUSY back from the new invalidate_inode_pages2 calls with your patch.
>>>>
>>> If it's really this case maybe this should be retried some where ?
>>>
>> Possibly, or we may need to implement ->launder_folio.
>>
>> Either way, we need to understand what's happening first and then we can
>> figure out a solution for it.
>
> Yeah, make sense.
>

OK, so here's what I got so far:

When we run this test *without* test_dummy_encryption, ceph_direct_read_wri=
te()
will be called and invalidate_inode_pages2_range() will do pretty much
nothing because the mapping will be empty (mapping_empty(inode->i_mapping)
will return 1).  If we use encryption, ceph_sync_write() will be called
instead and the mapping, obviously, be will be empty as well.

The difference between in encrypted vs non-encrypted (and the reason the
test passes without encryption) is that ceph_direct_read_write()
(non-encrypted) will call truncate_inode_pages_range() at a stage where
the mapping is not empty anymore (iter_get_bvecs_alloc will take care of
that).  In the encryption path (ceph_sync_write) the mapping will be
filled with copy_page_from_iter(), which will fault and do the read.
Because we don't have the truncate_inode_pages_range(), the cache will
contain invalid data after the write.  And that's why the extra
invalidate_inode_pages2_range (or truncate_...) fixes this.

Cheers,
--=20
Lu=C3=ADs
