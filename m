Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6064658CAE8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 16:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243684AbiHHO6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 10:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243491AbiHHO5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:57:38 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E47C12AFB
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 07:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659970658; x=1691506658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZZZmTi+uFgSNOrvmXUlZxD/TTF+6bac/va5jAJ+uc90=;
  b=G64yTYy21LHIDNCfx+gwPiYL4fH29r2I1AnFaNGob5hReZPjYPbSzVNZ
   oJCl5dIGVXLdG3znuIm4UFqjDQdAijAe5anj8XEEWzKsfLEZYiQCCBQxE
   f/El11b4FcsqkCmmhzn8Dll0u8DThPQA2Zi0z2l3qnbC5TRHHgkwc9sJG
   u2bMa06up4HXr/8inGP94F3yS4uR4xP7x5AFIYV8R49MgtQ6cPt6OW/FF
   MB6Bp3osRoGm9Ne0Y6BEVrPve7U/zGEDXQUP1enDnb1ukaPwhN61KbTEP
   AoYtc4pdHJzM6LaRm1sFb6xTNQjurslb18Ql+9qXWaCLvkHy8SprQv7/t
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="270996892"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="270996892"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 07:57:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="663980513"
Received: from ziqianlu-desk2.sh.intel.com ([10.238.2.76])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 07:57:36 -0700
From:   Aaron Lu <aaron.lu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [RFC PATCH 3/4] x86/mm/cpa: add merge event counter
Date:   Mon,  8 Aug 2022 22:56:48 +0800
Message-Id: <20220808145649.2261258-4-aaron.lu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808145649.2261258-1-aaron.lu@intel.com>
References: <20220808145649.2261258-1-aaron.lu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like split event counter, this patch add counter for merge event.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 arch/x86/mm/pat/set_memory.c  | 19 +++++++++++++++++++
 include/linux/vm_event_item.h |  2 ++
 mm/vmstat.c                   |  2 ++
 3 files changed, 23 insertions(+)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index fea2c70ff37f..1be9aab42c79 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -105,6 +105,23 @@ static void split_page_count(int level)
 	direct_pages_count[level - 1] += PTRS_PER_PTE;
 }
 
+static void merge_page_count(int level)
+{
+	if (direct_pages_count[level] < PTRS_PER_PTE) {
+		WARN_ON_ONCE(1);
+		return;
+	}
+
+	direct_pages_count[level] -= PTRS_PER_PTE;
+	if (system_state == SYSTEM_RUNNING) {
+		if (level == PG_LEVEL_4K)
+			count_vm_event(DIRECT_MAP_LEVEL1_MERGE);
+		else if (level == PG_LEVEL_2M)
+			count_vm_event(DIRECT_MAP_LEVEL2_MERGE);
+	}
+	direct_pages_count[level + 1]++;
+}
+
 void arch_report_meminfo(struct seq_file *m)
 {
 	seq_printf(m, "DirectMap4k:    %8lu kB\n",
@@ -875,6 +892,8 @@ static void merge_splitted_mapping(struct page *pgt, int level)
 
 	__ClearPageSplitpgt(pgt);
 	__free_page(pgt);
+
+	merge_page_count(level);
 }
 
 static pgprot_t pgprot_clear_protnone_bits(pgprot_t prot)
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 404024486fa5..00a9a435af49 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -143,6 +143,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 #ifdef CONFIG_X86
 		DIRECT_MAP_LEVEL2_SPLIT,
 		DIRECT_MAP_LEVEL3_SPLIT,
+		DIRECT_MAP_LEVEL1_MERGE,
+		DIRECT_MAP_LEVEL2_MERGE,
 #endif
 		NR_VM_EVENT_ITEMS
 };
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 373d2730fcf2..1a4287a4d614 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1403,6 +1403,8 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_X86
 	"direct_map_level2_splits",
 	"direct_map_level3_splits",
+	"direct_map_level1_merges",
+	"direct_map_level2_merges",
 #endif
 #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
 };
-- 
2.37.1

