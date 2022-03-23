Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502664E4DAB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 08:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242351AbiCWH7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 03:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbiCWH7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:59:10 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17144B873
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 00:57:40 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id bp39so525994qtb.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 00:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r41iKAI43c+0K6+pKFWIsdBKfHtyHD+d9VR6NqUvZmg=;
        b=m3gv09RuBTI4VChKq3U2t+BbGYngVCzLIJfBaobFg4LwwJM0aDdU/QoOD98YFedd95
         aJ1t6X9R0wUbOrVp9vDmWPA33pJ0MQiHq9gDnqAaLzHoLDDjmQWx1H94aY93EgJK6CX+
         EbdEYBArwVIka0fvMsLR5nQ8TLyHlG7zeTH+1vqIrE7vSNAYGkENxPJHUC585mBJE1FN
         EWeNX5XPWaxojKBAZE9UAdT3+MZAsE//sNTU9ZqlO8+TmNNDOSnv4LNQIfMIwSA2paS3
         d45ThDhNpesSVsOX1V9gIDpBwccRU7Ikuanp3jaIE1uPFRhy85oqCgDfL4nfpUZjX53u
         Wudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r41iKAI43c+0K6+pKFWIsdBKfHtyHD+d9VR6NqUvZmg=;
        b=oEYGuTDDAs4MqKADfuz0tazvqjvCueSI9ivXra3NGb8tjmLpcIYQKpIQdB7MBSk//2
         OBCke7x2dBUrVfZ/BdJmgOih6DAatF9gkRTFVi/yMUHdAjjjH6illWhfqlvZr2df073C
         VFr6sVTU9o2vCHK2NIaBOM0gygw4IpjzqI394lY8LJgMlL4tjYOJs/dwmiWtyJknXnw6
         0HdvE7jaSXDnotyn1ULLAxoDWx2rVmIOeR47pFJlzUA2/+AnPo+lNFiLCjTY8M2plB2+
         KNPveWw4KIrkgTXBY5D8JyjXZ4I+H31DxkBE+lg9JT+hUrxOPzxY0x8sWHC3/HmVQien
         mqKg==
X-Gm-Message-State: AOAM533aUVewKKN9ofNkFgq30OJt5wq9RdsMya/I3a3W3eiCbu3riC7y
        3LCqAoNmsdFc7YNNsSYGkR4=
X-Google-Smtp-Source: ABdhPJxwFkDY9Hb9zPqDADDHQyZysCI6txqKo+3o0s3vLkqC5uOLFGlD56M4b7QZMWRvO+CSQukraQ==
X-Received: by 2002:ac8:5e0e:0:b0:2e1:b6b7:10e8 with SMTP id h14-20020ac85e0e000000b002e1b6b710e8mr23229981qtx.172.1648022259497;
        Wed, 23 Mar 2022 00:57:39 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q8-20020a05622a030800b002e1c9304db8sm15641608qtw.38.2022.03.23.00.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 00:57:38 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     akpm@linux-foundation.org, david@redhat.com
Cc:     yang.yang29@zte.com.cn, dave.hansen@linux.intel.com,
        ran.xiaokai@zte.com.cn, yang.shi@linux.alibaba.com,
        saravanand@fb.com, minchan@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xu xin <xu.xin16@zte.com.cn>
Subject: [PATCH v2] mm/vmstat: add events for ksm cow
Date:   Wed, 23 Mar 2022 07:57:15 +0000
Message-Id: <20220323075714.2345743-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Yang Yang <yang.yang29@zte.com.cn>

Users may use ksm by calling madvise(, , MADV_MERGEABLE) when they want
to save memory, it's a tradeoff by suffering delay on ksm cow. Users can
get to know how much memory ksm saved by reading
/sys/kernel/mm/ksm/pages_sharing, but they don't know what's the costs
of ksm cow, and this is important of some delay sensitive tasks.

So add ksm cow events to help users evaluate whether or how to use ksm.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Reviewed-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
v2:
- fix compile error when CONFIG_KSM is not set
---
 include/linux/vm_event_item.h |  2 ++
 mm/memory.c                   | 20 +++++++++++++++++---
 mm/vmstat.c                   |  2 ++
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 16a0a4fd000b..6f32be04212f 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -131,6 +131,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		SWAP_RA_HIT,
 #ifdef CONFIG_KSM
 		KSM_SWPIN_COPY,
+		KSM_COW_SUCCESS,
+		KSM_COW_FAIL,
 #endif
 #endif
 #ifdef CONFIG_X86
diff --git a/mm/memory.c b/mm/memory.c
index 4111f97c91a0..c24d5f04fab5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3257,6 +3257,8 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	__releases(vmf->ptl)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	vm_fault_t ret = 0;
+	bool ksm = 0;
 
 	if (userfaultfd_pte_wp(vma, *vmf->pte)) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
@@ -3294,6 +3296,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	 */
 	if (PageAnon(vmf->page)) {
 		struct page *page = vmf->page;
+		ksm = PageKsm(page);
 
 		/*
 		 * We have to verify under page lock: these early checks are
@@ -3302,7 +3305,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 		 *
 		 * PageKsm() doesn't necessarily raise the page refcount.
 		 */
-		if (PageKsm(page) || page_count(page) > 3)
+		if (ksm || page_count(page) > 3)
 			goto copy;
 		if (!PageLRU(page))
 			/*
@@ -3316,7 +3319,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 			goto copy;
 		if (PageSwapCache(page))
 			try_to_free_swap(page);
-		if (PageKsm(page) || page_count(page) != 1) {
+		if (ksm || page_count(page) != 1) {
 			unlock_page(page);
 			goto copy;
 		}
@@ -3339,7 +3342,18 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	get_page(vmf->page);
 
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
-	return wp_page_copy(vmf);
+	ret = wp_page_copy(vmf);
+
+#ifdef CONFIG_KSM
+	if (ksm) {
+		if (unlikely(ret & VM_FAULT_ERROR))
+			count_vm_event(KSM_COW_FAIL);
+		else
+			count_vm_event(KSM_COW_SUCCESS);
+	}
+#endif
+
+	return ret;
 }
 
 static void unmap_mapping_range_vma(struct vm_area_struct *vma,
diff --git a/mm/vmstat.c b/mm/vmstat.c
index d5cc8d739fac..a2c29a5206ec 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1390,6 +1390,8 @@ const char * const vmstat_text[] = {
 	"swap_ra_hit",
 #ifdef CONFIG_KSM
 	"ksm_swpin_copy",
+	"ksm_cow_success",
+	"ksm_cow_fail",
 #endif
 #endif
 #ifdef CONFIG_X86
-- 
2.25.1

