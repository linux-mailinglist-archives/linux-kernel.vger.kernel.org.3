Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEE953D672
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 12:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbiFDKgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 06:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbiFDKge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 06:36:34 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54CD6419
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 03:36:32 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id s14so8533673plk.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 03:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SEH07fYqSJ08iDaWsMMB7o1Uq89bLucsW0RAoCe+2J0=;
        b=oQmg70J3mMdquSrusU9/30DsyMzAbDHg9VxhHbLmhtRneEGvnBIeqG7r7nce+E3WqX
         GC4uVb8+z2QdfeXoGiVD6Qe/AnHAcpS962HrTq0K0IyLycZ/RKz+uZWOAijsAuXaQsZl
         XysdRGShpLYRAn0XU3j6INOfZBFk+qIJ1CyAMaaQ8hVLR/QmmnxUR3phaPW/dXDwnAIC
         W6l2QkGYQ5+yhCl/NsBMCw6wPVi7zc0nVabcddD2frJpuKOFIzHDeDnpn+8NkbRWOita
         4G15ondkiHhd9vJxde/OPVSeYHbLl00GsZHGtN4jNNAUlEfezNWkjNgOZVYMAXL5r7Hr
         30zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SEH07fYqSJ08iDaWsMMB7o1Uq89bLucsW0RAoCe+2J0=;
        b=y4zwIBLXb+Lxqb2og0dN2vmK5qKPSPSGkO07tgsW7sVW0AsdIDbFHJoQ1xMQLMku0U
         lb4faUlZLX3JymNQ1GTfla2OeptHcgnKrkO1xzEyPl0KkTavnsvu47Xd2qE7cCzJ5ILh
         r8O4QJYfNorcf4O0R/QKsWWcbcP/t3A082JU6OiC3XDEHzRXW60QsfZyXEvDKR1kNSvP
         fOUSC0hM7Yv7hz/cXgCCqDN2s6OVUdBc9Kcwk00rRWkKwbgydg11iMRsEJw8Z8Cmiz2F
         HJjpN0MZTv6vzd6yAQfZRsfIvr5tG+JfEN24nUNrabz3sgGRgNBFGrKahh7UfVnBqerP
         6+Xg==
X-Gm-Message-State: AOAM530Yww3jYsNsxv9kNU5gvFAJaVh0HTRaLk0WXEv4jKkUUfvvIflb
        8nEESBE41+U3pf5iiDJScQO4yiBVulFPLA==
X-Google-Smtp-Source: ABdhPJxIUmt0ZMvrT4lHo4qSVtaDguY7+qyGD8IS1alf/zVQ9l1lLLUIO70mrXPK2W9XdXRoHi9C/A==
X-Received: by 2002:a17:903:200c:b0:163:d4c3:f24f with SMTP id s12-20020a170903200c00b00163d4c3f24fmr14440511pla.78.1654338992291;
        Sat, 04 Jun 2022 03:36:32 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id s17-20020a170902c65100b0015ee60ef65bsm6815889pls.260.2022.06.04.03.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 03:36:31 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     pizhenwei@bytedance.com, naoya.horiguchi@nec.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/memory-failure: don't allow to unpoison hw corrupted page
Date:   Sat,  4 Jun 2022 18:32:29 +0800
Message-Id: <20220604103229.3378591-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
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
poison(hwpoison-inject) only. Unpoisoning a hardware corrupted page
puts page back buddy only, this leads BUG during accessing on the
corrupted KPTE.

Do not allow to unpoison hardware corrupted page in unpoison_memory()
to avoid BUG like this:

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

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 mm/memory-failure.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index b85661cbdc4a..ec49571924f4 100644
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
@@ -2101,6 +2102,13 @@ int unpoison_memory(unsigned long pfn)
 	p = pfn_to_page(pfn);
 	page = compound_head(p);
 
+	kpte = virt_to_kpte((unsigned long)page_to_virt(p));
+	if (kpte && !pte_present(*kpte)) {
+		unpoison_pr_info("Unpoison: Page was hardware poisoned %#lx\n",
+				 pfn, &unpoison_rs);
+		return -EPERM;
+	}
+
 	mutex_lock(&mf_mutex);
 
 	if (!PageHWPoison(p)) {
-- 
2.20.1

