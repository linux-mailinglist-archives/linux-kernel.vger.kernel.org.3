Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BD54BE595
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357760AbiBUMPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:15:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357618AbiBUMOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:14:12 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA29C21E34;
        Mon, 21 Feb 2022 04:11:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8760C2113B;
        Mon, 21 Feb 2022 12:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645445479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RbWEdeLEnpwK+SZUqqlXr7ZVFlur6T5ifGlGBjkwCrc=;
        b=Z1Om9vgvR6r0tcLJIoivMN0aEkEDLt7UhDUUTD91y1A7M0roRW7XjUtopJEhldMtr0/m7D
        zRUCQon2Lb6UN8LWNeyvyvNZZU6jpkOox0DUgEZ6bTyKofvhAw7/v0YoxDfdWIRARMkGcH
        d9GA+UCw8GAEm2st21XBGa6IovpgmQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645445479;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RbWEdeLEnpwK+SZUqqlXr7ZVFlur6T5ifGlGBjkwCrc=;
        b=O+u+xqievn4ayza3E1dH3NH+nM7M90IFjfVgByjGv6zPXyEbiqPyKf0dJ55v99shK/lxw/
        OJEEFYvOHrp+Y0Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70CD513A9C;
        Mon, 21 Feb 2022 12:11:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sUz1GWeBE2J6WwAAMHmgww
        (envelope-from <nstange@suse.de>); Mon, 21 Feb 2022 12:11:19 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: [PATCH v4 05/15] crypto: dh - split out deserialization code from crypto_dh_decode()
Date:   Mon, 21 Feb 2022 13:10:51 +0100
Message-Id: <20220221121101.1615-6-nstange@suse.de>
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

A subsequent commit will introduce "dh" wrapping templates of the form
"ffdhe2048(dh)", "ffdhe3072(dh)" and so on in order to provide built-in
support for the well-known safe-prime ffdhe group parameters specified in
RFC 7919.

Those templates' ->set_secret() will wrap the inner "dh" implementation's
->set_secret() and set the ->p and ->g group parameters as appropriate on
the way inwards. More specifically,
- A ffdheXYZ(dh) user would call crypto_dh_encode() on a struct dh instance
  having ->p == ->g == NULL as well as ->p_size == ->g_size == 0 and pass
  the resulting buffer to the outer ->set_secret().
- This outer ->set_secret() would then decode the struct dh via
  crypto_dh_decode_key(), set ->p, ->g, ->p_size as well as ->g_size as
  appropriate for the group in question and encode the struct dh again
  before passing it further down to the inner "dh"'s ->set_secret().

The problem is that crypto_dh_decode_key() implements some basic checks
which would reject parameter sets with ->p_size == 0 and thus, the ffdheXYZ
templates' ->set_secret() cannot use it as-is for decoding the passed
buffer. As the inner "dh"'s ->set_secret() will eventually conduct said
checks on the final parameter set anyway, the outer ->set_secret() really
only needs the decoding functionality.

Split out the pure struct dh decoding part from crypto_dh_decode_key() into
the new __crypto_dh_decode_key().

__crypto_dh_decode_key() gets defined in crypto/dh_helper.c, but will have
to get called from crypto/dh.c and thus, its declaration must be somehow
made available to the latter. Strictly speaking, __crypto_dh_decode_key()
is internal to the dh_generic module, yet it would be a bit over the top
to introduce a new header like e.g. include/crypto/internal/dh.h
containing just a single prototype. Add the __crypto_dh_decode_key()
declaration to include/crypto/dh.h instead.

Provide a proper kernel-doc annotation, even though
__crypto_dh_decode_key() is purposedly not on the function list specified
in Documentation/crypto/api-kpp.rst.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 crypto/dh_helper.c  | 27 +++++++++++++++++++--------
 include/crypto/dh.h | 16 ++++++++++++++++
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/crypto/dh_helper.c b/crypto/dh_helper.c
index aabc91e4f63f..2d499879328b 100644
--- a/crypto/dh_helper.c
+++ b/crypto/dh_helper.c
@@ -63,7 +63,7 @@ int crypto_dh_encode_key(char *buf, unsigned int len, const struct dh *params)
 }
 EXPORT_SYMBOL_GPL(crypto_dh_encode_key);
 
-int crypto_dh_decode_key(const char *buf, unsigned int len, struct dh *params)
+int __crypto_dh_decode_key(const char *buf, unsigned int len, struct dh *params)
 {
 	const u8 *ptr = buf;
 	struct kpp_secret secret;
@@ -81,6 +81,24 @@ int crypto_dh_decode_key(const char *buf, unsigned int len, struct dh *params)
 	if (secret.len != crypto_dh_key_len(params))
 		return -EINVAL;
 
+	/* Don't allocate memory. Set pointers to data within
+	 * the given buffer
+	 */
+	params->key = (void *)ptr;
+	params->p = (void *)(ptr + params->key_size);
+	params->g = (void *)(ptr + params->key_size + params->p_size);
+
+	return 0;
+}
+
+int crypto_dh_decode_key(const char *buf, unsigned int len, struct dh *params)
+{
+	int err;
+
+	err = __crypto_dh_decode_key(buf, len, params);
+	if (err)
+		return err;
+
 	/*
 	 * Don't permit the buffer for 'key' or 'g' to be larger than 'p', since
 	 * some drivers assume otherwise.
@@ -89,13 +107,6 @@ int crypto_dh_decode_key(const char *buf, unsigned int len, struct dh *params)
 	    params->g_size > params->p_size)
 		return -EINVAL;
 
-	/* Don't allocate memory. Set pointers to data within
-	 * the given buffer
-	 */
-	params->key = (void *)ptr;
-	params->p = (void *)(ptr + params->key_size);
-	params->g = (void *)(ptr + params->key_size + params->p_size);
-
 	/*
 	 * Don't permit 'p' to be 0.  It's not a prime number, and it's subject
 	 * to corner cases such as 'mod 0' being undefined or
diff --git a/include/crypto/dh.h b/include/crypto/dh.h
index 67f3f6bca527..7b863e911cb4 100644
--- a/include/crypto/dh.h
+++ b/include/crypto/dh.h
@@ -79,4 +79,20 @@ int crypto_dh_encode_key(char *buf, unsigned int len, const struct dh *params);
  */
 int crypto_dh_decode_key(const char *buf, unsigned int len, struct dh *params);
 
+/**
+ * __crypto_dh_decode_key() - decode a private key without parameter checks
+ * @buf:	Buffer holding a packet key that should be decoded
+ * @len:	Length of the packet private key buffer
+ * @params:	Buffer allocated by the caller that is filled with the
+ *		unpacked DH private key.
+ *
+ * Internal function providing the same services as the exported
+ * crypto_dh_decode_key(), but without any of those basic parameter
+ * checks conducted by the latter.
+ *
+ * Return:	-EINVAL if buffer has insufficient size, 0 on success
+ */
+int __crypto_dh_decode_key(const char *buf, unsigned int len,
+			   struct dh *params);
+
 #endif
-- 
2.26.2

