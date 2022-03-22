Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7956D4E42B2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238422AbiCVPUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiCVPUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:20:22 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8EA5AEEE;
        Tue, 22 Mar 2022 08:18:53 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22MCnUfC013136;
        Tue, 22 Mar 2022 10:18:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=pAESqVmG+wUGs5ZQth8dL+0iG0WS7AgiO/N1TkpwKJY=;
 b=gOaYQoDFwPILbkgtTbhlhvMTKEYaRYKm4c69yC1ULmyOMrYmL7+LQSCdTQQo4WwI5TXg
 IQH/ew5aoRQk8PRz8OPShuW6i5jhUtL3D7Y5knc4dZfA9RGbrwSE1FhFyD3p/2nEX9YI
 huPMub9hDupsdM3YGCHPQuBntrPKZu84yHf99Hd6xdmRgozzpuUC2+Ffia1T0utKAVoc
 iSj70zpNp9QGgkFvVSLIu7cnICStEIW6y5zLpkWPZC2ydTZBZ7oKCLeKAPDcJ0QUyqLT
 CM+0ncDujKImrVOOyq4gO+k/PZkDkuh4YMzoe2UaOZG5BDZPRFkBG/Sf7zM4YALQG/y5 7A== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ewbknc0jc-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 22 Mar 2022 10:18:39 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Mar
 2022 15:18:34 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Tue, 22 Mar 2022 15:18:34 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.125])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C41C8B1A;
        Tue, 22 Mar 2022 15:18:33 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v5 09/16] ALSA: cs35l41: Enable Internal Boost in shared lib
Date:   Tue, 22 Mar 2022 15:18:12 +0000
Message-ID: <20220322151819.4299-10-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322151819.4299-1-tanureal@opensource.cirrus.com>
References: <20220322151819.4299-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 2jAyLTn1s1GhbXB1D83b_Csb6j4TehUF
X-Proofpoint-GUID: 2jAyLTn1s1GhbXB1D83b_Csb6j4TehUF
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Internal Boost enable is the default option from reset, but with
external boost support, internal boost must be disabled.
Add the enable of internal boost in cs35l41_boost_config to
centralize the internal boost configuration.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l41-lib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index eeeaeaa0db82..03039d8488b9 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -1036,6 +1036,9 @@ int cs35l41_boost_config(struct device *dev, struct regmap *regmap, int boost_in
 		return ret;
 	}
 
+	regmap_update_bits(regmap, CS35L41_PWR_CTRL2, CS35L41_BST_EN_MASK,
+			   CS35L41_BST_EN_DEFAULT << CS35L41_BST_EN_SHIFT);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(cs35l41_boost_config);
-- 
2.35.1

