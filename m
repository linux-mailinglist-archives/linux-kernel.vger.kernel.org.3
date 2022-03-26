Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB504E7FBA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 08:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbiCZHPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 03:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiCZHPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 03:15:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4A7193F7;
        Sat, 26 Mar 2022 00:13:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93F91B80E78;
        Sat, 26 Mar 2022 07:13:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303F4C340ED;
        Sat, 26 Mar 2022 07:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648278813;
        bh=SbCQiLcdpwK95EMOKB+awhm02w2+pKKQBhuDoxlYSak=;
        h=From:To:Cc:Subject:Date:From;
        b=CgH7x0hb0EquZmt+J6V02nwP9Zff35QzQN2Of+aUA1U3b2QcokVApMfEUw03XjHKz
         tVO8uQVnBw35cdO1LDed/vvQC7m1OOlOvSIkr6YApbQRtMF2O8mAijGRGkJ6i57bV7
         VUuJfaSl8H5k1QH8MAs9jZrnjZFqCOmsH/5q4eEhEdf8KcfzpHnxyOfxFobJndnY5q
         hxn1+uBWNSkrtuFoyV31jAFGeRnPjbeQfceXRWkAWNZbXy/zoOuDMVt6AXzb1eomek
         pHaPkFZyiFq3rHPZUOsQX/hIzqkph9z1t78loEEefHYVTAV+qsbmfPsuQ9Opxmiqe7
         hvJ2BDfFQYmpQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Gilad Ben-Yossef <gilad@benyossef.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: testmgr - test in-place en/decryption with two sglists
Date:   Sat, 26 Mar 2022 00:11:59 -0700
Message-Id: <20220326071159.56056-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

As was established in the thread
https://lore.kernel.org/linux-crypto/20220223080400.139367-1-gilad@benyossef.com/T/#u,
many crypto API users doing in-place en/decryption don't use the same
scatterlist pointers for the source and destination, but rather use
separate scatterlists that point to the same memory.  This case isn't
tested by the self-tests, resulting in bugs.

This is the natural usage of the crypto API in some cases, so requiring
API users to avoid this usage is not reasonable.

Therefore, update the self-tests to start testing this case.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/testmgr.c | 75 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 63 insertions(+), 12 deletions(-)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 2d632a285869f..24a1f9365b9bb 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -232,6 +232,20 @@ enum finalization_type {
 	FINALIZATION_TYPE_DIGEST,	/* use digest() */
 };
 
