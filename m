Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DB951204E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241727AbiD0QG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241543AbiD0QGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:06:52 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA183C9D7D;
        Wed, 27 Apr 2022 09:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651075380; x=1682611380;
  h=from:to:cc:subject:date:message-id;
  bh=VYULZm1ptnSTDWX7g9iwC8F1X12CH5Sh9VvlyVesL2U=;
  b=kLvGfw2WrVFj7l2PBxJzqfWpxLmd2WRHbQujR/vCH+7Yu4ozN5zepqO+
   PSdS/4pa8r7dfE1YQ/VnrbEzJfz5c8fb8mt/vl1NopxMRjyC0LHWdBO5c
   Y+NG2QfZBgVjjk7/029Hj4L6tziSGyhmHuhEpBqvl7wRdrWM4ZXriGeMT
   LqXJsznOzTF3PUQF72tVsEgs/zLxOKITVHxg/wUNY264/+CrcwSqShsur
   /lv1rw/hqUQxUrWJQn80G/ljk88TdTwO5xFz0GuTNU4knecF1qztJylQL
   u0YrAkPxjXdl33iA36V8agoG4VaZc5hN2knQyQZ2HNbfWaR4xeWb5btPt
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="291131603"
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="291131603"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 08:53:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="808096549"
Received: from srpawnik.iind.intel.com ([10.99.123.68])
  by fmsmga006.fm.intel.com with ESMTP; 27 Apr 2022 08:53:37 -0700
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     rafael@kernel.org, lenb@kernel.org,
        srinivas.pandruvada@linux.intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sumeet.r.pawnikar@intel.com
Subject: [PATCH] ACPI: DPTF: Add support for high frequency impedance notification
Date:   Wed, 27 Apr 2022 21:21:30 +0530
Message-Id: <20220427155130.8023-1-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add high frequency impedance notification support under DPTF.
This returns high frequency impedance value that can be obtained
from battery fuel gauge whenever there is change over a threshold.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 drivers/acpi/dptf/dptf_power.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_power.c
index dc1f52a5b3f4..2ef53ca88714 100644
--- a/drivers/acpi/dptf/dptf_power.c
+++ b/drivers/acpi/dptf/dptf_power.c
@@ -117,7 +117,7 @@ static const struct attribute_group dptf_battery_attribute_group = {
 #define POWER_STATE_CHANGED		0x81
 #define STEADY_STATE_POWER_CHANGED	0x83
 #define POWER_PROP_CHANGE_EVENT	0x84
-#define IMPEDANCED_CHNGED		0x85
+#define IMPEDANCE_CHANGED		0x85
 #define VOLTAGE_CURRENT_CHANGED	0x86
 
 static long long dptf_participant_type(acpi_handle handle)
@@ -150,6 +150,9 @@ static void dptf_power_notify(acpi_handle handle, u32 event, void *data)
 	case STEADY_STATE_POWER_CHANGED:
 		attr = "max_steady_state_power_mw";
 		break;
+	case IMPEDANCE_CHANGED:
+		attr = "high_freq_impedance_mohm";
+		break;
 	case VOLTAGE_CURRENT_CHANGED:
 		attr = "no_load_voltage_mv";
 		break;
-- 
2.17.1

