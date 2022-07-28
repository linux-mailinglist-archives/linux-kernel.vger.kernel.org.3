Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764B15837AC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237448AbiG1Dod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiG1Do3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:44:29 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761F95C96B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658979868; x=1690515868;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2RAC6cgFEMyES8AR32bBQv8vPeehvpO0yq9MM2d56sI=;
  b=A+JqbLn7j6opmVd3ASg2q73R4y4bEaLeh9ZUTFE6z09jkyCVLUTLDyt6
   kAvudfcCap+Pmebu7PJ6OVqQCfFyEMzzx3EXdu7K9CpsBIoveS7cwD8vI
   tlcpR6pxXElzMIEoydOGN1LxujeXDXCHnkbFLmA70Ck//1P1bex5p7wcq
   j3eBz53e/8IQ6PVq8MUT2KmFHFWVebkkyIk7iVSWvugAILYdnW+y3y5v2
   OWX2fm818BLrf8qQydwEXwo/C4XGNofNESRhji0bei5QKH7Z9av8px8z7
   DK/RLsdGXBIapY35I+9uRi++F9GgOnfqog1LFMhVuAw3R39/D338xL3Na
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="275292798"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="275292798"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 20:44:28 -0700
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="600676726"
Received: from hurleyst-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.209.106.108])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 20:44:27 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/6] Add TDX Guest Attestation support
Date:   Wed, 27 Jul 2022 20:44:14 -0700
Message-Id: <20220728034420.648314-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Intel's Trust Domain Extensions (TDX) protect guest VMs from malicious
hosts and some physical attacks. VM guest with TDX support is called
as TD Guest.

In TD Guest, the attestation process is used to verify the 
trustworthiness of TD guest to the 3rd party servers. Such attestation
process is required by 3rd party servers before sending sensitive
information to TD guests. One usage example is to get encryption keys
from the key server for mounting the encrypted rootfs or secondary drive.

During TD launch, the initial contents and configuration of the TD are
recorded by the Intel TDX module in the build time measurement register
(MRTD). In addition, run-time measurement registers (RTMRs)  can be
used by the guest TD software, e.g., to measure a boot process. At
run-time, the Intel TDX module reuses the Intel SGX attestation
infrastructure to provide support for attesting to these measurements
as described below.

Intel TDX attestation is intended to be used in two phases:

TD Guest can use the TDCALL(TDG.MR.REPORT) function to request the
Intel TDX Module to generate an integrity-protected TDREPORT structure
(TDREPORT_STRUCT). This structure includes the TD’s measurements, the
Intel TDX module’s measurements, and a value provided by the guest TD
software. This will typically be an asymmetric key that the attestation
verifier can use to establish a secure channel or protect sensitive
data to be sent to the TD software.

To protect the integrity of TDREPORT_STRUCT, it is HMAC'ed using an
HMAC key which by design can only be verified on the local platform via
the SGX ENCLU(EVERIFYREPORT2) instruction. So to create a remotely
verifiable attestation, the TDREPORT_STRUCT should be converted into a
Quote signed by a certified Quote signing key.

An Intel SGX Quoting Enclave (QE), written specifically to support
quoting Intel TDX TDs, uses EVERIFYREPORT2, to help check the integrity
of the TDG.MR.REPORT. If it passes, the QE can use a certified quote
signing key to sign a quote containing the guest TD’s measurements and
the additional data being quoted.

Method of sending the TDREPORT to QE and to get the Quote depends on
the implementation and deployment of QE. For quote requests from the
guest user space, communication models like vsock or TCP/IP can be
used to get the Quote from QE. But for requests generated during
pre-boot time, since such communication methods may not be available,
QEs at basic had to support GetQuote hypercall model. To keep the
attestation communication protocol same during pre-boot and
post-boot time, some QEs may just opt only to support GetQuote
hypercall request model. So add support to allow guest TD user space
get the Quote using GetQuote hypercall.

Since the Quote generation involves communication with QE, the response
time cannot be accurately defined and is generally long. So to let the TD
guest not wait for the response, host VMM supports callback event
notification via an interrupt vector. This can be used by the host to
notify the TD regarding the completion of the Quote request.
    
Following patches add the attestation support to the TDX guest which
includes attestation user interface driver, related hypercall
support and self test modules.

Patch 1-2/6 -> Adds TDREPORT support and related selftest.
Patch 3/6   -> Adds event notification IRQ support
Patch 4/6   -> Adds cc_decrypted_alloc/free() support
Patch 5-6/6 -> Adds Quote generation support and related selftest.

Any distribution enabling TDX is also expected to need attestation. So
enable it by default with TDX guest support. The compiled size is
quite small (~500 bytes).

Changes since v8:
 * To keep the interface generic to TDX guest, changed interface device
   name from tdx-attest -> tdx-guest. Also moved interface device creation
   logic from attest.c -> tdx.c.
 * Converted test app into self test module as per review suggestion.
 * Added subtype and length parameters to tdx_report_req ABI.
 * Regarding event notification IRQ, changed static IRQ vector
   reservation to runtime model.
 * For quote generation shared buffer allocation, replace vmap based
   allocation with DMA wrappers (cc_decrypted_alloc/free()).
 * Fixed commit log as per review comments.

