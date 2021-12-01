Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5733146440E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 01:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345885AbhLAAwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 19:52:47 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57998 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236871AbhLAAwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 19:52:45 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 08B961FD2F;
        Wed,  1 Dec 2021 00:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638319764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=LA2v/lPyow+GI4apO4cJeHeib2qXUxj68Q/tyAlOjcU=;
        b=bNbB/4xeJ6bnNLNFL8t1RgOLCOAaUf8LwXrtPM9lvE6DKt/snzAJXmjm48CAGAV0LQmdAL
        C0XqVCNP5PtHZEpVnuMVLq0rtac26/MqKc6udDf9r4GRKszelTMPcSlyfwiMdc3uidzeVe
        1CmIVtJkL8RSl4LuREmrzAIIvpuxIhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638319764;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=LA2v/lPyow+GI4apO4cJeHeib2qXUxj68Q/tyAlOjcU=;
        b=TzSMNZq0xVzyNQ3zvw+vWBV7Zpf9CovkivThO4jsIiRFQDjUtldbSAzf56ET3hrbL+e2TF
        ZXc0OUWGAieY9zCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E655613C10;
        Wed,  1 Dec 2021 00:49:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LtClNpPGpmHbKAAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 01 Dec 2021 00:49:23 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org,
        Nicolai Stange <nstange@suse.de>
Subject: [PATCH 00/18] crypto: dh - infrastructure for NVM in-band auth and FIPS conformance
Date:   Wed,  1 Dec 2021 01:48:40 +0100
Message-Id: <20211201004858.19831-1-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

first of all, to the people primarily interested in security/keys/, there's
a rather trivial change to security/keys/dh.c in patch 2/18. It would be
great to get ACKs for that...


Hannes' recent work on NVME in-band authentication ([1]) needs access to
the RFC 7919 DH group parameters and also some means to generate ephemeral
keys. He currently implements both as part of his patchset (patches 3/12
and 8/12). After some internal discussion, we decided to split off the bits
needed from crypto/dh into a separate series, i.e. this one here:
 - for the RFC 7919 DH group parameters, it's undesirable from a
   performance POV to serialize the well-known domain parameters via
   crypto_dh_encode_key() just to deserialize them shortly after again,
 - from an architectural POV, it would be preferrable to have the key
   generation code in crypto/dh.c rather than in drivers/nvme/,
   just in analogy to how key generation is supported by crypto/ecdh.c
   already.

Patches 1-13/18 implement all that is needed for the NVME in-band
authentication support. 

Unfortunately, due to the lack of HW, I have not been able to test
the changes to the QAT or HPRE drivers (other than mere compile tests).
Yet I figured it would be a good idea to have them behave consistently with
dh_generic, and so I chose to introduce support for privkey generation to
these as well.


By coincidence, NIST SP800-56Arev3 compliance effectively requires that
the domain parameters are checked against an approved set, which happens
to consists of those safe-prime group parameters specified in RFC 7919,
among others. Thus, introducing the RFC 7919 parameters to the kernel
allows for making the DH implementation to conform to SP800-56Arev3 with
only little effort. I used the opportunity to work crypto/dh towards
SP800-56Arev3 conformance with the rest of this patch series, i.e.
patches 14-18/18. I can split these into another series on its own, if you
like. But as they depend on the earlier patches 1-13/18, I sent them
alongside for now.

This patchset has been tested with and without fips_enabled on x86_64,
ppc64le and s390x, the latter being a big endian machine, which is relevant
for the new test vectors.

Thanks,

Nicolai

[1] https://lkml.kernel.org/r/20211123123801.73197-1-hare@suse.de

Nicolai Stange (18):
  crypto: dh - remove struct dh's ->q member
  crypto: dh - constify struct dh's pointer members
  crypto: dh - optimize domain parameter serialization for well-known
    groups
  crypto: dh - introduce RFC 7919 safe-prime groups
  crypto: testmgr - add DH RFC 7919 ffdhe2048 test vector
  crypto: dh - introduce RFC 3526 safe-prime groups
  crypto: testmgr - add DH RFC 3526 modp2048 test vector
  crypto: testmgr - run only subset of DH vectors based on config
  crypto: dh - implement private key generation primitive
  crypto: dh - introduce support for ephemeral key generation to
    dh-generic
  crypto: dh - introduce support for ephemeral key generation to hpre
    driver
  crypto: dh - introduce support for ephemeral key generation to qat
    driver
  crypto: testmgr - add DH test vectors for key generation
  lib/mpi: export mpi_rshift
  crypto: dh - store group id in dh-generic's dh_ctx
  crypto: dh - calculate Q from P for the full public key verification
  crypto: dh - try to match domain parameters to a known safe-prime
    group
  crypto: dh - accept only approved safe-prime groups in FIPS mode

 crypto/Kconfig                                |  20 +-
 crypto/dh.c                                   |  73 +-
 crypto/dh_helper.c                            | 691 +++++++++++++++++-
 crypto/testmgr.h                              | 342 ++++++++-
 drivers/crypto/hisilicon/hpre/hpre_crypto.c   |  11 +
 drivers/crypto/qat/qat_common/qat_asym_algs.c |   9 +
 include/crypto/dh.h                           |  52 +-
 lib/mpi/mpi-bit.c                             |   1 +
 security/keys/dh.c                            |   2 +-
 9 files changed, 1141 insertions(+), 60 deletions(-)

-- 
2.26.2