+/*
+ * Whether the crypto operation will occur in-place, and if so whether the
+ * source and destination scatterlist pointers will coincide (req->src ==
+ * req->dst), or whether they'll merely point to two separate scatterlists
+ * (req->src != req->dst) that reference the same underlying memory.
+ *
+ * This is only relevant for algorithm types that support in-place operation.
+ */
+enum inplace_mode {
+	OUT_OF_PLACE,
+	INPLACE_ONE_SGLIST,
+	INPLACE_TWO_SGLISTS,
+};
+
 #define TEST_SG_TOTAL	10000
 
 /**
@@ -265,7 +279,7 @@ struct test_sg_division {
  * crypto test vector can be tested.
  *
  * @name: name of this config, logged for debugging purposes if a test fails
- * @inplace: operate on the data in-place, if applicable for the algorithm type?
+ * @inplace_mode: whether and how to operate on the data in-place, if applicable
  * @req_flags: extra request_flags, e.g. CRYPTO_TFM_REQ_MAY_SLEEP
  * @src_divs: description of how to arrange the source scatterlist
  * @dst_divs: description of how to arrange the dst scatterlist, if applicable
@@ -282,7 +296,7 @@ struct test_sg_division {
  */
 struct testvec_config {
 	const char *name;
-	bool inplace;
+	enum inplace_mode inplace_mode;
 	u32 req_flags;
 	struct test_sg_division src_divs[XBUFSIZE];
 	struct test_sg_division dst_divs[XBUFSIZE];
@@ -307,11 +321,16 @@ struct testvec_config {
 /* Configs for skciphers and aeads */
 static const struct testvec_config default_cipher_testvec_configs[] = {
 	{
-		.name = "in-place",
-		.inplace = true,
+		.name = "in-place (one sglist)",
+		.inplace_mode = INPLACE_ONE_SGLIST,
+		.src_divs = { { .proportion_of_total = 10000 } },
+	}, {
+		.name = "in-place (two sglists)",
+		.inplace_mode = INPLACE_TWO_SGLISTS,
 		.src_divs = { { .proportion_of_total = 10000 } },
 	}, {
 		.name = "out-of-place",
+		.inplace_mode = OUT_OF_PLACE,
 		.src_divs = { { .proportion_of_total = 10000 } },
 	}, {
 		.name = "unaligned buffer, offset=1",
@@ -349,7 +368,7 @@ static const struct testvec_config default_cipher_testvec_configs[] = {
 		.key_offset = 3,
 	}, {
 		.name = "misaligned splits crossing pages, inplace",
-		.inplace = true,
+		.inplace_mode = INPLACE_ONE_SGLIST,
 		.src_divs = {
 			{
 				.proportion_of_total = 7500,
@@ -749,18 +768,39 @@ static int build_cipher_test_sglists(struct cipher_test_sglists *tsgls,
 
 	iov_iter_kvec(&input, WRITE, inputs, nr_inputs, src_total_len);
 	err = build_test_sglist(&tsgls->src, cfg->src_divs, alignmask,
-				cfg->inplace ?
+				cfg->inplace_mode != OUT_OF_PLACE ?
 					max(dst_total_len, src_total_len) :
 					src_total_len,
 				&input, NULL);
 	if (err)
 		return err;
 
-	if (cfg->inplace) {
+	/*
+	 * In-place crypto operations can use the same scatterlist for both the
+	 * source and destination (req->src == req->dst), or can use separate
+	 * scatterlists (req->src != req->dst) which point to the same
+	 * underlying memory.  Make sure to test both cases.
+	 */
+	if (cfg->inplace_mode == INPLACE_ONE_SGLIST) {
 		tsgls->dst.sgl_ptr = tsgls->src.sgl;
 		tsgls->dst.nents = tsgls->src.nents;
 		return 0;
 	}
+	if (cfg->inplace_mode == INPLACE_TWO_SGLISTS) {
+		/*
+		 * For now we keep it simple and only test the case where the
+		 * two scatterlists have identical entries, rather than
+		 * different entries that split up the same memory differently.
+		 */
+		memcpy(tsgls->dst.sgl, tsgls->src.sgl,
+		       tsgls->src.nents * sizeof(tsgls->src.sgl[0]));
+		memcpy(tsgls->dst.sgl_saved, tsgls->src.sgl,
+		       tsgls->src.nents * sizeof(tsgls->src.sgl[0]));
+		tsgls->dst.sgl_ptr = tsgls->dst.sgl;
+		tsgls->dst.nents = tsgls->src.nents;
+		return 0;
+	}
+	/* Out of place */
 	return build_test_sglist(&tsgls->dst,
 				 cfg->dst_divs[0].proportion_of_total ?
 					cfg->dst_divs : cfg->src_divs,
@@ -995,9 +1035,19 @@ static void generate_random_testvec_config(struct testvec_config *cfg,
 
 	p += scnprintf(p, end - p, "random:");
 
-	if (prandom_u32() % 2 == 0) {
-		cfg->inplace = true;
-		p += scnprintf(p, end - p, " inplace");
+	switch (prandom_u32() % 4) {
+	case 0:
+	case 1:
+		cfg->inplace_mode = OUT_OF_PLACE;
+		break;
+	case 2:
+		cfg->inplace_mode = INPLACE_ONE_SGLIST;
+		p += scnprintf(p, end - p, " inplace_one_sglist");
+		break;
+	default:
+		cfg->inplace_mode = INPLACE_TWO_SGLISTS;
+		p += scnprintf(p, end - p, " inplace_two_sglists");
+		break;
 	}
 
 	if (prandom_u32() % 2 == 0) {
@@ -1034,7 +1084,7 @@ static void generate_random_testvec_config(struct testvec_config *cfg,
 					  cfg->req_flags);
 	p += scnprintf(p, end - p, "]");
 
-	if (!cfg->inplace && prandom_u32() % 2 == 0) {
+	if (cfg->inplace_mode == OUT_OF_PLACE && prandom_u32() % 2 == 0) {
 		p += scnprintf(p, end - p, " dst_divs=[");
 		p = generate_random_sgl_divisions(cfg->dst_divs,
 						  ARRAY_SIZE(cfg->dst_divs),
@@ -2085,7 +2135,8 @@ static int test_aead_vec_cfg(int enc, const struct aead_testvec *vec,
 	/* Check for the correct output (ciphertext or plaintext) */
 	err = verify_correct_output(&tsgls->dst, enc ? vec->ctext : vec->ptext,
 				    enc ? vec->clen : vec->plen,
-				    vec->alen, enc || !cfg->inplace);
+				    vec->alen,
+				    enc || cfg->inplace_mode == OUT_OF_PLACE);
 	if (err == -EOVERFLOW) {
 		pr_err("alg: aead: %s %s overran dst buffer on test vector %s, cfg=\"%s\"\n",
 		       driver, op, vec_name, cfg->name);

base-commit: 46f538bf2404ee9c32648deafb886f49144bfd5e
-- 
2.35.1

