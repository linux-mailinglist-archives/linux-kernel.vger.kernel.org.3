Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793154E960D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242141AbiC1MAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242589AbiC1L6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:58:25 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D5832ECB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:56:30 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22S8AHvd030601;
        Mon, 28 Mar 2022 06:56:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=2aajtPw/VHXGiRbn4d9elWFWs+V7SiFRzaL6S/XYPoc=;
 b=GY+pGXMMIti1+Y1NchsWxh2X/+3qI1hHKStPEJuQ8UHZbPZcgXnMa+JbyJhJt/HKjowy
 v2fM/pgab7ww7pL4EASM2Fct58iiIlndPEnjX9UDdBfHBg43To3LO/3+xk1iLFWR8BjL
 dHgFkpS2w7nhQDx+0yTS1XbVTCAE7aJyVfQVqRCc3RwLKdMR5x4hY6jZQtp70stVZvKT
 U9jfc/zaMZ4k5Ld2rZqXwiasb8AktU2Z7g6IGgRPWLD03jHGxL/KZM6ptxzgNW2OtHze
 4iMAdvl3Bjl3kLofA8h4baAGWqFnnC5mAPSxGZ66KxNUR27LjeE6gP6Cg8dbONd3LhCO 6Q== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3f2081apda-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 28 Mar 2022 06:56:19 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 12:56:17 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Mon, 28 Mar 2022 12:56:17 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.244])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D979EB16;
        Mon, 28 Mar 2022 11:56:16 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 5/6] ALSA: hda/cs8409: Disable HSBIAS_SENSE_EN for Cyborg
Date:   Mon, 28 Mar 2022 12:56:13 +0100
Message-ID: <20220328115614.15761-6-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220328115614.15761-1-vitalyr@opensource.cirrus.com>
References: <20220328115614.15761-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0GjImj-kWq39K3a-caZBIBcalXGmuIO8
X-Proofpoint-GUID: 0GjImj-kWq39K3a-caZBIBcalXGmuIO8
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

For ESD reasons, all variants should now set HSBIAS_SENSE_EN.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>

Changes in v2:
Add patch description in commit message.

---
 sound/pci/hda/patch_cs8409.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index ce5fc03a8065..343fabc4387d 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
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

