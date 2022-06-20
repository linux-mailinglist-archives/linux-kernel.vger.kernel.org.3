Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B96B552618
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345019AbiFTUzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344506AbiFTUzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:55:14 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1301BE9C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:55:04 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25KIfiVg023078;
        Mon, 20 Jun 2022 15:54:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=R/t6fc1SxxcbNSxZ8Yw6JojVc/MfujfdPc5svZLK/5I=;
 b=huHpXa/FxU8yDw6z+S3ckjNjUcCSW7I4Atmbe4X3fvjSJotlwQ+bYN4vwfzaHHdsbw+5
 jIv8aFCzdUU4CVI6C0YERIAhjfSYELc4tf5kjzTHzuobk5/MSX3ugIBjb55arQKzm2ko
 FdK3urcRIzQhE77k4xxLwXBRGHD6HDs+DWP7qcE4ghqbrU4EOOsWRW9bSokw0qFFcwMT
 Gy9lEsjSihTgjv23Rr1ernwKBg5Du8o2h+GZKc7xiJm3M9hPhfUQ64dBlZhOqeK6ksqP
 X7yot6uhwy/pZdJ+ZE39MsWLwmu3AYonpHskMUwDb6BpLuJDnQ850iulMaxRfnAJ1A87 aw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3gsb4p2p54-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 Jun 2022 15:54:46 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 20 Jun
 2022 21:54:44 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 20 Jun 2022 21:54:44 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.175])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5DD9911D1;
        Mon, 20 Jun 2022 20:54:44 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v5 05/14] ALSA: hda: cs35l41: Save Subsystem ID inside CS35L41 Driver
Date:   Mon, 20 Jun 2022 21:54:23 +0100
Message-ID: <20220620205432.3809-6-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220620205432.3809-1-vitalyr@opensource.cirrus.com>
References: <20220620205432.3809-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: eAqQipql3Avj4tLDs2NLqwhQNVyqkpyC
X-Proofpoint-ORIG-GUID: eAqQipql3Avj4tLDs2NLqwhQNVyqkpyC
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

The Subsystem ID is read from the HDA driver, and will
be used by the CS35L41 driver to be able to uniquely
identify the laptop, which is required to be able to
define firmware to be used by specific models.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c   | 3 +++
 sound/pci/hda/cs35l41_hda.h   | 1 +
 sound/pci/hda/hda_component.h | 1 +
 sound/pci/hda/patch_realtek.c | 1 +
 4 files changed, 6 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 92c6d8b7052e..7f0132694774 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -356,6 +356,9 @@ static int cs35l41_hda_bind(struct device *dev, struct device *master, void *mas
 		return -EBUSY;
 
 	comps->dev = dev;
+	if (!cs35l41->acpi_subsystem_id)
+		cs35l41->acpi_subsystem_id = devm_kasprintf(dev, GFP_KERNEL,
+							    "%.8x", comps->subsystem_id);
 	cs35l41->codec = comps->codec;
 	strscpy(comps->name, dev_name(dev), sizeof(comps->name));
 	comps->playback_hook = cs35l41_hda_playback_hook;
diff --git a/sound/pci/hda/cs35l41_hda.h b/sound/pci/hda/cs35l41_hda.h
index 5814af050944..b57f59a1ba49 100644
--- a/sound/pci/hda/cs35l41_hda.h
+++ b/sound/pci/hda/cs35l41_hda.h
@@ -42,6 +42,7 @@ struct cs35l41_hda {
 	int channel_index;
 	unsigned volatile long irq_errors;
 	const char *amp_name;
+	const char *acpi_subsystem_id;
 	struct mutex fw_mutex;
 	struct regmap_irq_chip_data *irq_data;
 	bool firmware_running;
diff --git a/sound/pci/hda/hda_component.h b/sound/pci/hda/hda_component.h
index 534e845b9cd1..fa6df52e7855 100644
--- a/sound/pci/hda/hda_component.h
+++ b/sound/pci/hda/hda_component.h
@@ -14,6 +14,7 @@
 struct hda_component {
 	struct device *dev;
 	char name[HDA_MAX_NAME_SIZE];
+	int subsystem_id;
 	struct hda_codec *codec;
 	void (*playback_hook)(struct device *dev, int action);
 };
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 923c0d498d54..6a944396582b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6655,6 +6655,7 @@ static void cs35l41_generic_fixup(struct hda_codec *cdc, int action, const char
 			if (!name)
 				return;
 			spec->comps[i].codec = cdc;
+			spec->comps[i].subsystem_id = cdc->core.subsystem_id;
 			component_match_add(dev, &spec->match, component_compare_dev_name, name);
 		}
 		ret = component_master_add_with_match(dev, &comp_master_ops, spec->match);
-- 
2.34.1

