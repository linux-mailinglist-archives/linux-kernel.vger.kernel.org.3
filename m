Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296E55A0D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240961AbiHYKLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237536AbiHYKLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:11:31 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B4356B84
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:11:30 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x63-20020a17090a6c4500b001fabbf8debfso4383201pjj.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=3tPRmfkTHBLUBNfnSLM95a0SjCXe3S0TjHrD4Br220U=;
        b=N0IPzYA623Pgw/x8177w1cO/3JJIBFlco9XNvhWU3lfDM1l1ErKzdX+E0FyBNno+dr
         629HYO/bMQTUsOegrxo7OmMssm4Rr0qFCGZHE8rhFSXDzGOszaTopCUsEiX9uA4VV394
         sd4rOYPB0wfjYuHAb6el4Ju+BPl+HeIZA/ZuKqpLqX8bfGRThFqhsgDeuyYodEiHbp7/
         VcS3HYX8XmEGD2AIhGcoan56pW6DJoGMbbT3DoJc0L+7jDQ5mRW6ccM55fsETX0ZDKuK
         xzwcX/U9lD0/EXdfkULpFIEG9TZuDoCvP78ippyq3/RbCU9yFCG1YG4Qfivx9TDPvB0L
         7PlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=3tPRmfkTHBLUBNfnSLM95a0SjCXe3S0TjHrD4Br220U=;
        b=x6dsT1zIlKdpbJ5zz9dDMsHCDcgya+kjcSaeCwq4KzlXwbt5tMxXc9zhATuyBxuydt
         jaKLbaFAqrumb+4mmHw+oLQ7Or5mnNma/WfqK9uVX139W6u6JScWDjQRb9fEP47gdOtg
         YnkzOQcEn5jDzCg2mq3G7I+3UCwnxiQM4iu/Cq5Qxin9Y+0li4iHQM4C4hQYiUDybRCb
         RKIAlSMXg0twP77BdFWsTQcdIWZRZmd5+vjSnTEEsQMl3QvkMt4kGRTVhY8gckXjZG63
         xNqM6kN//TWKs6eSSmPZbx4KSeV0J1e6UVZOk+sGh6hiVcjF1XRMMue5cqoH3JEl5ypA
         PBgQ==
X-Gm-Message-State: ACgBeo2SRaGEk1oTcFjRPg9TrET0O8S/1sMLKZGVRzdPYngX+QDVyxDu
        SKLLwkPbIc1DJmBn9oJxOkkpEg==
X-Google-Smtp-Source: AA6agR4pf2g/naJfleKqPQsght+0HUQG8tm1oZOW0q1zQD3P4k2b7xems5DVqCnmggoFSc6bd3RY6g==
X-Received: by 2002:a17:903:120a:b0:172:5a63:7442 with SMTP id l10-20020a170903120a00b001725a637442mr3113379plh.55.1661422289511;
        Thu, 25 Aug 2022 03:11:29 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id b10-20020a170903228a00b001714c36a6e7sm8477581plh.284.2022.08.25.03.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 03:11:28 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@redhat.com,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        jgg@nvidia.com, tglx@linutronix.de, willy@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 0/7] Try to free empty and zero user PTE page table pages
Date:   Thu, 25 Aug 2022 18:10:30 +0800
Message-Id: <20220825101037.96517-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
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

Hi,

Before this, in order to free empty user PTE page table pages, I posted the
following patch sets of two solutions:
 - atomic refcount version:
	https://lore.kernel.org/lkml/20211110105428.32458-1-zhengqi.arch@bytedance.com/
 - percpu refcount version:
	https://lore.kernel.org/lkml/20220429133552.33768-1-zhengqi.arch@bytedance.com/

Both patch sets have the following behavior:
a. Protect the page table walker by hooking pte_offset_map{_lock}() and
   pte_unmap{_unlock}()
b. Will automatically reclaim PTE page table pages in the non-reclaiming path

