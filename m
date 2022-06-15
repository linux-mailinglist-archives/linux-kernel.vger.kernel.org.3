Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D773A54BF8F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 04:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239433AbiFOCFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 22:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239432AbiFOCFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 22:05:03 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D659A4C79C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 19:05:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id cx11so9981649pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 19:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ep2sWjEOrgSF336dlpmSeKloAzp4+PSakvgoXseW1lo=;
        b=mmB1Pq0SmF+MQtE0Vmg4IYkIXjXDa5r5drYmX1DTPSbrymbOsu0LIWOu2GqOXX7/sD
         LybOzWWS50ius7/f8fWYcZNMegR0a97Syjaf4z6AmerU2CMB4jHVIVKDjEKNHbnW3OhB
         C8VBSQQ5ToabLpBJc0R6L5IXP21eTHa2xkjsetNiJIKqjNEDwqNayALGmP16ee+neT2Y
         BbKWa7utZpaih6wnv8S2Ujh9qqvvRY0Jyn+EAgME6LKVdK7gYyW9Zja72jnTPXUfRpYc
         Kdg8fCJCTU8UPWjtG/JWsE/GSlTJ5nIOcyTCRKC9ePw9AYMLIS33XA6tQeHnwzLiUQi5
         0pOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ep2sWjEOrgSF336dlpmSeKloAzp4+PSakvgoXseW1lo=;
        b=I4EqDQnNnTjvMVfof2mpHHqiRB/WoOfHngfHVKSDYqCecbGRRYJQjJTX+p7G1xY+g7
         SzrgmMESIlwF+csap0nsm6mFuapKU7QDItSUDu5xNBc+FnFZyku8VY3AfP6DwNdoEC23
         i14err/olribCmF79PJaDFaBFSvNR8nTu4Oz2mfEnwTnxGIVi8xVGPE7TP/zKRNsmZOZ
         bPWYCuCqb7/NKvn+K/tVIqaL54FiZpXiz9d25iL6cIvzltZn5KcqqP5PKThl1pYH2adX
         z19Xwi/FfqZleNlqfYMotRRCiJjFHhHTct/IULuOqIdCI5D6qEXNdEUBSApPKHeRQjbv
         SXaQ==
X-Gm-Message-State: AOAM532UaBH0McBru9q8WTN0ii82khdtm7JLgfkPSdfs5mhcCS59F/as
        rPVUoPCgzLV1MkOAQmvPrDOv7g==
X-Google-Smtp-Source: ABdhPJyhtjVtLESv2UIwOi7gfxkUawtd7TckD4a15TywnCw9LkIojwicsZN5yN/SgL3AHrpzIDpAkg==
X-Received: by 2002:a17:902:ea03:b0:166:ab55:d7ee with SMTP id s3-20020a170902ea0300b00166ab55d7eemr6918665plg.103.1655258702254;
        Tue, 14 Jun 2022 19:05:02 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id f17-20020aa79691000000b00518d06efbc8sm8538290pfk.98.2022.06.14.19.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 19:05:01 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     pizhenwei@bytedance.com, naoya.horiguchi@nec.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
        linmiaohe@huawei.com, gregkh@linuxfoundation.org
Subject: [PATCH v5 1/1] mm/memory-failure: disable unpoison once hw error happens
Date:   Wed, 15 Jun 2022 10:00:05 +0800
Message-Id: <20220615020005.246295-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615020005.246295-1-pizhenwei@bytedance.com>
References: <20220615020005.246295-1-pizhenwei@bytedance.com>
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

Suggested by David&Naoya, disable unpoison mechanism when a real HW error
happens to avoid BUG like this:

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

Fixes: 847ce401df392 ("HWPOISON: Add unpoisoning support")
Fixes: 17fae1294ad9d ("x86/{mce,mm}: Unmap the entire page if the whole page is affected and poisoned")
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 Documentation/vm/hwpoison.rst |  3 ++-
 drivers/base/memory.c         |  2 +-
 include/linux/mm.h            |  1 +
 mm/hwpoison-inject.c          |  2 +-
 mm/madvise.c                  |  2 +-
 mm/memory-failure.c           | 12 ++++++++++++
 6 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/Documentation/vm/hwpoison.rst b/Documentation/vm/hwpoison.rst
