Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDD64D9A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 12:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346301AbiCOLuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 07:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235597AbiCOLuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 07:50:08 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1065246B3D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 04:48:56 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mr24-20020a17090b239800b001bf0a375440so2054529pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 04:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZqgQrWW9h8EA9ThxRZG5uSYD0/VFUVnqeaBjtQ/fiog=;
        b=H3lf9PYnNQ/mMrla7WKPf/Jgd4iBVY0u19a2rKEzVP8bMFQr5kNDf40lnGoos9UiQK
         Wg7PJ0OSZFaDIE95IEY0fp9rkqH7C7Wv1nNtXomC4/oGNZCUNlkky/r6bWZ+LVveZyJC
         wewieciGs/G3B+iG9LTU0TU+WPnwdihhYxVauD+3d5U2M7KeO6s5viUvgjGz5Qrsz5n7
         sLpHrxCnxBe4nWu2cExSIrzuKK9NFFT5haz3BB5+BkGC3UlajZJVTtpiXt3DHYAkSYZc
         llTUQcDeSwbC3+QYIj53FQ9LUybCkdJA5l9WoQBkLa1N0dXahz9hs2pMMGd7G8a7Lmgw
         cdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZqgQrWW9h8EA9ThxRZG5uSYD0/VFUVnqeaBjtQ/fiog=;
        b=q1Whpp8WLNoEnp19UlxOBB66Ol49VNPnfOzcpFrg8nEuMW2NS7B5i20C0fyCQ3TZ0B
         EbSCv0rA+xTXSj8ktl0YLTdCuk2wBz5omFsgrnDKy8tDG+ykWvEJQMybG2xurobAHa3s
         k0gFzTz4zYVIMhFu1h3TiR7Vu0cDbzqJBzlDBNwbgY/sgXmTKe45xPJtdHgSe84eL+Sl
         E+/i8B0aa5t/vN9hMgnvklYpJM7qDlTLMmvc0x7F6OWRmGp2RO8Rkvls+2oWkBoffKWr
         qofX8izl1jiZA/uIO0V7lZDOnV9sb5mV5yjUueXw+YmXlK2ma1yI8/GHctyAJs7ZoiN6
         49Kg==
X-Gm-Message-State: AOAM532AwugRhJ/1gY5u0ozWH1QUhPF2cyLmoOAkujhySkQa8N2ItrqG
        D3LvaFHd5XjafOYkLXHnhJU=
X-Google-Smtp-Source: ABdhPJzfwMdkLjsT8RF8fJRStDWH5MpVCMN8duoELf//ldmmvYGpibhYFDpUazLmTITItGx02cfi2w==
X-Received: by 2002:a17:90a:4f0b:b0:1be:e31f:bd38 with SMTP id p11-20020a17090a4f0b00b001bee31fbd38mr4216688pjh.76.1647344935490;
        Tue, 15 Mar 2022 04:48:55 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q4-20020a056a00150400b004f78d4821a0sm16414921pfu.204.2022.03.15.04.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 04:48:55 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     lkp@intel.com
Cc:     akpm@linux-foundation.org, bristot@redhat.com, cgel.zte@gmail.com,
        juri.lelli@redhat.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com,
        peterz@infradead.org, xu.xin16@zte.com.cn,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v2] ksm: Count ksm merging pages for each process
Date:   Tue, 15 Mar 2022 11:48:49 +0000
Message-Id: <20220315114849.2119443-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202203150131.oDjproo7-lkp@intel.com>
References: <202203150131.oDjproo7-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

As current KSM only counts the number of KSM merging pages(e.g.
ksm_pages_sharing and ksm_pages_shared) of the whole system, we cannot
see the more fine-grained KSM merging, for the upper application
optimization, the merging area cannot be set easily according to the
KSM page merging probability of each process. Therefore, it is necessary
to add extra statistical means so that the upper level users can know
the detailed KSM merging information of each process.

