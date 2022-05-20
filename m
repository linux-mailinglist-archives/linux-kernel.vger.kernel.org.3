Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5608552E5F7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 09:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346443AbiETHMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 03:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346333AbiETHLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 03:11:14 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42C612AAA
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:11:12 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id q18so6659033pln.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8UjG0o5nMa5Xyc82qdtjuxq129pWxy4iyjYulNwlNyA=;
        b=FvCeZJA8to5GxS3vQ+6fEvcNONch1qOBkoX5suR+8ddUyYlJGtARJLZxz+JH/IUMkB
         WzdFCPBBFVH0Kw7QBKqmnA76Xq3DyDJuJ83IjvJhLHrZWuaR7nTmavaZq+wA9z9kAufw
         9ObahDXqdskxgzCq2Az+G/kXC7yoV8vkmgL28dcC95bPcjUl2OgsjvY5cyKsfPchKwLt
         wSwc3aRZ0KQYCcoztiAPb3hWP6fBEuSOHBCZTVYfHLlI3PU+WBHhgCMYrUg7dAnYxsPc
         wlYqP422pmULChg9jq/rMp7aI3PnP8y/um8J2Zu88mD9Ip5pWM9xTXFaPYIGnaY+pQLV
         gZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8UjG0o5nMa5Xyc82qdtjuxq129pWxy4iyjYulNwlNyA=;
        b=RGA8e5sEwbaf39I5gvQpF6swM3tCm9ityS+HHyvPl3XFkpzgVbI/E5vvzUqg7wiHqV
         Q3lax2AKaHpXUPIQru6P6N/fXpcyIhejgiliZlp8AgmEQ/8Alg6qvCqQZALkR7vfEG8c
         qFv31BY9KWxS8y1WljLp/St93a/gihkYqe2ZQv2chyj52tKdRodqSkpLMGJ31/Yrfal9
         KpAqq6A+yiarzMeIEc/+WmFCcZ9TMMBPS9imTUkXTVyH+qYnB3ec6QutBtThzx8p7DJz
         k5ur/1VA3lxMQcmXf+O7n7ecv5lhsJqNGOXlVu5xdRTUACyLKf7FqZI4GlggvDM4HDIS
         A+lQ==
X-Gm-Message-State: AOAM533ru+xGDP0kRzUCltIaD2VtC+BzRcijlJ5oA8HWQK8VejUtpyPn
        phGXb2zyaB8gVlWL0bbNsddaQg==
X-Google-Smtp-Source: ABdhPJy7dN6W1unJEUkIMo5mIF8IIbhU7NS+eo2bgsyEgDOQL52VpJ/gWLWzofZM6zyA0hz0bJY9iQ==
X-Received: by 2002:a17:902:b703:b0:158:2667:7447 with SMTP id d3-20020a170902b70300b0015826677447mr8337607pls.92.1653030672217;
        Fri, 20 May 2022 00:11:12 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id t18-20020a170902d21200b00161b3d5e3e4sm4965168ply.304.2022.05.20.00.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 00:11:11 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com, mst@redhat.com,
        david@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        pbonzini@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org,
        zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 2/3] mm/memory-failure.c: support reset PTE during unpoison
Date:   Fri, 20 May 2022 15:06:47 +0800
Message-Id: <20220520070648.1794132-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520070648.1794132-1-pizhenwei@bytedance.com>
References: <20220520070648.1794132-1-pizhenwei@bytedance.com>
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

Origianlly, unpoison_memory() is only used by hwpoison-inject, and
unpoisons a page which is poisoned by hwpoison-inject too. The kernel PTE
entry has no change during software poison/unpoison.

On a virtualization platform, it's possible to fix hardware corrupted page
by hypervisor, typically the hypervisor remaps the error HVA(host virtual
address). So add a new parameter 'const char *reason' to show the reason
called by.

