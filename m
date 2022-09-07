Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170975B0169
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 12:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiIGKOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 06:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiIGKOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 06:14:52 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B21EB1FD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 03:14:49 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2877rCJr005930;
        Wed, 7 Sep 2022 05:14:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=ot1Tl8QTYVtsDuCHedMkmJ33fXe9BMeDLR0TIH+3JGU=;
 b=V7QWk7sO38uS86TS+NlahQceUBlCHvX/8rcq6rqKmo/2fOKoClg5XwVgUwt4F4y4GLxg
 PmKM5kTNRY0Ux/iX5Jfs8B1cq8AWwrVBe4DsHiTu6UY+xvhqbwb2PfXucZc6mvBaSld3
 5yq8dUBXF3jtcS1ijJ87JloUIxA61D36noN36zHPwZPOPBuuPcD9+0ktYiANPL2AEY5D
 BMqN4JF8rwegpM8/y7TWifZQHUYqkTy1QMpnQMuXFzL5r3srm72WTpWLin54EBaaTD0m
 vMGI8JHhynhQp61vXDksSxrkRIXus8ESzBRnndRUKJvFSObmAkZK7W9ve3qL3EXrUPfS qg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3jc3bpw4sr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 05:14:15 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Wed, 7 Sep
 2022 05:14:13 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.12 via Frontend Transport; Wed, 7 Sep 2022 05:14:13 -0500
Received: from debianA11184.ad.cirrus.com (unknown [198.61.65.149])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E36A5B10;
        Wed,  7 Sep 2022 10:14:12 +0000 (UTC)
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
Subject: [PATCH 2/7] soundwire: intel_init: Separate shutdown and cleanup
Date:   Wed, 7 Sep 2022 11:13:57 +0100
Message-ID: <20220907101402.4685-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220907101402.4685-1-rf@opensource.cirrus.com>
References: <20220907101402.4685-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: vWiTgViV4BfLhGN_tzoikE6XHgslZvo6
X-Proofpoint-ORIG-GUID: vWiTgViV4BfLhGN_tzoikE6XHgslZvo6
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the freeing of context data out of sdw_intel_exit() into a new
exported function sdw_intel_remove().

This splits shutdown and cleanup into separate stages, allowing the
calling code to perform its own shutdown after the bus has shutdown but
before the context has been deleted.

The struct sdw_intel_ctx pointer is passed to the calling code by
sdw_intel_probe() and the calling code passes it back as an opaque token.
When the caller is removed it must have the opportunity to teardown its
use of this token after the bus driver has stopped but before the
context memory has been freed. It should not be doing its teardown
before calling sdw_intel_exit() because that will break any bus activity
currently in progress and the removal of child drivers.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/soundwire/intel_init.c      | 24 ++++++++++++++++++++----
 include/linux/soundwire/sdw_intel.h |  2 ++
 sound/soc/sof/intel/hda.c           |  4 +++-
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index d091513919df..078e01f67830 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -292,6 +292,13 @@ static struct sdw_intel_ctx
 	return NULL;
 }
 
+static void sdw_intel_remove_controller(struct sdw_intel_ctx *ctx)
+{
+	kfree(ctx->ids);
+	kfree(ctx->ldev);
+	kfree(ctx);
+}
+
 static int
 sdw_intel_startup_controller(struct sdw_intel_ctx *ctx)
 {
@@ -360,6 +367,18 @@ struct sdw_intel_ctx
 }
 EXPORT_SYMBOL_NS(sdw_intel_probe, SOUNDWIRE_INTEL_INIT);
 
+/**
+ * sdw_intel_remove() - SoundWire Intel remove routine
+ * @ctx: SoundWire context allocated in the probe
+ *
+ * Free all the context created by sdw_intel_probe.
+ */
+void sdw_intel_remove(struct sdw_intel_ctx *ctx)
+{
+	return sdw_intel_remove_controller(ctx);
+}
+EXPORT_SYMBOL_NS(sdw_intel_remove, SOUNDWIRE_INTEL_INIT);
+
 /**
  * sdw_intel_startup() - SoundWire Intel startup
  * @ctx: SoundWire context allocated in the probe
@@ -376,14 +395,11 @@ EXPORT_SYMBOL_NS(sdw_intel_startup, SOUNDWIRE_INTEL_INIT);
  * sdw_intel_exit() - SoundWire Intel exit
  * @ctx: SoundWire context allocated in the probe
  *
- * Delete the controller instances created and cleanup
+ * Stop the controller instances.
  */
 void sdw_intel_exit(struct sdw_intel_ctx *ctx)
 {
 	sdw_intel_cleanup(ctx);
-	kfree(ctx->ids);
-	kfree(ctx->ldev);
-	kfree(ctx);
 }
 EXPORT_SYMBOL_NS(sdw_intel_exit, SOUNDWIRE_INTEL_INIT);
 
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 2e9fd91572d4..7f7327cab712 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -282,6 +282,8 @@ void sdw_intel_process_wakeen_event(struct sdw_intel_ctx *ctx);
 struct sdw_intel_ctx *
 sdw_intel_probe(struct sdw_intel_res *res);
 
+void sdw_intel_remove(struct sdw_intel_ctx *ctx);
+
 int sdw_intel_startup(struct sdw_intel_ctx *ctx);
 
 void sdw_intel_exit(struct sdw_intel_ctx *ctx);
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 8639ea63a10d..ee67e21e739f 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -241,8 +241,10 @@ static int hda_sdw_exit(struct snd_sof_dev *sdev)
 
 	hda_sdw_int_enable(sdev, false);
 
-	if (hdev->sdw)
+	if (hdev->sdw) {
 		sdw_intel_exit(hdev->sdw);
+		sdw_intel_remove(hdev->sdw);
+	}
 	hdev->sdw = NULL;
 
 	return 0;
-- 
2.30.2

