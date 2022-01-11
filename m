Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E0348AE4C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240461AbiAKNRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240391AbiAKNRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:17:17 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BD4C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 05:17:17 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id g5so7913150plo.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 05:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=51hfnZMrjVMwncBAfuPjR9jE1rmCVx4hXfZuwfJArk8=;
        b=LljzaIex9oaWpQpDIkneXLdfCcqNXilOgXqkk4D/kR7cYhdCa23RDZGJuoq6DBFGtO
         TTWUAFmaCLHz05QRmZdtZvkYMzdEtuxqpD4CDixUwHnGyp4T73EkQKomQVCKhnxLJTJ2
         bbtj+7nyl6t95Uc231qFZLxXJfavpeElcBVgpxNE3+0jW78xxdxhGy8doKfjcdXqAw5T
         HvyP/EQyittIW0StHo18qvuDv2PFZMijQyc78uvJxxzfkvHq6wB/wg85RRM7Lnvo2Pdo
         u29iAq85glUaEykP2fObR7yddVtFz399OM4p3NsF3ZSC1rzPatOTKrqG8Nul2Xmr6e61
         RUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=51hfnZMrjVMwncBAfuPjR9jE1rmCVx4hXfZuwfJArk8=;
        b=pWDHWItjiGwppRJoy5ZcynYk+N19bCikU3piJuH2UjPATy/+RXr4aXIZoge/4c/a17
         mEACLpUFnkkcOhSluSLQkLptEdz1tkYKmBTmUtLEBgo2HLBv4pB1ICnEi+AG2EJ6TF8l
         j7OkqYE9/nkfy0MvvmMD+P7S6Xo0PuRHDX3fR0Nvx3ZiNObiDz7nwV7Cl7OkENB8Skgz
         YKQ4XhHNmRKgfYvct/tiyjjCT0MvsvO2IMajK+g9TCGq0jLjqR1Uls+b5I6a7xdP469p
         Qs7DuVnyd7p6XQu/qpJd9b3WVLbY6z/sc4u0YoMuqvURpB1urNDZv2d4IuB6Auwsv3oa
         +GZg==
X-Gm-Message-State: AOAM530q+n1F86iXB32tAG8ro6N6ZICS6Uwx9gwOyHxlTxsKNsH2LBbr
        qxgvhvMqvMkz1V/DQ9o0Vakktg==
X-Google-Smtp-Source: ABdhPJzTrKFps+GeCoX3uZCxSVOWXOuaPD/0YuD2oXFzH+R10vAlnkfSlcZEwlQMzychksQJaXWtZw==
X-Received: by 2002:a63:485a:: with SMTP id x26mr4019728pgk.580.1641907036736;
        Tue, 11 Jan 2022 05:17:16 -0800 (PST)
Received: from C02FF4E5ML7H.tiktokd.org ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id c124sm10080450pfb.139.2022.01.11.05.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 05:17:16 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     will@kernel.org, akpm@linux-foundation.org, david@redhat.com,
        bodeddub@amazon.com, osalvador@suse.de, mike.kravetz@oracle.com,
        rientjes@google.com, mark.rutland@arm.com, catalin.marinas@arm.com,
        james.morse@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] arm64: mm: hugetlb: add support for free vmemmap pages of HugeTLB
Date:   Tue, 11 Jan 2022 21:16:52 +0800
Message-Id: <20220111131652.61947-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The preparation of supporting freeing vmemmap associated with each
HugeTLB page is ready, so we can support this feature for arm64.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
There is already some discussions about this in [1], but there was no
conclusion in the end. I copied the concern proposed by Anshuman to here.

1st concern:
"
  But what happens when a hot remove section's vmemmap area (which is being
  teared down) is nearby another vmemmap area which is either created or
  being destroyed for HugeTLB alloc/free purpose. As you mentioned HugeTLB
  pages inside the hot remove section might be safe. But what about other
  HugeTLB areas whose vmemmap area shares page table entries with vmemmap
  entries for a section being hot removed ? Massive HugeTLB alloc/use/free
  test cycle using memory just adjacent to a memory hotplug area, which is
  always added and removed periodically, should be able to expose this problem.
"
My Answer: As you already know HugeTLB pages inside the hot remove section
is safe. Let's talk your question "what about other HugeTLB areas whose
vmemmap area shares page table entries with vmemmap entries for a section
being hot removed ?", the question is not established. Why? The minimal
granularity size of hotplug memory 128MB (on arm64, 4k base page), so any
HugeTLB smaller than 128MB is within a section, then, there is no share
(PTE) page tables between HugeTLB in this section and ones in other
sections and a HugeTLB could not cross two sections. Any HugeTLB bigger
than 128MB (e.g. 1GB) whose size is an integer multible of a section and
vmemmap area is also an integer multiple of 2MB. At the time memory is
removed, all huge pages either have been migrated away or dissolved. The
vmemmap is stable. So there is no problem in this case as well.

2nd concern:
"
  differently, not sure if ptdump would require any synchronization.

  Dumping an wrong value is probably okay but crashing because a page table
  entry is being freed after ptdump acquired the pointer is bad. On arm64,
  ptdump() is protected against hotremove via [get|put]_online_mems().
"
My Answer: The ptdump should be fine since vmemmap_remap_free() only exchanges
PTEs or split the PMD entry (which means allocating a PTE page table). Both
operations do not free any page tables, so ptdump cannot run into a UAF on
any page tables. The wrost case is just dumping an wrong value.

[1] https://lore.kernel.org/linux-mm/b8cdc9c8-853c-8392-a2fa-4f1a8f02057a@arm.com/T/

 fs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 7a2b11c0b803..04cfd5bf5ec9 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -247,7 +247,7 @@ config HUGETLB_PAGE
 
 config HUGETLB_PAGE_FREE_VMEMMAP
 	def_bool HUGETLB_PAGE
-	depends on X86_64
+	depends on X86_64 || ARM64
 	depends on SPARSEMEM_VMEMMAP
 
 config HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON
-- 
2.11.0