Once the corrupted page gets fixed, the guest kernel needs put page to
buddy. Reuse the page and hit the following issue(Intel Platinum 8260):
 BUG: unable to handle page fault for address: ffff888061646000
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0002) - not-present page
 PGD 2c01067 P4D 2c01067 PUD 61aaa063 PMD 10089b063 PTE 800fffff9e9b9062
 Oops: 0002 [#1] PREEMPT SMP NOPTI
 CPU: 2 PID: 31106 Comm: stress Kdump: loaded Tainted: G   M       OE     5.18.0-rc6.bm.1-amd64 #6
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
 RIP: 0010:clear_page_erms+0x7/0x10

The kernel PTE entry of the fixed page is still uncorrected, kernel hits
page fault during prep_new_page. So add 'bool reset_kpte' to get a change
to fix the PTE entry if the page is fixed by hypervisor.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 include/linux/mm.h   |  2 +-
 mm/hwpoison-inject.c |  2 +-
 mm/memory-failure.c  | 26 +++++++++++++++++++-------
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 665873c2788c..7ba210e86401 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3191,7 +3191,7 @@ enum mf_flags {
 extern int memory_failure(unsigned long pfn, int flags);
 extern void memory_failure_queue(unsigned long pfn, int flags);
 extern void memory_failure_queue_kick(int cpu);
-extern int unpoison_memory(unsigned long pfn);
+extern int unpoison_memory(unsigned long pfn, bool reset_kpte, const char *reason);
 extern int sysctl_memory_failure_early_kill;
 extern int sysctl_memory_failure_recovery;
 extern void shake_page(struct page *p);
diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
index 5c0cddd81505..0dd17ba98ade 100644
--- a/mm/hwpoison-inject.c
+++ b/mm/hwpoison-inject.c
@@ -57,7 +57,7 @@ static int hwpoison_unpoison(void *data, u64 val)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	return unpoison_memory(val);
+	return unpoison_memory(val, false, "hwpoison-inject");
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(hwpoison_fops, NULL, hwpoison_inject, "%lli\n");
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 95c218bb0a37..a46de3be1dd7 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2132,21 +2132,26 @@ core_initcall(memory_failure_init);
 /**
  * unpoison_memory - Unpoison a previously poisoned page
  * @pfn: Page number of the to be unpoisoned page
+ * @reset_kpte: Reset the PTE entry for kmap
+ * @reason: The callers tells why unpoisoning the page
  *
- * Software-unpoison a page that has been poisoned by
- * memory_failure() earlier.
+ * Unpoison a page that has been poisoned by memory_failure() earlier.
  *
- * This is only done on the software-level, so it only works
- * for linux injected failures, not real hardware failures
+ * For linux injected failures, there is no need to reset PTE entry.
+ * It's possible to fix hardware memory failure on a virtualization platform,
+ * once hypervisor fixes the failure, guest needs put page back to buddy and
+ * reset the PTE entry in kernel.
  *
  * Returns 0 for success, otherwise -errno.
  */
-int unpoison_memory(unsigned long pfn)
+int unpoison_memory(unsigned long pfn, bool reset_kpte, const char *reason)
 {
 	struct page *page;
 	struct page *p;
 	int ret = -EBUSY;
 	int freeit = 0;
+	pte_t *kpte;
+	unsigned long addr;
 	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
 					DEFAULT_RATELIMIT_BURST);
 
@@ -2208,8 +2213,15 @@ int unpoison_memory(unsigned long pfn)
 	mutex_unlock(&mf_mutex);
 	if (!ret || freeit) {
 		num_poisoned_pages_dec();
-		unpoison_pr_info("Unpoison: Software-unpoisoned page %#lx\n",
-				 page_to_pfn(p), &unpoison_rs);
+		pr_info("Unpoison: Unpoisoned page %#lx by %s\n",
+				 page_to_pfn(p), reason);
+		if (reset_kpte) {
+			preempt_disable();
+			addr = (unsigned long)page_to_virt(p);
+			kpte = virt_to_kpte(addr);
+			set_pte_at(&init_mm, addr, kpte, pfn_pte(pfn, PAGE_KERNEL));
+			preempt_enable();
+		}
 	}
 	return ret;
 }
-- 
2.20.1

