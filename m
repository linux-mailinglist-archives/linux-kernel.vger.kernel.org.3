Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A38B47A5F6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 09:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238042AbhLTIXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 03:23:16 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:40483 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237925AbhLTIXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:23:06 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0V.Aovn1_1639988581;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0V.Aovn1_1639988581)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 20 Dec 2021 16:23:02 +0800
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
Subject: [PATCH 6/6] crypto: tcrypt - add asynchronous speed test for SM3
Date:   Mon, 20 Dec 2021 16:22:51 +0800
Message-Id: <20211220082251.1445-7-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211220082251.1445-1-tianjia.zhang@linux.alibaba.com>
References: <20211220082251.1445-1-tianjia.zhang@linux.alibaba.com>
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
2.32.0

