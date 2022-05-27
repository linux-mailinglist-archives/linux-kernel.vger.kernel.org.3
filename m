Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D884A535D30
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345049AbiE0JPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbiE0JPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:15:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7B2D8B;
        Fri, 27 May 2022 02:15:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9CD141F990;
        Fri, 27 May 2022 09:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653642949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4PNcFgUhLhWREVrd3nkcrMfGa8Rtl91s/gZZxYxrErY=;
        b=efW0VoM/ZOnFbsB7wh1BLUOlR/w3Gb/noJyvk8GhslDhaQzHL4xqVldI7YgzuCGJ5fhAbQ
        Ac53qMKQ9Gmumpc8CIj09F26o0wgBuiGmcpbwZl/7reojra8yV9WysDlt+jgIS8o+MX67G
        meteaOONF6AoWH8wAIjJLbIP+tUMSbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653642949;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4PNcFgUhLhWREVrd3nkcrMfGa8Rtl91s/gZZxYxrErY=;
        b=il3mgRpfqvUjjTgi7eXKWBdtb8O2Jp0b1nA2zZxzUjdfcaqQzz/LcEDKqkll3eJuFHPIis
        F7eQ4tSZzIP75+AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 44BAA139C4;
        Fri, 27 May 2022 09:15:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sZjxDcWWkGLITgAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 27 May 2022 09:15:49 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id ba8c5f5d;
        Fri, 27 May 2022 09:16:27 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ceph: use correct index when encoding client supported
 features
References: <20220524160627.20893-1-lhenriques@suse.de>
        <d1f22b3b-7415-0fdb-e702-24f2a7b0b939@redhat.com>
Date:   Fri, 27 May 2022 10:16:27 +0100
In-Reply-To: <d1f22b3b-7415-0fdb-e702-24f2a7b0b939@redhat.com> (Xiubo Li's
        message of "Thu, 26 May 2022 08:55:15 +0800")
Message-ID: <87h75bwd1w.fsf@brahms.olymp>
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

> On 5/25/22 12:06 AM, Lu=C3=ADs Henriques wrote:
>> Feature bits have to be encoded into the correct locations.  This hasn't
>> been an issue so far because the only hole in the feature bits was in bit
>> 10 (CEPHFS_FEATURE_RECLAIM_CLIENT), which is located in the 2nd byte.  W=
hen
>> adding more bits that go beyond the this 2nd byte, the bug will show up.
>>
>> Fixes: 9ba1e224538a ("ceph: allocate the correct amount of extra bytes f=
or the session features")
>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>> ---
>>   fs/ceph/mds_client.c | 7 +++++--
>>   fs/ceph/mds_client.h | 2 --
>>   2 files changed, 5 insertions(+), 4 deletions(-)
>>
>> I hope I got this code right.  I found this issue when trying to add an
>> extra feature bit that would go beyond bit 15 and that wasn't showing up
>> on the MDS side.
>>
>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>> index 1bd3e1bb0fdf..77e742b6fd30 100644
>> --- a/fs/ceph/mds_client.c
>> +++ b/fs/ceph/mds_client.c
>> @@ -1220,14 +1220,17 @@ static int encode_supported_features(void **p, v=
oid *end)
>>   	if (count > 0) {
>>   		size_t i;
>>   		size_t size =3D FEATURE_BYTES(count);
>> +		unsigned long bit;
>>=20=20=20
>>   		if (WARN_ON_ONCE(*p + 4 + size > end))
>>   			return -ERANGE;
>>=20=20=20
>>   		ceph_encode_32(p, size);
>>   		memset(*p, 0, size);
>> -		for (i =3D 0; i < count; i++)
>> -			((unsigned char*)(*p))[i / 8] |=3D BIT(feature_bits[i] % 8);
>> +		for (i =3D 0; i < count; i++) {
>> +			bit =3D feature_bits[i];
>> +			((unsigned char *)(*p))[bit / 8] |=3D BIT(bit % 8);
>> +		}
>>   		*p +=3D size;
>>   	} else {
>>   		if (WARN_ON_ONCE(*p + 4 > end))
>> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
>> index 33497846e47e..12901e3a6823 100644
>> --- a/fs/ceph/mds_client.h
>> +++ b/fs/ceph/mds_client.h
>> @@ -45,8 +45,6 @@ enum ceph_feature_type {
>>   	CEPHFS_FEATURE_MULTI_RECONNECT,		\
>>   	CEPHFS_FEATURE_DELEG_INO,		\
>>   	CEPHFS_FEATURE_METRIC_COLLECT,		\
>> -						\
>> -	CEPHFS_FEATURE_MAX,			\
>>   }
>>   #define CEPHFS_FEATURES_CLIENT_REQUIRED {}
>>=20=20=20
>
> LGTM. Just one small fix in the comment, since you have removed the=20
> 'CEPHFS_FEATURE_MAX', which makes no sense any more:

Ah, yeah.  I missed that.  Thanks!

Cheers,
--=20
Lu=C3=ADs


> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 33497846e47e..ac49344ea79e 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -33,10 +33,6 @@ enum ceph_feature_type {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CEPHFS_FEATURE_MAX =3D CEPHFS=
_FEATURE_METRIC_COLLECT,
>  =C2=A0};
>
> -/*
> - * This will always have the highest feature bit value
> - * as the last element of the array.
> - */
>  =C2=A0#define CEPHFS_FEATURES_CLIENT_SUPPORTED {=C2=A0=C2=A0=C2=A0=C2=A0=
 \
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, 1, 2, 3, 4, 5, 6, 7,=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 \
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CEPHFS_FEATURE_MIMIC,=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>
> Merged into the testing branch.
>
> Thanks Luis.
>
> -- Xiubo
>
