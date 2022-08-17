Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07998596E66
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238933AbiHQMYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbiHQMYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:24:03 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441B62B262
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:24:02 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27H4vLJc010755;
        Wed, 17 Aug 2022 07:23:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=lO393XigoXWuen3e1+IceJwVClmyWkbjIZ9xxN7eD9M=;
 b=DXyyN87Y0mAuH2l4kovn8y2DTV6aCI8HxCMcInIa73X0U7Unp/cDh8XqO33cdHzfrTeE
 wg43yrKne+J+mzl+0Lhub9DBk6Liz+1wP2tlI+wCA+tRcLI7uZhGHNk8u8o4TTHxuhS9
 Asd+eU8z+2/QElScMsaB3BhXHbfaUvp/xhsDRuwG1U3h/alO2+Wvh8ckX3mw5fuS3Z9d
 CwsDYssEOk7DeuSm54bPvCHJRleIxCu/K0Q2jxhThw2gfWWzuqbmNynRAjl24XOnR9gs
 kvwqcQENoVPseQ8lxB7Kpk2ZDQkjlrc9sbb2S7TCKv6QSOsEP491mkedQDQ+ADnawe1l DQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3hx8cpcuec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 07:23:49 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Wed, 17 Aug
 2022 07:23:47 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.9 via Frontend
 Transport; Wed, 17 Aug 2022 07:23:47 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C967BB16;
        Wed, 17 Aug 2022 12:23:47 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 3/5] ASoC: cs42l42: Move cs42l42_supply_names to .c file
Date:   Wed, 17 Aug 2022 13:23:45 +0100
Message-ID: <20220817122347.1356773-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220817122347.1356773-1-rf@opensource.cirrus.com>
References: <20220817122347.1356773-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ec7B2zCY3qquCT20rsfPwX-rRGgaLeyG
X-Proofpoint-GUID: ec7B2zCY3qquCT20rsfPwX-rRGgaLeyG
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The array of supply name strings doesn't need to be in the header file.
Move it to the .c file.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 9 +++++++++
 sound/soc/codecs/cs42l42.h | 8 --------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 9032dd1b9d57..2235c17a0247 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -37,6 +37,14 @@
 #include "cs42l42.h"
 #include "cirrus_legacy.h"
 
+static const char * const cs42l42_supply_names[] = {
+	"VA",
+	"VP",
+	"VCP",
+	"VD_FILT",
+	"VL",
+};
+
 static const struct reg_default cs42l42_reg_defaults[] = {
 	{ CS42L42_FRZ_CTL,			0x00 },
 	{ CS42L42_SRC_CTL,			0x10 },
@@ -2215,6 +2223,7 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
 		return ret;
 	}
 
+	BUILD_BUG_ON(ARRAY_SIZE(cs42l42_supply_names) != ARRAY_SIZE(cs42l42->supplies));
 	for (i = 0; i < ARRAY_SIZE(cs42l42->supplies); i++)
 		cs42l42->supplies[i].supply = cs42l42_supply_names[i];
 
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 1d53e0e050ee..50299c9f283a 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -21,14 +21,6 @@
 #include <sound/jack.h>
 #include <sound/cs42l42.h>
 
-static const char *const cs42l42_supply_names[CS42L42_NUM_SUPPLIES] = {
-	"VA",
-	"VP",
-	"VCP",
-	"VD_FILT",
-	"VL",
-};
-
 struct  cs42l42_private {
 	struct regmap *regmap;
 	struct device *dev;
-- 
2.30.2

