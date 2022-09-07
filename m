Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3AB5B0170
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 12:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiIGKPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 06:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiIGKPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 06:15:00 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AA7286F9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 03:14:58 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2876a3M4006643;
        Wed, 7 Sep 2022 05:14:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=gAWorbqvu9wmVkfPa/PiPrn39wNLz/dXO8GV+EOWmyE=;
 b=nazYJdeqIKSsBCYbF96Z+Tr2V+W+Uj0i2OOQsooIXcvZC1dusucu0y27Dm1rGzUQltk3
 vyCWkef6Vmag6S5Wn2lciim6GTtpVhmfzweC3KisWHYZYyKQACHEGjyDbz/rnYkZJL4z
 RWL+It21l3Hg+9NrTGY33e9HaUXEgrcyFlgPEsSjMJmpeK97IasvJMUZwARim6v1zhyg
 hkSWWJQZQ5cEKz75YK6kcccZfhHcPI0ly2T1Gcr0POPCYdUHHrHsjiZaXxjq3cRvluVJ
 vUpUF48DkJo+bQYuFW0vJKpCHp1Y0oiTkH660Kr5+tBpQgVTfUTzTAzFqXMhxzifF/Q3 3w== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3jc4b2dfns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 05:14:17 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Wed, 7 Sep
 2022 05:14:15 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.12 via Frontend Transport; Wed, 7 Sep 2022 05:14:15 -0500
Received: from debianA11184.ad.cirrus.com (unknown [198.61.65.149])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 632CBB10;
        Wed,  7 Sep 2022 10:14:15 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <lgirdwood@gmail.com>,
        <peter.ujfalusi@linux.intel.com>,
        <ranjani.sridharan@linux.intel.com>,
        <kai.vehmanen@linux.intel.com>, <daniel.baluta@nxp.com>,
        <sanyog.r.kale@intel.com>, <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>,
        <sound-open-firmware@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 6/7] soundwire: intel: Don't disable pm_runtime until children are removed
Date:   Wed, 7 Sep 2022 11:14:01 +0100
Message-ID: <20220907101402.4685-7-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220907101402.4685-1-rf@opensource.cirrus.com>
References: <20220907101402.4685-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: mmVUuAqqRom5Ky22p7pj3hn5CXe0KQZN
X-Proofpoint-ORIG-GUID: mmVUuAqqRom5Ky22p7pj3hn5CXe0KQZN
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the bus driver is removed the child drivers will be removed first.
These may need to perform bus transactions to shut down, and the device
driver core will runtime-resume the driver before calling its remove().

For this to work the pm_runtime of the bus driver must still be enabled.
So do not disable pm_runtime until the bus driver has been unregistered.

Though this could be done by powering-up the bus driver and then
disabling its pm_runtime with the bus still powered-up, there's no
need to bypass the standard device framework behaviour.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/soundwire/intel.c      | 4 +++-
 drivers/soundwire/intel_init.c | 1 -
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index d5e723a9c80b..3345310e979c 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1504,7 +1504,7 @@ static void intel_link_remove(struct auxiliary_device *auxdev)
 	struct sdw_bus *bus = &cdns->bus;
 
 	/*
-	 * Since pm_runtime is already disabled, we don't decrease
+	 * Since pm_runtime will be disabled, we don't decrease
 	 * the refcount when the clock_stop_quirk is
 	 * SDW_INTEL_CLK_STOP_NOT_ALLOWED
 	 */
@@ -1513,6 +1513,8 @@ static void intel_link_remove(struct auxiliary_device *auxdev)
 		snd_soc_unregister_component(dev);
 	}
 	sdw_bus_master_delete(bus);
+
+	pm_runtime_disable(&auxdev->dev);
 }
 
 int intel_link_process_wakeen_event(struct auxiliary_device *auxdev)
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 078e01f67830..ce26d2df088a 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -115,7 +115,6 @@ static int sdw_intel_cleanup(struct sdw_intel_ctx *ctx)
 
 		ldev = ctx->ldev[i];
 
-		pm_runtime_disable(&ldev->auxdev.dev);
 		if (!ldev->link_res.clock_stop_quirks)
 			pm_runtime_put_noidle(ldev->link_res.dev);
 
-- 
2.30.2

