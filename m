Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3715048C38D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 12:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240072AbiALLwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 06:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiALLwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 06:52:22 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468DAC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 03:52:22 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id a8so2638282qvx.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 03:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kwp9C8fnBtFWbIneloujcdboDJVGe0JvYQ1JElTpShc=;
        b=JetQGrILsOc2Z/T7ipIO7jVs5rBEi47xxb8V4FvOnIslsD7q7jdCvXBriV5V+ylAYd
         hBVIir4kZabGqXh282fMSC1OJ/PhF0u+2lCXXkXJ99Xr+A44+0xbhrZsTZEApEpk8TzV
         IkXcX+FHIwItPm3OjwYmxo+iHCHk6PPYI3GOaPiN4Mm+HgLkCbsxs2j1hn0RqsxKCyQZ
         l6vbxhuwBjnKqrFt3y12LlcqICWXtCtWAG5YQXPvyhA7VY5mpMKVaFcftkJcBWmm2ftO
         c20ZRn4/DNX9BL6evPek5ED/2OPCuiaTtPtSB5oF1tBfxJ8TYJ2nC6ehssQi3gXoB2v3
         XMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kwp9C8fnBtFWbIneloujcdboDJVGe0JvYQ1JElTpShc=;
        b=d4RV2eauy9lpFVe79CiTw1yPFUl68WBBeYyUfQb4vXnmUWG4qXx1LPX+k43CKx6Ndh
         08grR/soImDboti1AyNscvqQiA8Xh9PGBxfP2aKVXyDy9PU6mcN6PSMa7J1NSY+xhlwP
         sxDtSoYXtD5I4z0/uTIyvXnKkt/8z/LqCwxh7x8JiBCpg/f3Dlsakdxzv5+pTlL5rDBQ
         Xwg5yv5gWnrq02emVtBEG+C4wd9JytZxe9vaBx8KYIgzkqzVFk8L7czW0aMgULnIb/UE
         AksVOuQd8AFxp8GwpODIC1epWatGlBzuj/WRxQgAmBL5Vg2xhIV1kYnD9sHYz678akW4
         1zVw==
X-Gm-Message-State: AOAM532djkrIK5DVJQ98SokLHWYwKwvnKuTrj5P7gHAScLn/LWY9q9TV
        F2ioNLE7WlVDhOmR6NK3oFU=
X-Google-Smtp-Source: ABdhPJz4mGGrBqnl1slPX5BgMxnineBmeJtsNPjrx3r//69wotCsNDDt31+QTSllzoqy3/7pkdtT5A==
X-Received: by 2002:a05:6214:2302:: with SMTP id gc2mr7543232qvb.126.1641988341402;
        Wed, 12 Jan 2022 03:52:21 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b10sm6631914qtb.24.2022.01.12.03.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 03:52:20 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     akpm@linux-foundation.org, yang.shi@linux.alibaba.com,
        ying.huang@intel.com
Cc:     dave.hansen@linux.intel.com, yang.yang29@zte.com.cn,
        saravanand@fb.com, minchan@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: [PATCH] mm/vmstat: add event for ksm swapping in copy
Date:   Wed, 12 Jan 2022 11:51:11 +0000
Message-Id: <20220112115110.669160-1-yang.yang29@zte.com.cn>
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
 include/linux/vm_event_item.h | 3 +++
 mm/ksm.c                      | 1 +
 mm/vmstat.c                   | 3 +++
 3 files changed, 7 insertions(+)

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
index c20bd4d9a0d9..b6b382fde3d4 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2595,6 +2595,7 @@ struct page *ksm_might_need_to_copy(struct page *page,
 		SetPageDirty(new_page);
 		__SetPageUptodate(new_page);
 		__SetPageLocked(new_page);
+		count_vm_event(KSM_SWPIN_COPY);
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

