Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D774C7956
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 20:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiB1T6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 14:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiB1T6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 14:58:43 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119332B25B;
        Mon, 28 Feb 2022 11:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646078284; x=1677614284;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Eq8opGJGt5MzXdQWOsKJ4rqn4lBVtburJGTPiuqvMOw=;
  b=d4ivrvQyGLYOyeJDzxx8utWHr2+epPRkPrtMw239BBh0KHcVEVvv7K5A
   vvL80QkgPaMKXFK/PQgHud33Ti1VZ19EdQzPe1D9ZroiNhLh9ZBppLRwL
   ndLuzcldeRB7jOJSFEYEnNlA/l8OoEJZmxMQDYveqAdH8u7UzDoxsuShz
   t7a/O8lSxrLpNTQEqEKq+2Ops1Q4q5iqFvn+HMPM2kc9Bnejkg1WPV2Jb
   C3m5jK7bsQrh1Lq8aQQuNgeCRG9NKIprVgG3YRMauj/k7WCHfSfcrcsH4
   EfvkOX6X7Jth7G2NO9Xb7cW2lssxsyKR5Vs9ZDqWJcptCq8EZQLlnHzJa
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="339406627"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="339406627"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 11:58:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="685459498"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2022 11:58:02 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     corbet@lwn.net, rafael@kernel.org, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 1/2] Documentation: admin-guide: pm: Document uncore frequency scaling
Date:   Mon, 28 Feb 2022 11:57:59 -0800
Message-Id: <20220228195800.1422004-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added documentation to configure uncore frequency limits in Intel
Xeon processors.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2
As suggested removed "===" (chapter) for Introduction and added two sections
"Introduction" and "Sysfs interface".

 .../pm/intel_uncore_frequency_scaling.rst     | 59 +++++++++++++++++++
 .../admin-guide/pm/working-state.rst          |  1 +
 2 files changed, 60 insertions(+)
 create mode 100644 Documentation/admin-guide/pm/intel_uncore_frequency_scaling.rst

diff --git a/Documentation/admin-guide/pm/intel_uncore_frequency_scaling.rst b/Documentation/admin-guide/pm/intel_uncore_frequency_scaling.rst
new file mode 100644
index 000000000000..a55cf68d77df
--- /dev/null
+++ b/Documentation/admin-guide/pm/intel_uncore_frequency_scaling.rst
@@ -0,0 +1,59 @@
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
+------------
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
+Sysfs Interface
+---------------
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

