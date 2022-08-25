Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DD45A0D93
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241112AbiHYKMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241054AbiHYKMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:12:10 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC93ABF3C
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:12:01 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id t129so538502pfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=88xUUyVXHxDMCZmOYvZcYjojlwDW8mxu4+gwmvT3Uwg=;
        b=gCJc7t/irCxh/NsMtY1y28pn7+kS/+rCgGiEHuh81J6ucr5EX2vhMnTKm6bgUjyY0A
         FSH1ktN+iUPsTs7yW0vMLvS8VlTwmoaCjW/xDnuFk754nlVaaV5Sknqz7pgkUiF2NyNw
         kFNyD315ZQdYYefBhtxUO3hwVbrJh72K9xlvUHcJJytF8Hm+UucnXUn/bJV6GXT3KUbO
         qC74CEILcwNgX2/ksJAFI1VKjObcAa5bb61duB1Unbfwa4/HOAZINmkbhLrg/n2UTAM9
         Y1LJVRSnkqYB4JH0aUKiKOhE31G/bmczwx7n5ekrUGCJhmRUyWj6K+A5mw3aTIe+aRlY
         6TNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=88xUUyVXHxDMCZmOYvZcYjojlwDW8mxu4+gwmvT3Uwg=;
        b=hAO3w0b0e+cXrluDqkYn56W5ZRZ8jIn6fsYa0MHUVPNaaxJhft1MuwA6Xae7uGkVbs
         rq9EYwstegJ1YUOMCr9EhGRoWZrfySHqI0uRFaqMiMj8Dlon6P9xmB6ROO6Vd/vQUcOC
         eyZ+IcIN20C03peF/xCHwbrzSA/lToJfp5OmBnhOite9jFqsVWw1FEYMtrmZ+U4Ao+Ta
         QiFnuw+WA52xTGGas6EA9hAR5WiuFG5oAiodwx39ojdVyA+vIyWNxNJ9DcfTiwjbG2UX
         5iskUnDO2Uyrm8OF2n3loaGo6X8yyZ0x5ruKLfGA9KBccSaxkUC5ZOOzVZDS/ZkOhvQJ
         /5mA==
X-Gm-Message-State: ACgBeo1At/iA1EZ5MwKk0LdWOIyFtqd59pAhT62V19mWjMFpRsYrZvFO
        cJgeazuHgb3wCbzNBHutArHK0Q==
X-Google-Smtp-Source: AA6agR7wR0oMHsFEiShRabwQxkM0xbplFH+VDCYoO8SCvwJvs/eBFuYQvXDb00xbfLmujhgctEuB0w==
X-Received: by 2002:a05:6a00:8c8:b0:52c:887d:fa25 with SMTP id s8-20020a056a0008c800b0052c887dfa25mr3524872pfu.86.1661422320411;
        Thu, 25 Aug 2022 03:12:00 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id b10-20020a170903228a00b001714c36a6e7sm8477581plh.284.2022.08.25.03.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 03:11:59 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@redhat.com,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        jgg@nvidia.com, tglx@linutronix.de, willy@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 5/7] pte_ref: add track_pte_{set, clear}() helper
Date:   Thu, 25 Aug 2022 18:10:35 +0800
Message-Id: <20220825101037.96517-6-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220825101037.96517-1-zhengqi.arch@bytedance.com>
References: <20220825101037.96517-1-zhengqi.arch@bytedance.com>
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

The track_pte_set() is used to track the setting of the PTE page table
entry, and the track_pte_clear() is used to track the clearing of the
PTE page table entry, we update the pte_refcount of the PTE page in
these two functions.

In this way, the usage of the PTE page table page can be tracked by
its pte_refcount.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/pte_ref.h | 13 +++++++++++++
 mm/pte_ref.c            | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/linux/pte_ref.h b/include/linux/pte_ref.h
index db14e03e1dff..ab49c7fac120 100644
--- a/include/linux/pte_ref.h
+++ b/include/linux/pte_ref.h
@@ -12,12 +12,25 @@
 
 void pte_ref_init(pgtable_t pte);
 
+void track_pte_set(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
+		   pte_t pte);
+void track_pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
+		     pte_t pte);
 #else /* !CONFIG_FREE_USER_PTE */
 
 static inline void pte_ref_init(pgtable_t pte)
 {
 }
 
+static inline void track_pte_set(struct mm_struct *mm, unsigned long addr,
+				 pte_t *ptep, pte_t pte)
+{
+}
+
+static inline void track_pte_clear(struct mm_struct *mm, unsigned long addr,
+				   pte_t *ptep, pte_t pte)
+{
+}
 #endif /* CONFIG_FREE_USER_PTE */
 
 #endif /* _LINUX_PTE_REF_H */
diff --git a/mm/pte_ref.c b/mm/pte_ref.c
index 12b27646e88c..818821d068af 100644
--- a/mm/pte_ref.c
+++ b/mm/pte_ref.c
@@ -69,4 +69,40 @@ void pte_ref_init(pgtable_t pte)
 	pte->pte_refcount = 0;
 }
 
+void track_pte_set(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
+		   pte_t pte)
+{
+	pgtable_t page;
+
+	if (&init_mm == mm || pte_huge(pte))
+		return;
+
+	page = pte_to_page(ptep);
+	if (pte_none(*ptep) && !pte_none(pte)) {
+		pte_refcount_add(mm, page, PTE_MAPPED_OFFSET);
+		if (is_zero_pfn(pte_pfn(pte)))
+			pte_refcount_add(mm, page, PTE_ZERO_OFFSET);
+	} else if (is_zero_pfn(pte_pfn(*ptep)) && !is_zero_pfn(pte_pfn(pte))) {
+		pte_refcount_sub(mm, page, PTE_ZERO_OFFSET);
+	}
+}
+EXPORT_SYMBOL(track_pte_set);
+
+void track_pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
+		     pte_t pte)
+{
+	pgtable_t page;
+
+	if (&init_mm == mm || pte_huge(pte))
+		return;
+
+	page = pte_to_page(ptep);
+	if (!pte_none(pte)) {
+		pte_refcount_sub(mm, page, PTE_MAPPED_OFFSET);
+		if (is_zero_pfn(pte_pfn(pte)))
+			pte_refcount_sub(mm, page, PTE_ZERO_OFFSET);
+	}
+}
+EXPORT_SYMBOL(track_pte_clear);
+
 #endif /* CONFIG_FREE_USER_PTE */
-- 
2.20.1

