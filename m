Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F7955C5AF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbiF0JUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbiF0JUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:20:33 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD7163C1;
        Mon, 27 Jun 2022 02:20:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VHX6ig3_1656321628;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VHX6ig3_1656321628)
          by smtp.aliyun-inc.com;
          Mon, 27 Jun 2022 17:20:28 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Eric Biggers <ebiggers@google.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH v2 RESEND] KEYS: asymmetric: enforce SM2 signature use pkey algo
Date:   Mon, 27 Jun 2022 17:20:27 +0800
Message-Id: <20220627092027.20858-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The signature verification of SM2 needs to add the Za value and
recalculate sig->digest, which requires the detection of the pkey_algo
in public_key_verify_signature(). As Eric Biggers said, the pkey_algo
field in sig is attacker-controlled and should be use pkey->pkey_algo
instead of sig->pkey_algo, and secondly, if sig->pkey_algo is NULL, it
will also cause signature verification failure.

The software_key_determine_akcipher() already forces the algorithms
are matched, so the SM3 algorithm is enforced in the SM2 signature,
although this has been checked, we still avoid using any algorithm
information in the signature as input.

Fixes: 215525639631 ("X.509: support OSCCA SM2-with-SM3 certificate verification")
Reported-by: Eric Biggers <ebiggers@google.com>
Cc: stable@vger.kernel.org # v5.10+
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 crypto/asymmetric_keys/public_key.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index 7c9e6be35c30..3f17ee860f89 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -309,7 +309,8 @@ static int cert_sig_digest_update(const struct public_key_signature *sig,
 	if (ret)
 		return ret;
 
-	tfm = crypto_alloc_shash(sig->hash_algo, 0, 0);
+	/* SM2 signatures always use the SM3 hash algorithm */
+	tfm = crypto_alloc_shash("sm3", 0, 0);
 	if (IS_ERR(tfm))
 		return PTR_ERR(tfm);
 
@@ -414,8 +415,7 @@ int public_key_verify_signature(const struct public_key *pkey,
 	if (ret)
 		goto error_free_key;
 
-	if (sig->pkey_algo && strcmp(sig->pkey_algo, "sm2") == 0 &&
-	    sig->data_size) {
+	if (strcmp(pkey->pkey_algo, "sm2") == 0 && sig->data_size) {
 		ret = cert_sig_digest_update(sig, tfm);
 		if (ret)
 			goto error_free_key;
-- 
2.24.3 (Apple Git-128)

