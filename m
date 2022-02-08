Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F0C4ACDB4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345566AbiBHBLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241939AbiBHAyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 19:54:47 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5332C061355;
        Mon,  7 Feb 2022 16:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644281686; x=1675817686;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wgt9cDpHFiIgyIo4vctyylP81ktaV/VnGl0eXCmjt9E=;
  b=N6VOivxfX/XYgxbXqpY2Jqo7uf/RO4yZwmbmlkjDSh8N452uJH6KDwjt
   W8HwDd3mIwNtNGH94JPPDuZg0oS2mqEmC4O7ceoon4+o2kU9Vtufs8f/6
   HQIYaO0GF6s4eH6jf0yEQnvwp4IEktn11mo4dYJJ4O7/F5WIIA2IRuqOF
   3tQq2oDl7wVGnjAC/OwMFLyL4bM+KBN5wsCzHOOY/HXqzD1aiJ/5UiU+Y
   8SFVNR0iPVHjE7858OJcuvhq3aDrJK1AkzFL3GrXA7x4Ho7ZUY7oO9Hwl
   CdMcJ8L4VGFObeEhdqwXwJMwZThRSGGJ6GRTCYMOv90jsYLguIaT5v5Wj
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="249051629"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="249051629"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 16:54:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="628713428"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 07 Feb 2022 16:54:46 -0800
Received: from debox1-desk4.intel.com (unknown [10.212.183.65])
        by linux.intel.com (Postfix) with ESMTP id 5E528580970;
        Mon,  7 Feb 2022 16:54:46 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     hdegoede@redhat.com, david.e.box@linux.intel.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH V6 0/3] Intel Software Defined Silicon
Date:   Mon,  7 Feb 2022 16:54:41 -0800
Message-Id: <20220208005444.487209-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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

