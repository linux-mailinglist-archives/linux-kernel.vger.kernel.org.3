Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89FA4ACDB7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242856AbiBHBJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344143AbiBHAqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 19:46:12 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4045DC0612A4;
        Mon,  7 Feb 2022 16:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644281170; x=1675817170;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uxzua+aQavrFlY/woe2UthUq1F6We8I98mCxiSukQCA=;
  b=Oxmrjz8kbFumQQv2RIrR8WqHHHVHTcyzC1D0q8tYGnDOI1ZmfH6nLYfx
   MAzzjYCZ9Smu/bx8O+tWRADN6ieZK6HO4/Q+gbhpesvN66xJygKxtFdsM
   GUo7jS+9kqDeU6UDqmzEfvPcKfDX8avqG+j1pfLb7yvkpihvpBJRgCeN0
   cOm2oSbc1wyfWGNdb3hGeDgnDzNrOCxUTJxuqIiHZuRcl+i6Q8wPG1eZy
   Nc7UpkZxloWs621bvYaN27iHC1r5MY5WlCs/Mf1cWR9sZtZXj6u7V8jFm
   5sgINL7K8CfOTmx4U29wrQ4IrEbqv1NW8iu3vHDn2tjlnC0ahUI7gEWRj
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="232407929"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="232407929"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 16:46:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="499389465"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 16:46:08 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 00/32] x86/sgx and selftests/sgx: Support SGX2
Date:   Mon,  7 Feb 2022 16:45:22 -0800
Message-Id: <cover.1644274683.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V1: https://lore.kernel.org/linux-sgx/cover.1638381245.git.reinette.chatre@intel.com/

Changes since V1 that directly impact user space:
- SGX2 permission changes changed from a single ioctl() named
  SGX_IOC_PAGE_MODP to two new ioctl()s:
  SGX_IOC_ENCLAVE_RELAX_PERMISSIONS and
  SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS, supported by two different
  parameter structures (SGX_IOC_ENCLAVE_RELAX_PERMISSIONS does
  not support a result output parameter) (Jarkko).

  User space flow impact: After user space runs ENCLU[EMODPE] it
  needs to call SGX_IOC_ENCLAVE_RELAX_PERMISSIONS to have PTEs
  updated. Previously running SGX_IOC_PAGE_MODP in this scenario
  resulted in EPCM.PR being set but calling
  SGX_IOC_ENCLAVE_RELAX_PERMISSIONS will not result in EPCM.PR
  being set anymore and thus no need for an additional
  ENCLU[EACCEPT].

- SGX_IOC_ENCLAVE_RELAX_PERMISSIONS and
  SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS
  obtain new permissions from secinfo as parameter instead of
  the permissions directly (Jarkko).

- ioctl() supporting SGX2 page type change is renamed from
  SGX_IOC_PAGE_MODT to SGX_IOC_ENCLAVE_MODIFY_TYPE (Jarkko).

- SGX_IOC_ENCLAVE_MODIFY_TYPE obtains new page type from secinfo
  as parameter instead of the page type directly (Jarkko).

- ioctl() supporting SGX2 page removal is renamed from
  SGX_IOC_PAGE_REMOVE to SGX_IOC_ENCLAVE_REMOVE_PAGES (Jarkko).

- All ioctl() parameter structures have been renamed as a result of the
  ioctl() renaming:
  SGX_IOC_ENCLAVE_RELAX_PERMISSIONS => struct sgx_enclave_relax_perm
  SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS => struct sgx_enclave_restrict_perm
  SGX_IOC_ENCLAVE_MODIFY_TYPE => struct sgx_enclave_modt
  SGX_IOC_ENCLAVE_REMOVE_PAGES => struct sgx_enclave_remove_pages

