Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDC34EECF9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 14:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345794AbiDAMR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 08:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344506AbiDAMRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 08:17:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B4948324;
        Fri,  1 Apr 2022 05:15:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0EA30210F4;
        Fri,  1 Apr 2022 12:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648815332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=937kobGf1fHjhm3kcQZF6BFY9ANJ0nOaWjSM6tHYZgI=;
        b=KERMcWnzcKe5ewWlilWtrJd0jbzNKWI8vTamwJHcPeUpnuPqMkbESCMUvLGlA2SrIerWHW
        ttsybt4B5GXt/OYu/tcDd1UDgkAO+w412XLUzGL1N4XnD7v/rBcXrzTePWCnO+FyRB9I6g
        gQ19NicR+F46CARdBJCgMKfQiiJ5xXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648815332;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=937kobGf1fHjhm3kcQZF6BFY9ANJ0nOaWjSM6tHYZgI=;
        b=5fKD1xYCZ8xA7M0RJfWwXCGWmJP2gssaYX3zpHZ9cw4CCznCkybgUq+QjIF3yqT/RFf5QH
        OMcZZ0vGjD7OIiBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A5D541331E;
        Fri,  1 Apr 2022 12:15:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ffh3JePsRmLfMQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 01 Apr 2022 12:15:31 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 70734a10;
        Fri, 1 Apr 2022 12:15:53 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ceph: truncate page cache when doing DIO in encrypted
 inodes
References: <20220401113822.32545-1-lhenriques@suse.de>
        <0f781fa1b2bec48d40729d8306a2ed8b19209734.camel@kernel.org>
Date:   Fri, 01 Apr 2022 13:15:53 +0100
In-Reply-To: <0f781fa1b2bec48d40729d8306a2ed8b19209734.camel@kernel.org> (Jeff
        Layton's message of "Fri, 01 Apr 2022 07:56:23 -0400")
Message-ID: <87o81lov7q.fsf@brahms.olymp>
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

Jeff Layton <jlayton@kernel.org> writes:

> On Fri, 2022-04-01 at 12:38 +0100, Lu=C3=ADs Henriques wrote:
>> When doing DIO on an encrypted node, we need to truncate the page cache =
in
>> the range being written to, otherwise the cache will include invalid dat=
a.
>>=20
>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>> ---
>>  fs/ceph/file.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>=20
>> This patch should fix generic/647 fstest when run with test_dummy_encryp=
tion.
>>=20
>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>> index 5072570c2203..0f31c4d352a4 100644
>> --- a/fs/ceph/file.c
>> +++ b/fs/ceph/file.c
>> @@ -1895,6 +1895,11 @@ ceph_sync_write(struct kiocb *iocb, struct iov_it=
er *from, loff_t pos,
>>  		req->r_inode =3D inode;
>>  		req->r_mtime =3D mtime;
>>=20=20
>> +		if (IS_ENCRYPTED(inode) && (iocb->ki_flags & IOCB_DIRECT))
>> +			truncate_inode_pages_range(
>> +				inode->i_mapping, write_pos,
>> +				PAGE_ALIGN(write_pos + write_len) - 1);
>> +
>>  		/* Set up the assertion */
>>  		if (rmw) {
>>  			/*
>
> Truncating the pagecache like this could cause dirty data to be
> discarded. I know we're planning to overwrite this range, but you are
> having to invalidate more than the written range here. We could
> potentially lose a write to that region.
>
> Have you tried using something like invalidate_inode_pages2_range ?
> That's more of what we'd want here, as it's a bit more cautious about
> tossing out dirty pages. I see too that that is what
> ceph_direct_read_write calls in the write case as well.

OK, let me try that instead.  Yeah, I've used what the usual direct path
was using (the truncate_inode_pages_range()), but if
invalidate_inode_pages2_range works here I guess that's better.  I'll test
that and send out v2.

Cheers,
--=20
Lu=C3=ADs
