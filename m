Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F336B573973
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbiGMO6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236707AbiGMO6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:58:31 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC20419B2;
        Wed, 13 Jul 2022 07:58:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALA4EWdRiXv8ErYcvfTHwWZvqMklUQKx4RWY4JyP2pPWPeBFNUv20QUHmlZwkrq8RWAmCzy5xQx7yhstozG6Zn/lk4BD6bn3O4ynq0WExtLPOLgigqnbp0NkDGJV3XpKHLZr+gGUVVWcaySUIjFwQiBH5HsSCRfM4kj06awcs6TJPcQoSJXlAzT04F0WUSqy7RHUjflmPmICxa8KSPUnMaxrQEa2wz9+Y7fHRwIaYLni5EGOuF6q0z6H/c4PH9yizhkeBIt/ztqUlwpKX/FfuEMpz4wJHQPXWqnkWvlDimjNcgmauSDEj1bZAH//akcu4wujvPiDZTIWb8AF+hwWEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=diQdm2KDwFrNgipgryT/9yJmjcRWjiYaN9Y8qF5NA5o=;
 b=aCWNbOabwld0PBXhgf20ER4e3YhvdRDAnotjP+t71IYXghdXCPee+b7AXrB/E19iPO5krmzA3H48LKGvQ5baLDnpWIky+WNIDg2z34dqe3rOq++OkwonwY3esmSQbL2bF7LRYh4MdVziqgBelNT2jvmTTHxXW16+Jj0eWhDkw0cqP/UPj6DnbCwPLoLudFfLddV+Cr9t2fhvNFde2YkytJ6EF/zfWM5EhBMgiisG21Eq/Dp2nqTSZxMTlhHpSMP75u+4RBYFtar3DDpsmH0TuE1brIIuSZStUyj311Zyolcaat7mpEvMpr8E7mLy99VdvMyc04t5wLB4cQDLEUrIjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diQdm2KDwFrNgipgryT/9yJmjcRWjiYaN9Y8qF5NA5o=;
 b=lfuuNw6BAZUcO5OFzwi7QFkriIJ7ZgH/SdMkXhuRIKe192okH42uzlAGrI7gFcOvwZuu2TgmVmW7NBryafDL4tAUAwinKGwISy9sHI/4w8XbPWJN5OQyYKG4civTG41iJ6HDQ98+c0BBivoL9rD2H0xfQIPUi5AWiX+K9hkajbo=
