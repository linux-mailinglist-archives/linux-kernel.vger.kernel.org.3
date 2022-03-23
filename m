Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26354E4B5C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 04:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241465AbiCWDUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 23:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiCWDUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 23:20:13 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B9F31342
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 20:18:44 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id ke15so328824qvb.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 20:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HuZMniKUiLdmMq0S/smNDGx4nZr+J2VHjPsTBck+11s=;
        b=Tse20CMLZPb2xi5LDlL7G8zi9e/ZhtX9/urs8GbZmvyP4uSFlC4CZWjoI4aA/TJyvz
         qghQYdMJQ+pyEUGbMWo9FBTfHMapfLu7tHIX4XirSbAIpnoBipCMJ6EZ03PmxIMGhjW1
         okzbtJ8uJ4EO1lPxEQfPOwGJAmG6jP26zu52g0/HxhUJMotkPKJ/sSRDXG721rlw1qzD
         QEsaNlShMRACfhXdIbQfo4xyjU9cz+lcVORvKr2GnNQ1VmYSylY5FU2JtkhwI2EV7Yqf
         qAaK9AiJ9R8/45dVaAXa9fu6S8fKx3RMOF7IPXHIED5AFMxcPAxaDrpl4iXWR43LCKrV
         dnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HuZMniKUiLdmMq0S/smNDGx4nZr+J2VHjPsTBck+11s=;
        b=BytTRZ71VK0baA2wTDB5Gogu5WLmm97m8b5XbHKzLVhjw7peIqK3VTgZA91lwBvrjw
         IDxw6qmYgaYd/KJDZvLASTi1Ua5nJJOFy5Av7mMV/VMLW8LrbwjFLDkXm1y6OaB2URoU
         1PwIy/MzuIFwoGQkMRUW+GeV1C+o47IZX919JNkKHFXiEMzHZMcLjkeQqnUfmNgnOJH1
         cDv3NNG54frK+MwZkw2XopWrygnAqyDA+bVAwvNOi198++dqwgP546eMNfvL7yiGnUCN
         1Byl2qmMe8/sIRCUb53J3LmJjQ3L9nGDM2wsZ4j7sGfEvD/W3acSLbhgK/xL0DYWwrCg
         kKrw==
X-Gm-Message-State: AOAM532c2CpZpqmcGIq9ep2U7Jpg+R31IlZU/uEr5CLHQSt83F/t0RU2
        Dy/qSVQYl0SE6G9xx8vWUUI=
X-Google-Smtp-Source: ABdhPJzhksxHW4/rsLVdg+jn6M3FiJF1MkqN5pSAr6Z+9q+YhbyelyH/4MqEL6Bw9r3GhLufC8dKrg==
X-Received: by 2002:ad4:5ccb:0:b0:441:1abe:1b8a with SMTP id iu11-20020ad45ccb000000b004411abe1b8amr11696377qvb.7.1648005523965;
        Tue, 22 Mar 2022 20:18:43 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w13-20020a05622a134d00b002e2280215f6sm2108254qtk.54.2022.03.22.20.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 20:18:43 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     akpm@linux-foundation.org, david@redhat.com
Cc:     yang.yang29@zte.com.cn, dave.hansen@linux.intel.com,
        yang.shi@linux.alibaba.com, ran.xiaokai@zte.com.cn,
        saravanand@fb.com, minchan@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xu xin <xu.xin16@zte.com.cn>
Subject: [PATCH] mm/vmstat: add events for ksm cow
Date:   Wed, 23 Mar 2022 03:17:31 +0000
Message-Id: <20220323031730.2342930-1-yang.yang29@zte.com.cn>
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
 include/linux/vm_event_item.h |  2 ++
 mm/memory.c                   | 18 +++++++++++++++---
 mm/vmstat.c                   |  2 ++
 3 files changed, 19 insertions(+), 3 deletions(-)

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
index 4111f97c91a0..06c92f322cdb 100644
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
@@ -3339,7 +3342,16 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	get_page(vmf->page);
 
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
-	return wp_page_copy(vmf);
+	ret = wp_page_copy(vmf);
+
+	if (ksm) {
+		if (unlikely(ret & VM_FAULT_ERROR))
+			count_vm_event(KSM_COW_FAIL);
+		else
+			count_vm_event(KSM_COW_SUCCESS);
+	}
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

