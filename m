Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608CE4B5ED0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 01:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiBOAIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 19:08:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiBOAIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 19:08:36 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AD797BAD;
        Mon, 14 Feb 2022 16:08:26 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21ED8O50007511;
        Mon, 14 Feb 2022 18:08:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=ThW2rdxPPGMSDnk0VDFSlrn59RuYijZAMFSNrBmICJU=;
 b=YF38/BZSPJOVnBXd/IZ6rjuPBMkqi6MWxKe5fwYwCGOV/0SBtEYzcIUzXEMfgwUL7dzb
 NalfRHMfgADNiz5f6Q2NrJvmp1ihxiARmBJJqwzXc/CseX7RW90xl2rVPybrVfwo6TWn
 m05WmMf138VudKVgV6rxzgSRKyLmkd7zWABe6DLbYE4+w8QMgEIcJUpAf0WXSPmk4yEe
 OsOCX/0lLiyo9GrNFPKbIPibAkVEjRxa1Wp4Rt6HkcWAbN5d08BRVuVJD7Nl3AQk8WoW
 yHCx4yNvXs6Yd7B2rgfXzCpXLiRT8cK8Ck+ih0MEtusFmjN7z1YOnPJmbnzT8k//R5Ya rA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3e7qq18nh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 14 Feb 2022 18:08:19 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 00:08:17 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Tue, 15 Feb 2022 00:08:17 +0000
Received: from ricardo-lws.crystal.cirrus.com (ricardo-lws.ad.cirrus.com [141.131.206.19])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1BA1BB16;
        Tue, 15 Feb 2022 00:08:15 +0000 (UTC)
From:   Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
CC:     Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
Subject: [PATCH v3 2/3] power: supply: bq25980: Implements POWER_SUPPLY_CHARGE_TYPE_BYPASS
Date:   Mon, 14 Feb 2022 18:07:57 -0600
Message-ID: <20220215000758.803501-3-rriveram@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220215000758.803501-1-rriveram@opensource.cirrus.com>
References: <20220215000758.803501-1-rriveram@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: vbwslcIKQnsgtNm3GOGD70hMUuHiKEsH
X-Proofpoint-GUID: vbwslcIKQnsgtNm3GOGD70hMUuHiKEsH
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch remaps the bypass operation from POWER_SUPPLY_CHARGE_TYPE_FAST
to POWER_SUPPLY_CHARGE_TYPE_BYPASS.

Signed-off-by: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
---
 drivers/power/supply/bq25980_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq25980_charger.c b/drivers/power/supply/bq25980_charger.c
index 0008c229fd9c..296b221a70fd 100644
--- a/drivers/power/supply/bq25980_charger.c
+++ b/drivers/power/supply/bq25980_charger.c
@@ -764,7 +764,7 @@ static int bq25980_get_charger_property(struct power_supply *psy,
 		if (!state.ce)
 			val->intval = POWER_SUPPLY_CHARGE_TYPE_NONE;
 		else if (state.bypass)
-			val->intval = POWER_SUPPLY_CHARGE_TYPE_FAST;
+			val->intval = POWER_SUPPLY_CHARGE_TYPE_BYPASS;
 		else if (!state.bypass)
 			val->intval = POWER_SUPPLY_CHARGE_TYPE_STANDARD;
 		break;
-- 
2.25.1

