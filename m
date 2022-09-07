Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6E75B016A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 12:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiIGKO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 06:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiIGKOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 06:14:52 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9F3AE5B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 03:14:49 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2877rCJs005930;
        Wed, 7 Sep 2022 05:14:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Gp/uTF8GDKPfyMeYGc1Hdj6y6PqGS+VgIG+UYR8B8FI=;
 b=YVgoR3D7kVWQjD+AOI9dk/3aSCFFDAFS0d6X4Tk5P+vVREuYDnUmmcMXf32moX0Rcxup
 SDYTXKsG4tC85yuYO565v4dfNc2C4j3NIJjEUN03fNmm43NZs73jVqWkXArm1BOlIPkE
 1I0ktAm8QzJj47Ft4qSWIv1TqL6DHQZQ/3hTwmhyco1K91JezrAqDl0ax0jBZg9jfwT2
 ms/02XIiPRKmXbHJ9qIm9H+b+/qfwH5IS0Q0PLUtJkQTwUBeKC6/uG+COIaR4fNxIzgn
 b4e3eaa1Z4os/BQcKNy8olSmKBrFq04+Xtryec42I1u4zNngVCbESOMPpGWE5o26JQ0d 9w== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3jc3bpw4sr-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 05:14:15 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Wed, 7 Sep
 2022 05:14:14 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.12 via Frontend Transport; Wed, 7 Sep 2022 05:14:14 -0500
Received: from debianA11184.ad.cirrus.com (unknown [198.61.65.149])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 88D7E7C;
        Wed,  7 Sep 2022 10:14:13 +0000 (UTC)
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
Subject: [PATCH 3/7] ASoC: SOF: Intel: Don't disable Soundwire interrupt before the bus has shut down
Date:   Wed, 7 Sep 2022 11:13:58 +0100
Message-ID: <20220907101402.4685-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220907101402.4685-1-rf@opensource.cirrus.com>
References: <20220907101402.4685-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Hg_XoDk6Sv5Mpmkzh2SnQIEICaF7KUDS
X-Proofpoint-ORIG-GUID: Hg_XoDk6Sv5Mpmkzh2SnQIEICaF7KUDS
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until the Soundwire child drivers have been removed and the bus driver has
shut down any of them can still be actively doing something. And any of
them may need bus transactions to shut down their hardware. So the
Soundwire interrupt must not be disabled until the point that nothing can
be using it.

Normally it is up to the driver using the interrupt to ensure that it
doesn't break if there is an interrupt while it is shutting down. However,
the design of the Intel drivers means that the Soundwire bus driver doesn't
have control of its own interrupt - instead its interrupt handler is called
externally by the code in hda.c. Therefore hda.c must shutdown the bus
before disabling the interrupt and freeing the context memory.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/sof/intel/hda.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index ee67e21e739f..34f5de052bc0 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -236,17 +236,25 @@ int hda_sdw_startup(struct snd_sof_dev *sdev)
 static int hda_sdw_exit(struct snd_sof_dev *sdev)
 {
 	struct sof_intel_hda_dev *hdev;
+	void *tmp_sdw;
 
 	hdev = sdev->pdata->hw_pdata;
-
-	hda_sdw_int_enable(sdev, false);
-
-	if (hdev->sdw) {
+	if (hdev->sdw)
 		sdw_intel_exit(hdev->sdw);
-		sdw_intel_remove(hdev->sdw);
-	}
+
+	/* The bus has now stopped so the interrupt can be disabled */
+	hda_sdw_int_enable(sdev, false);
+
+	/* Wait for last run of irq handler to complete */
+	synchronize_irq(sdev->ipc_irq);
+
+	/* Stop using the pointer */
+	tmp_sdw = hdev->sdw;
 	hdev->sdw = NULL;
 
+	if (tmp_sdw)
+		sdw_intel_remove(tmp_sdw);
+
 	return 0;
 }
 
-- 
2.30.2

