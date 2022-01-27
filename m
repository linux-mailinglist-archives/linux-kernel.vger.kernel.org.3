Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F0949E955
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbiA0RzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:55:09 -0500
Received: from mga18.intel.com ([134.134.136.126]:31650 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234701AbiA0RzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306107; x=1674842107;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uMFTcU081YLv6y7pb/02RUx19fmV+DEhOz1KxnHsVXU=;
  b=cJ/+BJmtnbYRrgiUYYi9qZy515Q4VHYeFt7k4+pbFb/HIEq3NvH59YvL
   9hS7tWP6pGklUQyxC2fNW+vCC3YoBgp5s4mw7aPsJ984GtMREpbPIcW8n
   rXhO645mZ3lOuNknO5iqOTRYNqoHU3FNKKSA/bNEE9n9+fDattahfKq0x
   MWdLOk83stSZQD2lHJJC5mnDGEHvWlleAprAAFAlAbdWLoMIii+RhNukl
   T5f1jWEX9AC3pCv4QnQLW0ZV5yqnM/9X6oFBzgkRB1zzsr8D4NbcKxQ/q
   lCDVXI+WVqJqX2XJ+NUsyS4vML8VoEonilNErGo+YRukIZ7UxY3TUaAF6
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="230500079"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="230500079"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="535759375"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:06 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 00/44] PKS/PMEM: Add Stray Write Protection
Date:   Thu, 27 Jan 2022 09:54:21 -0800
Message-Id: <20220127175505.851391-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

NOTES:

I'm sending these to Intel reviewers to get their opinions on this code in a
public forum.  All feedback from V7 has been addressed in addition to a number
of changes.

Peter Anvin suggested that saving and restoring the MSR in the assembly code
might be better.  For him using the C code seemed a bit late for his taste.
But the MSR is saved and restored within the common entry code prior to any
general code being called.  I can't see the general entry code requiring
special PKS access.  It certainly does not for the PMEM use case.

I've also considered changing the name of pt_regs_extended and
pt_regs_auxiliary to something more generic.  Technically these are not 'ptrace
registers' but the names seem ok since they do extend the pt_regs within the C
code.  So I left the names alone.

Finally, I've changed the patches to be smaller and more direct to 1 change in
the code.  This helped to clarify why each particular change was made but it
also created more interdependence between the patches.  This does not mean that
the series is not bisectable but it does mean that some patches will not do
anything useful other than lay ground work for patches to follow.  I hope this
is ok.



Changes for V8

Feedback from Thomas
	* clean up noinstr mess
	* Fix static PKEY allocation mess
	* Ensure all functions are consistently named.
	* Split up patches to do 1 thing per patch
	* pkey_update_pkval() implementation
	* Streamline the use of pks_write_pkrs() by not disabling preemption
		- Leave this to the callers who require it.
		- Use documentation and lockdep to prevent errors
	* Clean up commit messages to explain in detail _why_ each patch is
		there.

Feedback from Dave H.
	* Leave out pks_mk_readonly() as it is not used by the PMEM use case

Feedback from Peter Anvin
	* Replace pks_abandon_pkey() with pks_update_exception()
		This is an even greater simplification in that it no longer
		attempts to shield users from faults.  As the main use case for
		abandoning a key was to allow a system to continue running even
		with an error.  This should be a rare event so the performance
		should not be an issue.

* Simplify ARCH_ENABLE_SUPERVISOR_PKEYS

* Update PKS Test code
	- Add default value test
	- Split up the test code into patches which follow each feature
	  addition
	- simplify test code processing
	- ensure consistent reporting of errors.

* Ensure all entry points to the PKS code are protected by
	cpu_feature_enabled(X86_FEATURE_PKS)
	- At the same time make sure non-entry points or sub-functions to the
	  PKS code are not _unnecessarily_ protected by the feature check

* Update documentation
	- Use kernel docs to place the docs with the code for easier internal
	  developer use

