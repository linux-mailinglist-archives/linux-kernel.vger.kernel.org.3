Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE4E46E50A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236353AbhLIJIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:08:52 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:54960 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbhLIJIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:08:00 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C0A3F210FF;
        Thu,  9 Dec 2021 09:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639040666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x0SJv2HsWDiDbMzafU+kDZ22w6PYjSfZS/lcRvvYuV8=;
        b=MqrNsr3eBBXTMcL4KaLN1/Bs4DNFuq6TCZwdYK9exHFxtitsDCsTw3K+T6/NcOWGMXt6zG
        TGzBRT+JmIMUE7FRet04exBz7RgSRgAhcZ7QAJD/4Y9poI4Al1hXDOhBNcLJzVlG4kWy/J
        Ox63bks4LU4Rh64JHfcJQH3LaW3H3Yc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639040666;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x0SJv2HsWDiDbMzafU+kDZ22w6PYjSfZS/lcRvvYuV8=;
        b=SqgBWyTUeo/YwoPswtM19oVHQC8zncRRemmBePCtHdFPevkjz/kc5eJ0WO93LjqK66W1Lr
        fQHoJ4r5JBGgiqAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A855F13A86;
        Thu,  9 Dec 2021 09:04:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XDA1J5rGsWGxaQAAMHmgww
        (envelope-from <nstange@suse.de>); Thu, 09 Dec 2021 09:04:26 +0000
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
Subject: [PATCH v2 08/18] crypto: testmgr - run only subset of DH vectors based on config
Date:   Thu,  9 Dec 2021 10:03:48 +0100
Message-Id: <20211209090358.28231-9-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211209090358.28231-1-nstange@suse.de>
References: <20211209090358.28231-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the previous patches, the testmgr now has up to four test vectors for
DH which all test more or less the same thing:
- the two vectors from before this series,
- the vector for the ffdhe3072 group, enabled if
  CONFIG_CRYPTO_DH_GROUPS_RFC7919 is set and
- the vector for the modp2048 group, similarly enabled if
  CONFIG_CRYPTO_DH_GROUPS_RFC3526 is set.

In order to avoid too much redundancy during DH testing, enable only a
subset of these depending on the kernel config:
- if CONFIG_CRYPTO_DH_GROUPS_RFC7919 is set, enable only the ffdhe3072
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
index 8658cf00ea1f..b10d5b9d49a1 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -1363,8 +1363,7 @@ static const struct kpp_testvec dh_tv_template[] = {
 	.expected_a_public_size = 384,
 	.expected_ss_size = 384,
 	},
-#endif /* IS_ENABLED(CONFIG_CRYPTO_DH_GROUPS_RFC7919) */
-#if IS_ENABLED(CONFIG_CRYPTO_DH_GROUPS_RFC3526)
+#elif IS_ENABLED(CONFIG_CRYPTO_DH_GROUPS_RFC3526)
 	{
 	.secret =
 #ifdef __LITTLE_ENDIAN
@@ -1455,7 +1454,7 @@ static const struct kpp_testvec dh_tv_template[] = {
 	.expected_a_public_size = 256,
 	.expected_ss_size = 256,
 	},
-#endif /* IS_ENABLED(CONFIG_CRYPTO_DH_GROUPS_RFC3526) */
+#else
 	{
 	.secret =
 #ifdef __LITTLE_ENDIAN
@@ -1674,6 +1673,7 @@ static const struct kpp_testvec dh_tv_template[] = {
 	.expected_a_public_size = 256,
 	.expected_ss_size = 256,
 	}
+#endif
 };
 
 static const struct kpp_testvec curve25519_tv_template[] = {
-- 
2.26.2

