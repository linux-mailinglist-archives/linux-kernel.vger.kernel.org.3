Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7A048ED4F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242871AbiANPnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242861AbiANPnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:43:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8224CC06173E;
        Fri, 14 Jan 2022 07:43:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A727B8295C;
        Fri, 14 Jan 2022 15:43:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE50C36AE5;
        Fri, 14 Jan 2022 15:43:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Bx1zCEbT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642174980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4QKGyaXYXpvy5zPBWVUqE679iwU8otdMKrrQ6kY3yeE=;
        b=Bx1zCEbTOglqnVNS696Y/Yjf6POB3FCwnrmdxhaYXEZuY30TPH82BPXGLyIsC3vHtX9aTR
        g8zsFk4iBspDkS4XoLPSlmuDPMblrWWGH4jWzuPNEd8maA2xbg1+ELH2+Gk5cvohJtTDfv
        qSpZfKLFnt/2trw15htwUm2s9Ggkqmk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9a0b01fd (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 14 Jan 2022 15:43:00 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, herbert@gondor.apana.org.au
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH crypto v3 2/2] lib/crypto: sha1: re-roll loops to reduce code size
Date:   Fri, 14 Jan 2022 16:42:47 +0100
Message-Id: <20220114154247.99773-3-Jason@zx2c4.com>
In-Reply-To: <20220114154247.99773-1-Jason@zx2c4.com>
References: <20220114154247.99773-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With SHA-1 no longer being used for anything performance oriented, and
also soon to be phased out entirely, we can make up for the space added
by unrolled BLAKE2s by simply re-rolling SHA-1. Since SHA-1 is so much
more complex, re-rolling it more or less takes care of the code size
added by BLAKE2s. And eventually, hopefully we'll see SHA-1 removed
entirely from most small kernel builds.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 lib/sha1.c | 95 ++++++++----------------------------------------------
 1 file changed, 14 insertions(+), 81 deletions(-)

diff --git a/lib/sha1.c b/lib/sha1.c
index 9bd1935a1472..0494766fc574 100644
--- a/lib/sha1.c
+++ b/lib/sha1.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 #include <crypto/sha1.h>
 #include <asm/unaligned.h>
 
@@ -55,7 +56,8 @@
 #define SHA_ROUND(t, input, fn, constant, A, B, C, D, E) do { \
 	__u32 TEMP = input(t); setW(t, TEMP); \
 	E += TEMP + rol32(A,5) + (fn) + (constant); \
-	B = ror32(B, 2); } while (0)
+	B = ror32(B, 2); \
+	TEMP = E; E = D; D = C; C = B; B = A; A = TEMP; } while (0)
 
 #define T_0_15(t, A, B, C, D, E)  SHA_ROUND(t, SHA_SRC, (((C^D)&B)^D) , 0x5a827999, A, B, C, D, E )
 #define T_16_19(t, A, B, C, D, E) SHA_ROUND(t, SHA_MIX, (((C^D)&B)^D) , 0x5a827999, A, B, C, D, E )
