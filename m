Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9697A5B0177
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 12:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiIGKQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 06:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiIGKPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 06:15:16 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AF549B7A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 03:15:11 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2877rCJu005930;
        Wed, 7 Sep 2022 05:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=B6nn0DMduRe/b0wPBE0kJZuYuyehQzIVtGN50L5g4Mk=;
 b=Ql0LJ86b71n/DDop36XiXMnZ657dfSJcMMDykbBtKO0u/RVnZs9tq+J+CFnZIlR5Imdw
 gjZweqYzLO8UpLYc83m+w41RagXRZ4jnbDRmpQMD0IKZfB2s8UIgzxWK/orMZuEUzXMx
 C1Ok+wVsbzHvLLaXmGe/EKCPHMZW2NCR3t1NanOCFAiyonWIoYcp/coeXtLqq/zEjWOP
 UDgws0DkMcT5B7GYl9FfO0Kba1liYYZ7IHPlW56ePfxFjxGaxyzN8kDPIT1hi1rC/4LF
 SN2+UQ0c2G6847OsHT5Fvv6utpi1RyUaZyfeb9d5ReJEZn1bU9YXcndkHb0Wc/EjuBHl 5Q== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3jc3bpw4sr-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 05:14:17 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Wed, 7 Sep
 2022 05:14:15 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.12 via Frontend Transport; Wed, 7 Sep 2022 05:14:15 -0500
Received: from debianA11184.ad.cirrus.com (unknown [198.61.65.149])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C3086B06;
        Wed,  7 Sep 2022 10:14:14 +0000 (UTC)
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
Subject: [PATCH 5/7] soundwire: intel: Don't disable interrupt until children are removed
Date:   Wed, 7 Sep 2022 11:14:00 +0100
Message-ID: <20220907101402.4685-6-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220907101402.4685-1-rf@opensource.cirrus.com>
References: <20220907101402.4685-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: BS6SyyWSBXeYEESWKkhNzUK3mS-9E41G
X-Proofpoint-ORIG-GUID: BS6SyyWSBXeYEESWKkhNzUK3mS-9E41G
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cadence_master code needs the interrupt to complete message transfers.
When the bus driver is being removed child drivers are removed, and their
remove actions might need bus transactions.

Use the sdw_master_ops.remove callback to disable the interrupt handling
only after the child drivers have been removed.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/soundwire/intel.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 01be62fa6c83..d5e723a9c80b 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1255,6 +1255,13 @@ static int intel_prop_read(struct sdw_bus *bus)
 	return 0;
 }
 
+static void intel_bus_remove(struct sdw_bus *bus)
+{
+	struct sdw_cdns *cdns = bus_to_cdns(bus);
+
+	sdw_cdns_enable_interrupt(cdns, false);
+}
+
 static struct sdw_master_ops sdw_intel_ops = {
 	.read_prop = sdw_master_read_prop,
 	.override_adr = sdw_dmi_override_adr,
@@ -1264,6 +1271,7 @@ static struct sdw_master_ops sdw_intel_ops = {
 	.set_bus_conf = cdns_bus_conf,
 	.pre_bank_switch = intel_pre_bank_switch,
 	.post_bank_switch = intel_post_bank_switch,
+	.remove = intel_bus_remove,
 };
 
 static int intel_init(struct sdw_intel *sdw)
@@ -1502,7 +1510,6 @@ static void intel_link_remove(struct auxiliary_device *auxdev)
 	 */
 	if (!bus->prop.hw_disabled) {
 		intel_debugfs_exit(sdw);
-		sdw_cdns_enable_interrupt(cdns, false);
 		snd_soc_unregister_component(dev);
 	}
 	sdw_bus_master_delete(bus);
-- 
2.30.2

