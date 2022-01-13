Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1965548D076
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 03:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiAMCj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 21:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiAMCjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 21:39:22 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359BBC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 18:39:21 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id q3so5213939qvc.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 18:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lqQJYTBMH8B+bnFx1VA3RJyA//jI2a1rkVu0LgwSkjk=;
        b=hIsGUzSYfWNfEXCNlEJXcw6YjqgD0bx3I4IR6WezFYBf2X3fXortLDD2U/JQbeoW7f
         pwOiJV/MiVLV33INNOhlkWKKZZXE8TEUSnZM0trp2QH37OrISpifxFeQZLlavpMtN5wo
         1iupVVIZKzo5Xca+tzTCibSZNy/FuN4HwHdvX6ckUgyGwkp19sVGf1lYqqhNyw1VxZfm
         DCmSackQ/R7Em8euzwVYdeaxgL3je/Qucf7hfODNYzLM+CKwExNvt4xvASOza1WVfAf0
         f+ZF6y1pb7uZKBVltVnl39HSAUOv3i7IQVgOG4xSomfGgae+UvI0rEsa92gQ+oTmVqfe
         /P9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lqQJYTBMH8B+bnFx1VA3RJyA//jI2a1rkVu0LgwSkjk=;
        b=Q91d/CjfPPHpqLUURTO3GnX0WgFhR8Qe2qRpMzA4hWDGhk7/oquYoNYqR5ImY4XJNV
         Rat3vfIT0WA+V0z55/pweyDKrNrMW2eDxoOdbEmtIGMiHHnmiVf943bPem7w8uXYo1VY
         yI92GfU+NZ5wXNGc9gm1p0cB1K2lr7n9KlStiZAp6FSfyVpayUWpxocDjBG+pJspRgBu
         YITgR/mB82IYuVnH1c8tGDOVaeZIoEDLHBHcDrGh7A7zO4jXNnGPLMpsxeiZ3Lueeqzj
         tiMGFqctK9JqNAWAlZgzZ5xfBkkX/lBStE5rHwv+FaBphjh8k13MU1/2Rn+UvnCLexGH
         2Wwg==
X-Gm-Message-State: AOAM532RQSpMUo8AB9ziXfBSU1ck3VamqehdIRGWLkVPJiE2H95fRIOP
        SCmoqJLs/a/xTvMA0/5FUqA=
X-Google-Smtp-Source: ABdhPJwnteAz+SPrNj6aAHpP32YYEOHGwrk67ByNbeZw1HmQAR/CwtX1Mvkidt4Sn/vIQ/j5PcwqNA==
X-Received: by 2002:a05:6214:4009:: with SMTP id kd9mr2403842qvb.3.1642041560431;
        Wed, 12 Jan 2022 18:39:20 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id v10sm1065991qkp.105.2022.01.12.18.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 18:39:18 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     akpm@linux-foundation.org, yang.shi@linux.alibaba.com,
        ying.huang@intel.com
Cc:     yang.yang29@zte.com.cn, dave.hansen@linux.intel.com,
        minchan@kernel.org, saravanand@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: [PATCH v2] mm/vmstat: add event for ksm swapping in copy
Date:   Thu, 13 Jan 2022 02:38:40 +0000
Message-Id: <20220113023839.758845-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

When faults in from swap what used to be a KSM page and that page
had been swapped in before, system has to make a copy, and leaves
remerging the pages to a later pass of ksmd.

That is not good for performace, we'd better to reduce this kind
of copy. There are some ways to reduce it, for example lessen
swappiness or madvise(, , MADV_MERGEABLE) range. So add this
event to support doing this tuning. Just like this patch:
"mm, THP, swap: add THP swapping out fallback counting".

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
v2:
- fix compile error when CONFIG_SWAP is not set
---
 include/linux/vm_event_item.h | 3 +++
 mm/ksm.c                      | 3 +++
 mm/vmstat.c                   | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 7b2363388bfa..16a0a4fd000b 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -129,6 +129,9 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 #ifdef CONFIG_SWAP
 		SWAP_RA,
 		SWAP_RA_HIT,
+#ifdef CONFIG_KSM
+		KSM_SWPIN_COPY,
+#endif
 #endif
 #ifdef CONFIG_X86
 		DIRECT_MAP_LEVEL2_SPLIT,
diff --git a/mm/ksm.c b/mm/ksm.c
index c20bd4d9a0d9..4a7f8614e57d 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2595,6 +2595,9 @@ struct page *ksm_might_need_to_copy(struct page *page,
 		SetPageDirty(new_page);
 		__SetPageUptodate(new_page);
 		__SetPageLocked(new_page);
+#ifdef CONFIG_SWAP
+		count_vm_event(KSM_SWPIN_COPY);
+#endif
 	}
 
 	return new_page;
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 4057372745d0..d2b9f27eb1c4 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1385,6 +1385,9 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_SWAP
 	"swap_ra",
 	"swap_ra_hit",
+#ifdef CONFIG_KSM
+	"ksm_swpin_copy",
+#endif
 #endif
 #ifdef CONFIG_X86
 	"direct_map_level2_splits",
-- 
2.25.1

