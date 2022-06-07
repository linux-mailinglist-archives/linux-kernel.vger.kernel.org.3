Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D2F53F486
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 05:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbiFGDbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 23:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiFGDbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 23:31:45 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA629427E8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 20:31:43 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 0B8461E80D74;
        Tue,  7 Jun 2022 11:31:27 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VxJoDDgVzgzL; Tue,  7 Jun 2022 11:31:24 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 261341E80D55;
        Tue,  7 Jun 2022 11:31:24 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, vincenzo.frascino@arm.com
Cc:     linux@armlinux.org.uk, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] arm: create_mapping function to remove unused return values
Date:   Tue,  7 Jun 2022 11:31:22 +0800
Message-Id: <20220607033122.256388-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the return value to void to reduce eax register execution.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 arch/arm/mm/kasan_init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
index 5ad0d6c56d56..db2068329985 100644
--- a/arch/arm/mm/kasan_init.c
+++ b/arch/arm/mm/kasan_init.c
@@ -187,7 +187,7 @@ static void __init clear_pgds(unsigned long start,
 		pmd_clear(pmd_off_k(start));
 }
 
-static int __init create_mapping(void *start, void *end)
+static void __init create_mapping(void *start, void *end)
 {
 	void *shadow_start, *shadow_end;
 
@@ -199,7 +199,6 @@ static int __init create_mapping(void *start, void *end)
 
 	kasan_pgd_populate((unsigned long)shadow_start & PAGE_MASK,
 			   PAGE_ALIGN((unsigned long)shadow_end), false);
-	return 0;
 }
 
 void __init kasan_init(void)
-- 
2.18.2

