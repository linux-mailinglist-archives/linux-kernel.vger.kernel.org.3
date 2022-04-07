Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FD84F7681
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 08:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241306AbiDGGpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 02:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbiDGGpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 02:45:47 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCBC1AD38B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 23:43:47 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o5-20020a17090ad20500b001ca8a1dc47aso8042170pju.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 23:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7q8TGy5f43FTrj99wrpepfbD//4/Ebrzp2Wb+EBF4pE=;
        b=MSE6Q/0ubEsaHr6jwYRQap58B7b7N6TZOESug/T0yNVOIt59Fjg4bMqGZ4jaewFdAT
         j8FnnkwR1+cQkLBatr7mmBFIcK1IJstqTQuLoz74y/sd9LY3dYRHRLV+jiUomFknyd3i
         d6V6XKVZdNIiej9R3oWnvEcGQTTU8R380BygFAOOEsJU6NbD35CQY8tv0Khn6kZRe2of
         W/rvAyQ2gHDau3kYcLcc+6ms53X/I+1VW25XlmIKyCMgke3/qNs5LFkgyq0v4mFE6GQL
         Wt1X7Hn07nGKovfk8W2h5Whudl4obTXRy4RbRWLTQrbHFl+cVUwtxIDe2n5TvopnIIIk
         v+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7q8TGy5f43FTrj99wrpepfbD//4/Ebrzp2Wb+EBF4pE=;
        b=FSq45IWRA+kBA+ilr3rGGULAWNhMjX1hvJEjVPhdy0oxFV2KJtoGcIbZD6Yy41AZpm
         xK3eZMLg7cQ6QE1uyQ19gGa59T3xzvxV3+/juK/GtlPduYiCQXnuO/eotS45n6hIunS8
         jxS8DqWD2bJ3G7Dguwd8e9dZaTLVG5RU9OWiYH1pOiswi2m12DoBK5cnReXcQsEeYXiO
         F621aaLARxp33w3ckxf1R7/RwMdjBbYFNKsDWFke0fwJNL/JY7A4+L0AF2nYt7QWevXS
         CxKCDhWLRIGhIRsK7ytLWSVNHjCMCb3o9iFYsLS5rY6Ap+Ftmc0qDyUlu4O6o6svo5hd
         L4og==
X-Gm-Message-State: AOAM532+ikfZ0+SWfCUxtZgl8gU68YSrX216H7Y74Wf2kXokwr0E6tiW
        UDLcZIiyqQOGeaOvHDBKuHLVEw==
X-Google-Smtp-Source: ABdhPJxAV3D1sK4BdA/DnNxGKAXtTwm6KCkV1Tkn8/XG4+HBbjvlt+ndb/Uv6O1IFrAADm2mCme7PQ==
X-Received: by 2002:a17:90b:e0d:b0:1ca:b15b:7d4b with SMTP id ge13-20020a17090b0e0d00b001cab15b7d4bmr14082269pjb.91.1649313827197;
        Wed, 06 Apr 2022 23:43:47 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id a11-20020a63cd4b000000b00378b9167493sm18393709pgj.52.2022.04.06.23.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 23:43:46 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH] mm: fix kernel NULL pointer dereference in page_vma_mapped_walk
Date:   Thu,  7 Apr 2022 14:40:08 +0800
Message-Id: <20220407064008.71869-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

size_to_hstate(4K) returns NULL pointer, this leads kernel BUG in
function page_vma_mapped_walk.

 BUG: kernel NULL pointer dereference, address: 0000000000000028
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 102a8b067 P4D 102a8b067 PUD 102a88067 PMD 0
 Oops: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 0 PID: 16 Comm: kworker/0:1 Kdump: loaded Tainted: G   M        E     5.18.0-rc1.bm.1-amd64 #3
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
 Workqueue: events mce_gen_pool_process
 RIP: 0010:page_vma_mapped_walk+0x4aa/0x850
 Code: 8b 77 20 48 89 c2 4c 89 ef e8 b2 c4 02 00 49 89 c4 48 89 43 30 48 85 c0 0f 84 a7 fd ff ff 48 89 ef e8 fa 9c 02 00 49 8d 7d 74 <83> 78 28 09 0f 84 1e 03 00 00 48 89 7b 38 e8 a3 cc 60 00 48 89 df
 RSP: 0018:ffffc9000008bc58 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: ffffc9000008bca0 RCX: 0000000000000009
 RDX: 0000000000200000 RSI: ffffffff82b4a460 RDI: ffff88810ac5c3f4
 RBP: 0000000000001000 R08: 0000000000001000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000007 R12: ffff888072cafd10
 R13: ffff88810ac5c380 R14: ffff888101afc440 R15: 0000000000000000
 FS:  0000000000000000(0000) GS:ffff88823fc00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000028 CR3: 0000000106ca2002 CR4: 0000000000772ef0
 PKRU: 55555554
 Call Trace:
  <TASK>
  ? preempt_count_add+0x68/0xa0
  page_mapped_in_vma+0xb4/0x230
  collect_procs.part.35+0x11b/0x440
  hwpoison_user_mappings+0x165/0x5b0
  ? zone_pcp_enable+0x16/0x30
  memory_failure+0xbea/0xd90
  ? _printk+0x58/0x6f
  uc_decode_notifier+0x4b/0xd0
  blocking_notifier_call_chain+0x60/0x90
  mce_gen_pool_process+0x3c/0x60
  process_one_work+0x1c2/0x390
  ? process_one_work+0x390/0x390
  worker_thread+0x30/0x360
  ? process_one_work+0x390/0x390
  kthread+0xe6/0x110
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x1f/0x30
  </TASK>

Fixes: 2aff7a4755bed ("mm: Convert page_vma_mapped_walk to work on PFNs")
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 mm/page_vma_mapped.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 1187f9c1ec5b..a39ec23581c9 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -163,7 +163,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		return not_found(pvmw);
 
 	if (unlikely(is_vm_hugetlb_page(vma))) {
-		unsigned long size = pvmw->nr_pages * PAGE_SIZE;
+		unsigned long size = huge_page_size(hstate_vma(vma));
 		/* The only possible mapping was handled on last iteration */
 		if (pvmw->pte)
 			return not_found(pvmw);
-- 
2.25.1

