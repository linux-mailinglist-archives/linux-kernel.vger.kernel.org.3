Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17AC4CD740
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240233AbiCDPJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240167AbiCDPJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:09:19 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E19714076A;
        Fri,  4 Mar 2022 07:08:17 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2248TInJ019088;
        Fri, 4 Mar 2022 09:07:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=cnANgRnNMxthB+Az/dRLrs4+S0q0VAMFd2idCCcyUx8=;
 b=CtkGtS1EYjug6luEtqqzds+hY+1x9G6ewt3kLaEzBFFpulGixXjJCjEc3E4wfUnZ/Yir
 GogwYFuTnbc3ShpZkoVXbhPMDDyZk7tQ3YfdH1bdN6EE9pmb+xqUBGhYo2EYeFhcKcd0
 TUgO5kvg4kWNuGV+yj1nzckdElibV0otbz31cq6hQAQAfDC+l7YewU4QvBo26WjoH+89
 FJC/p30qV/BdHEqhz2TJed2v31Efh73l9RiUV6cFQmuLY2Qa3DZ8yrbwhG36jscOS1wD
 Gz5h9/9ZlXcUV/Z4AXutWoRExIoWJcyWdUZVV7dcWkPKkfTe7k8E1XaT4EQ4ZYaxOzBo 2A== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ek4j3h413-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Mar 2022 09:07:36 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Mar
 2022 15:07:28 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 4 Mar 2022 15:07:28 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.198])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2CB64B1A;
        Fri,  4 Mar 2022 15:07:28 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v2 13/20] sound: cs35l41: Enable Internal Boost in shared lib
Date:   Fri, 4 Mar 2022 15:07:14 +0000
Message-ID: <20220304150721.3802-14-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304150721.3802-1-tanureal@opensource.cirrus.com>
References: <20220304150721.3802-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 16JV_AZfPC2lQoQTxWCR-O8v89lM1aAd
X-Proofpoint-ORIG-GUID: 16JV_AZfPC2lQoQTxWCR-O8v89lM1aAd
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boost enable is the default option from reset,
but with external boost support, internal boost
must be disabled.
Add the enable of boost in cs35l41_boost_config
to centralize the internal boost configuration.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l41-lib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index 3fae34a232cd..34ba163874a6 100644
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

