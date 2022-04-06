Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BFB4F6068
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbiDFNn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbiDFNnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:43:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABDE6AB4A7;
        Wed,  6 Apr 2022 03:50:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B58CF210EE;
        Wed,  6 Apr 2022 10:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649242232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0VPqKsepdHjXuh5eCVq2lcW8r7HHaKzIHYylD0wcWMA=;
        b=18shT1nJv+kZLrU/iP0drYE3s73dWDbXuvufc06nIlhJ1NRCoWQl6NK2x7zEg3zZsqygMy
        km46y2DyRcJK0y0JoLRwW/odLdwAZrfzTmFRXA4T4I5sbhCgzdDjg+q0I7h2taC0ws1jWW
        7wZFA0kywvl6J9YUlYcMk+Tt44Bkalc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649242232;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0VPqKsepdHjXuh5eCVq2lcW8r7HHaKzIHYylD0wcWMA=;
        b=O8FpfxrA4R79/fkzjy9v7QLR0ytKcUOPGT+VtRmGM7irghX5SIz7OXTeK4A0mp05eWuvMW
        Jl7HmADMD2tENuDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A69C13A8E;
        Wed,  6 Apr 2022 10:50:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9C0vE3hwTWLIMAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Wed, 06 Apr 2022 10:50:32 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id a2e9b2cc;
        Wed, 6 Apr 2022 10:50:56 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ceph: invalidate pages when doing DIO in encrypted
 inodes
References: <20220401133243.1075-1-lhenriques@suse.de>
        <5146f7a8-94c1-a7aa-db2d-d3ae98c5b83a@redhat.com>
Date:   Wed, 06 Apr 2022 11:50:56 +0100
In-Reply-To: <5146f7a8-94c1-a7aa-db2d-d3ae98c5b83a@redhat.com> (Xiubo Li's
        message of "Wed, 6 Apr 2022 13:24:33 +0800")
Message-ID: <87fsmqa3jj.fsf@brahms.olymp>
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
>
> Shouldn't we fail it if the 'invalidate_inode_pages2_range()' fails here ?

Yeah, I'm not really sure.  I'm simply following the usual pattern where
an invalidate_inode_pages2_range() failure is logged and ignored.  And
this is not ceph-specific, other filesystems seem to do the same thing.

Cheers,
--=20
Lu=C3=ADs

>
> -- Xiubo
>
>> +
>>   		/* Set up the assertion */
>>   		if (rmw) {
>>   			/*
>>
>
