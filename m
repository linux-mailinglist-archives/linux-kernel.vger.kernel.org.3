Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C3C55A8B3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 12:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbiFYJtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 05:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbiFYJtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 05:49:40 -0400
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C473B393EF
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 02:49:38 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 52Q2oyvoAP8Ap52Q2oqOnW; Sat, 25 Jun 2022 11:49:36 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 25 Jun 2022 11:49:36 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/xive: Fix some incorrect memory allocation
Date:   Sat, 25 Jun 2022 11:49:31 +0200
Message-Id: <2ebb28e9de76d35b75c137f9944c2dfd893d34fa.1656150559.git.christophe.jaillet@wanadoo.fr>
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

'xibm->count' really looks like a number of bits (see how it is used in
__xive_irq_bitmap_alloc()), so use the bitmap API to allocate and free this
bitmap.

This improves semantic and potentially avoids some over memory allocation.

Fixes: eac1e731b59e ("powerpc/xive: guest exploitation of the XIVE interrupt controller")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
I don't cross compile, so this patch is NOT compile-tested.
---
 arch/powerpc/sysdev/xive/spapr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
index 7d5128676e83..fdbebb14b7de 100644
--- a/arch/powerpc/sysdev/xive/spapr.c
+++ b/arch/powerpc/sysdev/xive/spapr.c
@@ -57,7 +57,7 @@ static int __init xive_irq_bitmap_add(int base, int count)
 	spin_lock_init(&xibm->lock);
 	xibm->base = base;
 	xibm->count = count;
-	xibm->bitmap = kzalloc(xibm->count, GFP_KERNEL);
+	xibm->bitmap = bitmap_zalloc(xibm->count, GFP_KERNEL);
 	if (!xibm->bitmap) {
 		kfree(xibm);
 		return -ENOMEM;
@@ -75,7 +75,7 @@ static void xive_irq_bitmap_remove_all(void)
 
 	list_for_each_entry_safe(xibm, tmp, &xive_irq_bitmaps, list) {
 		list_del(&xibm->list);
-		kfree(xibm->bitmap);
+		bitmap_free(xibm->bitmap);
 		kfree(xibm);
 	}
 }
-- 
2.34.1

