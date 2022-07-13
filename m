Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF8E573968
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbiGMO6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236640AbiGMO57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:57:59 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7537E3ED56;
        Wed, 13 Jul 2022 07:57:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WitwXtGDwviL5qwCjyCNhKLWzUsn37z0W9773db55Y0+HuPzq+VtDNRe03jv9aT4SyzgwJf6A0tmKyxLW+qM5Zm1bzQ9MLhCbnWFCnZW5Hn4LSB5amPLg5rqbsIXUNzTMxR3wuKomGxF8nVNuPrR7o+x7Y1Kcaon0Q7Mo1/p8A3LV4YsEAHvaOO+xub49wawgrW3vuKXlJo9X7SXPKsFdxeRl4xnYexb753vQvb+tgni8q6x9Hoif49d1RgSidYCmWr15B2/Mb9VpGoH0qg/VguygZIZglgtVx0Imv3mEvp6C9nzXO/LQ4+yQ0uqCYbYvzaq3hpKrwkkCQLNdrNW0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Es89HGwt+uihZ4zm0WLrkQ4yN5Eo/iXCgmqy3hdJmMc=;
 b=em8azqmFu0TS4rUkIXkoFToR8SpoA5oB+IbIPFz2zHEKeqZ+1tHD8LkALHXxE4BUQamfynHfjsoPWVGF3Qg/g3nQATV5aXw6+fAC2UcDRkCdCYXxFv/dhldCakRp4tSG+imYDQ8JoCIaUostVG1p1B1+4MNOFu+jGIdfWO04YtxqlYwIOcWDJHRq/Lzfu+t9SGeEp+H7jc+on21W2qWUCz9kSLA9s+TW8IYrvnrd723xo6gQIYTaxGzx7UUacW2y0MFqc90I04DaybYP048PXvW3r2wwE33GIMM6cw3/lmj/sSol9WKpo8GRbP56lYY84rGsAYp/hKTLs6WVu5ktsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Es89HGwt+uihZ4zm0WLrkQ4yN5Eo/iXCgmqy3hdJmMc=;
 b=tz+OqteQVJwlHlA73iNWBc8x9vBs+ZIYuTf2PT6ca1LRvGyBjnseb8ToHJqvxzN/QfedXg6w+bQQm5khNq/WfdEIs81N+O9GXJIE19jmgiQiqRPj02HVgIN9J+WYYgttpALYTYmBvXNw9KrAGMiW3ScggUPEvL1YD8DTWSrJUbo=
Received: from DS7PR03CA0024.namprd03.prod.outlook.com (2603:10b6:5:3b8::29)
 by MW4PR12MB5625.namprd12.prod.outlook.com (2603:10b6:303:168::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 14:57:56 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::f3) by DS7PR03CA0024.outlook.office365.com
 (2603:10b6:5:3b8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12 via Frontend
 Transport; Wed, 13 Jul 2022 14:57:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 14:57:56 +0000
Received: from ethanolx1ade-milan-genesis.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 13 Jul 2022 09:57:55 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <bjorn.andersson@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <konrad.dybcio@somainline.org>
CC:     <agross@kernel.org>, <david.brown@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bilbao@vt.edu>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH 2/4] thermal/drivers/qcom: Simplify function code_to_degc()
Date:   Wed, 13 Jul 2022 09:56:56 -0500
Message-ID: <20220713145655.3844109-3-carlos.bilbao@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: b2a09859-e9c9-41d7-2512-08da64e01212
X-MS-TrafficTypeDiagnostic: MW4PR12MB5625:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m30Y1xiU2SgvXJFie4Osi7N0LpHqiGgMASATh/vyMGf+1pt84QcTKl5IiTRyg+FRpkCoA72qD+ZoDSRcx5D0HfHR1kLguWDvyb8RPgJu5h4XwQSB3ln4Jr3IaJ7mPvtGOWgDkfv7LAmgBWVW5omB/2QJmZNW/miVuXCcfsG/lUfiIEXhOpqnirhM5OFWgx3EdewS7uEaRzxqWVVIpWFJCBZaUNrOr/A3LZ6dTNJnX3EuRPDqEHYOaStXQWRiIvITMZ9tT+0LlqCkGLjwo4ze2C7D3xhbfnFObX8Gv3MrKxeH+AN08KvUIMxpm+TC7znHRublCqlB0lS+8WQbzNZBM6i9cFUO2AwU3HMQ56tGMG7IwHAc9C4UtKga59l5BFdKYiEZFyV99bV5YKgSTUfRz5kpNw/M8IDAH0sAGe313HkBTmMZVZPA2N4/by9hGKlcJYUr79CNVGuzPJftV/OjUfUhlFKVNL5Iagk4Vz1r7W/ttgXxchz0GV6RF5ZUI1obpNo918SgPzeKEBY1142NSrKSQ2WAdsaJcEwS5slXwHmGbgsWZurNk5e6FXszkJYubbB4iZLu5kXdoWaJuW/NiUBrt+5sMQxYI6Ktv1wn7Cg7cfvVWFS/SB9HNSHONnHRv88Fr4AHZV0gRWoDic7mpnHuBmYXc0yqETJsrDB4kD2inN1YaYB68IMurwi7y9TAQK0C7fbNwI7vzhC6BQ6nBzqsveIvsE0KE54tGTReCvYSL/WP8idw8u4uiby7eF9agZhG0i2ybLIR8/6GFPKygjuyA3605/SrpodUk0694+590ZijVBnMJk0D8qrQ87N12l2j+vjEYmNJI+RDfjP1If5LTNmWh+yPZmtV4byx+y4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(39860400002)(346002)(46966006)(36840700001)(40470700004)(26005)(70206006)(1076003)(186003)(4326008)(8676002)(7696005)(5660300002)(70586007)(82310400005)(7416002)(356005)(8936002)(316002)(2616005)(478600001)(40460700003)(16526019)(336012)(83380400001)(81166007)(2906002)(110136005)(36860700001)(44832011)(41300700001)(36756003)(40480700001)(82740400003)(426003)(86362001)(54906003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 14:57:56.3883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a09859-e9c9-41d7-2512-08da64e01212
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5625
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify code_to_degc() so we don't need a third variable.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 drivers/thermal/qcom/tsens-common.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 528df8801254..492b0e9cc2a2 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -66,21 +66,18 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
 
 static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
 {
-	int degc, num, den;
+	int num, den;
 
 	num = (adc_code * SLOPE_FACTOR) - s->offset;
 	den = s->slope;
 
+	if (!num)
+		return 0;
+
 	if (num > 0)
-		degc = num + (den / 2);
-	else if (num < 0)
-		degc = num - (den / 2);
+		return (num + (den / 2)) / den;
 	else
-		degc = num;
-
-	degc /= den;
-
-	return degc;
+		return (num - (den / 2)) / den;
 }
 
 int get_temp_tsens_valid(struct tsens_priv *priv, int i, int *temp)
-- 
2.31.1

