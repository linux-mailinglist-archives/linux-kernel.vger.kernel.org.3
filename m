Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67D9573967
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236632AbiGMO6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236636AbiGMO57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:57:59 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126663E768;
        Wed, 13 Jul 2022 07:57:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0Eix/FC8mhhlcZzd0xCypKPaV3jj4DsOwYQdM4j0pwZpZezeUXwI1aZrD/Dc/rQv9mIha0G6QyqEbe1YsFK683de2mPw47sz4YU6zZuQVLsAOrHVqEHm+guIdh9DAr7BDTgi2+p02a9Cq5aXQ/sfe8dGTZGE1TdBnemdvGqWfYXcE9XEn0ASOwgKGT2AyOsO5InvaiF7BmBVsj+BlPPFpTZipv2exkcnH4KE3xZdVZy263tm+ndn+YGWYzyEskwM1HAsgzR7Wni/CvRiTY2iXp2v+Tw7s2dF+DM8AR0PF99MAQkSjyfBQCOJGCCJf0bLc+kECSS/5OyjgW8zPnbDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++kOoW67RSqz7nqztfDjATV3bfaRnMfsB2BuChyA0P8=;
 b=MN997RxIisMcFj0fXbODemwnAnPGe7k01SVypGrO/JvIeuk9Qe/EoLlM4ye5ITt3H5EOl9jHbzpS46oxs2qKuHB7chikOvFOowL7nAGpROm2cgzTncGiRUxRuAnRs9NAxuDFR698cCZkGj7GJYfOzpcTSLllfo08DT5Vs8FlFMkz6Tn1tHuR1Is5QVnxCMqHx4u+9FwS3g4Yo5CJM8fssGYCcISTSqdTmbdEXLGNMfwBikGYPLn99Znu9MDdqRZlSKJHgGW9e5u15sTnE72PM/+W7XVDYlmbrN9Brh7E6GLLScZ720sUensgZTwjbAEX6s3d/2ZD7JYiMNXpZ2WaQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++kOoW67RSqz7nqztfDjATV3bfaRnMfsB2BuChyA0P8=;
 b=B+QfpeocPXliZt/wSqm4CXsjKgkXNgZe6bROikPrgqCLenfAW/ovDNY6rdOFkOmKNG4/wu9nf08MoRe6axecdqWIOlGmBPHkGQ+nSnrDp/pq5HxoDbMMB9gcex3WvybW0d14ukCYDi5NGH4BnMMlhlYGLzbIEBRE58vHklgm3y0=
