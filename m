Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB908513893
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349283AbiD1PmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbiD1PmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:42:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C2BB36A8;
        Thu, 28 Apr 2022 08:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651160340; x=1682696340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KNI6TywIBrtMzHC0wppg8qEsX62tIPxK1F8eBPhI0zQ=;
  b=dU1rfjwBhowKSTxgfK2GGMcLq1DR672uXCi1OWcuaovgUhshA1FnNOis
   Rh+/WqMoD4REES5oIsTezc7RHKYhPebGI+3GNG0h7kxJ78dOwBfX3e4D9
   mLeZbyB8VX7wyQ/M3wyMnvPuj9K1wpkNLbvv8OMKpXVa4dhbsUfCZOl8N
   qxjrPV8cMDlZoxVofL9D1FbyhxRweIbd8gBpi0qgATyuwxdJs44m+/qUe
   TvGRLe6X82j4iKhY2Uxr3YvnNDNGmVoyskBRw+Wa+9GCA+EVSXgDUJf1b
   nRroj9FmVBItAsY02gjlVuryNcShvXVvAoINxwA47iABm/OxwE1WeQPTO
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="329271639"
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="329271639"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 08:39:00 -0700
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="559734311"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 08:38:59 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com, rostedt@goodmis.org,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com
Subject: [PATCH v5 00/10] Introduce In Field Scan driver
Date:   Thu, 28 Apr 2022 08:38:39 -0700
Message-Id: <20220428153849.295779-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422200219.2843823-1-tony.luck@intel.com>
References: <20220422200219.2843823-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hopefully this is close enough to done to begin discussion on which
maintainer tree will take this series.

Choices:
1) Hans/Mark take it into the platform-drivers tree
   Needs an Ack from x86 maintainers on parts 1 & 2
2) X86 maintainers take it into TIP
   Needs Ack from Hans/Mark on parts 2-10

TL;DR this driver loads scan test files that can check whether silicon
in a CPU core is still running correctly. It is expected that these tests
would be run several times per day to catch problems as silicon ages.

Changes since v4:

Greg Kroah-Hartman
------------------
 "Cute way to do this, but I don't see you ever have any more devices
 added to this list in this series."

 Removed the enum, arrays, loops, and count of test types discovered.
 Now just check for enumeration of the single test type that is being
 deployed on Sapphire Rapids.


Jithu Joseph (7):
  x86/microcode/intel: Expose collect_cpu_info_early() for IFS
  platform/x86/intel/ifs: Read IFS firmware image
  platform/x86/intel/ifs: Check IFS Image sanity
  platform/x86/intel/ifs: Authenticate and copy to secured memory
  platform/x86/intel/ifs: Add scan test support
  platform/x86/intel/ifs: Add IFS sysfs interface
  platform/x86/intel/ifs: add ABI documentation for IFS

Tony Luck (3):
  x86/msr-index: Define INTEGRITY_CAPABILITIES MSR
  platform/x86/intel/ifs: Add stub driver for In-Field Scan
  trace: platform/x86/intel/ifs: Add trace point to track Intel IFS
    operations

 .../ABI/testing/sysfs-platform-intel-ifs      |  39 ++
 MAINTAINERS                                   |   8 +
 arch/x86/include/asm/cpu.h                    |  18 +
 arch/x86/include/asm/msr-index.h              |   7 +
 arch/x86/kernel/cpu/intel.c                   |  32 ++
 arch/x86/kernel/cpu/microcode/intel.c         |  59 +---
 drivers/platform/x86/intel/Kconfig            |   1 +
 drivers/platform/x86/intel/Makefile           |   1 +
 drivers/platform/x86/intel/ifs/Kconfig        |  13 +
 drivers/platform/x86/intel/ifs/Makefile       |   3 +
 drivers/platform/x86/intel/ifs/core.c         |  80 +++++
 drivers/platform/x86/intel/ifs/ifs.h          | 123 +++++++
 drivers/platform/x86/intel/ifs/load.c         | 262 ++++++++++++++
 drivers/platform/x86/intel/ifs/runtest.c      | 332 ++++++++++++++++++
 drivers/platform/x86/intel/ifs/sysfs.c        | 147 ++++++++
 include/trace/events/intel_ifs.h              |  38 ++
 16 files changed, 1111 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-intel-ifs
 create mode 100644 drivers/platform/x86/intel/ifs/Kconfig
 create mode 100644 drivers/platform/x86/intel/ifs/Makefile
 create mode 100644 drivers/platform/x86/intel/ifs/core.c
 create mode 100644 drivers/platform/x86/intel/ifs/ifs.h
 create mode 100644 drivers/platform/x86/intel/ifs/load.c
 create mode 100644 drivers/platform/x86/intel/ifs/runtest.c
 create mode 100644 drivers/platform/x86/intel/ifs/sysfs.c
 create mode 100644 include/trace/events/intel_ifs.h


base-commit: af2d861d4cd2a4da5137f795ee3509e6f944a25b
-- 
2.35.1

