Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17DC589413
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 23:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbiHCVe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 17:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiHCVeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 17:34:24 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9B81836D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 14:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659562463; x=1691098463;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=65I8n7Wvc8PxKePDuDylWwR2VwgJS4FHDHtBXpWGur4=;
  b=KnQooCv99uQTqWBfN2Ws34hQzkVbQ8QaY/KmF7GtAT1e5BFDrXRC6GTf
   bzjTTCQcZuxc5SevF/SYgcuSzCQkhEW+Dbc1+csKlHnqBBKtKcQRT/2ID
   bi40vcQI6XoNG9nLpl8qJelnn0ru1TywA18UBQbixgS2uKMY7mvQAc1y1
   nAPVmzrmjFVHaCtYwzkClQlj02TZXeM+0YS6o+R7iQa1Epip3d9dyPNhv
   XcJUg+KKkGoqQw5g2INMqgfn6zUfbxsrXOfOLAM3gR7k6awdLXn33Cx9T
   T8K2Td+fgkrD4aHsi5Lo0pkWXe/lfk6qmlANS3xYv10DBMNxHsTbNU1PC
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="288540104"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="288540104"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 14:34:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="578815449"
Received: from viggo.jf.intel.com (HELO ray2.sr71.net) ([10.54.77.144])
  by orsmga006.jf.intel.com with ESMTP; 03 Aug 2022 14:34:23 -0700
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86/sgx for v6.0
Date:   Wed,  3 Aug 2022 14:33:56 -0700
Message-Id: <20220803213356.3396773-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull a set of x86/sgx changes focused on implementing the "SGX2"
features, plus a minor cleanup.

These changes conflict with an SGX bug fix that went in during the 5.19
rc cycle.  The resolution is straightforward and comes courtesy of Ingo:

Merge: e0a5915f1cca e0dccc3b76fb
Author: Ingo Molnar <mingo@kernel.org>
Date:   Tue Jul 26 09:14:28 2022 +0200

    Merge tag 'v5.19-rc8' into x86/sgx, to resolve conflicts
    
    There's overlapping modifications to the sgx/encl.h header,
    due to the following upstream fixes:
    
      0c9782e204d3 ("x86/sgx: Set active memcg prior to shmem allocation")
      6bd429643cc2 ("x86/sgx: Disconnect backing page references from dirty status")
    
    Resolve them.
    
    Conflicts:
           arch/x86/kernel/cpu/sgx/encl.h
    
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

diff --cc arch/x86/kernel/cpu/sgx/encl.h
index 57cc23602bbb,332ef3568267..a65a952116fd
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@@ -103,11 -103,13 +103,14 @@@ static inline int sgx_encl_find(struct 
  int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
  		     unsigned long end, unsigned long vm_flags);
  
+ bool current_is_ksgxd(void);
  void sgx_encl_release(struct kref *ref);
  int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm);
 +const cpumask_t *sgx_encl_cpumask(struct sgx_encl *encl);
- int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
- 			 struct sgx_backing *backing);
+ int sgx_encl_lookup_backing(struct sgx_encl *encl, unsigned long page_index,
+ 			    struct sgx_backing *backing);
+ int sgx_encl_alloc_backing(struct sgx_encl *encl, unsigned long page_index,
+ 			   struct sgx_backing *backing);
  void sgx_encl_put_backing(struct sgx_backing *backing);
  int sgx_encl_test_and_clear_young(struct mm_struct *mm,
  				  struct sgx_encl_page *page);

---

The following changes since commit e3a3bbe3e99de73043a1d32d36cf4d211dc58c7e:

  x86/sgx: Ensure no data in PCMD page after truncate (2022-05-16 15:17:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_v6.0-2022-08-03.1

for you to fetch changes up to e0a5915f1cca21da8ffc0563aea9fa1df5d16fb4:

  x86/sgx: Drop 'page_index' from sgx_backing (2022-07-08 09:31:11 -0700)

----------------------------------------------------------------

 - SGX2 ISA support which makes enclave memory management much more
   dynamic.  For instance, enclaves can now change enclave page
   permissions on the fly.
 - Removal of an unused structure member

----------------------------------------------------------------
Jarkko Sakkinen (1):
      x86/sgx: Export sgx_encl_page_alloc()

Reinette Chatre (30):
      x86/sgx: Add short descriptions to ENCLS wrappers
      x86/sgx: Add wrapper for SGX2 EMODPR function
      x86/sgx: Add wrapper for SGX2 EMODT function
      x86/sgx: Add wrapper for SGX2 EAUG function
      x86/sgx: Support loading enclave page without VMA permissions check
      x86/sgx: Export sgx_encl_ewb_cpumask()
      x86/sgx: Rename sgx_encl_ewb_cpumask() as sgx_encl_cpumask()
      x86/sgx: Move PTE zap code to new sgx_zap_enclave_ptes()
      x86/sgx: Make sgx_ipi_cb() available internally
      x86/sgx: Create utility to validate user provided offset and length
      x86/sgx: Keep record of SGX page type
      x86/sgx: Export sgx_encl_{grow,shrink}()
      x86/sgx: Support VA page allocation without reclaiming
      x86/sgx: Support restricting of enclave page permissions
      x86/sgx: Support adding of pages to an initialized enclave
      x86/sgx: Tighten accessible memory range after enclave initialization
      x86/sgx: Support modifying SGX page type
      x86/sgx: Support complete page removal
      x86/sgx: Free up EPC pages directly to support large page ranges
      Documentation/x86: Introduce enclave runtime management section
      selftests/sgx: Add test for EPCM permission changes
      selftests/sgx: Add test for TCS page permission changes
      selftests/sgx: Test two different SGX2 EAUG flows
      selftests/sgx: Introduce dynamic entry point
      selftests/sgx: Introduce TCS initialization enclave operation
      selftests/sgx: Test complete changing of page type flow
      selftests/sgx: Test faulty enclave behavior
      selftests/sgx: Test invalid access to removed enclave page
      selftests/sgx: Test reclaiming of untouched page
      selftests/sgx: Page removal stress test

Sean Christopherson (1):
      x86/sgx: Drop 'page_index' from sgx_backing

 Documentation/x86/sgx.rst                         |   15 +
 arch/x86/include/asm/sgx.h                        |    8 +
 arch/x86/include/uapi/asm/sgx.h                   |   62 +
 arch/x86/kernel/cpu/sgx/encl.c                    |  330 ++++-
 arch/x86/kernel/cpu/sgx/encl.h                    |   16 +-
 arch/x86/kernel/cpu/sgx/encls.h                   |   33 +
 arch/x86/kernel/cpu/sgx/ioctl.c                   |  641 ++++++++-
 arch/x86/kernel/cpu/sgx/main.c                    |   75 +-
 arch/x86/kernel/cpu/sgx/sgx.h                     |    3 +
 tools/testing/selftests/sgx/defines.h             |   23 +
 tools/testing/selftests/sgx/load.c                |   41 +
 tools/testing/selftests/sgx/main.c                | 1435 +++++++++++++++++++++
 tools/testing/selftests/sgx/main.h                |    1 +
 tools/testing/selftests/sgx/test_encl.c           |   68 +
 tools/testing/selftests/sgx/test_encl_bootstrap.S |    6 +
 15 files changed, 2627 insertions(+), 130 deletions(-)
