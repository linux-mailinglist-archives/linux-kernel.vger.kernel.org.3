Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983AD4F8260
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344402AbiDGPFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242225AbiDGPFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:05:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AC424591;
        Thu,  7 Apr 2022 08:03:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 979EF1F85E;
        Thu,  7 Apr 2022 15:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649343793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P2Y60UUpdzO4c/QznoyK437PUhA6xIvNYdqt68NitxY=;
        b=kYgeAbzpzunMhckxZibDJdHxuJ601n8vSHGYrrxwCDMG8e1Bmg/7jm+dO7Yrt0mP0nyPD+
        1gl2sOGYqMba6AQtRLIZWan0+yDxIEwOXeJiq1S/i5PkZU6kmJBA5Vt3wi4W5q07GXKhsP
        cVs3g2qvXAHPQf20Zkc9mIGfXu7uuFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649343793;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P2Y60UUpdzO4c/QznoyK437PUhA6xIvNYdqt68NitxY=;
        b=heBsnwuHmVko6H1Zte3P++6tL4z/CdhC6qQnFfXHE9UlbUvWyJrBm7wz9xQLyjv5OK8v5Y
        +Mx0ZOYcycuverDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 47DEC13485;
        Thu,  7 Apr 2022 15:03:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id p6oNDzH9TmKVZAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 07 Apr 2022 15:03:13 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id e89d1ce4;
        Thu, 7 Apr 2022 15:03:36 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ceph: invalidate pages when doing direct/sync writes
References: <20220407143834.7516-1-lhenriques@suse.de>
        <96a44a4224b67b9ec36198bc0586064df5c4ad2a.camel@kernel.org>
Date:   Thu, 07 Apr 2022 16:03:36 +0100
In-Reply-To: <96a44a4224b67b9ec36198bc0586064df5c4ad2a.camel@kernel.org> (Jeff
        Layton's message of "Thu, 07 Apr 2022 10:42:57 -0400")
Message-ID: <87k0c17x6f.fsf@brahms.olymp>
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

Jeff Layton <jlayton@kernel.org> writes:

> On Thu, 2022-04-07 at 15:38 +0100, Lu=C3=ADs Henriques wrote:
>> When doing a direct/sync write, we need to invalidate the page cache in
>> the range being written to.  If we don't do this, the cache will include
>> invalid data as we just did a write that avoided the page cache.
>>=20
>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>> ---
>>  fs/ceph/file.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>=20
>> Ok, here's a new attempt.  After discussion in this thread and on IRC, I
>> think this is the right fix.  generic/647 now passes with and without
>> encryption.  Thanks!
>>=20
>> Changes since v2:
>> - Invalidation needs to be done after a write
>>=20
>> Changes since v1:
>> - Replaced truncate_inode_pages_range() by invalidate_inode_pages2_range
>> - Call fscache_invalidate with FSCACHE_INVAL_DIO_WRITE if we're doing DIO
>>=20
>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>> index 5072570c2203..63e67eb60310 100644
>> --- a/fs/ceph/file.c
>> +++ b/fs/ceph/file.c
>> @@ -1938,6 +1938,15 @@ ceph_sync_write(struct kiocb *iocb, struct iov_it=
er *from, loff_t pos,
>>  			break;
>>  		}
>>  		ceph_clear_error_write(ci);
>> +		ret =3D invalidate_inode_pages2_range(
>> +				inode->i_mapping,
>> +				pos >> PAGE_SHIFT,
>> +				(pos + len - 1) >> PAGE_SHIFT);
>> +		if (ret < 0) {
>> +			dout("invalidate_inode_pages2_range returned %d\n",
>> +			     ret);
>> +			ret =3D 0;
>> +		}
>>  		pos +=3D len;
>>  		written +=3D len;
>>  		dout("sync_write written %d\n", written);
>
> Looks good. I suspect we can also remove the
> invalidate_indode_pages2_range call earlier in this function too. I may
> roll that into this patch.

Right, that occurred to me as well but I wasn't really sure that would be
safe.

> I'll give this an xfstests run with fscrypt enabled and see how it does.

I'll do the same here, I just run a few tests on a vstart cluster.  But
I'll definitely give it some more testing.

Cheers,
--=20
Lu=C3=ADs
