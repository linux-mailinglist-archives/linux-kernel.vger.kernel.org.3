Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E997656ADFB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 23:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236295AbiGGVv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 17:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiGGVv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:51:56 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC97B4D15C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 14:51:54 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aedb6.dynamic.kabel-deutschland.de [95.90.237.182])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5E3FE61EA192C;
        Thu,  7 Jul 2022 23:51:51 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] lib/bitmap: Make length parameter `len` unsigned
Date:   Thu,  7 Jul 2022 23:50:52 +0200
Message-Id: <20220707215051.5664-1-pmenzel@molgen.mpg.de>
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

The length is non-negative, so make it unsigned, and adapt while
condition accordingly.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 lib/bitmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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

