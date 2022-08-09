Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F09358E24B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiHIWCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiHIWBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:01:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D0FFE08
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660082474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8oTmLlquT/JmXxP88HUbcjeMqANq5xLJcNEKCKe+fKE=;
        b=S69FzfOWOVq7JyjaS/1d3hshovEm2x5unC1AWQ3zrK02vGC1wDgkd/NW2qMYCGJ8QHfuqJ
        +bf9aMoUtk21uhmD/QK6tvXkIEo6jJfMcNGaiBUx/hDkPqKuvb9hwrN/605NnzgNevRBBj
        gQikm7ehjiQLwgyjpJylN+gf90rHmdM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-k0QSOui-N8mT0mAZqRKEzA-1; Tue, 09 Aug 2022 18:01:13 -0400
X-MC-Unique: k0QSOui-N8mT0mAZqRKEzA-1
Received: by mail-qk1-f197.google.com with SMTP id s9-20020a05620a254900b006b54dd4d6deso11149622qko.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=8oTmLlquT/JmXxP88HUbcjeMqANq5xLJcNEKCKe+fKE=;
        b=uKcuoSlndzA42B/EIVgdsQVfQSoy1QAnWAVnxL0Idg/GejLgVy5Ld2yy6RWPJXjuR1
         bN+GN4/Gmeh6Ahcw7bsY7iOsE+cwZr5Qu7wEqH9skm4v8c2UQzkDm2AkKTduFihg1ape
         n1Ba+8GkEJBrfFwnAS1ZP5MP2s0gIpAI8Kux2ejcy0+VoZfFig/Cw1nPBpKeJj+zcVSO
         SCZ20aO1E4JUtYN09xP/fAskQdMDwS7rmSokmpPr5UqrX5Jos7Yy3lhmAp3f2UKDwBE0
         TsrHSorAuC+KdcS7sE8AfhPw2l62sFrl9BHxTIWrTnYb1ESW9lwsWKgb2JfFLp1G9TAl
         9fBA==
X-Gm-Message-State: ACgBeo2gjijv+ecG6smb2gtKVaD/ESLWkcYGGPMZLYe2qYzcxWgSNm7p
        I8yzx/7tE5pApTWPv7XiFKfjDP15B9M9Wg/TxtQX7DKGCYkd77BSb1Top/QpbGKRHBgGYoMJwfT
        /kLDtWVxJJ4TnsXzqEgDTk23J
X-Received: by 2002:ad4:5745:0:b0:474:73b3:8e6b with SMTP id q5-20020ad45745000000b0047473b38e6bmr21943586qvx.30.1660082472645;
        Tue, 09 Aug 2022 15:01:12 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7zy2JuWvJjf9RyNp22pt6EAQPYAGfW6c3P8B5Al6S1qhuoVayGnuKePcXRi5AkcG0+83tbPw==
X-Received: by 2002:ad4:5745:0:b0:474:73b3:8e6b with SMTP id q5-20020ad45745000000b0047473b38e6bmr21943562qvx.30.1660082472384;
        Tue, 09 Aug 2022 15:01:12 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id b16-20020a05622a021000b0031eddc83560sm10563383qtx.90.2022.08.09.15.01.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Aug 2022 15:01:12 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v3 7/7] mm/swap: Cache swap migration A/D bits support
Date:   Tue,  9 Aug 2022 18:01:00 -0400
Message-Id: <20220809220100.20033-8-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220809220100.20033-1-peterx@redhat.com>
References: <20220809220100.20033-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a variable swap_migration_ad_supported to cache whether the arch
supports swap migration A/D bits.

Here one thing to mention is that SWP_MIG_TOTAL_BITS will internally
reference the other macro MAX_PHYSMEM_BITS, which is a function call on
x86 (constant on all the rest of archs).

It's safe to reference it in swapfile_init() because when reaching here
we're already during initcalls level 4 so we must have initialized 5-level
pgtable for x86_64 (right after early_identify_cpu() finishes).

- start_kernel
  - setup_arch
    - early_cpu_init
      - get_cpu_cap --> fetch from CPUID (including X86_FEATURE_LA57)
      - early_identify_cpu --> clear X86_FEATURE_LA57 (if early lvl5 not enabled (USE_EARLY_PGTABLE_L5))
  - arch_call_rest_init
    - rest_init
      - kernel_init
        - kernel_init_freeable
          - do_basic_setup
            - do_initcalls --> calls swapfile_init() (initcall level 4)

This should slightly speed up the migration swap entry handlings.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/swapfile.h | 1 +
 include/linux/swapops.h  | 7 +------
 mm/swapfile.c            | 8 ++++++++
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/linux/swapfile.h b/include/linux/swapfile.h
index 54078542134c..87ec5e2cdb02 100644
--- a/include/linux/swapfile.h
+++ b/include/linux/swapfile.h
@@ -9,5 +9,6 @@
 extern struct swap_info_struct *swap_info[];
 extern unsigned long generic_max_swapfile_size(void);
 extern unsigned long max_swapfile_size(void);
+extern bool swap_migration_ad_supported;
 
 #endif /* _LINUX_SWAPFILE_H */
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 0e9579b90659..e6afc77c51ad 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -301,13 +301,8 @@ static inline swp_entry_t make_writable_migration_entry(pgoff_t offset)
  */
 static inline bool migration_entry_supports_ad(void)
 {
-	/*
-	 * max_swapfile_size() returns the max supported swp-offset plus 1.
-	 * We can support the migration A/D bits iff the pfn swap entry has
-	 * the offset large enough to cover all of them (PFN, A & D bits).
-	 */
 #ifdef CONFIG_SWAP
-	return max_swapfile_size() >= (1UL << SWP_MIG_TOTAL_BITS);
+	return swap_migration_ad_supported;
 #else  /* CONFIG_SWAP */
 	return false;
 #endif	/* CONFIG_SWAP */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 794fa37bd0c3..c49cf25f0d08 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -64,6 +64,9 @@ EXPORT_SYMBOL_GPL(nr_swap_pages);
 long total_swap_pages;
 static int least_priority = -1;
 static unsigned long swapfile_maximum_size;
+#ifdef CONFIG_MIGRATION
+bool swap_migration_ad_supported;
+#endif	/* CONFIG_MIGRATION */
 
 static const char Bad_file[] = "Bad swap file entry ";
 static const char Unused_file[] = "Unused swap file entry ";
@@ -3685,6 +3688,11 @@ static int __init swapfile_init(void)
 
 	swapfile_maximum_size = arch_max_swapfile_size();
 
+#ifdef CONFIG_MIGRATION
+	if (swapfile_maximum_size >= (1UL << SWP_MIG_TOTAL_BITS))
+		swap_migration_ad_supported = true;
+#endif	/* CONFIG_MIGRATION */
+
 	return 0;
 }
 subsys_initcall(swapfile_init);
-- 
2.32.0

