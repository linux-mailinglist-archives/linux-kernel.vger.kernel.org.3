Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9994ECF80
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 00:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351531AbiC3WUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 18:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347068AbiC3WUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 18:20:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD2122B1B;
        Wed, 30 Mar 2022 15:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648678719; x=1680214719;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O10FtJqoENJ6+MZXX+uwUYHQdNl71GLWCtw3HiZNIsA=;
  b=S0hBWTvPIyYURPuRTBrpQOpgUcphdBF0GFqjFT+nNw9JtFcOr+3ArPmV
   /wmPXEtPaG2noFf7IBXOVekk4/VJD7KdZLy36g0azN0DzEm0+zuplWVhu
   P6HT8XIVJ85KbiQDZkWKHxQq3fbcOKSnXninK2Ca4Vwy45le7IAv3m9Im
   0psMyydjbcj7ZcTDlx7L4uRkkMf5qruRyCsvfXuCH8AYQx+QPnfM6FHzY
   5VQaZRs6arSxdCDywVhuvWvefx8pSdLREUDfT/0RC9mb/neq7kQJlcF2T
   uJ+EHOLqvfUuccRxWqw5JNZGYULDagOnC7oe6q53q8G2gDyx8aOoAqL+1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="241811835"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="241811835"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 15:18:22 -0700
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="788171857"
Received: from ksanitha-mobl3.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.209.123.221])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 15:18:21 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 0/6] Add TDX Guest Attestation support
Date:   Wed, 30 Mar 2022 15:17:59 -0700
Message-Id: <cover.1648664666.git.sathyanarayanan.kuppuswamy@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@intel.com>

Hi All,

Intel's Trust Domain Extensions (TDX) protect guest VMs from malicious
hosts and some physical attacks. VM guest with TDX support is called
as TD Guest.

In TD Guest, the attestation process is used to verify the 
trustworthiness of TD guest to the 3rd party servers. Such attestation
process is required by 3rd party servers before sending sensitive
information to TD guests. One usage example is to get encryption keys
from the key server for mounting the encrypted rootfs or secondary drive.
    
Following patches add the attestation support to TDX guest which
includes attestation user interface driver, user agent example, and
related hypercall support.

Patch titled "platform/x86: intel_tdx_attest: Add TDX Guest attestation
interface driver" adds the attestation driver support. This is supposed
to be reviewed by platform-x86 maintainers.

Rest of the patches including the patch titled "tools/tdx: Add a sample
attestation user app" are intended for x86 maintainers review.


Dependencies:
--------------

This feature has dependency on TDX guest core patch set series.

https://lore.kernel.org/all/20220218161718.67148-1-kirill.shutemov@linux.intel.com/T/

History:
----------

Previously this patch set was sent under title "Add TDX Guest
Support (Attestation support)". In the previous version, only the
attestation driver patch was reviewed and got acked. Rest of the
patches need to be reviewed freshly.

https://lore.kernel.org/bpf/20210806000946.2951441-1-sathyanarayanan.kuppuswamy@linux.intel.com/

Changes since v1:
 * Moved test driver from "tools/tdx/attest/tdx-attest-test.c" to
   "tools/arch/x86/tdx/attest/tdx-attest-test.c" as per Hans review
   suggestion.
 * Minor commit log and comment fixes in patches titled
   "x86/tdx: Add tdx_mcall_tdreport() API support" and "x86/tdx:
   Add tdx_hcall_get_quote() API support"
 * Extended tdx_hcall_get_quote() API to accept GPA length as argument
   to accomodate latest TDQUOTE TDVMCALL related specification update.
 * Added support for tdx_setup_ev_notify_handler() and
   tdx_remove_ev_notify_handler() in patch titled "x86/tdx: Add TDX
   Guest event notify interrupt vector support"

Changes since previous submission:
 * Updated commit log and error handling in TDREPORT, GetQuote and
   SetupEventNotifyInterrupt support patches.
 * Added locking support in attestation driver.

Kuppuswamy Sathyanarayanan (6):
  x86/tdx: Add tdx_mcall_tdreport() API support
  x86/tdx: Add tdx_hcall_get_quote() API support
  x86/tdx: Add SetupEventNotifyInterrupt TDX hypercall support
  x86/tdx: Add TDX Guest event notify interrupt vector support
  platform/x86: intel_tdx_attest: Add TDX Guest attestation interface
    driver
  tools/tdx: Add a sample attestation user app

 arch/x86/coco/tdx/tdx.c                       | 180 ++++++++++++
 arch/x86/include/asm/hardirq.h                |   4 +
 arch/x86/include/asm/idtentry.h               |   4 +
 arch/x86/include/asm/irq_vectors.h            |   7 +-
 arch/x86/include/asm/tdx.h                    |   8 +
 arch/x86/kernel/irq.c                         |   7 +
 drivers/platform/x86/intel/Kconfig            |   1 +
 drivers/platform/x86/intel/Makefile           |   1 +
 drivers/platform/x86/intel/tdx/Kconfig        |  13 +
 drivers/platform/x86/intel/tdx/Makefile       |   3 +
 .../platform/x86/intel/tdx/intel_tdx_attest.c | 230 +++++++++++++++
 include/uapi/misc/tdx.h                       |  42 +++
 tools/Makefile                                |  16 +-
 tools/arch/x86/tdx/Makefile                   |  19 ++
 tools/arch/x86/tdx/attest/.gitignore          |   2 +
 tools/arch/x86/tdx/attest/Makefile            |  24 ++
 tools/arch/x86/tdx/attest/tdx-attest-test.c   | 263 ++++++++++++++++++
 17 files changed, 820 insertions(+), 4 deletions(-)
 create mode 100644 drivers/platform/x86/intel/tdx/Kconfig
 create mode 100644 drivers/platform/x86/intel/tdx/Makefile
 create mode 100644 drivers/platform/x86/intel/tdx/intel_tdx_attest.c
 create mode 100644 include/uapi/misc/tdx.h
 create mode 100644 tools/arch/x86/tdx/Makefile
 create mode 100644 tools/arch/x86/tdx/attest/.gitignore
 create mode 100644 tools/arch/x86/tdx/attest/Makefile
 create mode 100644 tools/arch/x86/tdx/attest/tdx-attest-test.c

-- 
2.25.1

