Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A874D5019
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244438AbiCJRVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbiCJRV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:21:28 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E2218E43B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646932827; x=1678468827;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+e4PqjCc2KBrj7kwZL0QjPv2+FSRzg3osW7I5H9U1X8=;
  b=Uq4bDRX38RjHs2vA77ltV32GQ9qilys1l2revUHrXNx3cD4qvIgUEAM4
   H48PSZq+othxWek9dRxqrjQfcGAn2xPn9Hw/qv08XPK7J4NAANInjev8i
   3VahuSaGgMyomwEC+QYXel/vUJMwagKz6oyWiKuqItabfHmf2I2tu2TsQ
   mi1UxR/DHE44KL5ubckU1+/we/+1ekzHDMQn8Wjv/vQED57YTcDASee7J
   BnvF52eO+cU6mOaikcbMCh1LxgWTF333LDbLeGEBL7ixgahBII2uGSkdh
   gWy8I9xkvdGb9JUE/vCLr7Th3OAIcRiw85yC0Fg6ql5ssGBW6oRRQc4Es
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="254141822"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="254141822"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:20:26 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="510983647"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:20:25 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V9 00/45] PKS/PMEM: Add Stray Write Protection
Date:   Thu, 10 Mar 2022 09:19:34 -0800
Message-Id: <20220310172019.850939-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>


I'm looking for Intel acks on the series prior to submitting to maintainers.
Most of the changes from V8 to V9 was in getting the tests straightened out.
But there are some improvements in the actual code.


Changes for V9

Review and update all commit messages.
Update cover letter below

PKS Core
	Separate user and supervisor pkey code in the headers
		create linux/pks.h for supervisor calls
		This facilitated making the pmem code more efficient 
	Completely rearchitect the test code
		[After Dave Hansen and Rick Edgecombe found issues in the test
			code it was easier to rearchitect the code completely
			rather than attempt to fix it.]
		Remove pks_test_callback in favor of using fault hooks
			Fault hooks also isolate the fault callbacks from being
			false positives if non-test consumers are running
		Make additional PKS_TEST_RUN_ALL Kconfig option which is
			mutually exclusive to any non-test PKS consumer
			PKS_TEST_RUN_ALL takes over all pkey callbacks
		Ensure that each test runs within it's own context and is
			mutually exclusive from running while any other test is
			running.
		Ensure test session and context memory is cleaned up on file
			close
		Use pr_debug() and dynamic debug for in kernel debug messages
		Enhance test_pks selftest
			Add the ability to run all tests not just the context
				switch test
			Standardize output [PASS][FAIL][SKIP]
			Add '-d' option enables dynamic debug to see the kernel
				debug messages

	Incorporate feedback from Rick Edgecombe
		Update all pkey types to u8
		Fix up test code barriers
	Move patch declaring PKS_INIT_VALUE ahead of the patch which enables
		PKS so that PKS_INIT_VALUE can be used when pks_setup() is
		first created
	From Dan Williams
		Use macros instead of an enum for a pkey allocation scheme
			which is predicated on the config options of consumers
			This almost worked perfectly.  It required a bit of
			tweeking to be able to allocate all of the keys.

	From Dave Hansen
		Reposition some code to be near/similar to user pkeys
			s/pks_write_current/x86_pkrs_load
			s/pks_saved_pkrs/pkrs
		Update Documentation
		s/PKR_{RW,AD,WD}_KEY/PKR_{RW,AD,WD}_MASK
		Consistently use lower case for pkey
		Update commit messages
		Add Acks

PMEM Stray Write
	Building on the change to the pks_mk_*() function rename
		s/pgmap_mk_*/pgmap_set_*/
		s/dax_mk_*/dax_set_*/
	From Dan Williams
		Avoid adding new dax operations by teaching dax_device about pgmap
		Remove pgmap_protection_flag_invalid() patch (Just let
			kmap'ings fail)


PKS/PMEM Stray write protection
===============================

This series is broken into 2 parts.

	1) Introduce Protection Key Supervisor (PKS), testing, and
	   documentation
	2) Use PKS to protect PMEM from stray writes

Introduce Protection Key Supervisor (PKS)
-----------------------------------------

