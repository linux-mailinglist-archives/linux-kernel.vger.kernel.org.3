Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382C851C5AA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353533AbiEERGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238942AbiEERG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:06:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB8B2AE;
        Thu,  5 May 2022 10:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651770168; x=1683306168;
  h=from:to:cc:subject:date:message-id;
  bh=iBIx4dif3zA1MnfTXgjhJYQX6/T/BHqzgCVF3qHd3U0=;
  b=McnK0390HTkmOd2oeek/w5OFZspBIB6fjt0RaccWiAP9C/SOXT+8W4+l
   o+CKlkKsXma5Ed0ge/vkabPbb6pCjnVRAwJt272MLDVi+DeFITv3EC+7o
   58gSCr5EJ4Wa0Kwo8xCMR4Jfzl2ByxkcBryLyQ3msmJvynOdPDLR5INLe
   79X62nxoUzg2QUHygZpqtN1P/g/3g/C2FU6EuJHvFzEL8df49kCjJKN3l
   Xov7PgEVWV17JvaLRiBxx5tjOfPyNYGDlctuOTvs8x0Y5dwAmCjSQO82g
   XZ2/tzAfuqtBqzdagWDjxDgW3E7LRl5LPFEhKp8NkgufZ72hPjxSdscHr
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="354620448"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="354620448"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 10:02:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="585442467"
Received: from srpawnik.iind.intel.com ([10.99.123.68])
  by orsmga008.jf.intel.com with ESMTP; 05 May 2022 10:02:39 -0700
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     rafael@kernel.org, lenb@kernel.org,
        srinivas.pandruvada@linux.intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sumeet.r.pawnikar@intel.com
Subject: [PATCH v2] ACPI: DPTF: Add support for high frequency impedance notification
Date:   Thu,  5 May 2022 22:30:19 +0530
Message-Id: <20220505170019.26047-1-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add high frequency impedance notification support under DPTF.
This returns high frequency impedance value that can be obtained
from battery fuel gauge whenever there is change over a threshold.
Also, corrected the typo from IMPEDANCED_CHNGED to IMPEDANCE_CHANGED.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
v1-->v2 : Addressed review comment recevied from Srinivas Pandruvada to add
          corrected the spelling from IMPEDANCED_CHNGED to IMPEDANCE_CHANGED
          under commit message. 
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

