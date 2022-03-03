Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1069C4CC3E6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbiCCRcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235415AbiCCRcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:32:07 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3638019E714;
        Thu,  3 Mar 2022 09:31:20 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2234AADr028599;
        Thu, 3 Mar 2022 11:31:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Qv07XFTe4HkWwbJqelMKj1qLuYum+eoKoYrC22mdvX0=;
 b=IylpRQg2raMh5Hu0JEr1GXaK2W2trWRyDI4AaCyYTsWVI2ad6u7GnX0bhOIE1Jz8olig
 A3O28Dx6lI2xWS02sOTtFm8IvOLPV8pjcspbkw8lqUH2G5JkOrhcjYuVf1TPoTfNvGeh
 pa2dIjToxd5maTsQ0gSRoKE44LsN6FpB2ksOEuXxZqLppWvya8mjeXEc+hZeW6uSgGoY
 tw7d4ja9WpIMV59owATX65EZ+FItnGlhtwQJ4ecehBYjGWkOERq0sSbxR3daI0ofKnp6
 Dc+/mO5Szonc34M0+EznXhSeZpbJWO9zxq2WTMLO0GqnBJFo/TpUAWL5eTAkjTsoMLbi fQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ejncq8ybk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Mar 2022 11:31:04 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Mar
 2022 17:31:02 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 3 Mar 2022 17:31:02 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.198])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 97C897C;
        Thu,  3 Mar 2022 17:31:02 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        David Rhodes <drhodes@opensource.cirrus.com>
Subject: [PATCH 01/20] ASoC: cs35l41: Fix GPIO2 configuration
Date:   Thu, 3 Mar 2022 17:30:40 +0000
Message-ID: <20220303173059.269657-2-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303173059.269657-1-tanureal@opensource.cirrus.com>
References: <20220303173059.269657-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: JeKpKn1mwFfiEGOPY8WFpAEMD0cVcIrK
X-Proofpoint-GUID: JeKpKn1mwFfiEGOPY8WFpAEMD0cVcIrK
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Rhodes <drhodes@opensource.cirrus.com>

Fix GPIO2 polarity and direction configuration

Fixes: fe1024d50477b ("ASoC: cs35l41: Combine adjacent register writes")
Signed-off-by: David Rhodes <drhodes@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l41.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 77a017694645..90c91b00288b 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -1035,8 +1035,8 @@ static int cs35l41_irq_gpio_config(struct cs35l41_private *cs35l41)
 
 	regmap_update_bits(cs35l41->regmap, CS35L41_GPIO2_CTRL1,
 			   CS35L41_GPIO_POL_MASK | CS35L41_GPIO_DIR_MASK,
-			   irq_gpio_cfg1->irq_pol_inv << CS35L41_GPIO_POL_SHIFT |
-			   !irq_gpio_cfg1->irq_out_en << CS35L41_GPIO_DIR_SHIFT);
+			   irq_gpio_cfg2->irq_pol_inv << CS35L41_GPIO_POL_SHIFT |
+			   !irq_gpio_cfg2->irq_out_en << CS35L41_GPIO_DIR_SHIFT);
 
 	regmap_update_bits(cs35l41->regmap, CS35L41_GPIO_PAD_CONTROL,
 			   CS35L41_GPIO1_CTRL_MASK | CS35L41_GPIO2_CTRL_MASK,
-- 
2.35.1

