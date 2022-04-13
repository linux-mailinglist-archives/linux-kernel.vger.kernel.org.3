Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3614FF242
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 10:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbiDMIkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 04:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbiDMIkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:40:12 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DB53D1CF;
        Wed, 13 Apr 2022 01:37:52 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23D8Z6Ri011523;
        Wed, 13 Apr 2022 03:37:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Fzriqc2p2agRhxATihfO5zPm2dKIdLr6K8XcqGOA/y4=;
 b=CwC8oZYQjkoO/Us24v12mrBG9tAhrNMRbyEsjtim5jQB878mKcQHectkntZtzx3hUaVn
 37CRu1t2ZdqiSK5H9lZhKKu8JDcsleS0MiwUgfWPyT1Zh3jmDfgRny6ovupu+5CJDGEu
 Tx3HSQ9i8qfGQp3g12ElYUyJsQMfHKmL2zZ9/ZS3yDZ2MFpqaYqMTEjOOyshePd90NUl
 k6R1ExgCrhA0y/SvVytDuMBjRyGWKmlPbUGao64du48R41kC5LhrETWsPLYIp8yZp/iq
 8x2c3ulS9m5Cqfwsmy5L6WYoQ/iVUSAndNRsUX5n2L1TvD2gDhnl/XSQNlNxTD3gY9HY Rg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fb6pycvcv-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Apr 2022 03:37:34 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 13 Apr
 2022 09:37:31 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 13 Apr 2022 09:37:31 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.152])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2B48AB06;
        Wed, 13 Apr 2022 08:37:31 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v7 05/16] ALSA: hda: cs35l41: Always configure the DAI
Date:   Wed, 13 Apr 2022 09:37:17 +0100
Message-ID: <20220413083728.10730-6-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220413083728.10730-1-tanureal@opensource.cirrus.com>
References: <20220413083728.10730-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VqMwxqfUOQyj22gd7Mm4YJ0jgPj6MkUg
X-Proofpoint-GUID: VqMwxqfUOQyj22gd7Mm4YJ0jgPj6MkUg
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dai configuration is always the same and should always configured
during the opening the stream.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index d2addae8c085..f853530eb385 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -111,8 +111,6 @@ static const struct reg_sequence cs35l41_reset_to_safe[] = {
 static const struct cs35l41_hda_reg_sequence cs35l41_hda_reg_seq_no_bst = {
 	.probe		= cs35l41_reset_to_safe,
 	.num_probe	= ARRAY_SIZE(cs35l41_reset_to_safe),
-	.open		= cs35l41_hda_config,
-	.num_open	= ARRAY_SIZE(cs35l41_hda_config),
 	.prepare	= cs35l41_safe_to_active,
 	.num_prepare	= ARRAY_SIZE(cs35l41_safe_to_active),
 	.cleanup	= cs35l41_active_to_safe,
@@ -120,8 +118,6 @@ static const struct cs35l41_hda_reg_sequence cs35l41_hda_reg_seq_no_bst = {
 };
 
 static const struct cs35l41_hda_reg_sequence cs35l41_hda_reg_seq_ext_bst = {
-	.open		= cs35l41_hda_config,
-	.num_open	= ARRAY_SIZE(cs35l41_hda_config),
 	.prepare	= cs35l41_start_ext_vspk,
 	.num_prepare	= ARRAY_SIZE(cs35l41_start_ext_vspk),
 	.cleanup	= cs35l41_stop_ext_vspk,
@@ -129,8 +125,6 @@ static const struct cs35l41_hda_reg_sequence cs35l41_hda_reg_seq_ext_bst = {
 };
 
 static const struct cs35l41_hda_reg_sequence cs35l41_hda_reg_seq_int_bst = {
-	.open		= cs35l41_hda_config,
-	.num_open	= ARRAY_SIZE(cs35l41_hda_config),
 	.prepare	= cs35l41_hda_start_bst,
 	.num_prepare	= ARRAY_SIZE(cs35l41_hda_start_bst),
 	.cleanup	= cs35l41_hda_stop_bst,
@@ -146,8 +140,8 @@ static void cs35l41_hda_playback_hook(struct device *dev, int action)
 
 	switch (action) {
 	case HDA_GEN_PCM_ACT_OPEN:
-		if (reg_seq->open)
-			ret = regmap_multi_reg_write(reg, reg_seq->open, reg_seq->num_open);
+		ret = regmap_multi_reg_write(reg, cs35l41_hda_config,
+					     ARRAY_SIZE(cs35l41_hda_config));
 		break;
 	case HDA_GEN_PCM_ACT_PREPARE:
 		if (reg_seq->prepare)
-- 
2.35.2

