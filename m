Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD54B575344
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240474AbiGNQpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240144AbiGNQoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:44:21 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBECDCDE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:43:45 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aeb82.dynamic.kabel-deutschland.de [95.90.235.130])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id D21D361EA192D;
        Thu, 14 Jul 2022 18:43:42 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v3] lib/bitmap: Make count and length parameters unsigned
Date:   Thu, 14 Jul 2022 18:42:07 +0200
Message-Id: <20220714164207.52410-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Counts and the length are non-negative, so make them unsigned, and adapt the
while condition in `__bitmap_set()` and `__bitmap_clear()` accordingly.

For `__bitmap_set()` six less intstructions are used as a result:

```
__bitmap_set: __bitmap_set:
        movl    %esi, %eax movl    %esi, %eax
        movq    %rdi, %r8                                     <
        movl    %esi, %ecx movl    %esi, %ecx
        movl    %edx, %edi                                    | movl    %esi, %r8d
                                                              > movl    $64, %esi
                                                              > andl    $63, %ecx
        shrl    $6, %eax shrl    $6, %eax
        andl    $63, %esi                                     | movl    %edx, %r9d
        movq    $-1, %rdx                                     | leaq    (%rdi,%rax,8), %rax
        leaq    (%r8,%rax,8), %rax                            | subl    %ecx, %esi
        leal    -64(%rsi,%rdi), %r8d                          | movq    $-1, %rdi
        salq    %cl, %rdx                                     | salq    %cl, %rdi
        testl   %r8d, %r8d                                    | cmpl    %edx, %esi
        js      .L88                                          | ja      .L85
        movl    %r8d, %r9d                                    <
        shrl    $6, %r9d                                      <
        leal    1(%r9), %esi                                  <
        leaq    (%rax,%rsi,8), %rsi                           <
.L86:                                                           .L86:
        orq     %rdx, (%rax)                                  | subl    %esi, %edx
                                                              > orq     %rdi, (%rax)
                                                              > movl    $64, %esi
        addq    $8, %rax addq    $8, %rax
        movq    $-1, %rdx                                     | movq    $-1, %rdi
        cmpq    %rsi, %rax                                    | cmpl    $63, %edx
        jne     .L86                                          | ja      .L86
        sall    $6, %r9d                                      <
        subl    %r9d, %r8d                                    <
.L85:                                                           .L85:
        testl   %r8d, %r8d                                    | testl   %edx, %edx
        je      .L84 je      .L84
        addl    %edi, %ecx                                    | leal    (%r8,%r9), %ecx
        movq    $-1, %rax                                     | movq    $-1, %rdx
        negl    %ecx negl    %ecx
        shrq    %cl, %rax                                     | shrq    %cl, %rdx
        andq    %rax, %rdx                                    | andq    %rdx, %rdi
        orq     %rdx, (%rsi)                                  | orq     %rdi, (%rax)
.L84:                                                           .L84:
        ret                                                             ret
.L88:                                                         <
        movq    %rax, %rsi                                    <
        movl    %edi, %r8d                                    <
        jmp     .L85                                          <
        .size   __bitmap_set, .-__bitmap_set .size   __bitmap_set, .-__bitmap_set
        .p2align 4 .p2align 4
        .globl  __bitmap_clear .globl  __bitmap_clear
        .type   __bitmap_clear, @function .type   __bitmap_clear, @function
```

    $ diff lib/bitmap.1.S lib/bitmap.2.S | diffstat
     unknown |   55 ++++++++++++++++++++++++-------------------------------
     1 file changed, 24 insertions(+), 31 deletions(-)

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
v2: Update signature in header file
v3: Adapt more functions to use unsigned int

 include/linux/bitmap.h | 20 ++++++++++----------
 lib/bitmap.c           | 26 +++++++++++++-------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 2e6cd5681040..9f1a097cd5d4 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -164,8 +164,8 @@ bool __bitmap_intersects(const unsigned long *bitmap1,
 bool __bitmap_subset(const unsigned long *bitmap1,
 		     const unsigned long *bitmap2, unsigned int nbits);
 int __bitmap_weight(const unsigned long *bitmap, unsigned int nbits);
-void __bitmap_set(unsigned long *map, unsigned int start, int len);
-void __bitmap_clear(unsigned long *map, unsigned int start, int len);
+void __bitmap_set(unsigned long *map, unsigned int start, unsigned int len);
+void __bitmap_clear(unsigned long *map, unsigned int start, unsigned int len);
 
 unsigned long bitmap_find_next_zero_area_off(unsigned long *map,
 					     unsigned long size,
@@ -198,17 +198,17 @@ bitmap_find_next_zero_area(unsigned long *map,
 }
 
 int bitmap_parse(const char *buf, unsigned int buflen,
-			unsigned long *dst, int nbits);
+			unsigned long *dst, unsigned int nbits);
 int bitmap_parse_user(const char __user *ubuf, unsigned int ulen,
-			unsigned long *dst, int nbits);
+			unsigned long *dst, unsigned int nbits);
 int bitmap_parselist(const char *buf, unsigned long *maskp,
-			int nmaskbits);
+			unsigned int nmaskbits);
 int bitmap_parselist_user(const char __user *ubuf, unsigned int ulen,
-			unsigned long *dst, int nbits);
+			unsigned long *dst, unsigned int nbits);
 void bitmap_remap(unsigned long *dst, const unsigned long *src,
 		const unsigned long *old, const unsigned long *new, unsigned int nbits);
 int bitmap_bitremap(int oldbit,
-		const unsigned long *old, const unsigned long *new, int bits);
+		const unsigned long *old, const unsigned long *new, unsigned int bits);
 void bitmap_onto(unsigned long *dst, const unsigned long *orig,
 		const unsigned long *relmap, unsigned int bits);
 void bitmap_fold(unsigned long *dst, const unsigned long *orig,
@@ -224,13 +224,13 @@ void bitmap_copy_le(unsigned long *dst, const unsigned long *src, unsigned int n
 #endif
 unsigned int bitmap_ord_to_pos(const unsigned long *bitmap, unsigned int ord, unsigned int nbits);
 int bitmap_print_to_pagebuf(bool list, char *buf,
-				   const unsigned long *maskp, int nmaskbits);
+				   const unsigned long *maskp, unsigned int nmaskbits);
 
 extern int bitmap_print_bitmask_to_buf(char *buf, const unsigned long *maskp,
-				      int nmaskbits, loff_t off, size_t count);
+				      unsigned int nmaskbits, loff_t off, size_t count);
 
 extern int bitmap_print_list_to_buf(char *buf, const unsigned long *maskp,
-				      int nmaskbits, loff_t off, size_t count);
+				      unsigned int nmaskbits, loff_t off, size_t count);
 
 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
 #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
