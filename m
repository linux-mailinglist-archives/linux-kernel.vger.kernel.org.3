Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C684465652
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 20:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245269AbhLAT1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 14:27:18 -0500
Received: from mga04.intel.com ([192.55.52.120]:46904 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245104AbhLAT1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:27:05 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="235267919"
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="235267919"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 11:23:42 -0800
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="500380434"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 11:23:42 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/25] x86/sgx and selftests/sgx: Support SGX2
Date:   Wed,  1 Dec 2021 11:22:58 -0800
Message-Id: <cover.1638381245.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Everybody,

The current Linux kernel support for SGX includes support for SGX1 that
requires that an enclave be created with properties that accommodate all
usages over its (the enclave's) lifetime. This includes properties such
as permissions of enclave pages, the number of enclave pages, and the
number of threads supported by the enclave.

Consequences of this requirement to have the enclave be created to
accommodate all usages include:
* pages needing to support relocated code are required to have RWX
  permissions for their entire lifetime,
* an enclave needs to be created with the maximum stack and heap
  projected to be needed during the enclave's entire lifetime which
  can be longer than the processes running within it,
* an enclave needs to be created with support for the maximum number
  of threads projected to run in the enclave.

Since SGX1 a few more instructions were introduced, collectively called
SGX2, that support modifications to an initialized enclave. Hardware
supporting these instructions are already available as listed on
https://github.com/ayeks/SGX-hardware

This series adds support for SGX2, also referred to as Enclave Dynamic
Memory Management (EDMM). This includes:

* Support modifying permissions of regular enclave pages belonging to an
  initialized enclave. New permissions are not allowed to exceed the
  originally vetted permissions. Modifying permissions is accomplished
  with a new ioctl SGX_IOC_PAGE_MODP.

* Support dynamic addition of regular enclave pages to an initialized
  enclave. Pages are added with RW permissions as their "originally
  vetted permissions" (see previous bullet) and thus not allowed to
  be made executable at this time. Enabling dynamically added pages
  to obtain executable permissions require integration with user space
  policy that is deferred until the core SGX2 enabling is complete.
  Pages are dynamically added to an initialized enclave from the SGX
  page fault handler.

* Support expanding an initialized enclave to accommodate more threads.
  More threads can be accommodated by an enclave with the addition of
  Thread Control Structure (TCS) pages that is done by changing the
  type of regular enclave pages to TCS pages using a new ioctl
  SGX_IOC_PAGE_MODT.

* Support removing regular and TCS pages from an initialized enclave.
  Removing pages is accomplished in two stages as supported by two new
  ioctls SGX_IOC_PAGE_MODT (same ioctl as mentioned in previous bullet)
  and SGX_IOC_PAGE_REMOVE.

* Tests covering all the new flows, some edge cases, and one
  comprehensive stress scenario.

No additional work is needed to support SGX2 in a virtualized
environment. The tests included in this series can also be run from
a guest and was tested with the recent QEMU release based on 6.2.0
that supports SGX.

Patches 1 to 9 prepares the existing code for SGX2 support by
introducing the SGX2 instructions, making sure pages remain accessible
after their enclave permissions are changed, and tracking enclave page
types as well as runtime permissions as needed by SGX2.

Patches 10 through 25 are a mix of x86/sgx and selftests/sgx patches
that follow the format where first an SGX2 feature is
enabled and then followed by tests of the new feature and/or
tests of scenarios that combine SGX2 features enabled up to that point.

In two cases (patches 14 and 24) code in support of SGX2 is separated
out with detailed motivation to support the review.

This series is based on commit 5c16f7ee03c0 ("Merge branch
'x86/urgent' into x86/sgx, to resolve conflict" as
found on the x86/sgx branch of the tip repo at
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git

Your feedback will be greatly appreciated.

Regards,

Reinette

Reinette Chatre (25):
  x86/sgx: Add shortlog descriptions to ENCLS wrappers
  x86/sgx: Add wrappers for SGX2 functions
  x86/sgx: Support VMA permissions exceeding enclave permissions
  x86/sgx: Add pfn_mkwrite() handler for present PTEs
  x86/sgx: Introduce runtime protection bits
  x86/sgx: Use more generic name for enclave cpumask function
  x86/sgx: Move PTE zap code to separate function
  x86/sgx: Make SGX IPI callback available internally
  x86/sgx: Keep record of SGX page type
  x86/sgx: Support enclave page permission changes
  selftests/sgx: Add test for EPCM permission changes
  selftests/sgx: Add test for TCS page permission changes
  x86/sgx: Support adding of pages to initialized enclave
  x86/sgx: Tighten accessible memory range after enclave initialization
  selftests/sgx: Test two different SGX2 EAUG flows
  x86/sgx: Support modifying SGX page type
  x86/sgx: Support complete page removal
  selftests/sgx: Introduce dynamic entry point
  selftests/sgx: Introduce TCS initialization enclave operation
  selftests/sgx: Test complete changing of page type flow
  selftests/sgx: Test faulty enclave behavior
  selftests/sgx: Test invalid access to removed enclave page
  selftests/sgx: Test reclaiming of untouched page
  x86/sgx: Free up EPC pages directly to support large page ranges
  selftests/sgx: Page removal stress test

 arch/x86/include/asm/sgx.h                    |    8 +
 arch/x86/include/uapi/asm/sgx.h               |   60 +
 arch/x86/kernel/cpu/sgx/encl.c                |  333 +++-
 arch/x86/kernel/cpu/sgx/encl.h                |   12 +-
 arch/x86/kernel/cpu/sgx/encls.h               |   30 +
 arch/x86/kernel/cpu/sgx/ioctl.c               |  647 +++++++-
 arch/x86/kernel/cpu/sgx/main.c                |   70 +-
 arch/x86/kernel/cpu/sgx/sgx.h                 |    3 +
 tools/testing/selftests/sgx/defines.h         |   23 +
 tools/testing/selftests/sgx/load.c            |   41 +
 tools/testing/selftests/sgx/main.c            | 1450 +++++++++++++++++
 tools/testing/selftests/sgx/main.h            |    1 +
 tools/testing/selftests/sgx/test_encl.c       |   68 +
 .../selftests/sgx/test_encl_bootstrap.S       |    6 +
 14 files changed, 2667 insertions(+), 85 deletions(-)


base-commit: 5c16f7ee03c011b0c6cd4c6deccaf0b269d054b2
-- 
2.25.1

