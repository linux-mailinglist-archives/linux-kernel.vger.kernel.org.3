Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801BC588784
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237249AbiHCGlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbiHCGlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:41:31 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1401A39BBC
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 23:41:29 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id A0B491E80D25;
        Wed,  3 Aug 2022 14:40:37 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cWoKKGcMRh8W; Wed,  3 Aug 2022 14:40:35 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 039B71E80CEA;
        Wed,  3 Aug 2022 14:40:35 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] page_alloc: remove inactive initialization
Date:   Wed,  3 Aug 2022 14:41:18 +0800
Message-Id: <20220803064118.3664-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The allocation address of the table pointer variable is first performed
in the function, no initialization assignment is required, and no
invalid pointer will appear.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b0bcab50f0a3..38d559e8aee6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8885,7 +8885,7 @@ void *__init alloc_large_system_hash(const char *tablename,
 {
 	unsigned long long max = high_limit;
 	unsigned long log2qty, size;
-	void *table = NULL;
+	void *table;
 	gfp_t gfp_flags;
 	bool virt;
 	bool huge;
-- 
2.18.2