@@ -84,6 +86,7 @@
 void sha1_transform(__u32 *digest, const char *data, __u32 *array)
 {
 	__u32 A, B, C, D, E;
+	unsigned int i = 0;
 
 	A = digest[0];
 	B = digest[1];
@@ -92,94 +95,24 @@ void sha1_transform(__u32 *digest, const char *data, __u32 *array)
 	E = digest[4];
 
 	/* Round 1 - iterations 0-16 take their input from 'data' */
-	T_0_15( 0, A, B, C, D, E);
-	T_0_15( 1, E, A, B, C, D);
-	T_0_15( 2, D, E, A, B, C);
-	T_0_15( 3, C, D, E, A, B);
-	T_0_15( 4, B, C, D, E, A);
-	T_0_15( 5, A, B, C, D, E);
-	T_0_15( 6, E, A, B, C, D);
-	T_0_15( 7, D, E, A, B, C);
-	T_0_15( 8, C, D, E, A, B);
-	T_0_15( 9, B, C, D, E, A);
-	T_0_15(10, A, B, C, D, E);
-	T_0_15(11, E, A, B, C, D);
-	T_0_15(12, D, E, A, B, C);
-	T_0_15(13, C, D, E, A, B);
-	T_0_15(14, B, C, D, E, A);
-	T_0_15(15, A, B, C, D, E);
+	for (; i < 16; ++i)
+		T_0_15(i, A, B, C, D, E);
 
 	/* Round 1 - tail. Input from 512-bit mixing array */
-	T_16_19(16, E, A, B, C, D);
-	T_16_19(17, D, E, A, B, C);
-	T_16_19(18, C, D, E, A, B);
-	T_16_19(19, B, C, D, E, A);
+	for (; i < 20; ++i)
+		T_16_19(i, A, B, C, D, E);
 
 	/* Round 2 */
-	T_20_39(20, A, B, C, D, E);
-	T_20_39(21, E, A, B, C, D);
-	T_20_39(22, D, E, A, B, C);
-	T_20_39(23, C, D, E, A, B);
-	T_20_39(24, B, C, D, E, A);
-	T_20_39(25, A, B, C, D, E);
-	T_20_39(26, E, A, B, C, D);
-	T_20_39(27, D, E, A, B, C);
-	T_20_39(28, C, D, E, A, B);
-	T_20_39(29, B, C, D, E, A);
-	T_20_39(30, A, B, C, D, E);
-	T_20_39(31, E, A, B, C, D);
-	T_20_39(32, D, E, A, B, C);
-	T_20_39(33, C, D, E, A, B);
-	T_20_39(34, B, C, D, E, A);
-	T_20_39(35, A, B, C, D, E);
-	T_20_39(36, E, A, B, C, D);
-	T_20_39(37, D, E, A, B, C);
-	T_20_39(38, C, D, E, A, B);
-	T_20_39(39, B, C, D, E, A);
+	for (; i < 40; ++i)
+		T_20_39(i, A, B, C, D, E);
 
 	/* Round 3 */
-	T_40_59(40, A, B, C, D, E);
-	T_40_59(41, E, A, B, C, D);
-	T_40_59(42, D, E, A, B, C);
-	T_40_59(43, C, D, E, A, B);
-	T_40_59(44, B, C, D, E, A);
-	T_40_59(45, A, B, C, D, E);
-	T_40_59(46, E, A, B, C, D);
-	T_40_59(47, D, E, A, B, C);
-	T_40_59(48, C, D, E, A, B);
-	T_40_59(49, B, C, D, E, A);
-	T_40_59(50, A, B, C, D, E);
-	T_40_59(51, E, A, B, C, D);
-	T_40_59(52, D, E, A, B, C);
-	T_40_59(53, C, D, E, A, B);
-	T_40_59(54, B, C, D, E, A);
-	T_40_59(55, A, B, C, D, E);
-	T_40_59(56, E, A, B, C, D);
-	T_40_59(57, D, E, A, B, C);
-	T_40_59(58, C, D, E, A, B);
-	T_40_59(59, B, C, D, E, A);
+	for (; i < 60; ++i)
+		T_40_59(i, A, B, C, D, E);
 
 	/* Round 4 */
-	T_60_79(60, A, B, C, D, E);
-	T_60_79(61, E, A, B, C, D);
-	T_60_79(62, D, E, A, B, C);
-	T_60_79(63, C, D, E, A, B);
-	T_60_79(64, B, C, D, E, A);
-	T_60_79(65, A, B, C, D, E);
-	T_60_79(66, E, A, B, C, D);
-	T_60_79(67, D, E, A, B, C);
-	T_60_79(68, C, D, E, A, B);
-	T_60_79(69, B, C, D, E, A);
-	T_60_79(70, A, B, C, D, E);
-	T_60_79(71, E, A, B, C, D);
-	T_60_79(72, D, E, A, B, C);
-	T_60_79(73, C, D, E, A, B);
-	T_60_79(74, B, C, D, E, A);
-	T_60_79(75, A, B, C, D, E);
-	T_60_79(76, E, A, B, C, D);
-	T_60_79(77, D, E, A, B, C);
-	T_60_79(78, C, D, E, A, B);
-	T_60_79(79, B, C, D, E, A);
+	for (; i < 80; ++i)
+		T_60_79(i, A, B, C, D, E);
 
 	digest[0] += A;
 	digest[1] += B;
-- 
2.34.1

