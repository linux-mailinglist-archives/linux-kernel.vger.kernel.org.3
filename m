Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB3A48CD97
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 22:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiALVUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 16:20:37 -0500
Received: from mga03.intel.com ([134.134.136.65]:1416 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbiALVUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 16:20:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642022436; x=1673558436;
  h=from:to:cc:subject:date:message-id;
  bh=oxP3kSzMpQU8LS3Jv/vnJRR1g2ZKuhTNt8AONEbvO4I=;
  b=beRX8cVocSudKRkV70l3ausB2Lo4uuawQuAahj25Y+Ej2etkQ1Yj95Qj
   PQX9i3tRVtgKDLd+rGEF75F++zc5wX77gLFx5grL7zrwFCsHuVmEINTo2
   KQ0EiAFirYWNbWPlU60LeSY8qa0vUc9fPilZ+nc7KpPPY1KBxTSjuICq/
   KP2/EDEIT2BGKDqgfDUOjWvBgJk2ekVLBbQS+3sDuhPjVHDC51q73RlMT
   6iyT8OEPogsthLizjkw50E3fshGXVgyaROm6qIBN4MJdcwwKAvh12Ia1c
   +oLWVvfCKcezw2XePwBtDLTN7v81VBgmK0rg9OkgblrGlpu/BF1lFvn9Q
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="243810777"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="243810777"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 13:20:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="529378212"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga008.jf.intel.com with ESMTP; 12 Jan 2022 13:20:35 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-crypto@vger.kernel.org, dm-devel@redhat.com,
        herbert@gondor.apana.org.au, ebiggers@kernel.org, ardb@kernel.org,
        x86@kernel.org, luto@kernel.org, tglx@linutronix.de, bp@suse.de,
        dave.hansen@linux.intel.com, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        charishma1.gairuboyina@intel.com, kumar.n.dwarakanath@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Subject: [PATCH v5 00/12] x86: Support Key Locker
Date:   Wed, 12 Jan 2022 13:12:46 -0800
Message-Id: <20220112211258.21115-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v4 [1]:
* Drop CBC mode support (PATCH10). (Eric Biggers)
* Update the changelog (PATCH8). (Rafael Wysocki)

A couple of other things outside of these patches are still in progress:
* Support DM-crypt/cryptsetup for Key Locker usage (Andy Lutomirski)
  [2].
* Understand decryption under-performance (Eric Biggers and Milan Broz)
  [3][4].

This feature's usage for the threat model can be found in the previous
cover letter [1]. This version is based on 5.16.

Thanks,
Chang

[1] V4: https://lore.kernel.org/lkml/20211214005212.20588-1-chang.seok.bae@intel.com/
[2] https://lore.kernel.org/lkml/75ec3ad1-6234-ae1f-1b83-482793e4fd23@kernel.org/
[3] https://lore.kernel.org/lkml/YbqRseO+TtuGQk5x@sol.localdomain/
[4] https://lore.kernel.org/lkml/120368dc-e337-9176-936c-4db2a8bf710e@gmail.com/

Chang S. Bae (12):
  Documentation/x86: Document Key Locker
  x86/cpufeature: Enumerate Key Locker feature
  x86/insn: Add Key Locker instructions to the opcode map
  x86/asm: Add a wrapper function for the LOADIWKEY instruction
  x86/msr-index: Add MSRs for Key Locker internal wrapping key
  x86/keylocker: Define Key Locker CPUID leaf
  x86/cpu/keylocker: Load an internal wrapping key at boot-time
  x86/PM/keylocker: Restore internal wrapping key on resume from ACPI
    S3/4
  x86/cpu: Add a configuration and command line option for Key Locker
  crypto: x86/aes - Prepare for a new AES implementation
  crypto: x86/aes-kl - Support AES algorithm using Key Locker
    instructions
  crypto: x86/aes-kl - Support XTS mode

 .../admin-guide/kernel-parameters.txt         |   2 +
 Documentation/x86/index.rst                   |   1 +
 Documentation/x86/keylocker.rst               |  98 +++
 arch/x86/Kconfig                              |   3 +
 arch/x86/crypto/Makefile                      |   5 +-
 arch/x86/crypto/aes-intel_asm.S               |  26 +
 arch/x86/crypto/aes-intel_glue.c              | 125 ++++
 arch/x86/crypto/aes-intel_glue.h              |  48 ++
 arch/x86/crypto/aeskl-intel_asm.S             | 633 ++++++++++++++++++
 arch/x86/crypto/aeskl-intel_glue.c            | 216 ++++++
 arch/x86/crypto/aesni-intel_asm.S             |  58 +-
 arch/x86/crypto/aesni-intel_glue.c            | 239 ++-----
 arch/x86/crypto/aesni-intel_glue.h            |  17 +
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/disabled-features.h      |   8 +-
 arch/x86/include/asm/keylocker.h              |  45 ++
 arch/x86/include/asm/msr-index.h              |   6 +
 arch/x86/include/asm/special_insns.h          |  32 +
 arch/x86/include/uapi/asm/processor-flags.h   |   2 +
 arch/x86/kernel/Makefile                      |   1 +
 arch/x86/kernel/cpu/common.c                  |  21 +-
 arch/x86/kernel/cpu/cpuid-deps.c              |   1 +
 arch/x86/kernel/keylocker.c                   | 199 ++++++
 arch/x86/kernel/smpboot.c                     |   2 +
 arch/x86/lib/x86-opcode-map.txt               |  11 +-
 arch/x86/power/cpu.c                          |   2 +
 crypto/Kconfig                                |  36 +
 tools/arch/x86/lib/x86-opcode-map.txt         |  11 +-
 28 files changed, 1633 insertions(+), 216 deletions(-)
 create mode 100644 Documentation/x86/keylocker.rst
 create mode 100644 arch/x86/crypto/aes-intel_asm.S
 create mode 100644 arch/x86/crypto/aes-intel_glue.c
 create mode 100644 arch/x86/crypto/aes-intel_glue.h
 create mode 100644 arch/x86/crypto/aeskl-intel_asm.S
 create mode 100644 arch/x86/crypto/aeskl-intel_glue.c
 create mode 100644 arch/x86/crypto/aesni-intel_glue.h
 create mode 100644 arch/x86/include/asm/keylocker.h
 create mode 100644 arch/x86/kernel/keylocker.c


base-commit: df0cc57e057f18e44dac8e6c18aba47ab53202f9
--
2.17.1

