Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5414CB335
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 01:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiCCAA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 19:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiCCAAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:00:53 -0500
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D48C13D2E;
        Wed,  2 Mar 2022 16:00:05 -0800 (PST)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nPXvY-0006Ci-I9; Thu, 03 Mar 2022 09:58:37 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 03 Mar 2022 10:58:36 +1200
Date:   Thu, 3 Mar 2022 10:58:36 +1200
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Nicolai Stange <nstange@suse.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Subject: Re: [PATCH v4 00/15] crypto: dh - infrastructure for NVM in-band
 auth and FIPS conformance
Message-ID: <Yh/2nD1wEh0BovMC@gondor.apana.org.au>
References: <20220221121101.1615-1-nstange@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221121101.1615-1-nstange@suse.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 01:10:46PM +0100, Nicolai Stange wrote:
> Hi all,
> 
> first of all, to the people primarily interested in security/keys/, there's
> a rather trivial change to security/keys/dh.c in patch 4/15. It would be
> great to get ACKs for that...
> 
> This patchset's main objective is to provide the DH related preprequisite
> bits needed by the upcoming support for NVME in-band authentication ([1]),
> namely
> - support for the RFC 7919 ffdheXYZ group parameters (patches [1-8/15]) and
> - an ephemeral key generation primitive for these (patches [9-11/15]).
> 
> With this in place, it happens to become relatively straight-forward to
> achieve conformance with NIST SP800-56Ar3. The remainder of this patchset,
> i.e. patches [12-15/15], implements the required changes.
> 
> The previous v3 of this patchset can be found at [2]. The only difference
> between v3 and the v4 here is the removal of a superfluous "default n"
> Kconfig statement in patch [7/15] ("crypto: dh - implement ffdheXYZ(dh)
> templates").
> 
> I would like to reiterate that [12/15] ("crypto: api - allow algs only in
> specific constructions in FIPS mode") is heavily based on a patch
> previously posted by Herbert. Please refer to the v3 cover letter at [2]
> for the full history.
> 
> Finally note that Stephan has granted his
> Tested-by: Stephan Mueller <smueller@chronox.de>
> to v3 already ([3]). Stephan, with the trivial diff between v3 and v4,
> would you be Ok with carrying it over?
> 
> Thanks,
> 
> Nicolai
> 
> [1] https://lore.kernel.org/r/20211202152358.60116-1-hare@suse.de
> [2] https://lore.kernel.org/r/20220202104012.4193-1-nstange@suse.de
> [3] https://lore.kernel.org/r/8937519.l8FpVtv5Hg@tauon.chronox.de
> 
> Nicolai Stange (15):
>   crypto: kpp - provide support for KPP template instances
>   crypto: kpp - provide support for KPP spawns
>   crypto: dh - remove struct dh's ->q member
>   crypto: dh - constify struct dh's pointer members
>   crypto: dh - split out deserialization code from crypto_dh_decode()
>   crypto: dh - introduce common code for built-in safe-prime group
>     support
>   crypto: dh - implement ffdheXYZ(dh) templates
>   crypto: testmgr - add known answer tests for ffdheXYZ(dh) templates
>   crypto: dh - implement private key generation primitive for
>     ffdheXYZ(dh)
>   crypto: testmgr - add keygen tests for ffdheXYZ(dh) templates
>   crypto: dh - allow for passing NULL to the ffdheXYZ(dh)s'
>     ->set_secret()
>   crypto: api - allow algs only in specific constructions in FIPS mode
>   crypto: dh - disallow plain "dh" usage in FIPS mode
>   lib/mpi: export mpi_rshift
>   crypto: dh - calculate Q from P for the full public key verification
> 
>  crypto/Kconfig                |    7 +
>  crypto/algapi.c               |   18 +-
>  crypto/api.c                  |   19 +-
>  crypto/dh.c                   |  687 +++++++++++++++-
>  crypto/dh_helper.c            |   42 +-
>  crypto/kpp.c                  |   29 +
>  crypto/tcrypt.c               |    4 +-
>  crypto/testmgr.c              |   61 +-
>  crypto/testmgr.h              | 1445 ++++++++++++++++++++++++++++++++-
>  include/crypto/dh.h           |   26 +-
>  include/crypto/internal/kpp.h |  158 ++++
>  include/linux/crypto.h        |    9 +
>  lib/mpi/mpi-bit.c             |    1 +
>  security/keys/dh.c            |    2 +-
>  14 files changed, 2441 insertions(+), 67 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
