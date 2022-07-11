Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E714656D403
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 06:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiGKErd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 00:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiGKErT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 00:47:19 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3000260CF
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 21:47:18 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id f12so3014869qka.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 21:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A6q5z8s18QRfHFAJrndvZI9vXCYXjK+FWxgchg+J6RI=;
        b=QBLvVko+rS1FTRCtsf8vYGAy3nf88w3gkkF8Q6lJ4404r2d6ucehKkAsSxdZTlDrJN
         2pUb0w/ZNLfWKoV4hMSenj84fR8fbAkByJK+izpYCcYmSoKXJdYn/I7UMDtX8zVvxjPy
         +fcOJSDoVp+JIfnFpHlM5gNfBGdf/kVhF+DUWvoNP+Jw1pE5yLBMGxfKlhxkbnxbH9zW
         woWPX6MRG8VWKSr5Gw1JueW0KsxNBk5D/3JQRTdRjlPpYt3y+5gACNvHDQUMggy1U/Mu
         PBs1b1FO5Hl0pyz9+ImqpzBvXjW1oP1Sibb7/pjUgGo0k88vOsDm4Vv1aswEUmmhOtFw
         V0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A6q5z8s18QRfHFAJrndvZI9vXCYXjK+FWxgchg+J6RI=;
        b=LwaZkJIIXAajkHyEI1XpauvtZm8nuF0afGVvnPw0CU+bYIXMToooRR+z5eU4+KWuaz
         8nMcq1APDyuEGgceYZfLhqjx18WN4sJxF+5QZAfc4X2/4wLEp7cbkdfvr5nllOM32ATD
         hgnEsQWCJdgB6g2aLhMrAdVYNPiosYuBjK+tt2Gkld58K+g/q3kZu5DzjLcIuXDaMv85
         PzHWeOTMIiq9ZptfUfzI4ble3zKa7ulO1Jcwn4MhFhbyRP0M31WQ+GMAFNBHfqAMjkOa
         EprIX4w6d6LZ7SI4mHgGrAx91FIGUi3YW2WQ/wPhconFHFK64GdxkzJ6KxQHqbdbJ+RF
         J0yA==
X-Gm-Message-State: AJIora8Ea4jEJZ6SKaDRdXMIw+VesGzcDzowTREodWxIJF6u/7ppne+L
        lg2cuiNRENl8FEX+wEfbPEniT7YUAQLeKg==
X-Google-Smtp-Source: AGRyM1t0kd3jZCCquGJH9OtMac+nJ5b3c9DI68BHZKN/BAfLOUcyRZM4IrHddpmG4NB4S2tCbsdhrw==
X-Received: by 2002:a37:a695:0:b0:6b5:8c47:ab0 with SMTP id p143-20020a37a695000000b006b58c470ab0mr1252213qke.579.1657514837051;
        Sun, 10 Jul 2022 21:47:17 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:a22e:180:f963:1eff])
        by smtp.gmail.com with ESMTPSA id s12-20020a05620a29cc00b006b28349678dsm5975138qkp.80.2022.07.10.21.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 21:47:16 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Kees Cook <keescook@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 3/5] lib/bitmap: remove bitmap_ord_to_pos
