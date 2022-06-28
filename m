Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BCD55E8A3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347862AbiF1Pek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347929AbiF1Peb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:34:31 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03092CCB9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:34:27 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25SAPO2I011111;
        Tue, 28 Jun 2022 10:34:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=h+s9sft2OOTYhSCEtjVTTS2VSJSR6LqopQ6K+pEwIRY=;
 b=AtplLyi05zdDxYYYLThPcpN9i8Bxhxt9LTFfnKSl0gxy/sLXiWTZlmkuB+yAnR1A0Viy
 +s7OsIWVwHcxpVuXhwXT2evs5nVF1C1ndRt4eIKdjJQ8AZn7mNRQxwdVNX3hJ8WU5QHc
 +2ShX/kkaIWRFteDwDyurQ0DFUuNCZGdAgjSntSEBuyf9SlSBvCSro3POnbh9HLvKsBG
 AV2Ns5MwOiYYRBXphznOorzHWLIw6NRvoDUYjA9ZRMIwooo+TKsTb4RRzgrn8qnJXdFL
 UjMf9nG4zDe6iZ/aE0kK5g4zEDBp8QOVkn5cqcNmdzF044Fl8KSk6rdimubCvGRwAFzy 5Q== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3gwys2mat2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 28 Jun 2022 10:34:11 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 28 Jun
 2022 16:34:09 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 28 Jun 2022 16:34:09 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 46FF72A1;
        Tue, 28 Jun 2022 15:34:09 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] ASoC: wm5102: Fix event generation for output compensation
Date:   Tue, 28 Jun 2022 16:34:06 +0100
Message-ID: <20220628153409.3266932-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: JDtivHhNZ4rrKEk9EKjZzAiA3ElKlLOK
X-Proofpoint-GUID: JDtivHhNZ4rrKEk9EKjZzAiA3ElKlLOK
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The output compensation controls always returns zero regardless of if
the control value was updated. This results in missing notifications
to user-space of the control change. Update the handling to return 1
when the value is changed.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm5102.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index da2f8998df87a..b034df47a5ef1 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -680,12 +680,17 @@ static int wm5102_out_comp_coeff_put(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	struct arizona *arizona = dev_get_drvdata(component->dev->parent);
+	uint16_t dac_comp_coeff = get_unaligned_be16(ucontrol->value.bytes.data);
+	int ret = 0;
 
 	mutex_lock(&arizona->dac_comp_lock);
-	arizona->dac_comp_coeff = get_unaligned_be16(ucontrol->value.bytes.data);
+	if (arizona->dac_comp_coeff != dac_comp_coeff) {
+		arizona->dac_comp_coeff = dac_comp_coeff;
+		ret = 1;
+	}
 	mutex_unlock(&arizona->dac_comp_lock);
 
-	return 0;
+	return ret;
 }
 
 static int wm5102_out_comp_switch_get(struct snd_kcontrol *kcontrol,
@@ -706,12 +711,20 @@ static int wm5102_out_comp_switch_put(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	struct arizona *arizona = dev_get_drvdata(component->dev->parent);
+	struct soc_mixer_control *mc = (struct soc_mixer_control *)kcontrol->private_value;
+	int ret = 0;
+
+	if (ucontrol->value.integer.value[0] > mc->max)
+		return -EINVAL;
 
 	mutex_lock(&arizona->dac_comp_lock);
-	arizona->dac_comp_enabled = ucontrol->value.integer.value[0];
+	if (arizona->dac_comp_enabled != ucontrol->value.integer.value[0]) {
+		arizona->dac_comp_enabled = ucontrol->value.integer.value[0];
+		ret = 1;
+	}
 	mutex_unlock(&arizona->dac_comp_lock);
 
-	return 0;
+	return ret;
 }
 
 static const char * const wm5102_osr_text[] = {
-- 
2.30.2

