Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8414DDD62
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238353AbiCRP5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238319AbiCRP5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:57:32 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AF376679
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:56:14 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22I7cSuF022149;
        Fri, 18 Mar 2022 10:55:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=3klzixPaUORRG4vi7yBDbGgciraqNg82f+RLAgzmDXc=;
 b=My0J3LaKZlm2eCD7ddrt/KWPn0zkesz74M27JkFLXbuJoz8jRXhBL0c3EKO+cu+ANWd/
 B38v6lsDlW5CVz5EqjYBxEoSYvzO4vxSYlRmi5Fo7xXT6mhtxiWb/FtW0cfaxdGuqvt8
 cMEO6JMZaZg60pTTvumvRCPLm0URkklHYc0wfr2SmTwQusSbi/zlVzIylc/cSgaHBO9y
 Cnp4NhoJYW4KR9yvulGbY8KW5PpqJHe+PjnVeA3lS0Nzvyv0hjJrleKTCkay7g7nEntM
 KQH3Px1oICUCzPslyXfYXbofEsERmndebHvxKynzdoizko9kUPAzT7tjKpCZRdWZDmvX 2g== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3et642ee6v-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Mar 2022 10:55:57 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Mar
 2022 15:55:55 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 18 Mar 2022 15:55:55 +0000
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.229])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id F3ACCB1A;
        Fri, 18 Mar 2022 15:55:54 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH 5/6] ALSA: hda/cs8409: Disable HSBIAS_SENSE_EN for Cyborg
Date:   Fri, 18 Mar 2022 15:55:51 +0000
Message-ID: <20220318155552.24751-6-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220318155552.24751-1-vitalyr@opensource.cirrus.com>
References: <20220318155552.24751-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: x6h7dbTqd5is0AMPVkWxPNxMK9qMbRG5
X-Proofpoint-ORIG-GUID: x6h7dbTqd5is0AMPVkWxPNxMK9qMbRG5
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/patch_cs8409.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index 85da4a5e84a8..343fabc4387d 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -913,13 +913,13 @@ static void cs8409_cs42l42_hw_init(struct hda_codec *codec)
 	}
 
 	switch (codec->fixup_id) {
-		case CS8409_CYBORG:
-		case CS8409_WARLOCK_MLK_DUAL_MIC:
-			/* DMIC1_MO=00b, DMIC1/2_SR=1 */
-			cs8409_vendor_coef_set(codec, CS8409_DMIC_CFG, 0x0003);
-			break;
-		default:
-			break;
+	case CS8409_CYBORG:
+	case CS8409_WARLOCK_MLK_DUAL_MIC:
+		/* DMIC1_MO=00b, DMIC1/2_SR=1 */
+		cs8409_vendor_coef_set(codec, CS8409_DMIC_CFG, 0x0003);
+		break;
+	default:
+		break;
 	}
 
 	cs42l42_resume(cs42l42);
@@ -1005,15 +1005,8 @@ void cs8409_cs42l42_fixups(struct hda_codec *codec, const struct hda_fixup *fix,
 		cs8409_fix_caps(codec, CS8409_CS42L42_HP_PIN_NID);
 		cs8409_fix_caps(codec, CS8409_CS42L42_AMIC_PIN_NID);
 
-		/* Set TIP_SENSE_EN for analog front-end of tip sense.
-		 * Additionally set HSBIAS_SENSE_EN and Full Scale volume for some variants.
-		 */
+		/* Set HSBIAS_SENSE_EN and Full Scale volume for some variants. */
 		switch (codec->fixup_id) {
-		case CS8409_CYBORG:
-			spec->scodecs[CS8409_CODEC0]->hsbias_hiz = 0x00a0;
-			spec->scodecs[CS8409_CODEC0]->full_scale_vol =
-				CS42L42_FULL_SCALE_VOL_MINUS6DB;
-			break;
 		case CS8409_WARLOCK_MLK:
 		case CS8409_WARLOCK_MLK_DUAL_MIC:
 			spec->scodecs[CS8409_CODEC0]->hsbias_hiz = 0x0020;
-- 
2.25.1

