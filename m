Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086D251A13E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350852AbiEDNtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350821AbiEDNtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:49:08 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5D16168
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 06:45:32 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2446Xnu6007611;
        Wed, 4 May 2022 08:45:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=MN5TT9CQ8+yVmb53jcb5CFCZCHuh7HK/uEBXED7+fWk=;
 b=RJsc4oRl+DUWdor/CxpIqFEOP/a/Q9f9sv0WL7opgGvqMgNowrlQZMpfHessAeLFW0Yl
 LUGWE3g+/IT2f+3+aIuZHTPHvEmj7vihBTk9aDelwIIOqQUOcuqB65xRdRXsrQYt2vi3
 5a/3t92BLmZlZaAmXO3/bKa60LFi+gd7N433k8ppA83tK8kehMiT+QKHunHesWtr+vAC
 Gqwo5WTUGTZNzuUOCAeRlzCvDCwoc4UNiNGDzHbgFQzadX339DMIXyQgr68t4p7Dqvuh
 MJMISOsaoa4Svw17YLeispmfi1tO7CUpdbG5vCYwEB4ciPszckmJDfeJ/mXa6MMcTqwI ew== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3fs2h2d0m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 04 May 2022 08:45:19 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 4 May
 2022 14:45:17 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 4 May 2022 14:45:17 +0100
Received: from debianA11184.ad.cirrus.com (debianA11184.ad.cirrus.com [198.90.251.83])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9770E459;
        Wed,  4 May 2022 13:45:17 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs35l45: Enable BOOST
Date:   Wed, 4 May 2022 14:44:58 +0100
Message-ID: <20220504134458.283780-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8C-RSCtKC9PVrPRpfHsO7bFrFnx844U2
X-Proofpoint-GUID: 8C-RSCtKC9PVrPRpfHsO7bFrFnx844U2
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not disable the boost converter during probe. The silicon
contains functional default tunings so the boost converter can
be left at the chip default enabled state.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l45.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/cs35l45.c b/sound/soc/codecs/cs35l45.c
index 86daa2574388..2367c1a4c10e 100644
--- a/sound/soc/codecs/cs35l45.c
+++ b/sound/soc/codecs/cs35l45.c
@@ -587,10 +587,6 @@ static int cs35l45_initialize(struct cs35l45_private *cs35l45)
 		return ret;
 	}
 
-	/* Default to boost bypass */
-	regmap_update_bits(cs35l45->regmap, CS35L45_BLOCK_ENABLES, CS35L45_BST_EN_MASK,
-			   CS35L45_BST_DISABLE_FET_ON << CS35L45_BST_EN_SHIFT);
-
 	ret = cs35l45_apply_property_config(cs35l45);
 	if (ret < 0)
 		return ret;
-- 
2.30.2

