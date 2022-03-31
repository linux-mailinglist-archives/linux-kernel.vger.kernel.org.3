Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10024ED2A3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 06:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiCaEKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 00:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiCaEJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 00:09:20 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C53C170084;
        Wed, 30 Mar 2022 20:56:59 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id g8so18827481qke.2;
        Wed, 30 Mar 2022 20:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tYlHPxM0iDi5VXE98hgeozahqYJk78JaFFeV+qzNw5U=;
        b=mTmT7+N63PXuIwB75+CKvFI6cw/jzFICsKFlmrX98DCY4KgVobDxkUkLrPbILjWEVd
         zOpsJzohasYTU2cri3mhczLOHO+85IFJWAcIzlnZ8sYbVwKoGAyN3ZrI0vtWoa7Qu3eu
         CsqMCtZFWjlutPRNC7lKg6mZUe8Sh5MDsmm5GAacxLBCKifK/EA4n2cFQBko12jzZ9sS
         WKQUNIcMTTE9y9FtrLpqhMIlKbYvWdq1U+ww/1au0hwzkHBamg7+Phf1Jd5WuYcisENx
         lCO2kL34hCyKaR+8Rf8wpTYtiFvSRdvzMZ6EfRXAZk+xbijJO3mI2cpMPxQ0aZw2TTYf
         kybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tYlHPxM0iDi5VXE98hgeozahqYJk78JaFFeV+qzNw5U=;
        b=STUmnVhXh3Sl9XglOkQc0q42kfRim7WNYEzUWi3rEpWsak8Bo6/GdGb0uFif48+39l
         MDu5uiw2YHoHws3uWmyTOkkceq6y3WAr8IPjocqb1k/rJXFV9Z7RH3T4eylr/ke3QcjJ
         XK4AmlGHGuqjb/+YfFGBCVh5z9MjAdpe5+SE17gIZyiZEnfqxJ35AYpVBnacvZPzq1Om
         IY8P6NLbrP/GEH/X/6fh1xel6nG34idP+lZDZBQrAmfPZ/OG/YzwO6lG3mxybkTgXqGk
         AfhCaNbvBUJvVi8UqZPPH/yVDw1kXCkGnxNN8f2quvDKfJ+F5A+BMkkittxpkhMtKVIB
         B1xQ==
X-Gm-Message-State: AOAM5317i4sAHqNIthshm6txwNYl0SRLQpYDUY9za6OmGu3zO+ivoggd
        bUXnHg0JH+c2n+y8Qwb3nQGP/gc3O/o=
X-Google-Smtp-Source: ABdhPJzyPrz0p+L/ALJneQJkAZo6ZUHwvs4kf6iDO0DACiqXPcs8bbEYZ5Igo5IyJWR4z4os6/CMDA==
X-Received: by 2002:a37:9503:0:b0:67e:977:9ff6 with SMTP id x3-20020a379503000000b0067e09779ff6mr2101575qkd.10.1648699018774;
        Wed, 30 Mar 2022 20:56:58 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f17-20020ac87f11000000b002e1e831366asm18698404qtk.77.2022.03.30.20.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 20:56:57 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     akpm@linux-foundation.org, david@redhat.com, willy@infradead.org
Cc:     corbet@lwn.net, yang.yang29@zte.com.cn, yang.shi@linux.alibaba.com,
        dave.hansen@linux.intel.com, saravanand@fb.com, minchan@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, jhubbard@nvidia.com,
        xu xin <xu.xin16@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: [PATCH v5] mm/vmstat: add events for ksm cow
Date:   Thu, 31 Mar 2022 03:56:17 +0000
Message-Id: <20220331035616.2390805-1-yang.yang29@zte.com.cn>
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
Also update Documentation/admin-guide/mm/ksm.rst with new added events.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
v2:
- fix compile error when CONFIG_KSM is not set
v3:
- delete KSM_COW_FAIL event
v4:
- modify /Documentation/admin-guide/mm/ksm.rst. And let cow_ksm before
- ksm_swpin_copy, so if new cow_* event could add before cow_ksm.
v5:
- fix compile error when CONFIG_SWAP is not set
---
 Documentation/admin-guide/mm/ksm.rst | 18 ++++++++++++++++++
 include/linux/vm_event_item.h        |  3 +++
 mm/memory.c                          |  4 ++++
 mm/vmstat.c                          |  3 +++
 4 files changed, 28 insertions(+)

diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
index 97d816791aca..b244f0202a03 100644
--- a/Documentation/admin-guide/mm/ksm.rst
+++ b/Documentation/admin-guide/mm/ksm.rst
@@ -184,6 +184,24 @@ The maximum possible ``pages_sharing/pages_shared`` ratio is limited by the
 ``max_page_sharing`` tunable. To increase the ratio ``max_page_sharing`` must
 be increased accordingly.
 
+Monitoring KSM events
+=====================
+
+There are some counters in /proc/vmstat that may be used to monitor KSM events.
+KSM might help save memory, it's a tradeoff by may suffering delay on KSM COW
+or on swapping in copy. Those events could help users evaluate whether or how
+to use KSM. For example, if cow_ksm increases too fast, user may decrease the
+range of madvise(, , MADV_MERGEABLE).
+
+cow_ksm
+	is incremented every time a KSM page triggers copy on write (COW)
+	when users try to write to a KSM page, we have to make a copy.
+
+ksm_swpin_copy
+	is incremented every time a KSM page is copied when swapping in
+	note that KSM page might be copied when swapping in because do_swap_page()
+	cannot do all the locking needed to reconstitute a cross-anon_vma KSM page.
+
 --
 Izik Eidus,
 Hugh Dickins, 17 Nov 2009
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 16a0a4fd000b..e83967e4c20e 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -133,6 +133,9 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		KSM_SWPIN_COPY,
 #endif
 #endif
+#ifdef CONFIG_KSM
+		COW_KSM,
+#endif
 #ifdef CONFIG_X86
 		DIRECT_MAP_LEVEL2_SPLIT,
 		DIRECT_MAP_LEVEL3_SPLIT,
diff --git a/mm/memory.c b/mm/memory.c
index 4111f97c91a0..12925ceaf745 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3339,6 +3339,10 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	get_page(vmf->page);
 
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
+#ifdef CONFIG_KSM
+	if (PageKsm(vmf->page))
+		count_vm_event(COW_KSM);
+#endif
 	return wp_page_copy(vmf);
 }
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index d5cc8d739fac..79015f144b15 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1392,6 +1392,9 @@ const char * const vmstat_text[] = {
 	"ksm_swpin_copy",
 #endif
 #endif
+#ifdef CONFIG_KSM
+	"cow_ksm",
+#endif
 #ifdef CONFIG_X86
 	"direct_map_level2_splits",
 	"direct_map_level3_splits",
-- 
2.25.1

