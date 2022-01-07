Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF2F487F1B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 23:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiAGWyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 17:54:49 -0500
Received: from mga18.intel.com ([134.134.136.126]:7113 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbiAGWys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 17:54:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641596088; x=1673132088;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GhKrc+4sAWUpP5n3cJ/0rirYUVFVTK+F0/y2R3Bnzoc=;
  b=eJ/5V4psNtOoXUIJpbNN0p9U/hZvsl15DSU2Kk3wKTo08EEfYY84bPYz
   JNWKsdnllgzwYA4Wve2P8t2cffnUq16IkCTsNWrJdAmbo7F4od2i7jbAB
   odJST3eOhXGP89vQDzls3zbzZNgw8P5hHC+vF/u1CJnpE8STfXdcZqrgo
   rseC7NX68gu0f89s2CseA7yeRKXmL9pzkqiJmfrHuTQwIF8xNOZC5zV81
   t4wOnPh+waZ8n415TktPI1JswFDoX7KgIsFh/8ivtBvQQwJWJ8mPGQBVx
   JvvUyog4RTpEkUhmtWSjHI5raEoIFmxZMRbdsM3bOb/CgR3quMZynwHZn
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="229762182"
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="229762182"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 14:54:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="471452453"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 14:54:47 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Smita Koralahalli Channabasappa 
        <smita.koralahallichannabasappa@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH 0/5] PPIN (Protected Processor Inventory Number) updates
Date:   Fri,  7 Jan 2022 14:54:37 -0800
Message-Id: <20220107225442.1690165-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series starts out with two changes that I expect are
uncontroversial. Later parts get progressively more "RFC".

1) Simple cleanup to merge Intel and AMD duplicated code to test for
   presence of PPIN and check whether it is enabled.

2) Long overdue update from Intel to enumerate the PPIN and PPIN_CTL
   MSRs. See the December 2021 Software Developers Manual

{RFC factor moves to medium here}

3) Code to scan machine check banks re-reads the PPIN every time banks
   are scanned (whether for a machine check, a CMCI, or just a periodic
   poll). Since PPIN never changes, this seems like unnecessary overhead.
   Read the MSR once (per CPU) and save to memory.

{RFC factor moves to high for last two parts}

4) Refactor as prep for last part.

5) Add "ppin" to /sys/devices/system/cpu/cpu*/topology/ppin

The big question for this part is whether there is a better
place to expose this value. I'm open to other suggestions.

I do think it is useful to do so. An "inventory" number
that stays hidden until there is an error that causes it to show
up in a machine check log is user hostile.

Tony Luck (5):
  x86/ras: Merge Intel and AMD ppin_init() functions
  x86/ras: X86_FEATURE_INTEL_PPIN finally has a CPUID bit
  x86/ras: Read/save PPIN MSR during initialization
  x86/sysfs: Add format parameter to macro defining "show" functions for
    proc
  x86/sysfs: Add PPIN in sysfs under cpu topology

 .../ABI/stable/sysfs-devices-system-cpu       |  4 +
 .../ABI/testing/sysfs-devices-system-cpu      |  6 ++
 arch/x86/include/asm/processor.h              |  2 +
 arch/x86/include/asm/topology.h               |  1 +
 arch/x86/kernel/cpu/amd.c                     | 30 -------
 arch/x86/kernel/cpu/common.c                  | 78 +++++++++++++++++++
 arch/x86/kernel/cpu/mce/core.c                |  7 +-
 arch/x86/kernel/cpu/mce/intel.c               | 41 ----------
 arch/x86/kernel/cpu/scattered.c               |  1 +
 drivers/base/topology.c                       | 20 +++--
 include/linux/topology.h                      |  3 +
 11 files changed, 108 insertions(+), 85 deletions(-)


base-commit: c9e6606c7fe92b50a02ce51dda82586ebdf99b48
-- 
2.31.1