We add a new proc file named as ksm_merging_pages under /proc/<pid>/
to indicate the involved ksm merging pages of this process.

Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 fs/proc/base.c           | 22 ++++++++++++++++++++++
 include/linux/mm_types.h |  8 ++++++++
 mm/ksm.c                 | 11 +++++++++++
 3 files changed, 41 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index d654ce7..5c8feef 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3155,6 +3155,22 @@ static int proc_pid_patch_state(struct seq_file *m, struct pid_namespace *ns,
 }
 #endif /* CONFIG_LIVEPATCH */
 
+#ifdef CONFIG_KSM
+static int proc_pid_ksm_merging_pages(struct seq_file *m, struct pid_namespace *ns,
+				struct pid *pid, struct task_struct *task)
+{
+	struct mm_struct *mm;
+
+	mm = get_task_mm(task);
+	if (mm) {
+		seq_printf(m, "%lu\n", mm->ksm_merging_pages);
+		mmput(mm);
+	}
+
+	return 0;
+}
+#endif /* CONFIG_KSM */
+
 #ifdef CONFIG_STACKLEAK_METRICS
 static int proc_stack_depth(struct seq_file *m, struct pid_namespace *ns,
 				struct pid *pid, struct task_struct *task)
@@ -3286,6 +3302,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 #ifdef CONFIG_SECCOMP_CACHE_DEBUG
 	ONE("seccomp_cache", S_IRUSR, proc_pid_seccomp_cache),
 #endif
+#ifdef CONFIG_KSM
+	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
+#endif
 };
 
 static int proc_tgid_base_readdir(struct file *file, struct dir_context *ctx)
@@ -3619,6 +3638,9 @@ static const struct pid_entry tid_base_stuff[] = {
 #ifdef CONFIG_SECCOMP_CACHE_DEBUG
 	ONE("seccomp_cache", S_IRUSR, proc_pid_seccomp_cache),
 #endif
+#ifdef CONFIG_KSM
+	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
+#endif
 };
 
 static int proc_tid_base_readdir(struct file *file, struct dir_context *ctx)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 9db36dc..4d98bd5 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -633,6 +633,14 @@ struct mm_struct {
 #ifdef CONFIG_IOMMU_SUPPORT
 		u32 pasid;
 #endif
+
+#ifdef CONFIG_KSM
+		/*
+		 * Represet how many pages of this process are
+		 * involved in KSM merging.
+		 */
+		unsigned long ksm_merging_pages;
+#endif
 	} __randomize_layout;
 
 	/*
diff --git a/mm/ksm.c b/mm/ksm.c
index c20bd4d..5889733 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -638,6 +638,10 @@ static void remove_node_from_stable_tree(struct stable_node *stable_node)
 			ksm_pages_sharing--;
 		else
 			ksm_pages_shared--;
+
+		BUG_ON(rmap_item->mm == NULL);
+		rmap_item->mm->ksm_merging_pages--;
+
 		VM_BUG_ON(stable_node->rmap_hlist_len <= 0);
 		stable_node->rmap_hlist_len--;
 		put_anon_vma(rmap_item->anon_vma);
@@ -785,6 +789,10 @@ static void remove_rmap_item_from_tree(struct rmap_item *rmap_item)
 			ksm_pages_sharing--;
 		else
 			ksm_pages_shared--;
+
+		BUG_ON(rmap_item->mm == NULL);
+		rmap_item->mm->ksm_merging_pages--;
+
 		VM_BUG_ON(stable_node->rmap_hlist_len <= 0);
 		stable_node->rmap_hlist_len--;
 
@@ -2020,6 +2028,9 @@ static void stable_tree_append(struct rmap_item *rmap_item,
 		ksm_pages_sharing++;
 	else
 		ksm_pages_shared++;
+
+	BUG_ON(rmap_item->mm == NULL);
+	rmap_item->mm->ksm_merging_pages++;
 }
 
 /*
-- 
2.15.2