Changes since V1 that do not directly impact user space:
- Number of patches in series increased from 25 to 32 primarily because
  of splitting the original submission:
  - Wrappers for the new SGX2 functions are introduced in three separate
    patches replacing the original "x86/sgx: Add wrappers for SGX2
    functions"
    (Jarkko).
  - Moving and renaming sgx_encl_ewb_cpumask() is done with two patches
    replacing the original "x86/sgx: Use more generic name for enclave
    cpumask function" (Jarkko).
  - Support for SGX2 EPCM permission changes is split into two ioctls(),
    one for relaxing and one for restricting permissions, each introduced
    by a new patch replacing the original "x86/sgx: Support enclave page
    permission changes" (Jarkko).
  - Extracted code used by existing ioctls() for usage by new ioctl()s
    into a new utility in new patch "x86/sgx: Create utility to validate
    user provided offset and length" (Dave did not specifically ask for
    this but it addresses his review feedback).
  - Two new Documentation patches to support the SGX2 work
    ("Documentation/x86: Introduce enclave runtime management") and
    a dedicated section on the enclave permission management
    ("Documentation/x86: Document SGX permission details") (Andy).
- Most patches were reworked to improve the language by:
  * aiming to refer to exact item instead of English rephrasing (Jarkko).
  * use ioctl() instead of ioctl throughout (Dave).
  * Use "relaxed" instead of "exceed" when referring to permissions
    (Dave).
- Improved documentation with several additions to
  Documentation/x86/sgx.rst.
- Many smaller changes, please refer to individual patches.

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

Since SGX1 a few more functions were introduced, collectively called
SGX2, that support modifications to an initialized enclave. Hardware
supporting these functions are already available as listed on
https://github.com/ayeks/SGX-hardware

This series adds support for SGX2, also referred to as Enclave Dynamic
Memory Management (EDMM). This includes:

* Support modifying permissions of regular enclave pages belonging to an
  initialized enclave. New permissions are not allowed to exceed the
  originally vetted permissions. For example, RX isn't allowed unless
  the page was originally added with RX or RWX.
  Modifying permissions is accomplished with two new ioctl()s:
  SGX_IOC_ENCLAVE_RELAX_PERMISSIONS and
  SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS.

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
  type of regular enclave pages to TCS pages using a new ioctl()
  SGX_IOC_ENCLAVE_MODIFY_TYPE.

* Support removing regular and TCS pages from an initialized enclave.
  Removing pages is accomplished in two stages as supported by two new
  ioctl()s SGX_IOC_ENCLAVE_MODIFY_TYPE (same ioctl() as mentioned in
  previous bullet) and SGX_IOC_ENCLAVE_REMOVE_PAGES.

* Tests covering all the new flows, some edge cases, and one
  comprehensive stress scenario.

No additional work is needed to support SGX2 in a virtualized
environment. The tests included in this series can also be run from
a guest and was tested with the recent QEMU release based on 6.2.0
that supports SGX.

Patches 1 to 14 prepares the existing code for SGX2 support by
introducing the SGX2 functions, making sure pages remain accessible
after their enclave permissions are changed, and tracking enclave page
types as well as runtime permissions as needed by SGX2.

Patches 15 through 32 are a mix of x86/sgx and selftests/sgx patches
that follow the format where first an SGX2 feature is
enabled and then followed by tests of the new feature and/or
tests of scenarios that combine SGX2 features enabled up to that point.

In two cases (patches 20 and 31) code in support of SGX2 is separated
out with detailed motivation to support the review.

This series is based on v5.17-rc2 with the following fixes additionally
applied:

"selftests/sgx: Remove extra newlines in test output"
 https://lore.kernel.org/linux-sgx/16317683a1822bbd44ab3ca48b60a9a217ac24de.1643754040.git.reinette.chatre@intel.com/
"selftests/sgx: Ensure enclave data available during debug print"
 https://lore.kernel.org/linux-sgx/eaaeeb9122916d831942fc8a3043c687137314c1.1643754040.git.reinette.chatre@intel.com/
"selftests/sgx: Do not attempt enclave build without valid enclave"
 https://lore.kernel.org/linux-sgx/4e4ea6d70c286c209964bec1e8d29ac8e692748b.1643754040.git.reinette.chatre@intel.com/
"selftests/sgx: Fix NULL-pointer-dereference upon early test failure"
 https://lore.kernel.org/linux-sgx/89824888783fd8e770bfc64530c7549650a41851.1643754040.git.reinette.chatre@intel.com/
"x86/sgx: Add poison handling to reclaimer"
 https://lore.kernel.org/linux-sgx/dcc95eb2aaefb042527ac50d0a50738c7c160dac.1643830353.git.reinette.chatre@intel.com/
