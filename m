Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A32A46E52D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbhLIJNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:13:37 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:56426 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhLIJNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:13:36 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 35CCD210FF;
        Thu,  9 Dec 2021 09:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639041002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IqzDqOx41zARVXCyyeAfCHZ0zpqGCraQT+X+lPXodGo=;
        b=tccTmg++AWaryh0805ou0ymPX8amYLE1yavVXoUzAtMZUgxtC8Y8jdvK4VkzL3Dn9j+AUe
        QfQ8TWv31Jdxyt1zMcqSdEKj2LDnsmWvXBf9cIJKD7xfa+4pu4IDHH3+NKpJQZ+sOHp933
        9G6ELSQXBxttQ6+kpiPprwo3wCA+6jQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639041002;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IqzDqOx41zARVXCyyeAfCHZ0zpqGCraQT+X+lPXodGo=;
        b=fhsYCHNrD8g5XdDMZrP01j94uv57BB9wdNYXqWbuyeGbiGj3NZkZ+9/Yw0YkrDDdqW/YgJ
        TecixgnhDjMFbLDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A70C813CB1;
        Thu,  9 Dec 2021 09:10:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id w2PIJunHsWGjbAAAMHmgww
        (envelope-from <nstange@suse.de>); Thu, 09 Dec 2021 09:10:01 +0000
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
Subject: Re: [PATCH 04/18] crypto: dh - introduce RFC 7919 safe-prime groups
References: <20211201004858.19831-1-nstange@suse.de>
        <20211201004858.19831-5-nstange@suse.de>
        <e3b20e75-2ebf-76a1-8d2b-e359f3f98891@suse.de>
Date:   Thu, 09 Dec 2021 10:10:01 +0100
In-Reply-To: <e3b20e75-2ebf-76a1-8d2b-e359f3f98891@suse.de> (Hannes Reinecke's
        message of "Wed, 1 Dec 2021 08:23:38 +0100")
Message-ID: <87wnkekuty.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hannes Reinecke <hare@suse.de> writes:

>> diff --git a/include/crypto/dh.h b/include/crypto/dh.h
>> index 15d8b2dfe4a2..59be1fe3a978 100644
>> --- a/include/crypto/dh.h
>> +++ b/include/crypto/dh.h
>> @@ -22,6 +22,13 @@
>>   /** enum dh_group_id - identify well-known domain parameter sets */
>>   enum dh_group_id {
>>   	dh_group_id_unknown =3D 0,
>> +#ifdef CONFIG_CRYPTO_DH_GROUPS_RFC7919
>> +	dh_group_id_rfc7919_ffdhe2048 =3D 1, /* Constant used by test vector. =
*/
>> +	dh_group_id_rfc7919_ffdhe3072,
>> +	dh_group_id_rfc7919_ffdhe4096,
>> +	dh_group_id_rfc7919_ffdhe6144,
>> +	dh_group_id_rfc7919_ffdhe8192,
>> +#endif
>>   };
>>     /**
>>
> Again, enums should be in upper case.
> And I think the rfc7919 in dh_group_id_rfc7919_ffdheXXX is redundant;
> I'd rather leave it out and name is just dh_group_id_ffdheXXX.

All upper case now in v2 and those _RFCXYZ_ parts have also been
removed.

Thanks,

Nicolai

--=20
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, G=
ermany
(HRB 36809, AG N=C3=BCrnberg), GF: Ivo Totev
