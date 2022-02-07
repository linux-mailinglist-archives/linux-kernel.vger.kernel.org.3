Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C464AC949
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 20:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbiBGTPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 14:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236838AbiBGTNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:13:11 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12E9C0401DA;
        Mon,  7 Feb 2022 11:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644261189; x=1675797189;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XSZpboCIkbXi1GE1bciC1P+mAUTpL2x/5a3sVLbpD0E=;
  b=LtO8CcM02fpLBuKxjoRgN/CY46ho8CHSseMbaqiNGavjzK+ytNPJ1BC1
   HPeRD/yqLB7IeapGF/dSyORfDI5WILz+Za6TEEVVMQeWDLb7EruSG/1fx
   aJFTdN6V+ay5SGFT0c3++j8Pv+jEM17qgX6gs3uRGGpRTEJZ7rLtIVQIl
   PrzAwdi+f7UErgiXGYfYcvXWMnIE73WZBzTSO0tATsXNcyc9TE/ZWLi7C
   NYJVHlCCbGY4khelRDODftuypWt89iNieIRZOfujmNLOPAm726PwSK2bF
   TvtDiwYg6+JPSwl212jF+bpiG+EdeviZ4IBxKB+ViK56GhHXd2jSbtZxH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="232354585"
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="232354585"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 11:13:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="567586162"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga001.jf.intel.com with ESMTP; 07 Feb 2022 11:13:09 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     corbet@lwn.net, rafael@kernel.org, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] Documentation: admin-guide: pm: Document uncore frequency scaling
Date:   Mon,  7 Feb 2022 11:13:07 -0800
Message-Id: <20220207191307.2903314-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added documentation to configure uncore frequency limits in Intel
Xeon processors.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
Resent by adding linux-pm@vger.kernel.org

 .../pm/intel_uncore_frequency_scaling.rst     | 56 +++++++++++++++++++
 .../admin-guide/pm/working-state.rst          |  1 +
 2 files changed, 57 insertions(+)
 create mode 100644 Documentation/admin-guide/pm/intel_uncore_frequency_scaling.rst

diff --git a/Documentation/admin-guide/pm/intel_uncore_frequency_scaling.rst b/Documentation/admin-guide/pm/intel_uncore_frequency_scaling.rst
new file mode 100644
index 000000000000..b3519560594b
--- /dev/null
+++ b/Documentation/admin-guide/pm/intel_uncore_frequency_scaling.rst
@@ -0,0 +1,56 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+==============================
+Intel Uncore Frequency Scaling
+==============================
+
+:Copyright: |copy| 2022 Intel Corporation
+
+:Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
+
+Introduction
+===========================================
+
+Uncore can consume significant amount of power in Intel's Xeon servers based
+on the workload characteristics. To optimize total power and improve overall
+performance, SoC has an internal algorithm for scaling uncore frequency. These
+algorithms monitor workload usage of uncore and set a desirable frequency.
+
+It is possible that users have different expectations of uncore performance and
+want to have control over it. The objective is similar to set scaling min/max
+frequencies using cpufreq sysfs to improve compute performance. Users may have
+some latency sensitive workload where they do not want any change to uncore
+frequency. Also, users may have workload which requires different core and
+uncore performance at distinct phases and they want to use both cpufreq and
+uncore scaling interface to distribute power and improve overall performance.
+
+To control uncore frequency, a sysfs interface is provided in the directory:
+`/sys/devices/system/cpu/intel_uncore_frequency/`.
+
+There is one directory for each package and die combination as the scope of
+uncore scaling control is per die in multiple dies/package SoC or per
+package for single die per package SoC. The name represents the
+scope of control. For example: 'package_00_die_00' is for package id 0 and
+die 0 in it.
+
+Each package_*_die_* contains following attributes:
+
+``initial_max_freq_khz``
+	Out of reset, this attribute represent the maximum possible frequency.
+	This is a read only attribute. If users adjust max_freq_khz,
+	they can always go back to maximum using the value from this attribute.
+
+``initial_min_freq_khz``
+	Out of reset, this attribute represent the minimum possible frequency.
+	This is a read only attribute. If users adjust min_freq_khz,
+	they can always go back to minimum using the value from this attribute.
+
+``max_freq_khz``
+	This attribute is used to set the maximum uncore frequency.
+
+``min_freq_khz``
+	This attribute is used to set the minimum uncore frequency.
+
+``current_freq_khz``
+	This attribute is used to get the current uncore frequency.
diff --git a/Documentation/admin-guide/pm/working-state.rst b/Documentation/admin-guide/pm/working-state.rst
index 5d2757e2de65..ee45887811ff 100644
--- a/Documentation/admin-guide/pm/working-state.rst
+++ b/Documentation/admin-guide/pm/working-state.rst
@@ -15,3 +15,4 @@ Working-State Power Management
    cpufreq_drivers
    intel_epb
    intel-speed-select
+   intel_uncore_frequency_scaling
-- 
2.34.1

