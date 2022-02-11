Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFD34B29CF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350581AbiBKQJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:09:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240087AbiBKQJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:09:40 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C854E1B5;
        Fri, 11 Feb 2022 08:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644595778; x=1676131778;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TKUUvWtokGbccNbJek5bykAjRoRXtkIpB78T8IUzGac=;
  b=CZ0+Dg5MZS8IH9ZFWpqTVb8sbcH3UgB+cGakfgC/05zRSMD19EZ93wQt
   0bqmsnjVCjxpwJ9w0EsXL3gpuXRUXi7OYQSDKyFzVQIK/TwyuRlC/AmdR
   /UdhPCLTrNhUK//lNGvK19Zvq268MO9M2XakeoxeM1qP24drhiHMiaUbe
   V1lCbvJzn5vzbk7mv2l+D8UQDmKyMurrz/ZX4o4UJSnZaJuNq7JBPDTyV
   LcpXuYI9Rkez2EETBzccY7esMFeLrsKyDG2fydIhusmKt1WM3ZU21nmvT
   ZwNzFoZr5APz88YlBdlqSFcEZ/qRRq0hwnfZAkdk7+UohNqdNztnfFsYK
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="249703803"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="249703803"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 08:09:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="630393682"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga002.fm.intel.com with ESMTP; 11 Feb 2022 08:09:37 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 0/6] ACPI / fan: Add fine grain control
Date:   Fri, 11 Feb 2022 08:09:26 -0800
Message-Id: <20220211160932.3221873-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
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

This series of changes adds fine grain control for fans. First 3 patches
are clean up and preparation patches.

v4
Addressed review comments:
- Creation of attributes to separate file
- Handle error in get/set callbacks
- Fix commit description for current state
- Remove casting to int by changing fif struct
- Change fan_get_fps() to acpi_fan_get_fst()
- Fallback to old method for invalid control value
- Remove logic to take reminder to adjust to 100
- Add else if for step size sanity checks

v3
Added fine_grain_control attribute.
v2-update
Change log is missed for v2.
v2
Fix for build issue as reported by Reported-by: kernel test robot <lkp@intel.com>

Srinivas Pandruvada (6):
  ACPI / fan: Fix error reporting to user space
  ACPI / fan: Separate file for attributes creation
  ACPI / fan: Optimize struct acpi_fan_fif
  ACPI / fan: Properly handle fine grain control
  ACPI / fan: Add additional attributes for fine grain control
  Documentation/admin-guide/acpi: Add documentation for fine grain
    control

 .../acpi/fan_performance_states.rst           |  28 +++
 drivers/acpi/Makefile                         |   3 +
 drivers/acpi/fan.h                            |  44 ++++
 drivers/acpi/fan_attr.c                       | 137 ++++++++++++
 drivers/acpi/{fan.c => fan_core.c}            | 204 ++++++++----------
 5 files changed, 298 insertions(+), 118 deletions(-)
 create mode 100644 drivers/acpi/fan_attr.c
 rename drivers/acpi/{fan.c => fan_core.c} (75%)

-- 
2.34.1