Received: from DM5PR07CA0051.namprd07.prod.outlook.com (2603:10b6:4:ad::16) by
 DM6PR12MB3210.namprd12.prod.outlook.com (2603:10b6:5:185::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.17; Wed, 13 Jul 2022 14:58:19 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::fb) by DM5PR07CA0051.outlook.office365.com
 (2603:10b6:4:ad::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23 via Frontend
 Transport; Wed, 13 Jul 2022 14:58:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 14:58:19 +0000
Received: from ethanolx1ade-milan-genesis.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 13 Jul 2022 09:58:18 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <bjorn.andersson@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <konrad.dybcio@somainline.org>
CC:     <agross@kernel.org>, <david.brown@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bilbao@vt.edu>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH 4/4] thermal/drivers/qcom: Use array for max num sensors per version
Date:   Wed, 13 Jul 2022 09:57:00 -0500
Message-ID: <20220713145655.3844109-5-carlos.bilbao@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 425109d8-74cd-4397-93e9-08da64e01fc6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3210:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yk1qFl3HLa144NCBLzaUfZaEGQYwBO4jw5uliSNMAzqPz5FzbnwoWRb/33AFdjgO/UnUzuD+qbG+EaeGsVeo5+9m+8QoumUdPBFvmAPkaOua9RCbRZF0znfxKu7H4oIq7XNOq++EhTGDhz/tmub/3qwL6RFW6IcKS3qoVg+AhuMgS+m+3Kd8U+gKjuZt+LI9/dn5LpqPTtq//lDjC9uBPXt6ffonCpeotkZiNRMTpETZ0kreglvy42DpAPJu5Yesk0qJiaiWeLIhUXm6SXxAxlhbRcb6/Fpe81Ij5Ahhe3HiUCYDpJBTC6y27ENnaKmYwGQCuJ3Mi/o+ofiyTWKLJ+LfjLNdE+6IOGEeX6nOfgAokwDrHcGizJC+5t7hTqpS2oRFOVJD2ha3G7LgWz2pFyEwjdZoFqK4DPWMo/o6C5A/H0lxsC/gPurupkJOvKE6Gc1NdPHIQjRMIfvKMQI5RRIIjoMMkZa+jueDoGWqRd1iaiRA2cyjMAooTRdopBYaghpe4E0KWtC10yQJ0sjTVF0HHJnbN5fjpSby0+qioodXK6mWqMZB1XAwT4vzVKVflpuPtvn3N2dHf9Hrl50Lx4DTjUORxniNmlSNk5ZHLXmF9pEtWOjcIZ4n+HB1s0YxdLRP3Lqp8GKdANyMNpngpiXyN3NiX3zffxMAmyaMuPPVaGmhHCqt+2zsMzlwNQ59lWaEY3WLW9xI00qfKUFzf0BycYy2zorWxJQD+Fdt/3ODtX6yirBld3UZs3ijzOeSaSWfbDVjHnRcbIjY+iP4M+pDWkQmXfVPwLAiaUx7+rlxoG2IHC8K5qhIlYVYhrhH/5xhvQOisVfcwnl7Bc5NNdS2j5JbChcT7tLOhKXP2h4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(39860400002)(376002)(36840700001)(46966006)(40470700004)(47076005)(336012)(40460700003)(5660300002)(54906003)(82310400005)(44832011)(186003)(16526019)(426003)(110136005)(36756003)(2616005)(86362001)(316002)(1076003)(2906002)(83380400001)(26005)(8936002)(478600001)(70206006)(7416002)(8676002)(41300700001)(7696005)(6666004)(36860700001)(40480700001)(4326008)(70586007)(81166007)(356005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 14:58:19.3656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 425109d8-74cd-4397-93e9-08da64e01fc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3210
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a constant array MAX_NUM_SENSORS[] for maximum number of sensors per
version (v0.1, v1, v2).

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 drivers/thermal/qcom/tsens-8960.c | 2 +-
 drivers/thermal/qcom/tsens-v0_1.c | 4 ++--
 drivers/thermal/qcom/tsens-v1.c   | 2 +-
 drivers/thermal/qcom/tsens-v2.c   | 2 +-
 drivers/thermal/qcom/tsens.h      | 6 ++++++
 5 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index b41ff164e67a..05db9bf0e2c6 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -263,6 +263,6 @@ static const struct tsens_ops ops_8960 = {
 };
 
 const struct tsens_plat_data data_8960 = {
-	.num_sensors	= 11,
+	.num_sensors	= MAX_NUM_SENSORS[VER_0_1],
 	.ops		= &ops_8960,
 };
diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 6f26fadf4c27..d29046cffc6b 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -324,7 +324,7 @@ static const struct tsens_features tsens_v0_1_feat = {
 	.crit_int	= 0,
 	.adc		= 1,
 	.srot_split	= 1,
-	.max_sensors	= 11,
+	.max_sensors	= MAX_NUM_SENSORS[VER_0_1],
 };
 
 static const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
@@ -374,7 +374,7 @@ static const struct tsens_ops ops_8974 = {
 };
 
 const struct tsens_plat_data data_8974 = {
-	.num_sensors	= 11,
+	.num_sensors	= MAX_NUM_SENSORS[VER_0_1],
 	.ops		= &ops_8974,
 	.feat		= &tsens_v0_1_feat,
 	.fields	= tsens_v0_1_regfields,
diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index 10b595d4f619..2007deb45723 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -149,7 +149,7 @@ static const struct tsens_features tsens_v1_feat = {
 	.crit_int	= 0,
 	.adc		= 1,
 	.srot_split	= 1,
-	.max_sensors	= 11,
+	.max_sensors	= MAX_NUM_SENSORS[VER_1_X],
 };
 
 static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 0a4f2b8fcab6..002809e6a0b5 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -32,7 +32,7 @@ static const struct tsens_features tsens_v2_feat = {
 	.crit_int	= 1,
 	.adc		= 0,
 	.srot_split	= 1,
-	.max_sensors	= 16,
+	.max_sensors	= MAX_NUM_SENSORS[VER_2_X],
 };
 
 static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 2fd94997245b..39645bbe9f95 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -26,6 +26,12 @@ enum tsens_ver {
 	VER_2_X,
 };
 
+static const int MAX_NUM_SENSORS[] = {
+	[VER_0_1] = 11,
+	[VER_1_X] = 11,
+	[VER_2_X] = 16,
+};
+
 /**
  * struct tsens_sensor - data for each sensor connected to the tsens device
  * @priv: tsens device instance that this sensor is connected to
-- 
2.31.1

