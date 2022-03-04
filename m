Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266FB4CD72C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240127AbiCDPIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240066AbiCDPI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:08:29 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5C53FDB0;
        Fri,  4 Mar 2022 07:07:38 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2244w2hF013723;
        Fri, 4 Mar 2022 09:07:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=j+aRd3p3l8MH2yYipEWQW5VKVEv+0k9D+Y84o7OTai0=;
 b=b56gBAJoMnwaxBybF08I3OvG6i6PFV26Io0zooU7l90DumQtTZHrtebVoondv7Po1e9c
 49K36yNoK2n3XA/UTB9BaNS5CvfeWXPJPsNnGCJZen+Gbfr5HpEBXSu+xh6nJTvJd9uA
 6rhsuwpJQtqQITmS9bIw+ze8B0us5KsI3Q3N2vQJq42ErxtqynvLHLIJEp0guehaxdDo
 ZKY76AgEd76UjMGiPFaHAc0DRsx/2Xk8jkdJhBWho7m401T/YurJvwM6mNRuZAP1sH+x
 EBCr/CjAMbKFCDipRGwDiHjeRtvqtI+o2X99BjZm612SVLM2oWw/wiSrujHw7JJO0Xhn wQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ek4j3h414-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Mar 2022 09:07:25 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Mar
 2022 15:07:24 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 4 Mar 2022 15:07:24 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.198])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A8C7D7C;
        Fri,  4 Mar 2022 15:07:23 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        David Rhodes <drhodes@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v2 01/20] ASoC: cs35l41: Fix GPIO2 configuration
Date:   Fri, 4 Mar 2022 15:07:02 +0000
Message-ID: <20220304150721.3802-2-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304150721.3802-1-tanureal@opensource.cirrus.com>
References: <20220304150721.3802-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ABmFhauVmGBe644gF1lDSn0je8X6Zu3Y
X-Proofpoint-ORIG-GUID: ABmFhauVmGBe644gF1lDSn0je8X6Zu3Y
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
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
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

