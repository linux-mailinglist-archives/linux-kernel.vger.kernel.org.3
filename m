Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA774F61C3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbiDFOdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbiDFOdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:33:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F634CFD98;
        Wed,  6 Apr 2022 03:56:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 53A95210EE;
        Wed,  6 Apr 2022 10:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649242611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PpR2c+ZPg7BJ6Xw9sfecT6Aa7dhhvXuHhhVja5spSqs=;
        b=yko3N8qgVwjgizn2PcGGICV1W5NyvHA7sY5gcwixgQRD8PyPF69wxAYem6Gs2rrhtym8wS
        sjPY5HKJuGMOWHI4IHi4crycbXQUeA0T9Rvh8eqtyXYQWmo3bC2z4JyPcDZuQ2xm+SfDb8
        60KHerAZNfH2nrNJ4/3xCIyxrskdotk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649242611;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PpR2c+ZPg7BJ6Xw9sfecT6Aa7dhhvXuHhhVja5spSqs=;
        b=g1qWpppB4rQ16gU9UhsmyCxI4cK6uo7iUhgYQfPTDxsD2ms8bZ+A7sySU2vSWxCjFErZjn
        zxih2HoSopIqKFBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF2A913A8E;
        Wed,  6 Apr 2022 10:56:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FzeFL/JxTWKlMwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Wed, 06 Apr 2022 10:56:50 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 00935f4b;
        Wed, 6 Apr 2022 10:57:14 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ceph: invalidate pages when doing DIO in encrypted
 inodes
References: <20220401133243.1075-1-lhenriques@suse.de>
        <d6407dd1-b6df-4de4-fe37-71b765b2088a@redhat.com>
Date:   Wed, 06 Apr 2022 11:57:14 +0100
In-Reply-To: <d6407dd1-b6df-4de4-fe37-71b765b2088a@redhat.com> (Xiubo Li's
        message of "Wed, 6 Apr 2022 14:28:27 +0800")
Message-ID: <878rsia391.fsf@brahms.olymp>
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

> On 4/1/22 9:32 PM, Lu=C3=ADs Henriques wrote:
>> When doing DIO on an encrypted node, we need to invalidate the page cach=
e in
>> the range being written to, otherwise the cache will include invalid dat=
a.
>>
>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>> ---
>>   fs/ceph/file.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> Changes since v1:
>> - Replaced truncate_inode_pages_range() by invalidate_inode_pages2_range
>> - Call fscache_invalidate with FSCACHE_INVAL_DIO_WRITE if we're doing DIO
>>
>> Note: I'm not really sure this last change is required, it doesn't really
>> affect generic/647 result, but seems to be the most correct.
>>
>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>> index 5072570c2203..b2743c342305 100644
>> --- a/fs/ceph/file.c
>> +++ b/fs/ceph/file.c
>> @@ -1605,7 +1605,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_ite=
r *from, loff_t pos,
>>   	if (ret < 0)
>>   		return ret;
>>   -	ceph_fscache_invalidate(inode, false);
>> +	ceph_fscache_invalidate(inode, (iocb->ki_flags & IOCB_DIRECT));
>>   	ret =3D invalidate_inode_pages2_range(inode->i_mapping,
>>   					    pos >> PAGE_SHIFT,
>>   					    (pos + count - 1) >> PAGE_SHIFT);
>
> The above has already invalidated the pages, why doesn't it work ?

I suspect the reason is because later on we loop through the number of
pages, call copy_page_from_iter() and then ceph_fscrypt_encrypt_pages().

Cheers,
--=20
Lu=C3=ADs

>
> -- Xiubo
>
>> @@ -1895,6 +1895,15 @@ ceph_sync_write(struct kiocb *iocb, struct iov_it=
er *from, loff_t pos,
>>   		req->r_inode =3D inode;
>>   		req->r_mtime =3D mtime;
>>   +		if (IS_ENCRYPTED(inode) && (iocb->ki_flags & IOCB_DIRECT)) {
>> +			ret =3D invalidate_inode_pages2_range(
>> +				inode->i_mapping,
>> +				write_pos >> PAGE_SHIFT,
>> +				(write_pos + write_len - 1) >> PAGE_SHIFT);
>> +			if (ret < 0)
>> +				dout("invalidate_inode_pages2_range returned %d\n", ret);
>> +		}
>> +
>>   		/* Set up the assertion */
>>   		if (rmw) {
>>   			/*
>>
>

