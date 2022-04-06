Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F824F625A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbiDFOzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235238AbiDFOyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:54:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE741608C05;
        Wed,  6 Apr 2022 04:32:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A39EF1F858;
        Wed,  6 Apr 2022 11:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649244767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Xisg031nvUyjGa8rCi6g+/z5EvYZTh85G/9xqOb5KY=;
        b=P/2Ym6ZL6GdwRefQpv/AEkV8+b4JtOemLvBrqv7RjuD2PfNcJpOfI564pSYltQEcy5BwsY
        Eu6IOAw83soFaggPo3L0EPH/DUt22OI4vFkCZaFECXqiPUsGpfH4pF6bPfpqnY7LnvcFED
        1ayP1Qwm9A/UrdjRKmxvE7Yfzzonp98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649244767;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Xisg031nvUyjGa8rCi6g+/z5EvYZTh85G/9xqOb5KY=;
        b=vigZobKfTvpGZEYPPCz/hre6y0dvlKsE+qj6qu4Xqu+34dqKdh1/zdH4dAAVBqd/Ov4KA+
        WonnjSEUQfLHxdAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D96A139F5;
        Wed,  6 Apr 2022 11:32:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ziL9C196TWIkRgAAMHmgww
        (envelope-from <lhenriques@suse.de>); Wed, 06 Apr 2022 11:32:47 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id b51e56ad;
        Wed, 6 Apr 2022 11:33:11 +0000 (UTC)
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
Date:   Wed, 06 Apr 2022 12:33:11 +0100
In-Reply-To: <6ba91390-83e8-8702-2729-dc432abd3cc5@redhat.com> (Xiubo Li's
        message of "Wed, 6 Apr 2022 19:18:04 +0800")
Message-ID: <87zgky8n0o.fsf@brahms.olymp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xiubo Li <xiubli@redhat.com> writes:

> On 4/6/22 6:57 PM, Lu=C3=ADs Henriques wrote:
>> Xiubo Li <xiubli@redhat.com> writes:
>>
>>> On 4/1/22 9:32 PM, Lu=C3=ADs Henriques wrote:
>>>> When doing DIO on an encrypted node, we need to invalidate the page ca=
che in
>>>> the range being written to, otherwise the cache will include invalid d=
ata.
>>>>
>>>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>>>> ---
>>>>    fs/ceph/file.c | 11 ++++++++++-
>>>>    1 file changed, 10 insertions(+), 1 deletion(-)
>>>>
>>>> Changes since v1:
>>>> - Replaced truncate_inode_pages_range() by invalidate_inode_pages2_ran=
ge
>>>> - Call fscache_invalidate with FSCACHE_INVAL_DIO_WRITE if we're doing =
DIO
>>>>
>>>> Note: I'm not really sure this last change is required, it doesn't rea=
lly
>>>> affect generic/647 result, but seems to be the most correct.
>>>>
>>>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>>>> index 5072570c2203..b2743c342305 100644
>>>> --- a/fs/ceph/file.c
>>>> +++ b/fs/ceph/file.c
>>>> @@ -1605,7 +1605,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_i=
ter *from, loff_t pos,
>>>>    	if (ret < 0)
>>>>    		return ret;
>>>>    -	ceph_fscache_invalidate(inode, false);
>>>> +	ceph_fscache_invalidate(inode, (iocb->ki_flags & IOCB_DIRECT));
>>>>    	ret =3D invalidate_inode_pages2_range(inode->i_mapping,
>>>>    					    pos >> PAGE_SHIFT,
>>>>    					    (pos + count - 1) >> PAGE_SHIFT);
>>> The above has already invalidated the pages, why doesn't it work ?
>> I suspect the reason is because later on we loop through the number of
>> pages, call copy_page_from_iter() and then ceph_fscrypt_encrypt_pages().
>
> Checked the 'copy_page_from_iter()', it will do the kmap for the pages bu=
t will
> kunmap them again later. And they shouldn't update the i_mapping if I did=
n't
> miss something important.
>
> For 'ceph_fscrypt_encrypt_pages()' it will encrypt/dencrypt the context i=
nplace,
> IMO if it needs to map the page and it should also unmap it just like in
> 'copy_page_from_iter()'.
>
> I thought it possibly be when we need to do RMW, it may will update the
> i_mapping when reading contents, but I checked the code didn't find any=20
> place is doing this. So I am wondering where tha page caches come from ? =
If that
> page caches really from reading the contents, then we should discard it i=
nstead
> of flushing it back ?
>
> BTW, what's the problem without this fixing ? xfstest fails ?

Yes, generic/647 fails if you run it with test_dummy_encryption.  And I've
also checked that the RMW code was never executed in this test.

But yeah I have assumed (perhaps wrongly) that the kmap/kunmap could
change the inode->i_mapping.  In my debugging this seemed to be the case
for the O_DIRECT path.  That's why I added this extra call here.

Cheers,
--=20
Lu=C3=ADs
