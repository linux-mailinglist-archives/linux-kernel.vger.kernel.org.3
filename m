Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FF5590500
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 18:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238939AbiHKQmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 12:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239280AbiHKQlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 12:41:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4E7CA61D2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660234429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Huxd7IPCPnmA3ZqjXCerOPqYjMrNourUX2B7v06rhc=;
        b=XJGWxRejrCYVzyK6dIdGSsJ4OuX4L4sncbi2UZ+wij7Gh1D7F2QbXHHwDm0c2yy+nMACnZ
        /gKXI/q5Ad08mY5oC7Z/jMuWwM6y/3MianCP5hKisHPsgDLAFW/SRhKdqGOqD9MlZbTeFr
        wE0r1+4YXoyk03NNEPaeah2rSitJjkY=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-446-HN37TWv9OBi_S03WOuowgQ-1; Thu, 11 Aug 2022 12:13:45 -0400
X-MC-Unique: HN37TWv9OBi_S03WOuowgQ-1
Received: by mail-il1-f197.google.com with SMTP id i12-20020a056e021d0c00b002df2d676974so12730071ila.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=/Huxd7IPCPnmA3ZqjXCerOPqYjMrNourUX2B7v06rhc=;
        b=aP3l1Xfj8TC0RuOCq3rvR1SjnTG2xjsegvremxzdLgU6CI/NFslkNwcg3/bIyXdyXA
         VkAJIufIWTUtY/vcp4TSctMIi+FfJOK4hSmnBjU2fdJ0RhfpN/HKym+gtuAskEu7xRi8
         Ln6E8Nl8VP9SZs43eB4K9hfj7+jaip/ydzY+ZEWeGTmgOrb12Z3c+x/nofT78bqntwU2
         pE5kroog6bWUEdI3SMGDTnZhMaxptBSLW8WhXB8H/sQOJGZPP7VI/ccuOYKuonlwF7Er
         zCLi2dBbQ88IqAtzX3hhkC0j/TRpyYeGgP3Io5uuMAi5Asb/LBJgq++nmLG6fUK2IHZ5
         elbg==
X-Gm-Message-State: ACgBeo1Qh4c2V8ruVCuwlay06YiJXvFAfIOJpdjewjsYsqFOXzXvq65v
        rr5LhrhrQK0NmVa+Od7C3moC8JYs2mDjxNyIU52lJ6630xh1PFXxScU+gfzfkRK6+TONUfL4le7
        RrSYqtzgu8YLN632io3FEIhhP
X-Received: by 2002:a05:6638:1301:b0:342:c20d:3b15 with SMTP id r1-20020a056638130100b00342c20d3b15mr21422jad.59.1660234424221;
        Thu, 11 Aug 2022 09:13:44 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4T6gWtzxZxHWUIVbSUYS7vdfLC8nfHajGAKsVlnVfjs8zkeYJ9u3kFIxUuxfWF4Czl1LgvQg==
X-Received: by 2002:a05:6638:1301:b0:342:c20d:3b15 with SMTP id r1-20020a056638130100b00342c20d3b15mr21411jad.59.1660234424004;
        Thu, 11 Aug 2022 09:13:44 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id t1-20020a92ca81000000b002dd1c3c5c46sm3415429ilo.73.2022.08.11.09.13.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Aug 2022 09:13:43 -0700 (PDT)
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
Subject: [PATCH v4 6/7] mm/swap: Cache maximum swapfile size when init swap
Date:   Thu, 11 Aug 2022 12:13:30 -0400
Message-Id: <20220811161331.37055-7-peterx@redhat.com>
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

We used to have swapfile_maximum_size() fetching a maximum value of
swapfile size per-arch.

As the caller of max_swapfile_size() grows, this patch introduce a variable
"swapfile_maximum_size" and cache the value of old max_swapfile_size(), so
that we don't need to calculate the value every time.

Caching the value in swapfile_init() is safe because when reaching the
phase we should have initialized all the relevant information.  Here the
major arch to take care of is x86, which defines the max swapfile size
based on L1TF mitigation.

Here both X86_BUG_L1TF or l1tf_mitigation should have been setup properly
when reaching swapfile_init(). As a reference, the code path looks like
this for x86:

