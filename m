Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8E1552F94
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 12:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348338AbiFUKVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 06:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344922AbiFUKUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:20:53 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0891B28720
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 03:20:53 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25L7wQ91011194;
        Tue, 21 Jun 2022 05:20:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=2mwJv9rwDuzZlDeF4gMWLOnhM+pmeWicS1501ixazNo=;
 b=bN+0DqAiRkRtSrCCmKIBrG4hUMuipP+Os6qXUIdc99aK0iP0Nqm/BLOMpAscP+V2e0cD
 hoWMC7VCiQL8sce2s14P3LYEPhvzWPhaaz+427PZZ0Vi6EbCd2kWsJye3wZNJq8IYAth
 5/gh7xVeU9L1a0c9h81gIyR7J1xkxMtPkv2V5Ucblq9GfNZcN7ur/VWvIfdRwZ4813BT
 DL4VvVF+NJtwefE5jo9+Q1GLcdBwC1CdRtWBwbI4SBiA7eg45rfvS/eQC6iv2fucTaa4
 jHg0hMhbh4mlwYXZbGcJKTuZH4MjbqxlxyW6DP1nYNGQ8gvE3kq6YLxPAqRCPKlapq3g 3w== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3gsc41bcxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Jun 2022 05:20:44 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 21 Jun
 2022 11:20:42 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 21 Jun 2022 11:20:42 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id F30CB468;
        Tue, 21 Jun 2022 10:20:41 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <james.schulman@cirrus.com>, <david.rhodes@cirrus.com>,
        <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] ASoC: wm_adsp: Fix event for preloader
Date:   Tue, 21 Jun 2022 11:20:38 +0100
Message-ID: <20220621102041.1713504-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: yVUhF6T4VUVGuObReVv-rz9jW_aiEL8P
X-Proofpoint-ORIG-GUID: yVUhF6T4VUVGuObReVv-rz9jW_aiEL8P
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The preloader controls on ADSP should return a value of 1 if the
preloader value was changed, update to correct this.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 6d7fd88243aa8..a7784ac15dde6 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -997,7 +997,7 @@ int wm_adsp2_preloader_put(struct snd_kcontrol *kcontrol,
 		snd_soc_dapm_sync(dapm);
 	}
 
-	return 0;
+	return 1;
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_preloader_put);
 
-- 
2.30.2

