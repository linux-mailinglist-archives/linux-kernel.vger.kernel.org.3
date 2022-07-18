Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28306578B00
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbiGRThG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiGRThF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:37:05 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619E9E00D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:37:03 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id p9so12675172pjd.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AYRHTvglS7MWBh2IBz4hMgwmIAyPT1erchZO9GO0BVY=;
        b=NJrFfrNoY0iomel5JhiA0br3CbpKSCrsufXYanqZjtwMZXma7bd7mEMfYL1CLUSjGt
         fIDf0Stc8+DdYK0eU0WPQvv6TiRDAHm1ebdjf9JoOts5WVUyxNzqPictNEGp9DNnSJiR
         idoDH02j6T6QJOg9BE4HaSKMDSpb9QfqU81rCoauPMCPapL2S6yMMpkvsJMwid4rSMhr
         /KTumfxfMVOr1arnTmZce7Pt1Eo0niD5eJZs2IeBx/rie2yt0ysT4KQfTfa6P5WRmGyd
         RrB0+ZZKLGnmRy/aEgfIC+2txK4xgUytK2bD00tR1XlXmPyHX2jgudF2USo0o7xMsb7i
         pKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AYRHTvglS7MWBh2IBz4hMgwmIAyPT1erchZO9GO0BVY=;
        b=QxeP2s51xtiN9dDKlHN7fcE2flq3bBASpdqeUq7nMf8RbcNvbAS/D8T8DWoswlilTU
         AOFgSGpAzEmy4LxDE2gQy3x66XxyPDDCJ0zvtn0tq4TZeWBZ3j6FPotuD6YNW/HfOkjD
         OPqS8dQo2Umw+E1774W78ISvnZYdxhZVey5v+XR4pLeBhH/hYsHxo5A2PgmMviA6KLw+
         HQvsMLN1ZpAtqL2HjAOFPcylUpyZaG/cw1dGMtw0+wGDS0yhND0HEyw/23QGbmLLV616
         ZM3JSDB237MWmHn6fF3OEsqLBAE4wGxAatkBD4HQx/Uh0WUsUhAlNEBq2+Bf0YhlvZSa
         K/Dg==
X-Gm-Message-State: AJIora9e8FV56babhMIMK+gHyFXxK0G8h+1rofe+J/qvTB0bgXJ7r6Ev
        y3LwZEvUZNbUUa7xptwkk/g=
X-Google-Smtp-Source: AGRyM1sjCw3eN71l0ZNBBK4Ea+EYfYiyKGIlFtnAiU8rN+xalvfAonv5bu3IKlPhcpo9EL1S5AVPrA==
X-Received: by 2002:a17:902:aa4b:b0:15f:b2c:73c7 with SMTP id c11-20020a170902aa4b00b0015f0b2c73c7mr29783790plr.164.1658173022360;
        Mon, 18 Jul 2022 12:37:02 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b0016bc4a6ce28sm9907887plb.98.2022.07.18.12.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 12:37:02 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 00/14] mm: relaxed TLB flushes and other optimi.
Date:   Mon, 18 Jul 2022 05:01:58 -0700
Message-Id: <20220718120212.3180-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Following the optimizations to avoid unnecessary TLB flushes [1],
mprotect() and userfaultfd() did not cause unnecessary TLB flushes when
protection was unchanged. This enabled userfaultfd to write-unprotect a
page without triggering a TLB flush (and potentially shootdown).

After these changes, David added another feature to mprotect [2],
allowing pages that can safely be mapped as writable, to be mapped as
such directly from mprotect(), instead of going through the page fault
handler. This saves the overhead of a page-fault when write-unprotecting
private exclusive pages as writable, for instance.

This change introduced, however, some undesired behaviors, especially if
we adopt this new feature for userfaultfd. First, the newly mapped PTE
is not set as dirty, which might induce on x86 over 500 cycles of
overhead (if the page was not dirty before).  Second, once again we can
have an expensive TLB shootdown when we write-unprotect a page: when we
relax the protection (i.e., give more permission), we would do a TLB
flush. If the application is multithreaded, or a userfaultfd monitor
uses write-unprotect (which is a common case), a TLB shootdown would be
needed.

