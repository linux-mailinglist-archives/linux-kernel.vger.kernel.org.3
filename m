Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CA3479698
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 22:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhLQVyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 16:54:20 -0500
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:51006 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhLQVyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 16:54:19 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id yLB7mDo2VUGqlyLB7mEfuG; Fri, 17 Dec 2021 22:54:18 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 17 Dec 2021 22:54:18 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        maz@kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] powerpc/mpic: Use bitmap_zalloc() when applicable
Date:   Fri, 17 Dec 2021 22:54:12 +0100
Message-Id: <aa145f674e08044c98f13f1a985faa9cc29c3708.1639777976.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'mpic->protected' is a bitmap. So use 'bitmap_zalloc()' to simplify
code and improve the semantic, instead of hand writing it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/powerpc/sysdev/mpic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 995fb2ada507..626ba4a9f64f 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1323,8 +1323,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	psrc = of_get_property(mpic->node, "protected-sources", &psize);
 	if (psrc) {
 		/* Allocate a bitmap with one bit per interrupt */
-		unsigned int mapsize = BITS_TO_LONGS(intvec_top + 1);
-		mpic->protected = kcalloc(mapsize, sizeof(long), GFP_KERNEL);
+		mpic->protected = bitmap_zalloc(intvec_top + 1, GFP_KERNEL);
 		BUG_ON(mpic->protected == NULL);
 		for (i = 0; i < psize/sizeof(u32); i++) {
 			if (psrc[i] > intvec_top)
-- 
2.30.2

