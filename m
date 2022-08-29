Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253475A4354
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 08:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiH2GfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 02:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiH2GfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 02:35:17 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA67B1275F
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 23:35:13 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.41:33464.1972940701
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id 440CB1002B3;
        Mon, 29 Aug 2022 14:35:11 +0800 (CST)
Received: from  ([123.150.8.42])
        by gateway-153622-dep-84fc4d489d-ngzxf with ESMTP id f15f6262ff3f481d8b2da43890107d73 for karolinadrobnik@gmail.com;
        Mon, 29 Aug 2022 14:35:12 CST
X-Transaction-ID: f15f6262ff3f481d8b2da43890107d73
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     karolinadrobnik@gmail.com, rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Song Chen <chensong_2000@189.cn>
Subject: [PATCH 1/2] tools/libs/slab.c: fix compiling mistakes of uatomic_inc/uatomic_dec
Date:   Mon, 29 Aug 2022 14:38:41 +0800
Message-Id: <1661755121-3286-1-git-send-email-chensong_2000@189.cn>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to build tools/test/memblock and got such message:

/usr/bin/ld: slab.o: in function `kmalloc':
slab.c:(.text+0x2b): undefined reference to `uatomic_inc'
/usr/bin/ld: slab.o: in function `kfree':
slab.c:(.text+0x97): undefined reference to `uatomic_dec'
collect2: error: ld returned 1 exit status

I could find any definition or inplememtation of uatomic_inc/uatomic_dec
in anywhere of the code base. So I use atomic_inc/atomic_dec_and_test
to replace like other tests underneath tools/test, it works.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 tools/lib/slab.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/slab.c b/tools/lib/slab.c
index 959997fb0652..8a5a8d536e35 100644
--- a/tools/lib/slab.c
+++ b/tools/lib/slab.c
@@ -3,7 +3,7 @@
 #include <stdio.h>
 #include <string.h>
 
-#include <urcu/uatomic.h>
+#include <linux/atomic.h>
 #include <linux/slab.h>
 #include <malloc.h>
 #include <linux/gfp.h>
@@ -19,7 +19,7 @@ void *kmalloc(size_t size, gfp_t gfp)
 		return NULL;
 
 	ret = malloc(size);
-	uatomic_inc(&kmalloc_nr_allocated);
+	atomic_inc(&kmalloc_nr_allocated);
 	if (kmalloc_verbose)
 		printf("Allocating %p from malloc\n", ret);
 	if (gfp & __GFP_ZERO)
@@ -31,7 +31,7 @@ void kfree(void *p)
 {
 	if (!p)
 		return;
-	uatomic_dec(&kmalloc_nr_allocated);
+	atomic_dec_and_test(&kmalloc_nr_allocated);
 	if (kmalloc_verbose)
 		printf("Freeing %p to malloc\n", p);
 	free(p);
-- 
2.25.1

