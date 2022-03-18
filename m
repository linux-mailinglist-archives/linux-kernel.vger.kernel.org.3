Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B718F4DDD61
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238360AbiCRP5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238322AbiCRP5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:57:33 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF18091567
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:56:14 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22I7cSuE022149;
        Fri, 18 Mar 2022 10:55:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Z9kbc2iZs4zHIK+C/HKRIGquRTDVsrdl0296zsGzzOg=;
 b=OfDhq2UuAsSMS8v4kTct+EjJaLdgNU6iRLMJlJiFIbJd8agqCxSbx4QYIREphGuPaGIH
 vUQ5TgpBr6Iks3vU17dZamNJ4fsE7H4oqagRp3HEiA0wC9wUXEdFkEk3+Uh6CfX1/COK
 V9zScwUF8qWCDRMn+QaqNF8xHT84m9Iub7M3sQRIRHkw+rc/23TA7v1X/aKzoK8nwzdI
 7Wk61vgGRz7zb2p5Zst2VHwJXaURlBblRwlKY8nguWaLbvM+Una4XbWi5QGgQU/+hHDf
 fSINfYkTjY5Zi6QbtyYbRg8BlXZf3rUDbRw6jYQcdoG7s5pLrDZNxiszsSfBLho42Xb5 VA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3et642ee6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Mar 2022 10:55:56 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Mar
 2022 15:55:54 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 18 Mar 2022 15:55:54 +0000
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.229])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 42F7711D1;
        Fri, 18 Mar 2022 15:55:54 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH 3/6] ALSA: hda/cs8409: Fix Full Scale Volume setting for all variants
Date:   Fri, 18 Mar 2022 15:55:49 +0000
Message-ID: <20220318155552.24751-4-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220318155552.24751-1-vitalyr@opensource.cirrus.com>
References: <20220318155552.24751-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: GqtRrS6FuqPrHbfwJNsY6mrjoWHzYnEo
X-Proofpoint-ORIG-GUID: GqtRrS6FuqPrHbfwJNsY6mrjoWHzYnEo
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

Also make more explicit meaning and setting of Full Scale Volume
setting to avoid future confusion.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/patch_cs8409.c | 29 ++++++++++++++++-------------
 sound/pci/hda/patch_cs8409.h |  3 +++
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index 1411e3845f16..163ff3b3092a 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -733,6 +733,7 @@ static void cs42l42_resume(struct sub_codec *cs42l42)
 		{ 0x130A, 0x00 },
 		{ 0x130F, 0x00 },
 	};
+	int fsv_old, fsv_new;
 
 	/* Bring CS42L42 out of Reset */
 	gpio_data = snd_hda_codec_read(codec, CS8409_PIN_AFG, 0, AC_VERB_GET_GPIO_DATA, 0);
@@ -749,8 +750,13 @@ static void cs42l42_resume(struct sub_codec *cs42l42)
 	/* Clear interrupts, by reading interrupt status registers */
 	cs8409_i2c_bulk_read(cs42l42, irq_regs, ARRAY_SIZE(irq_regs));
 
-	if (cs42l42->full_scale_vol)
-		cs8409_i2c_write(cs42l42, 0x2001, 0x01);
+	fsv_old = cs8409_i2c_read(cs42l42, 0x2001);
+	if (cs42l42->full_scale_vol == CS42L42_FULL_SCALE_VOL_0DB)
+		fsv_new = fsv_old & ~CS42L42_FULL_SCALE_VOL_MASK;
+	else
+		fsv_new = fsv_old & CS42L42_FULL_SCALE_VOL_MASK;
+	if (fsv_new != fsv_old)
+		cs8409_i2c_write(cs42l42, 0x2001, fsv_new);
 
 	/* we have to explicitly allow unsol event handling even during the
 	 * resume phase so that the jack event is processed properly
@@ -997,21 +1003,15 @@ void cs8409_cs42l42_fixups(struct hda_codec *codec, const struct hda_fixup *fix,
 		 * Additionally set HSBIAS_SENSE_EN and Full Scale volume for some variants.
 		 */
 		switch (codec->fixup_id) {
-		case CS8409_WARLOCK:
-			spec->scodecs[CS8409_CODEC0]->hsbias_hiz = 0x0020;
-			spec->scodecs[CS8409_CODEC0]->full_scale_vol = 1;
-			break;
-		case CS8409_BULLSEYE:
-			spec->scodecs[CS8409_CODEC0]->hsbias_hiz = 0x0020;
-			spec->scodecs[CS8409_CODEC0]->full_scale_vol = 0;
-			break;
 		case CS8409_CYBORG:
 			spec->scodecs[CS8409_CODEC0]->hsbias_hiz = 0x00a0;
-			spec->scodecs[CS8409_CODEC0]->full_scale_vol = 1;
+			spec->scodecs[CS8409_CODEC0]->full_scale_vol =
+				CS42L42_FULL_SCALE_VOL_MINUS6DB;
 			break;
 		default:
-			spec->scodecs[CS8409_CODEC0]->hsbias_hiz = 0x0003;
-			spec->scodecs[CS8409_CODEC0]->full_scale_vol = 1;
+			spec->scodecs[CS8409_CODEC0]->hsbias_hiz = 0x0020;
+			spec->scodecs[CS8409_CODEC0]->full_scale_vol =
+				CS42L42_FULL_SCALE_VOL_MINUS6DB;
 			break;
 		}
 
@@ -1222,6 +1222,9 @@ void dolphin_fixups(struct hda_codec *codec, const struct hda_fixup *fix, int ac
 		cs8409_fix_caps(codec, DOLPHIN_LO_PIN_NID);
 		cs8409_fix_caps(codec, DOLPHIN_AMIC_PIN_NID);
 
+		spec->scodecs[CS8409_CODEC0]->full_scale_vol = CS42L42_FULL_SCALE_VOL_MINUS6DB;
+		spec->scodecs[CS8409_CODEC1]->full_scale_vol = CS42L42_FULL_SCALE_VOL_MINUS6DB;
+
 		break;
 	case HDA_FIXUP_ACT_PROBE:
 		/* Fix Sample Rate to 48kHz */
diff --git a/sound/pci/hda/patch_cs8409.h b/sound/pci/hda/patch_cs8409.h
index d0b725c7285b..8e846f292cd0 100644
--- a/sound/pci/hda/patch_cs8409.h
+++ b/sound/pci/hda/patch_cs8409.h
@@ -235,6 +235,9 @@ enum cs8409_coefficient_index_registers {
 #define CS42L42_I2C_SLEEP_US			(2000)
 #define CS42L42_PDN_TIMEOUT_US			(250000)
 #define CS42L42_PDN_SLEEP_US			(2000)
+#define CS42L42_FULL_SCALE_VOL_MASK		(2)
+#define CS42L42_FULL_SCALE_VOL_0DB		(1)
+#define CS42L42_FULL_SCALE_VOL_MINUS6DB		(0)
 
 /* Dell BULLSEYE / WARLOCK / CYBORG Specific Definitions */
 
-- 
2.25.1

