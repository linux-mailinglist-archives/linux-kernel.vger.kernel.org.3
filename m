Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90A4487767
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 13:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346859AbiAGMH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 07:07:26 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:59636 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346933AbiAGMHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 07:07:15 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0V1B18v4_1641557230;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0V1B18v4_1641557230)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 Jan 2022 20:07:11 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Vitaly Chikunov <vt@altlinux.org>,
        Eric Biggers <ebiggers@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-crypto@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH v4 6/6] crypto: tcrypt - add asynchronous speed test for SM3
Date:   Fri,  7 Jan 2022 20:07:00 +0800
Message-Id: <20220107120700.730-7-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107120700.730-1-tianjia.zhang@linux.alibaba.com>
References: <20220107120700.730-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tcrypt supports testing of SM3 hash algorithms that use AVX
instruction acceleration.

In order to add the sm3 asynchronous test to the appropriate
position, shift the testcase sequence number of the multi buffer
backward and start from 450.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 crypto/tcrypt.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
index 00149657a4bc..82b5eef2246a 100644
--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -2571,31 +2571,35 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
 		if (mode > 400 && mode < 500) break;
 		fallthrough;
 	case 422:
+		test_ahash_speed("sm3", sec, generic_hash_speed_template);
+		if (mode > 400 && mode < 500) break;
+		fallthrough;
+	case 450:
 		test_mb_ahash_speed("sha1", sec, generic_hash_speed_template,
 				    num_mb);
 		if (mode > 400 && mode < 500) break;
 		fallthrough;
-	case 423:
+	case 451:
 		test_mb_ahash_speed("sha256", sec, generic_hash_speed_template,
 				    num_mb);
 		if (mode > 400 && mode < 500) break;
 		fallthrough;
-	case 424:
+	case 452:
 		test_mb_ahash_speed("sha512", sec, generic_hash_speed_template,
 				    num_mb);
 		if (mode > 400 && mode < 500) break;
 		fallthrough;
-	case 425:
+	case 453:
 		test_mb_ahash_speed("sm3", sec, generic_hash_speed_template,
 				    num_mb);
 		if (mode > 400 && mode < 500) break;
 		fallthrough;
-	case 426:
+	case 454:
 		test_mb_ahash_speed("streebog256", sec,
 				    generic_hash_speed_template, num_mb);
 		if (mode > 400 && mode < 500) break;
 		fallthrough;
-	case 427:
+	case 455:
 		test_mb_ahash_speed("streebog512", sec,
 				    generic_hash_speed_template, num_mb);
 		if (mode > 400 && mode < 500) break;
-- 
2.34.1

