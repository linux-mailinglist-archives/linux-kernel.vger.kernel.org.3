Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5F946748A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 11:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351321AbhLCKMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 05:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238002AbhLCKMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:12:13 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1AEC06174A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 02:08:49 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id gt5so1981273pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 02:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3aZ5hDOTlO9xAqAgnGVw37SSPdysn8T37LNEi5bKxUg=;
        b=d2FoMZ5BSWHyC91UJNk52xIlwntY9Kye3U3KlSxHSxqlCk/9uBaedAREZ8y3Z+DXeP
         jv2fzsuey8WczSBAKDamU8MDOooz99K9vNXQV6HOqEnick5aQMeeYqD4Ht3kN6IXeQpk
         J0kUFNBvrqkK9Ddbh6w26IEoVaDxEurQtBc24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3aZ5hDOTlO9xAqAgnGVw37SSPdysn8T37LNEi5bKxUg=;
        b=ZtHxnRZMRHIL/OEJHIgAbKBvKdiHUUlUNk0GhhIQTJn/ziRfHFLIIz0o88q99navGm
         GaDclT2LmYEDd99O+ikhwD0tqIi3buuuhQ3sN5z4ZPAcgOHtEG/5zcOMRXVvS4Fl8gxe
         +Nzc7m2fyRygoFV/5rTSCzvx9w8/Gx0k01gFtPHjgqxNNJo3rxig5QWO/4vwFPF/Jesk
         yJ2GawP1kMtKHoIWLVkeEyTn3rBQ22bqCB5ktKX00TDphHzBFsc8SiAdpsjiRAHdckaI
         Nl77ut9mzvwgHtLJGkzT1FaYxosrhQPxOHovGLxGN+z8re89xsOAYlBuUvOAmwEfJmwA
         Hn3A==
X-Gm-Message-State: AOAM531QBcEcAYx5Xx4RoQsOBDLt0mbmala9fQ+ZWWgaA5B0XuVNOYZy
        pOOTC0VSPrd7JKwIp5GckwcsbA==
X-Google-Smtp-Source: ABdhPJzw/7Xz0aU1ckB6L0IzIV/BVsYBOC7g21m34vtPf/wjrcjtJhg2FcVMWckxxHrSrjEeKa+awA==
X-Received: by 2002:a17:90a:bf0b:: with SMTP id c11mr12790653pjs.208.1638526128850;
        Fri, 03 Dec 2021 02:08:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y25sm2030640pgk.47.2021.12.03.02.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 02:08:48 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] find: Do not read beyond variable boundaries on small sizes
Date:   Fri,  3 Dec 2021 02:08:46 -0800
Message-Id: <20211203100846.3977195-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5527; h=from:subject; bh=fstdx1AjSi56ftIfU1iOgGLkvOQ+17iNMBAx3aiRsD8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhqeytl8dF3244Y09cI+u+3NQpjlcZKiKV9buJ/CDa eHfUI22JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYansrQAKCRCJcvTf3G3AJniqD/ sHPQeMVUUIMrflHY818vzvfnat9krrGjB+v1zPg1GvVJQCFFOsKSD4hxzAz/yXq6bBPAjLjlFezzZl tUpv9nJcerFZlGuoqFywdQSfhjKRwVmBtxXbdGvYC4DpZ/0As4X65ACatKnxgmP96k9fWkdlZb+Vzo M7ZPJWcNJP1CnjcuYy3nBJ39MJD5X+lzU5kK5PM0wOfkQuSTIAs0KC2+86ft2NMo4x4oeU4TuXLfaZ ElOsN7ojBXoM+tBYktrZ02GwhOAhF4AYHM6FPomFOxrDr87FzPci/NPbpIpXqhYTg8SlVNyCYg9Avd 8bYHhWoxRW4yCu46Jlxa2X1dnNZIHG4M4wMt/LaXtzgvX+gs18UBrlv4Mrwxo9w5OD/VqIMppANcGc AUvUGtVDHMl/8o+oYs44K7uOqi7RSjhNnTqcqpny92r31/pn0tm+Qgwip9bIQDfHEsLD/SZ4Qpi1tM zojc7QWTeE+GNdfE2s/N3Sp/ZpKCy/rK/j/qO56QbWZmOWrN3DRJAmRL3EJvObKWnNNne+yqj/xdLO G5QptPO0EINafZUyBrHPK9+f9MNfhWxGo/pezRpQAp9wgsF1jV/8nJbuc4jKXOuz/nzWcQiqgXw/De rGVVI3i2JicwDW2A+igeobHc9EMS4wyLjEUwaJN3wNjKjZmOQ5BTo3N4330w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's common practice to cast small variable arguments to the find_*_bit()
helpers to unsigned long and then use a size argument smaller than
sizeof(unsigned long):

	unsigned int bits;
	...
	out = find_first_bit((unsigned long *)&bits, 32);

This leads to the find helper dereferencing a full unsigned long,
regardless of the size of the actual variable. The unwanted bits
get masked away, but strictly speaking, a read beyond the end of
the target variable happens. Builds under -Warray-bounds complain
about this situation, for example:

