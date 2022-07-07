Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A4F56A6B0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 17:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbiGGPLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 11:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbiGGPLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 11:11:01 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A0A24F25;
        Thu,  7 Jul 2022 08:11:00 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267BU6Jj020187;
        Thu, 7 Jul 2022 10:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=UfB0AtssFWbge7uYqusm8PWaR1RC5vwgwqzBrLQ/xmY=;
 b=ANNggG/rnq+6UXUbnyk6mJSwr/wnsbpwM3wDey9u06OW5b5Px/IDQS4ApK8HT4InSA9m
 hmD5pxqBKaLweLuj2vmiBjX0+xEJrkpYCPSgm3nK2Mjtw2fpvYUWFXmUNzEjSLgVQAdH
 BB8gEfinnka0eXZPIywEtfmOzlESxnQxbBLfuvuFGjznNWjHUCLvjYbvHHgfxMY7DEgJ
 2Gu2ek4FUoPQUX1lvyVdIK8BWPO4keRu4R8LNQAMUxuBMhfYAiMljzOhtayY6dDdlSOd
 Eh5TrkK769BK4vZllLbvP03jzk6OYXsP2XTH0b7Jord4xEWy04DN87t/IT1AD69Z2Vxk ag== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3h4ucmjr6f-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 07 Jul 2022 10:10:48 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 16:10:44 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 7 Jul 2022 16:10:44 +0100
Received: from sbinding-cirrus-dsktp.ad.cirrus.com (NEWBNB750653-PC.ad.cirrus.com [198.90.238.195])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 34C6E2A9;
        Thu,  7 Jul 2022 15:10:44 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
CC:     <linux-acpi@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v6 2/2] ASoC: cs35l41: Read System Name from ACPI _SUB to identify firmware
Date:   Thu, 7 Jul 2022 16:10:37 +0100
Message-ID: <20220707151037.3901050-3-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707151037.3901050-1-sbinding@opensource.cirrus.com>
References: <20220707151037.3901050-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: sPX_SsKzF5jd2GxbOz3BpVz2-DyFvmNC
X-Proofpoint-ORIG-GUID: sPX_SsKzF5jd2GxbOz3BpVz2-DyFvmNC
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When loading firmware, wm_adsp uses a number of parameters to
determine the path of the firmware and tuning files to load.
One of these parameters is system_name.
Add support in cs35l41 to read this system name from the ACPI
_SUB ID in order to uniquely identify the firmware and tuning
mapped to a particular system.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l41.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 8766e19d85f1..c223d83e02cf 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -6,6 +6,7 @@
 //
 // Author: David Rhodes <david.rhodes@cirrus.com>
 
+#include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -1142,6 +1143,30 @@ static int cs35l41_dsp_init(struct cs35l41_private *cs35l41)
 	return ret;
 }
 
+static int cs35l41_acpi_get_name(struct cs35l41_private *cs35l41)
+{
+	acpi_handle handle = ACPI_HANDLE(cs35l41->dev);
+	const char *sub;
+
+	/* If there is no ACPI_HANDLE, there is no ACPI for this system, return 0 */
+	if (!handle)
+		return 0;
+
+	sub = acpi_get_subsystem_id(handle);
+	if (IS_ERR(sub)) {
+		/* If bad ACPI, return 0 and fallback to legacy firmware path, otherwise fail */
+		if (PTR_ERR(sub) == -ENODATA)
+			return 0;
+		else
+			return PTR_ERR(sub);
+	}
+
+	cs35l41->dsp.system_name = sub;
+	dev_dbg(cs35l41->dev, "Subsystem ID: %s\n", cs35l41->dsp.system_name);
+
+	return 0;
+}
+
 int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *hw_cfg)
 {
 	u32 regid, reg_revid, i, mtl_revid, int_status, chipid_match;
@@ -1270,6 +1295,10 @@ int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *
 		goto err;
 	}
 
+	ret = cs35l41_acpi_get_name(cs35l41);
+	if (ret < 0)
+		goto err;
+
 	ret = cs35l41_dsp_init(cs35l41);
 	if (ret < 0)
 		goto err;
@@ -1316,6 +1345,7 @@ void cs35l41_remove(struct cs35l41_private *cs35l41)
 	pm_runtime_disable(cs35l41->dev);
 
 	regmap_write(cs35l41->regmap, CS35L41_IRQ1_MASK1, 0xFFFFFFFF);
+	kfree(cs35l41->dsp.system_name);
 	wm_adsp2_remove(&cs35l41->dsp);
 	cs35l41_safe_reset(cs35l41->regmap, cs35l41->hw_cfg.bst_type);
 
-- 
2.25.1

