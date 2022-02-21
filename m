Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861494BE149
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357436AbiBUMOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:14:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357543AbiBUMOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:14:07 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD46320F55;
        Mon, 21 Feb 2022 04:11:18 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1130621129;
        Mon, 21 Feb 2022 12:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645445477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ecOYEB5a9clT6wXEVss+TIn463GHBUQE0HkKcT3yr7o=;
        b=VTlfxzk/7W72LUrYr87VbYu545ItwwS6/FOM1iO0B+A4jqKwJnstHEgKZT/y2OnurBtd6S
        KCx0dA5LP8vmtrNMoOpTn9AmvDpMHYYzWP/2hLYDG28zpbNr9mHNP/fxgqk9mLpP74c15q
        K63SLUSq+7khYo72m42SpNWIoPUUq28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645445477;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ecOYEB5a9clT6wXEVss+TIn463GHBUQE0HkKcT3yr7o=;
        b=5GXGlwurVAlh4MQE6RHiQMztopB8YwWNyjv5MSg8TRZp5t/YpLkdQnh2aIPt+EA5JswpS+
        n2LZQrktNOJpyNCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F143B13A9C;
        Mon, 21 Feb 2022 12:11:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id i+xPOWSBE2JuWwAAMHmgww
        (envelope-from <nstange@suse.de>); Mon, 21 Feb 2022 12:11:16 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: [PATCH v4 03/15] crypto: dh - remove struct dh's ->q member
Date:   Mon, 21 Feb 2022 13:10:49 +0100
Message-Id: <20220221121101.1615-4-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220221121101.1615-1-nstange@suse.de>
References: <20220221121101.1615-1-nstange@suse.de>
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

The only current user of the DH KPP algorithm, the
keyctl(KEYCTL_DH_COMPUTE) syscall, doesn't set the domain parameter ->q
in struct dh. Remove it and any associated (de)serialization code in
crypto_dh_encode_key() and crypto_dh_decode_key. Adjust the encoded
->secret values in testmgr's DH test vectors accordingly.

Note that the dh-generic implementation would have initialized its
struct dh_ctx's ->q from the decoded struct dh's ->q, if present. If this
struct dh_ctx's ->q would ever have been non-NULL, it would have enabled a
full key validation as specified in NIST SP800-56A in dh_is_pubkey_valid().
However, as outlined above, ->q is always NULL in practice and the full key
validation code is effectively dead. A later patch will make
dh_is_pubkey_valid() to calculate Q from P on the fly, if possible, so
don't remove struct dh_ctx's ->q now, but leave it there until that has
happened.

Signed-off-by: Nicolai Stange <nstange@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 crypto/dh.c         |  6 ------
 crypto/dh_helper.c  | 17 ++++-------------
 crypto/testmgr.h    | 16 ++++++----------
 include/crypto/dh.h |  4 ----
 4 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/crypto/dh.c b/crypto/dh.c
index 27e62a2a8027..abc2a72c8271 100644
--- a/crypto/dh.c
+++ b/crypto/dh.c
@@ -62,12 +62,6 @@ static int dh_set_params(struct dh_ctx *ctx, struct dh *params)
 	if (!ctx->p)
 		return -EINVAL;
 
-	if (params->q && params->q_size) {
-		ctx->q = mpi_read_raw_data(params->q, params->q_size);
-		if (!ctx->q)
-			return -EINVAL;
-	}
-
 	ctx->g = mpi_read_raw_data(params->g, params->g_size);
 	if (!ctx->g)
 		return -EINVAL;
diff --git a/crypto/dh_helper.c b/crypto/dh_helper.c
index 9fd5a42eea15..aabc91e4f63f 100644
--- a/crypto/dh_helper.c
+++ b/crypto/dh_helper.c
@@ -10,7 +10,7 @@
 #include <crypto/dh.h>
 #include <crypto/kpp.h>
 