* Adjust the PMEM use cases for the core changes

* Split the PMEM patches up to be 1 change per patch and help clarify review

* Review all header files and remove those no longer needed

* Review/update/clarify all commit messages



PKS/PMEM Stray write protection
===============================

This series is broken into 2 parts.

	1) Introduce Protection Key Supervisor (PKS)
	2) Use PKS to protect PMEM from stray writes

Introduce Protection Key Supervisor (PKS)
-----------------------------------------

PKS enables protections on 'domains' of supervisor pages to limit supervisor
mode access to pages beyond the normal paging protections.  PKS works in a
similar fashion to user space pkeys, PKU.  As with PKU, supervisor pkeys are
checked in addition to normal paging protections.  And page mappings are
assigned to a pkey domain by setting a 4 bit pkey in the PTE of that mapping.

Unlike PKU, permissions are changed via a MSR update.  This update avoids TLB
flushes making this an efficient way to alter protections vs PTE updates.

XSAVE is not supported for the PKRS MSR.  Therefore the implementation saves
and restores the MSR across context switches and during exceptions within
software.  Nested exceptions are supported by each exception getting a new
PKS state.

For consistent behavior with current paging protections, pkey 0 is reserved and
configured to allow full access via the pkey mechanism, thus preserving the
default paging protections because PTEs naturally have a pkey value of 0.

Other keys, (1-15) are statically allocated by kernel users.  This is done by
adding an entry to 'enum pks_pkey_consumers' and a corresponding default value
in PKS_INIT_VALUE.

2 users of keys, PKS_TEST and PMEM stray write protection, are included in this
series.  When the number of users grows larger the sharing of keys will need to
be resolved depending on the needs of the users at that time.  Many methods
have been contemplated but the number of kernel users and use cases envisioned
is still quite small.  Much less than the 15 available keys.

The following are key attributes of PKS.

	1) Fast switching of permissions
		1a) Prevents access without page table manipulations
		1b) No TLB flushes required
	2) Works on a per thread basis, thus allowing protections to be
	   preserved on threads which are not actively accessing data through
	   the mapping.

PKS is available with 4 and 5 level paging.  For this and simplicity of
implementation, the feature is restricted to x86_64.


Use PKS to protect PMEM from stray writes
-----------------------------------------

DAX leverages the direct-map to enable 'struct page' services for PMEM.  Given
that PMEM capacity may be an order of magnitude higher capacity than System RAM
it presents a large vulnerability surface to stray writes.  Such a stray write
becomes a silent data corruption bug.