- start_kernel
  - setup_arch
    - early_cpu_init
      - early_identify_cpu --> setup X86_BUG_L1TF
  - parse_early_param
    - l1tf_cmdline --> set l1tf_mitigation
  - check_bugs
    - l1tf_select_mitigation --> set l1tf_mitigation
  - arch_call_rest_init
    - rest_init
      - kernel_init
        - kernel_init_freeable
          - do_basic_setup
            - do_initcalls --> calls swapfile_init() (initcall level 4)

The swapfile size only depends on swp pte format on non-x86 archs, so
caching it is safe too.

Since at it, rename max_swapfile_size() to arch_max_swapfile_size() because
arch can define its own function, so it's more straightforward to have
"arch_" as its prefix.  At the meantime, export swapfile_maximum_size to
replace the old usages of max_swapfile_size().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/mm/init.c       | 2 +-
 include/linux/swapfile.h | 3 ++-
 include/linux/swapops.h  | 2 +-
 mm/swapfile.c            | 7 +++++--
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 82a042c03824..9121bc1b9453 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -1054,7 +1054,7 @@ void update_cache_mode_entry(unsigned entry, enum page_cache_mode cache)
 }
 
 #ifdef CONFIG_SWAP
-unsigned long max_swapfile_size(void)
+unsigned long arch_max_swapfile_size(void)
 {
 	unsigned long pages;
 
diff --git a/include/linux/swapfile.h b/include/linux/swapfile.h
index 54078542134c..165e0bd04862 100644
--- a/include/linux/swapfile.h
+++ b/include/linux/swapfile.h
@@ -8,6 +8,7 @@
  */
 extern struct swap_info_struct *swap_info[];
 extern unsigned long generic_max_swapfile_size(void);
-extern unsigned long max_swapfile_size(void);
+/* Maximum swapfile size supported for the arch (not inclusive). */
+extern unsigned long swapfile_maximum_size;
 
 #endif /* _LINUX_SWAPFILE_H */
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 36e462e116af..f25b566643f1 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -307,7 +307,7 @@ static inline bool migration_entry_supports_ad(void)
 	 * the offset large enough to cover all of them (PFN, A & D bits).
 	 */
 #ifdef CONFIG_SWAP
-	return max_swapfile_size() >= (1UL << SWP_MIG_TOTAL_BITS);
+	return swapfile_maximum_size >= (1UL << SWP_MIG_TOTAL_BITS);
 #else  /* CONFIG_SWAP */
 	return false;
 #endif	/* CONFIG_SWAP */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 1fdccd2f1422..3cc64399df44 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -63,6 +63,7 @@ EXPORT_SYMBOL_GPL(nr_swap_pages);
 /* protected with swap_lock. reading in vm_swap_full() doesn't need lock */
 long total_swap_pages;
 static int least_priority = -1;
+unsigned long swapfile_maximum_size;
 
 static const char Bad_file[] = "Bad swap file entry ";
 static const char Unused_file[] = "Unused swap file entry ";
@@ -2816,7 +2817,7 @@ unsigned long generic_max_swapfile_size(void)
 }
 
 /* Can be overridden by an architecture for additional checks. */
-__weak unsigned long max_swapfile_size(void)
+__weak unsigned long arch_max_swapfile_size(void)
 {
 	return generic_max_swapfile_size();
 }
@@ -2856,7 +2857,7 @@ static unsigned long read_swap_header(struct swap_info_struct *p,
 	p->cluster_next = 1;
 	p->cluster_nr = 0;
 
-	maxpages = max_swapfile_size();
+	maxpages = swapfile_maximum_size;
 	last_page = swap_header->info.last_page;
 	if (!last_page) {
 		pr_warn("Empty swap-file\n");
@@ -3677,6 +3678,8 @@ static int __init swapfile_init(void)
 	for_each_node(nid)
 		plist_head_init(&swap_avail_heads[nid]);
 
+	swapfile_maximum_size = arch_max_swapfile_size();
+
 	return 0;
 }
 subsys_initcall(swapfile_init);
-- 
2.32.0

