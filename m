Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD2246CDE2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 07:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243983AbhLHGpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 01:45:00 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:39388 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbhLHGoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 01:44:55 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AFE632190C;
        Wed,  8 Dec 2021 06:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638945682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JyrpoNw8nsRtEfjAdK2RgQyqMvaZ9i/qH0Pct+Spvfw=;
        b=uUYMuoaktDpHwVQqhD6SPxrBPnUl+k2musNlDAUytq3PIKubSELZr88//wU1BHeAb5wZLK
        IAOqO7+1Ej/T+MC222c01XzMO/6KRTLtcFrFNTnR26RNb1BbibYRhnbBqezCZu4Nt7fwjm
        hSyWsTAR853eXNXvCtPHtPmHvRsHKaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638945682;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JyrpoNw8nsRtEfjAdK2RgQyqMvaZ9i/qH0Pct+Spvfw=;
        b=s6ZnbiVxl7kWgFp1vc9GUrsjGURzw6l0Z2JbP1jJdJItKfr10lp9CHIEZJtSwgxY8PbqZI
        pDKiGiBy0ZngLJDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 263DE13B28;
        Wed,  8 Dec 2021 06:41:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f8tHB5JTsGGzQgAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 08 Dec 2021 06:41:22 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Stephan =?utf-8?Q?M=C3=BCller?= <smueller@chronox.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolai Stange <nstange@suse.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org
Subject: Re: [PATCH 16/18] crypto: dh - calculate Q from P for the full public key verification
References: <20211201004858.19831-1-nstange@suse.de>
        <20211201004858.19831-17-nstange@suse.de>
        <4182894.UPlyArG6xL@positron.chronox.de>
Date:   Wed, 08 Dec 2021 07:41:22 +0100
In-Reply-To: <4182894.UPlyArG6xL@positron.chronox.de> ("Stephan
 \=\?utf-8\?Q\?M\=C3\=BCller\=22's\?\=
        message of "Sun, 05 Dec 2021 07:07:11 +0100")
Message-ID: <878rwvegz1.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan M=C3=BCller <smueller@chronox.de> writes:

> Am Mittwoch, 1. Dezember 2021, 01:48:56 CET schrieb Nicolai Stange:
>
>> As the ->q in struct dh_ctx gets never set anywhere, the code
>> in dh_is_pubkey_valid() for doing the full public key validation in
>> accordance to SP800-56Arev3 is effectively dead.
>>=20
>> However, for safe-prime groups, Q =3D (P - 1)/2 by definition and this
>> enables dh_is_pubkey_valid() to calculate Q on the fly for these groups.
>> Implement this.
>>=20
>> With this change, the last code accessing struct dh_ctx's ->q is now gon=
e.
>> Remove this member from struct dh_ctx.
>
> Isn't it expensive to always calculate Q for a-priori known values? Why n=
ot=20
> add Q to the safe-prime definitions and do not do this operation here?

I actually considered this when writing the patch: it's basically a
time-memory tradeoff and I opted for time here. The reason is that I'd
expect the rather trivial Q calculation to be negligible when compared
to the subsequent mpi_powm() operation in dh_is_pubkey_valid(). OTOH, as
the size of Q is (almost) equal to that of P, the space needed for
storing all the the individual groups' precomputed Qs would be
significant. So I'd say let's wait and see whether the dynamic Q
calculation does actually show up in profiles before thinking about
optimizations like e.g. precomputations.

Thanks,

Nicolai

>
> If you need Q for all of those safe-primes, you may get them from [1] and=
=20
> following lines.
>
> [1] https://github.com/smuellerDD/acvpparser/blob/master/parser/
> safeprimes.h#L346
>
> Ciao
> Stephan
>
>

--=20
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, G=
ermany
(HRB 36809, AG N=C3=BCrnberg), GF: Ivo Totev