"x86/sgx: Silence softlockup detection when releasing large enclaves"
 https://lore.kernel.org/linux-sgx/b5e9f218064aa76e3026f778e1ad0a1d823e3db8.1643133224.git.reinette.chatre@intel.com/

Your feedback will be greatly appreciated.

Regards,

Reinette

Reinette Chatre (32):
  x86/sgx: Add short descriptions to ENCLS wrappers
  x86/sgx: Add wrapper for SGX2 EMODPR function
  x86/sgx: Add wrapper for SGX2 EMODT function
  x86/sgx: Add wrapper for SGX2 EAUG function
  Documentation/x86: Document SGX permission details
  x86/sgx: Support VMA permissions more relaxed than enclave permissions
  x86/sgx: Add pfn_mkwrite() handler for present PTEs
  x86/sgx: x86/sgx: Add sgx_encl_page->vm_run_prot_bits for dynamic
    permission changes
  x86/sgx: Export sgx_encl_ewb_cpumask()
  x86/sgx: Rename sgx_encl_ewb_cpumask() as sgx_encl_cpumask()
  x86/sgx: Move PTE zap code to new sgx_zap_enclave_ptes()
  x86/sgx: Make sgx_ipi_cb() available internally
  x86/sgx: Create utility to validate user provided offset and length
  x86/sgx: Keep record of SGX page type
  x86/sgx: Support relaxing of enclave page permissions
  x86/sgx: Support restricting of enclave page permissions
  selftests/sgx: Add test for EPCM permission changes
  selftests/sgx: Add test for TCS page permission changes
  x86/sgx: Support adding of pages to an initialized enclave
  x86/sgx: Tighten accessible memory range after enclave initialization
  selftests/sgx: Test two different SGX2 EAUG flows
  x86/sgx: Support modifying SGX page type
  x86/sgx: Support complete page removal
  Documentation/x86: Introduce enclave runtime management section
  selftests/sgx: Introduce dynamic entry point
  selftests/sgx: Introduce TCS initialization enclave operation
  selftests/sgx: Test complete changing of page type flow
  selftests/sgx: Test faulty enclave behavior
  selftests/sgx: Test invalid access to removed enclave page
  selftests/sgx: Test reclaiming of untouched page
  x86/sgx: Free up EPC pages directly to support large page ranges
  selftests/sgx: Page removal stress test

 Documentation/x86/sgx.rst                     |   64 +-
 arch/x86/include/asm/sgx.h                    |    8 +
 arch/x86/include/uapi/asm/sgx.h               |   81 +
 arch/x86/kernel/cpu/sgx/encl.c                |  334 +++-
 arch/x86/kernel/cpu/sgx/encl.h                |   12 +-
 arch/x86/kernel/cpu/sgx/encls.h               |   33 +
 arch/x86/kernel/cpu/sgx/ioctl.c               |  831 ++++++++-
 arch/x86/kernel/cpu/sgx/main.c                |   70 +-
 arch/x86/kernel/cpu/sgx/sgx.h                 |    3 +
 tools/testing/selftests/sgx/defines.h         |   23 +
 tools/testing/selftests/sgx/load.c            |   41 +
 tools/testing/selftests/sgx/main.c            | 1484 +++++++++++++++++
 tools/testing/selftests/sgx/main.h            |    1 +
 tools/testing/selftests/sgx/test_encl.c       |   68 +
 .../selftests/sgx/test_encl_bootstrap.S       |    6 +
 15 files changed, 2963 insertions(+), 96 deletions(-)


base-commit: 26291c54e111ff6ba87a164d85d4a4e134b7315c
prerequisite-patch-id: 3c3908f1c3536cc04ba020fb3e81f51395b44223
prerequisite-patch-id: e860923423c3387cf6fdcceb2fa41dc5e9454ef4
prerequisite-patch-id: 986260c8bc4255eb61e2c4afa88d2b723e376423
prerequisite-patch-id: ba014a99fced2b57d5d9e2dfb9d80ddf4333c13e
prerequisite-patch-id: 65cbb72889b6353a5639b984615d12019136b270
prerequisite-patch-id: e3296a2f0345a77c8a7ca91f76697ae2e1dca21f
-- 
2.25.1

