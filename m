Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67789511EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239161AbiD0PLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238971AbiD0PK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:10:57 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF86E541B5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:07:45 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23R6M8vl014103;
        Wed, 27 Apr 2022 10:07:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Kbi9tyRkam4NuDsbvQyAmGSuoQce+Q72iAA63LadoAw=;
 b=Vzp8ppm7SFCtPNM7kaq8rg942NKS3qxGFLXyEgtmQu9jrrFvFtwSOpzp2uNurIRpkqnI
 AbApmTZ3v5sbpcIF3LUvPPKw4rcLayKu6DRm5+5aFT8F+dTENFyXwpd4cwJnI1knOaFz
 BRB0p+KvnEnI6PEEzrF5+PG0AWVIKEtDk81uAjbosybD/MiOn9w54WfjAdCvfsVPB2UZ
 ulfZ2krLfNn+0utqzB0MqObO8nw7YxTpCqSAMjUbYVHCmkrhqxQN8XtSMNhu1PEOqKJ2
 yqpZS3YnFlAEaIhogNuGX4NeCvLwjDlCDSWQ78I0710X4Z3tBmmehgyiSRc/Yb+hR1Lp YA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fprt60xth-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 Apr 2022 10:07:32 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 16:07:27 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 27 Apr 2022 16:07:27 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.170])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5460A478;
        Wed, 27 Apr 2022 15:07:27 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH 12/26] ALSA: hda: cs35l41: Save codec object inside component struct
Date:   Wed, 27 Apr 2022 16:07:06 +0100
Message-ID: <20220427150720.9194-13-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
References: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 5ChtLbpRIep_TSTrkoJFv5WJivlfPO1I
X-Proofpoint-ORIG-GUID: 5ChtLbpRIep_TSTrkoJFv5WJivlfPO1I
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

This is required for ALSA control support.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c   | 1 +
 sound/pci/hda/cs35l41_hda.h   | 1 +
 sound/pci/hda/hda_component.h | 1 +
 sound/pci/hda/patch_realtek.c | 1 +
 4 files changed, 4 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index cce27a86267f..bbbaafac50c3 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -117,6 +117,7 @@ static int cs35l41_hda_bind(struct device *dev, struct device *master, void *mas
 		return -EBUSY;
 
 	comps->dev = dev;
+	cs35l41->codec = comps->codec;
 	strscpy(comps->name, dev_name(dev), sizeof(comps->name));
 	comps->playback_hook = cs35l41_hda_playback_hook;
 
diff --git a/sound/pci/hda/cs35l41_hda.h b/sound/pci/hda/cs35l41_hda.h
index a52ffd1f7999..aaf9e16684c2 100644
--- a/sound/pci/hda/cs35l41_hda.h
+++ b/sound/pci/hda/cs35l41_hda.h
@@ -32,6 +32,7 @@ struct cs35l41_hda {
 	struct regmap *regmap;
 	struct gpio_desc *reset_gpio;
 	struct cs35l41_hw_cfg hw_cfg;
+	struct hda_codec *codec;
 
 	int irq;
 	int index;
diff --git a/sound/pci/hda/hda_component.h b/sound/pci/hda/hda_component.h
index e26c896a13f3..534e845b9cd1 100644
--- a/sound/pci/hda/hda_component.h
+++ b/sound/pci/hda/hda_component.h
@@ -14,5 +14,6 @@
 struct hda_component {
 	struct device *dev;
 	char name[HDA_MAX_NAME_SIZE];
+	struct hda_codec *codec;
 	void (*playback_hook)(struct device *dev, int action);
 };
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index dc1ff4c54291..f7f732efd42b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6630,6 +6630,7 @@ static void cs35l41_generic_fixup(struct hda_codec *cdc, int action, const char
 					      "%s-%s:00-cs35l41-hda.%d", bus, hid, i);
 			if (!name)
 				return;
+			spec->comps[i].codec = cdc;
 			component_match_add(dev, &spec->match, component_compare_dev_name, name);
 		}
 		ret = component_master_add_with_match(dev, &comp_master_ops, spec->match);
-- 
2.32.0

