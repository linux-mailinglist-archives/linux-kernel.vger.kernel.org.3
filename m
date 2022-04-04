Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A3A4F13DC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 13:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376363AbiDDLfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 07:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359830AbiDDLfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 07:35:12 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF593C73F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 04:33:14 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 234ARsRs021747;
        Mon, 4 Apr 2022 06:32:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=H63J8bNo1U5sBmx2P4okC9/PwTimoEy0MqDW58hghvE=;
 b=jSWvRvoKOAi7WQU7VmBMfGcTKFHk4avxW2Im1ogeHTSiUC/RN0Gc79PFIvWzpezFNCvO
 HUAPp0x8BSNqLsP7e08h+BU03EZzxOtKq1Dl/m/T+2ztc+ekrX3t6qNIHVLRjcWGucPh
 qM50cVOXgavEGupm68sPUEHSIK07TONSC0jLIWfk3EmtvUPI0sL/5MDbW57UtfsULyNK
 V6SEnnpD/oUXTajdkDi8NBon3LbJmw3eHl6yP3Lj7FuhdpCxeJ53m3/rXvxy3Ig3jAj7
 ZQD78iFjuIP7VhSjKwmoXmDNwAxWvi2rXJrE5hJHj5MQzBGWL1zc5kJyoYEf5IXYjkc3 Vg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3f6jwnt2sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 04 Apr 2022 06:32:57 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 12:32:55 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Mon, 4 Apr 2022 12:32:55 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.88])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9687FB10;
        Mon,  4 Apr 2022 11:32:55 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ASoC: simple-card-utils: Avoid NULL deref in asoc_simple_set_tdm()
Date:   Mon, 4 Apr 2022 12:32:52 +0100
Message-ID: <20220404113252.1152659-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -H8KNmp3Gh51xxtvDil9ArkdgQVvLksO
X-Proofpoint-GUID: -H8KNmp3Gh51xxtvDil9ArkdgQVvLksO
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't dereference simple_dai before it has been checked for NULL.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 1e974e5b82b3 ("ASoC: audio_graph_card2: Add support for variable slot widths")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 sound/soc/generic/simple-card-utils.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 8e037835bc58..f2157944247f 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -364,13 +364,15 @@ static int asoc_simple_set_tdm(struct snd_soc_dai *dai,
 				struct snd_pcm_hw_params *params)
 {
 	int sample_bits = params_width(params);
-	int slot_width = simple_dai->slot_width;
-	int slot_count = simple_dai->slots;
+	int slot_width, slot_count;
 	int i, ret;
 
 	if (!simple_dai || !simple_dai->tdm_width_map)
 		return 0;
 
+	slot_width = simple_dai->slot_width;
+	slot_count = simple_dai->slots;
+
 	if (slot_width == 0)
 		slot_width = sample_bits;
 
-- 
2.30.2

