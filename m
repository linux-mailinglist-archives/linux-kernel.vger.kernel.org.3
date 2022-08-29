Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AFD5A5614
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiH2VZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiH2VZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:25:37 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B673D53
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:25:36 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id n30-20020a17090a5aa100b001fb0c492d5eso3876463pji.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc;
        bh=pDTzUH9ZmkMZg3cmno897HgIwaaxstGwmWtClqeSQMY=;
        b=gjUmOZLV9bcbLonNS4lb3WBoz84QjOA/D7CmogvUP5ud9+InysL8Oh9E7DKJdwkXA1
         t51SYWvWY7me7fS7UP+Cv2Nf/JhijDPumYxXmtSNDCmzKiJTL6HeIT2vpSjyKp+dKUA+
         i/6AfO9yhnI27e6m85YLYK5uydUZDc69Ws3yGDc+9jVDOLuag8kYSvlT6GKmBabHISlj
         Agpyx6xSKbJ2VmCCsK/dQfHtKexX+gaWqNmpXiQWr3NzSlhT0v1YMSw9eFOFs2Oau/MZ
         ybOwhTMeJ9rLhGpwSsJLA1PyAZvwxA2dIcGal5knPsRHjNnfif7k984xL88bpesVgDea
         AYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc;
        bh=pDTzUH9ZmkMZg3cmno897HgIwaaxstGwmWtClqeSQMY=;
        b=ZqE2Q4BnrTzQTy7a0at6b34rWIhlj8U7I5auUBK0CWEvlZT3h+F6vD2BEFIhlBhluA
         OoUGnG2hJaxDmRt47yfcoXBVaJYLBdQ7I/r4BgRmSFCB0a+vvTigr+vepV//WyAstWFQ
         9J/NdrBVWWfwKse8ljrnjFyuUBIr+FADskUUXr9/hyjq4+XOHfROQkSjIijDcsEoHMnk
         NCKWjq+Slpe3+SZz/5OmPwpeflfJWPsgX8Oj2EBPH0nEqVcHG8nLd8x86QOMdeHIKz+g
         u4F1k22qV+J/lsTZXHFhDg5dt5A6oRF8psY8bN6LmFLeede0ZJjU6hjUmxVv9GY1sxRG
         2anA==
X-Gm-Message-State: ACgBeo0igL7Zyz2xaC6caLZm36sQCgTqk3+LbUMBLtfbQTkKm+bkDJ8Y
        VK4u1qRl4G93zepHMij2kncm7/ieq8U=
X-Google-Smtp-Source: AA6agR6UQmZ/vaRok0dLo0fY9ZItUpZFj7DUiATdYYW4UNrGosZUH5TdrbUN0W11FQtWqAaY7kD6g0jugM8=
X-Received: from surenb-spec.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e30])
 (user=surenb job=sendgmr) by 2002:a05:6a00:1a47:b0:52e:6a8c:5430 with SMTP id
 h7-20020a056a001a4700b0052e6a8c5430mr18212460pfv.48.1661808335904; Mon, 29
 Aug 2022 14:25:35 -0700 (PDT)
Date:   Mon, 29 Aug 2022 21:25:03 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829212531.3184856-1-surenb@google.com>
Subject: [RFC PATCH 00/28] per-VMA locks proposal
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, riel@surriel.com,
        luto@kernel.org, songliubraving@fb.com, peterx@redhat.com,
        david@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        rientjes@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, surenb@google.com, kernel-team@android.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a proof of concept for per-vma locks idea that was discussed
during SPF [1] discussion at LSF/MM this year [2], which concluded with
suggestion that =E2=80=9Ca reader/writer semaphore could be put into the VM=
A
itself; that would have the effect of using the VMA as a sort of range
lock. There would still be contention at the VMA level, but it would be an
improvement.=E2=80=9D This patchset implements this suggested approach.

When handling page faults we lookup the VMA that contains the faulting
page under RCU protection and try to acquire its lock. If that fails we
fall back to using mmap_lock, similar to how SPF handled this situation.

One notable way the implementation deviates from the proposal is the way
VMAs are marked as locked. Because during some of mm updates multiple
VMAs need to be locked until the end of the update (e.g. vma_merge,
split_vma, etc). Tracking all the locked VMAs, avoiding recursive locks
and other complications would make the code more complex. Therefore we
provide a way to "mark" VMAs as locked and then unmark all locked VMAs
all at once. This is done using two sequence numbers - one in the
vm_area_struct and one in the mm_struct. VMA is considered locked when
these sequence numbers are equal. To mark a VMA as locked we set the
sequence number in vm_area_struct to be equal to the sequence number
in mm_struct. To unlock all VMAs we increment mm_struct's seq number.
This allows for an efficient way to track locked VMAs and to drop the
locks on all VMAs at the end of the update.

