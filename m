Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78856514AA8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359855AbiD2Nkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359864AbiD2Nk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:40:29 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA747CB03D
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:37:09 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id b12so7170577plg.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DGl50d69T/46DVPYmj2DL1x7ncKmmZ54JyK/lw6nQrc=;
        b=ARePECzUIuI/o7LaJ6U30K3W4hzXRsvLwyPDJjZN5Ir39F24/V1LJiWa1QSu1EMnH5
         A1GdbC0XtJEshbkbFIKnlj/USWQUZJ1ZbMvKe6cExn1vdQNp2EvKrmONYlgc4UfzDqDN
         NPrE/d77mWvSMe8t+Pj6PUpwZJtO1lp6YSqboATYrrZ7UX43LUsVHKLtdYbl0QShre5S
         KTKyDJkzYVYEsW858cbU/F6b9nm45sIAiNbvtYGtEbXr8MjkUHvyh6vh9G95S67sc/Qd
         5bayvVPY/1MQqIcZ8qKIQkAnNN6I1m7O69zc83csx5Wy9gJ5vcWF0bOjLvSmoOPA1ADx
         MHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DGl50d69T/46DVPYmj2DL1x7ncKmmZ54JyK/lw6nQrc=;
        b=f2SAKy+KcJ4eo9NxgaKdwsY6/uXJIZJ6OL9L6gj3y1aiuBvPaooSedp9oLPzGqVWVw
         50swfm8XRZtUNYLIFuTtV0J49WUpSRi7vMjSy1ajkHyGbfMOZYRSalCEZvIxuRIZF7PT
         DsYPGCs8vwzOSwtHdFz5p4CWI5+ExGVOWrPrOB+UV/CXesge1ZVwitIPKadxCSkAf/Jf
         5Kp++hM/Xm+c3fKOO4Gx2pwwp3sfV9ySpwaCe1DqWNB6ednh12AZ6iOmfK6u5bnjDzaT
         cPjrnXQj2Q5btZahrMlozYUtnOSI8yfnpLfubPDbYcs1IFPud98zEyWFmooval/3vxOb
         zFog==
X-Gm-Message-State: AOAM533xK15QqRM2q8e1NKDMnEGEWsQrT9xt3xJDGX7RfSya7malVK7P
        xwtaZQKJ/ksut1ydxzwDFSbtAQ==
X-Google-Smtp-Source: ABdhPJwkDEFr/eSiIXsECiLskFgBvhXhvx+Ht6goriTOJRM12m+x++WpdKjE8bfOm4QcHnGGrKiSMQ==
X-Received: by 2002:a17:90b:380e:b0:1da:2943:b975 with SMTP id mq14-20020a17090b380e00b001da2943b975mr4006350pjb.42.1651239429455;
        Fri, 29 Apr 2022 06:37:09 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id m8-20020a17090a414800b001d81a30c437sm10681977pjg.50.2022.04.29.06.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 06:37:08 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, jgg@nvidia.com, tj@kernel.org, dennis@kernel.org,
        ming.lei@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 09/18] pte_ref: add pte_tryget() and {__,}pte_put() helper
Date:   Fri, 29 Apr 2022 21:35:43 +0800
Message-Id: <20220429133552.33768-10-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220429133552.33768-1-zhengqi.arch@bytedance.com>
References: <20220429133552.33768-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The user PTE page table page may be freed when the last
percpu_ref is dropped. So we need to try to get its
percpu_ref before accessing the PTE page to prevent it
form being freed during the access process.

This patch adds pte_tryget() and {__,}pte_put() to help us
to get and put the percpu_ref of user PTE page table pages.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/pte_ref.h | 23 ++++++++++++++++
 mm/pte_ref.c            | 58 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/include/linux/pte_ref.h b/include/linux/pte_ref.h
index d3963a151ca5..bfe620038699 100644
--- a/include/linux/pte_ref.h
+++ b/include/linux/pte_ref.h
@@ -12,6 +12,10 @@
 
 bool pte_ref_init(pgtable_t pte);
 void pte_ref_free(pgtable_t pte);
+void free_user_pte(struct mm_struct *mm, pmd_t *pmd, unsigned long addr);
+bool pte_tryget(struct mm_struct *mm, pmd_t *pmd, unsigned long addr);
+void __pte_put(pgtable_t page);
+void pte_put(pte_t *ptep);
 
 #else /* !CONFIG_FREE_USER_PTE */
 
@@ -24,6 +28,25 @@ static inline void pte_ref_free(pgtable_t pte)
 {
 }
 
+static inline void free_user_pte(struct mm_struct *mm, pmd_t *pmd,
+				 unsigned long addr)
+{
+}
+
+static inline bool pte_tryget(struct mm_struct *mm, pmd_t *pmd,
+			      unsigned long addr)
+{
+	return true;
+}
+
+static inline void __pte_put(pgtable_t page)
+{
+}
+
+static inline void pte_put(pte_t *ptep)
+{
+}
+
 #endif /* CONFIG_FREE_USER_PTE */
 
 #endif /* _LINUX_PTE_REF_H */
diff --git a/mm/pte_ref.c b/mm/pte_ref.c
index 52e31be00de4..5b382445561e 100644
--- a/mm/pte_ref.c
+++ b/mm/pte_ref.c
@@ -44,4 +44,62 @@ void pte_ref_free(pgtable_t pte)
 	kfree(ref);
 }
 
+void free_user_pte(struct mm_struct *mm, pmd_t *pmd, unsigned long addr) {}
+
+/*
+ * pte_tryget - try to get the pte_ref of the user PTE page table page
+ * @mm: pointer the target address space
+ * @pmd: pointer to a PMD.
+ * @addr: virtual address associated with pmd.
+ *
+ * Return: true if getting the pte_ref succeeded. And false otherwise.
+ *
+ * Before accessing the user PTE page table, we need to hold a refcount to
+ * protect against the concurrent release of the PTE page table.
+ * But we will fail in the following case:
+ * 	- The content mapped in @pmd is not a PTE page
+ * 	- The pte_ref is zero, it may be reclaimed
+ */
+bool pte_tryget(struct mm_struct *mm, pmd_t *pmd, unsigned long addr)
+{
+	bool retval = true;
+	pmd_t pmdval;
+	pgtable_t pte;
+
+	rcu_read_lock();
+	pmdval = READ_ONCE(*pmd);
+	pte = pmd_pgtable(pmdval);
+	if (unlikely(pmd_none(pmdval) || pmd_leaf(pmdval))) {
+		retval = false;
+	} else if (!percpu_ref_tryget(pte->pte_ref)) {
+		rcu_read_unlock();
+		/*
+		 * Also do free_user_pte() here to prevent missed reclaim due
+		 * to race condition.
+		 */
+		free_user_pte(mm, pmd, addr & PMD_MASK);
+		return false;
+	}
+	rcu_read_unlock();
+
+	return retval;
+}
+
+void __pte_put(pgtable_t page)
+{
+	percpu_ref_put(page->pte_ref);
+}
+
+void pte_put(pte_t *ptep)
+{
+	pgtable_t page;
+
+	if (pte_huge(*ptep))
+		return;
+
+	page = pte_to_page(ptep);
+	__pte_put(page);
+}
+EXPORT_SYMBOL(pte_put);
+
 #endif /* CONFIG_FREE_USER_PTE */
-- 
2.20.1

