Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40934BC1A9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 22:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239696AbiBRVQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 16:16:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239658AbiBRVQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 16:16:11 -0500
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1C22402C1;
        Fri, 18 Feb 2022 13:15:52 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5D0923BAC81;
        Fri, 18 Feb 2022 16:06:46 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id C4s-otjKdnzx; Fri, 18 Feb 2022 16:06:45 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3C0BC3BAC08;
        Fri, 18 Feb 2022 16:06:45 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3C0BC3BAC08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1645218405;
        bh=H1BI137TQVD0IUIV2Akwp3DX/CDXZ2SZLX9a456H6tM=;
        h=From:To:Date:Message-Id;
        b=tKEzkfG7PGZjAzJkK4utsGhL+ZAcBe2p49eg1uSb6X63SQBFwUQtZQuJQJIfByPxQ
         9qgyMzi8Ep0a/6jaiA+PeL7Ke/lbFl37ERUnjRzVF+Uu7KNKQ4q302ijvg0GQ3DzSK
         msmreRhyfKA9eoyW6tjqm8/re8pSF8vYRWUo/EW32xe3T9jaiECg+KevZHfDIxMPun
         rsXzuXGF+7rJqvVodNlhGoacGC03UxnH2CA4kGxn6fjo8hS66rC1PAqliTjPdTphw9
         uJIgVn9X7Vs3ZLy2/6/bXFDafE1I5fT2nM84/7HPhsO32E4gz3wgi4+TjX3gXvudXA
         nyglD/BLCXGsw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aVdYg6aUs7zb; Fri, 18 Feb 2022 16:06:45 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id B61673BAC00;
        Fri, 18 Feb 2022 16:06:43 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH v2 06/11] lib: invert _find_next_bit source arguments
Date:   Fri, 18 Feb 2022 16:06:28 -0500
Message-Id: <20220218210633.23345-7-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220218210633.23345-1-mathieu.desnoyers@efficios.com>
References: <20220218210633.23345-1-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apply bit-invert operations before the AND operation in _find_next_bit.
Allows AND operations on combined bitmasks in which we search either for
one or zero, e.g.: find first bit which is both zero in one bitmask AND
one in the second bitmask.

The existing use for find first zero bit does not use the second
argument, so whether the inversion is performed before or after the AND
operator does not matter.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/linux/find.h       | 13 +++++++------
 lib/find_bit.c             | 17 ++++++++---------
 tools/include/linux/find.h |  9 +++++----
 tools/lib/find_bit.c       | 17 ++++++++---------
 4 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/include/linux/find.h b/include/linux/find.h
index 5bb6db213bcb..41941cb9cad7 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -10,7 +10,8 @@
 
 extern unsigned long _find_next_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long nbits,
-		unsigned long start, unsigned long invert, unsigned long le);
+		unsigned long start, unsigned long invert_src1,
+		unsigned long src2, unsigned long le);
 extern unsigned long _find_first_bit(const unsigned long *addr, unsigned long size);
 extern unsigned long _find_first_and_bit(const unsigned long *addr1,
 					 const unsigned long *addr2, unsigned long size);
@@ -41,7 +42,7 @@ unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
 		return val ? __ffs(val) : size;
 	}
 
-	return _find_next_bit(addr, NULL, size, offset, 0UL, 0);
+	return _find_next_bit(addr, NULL, size, offset, 0UL, 0UL, 0);
 }
 #endif
 
@@ -71,7 +72,7 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 		return val ? __ffs(val) : size;
 	}
 
-	return _find_next_bit(addr1, addr2, size, offset, 0UL, 0);
+	return _find_next_bit(addr1, addr2, size, offset, 0UL, 0UL, 0);
 }
 #endif
 
@@ -99,7 +100,7 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 		return val == ~0UL ? size : ffz(val);
 	}
 
-	return _find_next_bit(addr, NULL, size, offset, ~0UL, 0);
+	return _find_next_bit(addr, NULL, size, offset, ~0UL, 0UL, 0);
 }
 #endif
 
@@ -247,7 +248,7 @@ unsigned long find_next_zero_bit_le(const void *addr, unsigned
 		return val == ~0UL ? size : ffz(val);
 	}
 
-	return _find_next_bit(addr, NULL, size, offset, ~0UL, 1);
+	return _find_next_bit(addr, NULL, size, offset, ~0UL, 0UL, 1);
 }
 #endif
 
@@ -266,7 +267,7 @@ unsigned long find_next_bit_le(const void *addr, unsigned
 		return val ? __ffs(val) : size;
 	}
 
-	return _find_next_bit(addr, NULL, size, offset, 0UL, 1);
+	return _find_next_bit(addr, NULL, size, offset, 0UL, 0UL, 1);
 }
 #endif
 
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 1b8e4b2a9cba..73e78565e691 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -25,23 +25,23 @@
 /*
  * This is a common helper function for find_next_bit, find_next_zero_bit, and
  * find_next_and_bit. The differences are:
- *  - The "invert" argument, which is XORed with each fetched word before
- *    searching it for one bits.
+ *  - The "invert_src1" and "invert_src2" arguments, which are XORed to
+ *    each source word before applying the 'and' operator.
  *  - The optional "addr2", which is anded with "addr1" if present.
  */
 unsigned long _find_next_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long nbits,