In file included from ./include/linux/bitmap.h:9,
                 from drivers/iommu/intel/iommu.c:17:
drivers/iommu/intel/iommu.c: In function 'domain_context_mapping_one':
./include/linux/find.h:119:37: error: array subscript 'long unsigned int[0]' is partly outside array bounds of 'int[1]' [-Werror=array-bounds]
  119 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
      |                                     ^~~~~
drivers/iommu/intel/iommu.c:2115:18: note: while referencing 'max_pde'
 2115 |         int pds, max_pde;
      |                  ^~~~~~~

Instead, just carefully read the correct variable size, all of which
happens at compile time since small_const_nbits(size) has already
determined that arguments are constant expressions.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/find.h | 62 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 7 deletions(-)

diff --git a/include/linux/find.h b/include/linux/find.h
index 5bb6db213bcb..5708d188b9cb 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -17,6 +17,41 @@ extern unsigned long _find_first_and_bit(const unsigned long *addr1,
 extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
 extern unsigned long _find_last_bit(const unsigned long *addr, unsigned long size);
 
+static __always_inline
+unsigned long __find_bits_deref(const void *addr, unsigned long size)
+{
+	unsigned long val;
+
+	BUILD_BUG_ON(!small_const_nbits(size));
+	/*
+	 * This part of the routine will be evaluated at
+	 * compile-time (due to small_const_nbits()), and only
+	 * for values of "size" <= sizeof(unsigned long). As
+	 * such, the compiler can see when the dereference of
+	 * "addr" may be reading past the end of the variable
+	 * (when it is smaller than unsigned long). While the
+	 * GENMASK will clobber those bits for no exposure, it
+	 * is still technically an OOB read. Instead, pick a
+	 * better dereference width to avoid it entirely.
+	 */
+	switch (size) {
+	case 0 ... 8:
+		val = *(const unsigned char *)addr;
+		break;
+	case 9 ... 16:
+		val = *(const unsigned short *)addr;
+		break;
+	case 17 ... 32:
+		val = *(const unsigned int *)addr;
+		break;
+	default:
+		val = *(const unsigned long *)addr;
+		break;
+	}
+
+	return val;
+}
+
 #ifndef find_next_bit
 /**
  * find_next_bit - find the next set bit in a memory region
@@ -37,7 +72,8 @@ unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
 		if (unlikely(offset >= size))
 			return size;
 
-		val = *addr & GENMASK(size - 1, offset);
+		val =  __find_bits_deref(addr, size);
+		val &= GENMASK(size - 1, offset);
 		return val ? __ffs(val) : size;
 	}
 
@@ -67,7 +103,9 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 		if (unlikely(offset >= size))
 			return size;
 
-		val = *addr1 & *addr2 & GENMASK(size - 1, offset);
+		val =  __find_bits_deref(addr1, size);
+		val &= __find_bits_deref(addr2, size);
+		val &= GENMASK(size - 1, offset);
 		return val ? __ffs(val) : size;
 	}
 
@@ -95,7 +133,8 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 		if (unlikely(offset >= size))
 			return size;
 
-		val = *addr | ~GENMASK(size - 1, offset);
+		val =  __find_bits_deref(addr, size);
+		val |= ~GENMASK(size - 1, offset);
 		return val == ~0UL ? size : ffz(val);
 	}
 
@@ -116,8 +155,10 @@ static inline
 unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
 {
 	if (small_const_nbits(size)) {
-		unsigned long val = *addr & GENMASK(size - 1, 0);
+		unsigned long val;
 
+		val =  __find_bits_deref(addr, size);
+		val &= GENMASK(size - 1, 0);
 		return val ? __ffs(val) : size;
 	}
 
@@ -141,8 +182,11 @@ unsigned long find_first_and_bit(const unsigned long *addr1,
 				 unsigned long size)
 {
 	if (small_const_nbits(size)) {
-		unsigned long val = *addr1 & *addr2 & GENMASK(size - 1, 0);
+		unsigned long val;
 
+		val =  __find_bits_deref(addr1, size);
+		val &= __find_bits_deref(addr2, size);
+		val &= GENMASK(size - 1, 0);
 		return val ? __ffs(val) : size;
 	}
 
@@ -163,8 +207,10 @@ static inline
 unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
 {
 	if (small_const_nbits(size)) {
-		unsigned long val = *addr | ~GENMASK(size - 1, 0);
+		unsigned long val;
 
+		val =  __find_bits_deref(addr, size);
+		val |= ~GENMASK(size - 1, 0);
 		return val == ~0UL ? size : ffz(val);
 	}
 
@@ -184,8 +230,10 @@ static inline
 unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
 {
 	if (small_const_nbits(size)) {
-		unsigned long val = *addr & GENMASK(size - 1, 0);
+		unsigned long val;
 
+		val =  __find_bits_deref(addr, size);
+		val &= GENMASK(size - 1, 0);
 		return val ? __fls(val) : size;
 	}
 
-- 
2.30.2

