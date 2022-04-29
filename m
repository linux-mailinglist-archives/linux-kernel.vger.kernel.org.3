Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4DD514A9B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359826AbiD2NkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359852AbiD2NkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:40:17 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD55BCC500
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:36:58 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q12so6524743pgj.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZTHv+EobGmd8CLqrN8ICsD/Gd2+vakaEN+AZqfml/As=;
        b=Pp9YaWXF+keaVk+3vcFs3ST1OD3cYkcjwDO13WpXirW65DJ5bV24lriyyZ3gSCtH1t
         ZrexZP4eqVpM+sJIbrDvAV6PHKPMjCYED8+24O1lxhFn2leYX3+FUdT0xJMzmNoM8vHu
         R6U2/6kf69dP6xXUieWIdERPGU8JMCKVGGHds1fcYgNFcNtGAn1c/kHvsWaE3iNCkYA5
         RqdeoXcJZMaW+VrHTPiE0q4Zx8NLKhMbg/05XMpQP+Fif3YIpIK9cdVZGsJrI8deD15+
         Yk+iY23SxB+rz3MFcApWicRPxvVoXsv2GXFFrxlXAOr0Z2k4Bv9kbswt9Pf2UaM2ubmN
         BZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZTHv+EobGmd8CLqrN8ICsD/Gd2+vakaEN+AZqfml/As=;
        b=8QUiGp1zg7rmSIXLjm+Z6hKttwa4B1g2LMqa1N2/WL1fWtNwi5FDM2XiMovnRTycyn
         ceXP7CrBvmCqxkmYzj6wT5B7KPWVZoK3n/hNMifw6o51Ul/iL9MNM1y4eHk5exWcn/JW
         CpOWh4vWFXUQCyobkCSlvHd0sBjea1W0woGnfoLmVdGbVK+a2IGzh601GPvBRzlh8yeA
         ssEHeeZ5G83NsqWPe2CyrwjlUJuOXuXbLyk89kAipShzHg+Hr4ZbJmhHDAAfFjYlsrKj
         AkKhYqhHHr2LN61ELw1BeN4n8UwLMPdRl/o7SLiBqftpQ1ATejnJYIgMAK/X1EBKOh3v
         fyEQ==
X-Gm-Message-State: AOAM533hQUKJ2d1iwTUbG7OJxbS7dialHiHU9FroIgTS/aldVVmaoD6E
        Gfnxl1Bmg8BBFtM5chNbi/1l/cFxjj50lQ==
X-Google-Smtp-Source: ABdhPJxQ/VkMVyn4Qp+z5Cb9ljljtE8dhgkTNUvvkMORdefL3XrTmyDghPgZGP75wajseTIiF7sh1Q==
X-Received: by 2002:a63:290:0:b0:3aa:8b8b:1a3d with SMTP id 138-20020a630290000000b003aa8b8b1a3dmr31635992pgc.208.1651239417928;
        Fri, 29 Apr 2022 06:36:57 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id m8-20020a17090a414800b001d81a30c437sm10681977pjg.50.2022.04.29.06.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 06:36:57 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, jgg@nvidia.com, tj@kernel.org, dennis@kernel.org,
        ming.lei@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 07/18] mm: add pte_to_page() helper
Date:   Fri, 29 Apr 2022 21:35:41 +0800
Message-Id: <20220429133552.33768-8-zhengqi.arch@bytedance.com>
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

Add pte_to_page() helper similar to pmd_to_page(), which
will be used to get the struct page of the PTE page table.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/pgtable.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 0928acca6b48..d1218cb1013e 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -85,6 +85,14 @@ static inline unsigned long pud_index(unsigned long address)
 #define pgd_index(a)  (((a) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
 #endif
 
+#ifdef CONFIG_FREE_USER_PTE
+static inline struct page *pte_to_page(pte_t *pte)
+{
+	unsigned long mask = ~(PTRS_PER_PTE * sizeof(pte_t) - 1);
+	return virt_to_page((void *)((unsigned long) pte & mask));
+}
+#endif
+
 #if USE_SPLIT_PTE_PTLOCKS
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
-- 
2.20.1

