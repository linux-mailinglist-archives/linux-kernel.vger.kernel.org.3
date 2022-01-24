Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE864985CB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241369AbiAXRGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:06:05 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48234 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbiAXRGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:06:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D21A86119C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 17:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F29C340E5;
        Mon, 24 Jan 2022 17:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643043963;
        bh=O07YupI0AYFRjtSwOnJ9QeNbZU+KNz5x1PyE7VbLSf0=;
        h=From:To:Cc:Subject:Date:From;
        b=K7n6xytunBbkNMCJaMqlcZj9uy7ls2UstQ5fHGNbEudbEhI3P29m/dwJaewtzfLVS
         XfN/sDpmYTsLj0YGdA1UO9SbHUx85uYEuDYVqCt+eYHeEXvBGo06XYVdXi6clnAVuz
         0MsqcvkD5aGlylJZn8rMeXrPn8wQQ9qfe3nPQhPd2toUiZNLHL/EoEqMkduw7bIPVV
         ERZSxup31rgdRLrs38BDsbgFFh2RmDqPfegT1aOR9SAZCaIKGJEJSctL492W225sWV
         596Y5XE72YBbCHZfAMZtZZrJIrADvRAd8s4CW9TeTpZmaoZbgEAKi7i++Eox6hnszC
         GG3TDjeB8WGhg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] mm: make 'highmem' symbol ro_after_init
Date:   Mon, 24 Jan 2022 18:05:55 +0100
Message-Id: <20220124170555.1054480-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=681; h=from:subject; bh=O07YupI0AYFRjtSwOnJ9QeNbZU+KNz5x1PyE7VbLSf0=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7txyo6jtAOHE1+I/AryJ5nBk6LIn5EsN1sXih4M7 6mXsP4uJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7ccgAKCRDDTyI5ktmPJLE6DA Cj8IaD/hrKBzzk677LeV6tdJ0ILJ+6Z11g2KScQQ6C17ylXBopOKja1jePt4SduhtEcxZIfAHa6Ife zqPAssSTdAGWbfaCK7H7I0zAuXWa+1vqHiQQAsm0qKRj6mHbxxd5CaY12emXBbTFL2z90F5e1sm3W0 qkVW+Lfbv2RbSani3z8s1aGueI8mho/RqUnCeNHnhitStWXYmwrZRC98GBvI5cs9ataIz3EGjMbVet Qh06GAllexN7thblDw7uKX+81o23lX+4HmgBN7nEkhwyX8sn5u2P4Bzmchrb7WBWlK/ectQDyDCB+p 4P4CpGX0oGfVBoz02dxYbAWEIxj/D4AOv+zxf8DDIElpO9omdSSVSfNlSl6qEECDJWAhlW6ZHP9nHj HhLNkc4N3eJH5zu2S1SGj+wS8mw8c3QwopCKfSJ82CxLJMwAEPnFbr+15YsUqqYirRtGhmAokBV3ro mgOW5LJxJdV5vRbpaZ1XkitR5HjqBo0lnXFaBcvL1jBCQ=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'highmem' variable is only set at boot, so we can make it
ro_after_init and prevent it from being corrupted inadvertently, or from
ending up in a contended cacheline.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index c125c4969913..50e82cb94ccc 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -106,7 +106,7 @@ EXPORT_SYMBOL(mem_map);
  * highstart_pfn must be the same; there must be no gap between ZONE_NORMAL
  * and ZONE_HIGHMEM.
  */
-void *high_memory;
+void *high_memory __ro_after_init;
 EXPORT_SYMBOL(high_memory);
 
 /*
-- 
2.30.2