index c742de1769d1..b9d5253c1305 100644
--- a/Documentation/vm/hwpoison.rst
+++ b/Documentation/vm/hwpoison.rst
@@ -120,7 +120,8 @@ Testing
   unpoison-pfn
 	Software-unpoison page at PFN echoed into this file. This way
 	a page can be reused again.  This only works for Linux
-	injected failures, not for real memory failures.
+	injected failures, not for real memory failures. Once any hardware
+	memory failure happens, this feature is disabled.
 
   Note these injection interfaces are not stable and might change between
   kernel versions
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 084d67fd55cc..bc60c9cd3230 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -558,7 +558,7 @@ static ssize_t hard_offline_page_store(struct device *dev,
 	if (kstrtoull(buf, 0, &pfn) < 0)
 		return -EINVAL;
 	pfn >>= PAGE_SHIFT;
-	ret = memory_failure(pfn, 0);
+	ret = memory_failure(pfn, MF_SW_SIMULATED);
 	if (ret == -EOPNOTSUPP)
 		ret = 0;
 	return ret ? ret : count;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index bc8f326be0ce..4346e51484ba 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3232,6 +3232,7 @@ enum mf_flags {
 	MF_MUST_KILL = 1 << 2,
 	MF_SOFT_OFFLINE = 1 << 3,
 	MF_UNPOISON = 1 << 4,
+	MF_SW_SIMULATED = 1 << 5,
 };
 extern int memory_failure(unsigned long pfn, int flags);
 extern void memory_failure_queue(unsigned long pfn, int flags);
diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
index 5c0cddd81505..65e242b5a432 100644
--- a/mm/hwpoison-inject.c
+++ b/mm/hwpoison-inject.c
@@ -48,7 +48,7 @@ static int hwpoison_inject(void *data, u64 val)
 
 inject:
 	pr_info("Injecting memory failure at pfn %#lx\n", pfn);
-	err = memory_failure(pfn, 0);
+	err = memory_failure(pfn, MF_SW_SIMULATED);
 	return (err == -EOPNOTSUPP) ? 0 : err;
 }
 
diff --git a/mm/madvise.c b/mm/madvise.c
index d7b4f2602949..0316bbc6441b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1112,7 +1112,7 @@ static int madvise_inject_error(int behavior,
 		} else {
 			pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
 				 pfn, start);
-			ret = memory_failure(pfn, MF_COUNT_INCREASED);
+			ret = memory_failure(pfn, MF_COUNT_INCREASED | MF_SW_SIMULATED);
 			if (ret == -EOPNOTSUPP)
 				ret = 0;
 		}
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index b85661cbdc4a..385b5e99bfc1 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -69,6 +69,8 @@ int sysctl_memory_failure_recovery __read_mostly = 1;
 
 atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
 
+static bool hw_memory_failure;
+
 static bool __page_handle_poison(struct page *page)
 {
 	int ret;
@@ -1768,6 +1770,9 @@ int memory_failure(unsigned long pfn, int flags)
 
 	mutex_lock(&mf_mutex);
 
+	if (!(flags & MF_SW_SIMULATED))
+		hw_memory_failure = true;
+
 	p = pfn_to_online_page(pfn);
 	if (!p) {
 		res = arch_memory_failure(pfn, flags);
@@ -2103,6 +2108,13 @@ int unpoison_memory(unsigned long pfn)
 
 	mutex_lock(&mf_mutex);
 
+	if (hw_memory_failure) {
+		unpoison_pr_info("Unpoison: Disabled after HW memory failure %#lx\n",
+				 pfn, &unpoison_rs);
+		ret = -EOPNOTSUPP;
+		goto unlock_mutex;
+	}
+
 	if (!PageHWPoison(p)) {
 		unpoison_pr_info("Unpoison: Page was already unpoisoned %#lx\n",
 				 pfn, &unpoison_rs);
-- 
2.20.1

