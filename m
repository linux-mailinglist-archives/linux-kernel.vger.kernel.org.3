Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137F454A838
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 06:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351702AbiFNEgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 00:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344415AbiFNEgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 00:36:20 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052AA2E6BE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 21:36:19 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x138so7529567pfc.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 21:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SXchz2Eq62MMA7Wwy1fJEQQa85RBXUsLGi6XIUd5z/w=;
        b=Fbk9q6WUm6i0BymMi/Y7fwWYv80c89cVIqZEVaTWFvNpcrKioUsVVQqayGSVanUOha
         aocQyw1qPeQ0knzVI5hhBwPQDpvYoNZGbZqha3WjGeayqbqwwQc3SxYMJQaq1e9zM5LO
         EXlYh0l4sckSSMpFhLRd5TY9HbmesvovmoYsGeIoTjOPHrWspOQjp38RzwYUb365UnSV
         7oCeF0Jd7hrLpuy4LlDGH3n/PhP031TrIofc3PTlFNp7DBdK4ZypVqnHsLrA5F7hjOo8
         sZvT8V9L7qM0NfEL1p2MUnCJZaPwxrEFIHEfbFpmrSxMnYXd1ET5QfkEXtF4ztSqG0is
         1qtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SXchz2Eq62MMA7Wwy1fJEQQa85RBXUsLGi6XIUd5z/w=;
        b=eM3fsFZU4e6f1Amm9Xelt5z4oP7RBN7oPuWyWrizpKam5Cu+YzMezIDuV3tWPznIj4
         rku7SVfQZJQZxAVEt6tJzTy6RWhklt4qBWefq3MBXWFLBExwFeXBTwKU6FtdDW3NxzNJ
         9QuHfjWPUF+55o7UhMKma8PxIlXZscLximcg7F5SQemfWxoaJNoOmGyXGfsVVaoeLFFi
         /sN+HoY2dupEA3eZ6jwERL56dgfdm+0vdNW9i0ElSQnnO2ydveenbVGSlqDB2FmrUa2n
         X2rOLHePpIE7XWpe20SpxiL7ZLRGftgPJlnMzGzrR6qFcGVhKk916B+0ckPQs97k7B1I
         lCCg==
X-Gm-Message-State: AJIora8gAKMeLGPNabq+z6/yrkZ7OAmoS4Rxtj48kXdV6CUaJE7LyYXR
        MHNMQvZEGDHFu4vKi3C5YQ45amhCABdDDBpf
X-Google-Smtp-Source: AGRyM1vTSeRW1BT+lNyZVYYasdUzmAo+GIbXDrYrpv4eRD33/W43mOHhoz3/Bf3q8zf2OscEojpb0Q==
X-Received: by 2002:a63:8b42:0:b0:408:a938:289b with SMTP id j63-20020a638b42000000b00408a938289bmr785628pge.201.1655181378431;
        Mon, 13 Jun 2022 21:36:18 -0700 (PDT)
Received: from always-T480.www.tendawifi.com ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id t16-20020a63b250000000b00401a7b4f137sm6469120pgo.41.2022.06.13.21.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 21:36:17 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
        linmiaohe@huawei.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v4 2/2] mm/memory-failure: disable unpoison once hw error happens
Date:   Tue, 14 Jun 2022 12:38:30 +0800
Message-Id: <20220614043830.99607-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220614043830.99607-1-pizhenwei@bytedance.com>
References: <20220614043830.99607-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently unpoison_memory(unsigned long pfn) is designed for soft
poison(hwpoison-inject) only. Since 17fae1294ad9d, the KPTE gets
cleared on a x86 platform once hardware memory corrupts.

Unpoisoning a hardware corrupted page puts page back buddy only,
the kernel has a chance to access the page with *NOT PRESENT* KPTE.
This leads BUG during accessing on the corrupted KPTE.