This patch-set allows userfaultfd to map pages as writeable directly
upon write-(un)protect ioctl, while addressing the undesired behaviors
that occur when one uses userfaultfd write-unprotect or mprotect to add
permissions. It also does some cleanup and micro-optimizations along the
way.

The main change that is done in the patch-set - x86 specific, at the
moment - is the introduction of "relaxed" TLB flushes when permissions
are added. Upon a "relaxed" TLB flush, the mm's TLB generation is
advanced and the local TLB is flushed, but no TLB shootdown takes place.
If a spurious page-fault occurs and the local generation of the TLB is
found to be out-of-sync with the mm generation, a full TLB flush is
performed on the faulting core to prevent further spurious page-faults.

To a certain extent "relaxed flushes" are similar to the changes that
were proposed some time ago for kernel mappings [3]. However, it does
not have any complicated interactions with with NMI handlers.

Experiments on Haswell show the performance improvement.  Running, for a
single page, a loop of (1) mprotect(READ); (2) mprotect(READ|WRITE) and
then (3) access provides the following result (on bare metal this time):

mprotect(PROT_READ) time in cycles:

			1 Thread	2 Threads
Before (5.19rc4+)	2499		4655
+patch			2495		4363 (-6%)


mprotect(PROT_READ|PROT_WRITE) in cycles:

			1 Thread	2 Threads
Before (5.19rc4+)	2529		4675
+patch			2496		2615 (-44%)

If we ran MADV_FREE or the page was not dirty, we can also shorten the
PROT_READ time by skipping the TLB shootdown with this patch-set.

[1] https://lore.kernel.org/all/20220401180821.1986781-1-namit@vmware.com/
[2] https://lore.kernel.org/all/20220614093629.76309-1-david@redhat.com/
[3] https://lore.kernel.org/all/4797D64D.1060105@goop.org/

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>

Nadav Amit (14):
  userfaultfd: set dirty and young on writeprotect
  userfaultfd: try to map write-unprotected pages
  mm/mprotect: allow exclusive anon pages to be writable
  mm/mprotect: preserve write with MM_CP_TRY_CHANGE_WRITABLE
  x86/mm: check exec permissions on fault
  mm/rmap: avoid flushing on page_vma_mkclean_one() when possible
  mm: do fix spurious page-faults for instruction faults
  x86/mm: introduce flush_tlb_fix_spurious_fault
  mm: introduce relaxed TLB flushes
  x86/mm: introduce relaxed TLB flushes
  x86/mm: use relaxed TLB flushes when protection is removed
  x86/tlb: no flush on PTE change from RW->RO when PTE is clean
  mm/mprotect: do not check flush type if a strict is needed
  mm: conditional check of pfn in pte_flush_type

 arch/x86/include/asm/pgtable.h  |   4 +-
 arch/x86/include/asm/tlb.h      |   3 +-
 arch/x86/include/asm/tlbflush.h |  90 +++++++++++++++++--------
 arch/x86/kernel/alternative.c   |   2 +-
 arch/x86/kernel/ldt.c           |   3 +-
 arch/x86/mm/fault.c             |  22 +++++-
 arch/x86/mm/tlb.c               |  21 +++++-
 include/asm-generic/tlb.h       | 116 +++++++++++++++++++-------------
 include/linux/mm.h              |   2 +
 include/linux/mm_types.h        |   6 ++
 mm/huge_memory.c                |   9 ++-
 mm/hugetlb.c                    |   2 +-
 mm/memory.c                     |   2 +-
 mm/mmu_gather.c                 |   1 +
 mm/mprotect.c                   |  31 ++++++---
 mm/rmap.c                       |  16 +++--
 mm/userfaultfd.c                |  10 ++-
 17 files changed, 237 insertions(+), 103 deletions(-)

-- 
2.25.1

