Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D8C5206FC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 23:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiEIVxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 17:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiEIVvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 17:51:22 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757C62725D7
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 14:47:25 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 249KTf3H031853;
        Mon, 9 May 2022 16:47:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=bgdHWQGirsSxV+Hq/FWgJMJCd/1GeDJKgy7LjsIWtBI=;
 b=ZLsdPuHPe7iGlT61IRFMn/laHHI1rbq/xGVfk/SPO6XVDSgLP/rHk7sXrPNZBDoU/NUG
 7SHe4S3+HLXVj7qyfNLpdQsjn/K3b5s9o20uA9x0cTOjipO+oAdsbKxaaIpvGHRHi9yd
 7nl03Arp17xkblSGjYIVLQNke9NevtATWY+s72sl/zre+EFJ3JLJSTwvuHLdu97OVjQx
 WlYKAK2mX+HLzVER6ml1WhoI1dfhXMTaObeNPiz4gBJzCv10Kfl6XsqTGy5cuHUYPl5Y
 8pkT6fwniM39dLKx2G8d6Bh7TTWB4WDmoZD2XBj/b5SB8lh4oJwrCBttxkAMwX6yjxmB dg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fwn6nu87p-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 09 May 2022 16:47:07 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 22:47:05 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Mon, 9 May 2022 22:47:05 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.55])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 48D29B10;
        Mon,  9 May 2022 21:47:05 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 03/26] ALSA: hda: cs35l41: Remove Set Channel Map api from binding
Date:   Mon, 9 May 2022 22:46:40 +0100
Message-ID: <20220509214703.4482-4-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220509214703.4482-1-vitalyr@opensource.cirrus.com>
References: <20220509214703.4482-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: m3onGlIfLiaMK0Q0IqTHlYxe96ZdZ_pE
X-Proofpoint-GUID: m3onGlIfLiaMK0Q0IqTHlYxe96ZdZ_pE
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

This API was required for CLSA0100 laptop, which did not
have correct properties inside ACPI. The required values
are now hardcoded inside the driver so this is no longer
needed.
Without this api, there CLSA0100 can now use the generic
cs35l41 fixup, like the other laptops.
All other laptops will read the Speaker Position from
ACPI and set the channel map from within the driver.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c   |  1 -
 sound/pci/hda/hda_component.h |  2 --
 sound/pci/hda/patch_realtek.c | 54 +----------------------------------
 3 files changed, 1 insertion(+), 56 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index d7e90c0cae51..96c3e541696d 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -92,7 +92,6 @@ static int cs35l41_hda_bind(struct device *dev, struct device *master, void *mas
 	comps->dev = dev;
 	strscpy(comps->name, dev_name(dev), sizeof(comps->name));
 	comps->playback_hook = cs35l41_hda_playback_hook;
-	comps->set_channel_map = cs35l41_hda_channel_map;
 
 	return 0;
 }
diff --git a/sound/pci/hda/hda_component.h b/sound/pci/hda/hda_component.h
index 2e52be6db9c2..e26c896a13f3 100644
--- a/sound/pci/hda/hda_component.h
+++ b/sound/pci/hda/hda_component.h
@@ -15,6 +15,4 @@ struct hda_component {
 	struct device *dev;
 	char name[HDA_MAX_NAME_SIZE];
 	void (*playback_hook)(struct device *dev, int action);
-	int (*set_channel_map)(struct device *dev, unsigned int rx_num, unsigned int *rx_slot,
-				unsigned int tx_num, unsigned int *tx_slot);
 };
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index cf531c1efa13..27460a61487e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6582,18 +6582,6 @@ static void alc287_fixup_legion_15imhg05_speakers(struct hda_codec *codec,
 	}
 }
 
-static int find_comp_by_dev_name(struct alc_spec *spec, const char *name)
-{
-	int i;
-
-	for (i = 0; i < HDA_MAX_COMPONENTS; i++) {
-		if (strcmp(spec->comps[i].name, name) == 0)
-			return i;
-	}
-
-	return -ENODEV;
-}
-
 static int comp_bind(struct device *dev)
 {
 	struct hda_codec *cdc = dev_to_hda_codec(dev);
@@ -6668,50 +6656,10 @@ static void cs35l41_fixup_spi_four(struct hda_codec *codec, const struct hda_fix
 	cs35l41_generic_fixup(codec, action, "spi0", "CSC3551", 4);
 }
 
-static void alc287_legion_16achg6_playback_hook(struct hda_pcm_stream *hinfo, struct hda_codec *cdc,
-						struct snd_pcm_substream *sub, int action)
-{
-	struct alc_spec *spec = cdc->spec;
-	unsigned int rx_slot;
-	int i;
-
-	switch (action) {
-	case HDA_GEN_PCM_ACT_PREPARE:
-		rx_slot = 0;
-		i = find_comp_by_dev_name(spec, "i2c-CLSA0100:00-cs35l41-hda.0");
-		if (i >= 0)
-			spec->comps[i].set_channel_map(spec->comps[i].dev, 0, NULL, 1, &rx_slot);
-
-		rx_slot = 1;
-		i = find_comp_by_dev_name(spec, "i2c-CLSA0100:00-cs35l41-hda.1");
-		if (i >= 0)
-			spec->comps[i].set_channel_map(spec->comps[i].dev, 0, NULL, 1, &rx_slot);
-		break;
-	}
-
-	comp_generic_playback_hook(hinfo, cdc, sub, action);
-}
-
 static void alc287_fixup_legion_16achg6_speakers(struct hda_codec *cdc, const struct hda_fixup *fix,
 						 int action)
 {
-	struct device *dev = hda_codec_dev(cdc);
-	struct alc_spec *spec = cdc->spec;
-	int ret;
-
-	switch (action) {
-	case HDA_FIXUP_ACT_PRE_PROBE:
-		component_match_add(dev, &spec->match, component_compare_dev_name,
-				    "i2c-CLSA0100:00-cs35l41-hda.0");
-		component_match_add(dev, &spec->match, component_compare_dev_name,
-				    "i2c-CLSA0100:00-cs35l41-hda.1");
-		ret = component_master_add_with_match(dev, &comp_master_ops, spec->match);
-		if (ret)
-			codec_err(cdc, "Fail to register component aggregator %d\n", ret);
-		else
-			spec->gen.pcm_playback_hook = alc287_legion_16achg6_playback_hook;
-		break;
-	}
+	cs35l41_generic_fixup(cdc, action, "i2c", "CLSA0100", 2);
 }
 
 /* for alc295_fixup_hp_top_speakers */
-- 
2.34.1

