Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A90E4A6EE4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237894AbiBBKl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:41:28 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41748 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiBBKl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:41:26 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B7AB32110B;
        Wed,  2 Feb 2022 10:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643798485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ltQWgxs1hZJaXyb5EOG83MmulANVyd58GuQIHA710Gw=;
        b=tv/afUwIFi1MQ3xi4QXiQphZqX3xdC0KwmWeKxuQ7ggbrjof7uL1ZhODZziE5cqp7u5+Q+
        lEVkm4aIiy/t2+KSM3D+t2zA7vPhn7dUD8cnsEMT0kyYV5sjAHV71KGugpiGMdSUB0mCk/
        dEqhSd0+vy7bkERxfoED2PoUwqDjU9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643798485;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ltQWgxs1hZJaXyb5EOG83MmulANVyd58GuQIHA710Gw=;
        b=B3y0aeF5gz2ntvs7wCZKEcZu1eD+glUdPfNRot9SPHwcd/gxZVxb0VA+IMesG0jK0Qu1C3
        7DpADPw+ONun/1Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2F7B13E02;
        Wed,  2 Feb 2022 10:41:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hTVhJ9Vf+mFNbAAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 02 Feb 2022 10:41:25 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: [PATCH v3 00/15] crypto: dh - infrastructure for NVM in-band auth and FIPS conformance
Date:   Wed,  2 Feb 2022 11:39:57 +0100
Message-Id: <20220202104012.4193-1-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

first of all, to the people primarily interested in security/keys/, there's
a rather trivial change to security/keys/dh.c in patch 4/15. It would be
great to get ACKs for that...

This is a complete rework of the v2 patchset to be found at [1]. Most
notably, the ffdheXYZ groups are now made accessible by means of templates
wrapping the generic dh: ffdhe2048(dh) ffdhe3072(dh), etc, rather than by
that fixed enum dh_group_id as before. For your reference, this change has
been suggested at [2].

Plain "dh" usage will be disallowed in FIPS mode now, which will break
keyctl(KEYCTL_DH_COMPUTE) functionality in FIPS mode. As per the
discussion from [2], this is acceptable or perhaps even desirable.

The only motivation to include the RFC 3526 MODP groups in the previous v2
had been to keep keyctl(KEYCTL_DH_COMPUTE) somewhat workable in FIPS mode.
These groups have been dropped accordingly now and this patchset only
introduces support for the RFC 7919 FFDHE groups, which is what is needed
by NVM in-band authentication.

In order to be able to restrict plain "dh" usage in FIPS mode while
still allowing the usage of those new ffdheXYZ(dh) instantiations, I
incorporated a modified version of the patch posted by Herbert at
[3] ("crypto: api - Disallow sha1 in FIPS-mode while allowing hmac(sha1)")
into this series here as [12/15] ("crypto: api - allow algs only in
specific constructions in FIPS mode"). There had been two changes worth
mentioning:
- An attempt to make it more generic by having crypto_grab_spawn()
  to include FIPS_INTERNAL in the lookup and also, to let
  crypto_register_instance() to propagate this flag from the
  child spawns into the instance to be registered.
- To skip the actual self-test executions for !->fips_allowed algorithms,
  just as before. The rationale for this can be found in the discussion to
  [3].
With these changes, all breakage is to blame on me and thus, I assumed
authorship of this patch. I reflected the fact that this is heavily based
on Herbert's work by means of an Originally-by tag and sincerely hope this
is an appropriate way of recording the patch's history.

This series has been tested on x86_64 and s390x (big endian) with FIPS mode
both enabled and disabled each.

Thanks!

Nicolai

[1] https://lore.kernel.org/r/20211209090358.28231-1-nstange@suse.de
[2] https://lore.kernel.org/r/20211217055227.GA20698@gondor.apana.org.au
[3] https://lore.kernel.org/r/Yd0gInht+V+Kcsw2@gondor.apana.org.au

Nicolai Stange (15):
  crypto: kpp - provide support for KPP template instances
  crypto: kpp - provide support for KPP spawns
  crypto: dh - remove struct dh's ->q member
  crypto: dh - constify struct dh's pointer members
  crypto: dh - split out deserialization code from crypto_dh_decode()
  crypto: dh - introduce common code for built-in safe-prime group
    support
  crypto: dh - implement ffdheXYZ(dh) templates
  crypto: testmgr - add known answer tests for ffdheXYZ(dh) templates
  crypto: dh - implement private key generation primitive for
    ffdheXYZ(dh)
  crypto: testmgr - add keygen tests for ffdheXYZ(dh) templates
  crypto: dh - allow for passing NULL to the ffdheXYZ(dh)s'
    ->set_secret()
  crypto: api - allow algs only in specific constructions in FIPS mode
  crypto: dh - disallow plain "dh" usage in FIPS mode
  lib/mpi: export mpi_rshift
  crypto: dh - calculate Q from P for the full public key verification

 crypto/Kconfig                |    8 +
 crypto/algapi.c               |   18 +-
 crypto/api.c                  |   19 +-
 crypto/dh.c                   |  687 +++++++++++++++-
 crypto/dh_helper.c            |   44 +-
 crypto/kpp.c                  |   29 +
 crypto/tcrypt.c               |    4 +-
 crypto/testmgr.c              |   61 +-
 crypto/testmgr.h              | 1445 ++++++++++++++++++++++++++++++++-
 include/crypto/dh.h           |   26 +-
 include/crypto/internal/kpp.h |  158 ++++
 include/linux/crypto.h        |    9 +
 lib/mpi/mpi-bit.c             |    1 +
 security/keys/dh.c            |    2 +-
 14 files changed, 2443 insertions(+), 68 deletions(-)

-- 
2.26.2

