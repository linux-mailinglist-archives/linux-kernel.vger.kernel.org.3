Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35EA49FB6F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 15:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348918AbiA1OOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 09:14:43 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:53126 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348069AbiA1OOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 09:14:41 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8E2311F385;
        Fri, 28 Jan 2022 14:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643379280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CTHAmo7gQBUFA1fTDySimisIz/TBMzybVfp9a9saT4Q=;
        b=Br58rQV4TYwrowQa6637A4b+moWJk+s72s31wv5NA85IbeRSj2FH0MJoj6ejEVBC8WKOxK
        YFl6EuzrttQAvXfuNiI2OJI3i/IYCeKxgS0J++ahGWUoJ+NAJY70Li/l0N0tql1POs55fe
        nVAbj08A5zimTJHy/wwAVEeG/gEVSfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643379280;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CTHAmo7gQBUFA1fTDySimisIz/TBMzybVfp9a9saT4Q=;
        b=DCEBqbOv/dHXxtGmJWmsYD0iyk/HhW/q4LaDm9GwQF8zHLkLDu9gfb77CmRkuLk49cyx8w
        +LuhKOEwUzJ/ilCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 07B3813487;
        Fri, 28 Jan 2022 14:14:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8zpKAFD682FLHAAAMHmgww
        (envelope-from <nstange@suse.de>); Fri, 28 Jan 2022 14:14:40 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Nicolai Stange <nstange@suse.de>,
        Stephan Mueller <smueller@chronox.de>,
        "David S. Miller" <davem@davemloft.net>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org, simo@redhat.com,
        Eric Biggers <ebiggers@kernel.org>, Petr Vorel <pvorel@suse.cz>
Subject: Re: [v2 PATCH] crypto: api - Disallow sha1 in FIPS-mode while allowing hmac(sha1)
References: <20211209090358.28231-1-nstange@suse.de> <87r1a7thy0.fsf@suse.de>
        <YcvEkfS4cONDXXB9@gondor.apana.org.au>
        <2468270.qO8rWLYou6@tauon.chronox.de>
        <YdepEhTI/LB9wdJr@gondor.apana.org.au>
        <Yd0gInht+V+Kcsw2@gondor.apana.org.au> <871r1eyamd.fsf@suse.de>
        <Yd1dK//76455cHdz@gondor.apana.org.au>
        <YeEVSaMEVJb3cQkq@gondor.apana.org.au> <87k0f2hefl.fsf@suse.de>
        <YeFWnscvXtv73KBl@gondor.apana.org.au>
Date:   Fri, 28 Jan 2022 15:14:39 +0100
In-Reply-To: <YeFWnscvXtv73KBl@gondor.apana.org.au> (Herbert Xu's message of
        "Fri, 14 Jan 2022 21:55:26 +1100")
Message-ID: <87v8y4dk1c.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> writes:

> On Fri, Jan 14, 2022 at 10:09:02AM +0100, Nicolai Stange wrote:
>
>> This looks all good to me, but as !->fips_allowed tests aren't skipped
>> over anymore now, it would perhaps make sense to make their failure
>> non-fatal in FIPS mode. Because in FIPS mode a failure could mean a
>> panic and some of the existing TVs might not pass because of e.g. some
>> key length checks or so active only for fips_enabled...
>
> You mean a buggy non-FIPS algorithm that fails when tested in
> FIPS mode?  I guess we could skip the panic in that case if
> everyone is happy with that.  Stephan?

One more thing I just realized: dracut's fips module ([1]) modprobes
tcrypt (*) and failure is considered fatal, i.e. the system would not
boot up.

First of all this would mean that tcrypt_test() needs to ignore
-ECANCELED return values from alg_test() in FIPS mode, in addition to
the -EINVAL it is already prepared for.

However, chances are that some of the !fips_allowed algorithms looped
over by tcrypt are not available (i.e. not enabled at build time) and as
this change here makes alg_test() to unconditionally attempt a test
execution now, this would fail with -ENOENT AFAICS.

One way to work around this is to make tcrypt_test() to ignore -ENOENT
in addition to -EINVAL and -ECANCELED.

It might be undesirable though that the test executions triggered from
tcrypt would still instantiate/load a ton of !fips_allowed algorithms at
boot, most of which will effectively be inaccessible (because they're
not used as FIPS_INTERNAL arguments to fips_allowed =3D=3D 1 template
instances).

So how about making alg_test() to skip the !fips_allowed tests in FIPS
mode as before, but to return -ECANCELED and eventually set
FIPS_INTERNAL as implemented with this patch here.

This would imply that FIPS_INTERNAL algorithms by themselves remain
untested, but I think this might be Ok as they would be usable only as
template arguments in fips_allowed instantiations. That is, they will
still receive some form of testing when the larger construction they're
part of gets tested.

For example, going with the "dh" example, where "dh" and "ffdhe3072(dh)"
would have fips_allowed unset and set respecively, ffdhe3072(dh) as
a whole would get tested, but not the "dh" argument individually.

Stephan, would this approach work from a FIPS 140-3 perspective?

Thanks!

Nicolai

[1] https://git.kernel.org/pub/scm/boot/dracut/dracut.git/tree/modules.d/01=
fips/fips.sh#n106
(*) I'm not sure why this is being done, but it is what it is.

--=20
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, G=
ermany
(HRB 36809, AG N=C3=BCrnberg), GF: Ivo Totev
