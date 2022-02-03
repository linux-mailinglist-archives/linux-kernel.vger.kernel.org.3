Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500E14A8990
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbiBCRMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:12:02 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:39199 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbiBCRL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:11:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1643908315;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=in3ANS4p1/EJ1Vk8fAo3enQEiM4qdqkOrQ7NVZWdrM0=;
    b=g43WW+klKEcQR1r6HM6JPA2vjUlwLzEaEEnxW/6JKB4llxJzBhans5dXOIxpgSEtAn
    wZJFOOwTRwvty9UnrL9uTsIV54zWKO/4x21z9kk9OAictzIeZMNeT3kW9NLIUNzhCnnA
    naRiTC0XbuMUoeJuJxoHCSE62589gRJs2QF6ImUIBqLe/Cbndn4rGu4XYGO4t3JssvZ5
    cZQQh8oGjrosgrv61nXxlKKDfs+uDjMkIpqdW/vdwx/yzJMps4sQAeVrrHcDAxTpTnMy
    16Wo0pMxJ6R+4GouMHQSo87JowHowitTTVIEpQnzD7I+vbUH4pZm/43s18q6TBjhRuvr
    5K9A==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zW8BKRp5UFiyGZZ4jof7Xg=="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
    by smtp.strato.de (RZmta 47.39.0 AUTH)
    with ESMTPSA id z28df7y13HBsGQ7
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 3 Feb 2022 18:11:54 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolai Stange <nstange@suse.de>
Cc:     Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: Re: [PATCH v3 00/15] crypto: dh - infrastructure for NVM in-band auth and FIPS conformance
Date:   Thu, 03 Feb 2022 18:11:53 +0100
Message-ID: <8937519.l8FpVtv5Hg@tauon.chronox.de>
In-Reply-To: <20220202104012.4193-1-nstange@suse.de>
References: <20220202104012.4193-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 2. Februar 2022, 11:39:57 CET schrieb Nicolai Stange:

Hi Nicolai,

> Hi all,
> 
> first of all, to the people primarily interested in security/keys/, there's
> a rather trivial change to security/keys/dh.c in patch 4/15. It would be
> great to get ACKs for that...
> 
> This is a complete rework of the v2 patchset to be found at [1]. Most
> notably, the ffdheXYZ groups are now made accessible by means of templates
> wrapping the generic dh: ffdhe2048(dh) ffdhe3072(dh), etc, rather than by
> that fixed enum dh_group_id as before. For your reference, this change has
> been suggested at [2].
> 
> Plain "dh" usage will be disallowed in FIPS mode now, which will break
> keyctl(KEYCTL_DH_COMPUTE) functionality in FIPS mode. As per the
> discussion from [2], this is acceptable or perhaps even desirable.
> 
> The only motivation to include the RFC 3526 MODP groups in the previous v2
> had been to keep keyctl(KEYCTL_DH_COMPUTE) somewhat workable in FIPS mode.
> These groups have been dropped accordingly now and this patchset only
> introduces support for the RFC 7919 FFDHE groups, which is what is needed
> by NVM in-band authentication.
> 
> In order to be able to restrict plain "dh" usage in FIPS mode while
> still allowing the usage of those new ffdheXYZ(dh) instantiations, I
> incorporated a modified version of the patch posted by Herbert at
> [3] ("crypto: api - Disallow sha1 in FIPS-mode while allowing hmac(sha1)")
> into this series here as [12/15] ("crypto: api - allow algs only in
> specific constructions in FIPS mode"). There had been two changes worth
> mentioning:
> - An attempt to make it more generic by having crypto_grab_spawn()
>   to include FIPS_INTERNAL in the lookup and also, to let
>   crypto_register_instance() to propagate this flag from the
>   child spawns into the instance to be registered.
> - To skip the actual self-test executions for !->fips_allowed algorithms,
>   just as before. The rationale for this can be found in the discussion to
>   [3].
> With these changes, all breakage is to blame on me and thus, I assumed
> authorship of this patch. I reflected the fact that this is heavily based
> on Herbert's work by means of an Originally-by tag and sincerely hope this
> is an appropriate way of recording the patch's history.
> 
> This series has been tested on x86_64 and s390x (big endian) with FIPS mode
> both enabled and disabled each.

Using the NIST ACVP reference implementation, shared secret computation and 
key generation was successfully tested.

Tested-by: Stephan Mueller <smueller@chronox.de>


Ciao
Stephan