PKS enables protections on 'domains' of supervisor pages to limit supervisor
mode access to pages beyond the normal paging protections.  PKS works in a
similar fashion to user space pkeys, PKU.  As with PKU, supervisor pkeys are
checked in addition to normal paging protections.  And page mappings are
assigned to a domain by setting a 4 bit pkey in the PTE of that mapping.

Unlike PKU, permissions are changed via a MSR update.  This update avoids TLB
flushes making this an efficient way to alter protections vs PTE updates.

Also, unlike PTE updates PKS permission changes apply only to the current
processor.  Therefore changing permissions apply only to that thread and not
any other cpu/process.  This allows protections to remain in place on other
cpus for additional protection and isolation.

Even though PKS updates are thread local, XSAVE is not supported for the PKRS
MSR.  Therefore this implementation saves and restores the MSR across context
switches and during exceptions within software.  Nested exceptions are
supported by each exception getting a new PKS state.

For consistent behavior with current paging protections, pkey 0 is reserved and
configured to allow full access via the pkey mechanism, thus preserving the
default paging protections because PTEs naturally have a pkey value of 0.

Other keys, (1-15) are statically allocated by kernel consumers when
configured.  This is done by adding the appropriate PKS_NEW_KEY and
PKS_DECLARE_INIT_VALUE macros to pks-keys.h.

Two PKS consumers, PKS_TEST and PMEM stray write protection, are included in
this series.  When the number of users grows larger the sharing of keys will
need to be resolved depending on the needs of the users at that time.  Many
methods have been contemplated but the number of kernel users and use cases
envisioned is still quite small, much less than the 15 available keys.

To summarize, the following are key attributes of PKS.

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
that is needed in each dev_pagemap to indicate protection.

General access in the kernel is supported by modifying the kmap infrastructure
which can detect if a page is pks protected and enable access until the
corresponding unmap is called.

Because PKS is a thread local mechanism and because kmap was never really
intended to create a long term mapping, this implementation does not support
the kmap()/kunmap() calls.  Calling kmap() on a PMEM protected page is allowed
but accessing that mapping will cause a fault.

Originally this series modified many of the kmap call sites to indicate they
were thread local.[1]  And an attempt to support kmap()[2] was made.  But now
that kmap_local_page() has been developed[3] and in more wide spread use,
kmap() can safely be left unsupported.

How the fault is handled is configurable via a new module parameter
memremap.pks_fault_mode.  Two modes are supported.

	'relaxed' (default) -- WARN_ONCE, disable the protection and allow
	                       access

	'strict' -- prevent any unguarded access to a protected dev_pagemap
		    range

This 'safety valve' feature has already been useful in the development of this
feature.


[1] https://lore.kernel.org/lkml/20201009195033.3208459-1-ira.weiny@intel.com/

[2] https://lore.kernel.org/lkml/87mtycqcjf.fsf@nanos.tec.linutronix.de/

[3] https://lore.kernel.org/lkml/20210128061503.1496847-1-ira.weiny@intel.com/
    https://lore.kernel.org/lkml/20210210062221.3023586-1-ira.weiny@intel.com/
    https://lore.kernel.org/lkml/20210205170030.856723-1-ira.weiny@intel.com/
    https://lore.kernel.org/lkml/20210217024826.3466046-1-ira.weiny@intel.com/


----------------------------------------------------------------------------
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

Fenghua Yu (1):
mm/pkeys: Define PKS page table macros

