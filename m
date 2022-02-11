Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C4A4B29BA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350688AbiBKQJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:09:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350396AbiBKQJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:09:42 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A30D4F;
        Fri, 11 Feb 2022 08:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644595780; x=1676131780;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BHj/L6PmXNyjyG08UCx177u6mOVYoh+w/njRZ8MuuVs=;
  b=BIvD2pZhZf/xLwxpY3cRIh6YjU8xeZuMWm42BkF5DVNVe5hEz85CVPDu
   DVVrnzvE2t9vz78PvUPeSmQO/HLHKzOnz85TJ4NDdAYkdruYXEnaK8Sdu
   F+FMFnddP2Ta6mSLASvujQvx2qul2HXe9MKX6ssp16LbSjW9arn/tsOob
   VVbpDpSKMc/Jx8VqCI396/DXjbjTOi7f3Ky/cJJ5i+Cq3AN44SdWp60rr
   1jRvOkHpyHQPsWnOpQa8D0+nWHnG2H27OoONxDHyIbC4YSu27GwLzAvQC
   tkcxAcDvWwx5Qad5tBXz8dgMDT93hvM2PGH7LbHcUyH4YMWnM6r9QSiSi
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="249703808"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="249703808"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 08:09:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="630393695"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga002.fm.intel.com with ESMTP; 11 Feb 2022 08:09:38 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 3/6] ACPI / fan: Optimize struct acpi_fan_fif
Date:   Fri, 11 Feb 2022 08:09:29 -0800
Message-Id: <20220211160932.3221873-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220211160932.3221873-1-srinivas.pandruvada@linux.intel.com>
References: <20220211160932.3221873-1-srinivas.pandruvada@linux.intel.com>
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

We don't need u64 to store the information about _FIF. There are two
booleans (fine_grain_ctrl and low_speed_notification) and one field
step_size which can take value from 1-9. There are no internal users
of revision field. So convert all fields to u8, by not directly
extracting the _FIF info the struct. Use an intermediate buffer to
extract and assign.

This will help to do u32 math using these fields. No functional
changes are expected.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/fan.h      | 8 ++++----
 drivers/acpi/fan_core.c | 8 +++++++-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index 36c5e1a57094..6cbb4b028da0 100644
--- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -30,10 +30,10 @@ struct acpi_fan_fps {
 };
 
 struct acpi_fan_fif {
-	u64 revision;
-	u64 fine_grain_ctrl;
-	u64 step_size;
-	u64 low_speed_notification;
+	u8 revision;
+	u8 fine_grain_ctrl;
+	u8 step_size;
+	u8 low_speed_notification;
 };
 
 struct acpi_fan {
diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 9f8e68403fad..484cee0fb13e 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -211,7 +211,8 @@ static int acpi_fan_get_fif(struct acpi_device *device)
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_fan *fan = acpi_driver_data(device);
 	struct acpi_buffer format = { sizeof("NNNN"), "NNNN" };
-	struct acpi_buffer fif = { sizeof(fan->fif), &fan->fif };
+	u64 fields[4];
+	struct acpi_buffer fif = { sizeof(fields), fields };
 	union acpi_object *obj;
 	acpi_status status;
 
@@ -232,6 +233,11 @@ static int acpi_fan_get_fif(struct acpi_device *device)
 		status = -EINVAL;
 	}
 
+	fan->fif.revision = fields[0];
+	fan->fif.fine_grain_ctrl = fields[1];
+	fan->fif.step_size = fields[2];
+	fan->fif.low_speed_notification = fields[3];
+
 err:
 	kfree(obj);
 	return status;
-- 
2.34.1

