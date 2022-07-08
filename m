Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7190E56B3DA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237483AbiGHHxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236895AbiGHHxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:53:41 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBB21D308
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 00:53:38 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aeb4e.dynamic.kabel-deutschland.de [95.90.235.78])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id C942B61EA1929;
        Fri,  8 Jul 2022 09:53:35 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] lib/bitmap: Make parameter len unsigned
Date:   Fri,  8 Jul 2022 09:52:40 +0200
Message-Id: <20220708075239.9057-1-pmenzel@molgen.mpg.de>
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

The length is non-negative, so make it unsigned.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
v2: Update signature in header file

 include/linux/bitmap.h | 2 +-
 lib/bitmap.c           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 2e6cd5681040..feaf84cbc487 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -164,7 +164,7 @@ bool __bitmap_intersects(const unsigned long *bitmap1,
 bool __bitmap_subset(const unsigned long *bitmap1,
 		     const unsigned long *bitmap2, unsigned int nbits);
 int __bitmap_weight(const unsigned long *bitmap, unsigned int nbits);
-void __bitmap_set(unsigned long *map, unsigned int start, int len);
+void __bitmap_set(unsigned long *map, unsigned int start, unsigned int len);
 void __bitmap_clear(unsigned long *map, unsigned int start, int len);
 
 unsigned long bitmap_find_next_zero_area_off(unsigned long *map,
diff --git a/lib/bitmap.c b/lib/bitmap.c
index b18e31ea6e66..0746beb336df 100644
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
-- 
2.36.1

