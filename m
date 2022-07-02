Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE76564214
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 20:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbiGBS3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 14:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbiGBS3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 14:29:49 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C69DED2
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 11:29:48 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 7hsIoTjZy4Ltq7hsIonixx; Sat, 02 Jul 2022 20:29:46 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 02 Jul 2022 20:29:46 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        vneethv@linux.ibm.com, oberpar@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        almaz.alexandrovich@paragon-software.com, yury.norov@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk
Cc:     linux-s390@vger.kernel.org, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 4/4] bitmap: Use bitmap_size()
Date:   Sat,  2 Jul 2022 20:29:44 +0200
Message-Id: <a1d240070b58addae91aef9912925835ff09122d.1656785856.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1656785856.git.christophe.jaillet@wanadoo.fr>
References: <cover.1656785856.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify code and take advantage of the new bitmap_size() function.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 include/linux/bitmap.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index f66fb98a4126..668b47c1e5de 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -243,21 +243,18 @@ extern int bitmap_print_list_to_buf(char *buf, const unsigned long *maskp,
 
 static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
 {
-	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
-	memset(dst, 0, len);
+	memset(dst, 0, bitmap_size(nbits));
 }
 
 static inline void bitmap_fill(unsigned long *dst, unsigned int nbits)
 {
-	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
-	memset(dst, 0xff, len);
+	memset(dst, 0xff, bitmap_size(nbits));
 }
 
 static inline void bitmap_copy(unsigned long *dst, const unsigned long *src,
 			unsigned int nbits)
 {
-	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
-	memcpy(dst, src, len);
+	memcpy(dst, src, bitmap_size(nbits));
 }
 
 /*
-- 
2.34.1

