Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170384B3270
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 02:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354544AbiBLBc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 20:32:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242868AbiBLBc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 20:32:57 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E63AC56;
        Fri, 11 Feb 2022 17:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644629574; x=1676165574;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wgt9cDpHFiIgyIo4vctyylP81ktaV/VnGl0eXCmjt9E=;
  b=S7TXQRQC2Ly/96IwrthTXyFxE2GJPCExlNgurvUVKTmT7vWCnbAzNFoV
   xBY5WYiUrfn3W0RIVkcgxqaO8swPylGw3CyQrlZpDQwkjQA8jrLdMtujf
   5kA1fMKLAoUfCFvWPTP/YNmWlnt1OmJuLK6E8bI5Admv85KeDE8erL2it
   7UM7/fjjwZ2HLc5Gf5KWGUx/f/rG6mEsE5hmzIzfp5gnGrshig6XYdgCr
   F23d/SRtvhRiH9vbWlDvZhOrBSGjLIfEZMRhOnQp4RFrwYJyoC/CFZUwQ
   UWGPblGxjcWXM/m6v+t5x0UUvmG5Cvq0W06hZZnStbj4Kbm5UPX0P/LuH
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="248672543"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="248672543"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 17:32:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="483788681"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 11 Feb 2022 17:32:54 -0800
Received: from debox1-desk4.intel.com (unknown [10.212.133.77])
        by linux.intel.com (Postfix) with ESMTP id E5EDC580C25;
        Fri, 11 Feb 2022 17:32:53 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     hdegoede@redhat.com, david.e.box@linux.intel.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH V7 0/3] Intel Software Defined Silicon
Date:   Fri, 11 Feb 2022 17:32:49 -0800
Message-Id: <20220212013252.1293396-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for Intel Software Defined Silicon. These
patches are the same as patches 4-6 from this series [1]. Patches 1-3 
of that series were pulled in during the 5.17 merge window.

[1] https://lore.kernel.org/lkml/20211216023146.2361174-1-david.e.box@linux.intel.com/T/

David E. Box (3):
  platform/x86: Add Intel Software Defined Silicon driver
  tools arch x86: Add Intel SDSi provisiong tool
  selftests: sdsi: test sysfs setup

 .../ABI/testing/sysfs-driver-intel_sdsi       |  77 +++
 MAINTAINERS                                   |   7 +
 drivers/platform/x86/intel/Kconfig            |  12 +
 drivers/platform/x86/intel/Makefile           |   2 +
 drivers/platform/x86/intel/sdsi.c             | 574 ++++++++++++++++++
 drivers/platform/x86/intel/vsec.c             |  12 +-
 tools/arch/x86/intel_sdsi/Makefile            |   9 +
 tools/arch/x86/intel_sdsi/sdsi.c              | 540 ++++++++++++++++
 tools/testing/selftests/drivers/sdsi/sdsi.sh  |  18 +
 .../selftests/drivers/sdsi/sdsi_test.py       | 226 +++++++
 10 files changed, 1476 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel_sdsi
 create mode 100644 drivers/platform/x86/intel/sdsi.c
 create mode 100644 tools/arch/x86/intel_sdsi/Makefile
 create mode 100644 tools/arch/x86/intel_sdsi/sdsi.c
 create mode 100755 tools/testing/selftests/drivers/sdsi/sdsi.sh
 create mode 100644 tools/testing/selftests/drivers/sdsi/sdsi_test.py

-- 
2.25.1