Date:   Sun, 10 Jul 2022 21:47:09 -0700
Message-Id: <20220711044711.466822-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220711044711.466822-1-yury.norov@gmail.com>
References: <20220711044711.466822-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have find_nth_bit(), we can drop bitmap_ord_to_pos().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitmap.h |  1 -
 lib/bitmap.c           | 36 +++---------------------------------
 lib/nodemask.c         |  3 +--
 3 files changed, 4 insertions(+), 36 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 035d4ac66641..0de6f6a101a9 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -222,7 +222,6 @@ void bitmap_copy_le(unsigned long *dst, const unsigned long *src, unsigned int n
 #else
 #define bitmap_copy_le bitmap_copy
 #endif
-unsigned int bitmap_ord_to_pos(const unsigned long *bitmap, unsigned int ord, unsigned int nbits);
 int bitmap_print_to_pagebuf(bool list, char *buf,
 				   const unsigned long *maskp, int nmaskbits);
 
diff --git a/lib/bitmap.c b/lib/bitmap.c
index b580b381eca1..0b1082aa0b2c 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -956,36 +956,6 @@ static int bitmap_pos_to_ord(const unsigned long *buf, unsigned int pos, unsigne
 	return __bitmap_weight(buf, pos);
 }
 
-/**
- * bitmap_ord_to_pos - find position of n-th set bit in bitmap
- *	@buf: pointer to bitmap
- *	@ord: ordinal bit position (n-th set bit, n >= 0)
- *	@nbits: number of valid bit positions in @buf
- *
- * Map the ordinal offset of bit @ord in @buf to its position in @buf.
- * Value of @ord should be in range 0 <= @ord < weight(buf). If @ord
- * >= weight(buf), returns @nbits.
- *
- * If for example, just bits 4 through 7 are set in @buf, then @ord
- * values 0 through 3 will get mapped to 4 through 7, respectively,
- * and all other @ord values returns @nbits.  When @ord value 3
- * gets mapped to (returns) @pos value 7 in this example, that means
- * that the 3rd set bit (starting with 0th) is at position 7 in @buf.
- *
- * The bit positions 0 through @nbits-1 are valid positions in @buf.
- */
-unsigned int bitmap_ord_to_pos(const unsigned long *buf, unsigned int ord, unsigned int nbits)
-{
-	unsigned int pos;
-
-	for (pos = find_first_bit(buf, nbits);
-	     pos < nbits && ord;
-	     pos = find_next_bit(buf, nbits, pos + 1))
-		ord--;
-
-	return pos;
-}
-
 /**
  * bitmap_remap - Apply map defined by a pair of bitmaps to another bitmap
  *	@dst: remapped result
@@ -1035,7 +1005,7 @@ void bitmap_remap(unsigned long *dst, const unsigned long *src,
 		if (n < 0 || w == 0)
 			set_bit(oldbit, dst);	/* identity map */
 		else
-			set_bit(bitmap_ord_to_pos(new, n % w, nbits), dst);
+			set_bit(find_nth_bit(new, nbits, n % w), dst);
 	}
 }
 EXPORT_SYMBOL(bitmap_remap);
@@ -1074,7 +1044,7 @@ int bitmap_bitremap(int oldbit, const unsigned long *old,
 	if (n < 0 || w == 0)
 		return oldbit;
 	else
-		return bitmap_ord_to_pos(new, n % w, bits);
+		return find_nth_bit(new, bits, n % w);
 }
 EXPORT_SYMBOL(bitmap_bitremap);
 
@@ -1198,7 +1168,7 @@ void bitmap_onto(unsigned long *dst, const unsigned long *orig,
 	 * The following code is a more efficient, but less
 	 * obvious, equivalent to the loop:
 	 *	for (m = 0; m < bitmap_weight(relmap, bits); m++) {
-	 *		n = bitmap_ord_to_pos(orig, m, bits);
+	 *		n = find_nth_bit(orig, bits, m);
 	 *		if (test_bit(m, orig))
 	 *			set_bit(n, dst);
 	 *	}
diff --git a/lib/nodemask.c b/lib/nodemask.c
index e22647f5181b..7dad4ce8ff59 100644
--- a/lib/nodemask.c
+++ b/lib/nodemask.c
@@ -24,8 +24,7 @@ int node_random(const nodemask_t *maskp)
 
 	w = nodes_weight(*maskp);
 	if (w)
-		bit = bitmap_ord_to_pos(maskp->bits,
-			get_random_int() % w, MAX_NUMNODES);
+		bit = find_nth_bit(maskp->bits, MAX_NUMNODES, get_random_int() % w);
 	return bit;
 }
 #endif
-- 
2.34.1

