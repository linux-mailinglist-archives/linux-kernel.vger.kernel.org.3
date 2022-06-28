Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A2E55E11D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344190AbiF1JYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344189AbiF1JYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:24:05 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF47021E2D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:23:57 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 23so11622730pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vHYbuFYn6YlvT9Fdnx+EOgau5cAMH353uP8QsaR7HRc=;
        b=0nmaiILBL0Ishd8eJaNF98NYu3O4qdMxGBddKMrRd4lKI3pIXG2GNpFNO291L209NS
         ENsmr/FnVypwU6JuPmk8nxqdIYeX+7CSw8NXSCcpP1ppbnISwIxJ2POPJAsC6DTq8Esg
         Zs1H9dPG/lWkPaeYDBgoVc7YB/Cj4gQO0vl1Jcfp+ZHzJ7EAe8lD72i4dIS0TXtUIWAO
         Yzzg7jCU8Z0VPJmoXsGyQYF/6pGl6tpzJieZLxGcc7sl/gks2UHfYQxk9u/t8E6MTJv1
         mzR4QNWxJDeNdOI8ldEEWIt2h0L1Ot3uduS//eR0kMfCVNqSeByotggZxNMD+gp5Ik3H
         mUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vHYbuFYn6YlvT9Fdnx+EOgau5cAMH353uP8QsaR7HRc=;
        b=LVB5NiUXj1ZZWkxkhlNG0a6P1atAqz33/9hVM1qwvdya6uEsGdNbQ9Gx9qMWFRwvWg
         2XosLKwSa2A3lzKP3o0XmEoG7PN5dQ8X1ANh8atSZcdDdegSpopOuhTZpipYi+bfVyy3
         pOng0jM6wKHyFCMyCek6XVXnG2hs+52pY9+EFbgtqX4IT0/Udhghc7gkOg1lKttfD0yW
         CzUkrD/VBYaKpV0Hlm9FD7TnINfX30Pzc64jyX7Hnny1/gs1S2Pgg+HzJrEs8eZYwNZF
         H+3YqEIlwLGL4KeLHaAlqBqdVpJn24+Y18YnLeX6cmZNBhu0l31Kq32XFzIRk7Fv2YTV
         rXxw==
X-Gm-Message-State: AJIora+jEkpu3v3+DSKhlTqvkgxL75+Mdh9YPUwPOyl9T31Pep3JNYKz
        OhNihCY6GRNbWVDBYxn8jmBBsA==
X-Google-Smtp-Source: AGRyM1s6QKp3YFjgnn8w5wpZ4YzfRjz+2CBC2gen+rq5Ge2yaCfXPCuQ2lsG85yC5I4qOXZwEMrYdQ==
X-Received: by 2002:a63:7c49:0:b0:40c:b3f9:18c5 with SMTP id l9-20020a637c49000000b0040cb3f918c5mr16240298pgn.588.1656408237450;
        Tue, 28 Jun 2022 02:23:57 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id mm9-20020a17090b358900b001ec729d4f08sm8780463pjb.54.2022.06.28.02.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 02:23:57 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, corbet@lwn.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 2/8] mm: hugetlb_vmemmap: optimize vmemmap_optimize_mode handling
Date:   Tue, 28 Jun 2022 17:22:29 +0800
Message-Id: <20220628092235.91270-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220628092235.91270-1-songmuchun@bytedance.com>
References: <20220628092235.91270-1-songmuchun@bytedance.com>
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
PageVmemmapSelfHosted.  Therefore, we could simplify
vmemmap_optimize_mode handling by not holding an another reference
to hugetlb_optimize_vmemmap_key.  This also means that we not
incur the extra page_fixed_fake_head checks if there are no
vmemmap optinmized hugetlb pages after this change.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/page-flags.h |  6 ++---
 mm/hugetlb_vmemmap.c       | 65 +++++-----------------------------------------
 2 files changed, 9 insertions(+), 62 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 2455405ab82b..b44cc24d7496 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -205,8 +205,7 @@ enum pageflags {
 #ifndef __GENERATING_BOUNDS_H
 
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
-DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
-			 hugetlb_optimize_vmemmap_key);
+DECLARE_STATIC_KEY_FALSE(hugetlb_optimize_vmemmap_key);
 
 /*
  * If the feature of optimizing vmemmap pages associated with each HugeTLB
@@ -226,8 +225,7 @@ DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
  */
 static __always_inline const struct page *page_fixed_fake_head(const struct page *page)
 {
-	if (!static_branch_maybe(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
-				 &hugetlb_optimize_vmemmap_key))
+	if (!static_branch_unlikely(&hugetlb_optimize_vmemmap_key))
 		return page;
 
 	/*
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 6d9801bb3fec..0c2f15a35d62 100644
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
 
@@ -100,7 +73,7 @@ int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
 static unsigned int vmemmap_optimizable_pages(struct hstate *h,
 					      struct page *head)
 {
-	if (READ_ONCE(vmemmap_optimize_mode) == VMEMMAP_OPTIMIZE_OFF)
+	if (!READ_ONCE(vmemmap_optimize_enabled))
 		return 0;
 
 	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG)) {
@@ -191,7 +164,6 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 
 	if (!is_power_of_2(sizeof(struct page))) {
 		pr_warn_once("cannot optimize vmemmap pages because \"struct page\" crosses page boundaries\n");
-		static_branch_disable(&hugetlb_optimize_vmemmap_key);
 		return;
 	}
 
@@ -212,36 +184,13 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
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

