Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3E348F2FA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 00:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiANXYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 18:24:49 -0500
Received: from mga01.intel.com ([192.55.52.88]:33182 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229865AbiANXYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 18:24:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642202687; x=1673738687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+57jmJGipD0NVrM4oIQsgoZMVZ6PC/LhLcEpTUfLqew=;
  b=l6i8JyKTlrDsARADBeg5CnYN0O6FB06ZtJ311YR3a7e3curczwZ9+jnL
   uRAqV84TmAMpP9Tl4RrretvCKzzK51WYZFaTtAUTCOcAVMU1xpD6ClYI9
   q49H442AXHhYtW7QXPIYFxhH5xDr8yG6lrNJCwgzuWtpsqwfXYAe/7XJ5
   72dQCmTS4XR2uZwTBVi+cJ39oj/bmA4rn9FksmAEuhjXWRNKbVWsHTjs7
   I0AAW1oiSzy4oqUuYy3sqM0j96acChG3tokmrt38nhF4FXE2XLIDCSOO0
   FtfeNILwUb6rOYemAU5/bo+JtLEvuiwLqGM/U++iAR7t9MOeS4afyh/NB
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="268718349"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="268718349"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 15:24:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="491682054"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga002.jf.intel.com with ESMTP; 14 Jan 2022 15:24:46 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, lenb@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, amitk@kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/3] ACPI: DPTF: Support Raptor Lake
Date:   Fri, 14 Jan 2022 15:24:33 -0800
Message-Id: <20220114232435.448340-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220114232435.448340-1-srinivas.pandruvada@linux.intel.com>
References: <20220114232435.448340-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Raptor Lake ACPI IDs for DPTF devices.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/dptf/dptf_pch_fivr.c   | 1 +
 drivers/acpi/dptf/dptf_power.c      | 2 ++
 drivers/acpi/dptf/int340x_thermal.c | 6 ++++++
 drivers/acpi/fan.h                  | 1 +
 4 files changed, 10 insertions(+)

diff --git a/drivers/acpi/dptf/dptf_pch_fivr.c b/drivers/acpi/dptf/dptf_pch_fivr.c
index e7ab0fc90db9..c0da24c9f8c3 100644
--- a/drivers/acpi/dptf/dptf_pch_fivr.c
+++ b/drivers/acpi/dptf/dptf_pch_fivr.c
@@ -151,6 +151,7 @@ static int pch_fivr_remove(struct platform_device *pdev)
 static const struct acpi_device_id pch_fivr_device_ids[] = {
 	{"INTC1045", 0},
 	{"INTC1049", 0},
+	{"INTC10A3", 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, pch_fivr_device_ids);
diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_power.c
index a24d5d7aa117..dc1f52a5b3f4 100644
--- a/drivers/acpi/dptf/dptf_power.c
+++ b/drivers/acpi/dptf/dptf_power.c
@@ -231,6 +231,8 @@ static const struct acpi_device_id int3407_device_ids[] = {
 	{"INTC1050", 0},
 	{"INTC1060", 0},
 	{"INTC1061", 0},
+	{"INTC10A4", 0},
+	{"INTC10A5", 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, int3407_device_ids);
diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
index da5d5f0be2f2..42a556346548 100644
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -37,6 +37,12 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
 	{"INTC1050"},
 	{"INTC1060"},
 	{"INTC1061"},
+	{"INTC10A0"},
+	{"INTC10A1"},
+	{"INTC10A2"},
+	{"INTC10A3"},
+	{"INTC10A4"},
+	{"INTC10A5"},
 	{""},
 };
 
diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index dc9a6efa514b..dd9bb8ca2244 100644
--- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -10,4 +10,5 @@
 	{"INT3404", }, /* Fan */ \
 	{"INTC1044", }, /* Fan for Tiger Lake generation */ \
 	{"INTC1048", }, /* Fan for Alder Lake generation */ \
+	{"INTC10A2", }, /* Fan for Raptor Lake generation */ \
 	{"PNP0C0B", } /* Generic ACPI fan */
-- 
2.34.1