The patchset implements per-VMA locking only for anonymous pages which
are not in swap. If the initial proposal is considered acceptable, then
support for swapped and file-backed page faults will be added.

Performance benchmarks show similar although slightly smaller benefits as
with SPF patchset (~75% of SPF benefits). Still, with lower complexity
this approach might be more desirable.

The patchset applies cleanly over 6.0-rc3
The tree for testing is posted at [3]

[1] https://lore.kernel.org/all/20220128131006.67712-1-michel@lespinasse.or=
g/
[2] https://lwn.net/Articles/893906/
[3] https://github.com/surenbaghdasaryan/linux/tree/per_vma_lock_rfc

Laurent Dufour (2):
  powerc/mm: try VMA lock-based page fault handling first
  powerpc/mm: define ARCH_SUPPORTS_PER_VMA_LOCK

Michel Lespinasse (1):
  mm: rcu safe VMA freeing

Suren Baghdasaryan (25):
  mm: introduce CONFIG_PER_VMA_LOCK
  mm: introduce __find_vma to be used without mmap_lock protection
  mm: move mmap_lock assert function definitions
  mm: add per-VMA lock and helper functions to control it
  mm: mark VMA as locked whenever vma->vm_flags are modified
  kernel/fork: mark VMAs as locked before copying pages during fork
  mm/khugepaged: mark VMA as locked while collapsing a hugepage
  mm/mempolicy: mark VMA as locked when changing protection policy
  mm/mmap: mark VMAs as locked in vma_adjust
  mm/mmap: mark VMAs as locked before merging or splitting them
  mm/mremap: mark VMA as locked while remapping it to a new address
    range
  mm: conditionally mark VMA as locked in free_pgtables and
    unmap_page_range
  mm: mark VMAs as locked before isolating them
  mm/mmap: mark adjacent VMAs as locked if they can grow into unmapped
    area
  kernel/fork: assert no VMA readers during its destruction
  mm/mmap: prevent pagefault handler from racing with mmu_notifier
    registration
  mm: add FAULT_FLAG_VMA_LOCK flag
  mm: disallow do_swap_page to handle page faults under VMA lock
  mm: introduce per-VMA lock statistics
  mm: introduce find_and_lock_anon_vma to be used from arch-specific
    code
  x86/mm: try VMA lock-based page fault handling first
  x86/mm: define ARCH_SUPPORTS_PER_VMA_LOCK
  arm64/mm: try VMA lock-based page fault handling first
  arm64/mm: define ARCH_SUPPORTS_PER_VMA_LOCK
  kernel/fork: throttle call_rcu() calls in vm_area_free

 arch/arm64/Kconfig                     |   1 +
 arch/arm64/mm/fault.c                  |  36 +++++++++
 arch/powerpc/mm/fault.c                |  41 ++++++++++
 arch/powerpc/platforms/powernv/Kconfig |   1 +
 arch/powerpc/platforms/pseries/Kconfig |   1 +
 arch/x86/Kconfig                       |   1 +
 arch/x86/mm/fault.c                    |  36 +++++++++
 drivers/gpu/drm/i915/i915_gpu_error.c  |   4 +-
 fs/proc/task_mmu.c                     |   1 +
 fs/userfaultfd.c                       |   6 ++
 include/linux/mm.h                     | 104 ++++++++++++++++++++++++-
 include/linux/mm_types.h               |  33 ++++++--
 include/linux/mmap_lock.h              |  37 ++++++---
 include/linux/vm_event_item.h          |   6 ++
 include/linux/vmstat.h                 |   6 ++
 kernel/fork.c                          |  75 +++++++++++++++++-
 mm/Kconfig                             |  13 ++++
 mm/Kconfig.debug                       |   8 ++
 mm/init-mm.c                           |   6 ++
 mm/internal.h                          |   4 +-
 mm/khugepaged.c                        |   1 +
 mm/madvise.c                           |   1 +
 mm/memory.c                            |  82 ++++++++++++++++---
 mm/mempolicy.c                         |   6 +-
 mm/mlock.c                             |   2 +
 mm/mmap.c                              |  60 ++++++++++----
 mm/mprotect.c                          |   1 +
 mm/mremap.c                            |   1 +
 mm/nommu.c                             |   2 +
 mm/oom_kill.c                          |   3 +-
 mm/vmstat.c                            |   6 ++
 31 files changed, 531 insertions(+), 54 deletions(-)

--=20
2.37.2.672.g94769d06f0-goog