-#define DH_KPP_SECRET_MIN_SIZE (sizeof(struct kpp_secret) + 4 * sizeof(int))
+#define DH_KPP_SECRET_MIN_SIZE (sizeof(struct kpp_secret) + 3 * sizeof(int))
 
 static inline u8 *dh_pack_data(u8 *dst, u8 *end, const void *src, size_t size)
 {
@@ -28,7 +28,7 @@ static inline const u8 *dh_unpack_data(void *dst, const void *src, size_t size)
 
 static inline unsigned int dh_data_size(const struct dh *p)
 {
-	return p->key_size + p->p_size + p->q_size + p->g_size;
+	return p->key_size + p->p_size + p->g_size;
 }
 
 unsigned int crypto_dh_key_len(const struct dh *p)
@@ -53,11 +53,9 @@ int crypto_dh_encode_key(char *buf, unsigned int len, const struct dh *params)
 	ptr = dh_pack_data(ptr, end, &params->key_size,
 			   sizeof(params->key_size));
 	ptr = dh_pack_data(ptr, end, &params->p_size, sizeof(params->p_size));
-	ptr = dh_pack_data(ptr, end, &params->q_size, sizeof(params->q_size));
 	ptr = dh_pack_data(ptr, end, &params->g_size, sizeof(params->g_size));
 	ptr = dh_pack_data(ptr, end, params->key, params->key_size);
 	ptr = dh_pack_data(ptr, end, params->p, params->p_size);
-	ptr = dh_pack_data(ptr, end, params->q, params->q_size);
 	ptr = dh_pack_data(ptr, end, params->g, params->g_size);
 	if (ptr != end)
 		return -EINVAL;
@@ -79,7 +77,6 @@ int crypto_dh_decode_key(const char *buf, unsigned int len, struct dh *params)
 
 	ptr = dh_unpack_data(&params->key_size, ptr, sizeof(params->key_size));
 	ptr = dh_unpack_data(&params->p_size, ptr, sizeof(params->p_size));
-	ptr = dh_unpack_data(&params->q_size, ptr, sizeof(params->q_size));
 	ptr = dh_unpack_data(&params->g_size, ptr, sizeof(params->g_size));
 	if (secret.len != crypto_dh_key_len(params))
 		return -EINVAL;
@@ -89,7 +86,7 @@ int crypto_dh_decode_key(const char *buf, unsigned int len, struct dh *params)
 	 * some drivers assume otherwise.
 	 */
 	if (params->key_size > params->p_size ||
-	    params->g_size > params->p_size || params->q_size > params->p_size)
+	    params->g_size > params->p_size)
 		return -EINVAL;
 
 	/* Don't allocate memory. Set pointers to data within
@@ -97,9 +94,7 @@ int crypto_dh_decode_key(const char *buf, unsigned int len, struct dh *params)
 	 */
 	params->key = (void *)ptr;
 	params->p = (void *)(ptr + params->key_size);