Stray pointers to System RAM may result in a crash or other undesirable
behavior which, while unfortunate, are usually recoverable with a reboot.
Stray writes to PMEM are permanent in nature and thus are more likely to result
in permanent user data loss.  Given that PMEM access from the kernel is limited
to a constrained set of locations (PMEM driver, Filesystem-DAX, direct-I/O, and
any properly kmap'ed page), it is amenable to PKS protection.

Set up an infrastructure for extra device access protection. Then implement the
protection using the new Protection Keys Supervisor (PKS) on architectures
which support it.

Because PMEM pages are all associated with a struct dev_pagemap and flags in
struct page are valuable the flag of protecting memory can be stored in struct
dev_pagemap.  All PMEM is protected by the same pkey.  So a single flag is all
that is needed in each page to indicate protection.

General access in the kernel is supported by modifying the kmap infrastructure
which can detect if a page is pks protected and enable access until the
corresponding unmap is called.

Because PKS is a thread local mechanism and because kmap was never really
intended to create a long term mappings, this implementation does not support
the kmap()/kunmap() calls.  Calling kmap() on a PMEM protected page is flagged
with a warning with a trace from that call stack.  Access to that mapping may
or may not cause a fault depending on if they are within the thread which
created the mapping.

Originally this series modified many of the kmap call sites to indicate they
were thread local.[1]  And an attempt to support kmap()[2] was made.  But now
that kmap_local_page() has been developed[3] and in more wide spread use,
kmap() can safely be left unsupported.

Furthermore, handling invalid access to these pages is configurable via a new
module parameter memremap.pks_fault_mode.  2 modes are suported.

	'relaxed' (default) -- WARN_ONCE, disable the protection and allow
	                       access

	'strict' -- prevent any unguarded access to a protected dev_pagemap
		    range

The fault handler detects the invalid access and applies the above
configuration.  Relaxed warns of the condition while allowing the access to
continue.  Where 'strict' oopes the kernel.  This 'safety valve' feature has
already been useful in the development of this feature.

Due to the nesting nature of kmap and the pmem direct accesses, in addition to
the fact that the pkey is a single global domain, reference counting must be
employed to ensure that access remain enabled on a thread which may be nesting
access and or creating access to multiple PMEM pages at a time.  The reference
count is stored the struct thread_struct.

Reference counting is not needed during exceptions as normal PMEM accesses are
never done during exceptions.



[1] https://lore.kernel.org/lkml/20201009195033.3208459-1-ira.weiny@intel.com/

[2] https://lore.kernel.org/lkml/87mtycqcjf.fsf@nanos.tec.linutronix.de/

[3] https://lore.kernel.org/lkml/20210128061503.1496847-1-ira.weiny@intel.com/
    https://lore.kernel.org/lkml/20210210062221.3023586-1-ira.weiny@intel.com/
    https://lore.kernel.org/lkml/20210205170030.856723-1-ira.weiny@intel.com/
    https://lore.kernel.org/lkml/20210217024826.3466046-1-ira.weiny@intel.com/

[4] https://lore.kernel.org/lkml/20201106232908.364581-1-ira.weiny@intel.com/

[5] https://lore.kernel.org/lkml/20210322053020.2287058-1-ira.weiny@intel.com/

[6] https://lore.kernel.org/lkml/20210331191405.341999-1-ira.weiny@intel.com/


Fenghua Yu (1):
mm/pkeys: Define PKS page table macros

Ira Weiny (42):
entry: Create an internal irqentry_exit_cond_resched() call
Documentation/protection-keys: Clean up documentation for User Space
pkeys
x86/pkeys: Create pkeys_common.h
x86/pkeys: Add additional PKEY helper macros
x86/fpu: Refactor arch_set_user_pkey_access()
mm/pkeys: Add Kconfig options for PKS
x86/pkeys: Add PKS CPU feature bit
x86/fault: Adjust WARN_ON for PKey fault
x86/pkeys: Enable PKS on cpus which support it
Documentation/pkeys: Add initial PKS documentation
mm/pkeys: Define static PKS key array and default values
mm/pkeys: Add initial PKS Test code
x86/pkeys: Introduce pks_write_pkrs()
x86/pkeys: Preserve the PKS MSR on context switch
mm/pkeys: Introduce pks_mk_readwrite()
mm/pkeys: Introduce pks_mk_noaccess()
x86/fault: Add a PKS test fault hook
mm/pkeys: PKS Testing, add pks_mk_*() tests
mm/pkeys: Add PKS test for context switching
x86/entry: Add auxiliary pt_regs space
entry: Pass pt_regs to irqentry_exit_cond_resched()
entry: Add architecture auxiliary pt_regs save/restore calls
x86/entry: Define arch_{save|restore}_auxiliary_pt_regs()
x86/pkeys: Preserve PKRS MSR across exceptions
x86/fault: Print PKS MSR on fault
mm/pkeys: Add PKS exception test
mm/pkeys: Introduce pks_update_exception()
mm/pkeys: Test setting a PKS key in a custom fault callback
mm/pkeys: Add pks_available()
memremap_pages: Add Kconfig for DEVMAP_ACCESS_PROTECTION
memremap_pages: Introduce pgmap_protection_available()
memremap_pages: Introduce a PGMAP_PROTECTION flag
memremap_pages: Introduce devmap_protected()
memremap_pages: Reserve a PKS PKey for eventual use by PMEM
memremap_pages: Set PKS PKey in PTEs if PGMAP_PROTECTIONS is requested
memremap_pages: Define pgmap_mk_{readwrite|noaccess}() calls
memremap_pages: Add memremap.pks_fault_mode
memremap_pages: Add pgmap_protection_flag_invalid()
kmap: Ensure kmap works for devmap pages
dax: Stray access protection for dax_direct_access()
nvdimm/pmem: Enable stray access protection
devdax: Enable stray access protection

Rick Edgecombe (1):
mm/pkeys: Introduce PKS fault callbacks

.../admin-guide/kernel-parameters.txt | 14 +
Documentation/core-api/protection-keys.rst | 135 +++-
arch/x86/Kconfig | 6 +
arch/x86/entry/calling.h | 20 +
arch/x86/entry/common.c | 2 +-
arch/x86/entry/entry_64.S | 22 +
arch/x86/entry/entry_64_compat.S | 6 +
arch/x86/include/asm/cpufeatures.h | 1 +
arch/x86/include/asm/disabled-features.h | 8 +-
arch/x86/include/asm/entry-common.h | 15 +
arch/x86/include/asm/msr-index.h | 1 +
arch/x86/include/asm/pgtable_types.h | 22 +
arch/x86/include/asm/pkeys.h | 2 +
arch/x86/include/asm/pkeys_common.h | 15 +
arch/x86/include/asm/pkru.h | 16 +-
arch/x86/include/asm/pks.h | 51 ++
arch/x86/include/asm/processor.h | 17 +-
arch/x86/include/asm/ptrace.h | 22 +
arch/x86/include/uapi/asm/processor-flags.h | 2 +
arch/x86/kernel/asm-offsets_64.c | 15 +
arch/x86/kernel/cpu/common.c | 2 +
arch/x86/kernel/fpu/xstate.c | 22 +-
arch/x86/kernel/head_64.S | 6 +
arch/x86/kernel/process_64.c | 3 +
arch/x86/mm/fault.c | 32 +-
arch/x86/mm/pkeys.c | 312 +++++++-
drivers/dax/device.c | 2 +
drivers/dax/super.c | 54 ++
drivers/md/dm-writecache.c | 8 +-
drivers/nvdimm/pmem.c | 52 +-
fs/dax.c | 8 +
fs/fuse/virtio_fs.c | 2 +
include/linux/dax.h | 8 +
include/linux/entry-common.h | 15 +-
include/linux/highmem-internal.h | 5 +
include/linux/memremap.h | 1 +
include/linux/mm.h | 90 +++
include/linux/pgtable.h | 4 +
include/linux/pkeys.h | 54 ++
include/linux/pks-keys.h | 64 ++
include/linux/sched.h | 7 +
include/uapi/asm-generic/mman-common.h | 1 +
init/init_task.c | 3 +
kernel/entry/common.c | 44 +-
kernel/sched/core.c | 40 +-
lib/Kconfig.debug | 12 +
lib/Makefile | 3 +
lib/pks/Makefile | 3 +
lib/pks/pks_test.c | 692 ++++++++++++++++++
mm/Kconfig | 23 +
mm/memremap.c | 150 ++++
tools/testing/selftests/x86/Makefile | 2 +-
tools/testing/selftests/x86/test_pks.c | 168 +++++
53 files changed, 2176 insertions(+), 108 deletions(-)
create mode 100644 arch/x86/include/asm/pkeys_common.h
create mode 100644 arch/x86/include/asm/pks.h
create mode 100644 include/linux/pks-keys.h
create mode 100644 lib/pks/Makefile
create mode 100644 lib/pks/pks_test.c
create mode 100644 tools/testing/selftests/x86/test_pks.c

--
2.31.1

