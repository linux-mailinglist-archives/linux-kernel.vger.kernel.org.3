Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9C05030F0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349935AbiDOWEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 18:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356268AbiDOWEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 18:04:02 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5542D36683;
        Fri, 15 Apr 2022 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650060093; x=1681596093;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3OZlFVbHP5/ajJm2cSReWR0056FO3inBavI6Q/Qky2M=;
  b=i6vmGPRz/hmoZ7guiE+azavzH3m/0RqQxfTSGoWc8f1aATdC3Pvw83bM
   uffK7aNNK/UQToQJ8xT6PdJwC1FcUv9q189PSzb38uuc9V7kPiMtiQgWj
   epDa/OzUvjAOltxSPlQ+49kucfidKY92EMYW4WCA7YqdBpHLN6s/WYX+b
   fHYmKl7YT6KWBb1kAFzomIERJZOpXkQt4GFU/s2UKfJKFnGCE+jHD0+cO
   g52qFlfOko8zfSwY3fzx0t8+IEfhGFmH7fR0dn7Jrcxen4+4EKL3oL1Wq
   z06RlFJLbYk6h7ssUeXkYIU9SfGPy+pwnPZzk0BmdURVtqmIbSiEscUSt
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="288303527"
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="288303527"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 15:01:29 -0700
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="612949085"
Received: from smashtou-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.212.128.210])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 15:01:28 -0700
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
Subject: [PATCH v3 0/4] Add TDX Guest Attestation support
Date:   Fri, 15 Apr 2022 15:01:05 -0700
Message-Id: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
includes attestation user interface driver, user agent example, and
related hypercall support.

Patch titled "platform/x86: intel_tdx_attest: Add TDX Guest attestation
interface driver" adds the attestation driver support. This is supposed
to be reviewed by platform-x86 maintainers.

Rest of the patches are intended for x86 maintainers review.


Dependencies:
--------------

This feature has dependency on TDX guest core patch set series.

https://lore.kernel.org/all/20220218161718.67148-1-kirill.shutemov@linux.intel.com/T/

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


Kuppuswamy Sathyanarayanan (4):
  x86/tdx: Add tdx_mcall_tdreport() API support
  x86/tdx: Add tdx_hcall_get_quote() API support
  x86/tdx: Add TDX Guest event notify interrupt support
  platform/x86: intel_tdx_attest: Add TDX Guest attestation interface
    driver

 arch/x86/coco/tdx/tdx.c                       | 161 ++++++++++
 arch/x86/include/asm/hardirq.h                |   3 +
 arch/x86/include/asm/idtentry.h               |   4 +
 arch/x86/include/asm/irq_vectors.h            |   7 +-
 arch/x86/include/asm/tdx.h                    |   8 +
 arch/x86/kernel/irq.c                         |   7 +
 drivers/platform/x86/intel/Kconfig            |   2 +-
 drivers/platform/x86/intel/Makefile           |   1 +
 drivers/platform/x86/intel/tdx/Kconfig        |  13 +
 drivers/platform/x86/intel/tdx/Makefile       |   3 +
 .../platform/x86/intel/tdx/intel_tdx_attest.c | 302 ++++++++++++++++++
 include/uapi/misc/tdx.h                       |  42 +++
 12 files changed, 551 insertions(+), 2 deletions(-)
 create mode 100644 drivers/platform/x86/intel/tdx/Kconfig
 create mode 100644 drivers/platform/x86/intel/tdx/Makefile
 create mode 100644 drivers/platform/x86/intel/tdx/intel_tdx_attest.c
 create mode 100644 include/uapi/misc/tdx.h

-- 
2.25.1

