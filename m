Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369EA547F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 08:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbiFMGfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 02:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiFMGfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 02:35:36 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AD3B872
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:35:35 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d5so1693448plo.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XLBHCSl3x40n/JirLCrBjaqZu+zJJs2ufPMKi7d2Sww=;
        b=oyts69b4avBW6IfgVF+4QpgyMTlLyDvTK8H8cgqFmeMxrl7bKHSPH0QcLfPSUXkpFx
         nvC3JmFuxzPBTZ08riXpF3Hnn0WwSf0Xz5YoNlEhowi0FwIsSdFz3JNWmEg73Mu8zFZL
         yTHQ74HZI/9sqE+udr02AltX1Wk3vQDAL+J9nK9PLL2UcKGGnsTrwzNPqPTZC0uucGgB
         SIfPr0Zg0Vv+ShY5B1ecsFgDlSe6swxvd7QQA3/qQk0QLSHfPE2ri/ZSGcRQNsI0mcpp
         c9v+ELelY0gKRbnsL7BJ+AN8XbTC/qE5w/gmOik/HPgrmqeYOvTpOOBkPbC19WeXC67S
         4ytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XLBHCSl3x40n/JirLCrBjaqZu+zJJs2ufPMKi7d2Sww=;
        b=YKKzBrnp+ozgzo8UK+O3XUhTNuFYxBEKiuPewxd20eq9t07poWRE+37k+fDKpn7ePY
         /6fsm5c2E4KskY9CHlRKCiGPKSimqU5nBrgoQz39tIbh/43C1GybJLGHoE81tn6u43Aw
         pS49GXZEeguDevx0nioJ+6/EFqbkFIuoKwg/8enZuJvjHvBL+r4REbjCQkImHkpBu+1I
         l2lBAqrVbYYGmLUSlAEGPeL3et0Erxce9pPyNjf3s2zIJR0wZ0fRCjbwUgWJ2DrFN1MN
         +5Q8kbaF0RAXAoJLoL6OoqcurqaEtB0ifsKFEiV6TUB2pac7TTyTlTkEuG5vUiuOiGxO
         O0cQ==
X-Gm-Message-State: AOAM532PPWPo43z7en4rFdJw0SR/tK/zZ6jthjLhRzGaitD+X+V1Lpd6
        o8jZkUGdeFgWek9tagtWEgl4Sg==
X-Google-Smtp-Source: ABdhPJxCusXzGwHuisl+klFQ+x+A+Evfz+qDo9pEo1G3bTqjCJLS5ohmbbAPHwTAHuGVHxld3Y5Wog==
X-Received: by 2002:a17:902:e742:b0:166:4d34:3be8 with SMTP id p2-20020a170902e74200b001664d343be8mr53370044plf.140.1655102135058;
        Sun, 12 Jun 2022 23:35:35 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id v3-20020aa799c3000000b0051bc538baadsm4366554pfi.184.2022.06.12.23.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 23:35:34 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, corbet@lwn.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 2/6] mm: hugetlb_vmemmap: optimize vmemmap_optimize_mode handling
