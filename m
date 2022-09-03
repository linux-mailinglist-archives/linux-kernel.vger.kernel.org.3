Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B0F5ABC8F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 05:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiICDWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 23:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiICDWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 23:22:10 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA13AA4C3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 20:22:02 -0700 (PDT)
X-UUID: 93dd09b9dae14bfc8312c7f32e8d8472-20220903
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=fJObzOkxqCK/zu3xiS1JDCbQmMq2BkxFrGab8445ook=;
        b=tAA6dul/iLsIDZ4nSY9WTijX+CV3yTuYJHAW0infg2SCOfOfxh62WoemSKUoTt+BSnKAZR9foyts4BvyYS0Uu3+aZ83dveRuna5hjhqfglhTOOJUC0fJFHhwriIQb14gc3vGLpvl3FV8rDy8kOkka1QhG/o3uB6uJVvuC9NNM/c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:3a462cba-542a-4c13-b9ec-1e3819166891,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Relea
        se_Ham,ACTION:release,TS:70
X-CID-INFO: VERSION:1.1.10,REQID:3a462cba-542a-4c13-b9ec-1e3819166891,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS
        981B3D,ACTION:quarantine,TS:70
X-CID-META: VersionHash:84eae18,CLOUDID:c7e781d0-20bd-4e5e-ace8-00692b7ab380,C
        OID:b674ad4010d1,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 93dd09b9dae14bfc8312c7f32e8d8472-20220903
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <chunxu.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1345567567; Sat, 03 Sep 2022 11:21:57 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 3 Sep 2022 11:21:56 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Sat, 3 Sep 2022 11:21:55 +0800
From:   Chunxu Li <chunxu.li@mediatek.com>
To:     <broonie@kernel.org>, <pierre-louis.bossart@linux.intel.com>,
        <peter.ujfalusi@linux.intel.com>, <lgirdwood@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <daniel.baluta@nxp.com>
CC:     <matthias.bgg@gmail.com>, <yc.hung@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <sound-open-firmware@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <project_global_chrome_upstream_group@mediatek.com>,
        Chunxu Li <chunxu.li@mediatek.com>
Subject: [PATCH] ASoC: SOF: Introduce function sof_of_machine_select
Date:   Sat, 3 Sep 2022 11:21:51 +0800
Message-ID: <20220903032151.13664-1-chunxu.li@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From current design in sof_machine_check the SOF can only support
ACPI type machine.

In sof_machine_check if there is no ACPI machine exist, the function
will return -ENODEV directly, that's we don't expected if we do not
base on ACPI machine.

So we add a new function named sof_of_machine_select that we can pass
sof_machine_check and obtain info required by snd_sof_new_platform_drv.

Signed-off-by: Chunxu Li <chunxu.li@mediatek.com>
---
 sound/soc/sof/sof-audio.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
index c18e723435bd..ea9663d448eb 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -785,6 +785,28 @@ int sof_dai_get_bclk(struct snd_soc_pcm_runtime *rtd)
 }
 EXPORT_SYMBOL(sof_dai_get_bclk);
 
+static struct snd_sof_of_mach *sof_of_machine_select(struct snd_sof_dev *sdev)
+{
+	struct snd_sof_pdata *sof_pdata = sdev->pdata;
+	const struct sof_dev_desc *desc = sof_pdata->desc;
+	struct snd_sof_of_mach *mach = desc->of_machines;
+
+	if (!mach)
+		return NULL;
+
+	for (; mach->compatible; mach++) {
+		if (of_machine_is_compatible(mach->compatible)) {
+			sof_pdata->tplg_filename = mach->sof_tplg_filename;
+			if (mach->fw_filename)
+				sof_pdata->fw_filename = mach->fw_filename;
+
+			return mach;
+		}
+	}
+
+	return NULL;
+}
+
 /*
  * SOF Driver enumeration.
  */
@@ -795,6 +817,7 @@ int sof_machine_check(struct snd_sof_dev *sdev)
 	struct snd_soc_acpi_mach *mach;
 
 	if (!IS_ENABLED(CONFIG_SND_SOC_SOF_FORCE_NOCODEC_MODE)) {
+		const struct snd_sof_of_mach *of_mach;
 
 		/* find machine */
 		mach = snd_sof_machine_select(sdev);
@@ -804,6 +827,12 @@ int sof_machine_check(struct snd_sof_dev *sdev)
 			return 0;
 		}
 
+		of_mach = sof_of_machine_select(sdev);
+		if (of_mach) {
+			sof_pdata->of_machine = of_mach;
+			return 0;
+		}
+
 		if (!IS_ENABLED(CONFIG_SND_SOC_SOF_NOCODEC)) {
 			dev_err(sdev->dev, "error: no matching ASoC machine driver found - aborting probe\n");
 			return -ENODEV;
-- 
2.25.1

