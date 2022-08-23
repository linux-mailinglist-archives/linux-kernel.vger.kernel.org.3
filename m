Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5204359EED5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 00:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbiHWWNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 18:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbiHWWNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 18:13:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962708B2E4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 15:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661292703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SqSTkWZMCrwSwsjSNzpe+ypA/kUjJyLN2b7ZHvSho3U=;
        b=ZYq5eHgtkXVWUfqLkxdvxYOhX0pdJUhF3FbQBYU271n4uQpzK4ZxJIT70xogtuZpKVRiWV
        Ffq0mUfZW62EVbPFAPjfBTKNQXs6Z9xD3jjiyNdRMvh4PgqoTaSGw/0uDcYsu+VWef6Qef
        IATxQ0iTnEB2GBF8gTcRaalKHjErFb4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-110-GuhQl4zcNmC6p66W5DZeSA-1; Tue, 23 Aug 2022 18:11:42 -0400
X-MC-Unique: GuhQl4zcNmC6p66W5DZeSA-1
Received: by mail-qk1-f199.google.com with SMTP id x22-20020a05620a259600b006b552a69231so13170917qko.18
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 15:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=SqSTkWZMCrwSwsjSNzpe+ypA/kUjJyLN2b7ZHvSho3U=;
        b=NyD1kwFWanffRU1bd5G0Vvw9kxL19oUEAsmeUqPTQcaN4cFR3ybJjuHJfFmkdY//g5
         lhGkAEgqPmYsPfn4VyDVcVyyuPAC0XHI/8dkvZwhDW8rD0JybKXNPfK5h/i0vtwcJUHV
         kN7R9O4Gb7oCo0rv4r3efqx/bdZytpeSTOkecud4sf9hEK+KvEuY7oOoIrw9Kpv2YaUd
         JxF62fNcc11dDSWeQsaojzG2Hlv3FyJYgMweEKUrsP5S1ZRrVduBR39bnhyNAR1ryvMd
         hVJ+SShjc3qTZ5h8NsGzBBYsN0ORrmZo8b/MXNwyPWIii7i8219EeJ1BrT0CwoIAP8pO
         KvPQ==
X-Gm-Message-State: ACgBeo1/NzGbwv6/BoN0qhEJN+HOsdJ5yQU2TeSHAdwyfRma2F2O+SkE
        mhOUdSJpRWsEdTKQG5Sv8KaNOowmA5ufR9YsQe88KGFRLAZ4JyNBg1tpkiP1XDlw6LM7GU2HW/k
        SKtOJhBvUBCGAYq6R+eQbZNOmLvuKDBGj8VmJrPbQ8nbcOEwnJlaLsvEbFfBvJvaJenkBF3cQow
        ==
X-Received: by 2002:ac8:58c8:0:b0:344:87c2:c495 with SMTP id u8-20020ac858c8000000b0034487c2c495mr21306113qta.631.1661292701379;
        Tue, 23 Aug 2022 15:11:41 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4lLdPjmsXBhe8LEZIi5nM1ZsA7umBVsvW+i6mZX+KoZuDvOiaboMlLZWVcvCAfdLMqUwSvCg==
X-Received: by 2002:ac8:58c8:0:b0:344:87c2:c495 with SMTP id u8-20020ac858c8000000b0034487c2c495mr21306082qta.631.1661292700932;
        Tue, 23 Aug 2022 15:11:40 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006bbd0ae9c05sm12319185qkp.130.2022.08.23.15.11.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Aug 2022 15:11:40 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, peterx@redhat.com,
        David Hildenbrand <david@redhat.com>, stable@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH] mm/mprotect: Only reference swap pfn page if type match
Date:   Tue, 23 Aug 2022 18:11:38 -0400
Message-Id: <20220823221138.45602-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Zhao reported a bug after the commit "mm/swap: Add swp_offset_pfn() to
fetch PFN from swap entry" added a check in swp_offset_pfn() for swap type [1]:

  kernel BUG at include/linux/swapops.h:117!
  CPU: 46 PID: 5245 Comm: EventManager_De Tainted: G S         O L 6.0.0-dbg-DEV #2
  RIP: 0010:pfn_swap_entry_to_page+0x72/0xf0
  Code: c6 48 8b 36 48 83 fe ff 74 53 48 01 d1 48 83 c1 08 48 8b 09 f6
  c1 01 75 7b 66 90 48 89 c1 48 8b 09 f6 c1 01 74 74 5d c3 eb 9e <0f> 0b
  48 ba ff ff ff ff 03 00 00 00 eb ae a9 ff 0f 00 00 75 13 48
  RSP: 0018:ffffa59e73fabb80 EFLAGS: 00010282
  RAX: 00000000ffffffe8 RBX: 0c00000000000000 RCX: ffffcd5440000000
  RDX: 1ffffffffff7a80a RSI: 0000000000000000 RDI: 0c0000000000042b
  RBP: ffffa59e73fabb80 R08: ffff9965ca6e8bb8 R09: 0000000000000000
  R10: ffffffffa5a2f62d R11: 0000030b372e9fff R12: ffff997b79db5738
  R13: 000000000000042b R14: 0c0000000000042b R15: 1ffffffffff7a80a
  FS:  00007f549d1bb700(0000) GS:ffff99d3cf680000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000440d035b3180 CR3: 0000002243176004 CR4: 00000000003706e0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   <TASK>
   change_pte_range+0x36e/0x880
   change_p4d_range+0x2e8/0x670
   change_protection_range+0x14e/0x2c0
   mprotect_fixup+0x1ee/0x330
   do_mprotect_pkey+0x34c/0x440
   __x64_sys_mprotect+0x1d/0x30

It triggers because pfn_swap_entry_to_page() could be called upon e.g. a
genuine swap entry.

Fix it by only calling it when it's a write migration entry where the page*
is used.

[1] https://lore.kernel.org/lkml/CAOUHufaVC2Za-p8m0aiHw6YkheDcrO-C3wRGixwDS32VTS+k1w@mail.gmail.com/

Fixes: 6c287605fd56 ("mm: remember exclusively mapped anonymous pages with PG_anon_exclusive")
Cc: David Hildenbrand <david@redhat.com>
Cc: <stable@vger.kernel.org>
Reported-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/mprotect.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index f2b9b1da9083..4549f5945ebe 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -203,10 +203,11 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 			pages++;
 		} else if (is_swap_pte(oldpte)) {
 			swp_entry_t entry = pte_to_swp_entry(oldpte);
-			struct page *page = pfn_swap_entry_to_page(entry);
 			pte_t newpte;
 
 			if (is_writable_migration_entry(entry)) {
+				struct page *page = pfn_swap_entry_to_page(entry);
+
 				/*
 				 * A protection check is difficult so
 				 * just be safe and disable write
-- 
2.32.0

