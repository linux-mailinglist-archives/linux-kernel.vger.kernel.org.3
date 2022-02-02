Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79444A6EEA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343745AbiBBKm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:42:28 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41990 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244174AbiBBKls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:41:48 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E002D21135;
        Wed,  2 Feb 2022 10:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643798506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F2A3VejHfy1pwgtKHo9p3Kst3JXAr0emkFaSCeEGE/0=;
        b=JZDZpdbjFKh+YY3KxsmmD/ZBGuoQr4nBI5vhM80mBrOU8PQhY3T7KKzqVBbVDGnTKEJ8XK
        ZlB/Nl8+pQkNgveH0sSMiab2MPO/LHSWwxhYX4r4QDkY5SOSEGMbkqf6WvqAogOlzwYsq4
        oxPwcE7Em2lQeWHybzAnvGPjdyP3sXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643798506;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F2A3VejHfy1pwgtKHo9p3Kst3JXAr0emkFaSCeEGE/0=;
        b=bqfvYoU4KwaDU4wiQiHKZyRqpKWn458SLcfSzj8kCpSV+0FlumTnm91TkEshVYyx5F34BL
        mJAcWUMQ4TT+BVAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CBFF013E02;
        Wed,  2 Feb 2022 10:41:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id odWLMOpf+mGhbAAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 02 Feb 2022 10:41:46 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: [PATCH v3 15/15] crypto: dh - calculate Q from P for the full public key verification
Date:   Wed,  2 Feb 2022 11:40:12 +0100
Message-Id: <20220202104012.4193-16-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220202104012.4193-1-nstange@suse.de>
References: <20220202104012.4193-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the ->q in struct dh_ctx gets never set anywhere, the code in
dh_is_pubkey_valid() for doing the full public key validation in accordance
to SP800-56Arev3 is effectively dead.

However, for safe-prime groups Q = (P - 1)/2 by definition and
as the safe-prime groups are the only possible groups in FIPS mode (via
those ffdheXYZ() templates), this enables dh_is_pubkey_valid() to calculate
Q on the fly for these.
Implement this.

With this change, the last code accessing struct dh_ctx's ->q is now gone.
Remove this member from struct dh_ctx.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 crypto/dh.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/crypto/dh.c b/crypto/dh.c
index d0d24f615b2d..cca289477485 100644
--- a/crypto/dh.c
+++ b/crypto/dh.c
@@ -15,7 +15,6 @@
 
 struct dh_ctx {
 	MPI p;	/* Value is guaranteed to be set. */
-	MPI q;	/* Value is optional. */
 	MPI g;	/* Value is guaranteed to be set. */
 	MPI xa;	/* Value is guaranteed to be set. */
 };
@@ -23,7 +22,6 @@ struct dh_ctx {
 static void dh_clear_ctx(struct dh_ctx *ctx)
 {
 	mpi_free(ctx->p);
-	mpi_free(ctx->q);
 	mpi_free(ctx->g);
 	mpi_free(ctx->xa);
 	memset(ctx, 0, sizeof(*ctx));
@@ -99,11 +97,12 @@ static int dh_set_secret(struct crypto_kpp *tfm, const void *buf,
 /*
  * SP800-56A public key verification:
  *
- * * If Q is provided as part of the domain paramenters, a full validation
- *   according to SP800-56A section 5.6.2.3.1 is performed.
+ * * For the safe-prime groups in FIPS mode, Q can be computed
+ *   trivially from P and a full validation according to SP800-56A
+ *   section 5.6.2.3.1 is performed.
  *
- * * If Q is not provided, a partial validation according to SP800-56A section
- *   5.6.2.3.2 is performed.
+ * * For all other sets of group parameters, only a partial validation
+ *   according to SP800-56A section 5.6.2.3.2 is performed.
  */
 static int dh_is_pubkey_valid(struct dh_ctx *ctx, MPI y)
 {
@@ -114,21 +113,40 @@ static int dh_is_pubkey_valid(struct dh_ctx *ctx, MPI y)
 	 * Step 1: Verify that 2 <= y <= p - 2.
 	 *
 	 * The upper limit check is actually y < p instead of y < p - 1
-	 * as the mpi_sub_ui function is yet missing.
+	 * in order to save one mpi_sub_ui() invocation here. Note that
+	 * p - 1 is the non-trivial element of the subgroup of order 2 and
+	 * thus, the check on y^q below would fail if y == p - 1.
 	 */
 	if (mpi_cmp_ui(y, 1) < 1 || mpi_cmp(y, ctx->p) >= 0)
 		return -EINVAL;
 
-	/* Step 2: Verify that 1 = y^q mod p */
-	if (ctx->q) {
-		MPI val = mpi_alloc(0);
+	/*
+	 * Step 2: Verify that 1 = y^q mod p
+	 *
+	 * For the safe-prime groups q = (p - 1)/2.
+	 */
+	if (fips_enabled) {
+		MPI val, q;
 		int ret;
 
+		val = mpi_alloc(0);
 		if (!val)
 			return -ENOMEM;
 
-		ret = mpi_powm(val, y, ctx->q, ctx->p);
+		q = mpi_alloc(mpi_get_nlimbs(ctx->p));
+		if (!q) {
+			mpi_free(val);
+			return -ENOMEM;
+		}
 
+		/*
+		 * ->p is odd, so no need to explicitly subtract one
+		 * from it before shifting to the right.
+		 */
+		mpi_rshift(q, ctx->p, 1);
+
+		ret = mpi_powm(val, y, q, ctx->p);
+		mpi_free(q);
 		if (ret) {
 			mpi_free(val);
 			return ret;
-- 
2.26.2

