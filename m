Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B8C47DEE1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 07:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346490AbhLWGFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 01:05:15 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:29670 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346322AbhLWGFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 01:05:13 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BN4Isld005574;
        Wed, 22 Dec 2021 22:05:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=TPcgxzMf0ZBvtJz/tlHuf2xI84b4LiRt2eVmxt46vOY=;
 b=nQY6aEZ1h9pI5tbSbTG/7QPg9GmQ3VSK3ar1Cb/qlkPPcrhhM3cZZRHEmjVslDUqcyfH
 TcKjVmGGFSdH5PDWnN561l4m4GIUouiwDAW33FETyjdRWYZ8Rn3I9zCYBVMaSA9uCIEU
 235u9lUY6VT8/+qJJAC+Dnv/Hqj9TBgo1gJcA5kCgBUYCZ85A7wbGDUlYDsDMr3cr7xs
 wxzjeK6YzktFkXBZHW8ym1Y0nXnmk47SDXmBG8plvRgcNGEoiAAxJxXthn5WulzY1iyZ
 fVyerRujOLTgPYZ8BM/dHlXl4aAdz8Hlisd6U1NZ68intImrVrFw01eqEkOiHZDxYOzm MQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3d3rwxvjqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 22:05:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oq6g/dKoW33jOTkcY3JN1pTFvr4spde42JffCmgjJdYcWeH/klQ5uw5Y0qwRDopcEcqq5cguyiNXED4pIB1Zeb3rM3yYEn+/OkUynQJZJcwoQQ4p1ylORX5BWnw3A0esy9EuN0APUnp/tXcs+4A0L/Tlmv4GqahSh4SMtv6pAGpYDXsIzcj2XaJqQScp1TON2IAEJTEsNIJgUJa9wbV77lWVmLMw3zGK+yKvsHKq4sJkZ36T1yX1zB7nUQkLwD5W7jnWOois5kcjUlK3LavyKSnEXB5IOQSMrBvLIXuhXf7sKt08bn0tj/PmG3t2rEyvCytJ6Lc62/y8+t1ht+5gbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPcgxzMf0ZBvtJz/tlHuf2xI84b4LiRt2eVmxt46vOY=;
 b=OC5Aj5yuAhJXSAk6JhUAuwiKzSDXwMKs/PiVyEKYi1Kfr8Pa6oLxw7vicVWQIcIJaOOFcYsnUgucWAjMzGa8y3VGQsYiOMQinCKaIPLi+uNMIyqV/Z4XZfRIqMGPXekxsQ1V5w8RAe0QcvTd0JUuU0WCVVuo3Nq+8HB0/KCiW13WlY/0fEkoRkX1qI4mb/kw7KLkPJGdf0YKcEfTBQbefpbgAFO/3Netj3HgCuD6AJXAmMuQu+fcIhgjpmBszz+3AtQNGbQVReK4u7AtUpO/vmg8w1AnerP0+59uka5Sp+0XGPg32niwkBE9nsscJ1CpuV2ltfpUGUlwdy1gGBa2IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPcgxzMf0ZBvtJz/tlHuf2xI84b4LiRt2eVmxt46vOY=;
 b=w8mj2pNTZTQ2y2Xeodly9odAHJCwlvGN+wwbYapHKp2FBCkjDZr0fEeX7p8SpT4fxNup0x47pa2X3qDTQQUxAbpE0G5WedcN/DDNSOy1OWr9WijTHP0wyld/BSbCYVsACzbNjx6rraD/gXqqn4fBWnbt16sNcZnwZuNkhTb8clA=
