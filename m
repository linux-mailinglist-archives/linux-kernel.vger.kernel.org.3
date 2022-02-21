Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07724BE321
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357551AbiBUMSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:18:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357609AbiBUMOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:14:48 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474FF22512;
        Mon, 21 Feb 2022 04:11:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 050601F38E;
        Mon, 21 Feb 2022 12:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645445487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WnOdrlh6LGfG36vDb1+pe1e6uf+fKBULrRSd0uCVIeg=;
        b=oGpIaNQNG8XWGxJWsFlSjZywqaoml0hUnh2Bo3EVUIddZE2zPNgUXPmzH/UcmYXdvlgu6y
        SlJSi4Bg2Tx1kMbywu+/DRdvPN/wyBQ6h9seM/z4RPB6txNftBI4wwXQxZeURzHUfVq0Mk
        IsOnaFUGrGNsU7HU0PIDUEPwz1YTyXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645445487;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WnOdrlh6LGfG36vDb1+pe1e6uf+fKBULrRSd0uCVIeg=;
        b=WjU46YUpRNXgiWMJnRtv82oHJCIBgLPlg0FjOaViz7assY1f3ueK/VhbBxaP4ZqvTgG72f
        F7Wrj7rWm3zFDiCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E555D13A94;
        Mon, 21 Feb 2022 12:11:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZEVpNm6BE2KUWwAAMHmgww
        (envelope-from <nstange@suse.de>); Mon, 21 Feb 2022 12:11:26 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: [PATCH v4 11/15] crypto: dh - allow for passing NULL to the ffdheXYZ(dh)s' ->set_secret()
Date:   Mon, 21 Feb 2022 13:10:57 +0100
Message-Id: <20220221121101.1615-12-nstange@suse.de>
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

Ephemeral key generation can be requested from any of the ffdheXYZ(dh)
variants' common ->set_secret() by passing it an (encoded) struct dh
with the key parameter being unset, i.e. with ->key_size == 0. As the
whole purpose of the ffdheXYZ(dh) templates is to fill in the group
parameters as appropriate, they expect ->p and ->g to be unset in any
input struct dh as well. This means that a user would have to encode an
all-zeroes struct dh instance via crypto_dh_encode_key() when requesting
ephemeral key generation from a ffdheXYZ(dh) instance, which is kind of
pointless.

Make dh_safe_prime_set_secret() to decode a struct dh from the supplied
buffer only if the latter is non-NULL and initialize it with all zeroes
otherwise.

That is, it is now possible to call

  crypto_kpp_set_secret(tfm, NULL, 0);

on any ffdheXYZ(dh) tfm for requesting ephemeral key generation.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 crypto/dh.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/crypto/dh.c b/crypto/dh.c
index 869a0476e5e2..d0d24f615b2d 100644
--- a/crypto/dh.c
+++ b/crypto/dh.c
@@ -444,17 +444,18 @@ static int dh_safe_prime_set_secret(struct crypto_kpp *tfm, const void *buffer,
 	struct dh_safe_prime_instance_ctx *inst_ctx =
 		dh_safe_prime_instance_ctx(tfm);
 	struct dh_safe_prime_tfm_ctx *tfm_ctx = kpp_tfm_ctx(tfm);
-	struct dh params;
+	struct dh params = {};
 	void *buf = NULL, *key = NULL;
 	unsigned int buf_size;
 	int err;
 
-	err = __crypto_dh_decode_key(buffer, len, &params);
-	if (err)
-		return err;
-
-	if (params.p_size || params.g_size)
-		return -EINVAL;
+	if (buffer) {
+		err = __crypto_dh_decode_key(buffer, len, &params);
+		if (err)
+			return err;
+		if (params.p_size || params.g_size)
+			return -EINVAL;
+	}
 
 	params.p = inst_ctx->safe_prime->p;
 	params.p_size = inst_ctx->safe_prime->p_size;
-- 
2.26.2

