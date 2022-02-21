Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897F74BDBEA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245136AbiBUMOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:14:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357494AbiBUMOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:14:05 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A33B205F6;
        Mon, 21 Feb 2022 04:11:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 85C6B1F38E;
        Mon, 21 Feb 2022 12:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645445471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=NOqTT1XNzh9fvTWq3EP6c+EQZqVe2ujBsleekauTIRM=;
        b=eD6b9B49JF6/+W2shYM8+/n3Fr2qpshlYHS78/lbq6n1sMBFsXdZnddruiU0kcDIpjy41p
        g5Ef03y0PYrUnzuv6jNPgHrG5PddSCsZveH21MNvU+TBg/2q29QO7xZZIEcwimrxBndK+K
        be40IF9YnmFTjfO7LwBPkPgz4qnAwXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645445471;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=NOqTT1XNzh9fvTWq3EP6c+EQZqVe2ujBsleekauTIRM=;
        b=c5G7g3s4A9OB2zWz54Qxh02mb6doK/LU12FROawvVZGQDLjxLoTSDjJlAAmTBhLVHwgI1j
        fWEWcoVo7qUuODBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 667BA13A9C;
        Mon, 21 Feb 2022 12:11:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id A7j6GF+BE2JRWwAAMHmgww
        (envelope-from <nstange@suse.de>); Mon, 21 Feb 2022 12:11:11 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: [PATCH v4 00/15] crypto: dh - infrastructure for NVM in-band auth and FIPS conformance
Date:   Mon, 21 Feb 2022 13:10:46 +0100
Message-Id: <20220221121101.1615-1-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

first of all, to the people primarily interested in security/keys/, there's
a rather trivial change to security/keys/dh.c in patch 4/15. It would be
great to get ACKs for that...

This patchset's main objective is to provide the DH related preprequisite
bits needed by the upcoming support for NVME in-band authentication ([1]),
namely
- support for the RFC 7919 ffdheXYZ group parameters (patches [1-8/15]) and
- an ephemeral key generation primitive for these (patches [9-11/15]).

With this in place, it happens to become relatively straight-forward to
achieve conformance with NIST SP800-56Ar3. The remainder of this patchset,
i.e. patches [12-15/15], implements the required changes.

The previous v3 of this patchset can be found at [2]. The only difference
between v3 and the v4 here is the removal of a superfluous "default n"
Kconfig statement in patch [7/15] ("crypto: dh - implement ffdheXYZ(dh)
templates").

I would like to reiterate that [12/15] ("crypto: api - allow algs only in
specific constructions in FIPS mode") is heavily based on a patch
previously posted by Herbert. Please refer to the v3 cover letter at [2]
for the full history.

Finally note that Stephan has granted his
Tested-by: Stephan Mueller <smueller@chronox.de>
to v3 already ([3]). Stephan, with the trivial diff between v3 and v4,
would you be Ok with carrying it over?

Thanks,

Nicolai

[1] https://lore.kernel.org/r/20211202152358.60116-1-hare@suse.de
[2] https://lore.kernel.org/r/20220202104012.4193-1-nstange@suse.de
[3] https://lore.kernel.org/r/8937519.l8FpVtv5Hg@tauon.chronox.de

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

 crypto/Kconfig                |    7 +
 crypto/algapi.c               |   18 +-
 crypto/api.c                  |   19 +-
 crypto/dh.c                   |  687 +++++++++++++++-
 crypto/dh_helper.c            |   42 +-
 crypto/kpp.c                  |   29 +
 crypto/tcrypt.c               |    4 +-
 crypto/testmgr.c              |   61 +-
 crypto/testmgr.h              | 1445 ++++++++++++++++++++++++++++++++-
 include/crypto/dh.h           |   26 +-
 include/crypto/internal/kpp.h |  158 ++++
 include/linux/crypto.h        |    9 +
 lib/mpi/mpi-bit.c             |    1 +
 security/keys/dh.c            |    2 +-
 14 files changed, 2441 insertions(+), 67 deletions(-)

-- 
2.26.2

