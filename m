Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480804A52C7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 00:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbiAaXBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 18:01:20 -0500
Received: from mga03.intel.com ([134.134.136.65]:53702 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231403AbiAaXBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 18:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643670078; x=1675206078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MdeQY8Jo7hmZqw1uzB+etOY106xNm7rWrFs0/phXfqs=;
  b=TPquwlWjBt3IwiHly56sCP37k64klr6lkm2tXePjB8VwnkBwXLpwZCs5
   Rt9nIlBpHzkCmTHdreSMYFduYBVJdSWzsA6EulpS5fH1PwaAfw4CW6YnM
   jT7TEilKj6t72EYYlRS9uKrpljAqxZ8wiVERY03WUCD8dg8FBkydzBtoO
   cJOJKgqbBdMeLJju8UpmNocLdiWuGBYvL7xo6kUPntul8XBi/f6k/P+ww
   /2b41WWNYrkD+H5n6pp1q28ChhC6t+7H05zQHMCVkaFMylVEMFJ9L7grn
   hG6V7IFbhS1CZsnKs77J126Qa36PephwrERKqof4YkGd9ZLOVxiRT512h
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="247521221"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="247521221"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 15:01:18 -0800
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="522831334"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 15:01:17 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Smita Koralahalli Channabasappa 
        <smita.koralahallichannabasappa@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 0/5] PPIN (Protected Processor Inventory Number) updates
Date:   Mon, 31 Jan 2022 15:01:06 -0800
Message-Id: <20220131230111.2004669-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220121174743.1875294-1-tony.luck@intel.com>
References: <20220121174743.1875294-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series starts out with two changes that I expect are uncontroversial.
Later parts get progressively more "RFC" - but seem to have survived
discussions on LKML.

1) Simple cleanup to merge Intel and AMD duplicated code to test for
   presence of PPIN and check whether it is enabled.

2) Long overdue update from Intel to enumerate the PPIN and PPIN_CTL
   MSRs. See the December 2021 Software Developers Manual

3) Code to scan machine check banks re-reads the PPIN every time banks
   are scanned (whether for a machine check, a CMCI, or just a periodic
   poll). Since PPIN never changes, this seems like unnecessary overhead.
   Read the MSR once (per CPU) and save to memory.

4) Refactor as prep for last part.

5) Add "ppin" to /sys/devices/system/cpu/cpu*/topology/ppin

Use case: ppin is already useful when reporting machine check
errors. Patches for new "in field scan" tests will appear soon.
If a CPU fails such a test it will be useful to provide the ppin
along with the test failure data.

Changes since V2:
----------------
1) Part 1 of V2 (adding ICELAKE_D) merged upstream, so dropped here

2) Rebased to v5.17-rc2 (to build on top of that merged patch)

3) Fixed bisection breakage reported by Boris where .msr_ppin
   structure fields were initialized two patches before the
   field was added.

4) Add Ack's from GregKH to parts 4 & 5

Tony Luck (5):
  x86/cpu: Merge Intel and AMD ppin_init() functions
  x86/cpu: X86_FEATURE_INTEL_PPIN finally has a CPUID bit
  x86/cpu: Read/save PPIN MSR during initialization
  topology/sysfs: Add format parameter to macro defining "show"
    functions for proc
  topology/sysfs: Add PPIN in sysfs under cpu topology

 .../ABI/stable/sysfs-devices-system-cpu       |  4 +
 .../ABI/testing/sysfs-devices-system-cpu      |  6 ++
 arch/x86/include/asm/processor.h              |  2 +
 arch/x86/include/asm/topology.h               |  1 +
 arch/x86/kernel/cpu/amd.c                     | 30 -------
 arch/x86/kernel/cpu/common.c                  | 79 +++++++++++++++++++
 arch/x86/kernel/cpu/mce/core.c                |  7 +-
 arch/x86/kernel/cpu/mce/intel.c               | 42 ----------
 arch/x86/kernel/cpu/scattered.c               |  1 +
 drivers/base/topology.c                       | 20 +++--
 include/linux/topology.h                      |  3 +
 11 files changed, 109 insertions(+), 86 deletions(-)


base-commit: 26291c54e111ff6ba87a164d85d4a4e134b7315c
-- 
2.31.1

