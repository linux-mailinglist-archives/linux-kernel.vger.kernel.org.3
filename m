Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C57A472874
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238313AbhLMKNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241580AbhLMKEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:04:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FECC0A8850;
        Mon, 13 Dec 2021 01:50:28 -0800 (PST)
Date:   Mon, 13 Dec 2021 09:50:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639389026;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5+rm9KZWKsG0B7k2P1qa43D0aTRrf5ue7Cy428TnSA0=;
        b=SfHgHNBk0GL8z+B9gbrf5xD7uZxm1WuR+0/OQ7G4CHpHhM6X+FlKQX1VvKr7BvcRKMHzar
        7Cr/9rLTqG8Pg6GHExQV3tLZhD+oy8CGGId8tfLjvqbfrqd0Bt71WTiVi00+HyegF4b8ZI
        l+Oh4ygCM3ywvAQKy/aRblir3kicC/7bLTP4GZH61SOkPoyI/oJrcttrvY+yt+kmP26wXB
        ASRz5UhbuilwWRXJACkJLZmyozOciKBpE03I/WbNhQngRCSSw2UoMr98qjHtb3e12pe2qF
        bzeJBStNvKL4zvSDbJthh5Bh9sptPUt2CroS4uxY5dTJrjLTzteuXX+4cbS+8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639389026;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5+rm9KZWKsG0B7k2P1qa43D0aTRrf5ue7Cy428TnSA0=;
        b=oBolnVId88ixsc2UBIfp+BjHSIzK8oxHI0ZgbjVhg2O317tabpQvrY5Ulb3aAees8PTWRd
        Ho/J1pVlR59pe6Cw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] bitfield.h: Fix "type of reg too small for mask" test
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211110101324.950210584@infradead.org>
References: <20211110101324.950210584@infradead.org>
MIME-Version: 1.0
Message-ID: <163938902513.23020.16367474186635885490.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     bff8c3848e071d387d8b0784dc91fa49cd563774
Gitweb:        https://git.kernel.org/tip/bff8c3848e071d387d8b0784dc91fa49cd563774
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 10 Nov 2021 11:01:03 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Dec 2021 09:09:45 +01:00

bitfield.h: Fix "type of reg too small for mask" test

The test: 'mask > (typeof(_reg))~0ull' only works correctly when both
sides are unsigned, consider:

 - 0xff000000 vs (int)~0ull
 - 0x000000ff vs (int)~0ull

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20211110101324.950210584@infradead.org
---
 include/linux/bitfield.h | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 4e035ac..6093fa6 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -41,6 +41,22 @@
 
 #define __bf_shf(x) (__builtin_ffsll(x) - 1)
 
+#define __scalar_type_to_unsigned_cases(type)				\
+		unsigned type:	(unsigned type)0,			\
+		signed type:	(unsigned type)0
+
+#define __unsigned_scalar_typeof(x) typeof(				\
+		_Generic((x),						\
+			char:	(unsigned char)0,			\
+			__scalar_type_to_unsigned_cases(char),		\
+			__scalar_type_to_unsigned_cases(short),		\
+			__scalar_type_to_unsigned_cases(int),		\
+			__scalar_type_to_unsigned_cases(long),		\
+			__scalar_type_to_unsigned_cases(long long),	\
+			default: (x)))
+
+#define __bf_cast_unsigned(type, x)	((__unsigned_scalar_typeof(type))(x))
+
 #define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)			\
 	({								\
 		BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),		\
@@ -49,7 +65,8 @@
 		BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?		\
 				 ~((_mask) >> __bf_shf(_mask)) & (_val) : 0, \
 				 _pfx "value too large for the field"); \
-		BUILD_BUG_ON_MSG((_mask) > (typeof(_reg))~0ull,		\
+		BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >	\
+				 __bf_cast_unsigned(_reg, ~0ull),	\
 				 _pfx "type of reg too small for mask"); \
 		__BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +			\
 					      (1ULL << __bf_shf(_mask))); \