Changes since v7:
 * Removed exports symbols for tdx_setup_ev_notify_handler() and
   tdx_remove_ev_notify_handler().
 * Changed "struct quote_buf *buf" member in "struct quote_entry"
   from pointer to embed object.
 * Rebased on top of v5.19-rc1.

Changes since v6:
 * Fixed race between wait_for_completion_*() and
   quote_callback_handler() in tdx_get_quote() when user terminates the
   request.
 * Fixed commit log and comments.

Changes since v5:
 * Added support for parallel GetQuote requests.
 * Add noalias variants of set_memory_*crypted() functions to
   changes page attribute without touching direct map.
 * Made set_memory_*crypted() functions vmalloc address compatible.
 * Use vmap()/set_memory_*crypted() functions to share/unshare
   memory without touching the direct map.
 * Add support to let driver handle the memory cleanup for the
   early termination of user requests.
 * Removed unused headers in attest.c
 * Fixed commit log and comments as per review comments.

Changes since v4:
 * Removed platform driver model in attestation driver and used
   miscdevice and initcall approach.
 * Since dma_alloc*() APIs require a valid device reference,
   replaced it with __get_free_pages() and set_memory_decrypted()
   for quote memory allocation.
 * Removed tdx_mcall_tdreport() and moved TDG.MR.REPORT TDCALL code
   to tdx_get_report().
 * Used kmalloc() for TDREPORT memory allocation instead of
   get_zeroed_page().
 * Returned -EINVAL in default case of tdx_attest_ioctl().
 * Added struct tdx_report_req to explicitly mention the
   TDX_CMD_GET_REPORT IOCTL argument.
 * Removed tdx_get_quote_hypercall() and moved hypercall code to
   attestation driver itself.
 * Removed GetQuote timeout support (since it is not defined in
   spec)
 * Added support to check for spurious callback interrupt in GetQuote
   request.
 * Fixed commit log and comments as per review suggestions.
   

Changes since v3:
 * Moved the attestation driver from platform/x86 to arch/x86/coco/tdx/ and
   renamed intel_tdx_attest.c to attest.c.
 * Dropped CONFIG_INTEL_TDX_ATTESTATION and added support to compile
   attestation changes with CONFIG_INTEL_TDX_GUEST option.
 * Merged patch titled "x86/tdx: Add tdx_mcall_tdreport() API support" and
   "platform/x86: intel_tdx_attest: Add TDX Guest attestation interface" into
   a single patch.
 * Moved GetQuote IOCTL support changes from patch titled "platform/x86:
   intel_tdx_attest: Add TDX Guest attestation interface driver" to a
   separate patch.
 * Removed 8K size restriction when requesting quote, and added support
   to let userspace decide the quote size.
 * Added support to allow attestation agent configure quote generation
   timeout value.
 * Fixed commit log and comments as per review comments.

Changes since v2:
 * As per Han's suggestion, modified the attestation driver to use
   platform device driver model.
 * Modified tdx_hcall_get_quote() and tdx_mcall_tdreport() APIs to
   return TDCALL error code instead of generic error info (like -EIO).
 * Removed attestation test app patch from this series to simplify
   the patchset and review process. Test app patches will be submitted
   once attestation support patches are merged.
 * Since patches titled "x86/tdx: Add SetupEventNotifyInterrupt TDX
   hypercall support" and "x86/tdx: Add TDX Guest event notify
   interrupt vector support" are related, combining them into a
   single patch.

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


Kuppuswamy Sathyanarayanan (6):
  x86/tdx: Add TDX Guest attestation interface driver
  selftests: tdx: Test GetReport TDX attestation feature
  x86/tdx: Add TDX Guest event notify interrupt support
  x86/coco: Add cc_decrypted_alloc/free() interfaces
  x86/tdx: Add Quote generation support
  selftests: tdx: Test GetQuote TDX attestation feature

 arch/x86/coco/Makefile                        |   2 +-
 arch/x86/coco/mem.c                           |  90 +++++
 arch/x86/coco/tdx/Makefile                    |   2 +-
 arch/x86/coco/tdx/attest.c                    | 363 ++++++++++++++++++
 arch/x86/coco/tdx/tdx.c                       | 149 +++++++
 arch/x86/coco/tdx/tdx.h                       |  11 +
 arch/x86/include/asm/coco.h                   |  10 +
 arch/x86/include/asm/tdx.h                    |   2 +
 arch/x86/include/uapi/asm/tdx.h               |  96 +++++
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/tdx/Makefile          |   7 +
 tools/testing/selftests/tdx/tdx_attest_test.c | 214 +++++++++++
 12 files changed, 945 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/coco/mem.c
 create mode 100644 arch/x86/coco/tdx/attest.c
 create mode 100644 arch/x86/coco/tdx/tdx.h
 create mode 100644 arch/x86/include/uapi/asm/tdx.h
 create mode 100644 tools/testing/selftests/tdx/Makefile
 create mode 100644 tools/testing/selftests/tdx/tdx_attest_test.c

-- 
2.25.1

