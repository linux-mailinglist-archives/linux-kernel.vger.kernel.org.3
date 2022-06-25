Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0079555A7C8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 09:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiFYHkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 03:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbiFYHki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 03:40:38 -0400
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE0A4579A
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 00:40:36 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 50PBoAAE5xzw250PBoeVPs; Sat, 25 Jun 2022 09:40:34 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 25 Jun 2022 09:40:34 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-sh@vger.kernel.org
Subject: [PATCH] sh: sq: Use the bitmap API when applicable
Date:   Sat, 25 Jun 2022 09:40:31 +0200
Message-Id: <521788e22ad8f7a5058c154f068b061525321841.1656142814.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the bitmap API is less verbose than hand writing them.
It also improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
I don't cross compile, so this patch is NOT compile-tested.
---
 arch/sh/kernel/cpu/sh4/sq.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
index a76b94e41e91..c3101427d9a9 100644
--- a/arch/sh/kernel/cpu/sh4/sq.c
+++ b/arch/sh/kernel/cpu/sh4/sq.c
@@ -372,7 +372,6 @@ static struct subsys_interface sq_interface = {
 static int __init sq_api_init(void)
 {
 	unsigned int nr_pages = 0x04000000 >> PAGE_SHIFT;
-	unsigned int size = (nr_pages + (BITS_PER_LONG - 1)) / BITS_PER_LONG;
 	int ret = -ENOMEM;
 
 	printk(KERN_NOTICE "sq: Registering store queue API.\n");
@@ -382,7 +381,7 @@ static int __init sq_api_init(void)
 	if (unlikely(!sq_cache))
 		return ret;
 
-	sq_bitmap = kzalloc(size, GFP_KERNEL);
+	sq_bitmap = bitmap_zalloc(nr_pages, GFP_KERNEL);
 	if (unlikely(!sq_bitmap))
 		goto out;
 
@@ -393,7 +392,7 @@ static int __init sq_api_init(void)
 	return 0;
 
 out:
-	kfree(sq_bitmap);
+	bitmap_free(sq_bitmap);
 	kmem_cache_destroy(sq_cache);
 
 	return ret;
@@ -402,7 +401,7 @@ static int __init sq_api_init(void)
 static void __exit sq_api_exit(void)
 {
 	subsys_interface_unregister(&sq_interface);
-	kfree(sq_bitmap);
+	bitmap_free(sq_bitmap);
 	kmem_cache_destroy(sq_cache);
 }
 
-- 
2.34.1

