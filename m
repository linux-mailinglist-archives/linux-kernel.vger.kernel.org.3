Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFDD5A395D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 19:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiH0R6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 13:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiH0R6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 13:58:19 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B091CF327E
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 10:58:13 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id f14so3462971qkm.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 10:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=+ROIhR+DUlx4fpKW5KLbgmJzC5ncENSa5comAdZ246Q=;
        b=D3Tl/vpiPHu8H8igqykqECr+3dgVEyZ8XzOb2zB6Sk8qIE9+t5FABGPMeqSP+E5P0t
         sZPQq92HA9mqw/yG4N8vnUsA0qG2qdiEv1k0gWo8LMtCzKuspZ54U1Zsl4qNi/TEx0QE
         kj8n2pSGjQxdKFx0IB/FU3Xlyoosyj05lScctNb9fLjsSIlL4/nbYKB4aeMrIg4l+tl7
         cx3GMt4DK/gU86KO9R64gIHzcGxcpWAkNye6vx50hOJ86dLo91nrJBAenPMONtnEGIFY
         TphM0ShCXXJLcQIQasJJ5FlVYI0M5acW9OL1EdRhYENTvajdoSy0C4EQtCoZsYQeVxv+
         fpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=+ROIhR+DUlx4fpKW5KLbgmJzC5ncENSa5comAdZ246Q=;
        b=EMMSb2BErCmxLsCdN8JM3uR25kzPGDf7LNR2joOyuKnv4HGTTIQyDpO1EqFHo9uViN
         WAo/8xfnV8X0+W4W/0/Yb1KBiZEbHUmFprMNIwkF+RI0N3TrSYYpHiQpQWmPzDEZ+/bY
         4mRp/ve1X6BytXgCOE2zpzWwNeG87F52/maU8fpcFzBmIzq236DJhu7w/yd2PqjP93eo
         9jClmM5/Bce2qwSOwNPjLchjlz52395L05EIkSxuLSPTUfkfnarJKTMIzTHN7QGlPm+L
         KQ3cU7q9YTUHt9Lon+yw5ap4HIl1rpjTTOURxFI6XK89yH67FtV91gYMkcnjhnOBkJ0d
         GAdQ==
X-Gm-Message-State: ACgBeo2Dm/8Z3lgNWy6RvXtd/QdjYdlIX2SYS8oco0MtfzETNvw7RFAw
        NErx1BTkYNcQV4ptls8ldXU=
X-Google-Smtp-Source: AA6agR5DtVTedUb0fJmhOAdeqfwA395d9c01AeYRUFpxmgQLem/pnzYzeWylEI2VfDWT7iVEeilDbg==
X-Received: by 2002:a37:9ad4:0:b0:6b9:c5d1:74e2 with SMTP id c203-20020a379ad4000000b006b9c5d174e2mr3546613qke.319.1661623091470;
        Sat, 27 Aug 2022 10:58:11 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:2454:ae5e:5655:e298])
        by smtp.gmail.com with ESMTPSA id az20-20020a05620a171400b006bb41ac3b6bsm2250194qkb.113.2022.08.27.10.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 10:58:11 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Whitcroft <apw@canonical.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Dennis Zhou <dennis@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v3 2/4] lib/find_bit: create find_first_zero_bit_le()
Date:   Sat, 27 Aug 2022 10:58:05 -0700
Message-Id: <20220827175807.4017673-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220827175807.4017673-1-yury.norov@gmail.com>
References: <20220827175807.4017673-1-yury.norov@gmail.com>
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

find_first_zero_bit_le() is an alias to find_next_zero_bit_le(),
despite that 'next' is known to be slower than 'first' version.

Now that we have common FIND_FIRST_BIT() macro helper, it's trivial
to implement find_first_zero_bit_le() as a real function.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/find.h | 23 ++++++++++++++++++-----
 lib/find_bit.c       | 14 ++++++++++++++
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/include/linux/find.h b/include/linux/find.h
index 424ef67d4a42..a1861d0ba533 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -17,6 +17,10 @@ extern unsigned long _find_first_and_bit(const unsigned long *addr1,
 extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
 extern unsigned long _find_last_bit(const unsigned long *addr, unsigned long size);
 
+#ifdef __BIG_ENDIAN
+unsigned long _find_first_zero_bit_le(const unsigned long *addr, unsigned long size);
+#endif
+
 #ifndef find_next_bit
 /**
  * find_next_bit - find the next set bit in a memory region
@@ -251,6 +255,20 @@ unsigned long find_next_zero_bit_le(const void *addr, unsigned
 }
 #endif
 
+#ifndef find_first_zero_bit_le
+static inline
+unsigned long find_first_zero_bit_le(const unsigned long *addr, unsigned long size)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val = swab(*addr) | ~GENMASK(size - 1, 0);
+
+		return val == ~0UL ? size : ffz(val);
+	}
+
+	return _find_first_zero_bit_le(addr, size);
+}
+#endif
+
 #ifndef find_next_bit_le
 static inline
 unsigned long find_next_bit_le(const void *addr, unsigned
@@ -270,11 +288,6 @@ unsigned long find_next_bit_le(const void *addr, unsigned
 }
 #endif
 
-#ifndef find_first_zero_bit_le
-#define find_first_zero_bit_le(addr, size) \
-	find_next_zero_bit_le((addr), (size), 0)
-#endif
-
 #else
 #error "Please fix <asm/byteorder.h>"
 #endif
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 894b656f6836..f4d9b9684811 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -160,3 +160,17 @@ unsigned long find_next_clump8(unsigned long *clump, const unsigned long *addr,
 	return offset;
 }
 EXPORT_SYMBOL(find_next_clump8);
+
+#ifdef __BIG_ENDIAN
+#ifndef find_first_zero_bit_le
+/*
+ * Find the first cleared bit in an LE memory region.
+ */
+unsigned long _find_first_zero_bit_le(const unsigned long *addr, unsigned long size)
+{
+	return FIND_FIRST_BIT(~addr[idx], swab, size);
+}
+EXPORT_SYMBOL(_find_first_zero_bit_le);
+#endif
+
+#endif /* __BIG_ENDIAN */
-- 
2.34.1