diff --git a/lib/bitmap.c b/lib/bitmap.c
index b18e31ea6e66..d529f7dffc48 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -348,14 +348,14 @@ int __bitmap_weight(const unsigned long *bitmap, unsigned int bits)
 }
 EXPORT_SYMBOL(__bitmap_weight);
 
-void __bitmap_set(unsigned long *map, unsigned int start, int len)
+void __bitmap_set(unsigned long *map, unsigned int start, unsigned int len)
 {
 	unsigned long *p = map + BIT_WORD(start);
 	const unsigned int size = start + len;
 	int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
 	unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
 
-	while (len - bits_to_set >= 0) {
+	while (len >= bits_to_set) {
 		*p |= mask_to_set;
 		len -= bits_to_set;
 		bits_to_set = BITS_PER_LONG;
@@ -369,7 +369,7 @@ void __bitmap_set(unsigned long *map, unsigned int start, int len)
 }
 EXPORT_SYMBOL(__bitmap_set);
 
-void __bitmap_clear(unsigned long *map, unsigned int start, int len)
+void __bitmap_clear(unsigned long *map, unsigned int start, unsigned int len)
 {
 	unsigned long *p = map + BIT_WORD(start);
 	const unsigned int size = start + len;
@@ -445,7 +445,7 @@ EXPORT_SYMBOL(bitmap_find_next_zero_area_off);
  */
 int bitmap_parse_user(const char __user *ubuf,
 			unsigned int ulen, unsigned long *maskp,
-			int nmaskbits)
+			unsigned int nmaskbits)
 {
 	char *buf;
 	int ret;
@@ -478,7 +478,7 @@ EXPORT_SYMBOL(bitmap_parse_user);
  * actually printed to @buf, excluding terminating '\0'.
  */
 int bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
-			    int nmaskbits)
+			    unsigned int nmaskbits)
 {
 	ptrdiff_t len = PAGE_SIZE - offset_in_page(buf);
 
@@ -499,7 +499,7 @@ EXPORT_SYMBOL(bitmap_print_to_pagebuf);
  * @count: the maximum number of bytes to print
  */
 static int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
-		int nmaskbits, loff_t off, size_t count)
+		unsigned int nmaskbits, loff_t off, size_t count)
 {
 	const char *fmt = list ? "%*pbl\n" : "%*pb\n";
 	ssize_t size;
@@ -542,7 +542,7 @@ static int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
  * normal attribute with buf parameter and without offset, count::
  *
  *   bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
- * 			   int nmaskbits)
+ * 			   unsigned int nmaskbits)
  *   {
  *   }
  *