Ira Weiny (43):
entry: Create an internal irqentry_exit_cond_resched() call
Documentation/protection-keys: Clean up documentation for User Space
pkeys
x86/pkeys: Clarify PKRU_AD_KEY macro
x86/pkeys: Make PKRU macros generic
x86/fpu: Refactor arch_set_user_pkey_access()
mm/pkeys: Add Kconfig options for PKS
x86/pkeys: Add PKS CPU feature bit
x86/fault: Adjust WARN_ON for pkey fault
Documentation/pkeys: Add initial PKS documentation
mm/pkeys: Provide for PKS key allocation
x86/pkeys: Enable PKS on cpus which support it
mm/pkeys: PKS testing, add initial test code
x86/selftests: Add test_pks
x86/pkeys: Introduce pks_write_pkrs()
x86/pkeys: Preserve the PKS MSR on context switch
mm/pkeys: Introduce pks_set_readwrite()
mm/pkeys: Introduce pks_set_noaccess()
mm/pkeys: PKS testing, add a fault call back
mm/pkeys: PKS testing, add pks_set_*() tests
mm/pkeys: PKS testing, test context switching
x86/entry: Add auxiliary pt_regs space
entry: Split up irqentry_exit_cond_resched()
entry: Add calls for save/restore auxiliary pt_regs
x86/entry: Define arch_{save|restore}_auxiliary_pt_regs()
x86/pkeys: Preserve PKRS MSR across exceptions
x86/fault: Print PKS MSR on fault
mm/pkeys: PKS testing, Add exception test
mm/pkeys: Introduce pks_update_exception()
mm/pkeys: PKS testing, test pks_update_exception()
mm/pkeys: PKS testing, add test for all keys
mm/pkeys: Add pks_available()
memremap_pages: Add Kconfig for DEVMAP_ACCESS_PROTECTION
memremap_pages: Introduce pgmap_protection_available()
memremap_pages: Introduce a PGMAP_PROTECTION flag
memremap_pages: Introduce devmap_protected()
memremap_pages: Reserve a PKS pkey for eventual use by PMEM
memremap_pages: Set PKS pkey in PTEs if requested
memremap_pages: Define pgmap_set_{readwrite|noaccess}() calls
memremap_pages: Add memremap.pks_fault_mode
kmap: Make kmap work for devmap protected pages
dax: Stray access protection for dax_direct_access()
nvdimm/pmem: Enable stray access protection
devdax: Enable stray access protection

Rick Edgecombe (1):
mm/pkeys: Introduce PKS fault callbacks

.../admin-guide/kernel-parameters.txt | 12 +
Documentation/core-api/protection-keys.rst | 130 ++-
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
arch/x86/include/asm/pkeys_common.h | 18 +
arch/x86/include/asm/pkru.h | 20 +-
arch/x86/include/asm/pks.h | 46 ++
arch/x86/include/asm/processor.h | 15 +-
arch/x86/include/asm/ptrace.h | 21 +
arch/x86/include/uapi/asm/processor-flags.h | 2 +
arch/x86/kernel/asm-offsets_64.c | 15 +
arch/x86/kernel/cpu/common.c | 2 +
arch/x86/kernel/dumpstack.c | 32 +-
arch/x86/kernel/fpu/xstate.c | 22 +-
arch/x86/kernel/head_64.S | 6 +
arch/x86/kernel/process_64.c | 3 +
arch/x86/mm/fault.c | 17 +-
arch/x86/mm/pkeys.c | 320 +++++++-
drivers/dax/device.c | 2 +
drivers/dax/super.c | 59 ++
drivers/md/dm-writecache.c | 8 +-
drivers/nvdimm/pmem.c | 26 +
fs/dax.c | 8 +
fs/fuse/virtio_fs.c | 2 +
include/linux/dax.h | 5 +
include/linux/entry-common.h | 15 +-
include/linux/highmem-internal.h | 4 +
include/linux/memremap.h | 1 +
include/linux/mm.h | 72 ++
include/linux/pgtable.h | 4 +
include/linux/pks-keys.h | 92 +++
include/linux/pks.h | 73 ++
include/linux/sched.h | 7 +
include/uapi/asm-generic/mman-common.h | 1 +
init/init_task.c | 3 +
kernel/entry/common.c | 44 +-
kernel/sched/core.c | 40 +-
lib/Kconfig.debug | 33 +
lib/Makefile | 3 +
lib/pks/Makefile | 3 +
lib/pks/pks_test.c | 755 ++++++++++++++++++
mm/Kconfig | 32 +
mm/memremap.c | 132 +++
tools/testing/selftests/x86/Makefile | 2 +-
tools/testing/selftests/x86/test_pks.c | 514 ++++++++++++
54 files changed, 2617 insertions(+), 109 deletions(-)
create mode 100644 arch/x86/include/asm/pkeys_common.h
create mode 100644 arch/x86/include/asm/pks.h
create mode 100644 include/linux/pks-keys.h
create mode 100644 include/linux/pks.h
create mode 100644 lib/pks/Makefile
create mode 100644 lib/pks/pks_test.c
create mode 100644 tools/testing/selftests/x86/test_pks.c

--
2.35.1