Received: from DS7PR03CA0015.namprd03.prod.outlook.com (2603:10b6:5:3b8::20)
 by DM6PR12MB3722.namprd12.prod.outlook.com (2603:10b6:5:1c3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 14:57:55 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::64) by DS7PR03CA0015.outlook.office365.com
 (2603:10b6:5:3b8::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13 via Frontend
 Transport; Wed, 13 Jul 2022 14:57:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 14:57:55 +0000
Received: from ethanolx1ade-milan-genesis.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 13 Jul 2022 09:57:47 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <bjorn.andersson@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <konrad.dybcio@somainline.org>
CC:     <agross@kernel.org>, <david.brown@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bilbao@vt.edu>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH 1/4] thermal/drivers/qcom: Simplify returns for tsens-8060.c
Date:   Wed, 13 Jul 2022 09:56:54 -0500
Message-ID: <20220713145655.3844109-2-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220713145655.3844109-1-carlos.bilbao@amd.com>
References: <20220713145655.3844109-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9002a393-6a6c-4a0c-0417-08da64e011ae
X-MS-TrafficTypeDiagnostic: DM6PR12MB3722:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Avix2aQXciFNcbEtU+OXI4I28YuCoHvf8JBSc7anBiUA442xjMm1wnoXsoGMJ4h7IyM9vGIZNI04osLz4+X5T7Ovv7vGZDjNrT7S0pmLx7yQZ8LiemSmBRDuVZGG/JNuFHJZJm4o6+/97Mf+fYojHxJOwYscL4isGUXR01v2uahgUyo0j19tjFMaoJq6IMuFD/b8xNr/L2X6QThA+4jT04xICbJlUROj7Vt2K9zddXfmlv5UK0q8T5nWdr0EyzZPmSVaxU7wVc0UXaS5w3/wTggfwBTG/orH9JtV6mnP+rdrDn/gULz3uUEGh6eAGvCvHoRb2J3Gk3XxbwTw1Qt6DhpHjuSMGKlfqZ1/mauW8GCDBSUKX49IySqO1m+ThjSInzcK4LM4gVG6KOYuWfv0cyFF3eNAIYCeDomu/b1PbXigF/DlTCbBcKfcqSfAxDnGPBrHDswJIvTgSe6KypuCoROi6zveXdtOrEqObPUz4VXUnCnbNdX21FYw0mNIvxxt5J9GvSVuJJGfQrfBMLkyi0lE20kuCwyVqdsA4u3B8GjI3n3y6xEtF1vZY3zj+anzLd/ZdzDEDeUSTsV7otD9HLFWdCIvRmsoHy1go7wzipfw/qhbRqOyiyxw3OCUTtu1fLvYVtVEDVaWoCyDPJVXXPClj4ejzrljMJ/aY28i70dUGClpFOpaEGUR5U3KYgcfg+3WFUjgSwPmzN8gjbihVGV/TDpbKeQozxh3nBKAG8ENkSEyDHCAhdigFQu8WSOieTr7GtFNRe/E/jDXmXK4Nn0wNiIVI8nyK1jbuB2uyRo0h0Bw5R6jRt2/HzIrGSoRPoLHrDZhCHXJzrX4Srl3jMBB3h5Er+zLbGZlHOqcStI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(136003)(40470700004)(36840700001)(46966006)(356005)(54906003)(7696005)(81166007)(16526019)(426003)(44832011)(4326008)(47076005)(36756003)(110136005)(70586007)(8676002)(336012)(70206006)(82740400003)(82310400005)(36860700001)(316002)(2616005)(83380400001)(5660300002)(8936002)(1076003)(86362001)(40480700001)(2906002)(41300700001)(7416002)(26005)(478600001)(186003)(6666004)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 14:57:55.7321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9002a393-6a6c-4a0c-0417-08da64e011ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3722
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify return logic in file tsens-8060.c.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 drivers/thermal/qcom/tsens-8960.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 8d9b721dadb6..f4fc8a1c161e 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -75,11 +75,7 @@ static int suspend_8960(struct tsens_priv *priv)
 	else
 		mask = SLP_CLK_ENA_8660 | EN;
 
-	ret = regmap_update_bits(map, CNTL_ADDR, mask, 0);
-	if (ret)
-		return ret;
-
-	return 0;
+	return regmap_update_bits(map, CNTL_ADDR, mask, 0);
 }
 
 static int resume_8960(struct tsens_priv *priv)
@@ -105,11 +101,7 @@ static int resume_8960(struct tsens_priv *priv)
 	if (ret)
 		return ret;
 
-	ret = regmap_write(map, CNTL_ADDR, priv->ctx.control);
-	if (ret)
-		return ret;
-
-	return 0;
+	return regmap_write(map, CNTL_ADDR, priv->ctx.control);
 }
 
 static int enable_8960(struct tsens_priv *priv, int id)
@@ -131,11 +123,7 @@ static int enable_8960(struct tsens_priv *priv, int id)
 	else
 		reg |= mask | SLP_CLK_ENA_8660 | EN;
 
-	ret = regmap_write(priv->tm_map, CNTL_ADDR, reg);
-	if (ret)
-		return ret;
-
-	return 0;
+	return regmap_write(priv->tm_map, CNTL_ADDR, reg);
 }
 
 static void disable_8960(struct tsens_priv *priv)
@@ -205,11 +193,7 @@ static int init_8960(struct tsens_priv *priv)
 		return ret;
 
 	reg_cntl |= EN;
-	ret = regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl);
-	if (ret)
-		return ret;
-
-	return 0;
+	return regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl);
 }
 
 static int calibrate_8960(struct tsens_priv *priv)
-- 
2.31.1