@@ -600,7 +600,7 @@ static int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
  * Returns the number of characters actually printed to @buf
  */
 int bitmap_print_bitmask_to_buf(char *buf, const unsigned long *maskp,
-				int nmaskbits, loff_t off, size_t count)
+				unsigned int nmaskbits, loff_t off, size_t count)
 {
 	return bitmap_print_to_buf(false, buf, maskp, nmaskbits, off, count);
 }
@@ -618,7 +618,7 @@ EXPORT_SYMBOL(bitmap_print_bitmask_to_buf);
  * the print format.
  */
 int bitmap_print_list_to_buf(char *buf, const unsigned long *maskp,
-			     int nmaskbits, loff_t off, size_t count)
+			     unsigned int nmaskbits, loff_t off, size_t count)
 {
 	return bitmap_print_to_buf(true, buf, maskp, nmaskbits, off, count);
 }
@@ -793,7 +793,7 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
  *   - ``-ERANGE``: bit number specified too large for mask
  *   - ``-EOVERFLOW``: integer overflow in the input parameters
  */
-int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
+int bitmap_parselist(const char *buf, unsigned long *maskp, unsigned int nmaskbits)
 {
 	struct region r;
 	long ret;
@@ -836,7 +836,7 @@ EXPORT_SYMBOL(bitmap_parselist);
  */
 int bitmap_parselist_user(const char __user *ubuf,
 			unsigned int ulen, unsigned long *maskp,
-			int nmaskbits)
+			unsigned int nmaskbits)
 {
 	char *buf;
 	int ret;
@@ -893,7 +893,7 @@ static const char *bitmap_get_x32_reverse(const char *start,
  * Leading, embedded and trailing whitespace accepted.
  */
 int bitmap_parse(const char *start, unsigned int buflen,
-		unsigned long *maskp, int nmaskbits)
+		unsigned long *maskp, unsigned int nmaskbits)
 {
 	const char *end = strnchrnul(start, buflen, '\n') - 1;
 	int chunks = BITS_TO_U32(nmaskbits);
@@ -1068,7 +1068,7 @@ EXPORT_SYMBOL(bitmap_remap);
  * returns 13.
  */
 int bitmap_bitremap(int oldbit, const unsigned long *old,
-				const unsigned long *new, int bits)
+				const unsigned long *new, unsigned int bits)
 {
 	int w = bitmap_weight(new, bits);
 	int n = bitmap_pos_to_ord(old, oldbit, bits);
-- 
2.36.1

