Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C694511EDD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239114AbiD0PLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238918AbiD0PK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:10:56 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114E833A27
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:07:44 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23R6M8vi014103;
        Wed, 27 Apr 2022 10:07:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=V8Mvv4H/VjXen4//QTXfHhT64KQCMiYzfVg7yIvyhMQ=;
 b=Z/Hv6Nuey+czONX9tQDxL/H951V9aG8Pz+OrmhfxtJIplfPES3THNjiJ4uewxQx6TRuN
 Y4Iza06TcNqF81BoiyThQpyNzVwqsk+JPG64Hw4Mj4vUCCw9BtpYc26DTAx4u1VuXpni
 46UFz2nyMzAF/eA9m85KTplX4LNqRyBe4dwQWUivTwibbmiPFTS/PhQCs9KhV4eLZoWl
 2ErjMyKkvr0+w0z8kJi0Iu4nFQb9d8GjxUbj9SN8XapJaVLfHZdy7o2asIREx5BrSZ5O
 nccylXvyyreE0Pj6CPSVtZBwoAKEz/7wNvfKx5/IkeODdp7undPGBQtI+s42iram75VT wA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fprt60xth-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 Apr 2022 10:07:28 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 16:07:26 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 27 Apr 2022 16:07:26 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.170])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E1D7A46C;
        Wed, 27 Apr 2022 15:07:25 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH 09/26] ALSA: hda: cs35l41: Add Amp Name based on channel and index
Date:   Wed, 27 Apr 2022 16:07:03 +0100
Message-ID: <20220427150720.9194-10-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
References: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: KSfQvzsFPytPkcB97WqfF-KX0G21mgt0
X-Proofpoint-ORIG-GUID: KSfQvzsFPytPkcB97WqfF-KX0G21mgt0
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

This will be used to identify ALSA controls and firmware.
The Amp Name will be a channel identifier (L or R), and an
index, which identifies which amp for that channel.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 17 +++++++++++++++++
 sound/pci/hda/cs35l41_hda.h |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 2608bf4a6851..cce27a86267f 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -88,6 +88,17 @@ static int cs35l41_hda_channel_map(struct device *dev, unsigned int tx_num, unsi
 				    unsigned int rx_num, unsigned int *rx_slot)
 {
 	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
+	static const char * const channel_name[] = { "L", "R" };
+
+	if (!cs35l41->amp_name) {
+		if (*rx_slot >= ARRAY_SIZE(channel_name))
+			return -EINVAL;
+
+		cs35l41->amp_name = devm_kasprintf(cs35l41->dev, GFP_KERNEL, "%s%d",
+						   channel_name[*rx_slot], cs35l41->channel_index);
+		if (!cs35l41->amp_name)
+			return -ENOMEM;
+	}
 
 	return cs35l41_set_channels(cs35l41->dev, cs35l41->regmap, tx_num, tx_slot, rx_num,
 				    rx_slot);
@@ -345,6 +356,11 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 		goto err;
 	hw_cfg->spk_pos = values[cs35l41->index];
 
+	cs35l41->channel_index = 0;
+	for (i = 0; i < cs35l41->index; i++)
+		if (values[i] == hw_cfg->spk_pos)
+			cs35l41->channel_index++;
+
 	property = "cirrus,gpio1-func";
 	ret = device_property_read_u32_array(physdev, property, values, nval);
 	if (ret)
@@ -410,6 +426,7 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 	/* check I2C address to assign the index */
 	cs35l41->index = id == 0x40 ? 0 : 1;
 	cs35l41->hw_cfg.spk_pos = cs35l41->index;
+	cs35l41->channel_index = 0;
 	cs35l41->reset_gpio = gpiod_get_index(physdev, NULL, 0, GPIOD_OUT_HIGH);
 	cs35l41->hw_cfg.bst_type = CS35L41_EXT_BOOST_NO_VSPK_SWITCH;
 	hw_cfg->gpio2.func = CS35L41_GPIO2_INT_OPEN_DRAIN;
diff --git a/sound/pci/hda/cs35l41_hda.h b/sound/pci/hda/cs35l41_hda.h
index c486e4a5bb24..a52ffd1f7999 100644
--- a/sound/pci/hda/cs35l41_hda.h
+++ b/sound/pci/hda/cs35l41_hda.h
@@ -35,7 +35,9 @@ struct cs35l41_hda {
 
 	int irq;
 	int index;
+	int channel_index;
 	unsigned volatile long irq_errors;
+	const char *amp_name;
 	struct regmap_irq_chip_data *irq_data;
 };
 
-- 
2.32.0

