Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2F849FA7F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348829AbiA1NTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245110AbiA1NTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:08 -0500
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1204CC061749
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 05:19:08 -0800 (PST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375406; h=from : to : cc : subject : date : message-id :
 mime-version : content-transfer-encoding : from;
 bh=L0EsVZmWO0qWAcY9Q+wuJdVY5QDOSEJrwFC5355864I=;
 b=drIZu+9Qhgn3ycz6eNZiNVa30kTXaDUBc3Nl/F3CIEuWD7X8++C0uJE2qyN96BfNGAuoW
 sAsoMrTGpyJ44UpDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375406; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=L0EsVZmWO0qWAcY9Q+wuJdVY5QDOSEJrwFC5355864I=;
 b=EW8z4jZdXvhA2S/FZLp7iytMb8RjRVmWh5S8ZOFSM60GENlUTE4mfzPgslb0/ZR31tPzF
 NXNqW695jMOkPZ6kC8+aYxmMtS0biozVzNSJNfLHrEvECar2qb52rBq8B6fPjt2g8B0OU/q
 bS7e/vZ5XRD6ZNp+wexr6it1NEl0nhRseUKyAY/1VcykPotUG/QBZ4r08Jz5K0DhesCyRwt
 LkMJZEp735V154LNi0Q0n7au8MBR0z09bBztdJHxM1f5ktDfTnmqk23Pi4o2xYg3Uv4lT1A
 NQejPSnYJp9l+TbK22kS/+gK4wjFyUs29qt1CGX3LtCOFQ6Ouqbk97VQzRqQ==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id D169316094B;
        Fri, 28 Jan 2022 05:10:06 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id C119C20132; Fri, 28 Jan 2022 05:10:06 -0800 (PST)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-team@fb.com, Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [PATCH v2 00/35] Speculative page faults
Date:   Fri, 28 Jan 2022 05:09:31 -0800
Message-Id: <20220128131006.67712-1-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is my take on speculative page faults (spf).
It builds on ideas that have been previously proposed by Laurent Dufour,
Peter Zijlstra and others before. While Laurent's previous proposal
was rejected around the time of LSF/MM 2019, I am hoping we can revisit
this now based on what I think is a simpler and more bisectable approach,
much improved scaling numbers in the anonymous vma case, and the Android
use case that has since emerged. I will expand on these points towards
the end of this message.

The patch series applies on top of linux v5.17-rc1;
a git tree is also available:
git fetch https://github.com/lespinasse/linux.git v5.17-rc1-spf-anon

I would like these patches to be considered for inclusion into v5.18.
Several android vendors are using Laurent Dufour's previous SPF work into
their kernel tree in order to improve application startup performance,
want to converge to an upstream accepted solution, and have reported good
numbers with previous versions of this patchset. Also, there is a broader
interest into reducing mmap lock dependencies in critical MM paths,
and I think this patchset would be a good first step in that direction.


This patchset follows the same overall structure as the v1 proposal,
with the following differences:
- Commit 12 (mm: separate mmap locked assertion from find_vma) is new.
- The mmu notifier lock is new; this fixes a race in v1 patchset
  between speculative COW faults and registering new MMU notifiers.
- Speculative handling of swap-cache pages has been removed.
- Commit 30 is new; this fixes build issues that showed in some configs.


In principle it would also be possible to extend this work for handling
file mapped vmas; I have pending work on such patches too but they are
not mature enough to be submitted for inclusion at this point.


Patchset summary:

Classical page fault processing takes the mmap read lock in order to
prevent races with mmap writers. In contrast, speculative fault
processing does not take the mmap read lock, and instead verifies,
when the results of the page fault are about to get committed and
become visible to other threads, that no mmap writers have been
running concurrently with the page fault. If the check fails,
speculative updates do not get committed and the fault is retried
in the usual, non-speculative way (with the mmap read lock held).

The concurrency check is implemented using a per-mm mmap sequence count.
The counter is incremented at the beginning and end of each mmap write
operation. If the counter is initially observed to have an even value,
and has the same value later on, the observer can deduce that no mmap
writers have been running concurrently with it between those two times.
This is similar to a seqlock, except that readers never spin on the
counter value (they would instead revert to taking the mmap read lock),
and writers are allowed to sleep. One benefit of this approach is that
it requires no writer side changes, just some hooks in the mmap write
lock APIs that writers already use.

The first step of a speculative page fault is to look up the vma and
read its contents (currently by making a copy of the vma, though in
principle it would be sufficient to only read the vma attributes that
are used in page faults). The mmap sequence count is used to verify
that there were no mmap writers concurrent to the lookup and copy steps.
Note that walking rbtrees while there may potentially be concurrent
writers is not an entirely new idea in linux, as latched rbtrees
are already doing this. This is safe as long as the lookup is
followed by a sequence check to verify that concurrency did not
actually occur (and abort the speculative fault if it did).

The next step is to walk down the existing page table tree to find the
current pte entry. This is done with interrupts disabled to avoid
races with munmap(). Again, not an entirely new idea, as this repeats
a pattern already present in fast GUP. Similar precautions are also
taken when taking the page table lock.

Breaking COW on an existing mapping may require firing MMU notifiers.
Some care is required to avoid racing with registering new notifiers.
This patchset adds a new per-cpu rwsem to handle this situation.


Commits 1 to 5 are preparatory cleanups.

Commits 6 and 7 introduce CONFIG_SPECULATIVE_PAGE_FAULT and lets us
enable it on x86 so we can test the new code as it gets introduced.

Commits 8 and 9 extend handle_mm_fault() so it can be used for
speculative faults; initially these always abort with VM_FAULT_RETRY.

Commits 10 to 27 progressively implement the speculative handling of
page faults. Importantly, they are structured to be bisectable:
the new code gets enabled every few commits.
- Commit 10 adds the mmap sequence count that will be used for detecting
  when writers have been running concurrently with an spf attempt
  (in which case the attempt will be aborted);
- Commit 11 adds RCU safe vma freeing;
- Commit 12 adds a version of find_vma that doesn't check for mmap locking;
- Commit 13 does a lockless VMA lookup and starts the spf handling attempt;
- Commit 14 introduces an API for preventing page table reclamation
  (using RCU or disabling interrupts depending on build config options);
- (Commit 15 is a small refactor preparing for the next commit);
- Commit 16 walks down the existing page tables, carefully avoiding
  races with potential writers (munmap in particular)
- Commit 17 introduces pte_map_lock() and pte_spinlock(), which attempt
  to (optionally map and) lock an existing page table when it's time to
  commit page fault results to it.
- Commits 18 to 21 implement SPF for the simplest cases
  (do_anonymous_page and do_numa_page). This mostly comes down to
  using the pte_map_lock() and pte_spinlock() APIs where needed,
  and making sure to abort speculation in unsupported cases
  (mostly anon_vma allocation and userfaultfd).
- Commits 22 to 25 add a new mmu_notifier_lock
- Commits 26 and 27 implement some additional SPF cases, using the new
  mmu_notifier_lock for the COW cases.

Commits 28 and 29 disable speculative handling for single threaded
userspace. This is for (minor) performance tuning and is pushed
towards the end of the series to make it easier to exercise the spf
paths as they are introduced.

Commits 30 and 31 add some extra statistics.

Commits 32 to 35 add spf support on the arm64 and powerpc architectures.


Michel Lespinasse (34):
  mm: export dump_mm
  mmap locking API: mmap_lock_is_contended returns a bool
  mmap locking API: name the return values
  do_anonymous_page: use update_mmu_tlb()
  do_anonymous_page: reduce code duplication
  mm: introduce CONFIG_SPECULATIVE_PAGE_FAULT
  x86/mm: define ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
  mm: add FAULT_FLAG_SPECULATIVE flag
  mm: add do_handle_mm_fault()
  mm: add per-mm mmap sequence counter for speculative page fault handling.
  mm: rcu safe vma freeing
  mm: separate mmap locked assertion from find_vma
  x86/mm: attempt speculative mm faults first
  mm: add speculative_page_walk_begin() and speculative_page_walk_end()
  mm: refactor __handle_mm_fault() / handle_pte_fault()
  mm: implement speculative handling in __handle_mm_fault().
  mm: add pte_map_lock() and pte_spinlock()
  mm: implement speculative handling in do_anonymous_page()
  mm: enable speculative fault handling through do_anonymous_page()
  mm: implement speculative handling in do_numa_page()
  mm: enable speculative fault handling in do_numa_page()
  mm: add mmu_notifier_lock
  mm: write lock mmu_notifier_lock when registering mmu notifiers
  mm: add mmu_notifier_trylock() and mmu_notifier_unlock()
  mm: implement speculative handling in wp_page_copy()
  mm: implement and enable speculative fault handling in handle_pte_fault()
  mm: disable speculative faults for single threaded user space
  mm: disable rcu safe vma freeing for single threaded user space
  mm: create new include/linux/vm_event.h header file
  mm: anon spf statistics
  arm64/mm: define ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
  arm64/mm: attempt speculative mm faults first
  powerpc/mm: define ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
  powerpc/mm: attempt speculative mm faults first

Suren Baghdasaryan (1):
  percpu-rwsem: enable percpu_sem destruction in atomic context

 arch/arm64/Kconfig                    |   1 +
 arch/arm64/mm/fault.c                 |  62 ++++
 arch/powerpc/Kconfig                  |   1 +
 arch/powerpc/mm/fault.c               |  64 ++++
 arch/x86/Kconfig                      |   1 +
 arch/x86/mm/fault.c                   |  63 ++++
 drivers/gpu/drm/i915/i915_gpu_error.c |   4 +-
 include/linux/mm.h                    |  68 +++-
 include/linux/mm_types.h              |  33 +-
 include/linux/mmap_lock.h             | 109 ++++--
 include/linux/mmu_notifier.h          |  52 ++-
 include/linux/percpu-rwsem.h          |  13 +-
 include/linux/vm_event.h              | 111 ++++++
 include/linux/vm_event_item.h         |  25 ++
 include/linux/vmstat.h                |  95 +-----
 kernel/fork.c                         |  18 +-
 kernel/locking/percpu-rwsem.c         |  32 ++
 mm/Kconfig                            |  22 ++
 mm/Kconfig.debug                      |   7 +
 mm/debug.c                            |   1 +
 mm/memory.c                           | 474 +++++++++++++++++++-------
 mm/mmap.c                             |  13 +-
 mm/vmstat.c                           |  25 ++
 23 files changed, 1040 insertions(+), 254 deletions(-)
 create mode 100644 include/linux/vm_event.h

-- 
2.20.1

