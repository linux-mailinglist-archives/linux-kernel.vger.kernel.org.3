Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16644464443
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 01:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345934AbhLAAyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 19:54:46 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58232 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345938AbhLAAw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 19:52:57 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BE9C61FDFC;
        Wed,  1 Dec 2021 00:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638319776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JThRvp/hqu9/eogpWopPh6mPtHyPqDj7JZnDSMgotJE=;
        b=FwbOLHLshva1FoWxPh4H6OarQHxZlUFGmMIfAHOLRpN9eYbc9zO93VYLKVVoC4wS9uc/Rb
        b8ygRIhNC4s+oMQF9DZo26XkxWBOmdEWFnmizAYAuzCqTri2HsczxOcF0LhGge1rysF5Ye
        zUt84BONyayw3F+dhP3PKERDX82fF7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638319776;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JThRvp/hqu9/eogpWopPh6mPtHyPqDj7JZnDSMgotJE=;
        b=QeYNWon0GhKbN1dmlA/goUz+dvD53jvtp5GUP9DtPTbyr/fQ3e4/IAL5YiZi1tuv/iJAFg
        2ebc87UCXqdRnXCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AAC2613C10;
        Wed,  1 Dec 2021 00:49:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 11odKKDGpmENKQAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 01 Dec 2021 00:49:36 +0000
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
Subject: [PATCH 18/18] crypto: dh - accept only approved safe-prime groups in FIPS mode
Date:   Wed,  1 Dec 2021 01:48:58 +0100
Message-Id: <20211201004858.19831-19-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211201004858.19831-1-nstange@suse.de>
References: <20211201004858.19831-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SP800-56Arev3, sec. 5.5.2 ("Assurance of Domain-Parameter Validity")
asserts that an implementation needs to verify domain paramtere validity,
which boils down to either
- the domain parameters corresponding to some known safe-prime group
  explicitly listed to be approved in the document or
- for parameters conforming to a "FIPS 186-type parameter-size set",
  that the implementation needs to perform an explicit domain parameter
  verification, which would require access to the "seed" and "counter"
  values used in their generation.

The latter is not easily feasible and moreover, SP800-56Arev3 states that
safe-prime groups are preferred and that FIPS 186-type parameter sets
should only be supported for backward compatibility, if it all.

Make the dh implementations reject any domain parameters which don't
correspond to any of the approved safe-prime groups in FIPS mode. The
approved safe-prime groups are the ones specified in RFC 7919 and RFC 3526,
and given that all possible values of enum dh_group_id correspond to
either groups from these RFCs or to dh_group_id_unknown, it suffices to
make crypto_dh_decode_key() to reject any parameter set where
->group_id == dh_group_id_unknown.

As this change will effectively render the dh implementation unusable in
FIPS mode if neither of the CRYPTO_DH_GROUPS_RFC7919 or
CRYPTO_DH_GROUPS_RFC3526 Kconfig options enabled, make CRYPTO_DH imply
these two if CRYPTO_FIPS is set.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 crypto/Kconfig     | 2 ++
 crypto/dh_helper.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 578711b02bb3..571f2271ad2e 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -229,6 +229,8 @@ menuconfig CRYPTO_DH
 	select CRYPTO_KPP
 	select MPILIB
 	select CRYPTO_RNG_DEFAULT
+	imply CRYPTO_DH_GROUPS_RFC7919 if CRYPTO_FIPS
+	imply CRYPTO_DH_GROUPS_RFC3526 if CRYPTO_FIPS
 	help
 	  Generic implementation of the Diffie-Hellman algorithm.
 
diff --git a/crypto/dh_helper.c b/crypto/dh_helper.c
index cf632beca65e..f30674df0d76 100644
--- a/crypto/dh_helper.c
+++ b/crypto/dh_helper.c
@@ -7,6 +7,7 @@
 #include <linux/export.h>
 #include <linux/err.h>
 #include <linux/string.h>
+#include <linux/fips.h>
 #include <crypto/dh.h>
 #include <crypto/kpp.h>
 #include <crypto/rng.h>
@@ -622,6 +623,9 @@ int crypto_dh_decode_key(const char *buf, unsigned int len, struct dh *params)
 	    params->g_size > params->p_size)
 		return -EINVAL;
 
+	/* Only safe-prime groups are allowed in FIPS mode. */
+	if (fips_enabled && params->group_id == dh_group_id_unknown)
+		return -EINVAL;
 
 	return 0;
 }
-- 
2.26.2

