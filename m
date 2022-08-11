Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E89B590470
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 18:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238867AbiHKQmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 12:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239285AbiHKQlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 12:41:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0F8EA61DC
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660234429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kvn+70I7yPIly7NIcpI+E4BYwfh3vfPaXmRAy92AF5w=;
        b=hVTN7i0QMKFBh392bac4jgfDb9v6Stf77skSImDft/H2S9/YrAmTxie6y+yysl3hue34rX
        D7vxaR3YmB3QBPB8v7/q/gafzHMI/KYJYff/osB3qs64VorXQWGuLXU0Fvi+AGgk1cAgjk
        aDWQpi0nGivaYsrkGwxgC+HCzwkYqk0=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-660-GKQMlPldOKq3pJ_IvPSDHA-1; Thu, 11 Aug 2022 12:13:48 -0400
X-MC-Unique: GKQMlPldOKq3pJ_IvPSDHA-1
Received: by mail-il1-f200.google.com with SMTP id x7-20020a056e021ca700b002ded2e6331aso13023929ill.20
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:13:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Kvn+70I7yPIly7NIcpI+E4BYwfh3vfPaXmRAy92AF5w=;
        b=cczcbIcih1Oc2hhZ5G7QkoPklNPPYzk2khBqf5fPcWY14Q7rNZiRGl7t2/cLfN92Hl
         YKBmCIw9fFs4L8LlLsI9fw/8auejIdOkwrENCmJbzcVRduhERuIj2SjTCX08Fqkztisp
         4GU9NzMSbIMJStE+FsqZ8N9+EwUfQBK4N1JyHrBnGdgSU3oUDlvBLo6J1LfUCpmNN9TG
         dikcuxH785qSxADkt5BZMybRoq7/6TDcVkUMe1nypavtTXVgx5rA9VFqzPNuCUXBHx6D
         1auPEUewD/N3f6JAMR41Z6aCeHtkYC0yEjOAtBH9vFTETGjcBk50NV8uFS/rRVP5deMP
         cuoA==
X-Gm-Message-State: ACgBeo384bJTAFqZwuy7CPJwJKJv5CEtG7NzxUeBvXDctLYSlqfMk9gq
        HdwfiHbEKC4N7u2uaHHYoP27Oc8FYRiZURjLXyF2lKwDMLPoEzFjdT8M+/WhudRUQMv2hDWOzxC
        V6yxZmP6hTIksNnDoNLo+qTG8
X-Received: by 2002:a92:ce50:0:b0:2dd:dc8e:1f36 with SMTP id a16-20020a92ce50000000b002dddc8e1f36mr16218642ilr.34.1660234425789;
        Thu, 11 Aug 2022 09:13:45 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4ZzxcH25ORg0vfYxNfi+ta3V6GDOQvV28uQeT5mwGBGdlqyFRzS44blQE276L9QlyIzt5Fvg==
X-Received: by 2002:a92:ce50:0:b0:2dd:dc8e:1f36 with SMTP id a16-20020a92ce50000000b002dddc8e1f36mr16218626ilr.34.1660234425555;
        Thu, 11 Aug 2022 09:13:45 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id t1-20020a92ca81000000b002dd1c3c5c46sm3415429ilo.73.2022.08.11.09.13.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Aug 2022 09:13:45 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Alistair Popple <apopple@nvidia.com>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v4 7/7] mm/swap: Cache swap migration A/D bits support
Date:   Thu, 11 Aug 2022 12:13:31 -0400
Message-Id: <20220811161331.37055-8-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220811161331.37055-1-peterx@redhat.com>
References: <20220811161331.37055-1-peterx@redhat.com>
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
 include/linux/swapfile.h | 2 ++
 include/linux/swapops.h  | 7 +------
 mm/swapfile.c            | 8 ++++++++
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/linux/swapfile.h b/include/linux/swapfile.h
index 165e0bd04862..2fbcc9afd814 100644
--- a/include/linux/swapfile.h
+++ b/include/linux/swapfile.h
@@ -10,5 +10,7 @@ extern struct swap_info_struct *swap_info[];
 extern unsigned long generic_max_swapfile_size(void);
 /* Maximum swapfile size supported for the arch (not inclusive). */
 extern unsigned long swapfile_maximum_size;
+/* Whether swap migration entry supports storing A/D bits for the arch */
+extern bool swap_migration_ad_supported;
 
 #endif /* _LINUX_SWAPFILE_H */
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index f25b566643f1..dbf9df854124 100644
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
-	return swapfile_maximum_size >= (1UL << SWP_MIG_TOTAL_BITS);
+	return swap_migration_ad_supported;
 #else  /* CONFIG_SWAP */
 	return false;
 #endif	/* CONFIG_SWAP */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 3cc64399df44..263b19e693cf 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -64,6 +64,9 @@ EXPORT_SYMBOL_GPL(nr_swap_pages);
 long total_swap_pages;
 static int least_priority = -1;
 unsigned long swapfile_maximum_size;
+#ifdef CONFIG_MIGRATION
+bool swap_migration_ad_supported;
+#endif	/* CONFIG_MIGRATION */
 
 static const char Bad_file[] = "Bad swap file entry ";
 static const char Unused_file[] = "Unused swap file entry ";
@@ -3680,6 +3683,11 @@ static int __init swapfile_init(void)
 
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

