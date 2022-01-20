Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2C84954A9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 20:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377439AbiATTNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 14:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377410AbiATTM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 14:12:57 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE16AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 11:12:56 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id o9so3795253qvy.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 11:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/lrhieXAQjpkgK4+rimVAixmRMROqE/GcACBpp2RziA=;
        b=DVbJt984cdsTf0nLyL0gU+CRPeI6csgRuWb0tYVjhrI1WKObUvjWiJH3vkiFqxeXv6
         DGDPkwoRX5AKCXqVNns18Tl1MheshVE0QOVPsw+a5azPgWxiRQlnp8toELV+g+0koCpD
         EXmmlh0mVnvWi3Bd9TaiLKo1E++CJb2OBDNan93i7tO9ODFWsRVISd8blF1c+C7BZqOW
         AcM5kBPI9Zta1hy4wePoAnTjZ7kNNY6TJp538BwMkMc3Yl49am02dp6618Wso6ozgF4e
         4+Ri0un9Nw1/L0A2LhfqJ+KCGA9Tr3cym3CSlFBCIMGmaGB091V2I7z7tPgcXu1I+DM2
         3lzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/lrhieXAQjpkgK4+rimVAixmRMROqE/GcACBpp2RziA=;
        b=nHAiu123IKe+mkR4QoxPSaUr5L9cOz6fWOh5Bii7Cmi1ynrdmenrpb4z4u34uvtxEp
         BrsryLGISAVdMtCTZHq88JUgGltIz6XUL21nod2Hv7GrSyaTrbBfi/telnRgdb1qnJXO
         nO6SIbjqP63tRI0lUTaQBaZWnQ7Fjo633GlzypnqQQtswwuVHQ4U3yoL3xHy5L3cXnAc
         sqO9Nv/WDbErdGEKzMxsIG+JmbqtWc/rcjRoScZcZ1Ycdq4QL1KZiaQUqtipdKdBxPY1
         ks9dxprjtzyLYbhvpEoZAki1e0zdzkAGVRC3lu14ahpDoQqoguuXMfREnGU1WFMYe+Ub
         RngA==
X-Gm-Message-State: AOAM531pTsmh9AITRO6QuC6I2L3LO1GFXHv2+PhHV4RACRmC1V/lhBu+
        qm0787hjvmQ+FA83Eh3b3geB8A==
X-Google-Smtp-Source: ABdhPJzX9ogZQNd0p5asU4lyl7+h+DwhcECJON4g0QSGJOOD4M1nujIMQK+391N6XK1gOndyju7qjQ==
X-Received: by 2002:a05:6214:2428:: with SMTP id gy8mr359142qvb.117.1642705975967;
        Thu, 20 Jan 2022 11:12:55 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id w1sm1822509qko.40.2022.01.20.11.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 11:12:55 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, rientjes@google.com,
        pjt@google.com, weixugc@google.com, gthelen@google.com,
        mingo@redhat.com, will@kernel.org, rppt@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com, hughd@google.com,
        ziy@nvidia.com, anshuman.khandual@arm.com
Subject: [PATCH v2 3/3] mm/page_table_check: use unsigned long for page counters
Date:   Thu, 20 Jan 2022 19:12:50 +0000
Message-Id: <20220120191250.2671557-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
In-Reply-To: <20220120191250.2671557-1-pasha.tatashin@soleen.com>
References: <20220120191250.2671557-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the consistency, use "unsigned long" for all page counters.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Wei Xu <weixugc@google.com>
---
 mm/page_table_check.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 877d967742bc..f1db4de8bed2 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -86,8 +86,8 @@ static void page_table_check_clear(struct mm_struct *mm, unsigned long addr,
 {
 	struct page_ext *page_ext;
 	struct page *page;
+	unsigned long i;
 	bool anon;
-	int i;
 
 	if (!pfn_valid(pfn))
 		return;
@@ -121,8 +121,8 @@ static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
 {
 	struct page_ext *page_ext;
 	struct page *page;
+	unsigned long i;
 	bool anon;
-	int i;
 
 	if (!pfn_valid(pfn))
 		return;
@@ -176,10 +176,10 @@ static void pmd_clear_level(struct mm_struct *mm, unsigned long addr,
 void __page_table_check_zero(struct page *page, unsigned int order)
 {
 	struct page_ext *page_ext = lookup_page_ext(page);
-	int i;
+	unsigned long i;
 
 	BUG_ON(!page_ext);
-	for (i = 0; i < (1 << order); i++) {
+	for (i = 0; i < (1ul << order); i++) {
 		struct page_table_check *ptc = get_page_table_check(page_ext);
 
 		BUG_ON(atomic_read(&ptc->anon_map_count));
-- 
2.34.1.703.g22d0c6ccf7-goog

