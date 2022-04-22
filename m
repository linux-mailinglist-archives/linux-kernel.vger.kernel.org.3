Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392B650C535
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiDVXlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 19:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiDVXlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:41:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9C01299F3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 16:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650670463; x=1682206463;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4LR5KpsY2NA3mRoUbLaCBj3237eryiX6z+iSFlcNzGY=;
  b=eySCcXUOsk+wbYc0JqwaZOENCTUokkTc0CIvGyl6h7Xb2onxI2AqPJgh
   tsIYdMP/PPPdV6MwydGOM5bF0lssiUkX0bZZXZqNbkDTpC//R15aDruQG
   0a879FcCVo8RK8w3reOahjIUPSG8waIdlkMTF3LXNJZwOWh97XwlKo3vD
   eSxJp9ms0CozNicRIUwIW9UzGAewUDeZ3r7+Q+o5iTtg0D5XRdt7d5Cbc
   m0zdnMUG8ZBdvk+MDz/sETb1m7y+57dryOdNmwa0XyEFSDj8FNUQdlTrV
   +LSiNZW933kTaiApN3zXi86N3z9RET5iYh7TeypuBSrcwK+54Pof632Bw
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="246719368"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="246719368"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 16:34:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="648838429"
Received: from albelfat-mobl.amr.corp.intel.com (HELO skuppusw-desk1.home) ([10.212.246.20])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 16:34:22 -0700
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
        Kai Huang <kai.huang@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] Add TDX Guest Attestation support
Date:   Fri, 22 Apr 2022 16:34:15 -0700
Message-Id: <20220422233418.1203092-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
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
    
Following patches add the attestation support to TDX guest which
includes attestation user interface driver and related hypercall support.

Any distribution enabling TDX is also expected to need attestation. So
enable it by default with TDX guest support. The compiled size is
quite small (500 bytes).

Dependencies:
--------------

This feature has dependency on TDX guest core patch set series.

https://lore.kernel.org/all/20220218161718.67148-1-kirill.shutemov@linux.intel.com/T/

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
 arch/x86/coco/tdx/attest.c         | 305 +++++++++++++++++++++++++++++
 arch/x86/coco/tdx/tdx.c            | 159 +++++++++++++++
 arch/x86/include/asm/hardirq.h     |   3 +
 arch/x86/include/asm/idtentry.h    |   4 +
 arch/x86/include/asm/irq_vectors.h |   7 +-
 arch/x86/include/asm/tdx.h         |   8 +
 arch/x86/include/uapi/asm/tdx.h    |  59 ++++++
 arch/x86/kernel/irq.c              |   7 +
 9 files changed, 552 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/coco/tdx/attest.c
 create mode 100644 arch/x86/include/uapi/asm/tdx.h

-- 
2.25.1