-		unsigned long start, unsigned long invert, unsigned long le)
+		unsigned long start, unsigned long invert_src1,
+		unsigned long invert_src2, unsigned long le)
 {
 	unsigned long tmp, mask;
 
 	if (unlikely(start >= nbits))
 		return nbits;
 
-	tmp = addr1[start / BITS_PER_LONG];
+	tmp = addr1[start / BITS_PER_LONG] ^ invert_src1;
 	if (addr2)
-		tmp &= addr2[start / BITS_PER_LONG];
-	tmp ^= invert;
+		tmp &= addr2[start / BITS_PER_LONG] ^ invert_src2;
 
 	/* Handle 1st word. */
 	mask = BITMAP_FIRST_WORD_MASK(start);
@@ -57,10 +57,9 @@ unsigned long _find_next_bit(const unsigned long *addr1,
 		if (start >= nbits)
 			return nbits;
 
-		tmp = addr1[start / BITS_PER_LONG];
+		tmp = addr1[start / BITS_PER_LONG] ^ invert_src1;
 		if (addr2)
-			tmp &= addr2[start / BITS_PER_LONG];
-		tmp ^= invert;
+			tmp &= addr2[start / BITS_PER_LONG] ^ invert_src2;
 	}
 
 	if (le)
diff --git a/tools/include/linux/find.h b/tools/include/linux/find.h
index 47e2bd6c5174..5ab0c95086ad 100644
--- a/tools/include/linux/find.h
+++ b/tools/include/linux/find.h
@@ -10,7 +10,8 @@
 
 extern unsigned long _find_next_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long nbits,
-		unsigned long start, unsigned long invert, unsigned long le);
+		unsigned long start, unsigned long invert_src1,
+		unsigned long src2, unsigned long le);
 extern unsigned long _find_first_bit(const unsigned long *addr, unsigned long size);
 extern unsigned long _find_first_and_bit(const unsigned long *addr1,
 					 const unsigned long *addr2, unsigned long size);
@@ -41,7 +42,7 @@ unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
 		return val ? __ffs(val) : size;
 	}
 
-	return _find_next_bit(addr, NULL, size, offset, 0UL, 0);
+	return _find_next_bit(addr, NULL, size, offset, 0UL, 0UL, 0);
 }
 #endif
 
@@ -71,7 +72,7 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 		return val ? __ffs(val) : size;
 	}
 
-	return _find_next_bit(addr1, addr2, size, offset, 0UL, 0);
+	return _find_next_bit(addr1, addr2, size, offset, 0UL, 0UL, 0);
 }
 #endif
 
@@ -99,7 +100,7 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 		return val == ~0UL ? size : ffz(val);
 	}
 
-	return _find_next_bit(addr, NULL, size, offset, ~0UL, 0);
+	return _find_next_bit(addr, NULL, size, offset, ~0UL, 0UL, 0);
 }
 #endif
 
diff --git a/tools/lib/find_bit.c b/tools/lib/find_bit.c
index ba4b8d94e004..4176232de7f9 100644
--- a/tools/lib/find_bit.c
+++ b/tools/lib/find_bit.c
@@ -24,13 +24,14 @@
 /*
  * This is a common helper function for find_next_bit, find_next_zero_bit, and
  * find_next_and_bit. The differences are:
- *  - The "invert" argument, which is XORed with each fetched word before
- *    searching it for one bits.
+ *  - The "invert_src1" and "invert_src2" arguments, which are XORed to
+ *    each source word before applying the 'and' operator.
  *  - The optional "addr2", which is anded with "addr1" if present.
  */
 unsigned long _find_next_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long nbits,
-		unsigned long start, unsigned long invert, unsigned long le)
+		unsigned long start, unsigned long invert_src1,
+		unsigned long invert_src2, unsigned long le)
 {
 	unsigned long tmp, mask;
 	(void) le;
@@ -38,10 +39,9 @@ unsigned long _find_next_bit(const unsigned long *addr1,
 	if (unlikely(start >= nbits))
 		return nbits;
 
-	tmp = addr1[start / BITS_PER_LONG];
+	tmp = addr1[start / BITS_PER_LONG] ^ invert_src1;
 	if (addr2)
-		tmp &= addr2[start / BITS_PER_LONG];
-	tmp ^= invert;
+		tmp &= addr2[start / BITS_PER_LONG] ^ invert_src2;
 
 	/* Handle 1st word. */
 	mask = BITMAP_FIRST_WORD_MASK(start);
@@ -64,10 +64,9 @@ unsigned long _find_next_bit(const unsigned long *addr1,
 		if (start >= nbits)
 			return nbits;
 
-		tmp = addr1[start / BITS_PER_LONG];
+		tmp = addr1[start / BITS_PER_LONG] ^ invert_src1;
 		if (addr2)
-			tmp &= addr2[start / BITS_PER_LONG];
-		tmp ^= invert;
+			tmp &= addr2[start / BITS_PER_LONG] ^ invert_src2;
 	}
 
 #if (0)
-- 
2.17.1

