Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB1546E509
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbhLIJIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:08:48 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55146 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbhLIJIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:08:13 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 61AB3210FE;
        Thu,  9 Dec 2021 09:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639040679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IZg49RUjlaBwZL0UoVGR8SYMJcE8TonIRswbttkRw2E=;
        b=RRZhP2J6dua1jRMtMp6ydy3jEhRspnqkqwGPbRrJM0SxKrLW9hMRsc3ia0QdSXtqoQwGXj
        LIQUmPq10w1sFzBBrwyX4oolOB3JRm8FesENCKdiUu3UsVER+kwoWVl4ra3Lddu9Je2Ijb
        NgUrs98oxpWkD/SbTzwRy//UaPQk/aI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639040679;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IZg49RUjlaBwZL0UoVGR8SYMJcE8TonIRswbttkRw2E=;
        b=je+5tUoMH3n8h8gMosRvTcdMGNowsbXtut81A9rixQs2QI/yx+JHAmVgOrASBIMEuwJtXH
        Yzs8UmKuO/3/VMAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4CB7913A86;
        Thu,  9 Dec 2021 09:04:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jjpCEafGsWHwaQAAMHmgww
        (envelope-from <nstange@suse.de>); Thu, 09 Dec 2021 09:04:39 +0000
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
Subject: [PATCH v2 18/18] crypto: dh - accept only approved safe-prime groups in FIPS mode
Date:   Thu,  9 Dec 2021 10:03:58 +0100
Message-Id: <20211209090358.28231-19-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211209090358.28231-1-nstange@suse.de>
References: <20211209090358.28231-1-nstange@suse.de>
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
either groups from these RFCs or to DH_GROUP_ID_UNKNOWN, it suffices to
make crypto_dh_decode_key() to reject any parameter set where
->group_id == DH_GROUP_ID_UNKNOWN.

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
index b8a726b610a2..fafaf3c30bb1 100644
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
@@ -624,6 +625,9 @@ int crypto_dh_decode_key(const char *buf, unsigned int len, struct dh *params)
 	    params->g_size > params->p_size)
 		return -EINVAL;
 
+	/* Only safe-prime groups are allowed in FIPS mode. */
+	if (fips_enabled && params->group_id == DH_GROUP_ID_UNKNOWN)
+		return -EINVAL;
 
 	return 0;
 }
-- 
2.26.2

