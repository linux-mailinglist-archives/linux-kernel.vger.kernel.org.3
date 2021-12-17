Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B13747881A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 10:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbhLQJue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 04:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbhLQJuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 04:50:32 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C040C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 01:50:32 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id r5so1604905pgi.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 01:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rypggmWj2ZAR/qBSI7OyiNkg4p9nnMtSBFRsWhsabrA=;
        b=eMaXZ9DNADrf6LYLKFamcJVyOxhIpEzD5wgYlnNTckyKN6ED+hY8L3FhTE4y8fdsHI
         Ju3yYPhoSEroXER7y14QuqbTCrF80FPNrHtPP+Xj6TsKGEy+dc9TaqAHqapB1RGQBYnL
         FT3QVDFvHKBEoVNw+0dZjmKyY3RAPbEpfR3s+UyTmZnMiGtnj/fmP9k3tpnWwpPctkmX
         wWbGw+FOnrPXvlZF/IeVFvae6JzbTTYJzDph840A+fyfbns7UFtkehiwJz1OcitgBEWR
         ZrYRKKn4+hJJS1tJqLBcj1b8GAaqlZ1CzdmEtELhKAiBnSB7XUXy84fwa23aS0Krthsc
         sRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rypggmWj2ZAR/qBSI7OyiNkg4p9nnMtSBFRsWhsabrA=;
        b=3JTSNYQH6IAjGzXcNS2AuB+lX4XXmmLPJRVoqvRDpr8cV0pPD7hdfGHu47WDWVUhAP
         axHUnQoexveqH9CCDQ2Wd0+59cEk5XSU8k5SeeGAQjkcKeBRhpfgHdI+wzbUY1mfN5am
         6V+dIBOCQyp2NQgnvNFjd/ITsTzKcPZHolwZEYMKJ1KOoGEhyyPx13+llG8zYrC03Vbf
         JcHlBKaczzff3UCw8OHcxk7COVu4uja38jupwKmhNq6JPfQh4g3cP4nInUCbA7q/21HD
         jvNnHU+mdrfz4f6yakgdpTOL/5C8TJ0Lk6j0z4iEKD0SRMs7wGZqOaYMFgqnX10BPN9k
         s2Ow==
X-Gm-Message-State: AOAM531Tj5TBWkDkQ/BLao50U/sPG8BLqPXns6VKPJ4++4oSrVNbOJuC
        5PI0VjjTonihSAUscJdS/5uyvA==
X-Google-Smtp-Source: ABdhPJyXAe+mFABlJukIfX+yxy5iTzogn0nR/bdksiB/PzmFmpvw9Y1V/5Vxtri71v0ALhcbkADZlQ==
X-Received: by 2002:a63:f651:: with SMTP id u17mr2148049pgj.256.1639734631784;
        Fri, 17 Dec 2021 01:50:31 -0800 (PST)
Received: from C02CPFUZMD6M.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id nv12sm8759229pjb.49.2021.12.17.01.50.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Dec 2021 01:50:31 -0800 (PST)
From:   Ting Liu <liuting.0x7c00@bytedance.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, vbabka@suse.cz,
        shakeelb@google.com, willy@infradead.org, sjpark@amazon.de,
        "liuting.0x7c00" <liuting.0x7c00@bytedance.com>
Subject: [PATCH] mm: make some vars and functions static or __init
Date:   Fri, 17 Dec 2021 17:50:23 +0800
Message-Id: <20211217095023.67293-1-liuting.0x7c00@bytedance.com>
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
Signed-off-by: Ting Liu <liuting.0x7c00@bytedance.com>
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
index 6242afb24d84..eecd7221143d 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -63,12 +63,12 @@ static bool need_page_idle(void)
 {
 	return true;
 }
-struct page_ext_operations page_idle_ops = {
+static struct page_ext_operations page_idle_ops __initdata = {
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

