Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BEA531AB2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238957AbiEWQdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238906AbiEWQdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:33:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971E468FBC;
        Mon, 23 May 2022 09:33:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 545DA21A56;
        Mon, 23 May 2022 16:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653323629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tNoKiNGrG5iW0aGhUIxZVTdGUlMyrTnQj8c3DQqRnC0=;
        b=en8UGpPz/Y5jTas0q8lKpEg3Z47jp59uxeCEqWczJ9mPcGZ1RTm6AlbvRy6wjmnO/HNzIw
        +4AmJy17/yIPkJgEW25O6399LBmr4Auv0VtfENazGIMTRSQdqzlG4DImLeACVYiT9daWq3
        sHSP7ZN0+4Nj1hHMA4vWQU+udK8SCXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653323629;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tNoKiNGrG5iW0aGhUIxZVTdGUlMyrTnQj8c3DQqRnC0=;
        b=APTqi9Ii3NrXEDU75W/Zkznp1tQo55JCy3IgCHvm6DcK6CKve8cwIBa3bY3nnXNaZ9J3ia
        x0kXNF1j7dRt6lDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F2990139F5;
        Mon, 23 May 2022 16:33:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kGllOGy3i2KFNAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Mon, 23 May 2022 16:33:48 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id d67aef96;
        Mon, 23 May 2022 16:34:26 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ceph: fix decoding of client session messages flags
References: <20220523160951.8781-1-lhenriques@suse.de>
        <1e1f7397d516f8b9780b08763f6338cd4ce83506.camel@kernel.org>
Date:   Mon, 23 May 2022 17:34:26 +0100
In-Reply-To: <1e1f7397d516f8b9780b08763f6338cd4ce83506.camel@kernel.org> (Jeff
        Layton's message of "Mon, 23 May 2022 12:19:27 -0400")
Message-ID: <87y1ysky25.fsf@brahms.olymp>
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

> On Mon, 2022-05-23 at 17:09 +0100, Lu=C3=ADs Henriques wrote:
>> The cephfs kernel client started to show  the message:
>>=20
>>  ceph: mds0 session blocklisted
>>=20
>> when mounting a filesystem.  This is due to the fact that the session
>> messages are being incorrectly decoded: the skip needs to take into
>> account the 'len'.
>>=20
>> While there, fixed some whitespaces too.
>>=20
>> Fixes: e1c9788cb397 ("ceph: don't rely on error_string to validate block=
listed session.")
>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>> ---
>>  fs/ceph/mds_client.c | 14 +++++++++-----
>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>> index 00c3de177dd6..1bd3e1bb0fdf 100644
>> --- a/fs/ceph/mds_client.c
>> +++ b/fs/ceph/mds_client.c
>> @@ -3375,13 +3375,17 @@ static void handle_session(struct ceph_mds_sessi=
on *session,
>>  	}
>>=20=20
>>  	if (msg_version >=3D 5) {
>> -		u32 flags;
>> -		/* version >=3D 4, struct_v, struct_cv, len, metric_spec */
>> -	        ceph_decode_skip_n(&p, end, 2 + sizeof(u32) * 2, bad);
>> +		u32 flags, len;
>> +
>> +		/* version >=3D 4 */
>> +		ceph_decode_skip_16(&p, end, bad); /* struct_v, struct_cv */
>> +		ceph_decode_32_safe(&p, end, len, bad); /* len */
>> +		ceph_decode_skip_n(&p, end, len, bad); /* metric_spec */
>> +
>>  		/* version >=3D 5, flags   */
>> -                ceph_decode_32_safe(&p, end, flags, bad);
>> +		ceph_decode_32_safe(&p, end, flags, bad);
>>  		if (flags & CEPH_SESSION_BLOCKLISTED) {
>> -		        pr_warn("mds%d session blocklisted\n", session->s_mds);
>> +			pr_warn("mds%d session blocklisted\n", session->s_mds);
>>  			blocklisted =3D true;
>>  		}
>>  	}
>
> Good catch! Should we send this to stable too?

Ah, yeah.  I didn't explicitly tagged it as I assumed the 'Fixes:' would
be enough for that.  But it's probably better to do add the 'Cc: stable'
too.

> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Cheers,
--=20
Lu=C3=ADs
