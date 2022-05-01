Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FEC516723
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 20:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356147AbiEASjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 14:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356389AbiEASi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 14:38:56 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7644215FEA
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 11:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651430129; x=1682966129;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H6qTrpoeBe0F3BTHmwAkt662uH+V9D5J4JW34muG/rA=;
  b=iYc9TKF40ejBsr3W1UbHgomOZYLeQz48PeMq/XmHIkFo1knP8YWYevgN
   Le2AWEpoRRhIORIxiQxubq9S21leFAizZd20iMd69B9FyDCgauXFazxgy
   yGKov20Tjqv0juOd0KF4SjiwSgD4uYfg1qF2/4dbhqwT6j/3gaXF7w1qe
   0Lo1guZaxkxnIzDVyqJO6bWNXeePsWdb9jJMuBVbaTPFuY/eoKx/qsumA
   lrMl/wM13H9QBnmCSJAsLiXDgEG85q0A3tliZzB8M0Rn/CFBKjqgeQr93
   M/nI68HwUkXm7i0h/WJelEPHnvRef/qxsoF33dTia9dhMM1+DsxK3t7yj
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="247598667"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="247598667"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 11:35:27 -0700
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="515731251"
Received: from pghaisax-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.home) ([10.209.85.28])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 11:35:26 -0700
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
Subject: [PATCH v5 0/3] Add TDX Guest Attestation support
Date:   Sun,  1 May 2022 11:34:57 -0700
Message-Id: <20220501183500.2242828-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
    
Following patches add the attestation support to TDX guest which
includes attestation user interface driver and related hypercall support.

Any distribution enabling TDX is also expected to need attestation. So
enable it by default with TDX guest support. The compiled size is
quite small (500 bytes).

Dependencies:
--------------

This feature has dependency on TDX guest core patch set series.

https://lore.kernel.org/all/20220218161718.67148-1-kirill.shutemov@linux.intel.com/T/

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

Kuppuswamy Sathyanarayanan (3):
  x86/tdx: Add TDX Guest attestation interface driver
  x86/tdx: Add TDX Guest event notify interrupt support
  x86/tdx: Add Quote generation support

 arch/x86/coco/tdx/Makefile         |   2 +-
 arch/x86/coco/tdx/attest.c         | 273 +++++++++++++++++++++++++++++
 arch/x86/coco/tdx/tdx.c            |  73 ++++++++
 arch/x86/include/asm/hardirq.h     |   3 +
 arch/x86/include/asm/idtentry.h    |   4 +
 arch/x86/include/asm/irq_vectors.h |   7 +-
 arch/x86/include/asm/tdx.h         |   4 +
 arch/x86/include/uapi/asm/tdx.h    |  76 ++++++++
 arch/x86/kernel/irq.c              |   7 +
 9 files changed, 447 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/coco/tdx/attest.c
 create mode 100644 arch/x86/include/uapi/asm/tdx.h

-- 
2.25.1

