Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6B75691A6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbiGFSXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiGFSXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:23:07 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A82C20193
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:23:06 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id h19so19451728qtp.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 11:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hy1Cll65BZP8JO4Jpuyg4IGmFUmacl9SpleS3IvscpM=;
        b=nmgqjfLsvKj1hpB3WD2dAqde/v8ZbkHNCp1gle0xYqg8ojb8HqI9laswQ7QP6n78MP
         iwZ4P07GtZEGMy/B0qmlyxfpuxVWjrsvKBKzHahnRKhUn1IIoTB2P9Wi0LAdc3Fx+Lnb
         KvnRuITTi8Fmx2oWrleoCsC3oiqE69JX1s1mCuTxvPESO3ziUVn1oRWOmlKVZTVx/0Ir
         sjH6zW0yMTFBz3032wkKCAE/HA28GCX7SSVJWK/zuuYl217pgC+VKeX9SqqdkFZkzRR2
         zAZVtflmXkAF/gdVYwBoqusSwLtunXiHYjQZDivGuVtuIu3V0AVAg/hb096zHtPG+GQa
         puhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hy1Cll65BZP8JO4Jpuyg4IGmFUmacl9SpleS3IvscpM=;
        b=6HniR9JQbSnVDzYIPMQfydmPGuPl4n/+0XhSuuJRErwjT5iivcLIOlewmPnWYGBlAB
         Cvh0QdHuFgO/NXEPfIGhKjDMyRG3X7k2fWjRNHoTcbltT4xrbcOZ+aYHK5Y2m7k8dzKy
         wWffZcZHyueMLGiqOC2hHKFaCaGQxheddHplLebtoWDtuCQXyAgqLNMoNLUDQXiNcdlx
         PpDNh2a2HjvBKUfdiv7i2lmURIJ0dpGt/ckmM5E+pwNoB8QSzl9VJIcraaEw8UFWiM2E
         kWEYp44TvtkLlmBPIxeRoB1vpL15xsCLnfrnYTGWG7au6c4b7KVEfi0rj7UaIrAqeTWm
         qgyQ==
X-Gm-Message-State: AJIora/xB5RDBtFwWV+UY2nuTXTaYgg8IULw+QL8k9p3xh4xY3OKJ9eu
        P0O325d8pcAZFKzB6KbqglzHZqcDRX1Ijg==
X-Google-Smtp-Source: AGRyM1sXwH/92sewGs9iSo+ylW6KFna6nLt4ZI+flx/x9kz+/TNp6ZoAEKE+iD2jAbfLqbhU0FKAQQ==
X-Received: by 2002:a05:622a:1305:b0:31d:3d10:fd88 with SMTP id v5-20020a05622a130500b0031d3d10fd88mr20986122qtk.168.1657131785197;
        Wed, 06 Jul 2022 11:23:05 -0700 (PDT)
Received: from localhost (c-69-254-185-160.hsd1.fl.comcast.net. [69.254.185.160])
        by smtp.gmail.com with ESMTPSA id ey14-20020a05622a4c0e00b002fcb0d95f65sm24639528qtb.90.2022.07.06.11.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 11:23:05 -0700 (PDT)
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
Date:   Wed,  6 Jul 2022 11:22:58 -0700
Message-Id: <20220706182300.70862-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220706182300.70862-1-yury.norov@gmail.com>
References: <20220706182300.70862-1-yury.norov@gmail.com>
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
index b2198665a064..91506057b240 100644
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
+			set_bit(find_nth_bit(new, nbits, n % w + 1), dst);
 	}
 }
 EXPORT_SYMBOL(bitmap_remap);
@@ -1074,7 +1044,7 @@ int bitmap_bitremap(int oldbit, const unsigned long *old,
 	if (n < 0 || w == 0)
 		return oldbit;
 	else
-		return bitmap_ord_to_pos(new, n % w, bits);
+		return find_nth_bit(new, bits, n % w + 1);
 }
 EXPORT_SYMBOL(bitmap_bitremap);
 
@@ -1198,7 +1168,7 @@ void bitmap_onto(unsigned long *dst, const unsigned long *orig,
 	 * The following code is a more efficient, but less
 	 * obvious, equivalent to the loop:
 	 *	for (m = 0; m < bitmap_weight(relmap, bits); m++) {
-	 *		n = bitmap_ord_to_pos(orig, m, bits);
+	 *		n = find_nth_bit(orig, bits, m + 1);
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
+		bit = find_nth_bit(maskp->bits, MAX_NUMNODES, get_random_int() % w + 1);
 	return bit;
 }
 #endif
-- 
2.34.1