-	params->q = (void *)(ptr + params->key_size + params->p_size);
-	params->g = (void *)(ptr + params->key_size + params->p_size +
-			     params->q_size);
+	params->g = (void *)(ptr + params->key_size + params->p_size);
 
 	/*
 	 * Don't permit 'p' to be 0.  It's not a prime number, and it's subject
@@ -109,10 +104,6 @@ int crypto_dh_decode_key(const char *buf, unsigned int len, struct dh *params)
 	if (memchr_inv(params->p, 0, params->p_size) == NULL)
 		return -EINVAL;
 
-	/* It is permissible to not provide Q. */
-	if (params->q_size == 0)
-		params->q = NULL;
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(crypto_dh_decode_key);
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 85ccf811f5e7..31da6fd3cfe7 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -1246,17 +1246,15 @@ static const struct kpp_testvec dh_tv_template[] = {
 	.secret =
 #ifdef __LITTLE_ENDIAN
 	"\x01\x00" /* type */
-	"\x15\x02" /* len */
+	"\x11\x02" /* len */
 	"\x00\x01\x00\x00" /* key_size */
 	"\x00\x01\x00\x00" /* p_size */
-	"\x00\x00\x00\x00" /* q_size */
 	"\x01\x00\x00\x00" /* g_size */
 #else
 	"\x00\x01" /* type */
-	"\x02\x15" /* len */
+	"\x02\x11" /* len */
 	"\x00\x00\x01\x00" /* key_size */
 	"\x00\x00\x01\x00" /* p_size */
-	"\x00\x00\x00\x00" /* q_size */
 	"\x00\x00\x00\x01" /* g_size */
 #endif
 	/* xa */
@@ -1346,7 +1344,7 @@ static const struct kpp_testvec dh_tv_template[] = {
 	"\xd3\x34\x49\xad\x64\xa6\xb1\xc0\x59\x28\x75\x60\xa7\x8a\xb0\x11"
 	"\x56\x89\x42\x74\x11\xf5\xf6\x5e\x6f\x16\x54\x6a\xb1\x76\x4d\x50"
 	"\x8a\x68\xc1\x5b\x82\xb9\x0d\x00\x32\x50\xed\x88\x87\x48\x92\x17",
-	.secret_size = 533,
+	.secret_size = 529,
 	.b_public_size = 256,
 	.expected_a_public_size = 256,
 	.expected_ss_size = 256,
@@ -1355,17 +1353,15 @@ static const struct kpp_testvec dh_tv_template[] = {
 	.secret =
 #ifdef __LITTLE_ENDIAN
 	"\x01\x00" /* type */
-	"\x15\x02" /* len */
+	"\x11\x02" /* len */
 	"\x00\x01\x00\x00" /* key_size */
 	"\x00\x01\x00\x00" /* p_size */
-	"\x00\x00\x00\x00" /* q_size */
 	"\x01\x00\x00\x00" /* g_size */
 #else
 	"\x00\x01" /* type */
-	"\x02\x15" /* len */
+	"\x02\x11" /* len */
 	"\x00\x00\x01\x00" /* key_size */
 	"\x00\x00\x01\x00" /* p_size */
-	"\x00\x00\x00\x00" /* q_size */
 	"\x00\x00\x00\x01" /* g_size */
 #endif
 	/* xa */
@@ -1455,7 +1451,7 @@ static const struct kpp_testvec dh_tv_template[] = {
 	"\x5e\x5a\x64\xbd\xf6\x85\x04\xe8\x28\x6a\xac\xef\xce\x19\x8e\x9a"
 	"\xfe\x75\xc0\x27\x69\xe3\xb3\x7b\x21\xa7\xb1\x16\xa4\x85\x23\xee"
 	"\xb0\x1b\x04\x6e\xbd\xab\x16\xde\xfd\x86\x6b\xa9\x95\xd7\x0b\xfd",
-	.secret_size = 533,
+	.secret_size = 529,
 	.b_public_size = 256,
 	.expected_a_public_size = 256,
 	.expected_ss_size = 256,
diff --git a/include/crypto/dh.h b/include/crypto/dh.h
index d71e9858ab86..2585f0e6bb69 100644
--- a/include/crypto/dh.h
+++ b/include/crypto/dh.h
@@ -24,21 +24,17 @@
  *
  * @key:	Private DH key
  * @p:		Diffie-Hellman parameter P
- * @q:		Diffie-Hellman parameter Q
  * @g:		Diffie-Hellman generator G
  * @key_size:	Size of the private DH key
  * @p_size:	Size of DH parameter P
- * @q_size:	Size of DH parameter Q
  * @g_size:	Size of DH generator G
  */
 struct dh {
 	void *key;
 	void *p;
-	void *q;
 	void *g;
 	unsigned int key_size;
 	unsigned int p_size;
-	unsigned int q_size;
 	unsigned int g_size;
 };
 
-- 
2.26.2