Received: from DM5PR2201CA0010.namprd22.prod.outlook.com (2603:10b6:4:14::20)
 by DM5PR07MB3451.namprd07.prod.outlook.com (2603:10b6:4:6c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 23 Dec
 2021 06:04:57 +0000
Received: from DM6NAM12FT018.eop-nam12.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::7d) by DM5PR2201CA0010.outlook.office365.com
 (2603:10b6:4:14::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19 via Frontend
 Transport; Thu, 23 Dec 2021 06:04:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 DM6NAM12FT018.mail.protection.outlook.com (10.13.179.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.7 via Frontend Transport; Thu, 23 Dec 2021 06:04:57 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 1BN64uUm024878
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 22 Dec 2021 22:04:57 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Dec 2021 07:04:56 +0100
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 23 Dec 2021 07:04:43 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 23 Dec 2021 07:04:43 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1BN637v5009953;
        Thu, 23 Dec 2021 07:03:39 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1BN637GX009951;
        Thu, 23 Dec 2021 07:03:07 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <a-govindraju@ti.com>
Subject: [PATCH v4 01/15] phy: cadence: Sierra: Use of_device_get_match_data() to get driver data
Date:   Thu, 23 Dec 2021 07:01:23 +0100
Message-ID: <20211223060137.9252-2-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20211223060137.9252-1-sjakhade@cadence.com>
References: <20211223060137.9252-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d11bd81-dee1-42bd-5325-08d9c5da2587
X-MS-TrafficTypeDiagnostic: DM5PR07MB3451:EE_
X-Microsoft-Antispam-PRVS: <DM5PR07MB3451D7C7F2A62837BC0B21A6C57E9@DM5PR07MB3451.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:311;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HG4PC8lv1O3HAH0PSZ14q7oU4M3ZsDG1vSdT03xPgHTLHU+d5C4g/v3wy1IrWVrMxi5Rb4ZqM6YaGhKOc6dru5lUXOKIRAaA6bMvn6LPgTaT469DWFDzlCW0f9AroDXcoZXjF/V5q/fCK0t6cyU/ZjiKMm1fabRegcAdGlZo15hUPpHuvbTNDtSztrg02TwefCXkcHyc53Ui7Y9qlr7gaKZ0PNjUDsFpgJMzTnkKmRVIPghvxG2cesP/VS4vpvJWCmIkV0co60X5lYYylEZAXvhx8LU7sE8bLKf8JrgtuJBCqxLo09EecdnEZ8Rmg240bizL0qSrj0sIm4mdwciVr3KaApJP7vjZgup/PcZ1R5xv7kpBI88hVKphQU3XtKUOTD3WzNQnjkgVI6aEvvxDX3lIlwRs5n243fRDAr4WeDU7U4VGKdrxzoqOwlXmeYYZihALiJIn53zSFhe0LrXRb7rRtmIgWFXlTdrw0ITdj0TS887gfeEvnWjisb2q38hdivf3o3f6uG+dQJQ6jhIiivWOYLfPOE+QabKqFnumDz3Z91kDJK+4Z+EKLfItgIui67xKo2HstxUxBKSsv1JH0mYWMeg47zaT2+vn86cQWRB7ruQncd4pd7+aiwmF47lom08woa2FpYM6W8B8UTFfD2yJZWKR/K8HpjW5z8HirqFj6GGmKyNe/2D+ZhesMGt8OmGdUXDKUCccVkER6kZoQSwawMUkWJzTr2gbHtO2n47TB7km5L1TIkN6PgsEF6t09yW1hFxJ1jZwbN1cchLmuAOjJsclv1rt+PpbaCRNpbr+2NDbGfrLMFAJ4ShieolnsXOtXp4qo74BQ1JCOYuuuw==
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(36092001)(46966006)(40470700002)(36840700001)(4326008)(36860700001)(426003)(6666004)(2616005)(336012)(110136005)(1076003)(40460700001)(42186006)(82310400004)(36756003)(26005)(86362001)(54906003)(316002)(186003)(81166007)(356005)(83380400001)(2906002)(508600001)(8676002)(8936002)(5660300002)(70206006)(70586007)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 06:04:57.1710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d11bd81-dee1-42bd-5325-08d9c5da2587
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT018.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3451
X-Proofpoint-ORIG-GUID: 7i2eG9dk7hC7xi40plOCvY69xKOOdvXg
X-Proofpoint-GUID: 7i2eG9dk7hC7xi40plOCvY69xKOOdvXg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-23_01,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112230034
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of_device_get_match_data() to get driver data instead of boilerplate
code.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index e93818e3991f..54d1c63932ac 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -253,7 +253,7 @@ struct cdns_regmap_cdb_context {
 struct cdns_sierra_phy {
 	struct device *dev;
 	struct regmap *regmap;
-	struct cdns_sierra_data *init_data;
+	const struct cdns_sierra_data *init_data;
 	struct cdns_sierra_inst phys[SIERRA_MAX_LANES];
 	struct reset_control *phy_rst;
 	struct reset_control *apb_rst;
@@ -595,8 +595,6 @@ static int cdns_sierra_get_optional(struct cdns_sierra_inst *inst,
 	return 0;
 }
 
-static const struct of_device_id cdns_sierra_id_table[];
-
 static struct regmap *cdns_regmap_init(struct device *dev, void __iomem *base,
 				       u32 block_offset, u8 reg_offset_shift,
 				       const struct regmap_config *config)
@@ -829,8 +827,7 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 	struct cdns_sierra_phy *sp;
 	struct phy_provider *phy_provider;
 	struct device *dev = &pdev->dev;
-	const struct of_device_id *match;
-	struct cdns_sierra_data *data;
+	const struct cdns_sierra_data *data;
 	unsigned int id_value;
 	int i, ret, node = 0;
 	void __iomem *base;
@@ -840,12 +837,10 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	/* Get init data for this PHY */
-	match = of_match_device(cdns_sierra_id_table, dev);
-	if (!match)
+	data = of_device_get_match_data(dev);
+	if (!data)
 		return -EINVAL;
 
-	data = (struct cdns_sierra_data *)match->data;
-
 	sp = devm_kzalloc(dev, sizeof(*sp), GFP_KERNEL);
 	if (!sp)
 		return -ENOMEM;
-- 
2.26.1

