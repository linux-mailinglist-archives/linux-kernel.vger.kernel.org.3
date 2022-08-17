Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79221596E62
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239412AbiHQMYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbiHQMYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:24:03 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A22474E8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:24:02 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HBro3S026619;
        Wed, 17 Aug 2022 07:23:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=KbIaOF8/xfmF6NFGZtHHR2xoP917ye6MKAgaY49pSnU=;
 b=TAuPMQeQXRWS3CU3TTnMznrRvR8T5y1SJLFOZfEspOdi6ZRC9i/yHL47M13S7ZYjzdai
 DkYoj67JsdGjOGnLvREEufnf5FJrD2kALhkhbWni9YL1Zt12SFyWIkO8u1kIGhtoCWj7
 T0SJlkoGGzut79f9+QAFbp0FjWzacIKjr40FeQTnY3vA1X7wWBMuzaiDY2nMORDcdUDp
 QUvGCYBdnDfTtiDMXsboxOCNt4QOWMvaePhPeNGdrYZiSYWrW14TJDwY/zSKN/gnyhas
 wuGPQSZQ9seXOr3WC8+Vsf/XtrddR+BkdwRD486h92tehCROnS8PJKxe8YauIKY8yStP 2g== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3hx8cpcueb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 07:23:49 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Wed, 17 Aug
 2022 07:23:47 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.9 via Frontend
 Transport; Wed, 17 Aug 2022 07:23:47 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id ABBEA459;
        Wed, 17 Aug 2022 12:23:47 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 1/5] ASoC: cs42l42: Don't include kernel.h
Date:   Wed, 17 Aug 2022 13:23:43 +0100
Message-ID: <20220817122347.1356773-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220817122347.1356773-1-rf@opensource.cirrus.com>
References: <20220817122347.1356773-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Q3uIgX7Sf2Dkq1TaQ0E45CcH7annyIHX
X-Proofpoint-GUID: Q3uIgX7Sf2Dkq1TaQ0E45CcH7annyIHX
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

kernel.h includes a lot of other headers that we don't need.
Replace with an include of types.h.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index daafd4251ce6..9032dd1b9d57 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -12,7 +12,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/version.h>
-#include <linux/kernel.h>
+#include <linux/types.h>
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
-- 
2.30.2