Do not allow to unpoison hardware corrupted page in unpoison_memory() to
avoid BUG like this:

 Unpoison: Software-unpoisoned page 0x61234
 BUG: unable to handle page fault for address: ffff888061234000
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0002) - not-present page
 PGD 2c01067 P4D 2c01067 PUD 107267063 PMD 10382b063 PTE 800fffff9edcb062
 Oops: 0002 [#1] PREEMPT SMP NOPTI
 CPU: 4 PID: 26551 Comm: stress Kdump: loaded Tainted: G   M       OE     5.18.0.bm.1-amd64 #7
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996) ...
 RIP: 0010:clear_page_erms+0x7/0x10
 Code: ...
 RSP: 0000:ffffc90001107bc8 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: 0000000000000901 RCX: 0000000000001000
 RDX: ffffea0001848d00 RSI: ffffea0001848d40 RDI: ffff888061234000
 RBP: ffffea0001848d00 R08: 0000000000000901 R09: 0000000000001276
 R10: 0000000000000003 R11: 0000000000000000 R12: 0000000000000001
 R13: 0000000000000000 R14: 0000000000140dca R15: 0000000000000001
 FS:  00007fd8b2333740(0000) GS:ffff88813fd00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: ffff888061234000 CR3: 00000001023d2005 CR4: 0000000000770ee0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  <TASK>
  prep_new_page+0x151/0x170
  get_page_from_freelist+0xca0/0xe20
  ? sysvec_apic_timer_interrupt+0xab/0xc0
  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
  __alloc_pages+0x17e/0x340
  __folio_alloc+0x17/0x40
  vma_alloc_folio+0x84/0x280
  __handle_mm_fault+0x8d4/0xeb0
  handle_mm_fault+0xd5/0x2a0
  do_user_addr_fault+0x1d0/0x680
  ? kvm_read_and_reset_apf_flags+0x3b/0x50
  exc_page_fault+0x78/0x170
  asm_exc_page_fault+0x27/0x30

Suggested by David&Naoya, disable unpoison mechanism when a real HW error
happens.

Fixes: 847ce401df392 ("HWPOISON: Add unpoisoning support")
Fixes: 17fae1294ad9d ("x86/{mce,mm}: Unmap the entire page if the whole page is affected and poisoned")
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 Documentation/vm/hwpoison.rst | 3 ++-
 mm/hwpoison-inject.c          | 6 ++++++
 mm/memory-failure.c           | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/vm/hwpoison.rst b/Documentation/vm/hwpoison.rst
index c832a8b192d4..ac439381cad4 100644
--- a/Documentation/vm/hwpoison.rst
+++ b/Documentation/vm/hwpoison.rst
@@ -120,7 +120,8 @@ Testing
   unpoison-pfn
 	Software-unpoison page at PFN echoed into this file. This way
 	a page can be reused again.  This only works for Linux
-	injected failures, not for real memory failures.
+	injected failures, not for real memory failures. Once any hardware
+	memory failure happens, the feature is disabled.
 
   Note these injection interfaces are not stable and might change between
   kernel versions
diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
index 9e522ecedeef..787d2daf41e8 100644
--- a/mm/hwpoison-inject.c
+++ b/mm/hwpoison-inject.c
@@ -7,6 +7,7 @@
 #include <linux/swap.h>
 #include <linux/pagemap.h>
 #include <linux/hugetlb.h>
+#include <linux/swapops.h>
 #include "internal.h"
 
 static struct dentry *hwpoison_dir;
@@ -65,6 +66,11 @@ static int hwpoison_unpoison(void *data, u64 val)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (atomic_read(&hwpoisoned_pages) != atomic_long_read(&num_poisoned_pages)) {
+		pr_info("Unpoison is disabled after hardware memory failure happened\n");
+		return -EOPNOTSUPP;
+	}
+
 	ret = unpoison_memory(val);
 	if (!ret) {
 		atomic_dec(&hwpoisoned_pages);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index b85661cbdc4a..a3e6bd4b5528 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -68,6 +68,7 @@ int sysctl_memory_failure_early_kill __read_mostly = 0;
 int sysctl_memory_failure_recovery __read_mostly = 1;
 
 atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
+EXPORT_SYMBOL_GPL(num_poisoned_pages);
 
 static bool __page_handle_poison(struct page *page)
 {
-- 
2.20.1

