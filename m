Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB6346443D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 01:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346025AbhLAAyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 19:54:21 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58100 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345904AbhLAAwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 19:52:50 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BC4C11FD5C;
        Wed,  1 Dec 2021 00:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638319769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/f42g4TvD+woxv+Oq7dfGuZGHJnzlWVrLnH1uItsoJM=;
        b=jaQP4pTI5Gc89hYoqCroIErYQldJD6Qvgn0GIMbtm6gVXxHzbV22b3VQ0NezZ1Bbf1Fugi
        5tIeArU2aQEub+NCVAwEd9424mDKssww9PnjYI5zyz6XZIme1pHXT+nG/+cj++OOBz2Qfd
        wtzSXrdRVohJjMZN0D01skmr10Mchps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638319769;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/f42g4TvD+woxv+Oq7dfGuZGHJnzlWVrLnH1uItsoJM=;
        b=j0pgj78shvZF1E5cQFElb6tF+voPf67iR/UA7pdbFavV7I2DSlugSCGJULAoVydiB6xve8
        Cm94+RbEVv/hZpCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E45513C10;
        Wed,  1 Dec 2021 00:49:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bwwWJZnGpmH0KAAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 01 Dec 2021 00:49:29 +0000
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
Subject: [PATCH 08/18] crypto: testmgr - run only subset of DH vectors based on config
Date:   Wed,  1 Dec 2021 01:48:48 +0100
Message-Id: <20211201004858.19831-9-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211201004858.19831-1-nstange@suse.de>
References: <20211201004858.19831-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the previous patches, the testmgr now has up to four test vectors for
DH which all test more or less the same thing:
- the two vectors from before this series,
- the vector for the ffdhe2048 group, enabled if
  CONFIG_CRYPTO_DH_GROUPS_RFC7919 is set and
- the vector for the modp2048 group, similarly enabled if
  CONFIG_CRYPTO_DH_GROUPS_RFC3526 is set.

In order to avoid too much redundancy during DH testing, enable only a
subset of these depending on the kernel config:
- if CONFIG_CRYPTO_DH_GROUPS_RFC7919 is set, enable only the ffdhe2048
  vector,
- otherwise, if CONFIG_CRYPTO_DH_GROUPS_RFC3526 is set, enable only
  the modp2048 vector and
- only enable the original two vectors if neither of these options
  has been selected.

Note that an upcoming patch will make the DH implementation to reject any
domain parameters not corresponding to some safe-prime group approved by
SP800-56Arev3 in FIPS mode. Thus, having CONFIG_FIPS enabled, but
both of CONFIG_CRYPTO_DH_GROUPS_RFC7919 and
CONFIG_CRYPTO_DH_GROUPS_RFC3526 unset wouldn't make much sense as it would
render the DH implementation unusable in FIPS mode. Conversely, any
reasonable configuration would ensure that the original, non-conforming
test vectors would not get to run in FIPS mode.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 crypto/testmgr.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index d18844c7499e..b295512c8f22 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -1331,8 +1331,7 @@ static const struct kpp_testvec dh_tv_template[] = {
 	.expected_a_public_size = 256,
 	.expected_ss_size = 256,
 	},
-#endif /* IS_ENABLED(CONFIG_CRYPTO_DH_GROUPS_RFC7919) */
-#if IS_ENABLED(CONFIG_CRYPTO_DH_GROUPS_RFC3526)
+#elif IS_ENABLED(CONFIG_CRYPTO_DH_GROUPS_RFC3526)
 	{
 	.secret =
 #ifdef __LITTLE_ENDIAN
@@ -1423,7 +1422,7 @@ static const struct kpp_testvec dh_tv_template[] = {
 	.expected_a_public_size = 256,
 	.expected_ss_size = 256,
 	},
-#endif /* IS_ENABLED(CONFIG_CRYPTO_DH_GROUPS_RFC3526) */
+#else
 	{
 	.secret =
 #ifdef __LITTLE_ENDIAN
@@ -1642,6 +1641,7 @@ static const struct kpp_testvec dh_tv_template[] = {
 	.expected_a_public_size = 256,
 	.expected_ss_size = 256,
 	},
+#endif
 };
 
 static const struct kpp_testvec curve25519_tv_template[] = {
-- 
2.26.2

