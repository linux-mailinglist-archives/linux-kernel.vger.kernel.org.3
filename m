Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81D3475211
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 06:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbhLOF1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 00:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbhLOF1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 00:27:01 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A984DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 21:27:01 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id h24so16351158pjq.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 21:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EATF0++rhQQhxWqPyfU2MMj4vBgI3dJhEYF3haLw1w4=;
        b=bTiDndqWZQ7vtoDIvJRvbcIGF2mcynmMfSDxN9wrBBT8TISsHXtThVK23jl+JgQRrp
         lWnEW4CgcVRJ/3PfopBSA8XCl9WAoEZfEq9nnMDbkNpatBJRwSY5239O3arnteUjkzW2
         D6CFA4q39MBrxOaXJ7pQirg1auy46uHuACr6t+p/81gJLI2Cnos6HsVwHzXssENFEHlF
         R6kyaf7bUS1FcSPFY5CxtMBZ/SnTpiqWRyGMTFFE7kIvfKS053DGYkDHsrCGWyHvmWU1
         MOvyoPsBFuxNefkgcdfHYRy1KiLyqTaaBQu+hoq3jc0jOPFnADd2dIPlmxBZD5vM1g+g
         5krQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EATF0++rhQQhxWqPyfU2MMj4vBgI3dJhEYF3haLw1w4=;
        b=v+ASXOjU7TvQ0BVHXpRjiHCSTBUcbiXrjZr+tOG7SsKE5nVHVxzkCgXY9tDdzKg/UQ
         gtLQswzVnEitJ4vjmQE2g4Ks68LBfiN9bENcSHfB7ZsNJ7zZ60xuSYDJCsJIiRu1Vore
         LJbMlciUGoBqM7t3QhEyDee4YodjksEHMP8suFO0On4h7wJCnMey7HRm4jzeZ4f19hVc
         sViVip0Rj6C9j0JB+qE6WiMkFOXa2zHUWkDgocNYoL8phSSyOw6qTTSoaiuCzyfFkOu5
         glKZIfA5aLBCaUoqR+kMpkya6eVxpeUEBssOCSu1r0sPdSL3YIXrZvCnq24GW80W6a4U
         9jyw==
X-Gm-Message-State: AOAM533rViDalRKYukjKZq/avPjEvgG/yC3dvPoOvccijzSucjqHxzr1
        cpSuh1Q+321gOIPygj9sAcGkwg==
X-Google-Smtp-Source: ABdhPJwApHB7bNNx5kaM60v3MqQT5kLfa+h8WBVe0vHIwtGhzbJjlTgBNz0jwrvYru+c6nmuZKYyQA==
X-Received: by 2002:a17:90b:1810:: with SMTP id lw16mr6687286pjb.129.1639546021207;
        Tue, 14 Dec 2021 21:27:01 -0800 (PST)
Received: from C02CPFUZMD6M.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id ns21sm3853367pjb.37.2021.12.14.21.26.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Dec 2021 21:27:00 -0800 (PST)
From:   Ting Liu <liuting.0x7c00@bytedance.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, vbabka@suse.cz,
        shakeelb@google.com, willy@infradead.org, sjpark@amazon.de,
        liuting.0x7c00@bytedance.com
Subject: [PATCH] mm: make some vars and functions static or __init
Date:   Wed, 15 Dec 2021 13:26:51 +0800
Message-Id: <20211215052651.89544-1-liuting.0x7c00@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "liuting.0x7c00" <liuting.0x7c00@bytedance.com>

"page_idle_ops" as a global var, but its scope of use within this
document. So it should be static.
"page_ext_ops" is a var used in the kernel initial phase. And other
functions are aslo used in the kernel initial phase. So they should be
__init or __initdata to reclaim memory.

Signed-off-by: liuting.0x7c00 <liuting.0x7c00@bytedance.com>
---
 include/linux/page_idle.h | 1 -
 mm/page_ext.c             | 4 ++--
 mm/page_owner.c           | 4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/page_idle.h b/include/linux/page_idle.h
index 83abf95e9fa7..4663dfed1293 100644
--- a/include/linux/page_idle.h
+++ b/include/linux/page_idle.h
@@ -13,7 +13,6 @@
  * If there is not enough space to store Idle and Young bits in page flags, use
  * page ext flags instead.
  */
-extern struct page_ext_operations page_idle_ops;
 
 static inline bool folio_test_young(struct folio *folio)
 {
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 6242afb24d84..2193e3f10e56 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -63,12 +63,12 @@ static bool need_page_idle(void)
 {
 	return true;
 }
-struct page_ext_operations page_idle_ops = {
+static struct page_ext_operations page_idle_ops = {
 	.need = need_page_idle,
 };
 #endif
 
-static struct page_ext_operations *page_ext_ops[] = {
+static struct page_ext_operations *page_ext_ops[] __initdata = {
 #ifdef CONFIG_PAGE_OWNER
 	&page_owner_ops,
 #endif
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 4f924957ce7a..5eea061bb1e5 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -46,7 +46,7 @@ static int __init early_page_owner_param(char *buf)
 }
 early_param("page_owner", early_page_owner_param);
 
-static bool need_page_owner(void)
+static __init bool need_page_owner(void)
 {
 	return page_owner_enabled;
 }
@@ -75,7 +75,7 @@ static noinline void register_early_stack(void)
 	early_handle = create_dummy_stack();
 }
 
-static void init_page_owner(void)
+static __init void init_page_owner(void)
 {
 	if (!page_owner_enabled)
 		return;
-- 
2.20.1

