Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C42B542B5F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbiFHJVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235341AbiFHJTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:19:19 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E63155493
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:42:08 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id c18so9947353pgh.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 01:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sb98wOh0APW10cVV6EJOE4BAB6aJnap4z+dh4wykpTE=;
        b=PD0WVIoUek3vJ8vo3YueL2euoEvexCCdJGTthjFnw3auR4gD9xc1+AbopFWA1zwqy0
         82gksE0mRUEyOv2RcXw0a1KqiUTCDkFnZ5Q76oD7UBPjehdyJZ4f3Ns3kiM8QoAcn4qg
         eorXMvVxsq/K8+DAJA0pfuvt4Bl6HcSHnmgsD+V1g53sSYTzCkdlQ98xzT1WKturK2AC
         179hX0duKXG1F25gLFaxbA3HfT8OwarJuX5XrZV4T5HTYzn1v1M2BASrx3TNPFKtSSGW
         aWu4D5rmdloe/3tSKVy6BcB6fiZQeD7hvl8Mn3YVsMXezz+tnd1Skp0n0dLKtP/0Wi7l
         BF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sb98wOh0APW10cVV6EJOE4BAB6aJnap4z+dh4wykpTE=;
        b=z7v/sMhhmI0+WZS65WubX39oEYpMU+wiGrMGBueVdEqVMLcAZ12EzGccQlo49MWOAT
         ETBx/RfFokz6Mq3X6us8g8ZoM2Kb5MYmb+jxcWvxU2mgEPAAfJbXo5GGm7qmdnJ1bbvO
         MKAd+URMTmBqstt13CGfRfSuasMZ6KcN0C4q6H43b7tAi3EYZA7mNqvSfa0LemDVvw+1
         Kts5mf9LrEVS+2Umwii36iUtZ1GUvARbzExnEz5ceyXi2OqrUGKYU0oKu6eCOtz3FMAp
         l+vuhIVSCS38fI5jxHs0xmPren8KHir2OSn+quvcBBtVwqDq4A4SSKpJbxiHaH8+8t6g
         zN2Q==
X-Gm-Message-State: AOAM530RjuPp4d+CMkCr/hqeocd/zWOuYCBgih9gzdMRCOwi/nbQsX1c
        zdawhQ4o//zhO79N6CTNXdjZ+w==
X-Google-Smtp-Source: ABdhPJyoJ4K+iVeEl6Rbs51QAba7tVuMh9rDessrajKigQLxtfCxPF3vsrhTpRahDeitRdzx4JUGTQ==
X-Received: by 2002:a63:5d21:0:b0:3fa:387b:7b44 with SMTP id r33-20020a635d21000000b003fa387b7b44mr29190274pgb.48.1654677727578;
        Wed, 08 Jun 2022 01:42:07 -0700 (PDT)
Received: from always-T480.www.tendawifi.com ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id u30-20020a63b55e000000b003fc136f9a7dsm2180975pgo.38.2022.06.08.01.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 01:42:06 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v2 1/1] mm/memory-failure: don't allow to unpoison hw corrupted page
Date:   Wed,  8 Jun 2022 16:43:56 +0800
Message-Id: <20220608084356.40894-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220608084356.40894-1-pizhenwei@bytedance.com>
References: <20220608084356.40894-1-pizhenwei@bytedance.com>
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

Fixes: 847ce401df392 ("HWPOISON: Add unpoisoning support")
Fixes: 17fae1294ad9d ("x86/{mce,mm}: Unmap the entire page if the whole page is affected and poisoned")
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 mm/memory-failure.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index b85661cbdc4a..da99a2b7ef35 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2090,6 +2090,7 @@ int unpoison_memory(unsigned long pfn)
 {
 	struct page *page;
 	struct page *p;
+	pte_t *kpte;
 	int ret = -EBUSY;
 	int freeit = 0;
 	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
@@ -2103,6 +2104,14 @@ int unpoison_memory(unsigned long pfn)
 
 	mutex_lock(&mf_mutex);
 
+	kpte = virt_to_kpte((unsigned long)page_to_virt(p));
+	if (kpte && !pte_present(*kpte)) {
+		unpoison_pr_info("Unpoison: Page was hardware poisoned %#lx\n",
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

