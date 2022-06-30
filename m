Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F407956237C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 21:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbiF3TvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 15:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235972AbiF3TvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 15:51:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E1F443E9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 12:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656618663; x=1688154663;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=58ItSmlRaP9vrafRX6JjnPGuM1FrCchcSlHpt/K27uo=;
  b=QNdBX0BY8gZZP+c9ethmAfOrNYzIH9VDzLywMaQST0hfRMh4E7rGUHAP
   ZJ5ohMkewVYtD1jl4j31pvz9pxwKlZ+5m2oJl+TcCwc3SUGsn3p7UDo3S
   Q0aYuP+yJmHXtoxcJ47sRB3kQ8dy/RAixitXLmUpHnS+Q9Zi9t630Zd+C
   9rf1UZ43seXNmrLssIONch5BTo0VAXR35QOM51iA/EU8KXOdSQArMhCdu
   M6UsPANYGlMHSYzEU9Y0n3vLzHwkGCN26EPYHd0tDIkHlHVVrywD5W/9F
   diEL00wPRyxFtK5/FGAnIbQBbZyujbCTogW7vpC/KlScElQMs4oeoiJ4t
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="346440317"
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="346440317"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 12:51:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="623906483"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 30 Jun 2022 12:50:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E19CD11E; Thu, 30 Jun 2022 22:51:05 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Will Deacon <will@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v1 1/1] drivers/perf: thunderx2_pmu: Replace open coded acpi_match_device()
Date:   Thu, 30 Jun 2022 22:51:03 +0300
Message-Id: <20220630195103.4088-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

Replace open coded acpi_match_device() in get_tx2_pmu_type().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/perf/thunderx2_pmu.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index 1edb9c03704f..b5a70cc42495 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -504,24 +504,19 @@ static void tx2_uncore_event_update(struct perf_event *event)
 
 static enum tx2_uncore_type get_tx2_pmu_type(struct acpi_device *adev)
 {
-	int i = 0;
-	struct acpi_tx2_pmu_device {
-		__u8 id[ACPI_ID_LEN];
-		enum tx2_uncore_type type;
-	} devices[] = {
+	struct acpi_device_id devices[] = {
 		{"CAV901D", PMU_TYPE_L3C},
 		{"CAV901F", PMU_TYPE_DMC},
 		{"CAV901E", PMU_TYPE_CCPI2},
-		{"", PMU_TYPE_INVALID}
+		{}
 	};
+	const struct acpi_device_id *id;
 
-	while (devices[i].type != PMU_TYPE_INVALID) {
-		if (!strcmp(acpi_device_hid(adev), devices[i].id))
-			break;
-		i++;
-	}
+	id = acpi_match_device(adev, devices);
+	if (!id)
+		return PMU_TYPE_INVALID;
 
-	return devices[i].type;
+	return (enum tx2_uncore_type)id->driver_data;
 }
 
 static bool tx2_uncore_validate_event(struct pmu *pmu,
-- 
2.35.1

