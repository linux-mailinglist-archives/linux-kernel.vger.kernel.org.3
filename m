Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428814F8269
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344434AbiDGPGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbiDGPGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:06:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A63D1EFE1C;
        Thu,  7 Apr 2022 08:04:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0B9A11F85E;
        Thu,  7 Apr 2022 15:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649343882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tD8QcCdjsJv2ikAX8X2TNa5afoDm9tTHK0fQiiB6sHU=;
        b=Is5qOJq3QJghtwg149CiqAXAjsC7zU3PmFttbMwrT+KwGOEsOj+Wmu9NbA2sPLnzVqNyWe
        wnQMtxfzb+XBsQ12LdvR9jnuj9unwSLuEqqWRIqkPjlYGOBFgtDCo2RnDqi+kj3AmyfxzB
        KgWm68sWP8pb+/oS18L6kq2lQ+P09D0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649343882;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tD8QcCdjsJv2ikAX8X2TNa5afoDm9tTHK0fQiiB6sHU=;
        b=ZCgY+/xBoL8YrgePptnI7y/0MnNlyi65+N0z6F2637eqlM68OMajhNlth5L7dPvfrWBdc1
        nUnc1GpgB3SXBGDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9EF3413485;
        Thu,  7 Apr 2022 15:04:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id m8DxI4n9TmJUZQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 07 Apr 2022 15:04:41 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 8f20ff87;
        Thu, 7 Apr 2022 15:05:04 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ceph: invalidate pages when doing direct/sync writes
References: <20220407143834.7516-1-lhenriques@suse.de>
        <253c9edf-01c5-40a3-3a11-738f29df8142@redhat.com>
Date:   Thu, 07 Apr 2022 16:05:04 +0100
In-Reply-To: <253c9edf-01c5-40a3-3a11-738f29df8142@redhat.com> (Xiubo Li's
        message of "Thu, 7 Apr 2022 22:48:20 +0800")
Message-ID: <87fsmp7x3z.fsf@brahms.olymp>
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

> On 4/7/22 10:38 PM, Lu=C3=ADs Henriques wrote:
>> When doing a direct/sync write, we need to invalidate the page cache in
>> the range being written to.  If we don't do this, the cache will include
>> invalid data as we just did a write that avoided the page cache.
>>
>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>> ---
>>   fs/ceph/file.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> Ok, here's a new attempt.  After discussion in this thread and on IRC, I
>> think this is the right fix.  generic/647 now passes with and without
>> encryption.  Thanks!
>>
>> Changes since v2:
>> - Invalidation needs to be done after a write
>>
>> Changes since v1:
>> - Replaced truncate_inode_pages_range() by invalidate_inode_pages2_range
>> - Call fscache_invalidate with FSCACHE_INVAL_DIO_WRITE if we're doing DIO
>>
>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>> index 5072570c2203..63e67eb60310 100644
>> --- a/fs/ceph/file.c
>> +++ b/fs/ceph/file.c
>> @@ -1938,6 +1938,15 @@ ceph_sync_write(struct kiocb *iocb, struct iov_it=
er *from, loff_t pos,
>>   			break;
>>   		}
>>   		ceph_clear_error_write(ci);
>> +		ret =3D invalidate_inode_pages2_range(
>> +				inode->i_mapping,
>> +				pos >> PAGE_SHIFT,
>> +				(pos + len - 1) >> PAGE_SHIFT);
>> +		if (ret < 0) {
>> +			dout("invalidate_inode_pages2_range returned %d\n",
>> +			     ret);
>> +			ret =3D 0;
>> +		}
>>   		pos +=3D len;
>>   		written +=3D len;
>>   		dout("sync_write written %d\n", written);
>>
> LGTM.
>
> Maybe it worth adding a comment to explain why we need this and where the
> mapping come from ?
>
> Reviewed-by: Xiubo Li <xiubli@redhat.com>
>

Sure, I'll send out v4 with an extra comment.  Thanks.

Cheers,
--=20
Lu=C3=ADs
