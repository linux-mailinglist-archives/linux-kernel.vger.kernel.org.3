Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F9455E84E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347932AbiF1Peq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347931AbiF1Pec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:34:32 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BD72BB09
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:34:32 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25SAPO2J011111;
        Tue, 28 Jun 2022 10:34:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Sg5V/JOYV9uhVr4H4c2c+mW3djbmU523MZTj9cu6wV8=;
 b=oIAqj0S1ejeZY/VaOeVQ4r+JEIpbgVNFfDmlItNO4E4k8nlFzM6UQWWbtta6liVJVuGC
 PG1hlOrYQSOWLJcoo1qKyHxttqPg/d+RAZLN9io3KCIjIW80Qc6az4t5Dx5NkYHZ1AAP
 ejOs3uLqBoLHGuONVWy/JdB0ONKJMdZqijxCGm826osH5qo2AOBnMFpq+ZSpPiE9id5n
 Lcx7VJXp92ojjEzVLQPuR5g4lr5mB5mAmXK3Dz19KDrv5bh2FQBoSw/gZzTQprzkbXqE
 Y1LJHjG51tX3GPrwK2KQwZj9I5ddXUaK/8WpPfN6LAMJ4MmmBVjkP6RlxbKwulgrZ97y eg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3gwys2mat2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 28 Jun 2022 10:34:12 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 28 Jun
 2022 16:34:09 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 28 Jun 2022 16:34:09 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4BBCA458;
        Tue, 28 Jun 2022 15:34:09 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] ASoC: wm8998: Fix event generation for input mux
Date:   Tue, 28 Jun 2022 16:34:07 +0100
Message-ID: <20220628153409.3266932-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220628153409.3266932-1-ckeepax@opensource.cirrus.com>
References: <20220628153409.3266932-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: DUAm5S6FSpeKs1rQXALmeksBnOmT4jbF
X-Proofpoint-GUID: DUAm5S6FSpeKs1rQXALmeksBnOmT4jbF
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wm8998_inmux_put returns the value of snd_soc_dapm_mux_update_power,
which returns a 1 if a path was found for the kcontrol. This is
obviously different to the expected return a 1 if the control
was updated value. This results in spurious notifications to
user-space. Update the handling to only return a 1 when the value is
changed.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm8998.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm8998.c b/sound/soc/codecs/wm8998.c
index 00b59fc9b1fe0..ab5481187c710 100644
--- a/sound/soc/codecs/wm8998.c
+++ b/sound/soc/codecs/wm8998.c
@@ -108,6 +108,7 @@ static int wm8998_inmux_put(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int mode_reg, mode_index;
 	unsigned int mux, inmode, src_val, mode_val;
+	int change, ret;
 
 	mux = ucontrol->value.enumerated.item[0];
 	if (mux > 1)
@@ -137,14 +138,20 @@ static int wm8998_inmux_put(struct snd_kcontrol *kcontrol,
 	snd_soc_component_update_bits(component, mode_reg,
 				      ARIZONA_IN1_MODE_MASK, mode_val);
 
-	snd_soc_component_update_bits(component, e->reg,
-				      ARIZONA_IN1L_SRC_MASK |
-				      ARIZONA_IN1L_SRC_SE_MASK,
-				      src_val);
+	change = snd_soc_component_update_bits(component, e->reg,
+					       ARIZONA_IN1L_SRC_MASK |
+					       ARIZONA_IN1L_SRC_SE_MASK,
+					       src_val);
 
-	return snd_soc_dapm_mux_update_power(dapm, kcontrol,
-					     ucontrol->value.enumerated.item[0],
-					     e, NULL);
+	ret = snd_soc_dapm_mux_update_power(dapm, kcontrol,
+					    ucontrol->value.enumerated.item[0],
+					    e, NULL);
+	if (ret < 0) {
+		dev_err(arizona->dev, "Failed to update demux power state: %d\n", ret);
+		return ret;
+	}
+
+	return change;
 }
 
 static const char * const wm8998_inmux_texts[] = {
-- 
2.30.2

