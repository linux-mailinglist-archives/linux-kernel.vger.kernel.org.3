Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4885A469792
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244941AbhLFN6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:58:50 -0500
Received: from mga04.intel.com ([192.55.52.120]:44554 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244914AbhLFN6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:58:43 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="236052904"
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="236052904"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 05:55:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="562781457"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 06 Dec 2021 05:55:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E44FB144; Mon,  6 Dec 2021 15:55:16 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org
Cc:     ak@linux.intel.com, dan.j.williams@intel.com, hpa@zytor.com,
        jroedel@suse.de, knsathya@kernel.org, linux-kernel@vger.kernel.org,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        thomas.lendacky@amd.com, tony.luck@intel.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 0/3] Share common features between AMD SEV / TDX guest
Date:   Mon,  6 Dec 2021 16:55:02 +0300
Message-Id: <20211206135505.75045-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel's Trust Domain Extensions (TDX) protect guest VMs from malicious
hosts and some physical attacks. TDX has a lot of similarities to AMD SEV.
Features like encryption/decryption and string I/O unroll support can
be shared between these two technologies.

This patch set adds infrastructure changes required to share the code
between AMD SEV and TDX.

v3:
 - Adjust wording in 1/3 based on Tom's feedback.
 - Tested-by from Tom.
v2:
 - Squash first two patches
 - Rename print_amd_mem_encrypt_feature_info() to print_mem_encrypt_feature_info().
   It will report TDX feature too.

Kirill A. Shutemov (1):
  x86: Move common memory encryption code to mem_encrypt.c

Kuppuswamy Sathyanarayanan (2):
  x86/sev: Use CC_ATTR attribute to generalize string I/O unroll
  x86/sev: Rename mem_encrypt.c to mem_encrypt_amd.c

 arch/x86/Kconfig              |  10 +-
 arch/x86/include/asm/io.h     |  20 +-
 arch/x86/kernel/cc_platform.c |   4 +
 arch/x86/mm/Makefile          |   7 +-
 arch/x86/mm/mem_encrypt.c     | 441 +---------------------------------
 arch/x86/mm/mem_encrypt_amd.c | 438 +++++++++++++++++++++++++++++++++
 include/linux/cc_platform.h   |  11 +
 7 files changed, 473 insertions(+), 458 deletions(-)
 create mode 100644 arch/x86/mm/mem_encrypt_amd.c

-- 
2.32.0

