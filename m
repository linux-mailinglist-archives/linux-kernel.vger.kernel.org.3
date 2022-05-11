Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AD452302C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237227AbiEKKD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 06:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239500AbiEKKCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:02:50 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4475849F88
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 03:02:27 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24B4xHqP029588;
        Wed, 11 May 2022 05:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=uD8g4n5cPT9hscvEkoP6sTC3o6MpJbq8d1DTDJAD3Uo=;
 b=njAivVw22o46BW5YZC8cPBJspRsIP2mSYwy4gpDQj5yRwu6itp3Uq8xs5VH9UQlUeP8b
 PQxMMsPeX4MeiKifHzEFiuFIRf3Waklgf0kQv3VVdwZIqKr+UOU754XiveUBgdx4gDPb
 LKkLTjemEUKv7zbp48HiRu8JjDfhZ8SV53/n2DQIF7hYhO3RHvL/6NiYtxlYl+fiZASv
 v1LCYkNsMCCrrygaVhQ+GcC+V4ZtnzjUG5VXpITlUMqiTvodl10nNdul0yQDZ7DkueXm
 iSiR7nmwaQ1APWaqDBva/fr9yh/l7qdbmeErNFu/x20+dn1zvXXmp5RYvLJuOhOPRfBu qg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fwn6nwt0g-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 May 2022 05:02:16 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 11:02:13 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 11 May 2022 11:02:13 +0100
Received: from sbinding-cirrus-dsktp.ad.cirrus.com (unknown [198.90.238.24])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6ABF2468;
        Wed, 11 May 2022 10:02:13 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 3/3] ALSA: hda/cs8409: Add Speaker Playback Switch for Warlock
Date:   Wed, 11 May 2022 11:02:07 +0100
Message-ID: <20220511100207.1268321-4-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511100207.1268321-1-sbinding@opensource.cirrus.com>
References: <20220511100207.1268321-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: r04KqkmNxpTNbo34xHp9hDwFCSnyHDNQ
X-Proofpoint-GUID: r04KqkmNxpTNbo34xHp9hDwFCSnyHDNQ
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for a Speaker Playback Switch, which disables
the Amp connected to cs8409. The Switch is not added
automatically because cs8409 does not have an output amp
for the speaker NID.

Note: This switch uses a different GPIO to Cyborg/Odin variants

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/patch_cs8409.c | 2 ++
 sound/pci/hda/patch_cs8409.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index e9b9273dbfd9..754aa8ddd2e4 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -1168,10 +1168,12 @@ void cs8409_cs42l42_fixups(struct hda_codec *codec, const struct hda_fixup *fix,
 		case CS8409_WARLOCK_MLK:
 		case CS8409_WARLOCK_MLK_DUAL_MIC:
 			spec->scodecs[CS8409_CODEC0]->full_scale_vol = CS42L42_FULL_SCALE_VOL_0DB;
+			spec->speaker_pdn_gpio = CS8409_WARLOCK_SPEAKER_PDN;
 			break;
 		default:
 			spec->scodecs[CS8409_CODEC0]->full_scale_vol =
 				CS42L42_FULL_SCALE_VOL_MINUS6DB;
+			spec->speaker_pdn_gpio = CS8409_WARLOCK_SPEAKER_PDN;
 			break;
 		}
 
diff --git a/sound/pci/hda/patch_cs8409.h b/sound/pci/hda/patch_cs8409.h
index 630a7a2de51f..260388a6256c 100644
--- a/sound/pci/hda/patch_cs8409.h
+++ b/sound/pci/hda/patch_cs8409.h
@@ -239,6 +239,7 @@ enum cs8409_coefficient_index_registers {
 #define CS8409_CS42L42_RESET			GENMASK(5, 5) /* CS8409_GPIO5 */
 #define CS8409_CS42L42_INT			GENMASK(4, 4) /* CS8409_GPIO4 */
 #define CS8409_CYBORG_SPEAKER_PDN		GENMASK(2, 2) /* CS8409_GPIO2 */
+#define CS8409_WARLOCK_SPEAKER_PDN		GENMASK(1, 1) /* CS8409_GPIO1 */
 #define CS8409_CS42L42_HP_PIN_NID		CS8409_PIN_ASP1_TRANSMITTER_A
 #define CS8409_CS42L42_SPK_PIN_NID		CS8409_PIN_ASP2_TRANSMITTER_A
 #define CS8409_CS42L42_AMIC_PIN_NID		CS8409_PIN_ASP1_RECEIVER_A
-- 
2.25.1