For behavior a, there may be the following disadvantages mentioned by
David Hildenbrand:
 - It introduces a lot of complexity. It's not something easy to get in and most
   probably not easy to get out again
 - It is inconvenient to extend to other architectures. For example, for the
   continuous ptes of arm64, the pointer to the PTE entry is obtained directly
   through pte_offset_kernel() instead of pte_offset_map{_lock}()
 - It has been found that pte_unmap() is missing in some places that only
   execute on 64-bit systems, which is a disaster for pte_refcount

For behavior b, it may not be necessary to actively reclaim PTE pages, especially
when memory pressure is not high, and deferring to the reclaim path may be a
better choice.

In addition, the above two solutions are only for empty PTE pages (a PTE page
where all entries are empty), and do not deal with the zero PTE page ( a PTE
page where all page table entries are mapped to shared zero page) mentioned by
David Hildenbrand:
	"Especially the shared zeropage is nasty, because there are
	 sane use cases that can trigger it. Assume you have a VM
	 (e.g., QEMU) that inflated the balloon to return free memory
	 to the hypervisor.

	 Simply migrating that VM will populate the shared zeropage to
	 all inflated pages, because migration code ends up reading all
	 VM memory. Similarly, the guest can just read that memory as
	 well, for example, when the guest issues kdump itself."

The purpose of this RFC patch is to continue the discussion and fix the above
issues. The following is the solution to be discussed.

In order to quickly identify the above two types of PTE pages, we still
introduced a pte_refcount for each PTE page. We put the mapped and zero PTE
entry counter into the pte_refcount of the PTE page. The bitmask has the
following meaning:

 - bits 0-9 are mapped PTE entry count
 - bits 10-19 are zero PTE entry count

In this way, when mapped PTE entry count is 0, we can know that the current PTE
page is an empty PTE page, and when zero PTE entry count is PTRS_PER_PTE, we can
know that the current PTE page is a zero PTE page.

We only update the pte_refcount when setting and clearing of PTE entry, and
since they are both protected by pte lock, pte_refcount can be a non-atomic
variable with little performance overhead.

For page table walker, we mutually exclusive it by holding write lock of
mmap_lock when doing pmd_clear() (in the newly added path to reclaim PTE pages).

The [RFC PATCH 7/7] is an example of reclaiming empty and zero PTE page in a
process. But the best time to reclaim should be in the reclaiming path, such as
before waking up the oom killer. At this point, the system can not reclaim more
memory. Compared with killing a process, it is more acceptable to hold a write
lock of mmap_lock to reclaim memory by releasing empty and zero PTE pages.

My idea is to count the number of bytes (mm->reclaimable_pt_bytes, similar to
mm->pgtables_bytes) of reclaimable PTE pages (including empty and zero PTE page)
in each mm, and maintain a rbtree with mm->reclaimable_pt_bytes as the key, then
we can pick the mm with the largest mm->reclaimable_pt_bytes to reclaim in the
reclaim path.

This series is based on v5.19.

Comments and suggestions are welcome.

Thanks,
Qi

Qi Zheng (7):
  mm: use ptep_clear() in non-present cases
  mm: introduce CONFIG_FREE_USER_PTE
  mm: add pte_to_page() helper
  mm: introduce pte_refcount for user PTE page table page
  pte_ref: add track_pte_{set, clear}() helper
  x86/mm: add x86_64 support for pte_ref
  mm: add proc interface to free user PTE page table pages

 arch/x86/Kconfig               |   1 +
 arch/x86/include/asm/pgtable.h |   4 +
 include/linux/mm.h             |   2 +
 include/linux/mm_types.h       |   1 +
 include/linux/pgtable.h        |  11 +-
 include/linux/pte_ref.h        |  41 ++++++
 kernel/sysctl.c                |  12 ++
 mm/Kconfig                     |  11 ++
 mm/Makefile                    |   2 +-
 mm/memory.c                    |   2 +-
 mm/mprotect.c                  |   2 +-
 mm/pte_ref.c                   | 234 +++++++++++++++++++++++++++++++++
 12 files changed, 319 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/pte_ref.h
 create mode 100644 mm/pte_ref.c

-- 
2.20.1

