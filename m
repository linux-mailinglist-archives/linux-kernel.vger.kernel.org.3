Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46483472839
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbhLMKJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:09:22 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41446 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236043AbhLMKGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:06:39 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3B86E210F4;
        Mon, 13 Dec 2021 10:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639389998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x8PtASu7vSwnUJwQTU1wmcrUqlQCjVjwWb73urhJRZc=;
        b=QzLyPqAQK0T4DRACOufOUqEhQvGxSxDeYqqYHhMksaumhy3oEFCg66bsovffDT/58E2642
        3NBn2Ydfu+pkYGilIm57CDEZuu/G6XI7v5g7TWhNfZPR3Do0dpm3r35fklNJf4yPU4W4GG
        VMGpaqKS/fRFZo++657Lgug91FOV04I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639389998;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x8PtASu7vSwnUJwQTU1wmcrUqlQCjVjwWb73urhJRZc=;
        b=khVe4Ie+IlLN10cGXe+QWqewcf2nMHnVkU/pI9OXempBeTJbvOOyX88dLpdHMoaiOCDtLy
        PzO3J2Y4WeLuo5Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84A6B13BB2;
        Mon, 13 Dec 2021 10:06:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KjAiHi0bt2FVNQAAMHmgww
        (envelope-from <nstange@suse.de>); Mon, 13 Dec 2021 10:06:37 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Nicolai Stange <nstange@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Stephan =?utf-8?Q?M=C3=BCller?= <smueller@chronox.de>,
        Torsten Duwe <duwe@suse.de>, Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org
Subject: Re: [PATCH v2 03/18] crypto: dh - optimize domain parameter serialization for well-known groups
In-Reply-To: <86157a11-7daa-876a-d80b-e6bda36e6368@suse.de> (Hannes Reinecke's
        message of "Fri, 10 Dec 2021 12:33:34 +0100")
References: <20211209090358.28231-1-nstange@suse.de>
        <20211209090358.28231-4-nstange@suse.de>
        <86157a11-7daa-876a-d80b-e6bda36e6368@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
Date:   Mon, 13 Dec 2021 11:06:36 +0100
Message-ID: <87r1agrf83.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hannes Reinecke <hare@suse.de> writes:

> On 12/9/21 10:03 AM, Nicolai Stange wrote:
>> diff --git a/crypto/dh_helper.c b/crypto/dh_helper.c
>> index aabc91e4f63f..9f21204e5dee 100644
>> --- a/crypto/dh_helper.c
>> +++ b/crypto/dh_helper.c
>> @@ -45,18 +72,24 @@ int crypto_dh_encode_key(char *buf, unsigned int len=
, const struct dh *params)
>>  		.type =3D CRYPTO_KPP_SECRET_TYPE_DH,
>>  		.len =3D len
>>  	};
>> +	int group_id;
>>=20=20
>>  	if (unlikely(!len))
>>  		return -EINVAL;
>>=20=20
>>  	ptr =3D dh_pack_data(ptr, end, &secret, sizeof(secret));
>> +	group_id =3D (int)params->group_id;
>> +	ptr =3D dh_pack_data(ptr, end, &group_id, sizeof(group_id));
>
> Me being picky again.
> To my knowledge, 'int' doesn't have a fixed width, but is rather only
> guaranteed to hold certain values.
> So as soon as one relies on any fixed size (as this one does) I tend to
> use fixed size type like 'u32' to make it absolutely clear what is to be
> expected here.
>
> But the I don't know the conventions in the crypto code; if an 'int' is
> assumed to be 32 bits throughout the crypto code I guess we should be fin=
e.

Yes, I thought about this, too. However, the other, already existing
fields like ->key_size and ->p_size are getting serialized as unsigned
ints and I decided to stick to that for ->group_id as well. Except for
the testmgr vectors, the encoding is internal to the
crypto_dh_encode_key() and crypto_dh_decode_key() pair anyway -- all
that would happen if sizeof(int) !=3D 4 is that the tests would fail.

So, IMO, making the serialization of struct dh to use u32 throughout is
not really in scope for this series and would probably deserve a patch
on its own, if desired.

Thanks,

Nicolai

--=20
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, G=
ermany
(HRB 36809, AG N=C3=BCrnberg), GF: Ivo Totev