Date:   Mon, 13 Jun 2022 14:35:08 +0800
Message-Id: <20220613063512.17540-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220613063512.17540-1-songmuchun@bytedance.com>
References: <20220613063512.17540-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We hold an another reference to hugetlb_optimize_vmemmap_key when
making vmemmap_optimize_mode on, because we use static_key to tell
memory_hotplug that memory_hotplug.memmap_on_memory should be
overridden.  However, this rule has gone when we have introduced
SECTION_CANNOT_OPTIMIZE_VMEMMAP.  Therefore, we could simplify
vmemmap_optimize_mode handling by not holding an another reference
to hugetlb_optimize_vmemmap_key.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/page-flags.h |  6 ++---
 mm/hugetlb_vmemmap.c       | 65 +++++-----------------------------------------
 2 files changed, 9 insertions(+), 62 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index b8b992cb201c..da7ccc3b16ad 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -200,8 +200,7 @@ enum pageflags {
 #ifndef __GENERATING_BOUNDS_H
 
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
-DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
-			 hugetlb_optimize_vmemmap_key);
+DECLARE_STATIC_KEY_FALSE(hugetlb_optimize_vmemmap_key);
 
 /*
  * If the feature of optimizing vmemmap pages associated with each HugeTLB
@@ -221,8 +220,7 @@ DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
  */
 static __always_inline const struct page *page_fixed_fake_head(const struct page *page)
 {
-	if (!static_branch_maybe(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
-				 &hugetlb_optimize_vmemmap_key))
+	if (!static_branch_unlikely(&hugetlb_optimize_vmemmap_key))
 		return page;
 
 	/*
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index e20a7082f2f8..132dc83f0130 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -23,42 +23,15 @@
 #define RESERVE_VMEMMAP_NR		1U
 #define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
 
-enum vmemmap_optimize_mode {
-	VMEMMAP_OPTIMIZE_OFF,
-	VMEMMAP_OPTIMIZE_ON,
-};
-
-DEFINE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
-			hugetlb_optimize_vmemmap_key);
+DEFINE_STATIC_KEY_FALSE(hugetlb_optimize_vmemmap_key);
 EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
 
-static enum vmemmap_optimize_mode vmemmap_optimize_mode =
+static bool vmemmap_optimize_enabled =
 	IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON);
 
-static void vmemmap_optimize_mode_switch(enum vmemmap_optimize_mode to)
-{
-	if (vmemmap_optimize_mode == to)
-		return;
-
-	if (to == VMEMMAP_OPTIMIZE_OFF)
-		static_branch_dec(&hugetlb_optimize_vmemmap_key);
-	else
-		static_branch_inc(&hugetlb_optimize_vmemmap_key);
-	WRITE_ONCE(vmemmap_optimize_mode, to);
-}
-
 static int __init hugetlb_vmemmap_early_param(char *buf)
 {
-	bool enable;
-	enum vmemmap_optimize_mode mode;
-
-	if (kstrtobool(buf, &enable))
-		return -EINVAL;
-
-	mode = enable ? VMEMMAP_OPTIMIZE_ON : VMEMMAP_OPTIMIZE_OFF;
-	vmemmap_optimize_mode_switch(mode);
-
-	return 0;
+	return kstrtobool(buf, &vmemmap_optimize_enabled);
 }
 early_param("hugetlb_free_vmemmap", hugetlb_vmemmap_early_param);
 
@@ -103,7 +76,7 @@ static unsigned int optimizable_vmemmap_pages(struct hstate *h,
 	unsigned long pfn = page_to_pfn(head);
 	unsigned long end = pfn + pages_per_huge_page(h);
 
-	if (READ_ONCE(vmemmap_optimize_mode) == VMEMMAP_OPTIMIZE_OFF)
+	if (!READ_ONCE(vmemmap_optimize_enabled))
 		return 0;
 
 	for (; pfn < end; pfn += PAGES_PER_SECTION) {
@@ -155,7 +128,6 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 
 	if (!is_power_of_2(sizeof(struct page))) {
 		pr_warn_once("cannot optimize vmemmap pages because \"struct page\" crosses page boundaries\n");
-		static_branch_disable(&hugetlb_optimize_vmemmap_key);
 		return;
 	}
 
@@ -176,36 +148,13 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 }
 
 #ifdef CONFIG_PROC_SYSCTL
-static int hugetlb_optimize_vmemmap_handler(struct ctl_table *table, int write,
-					    void *buffer, size_t *length,
-					    loff_t *ppos)
-{
-	int ret;
-	enum vmemmap_optimize_mode mode;
-	static DEFINE_MUTEX(sysctl_mutex);
-
-	if (write && !capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
-	mutex_lock(&sysctl_mutex);
-	mode = vmemmap_optimize_mode;
-	table->data = &mode;
-	ret = proc_dointvec_minmax(table, write, buffer, length, ppos);
-	if (write && !ret)
-		vmemmap_optimize_mode_switch(mode);
-	mutex_unlock(&sysctl_mutex);
-
-	return ret;
-}
-
 static struct ctl_table hugetlb_vmemmap_sysctls[] = {
 	{
 		.procname	= "hugetlb_optimize_vmemmap",
-		.maxlen		= sizeof(enum vmemmap_optimize_mode),
+		.data		= &vmemmap_optimize_enabled,
+		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= hugetlb_optimize_vmemmap_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.proc_handler	= proc_dobool,
 	},
 	{ }
 };
-- 
2.11.0

