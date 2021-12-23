Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB7A47DF0B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 07:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346594AbhLWGZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 01:25:30 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:22236 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232444AbhLWGZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 01:25:28 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BMN45kk002320;
        Wed, 22 Dec 2021 22:25:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=qyS93nZeZwh/+rMOjOefrWbwgrOpM62DuJyl0NmpwuY=;
 b=igxHf00S8Ar7h4iBXiFDIHLgzUiA3QCc0RvtP+fM4yKzoSGLZw7x19saNPEH1WTRs4Sa
 FyfRx2qk3z531EKA/zJ4WydKCu3RPGkUAskY0P2ckszSU/rx4ZUa6T7Hn4q4/BcaJ2JA
 IveBzA6xGcdKYJjnu6pprFUHZeQBpiAufxxsRJAQDakPJWqhtXMWkXwjkBTaZ7cRyyW3
 pvZ+sVrlMrbRs9OwiyImxrBM+co41i9t+29IXQB+M9iqAbV7eWFfDOfKbrO4X+gHQclr
 e7+En1TyH4w/MX74PR9dmncwh6sHwMCmgOnPL5khbyiN7cOzTsqXGop9F/+MiodhnXX9 2g== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3d411ru6fn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 22:25:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBf4SVfm9Lhro2Sx/JXlxFmxB+maHD5jVU8vBkbbTYOKE6GeAvHickR8IhaCAKBe1TY+LY/bFaLoQj3ftTT/ke2aAHahDMqGLdynOZif2ZNZbP4MKW2T5QswwNcEL5quxK/033glCdreW/xpeHbSXYs2YOYjVJ5oKjdhfwPyJtWrodiRVXz9Q882p4neqv3pIdZSvbmjuMprH3zFUTdES8YyTBU3DupXYAjHpXshzf1nlhwzUuxsG9CKZXs6MGZVr8MNAeD+39s1xYUFE9CNtdpLj+Hc7/uoUKI4xHmnhw1hWnwIS2hhdOw2D1qMjvOJZc6QHjbAzNlQvA+5fD1Ayg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyS93nZeZwh/+rMOjOefrWbwgrOpM62DuJyl0NmpwuY=;
 b=QcM0yeh3BUpr3SYAMfnrgE2CfXTeg/fx06v0tSeN0k1iU+NX4GkWoMZME/3Om7hYst9+PhkNdfpY/gLcekW9ayHv5DgMvOEv5wGr1DAAH/Y2PEI7DbiYYHzWUBTHKYF+A+UtafYNArlHetxxtnqpL4lqIc5P06uEYxhZOhad61xMxEIXzuS9Sz66Vam3uPLV80RSwi+V5D/uTEC1ItKGRCeqIDUuR2t4ZIF9iyYuk5AX5C+YRGAT/X/hSQugEpbez21lpp85RmKUH+BErb+tyn+5OIVE5v75Qcles8/9ChhzMoov3ALmpeWbQKVS486EAwFJwI3hyZWk2NpBjC4U4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyS93nZeZwh/+rMOjOefrWbwgrOpM62DuJyl0NmpwuY=;
 b=Azz0AeKS9zGX7coo5yRrTsih24E7zrhk1nGbXbxpZy6tunEj2+msuMx9/Iqld34Rbe2es1LU6Yq5rg8f3emmCkqy//5C1dEOPUdsV3FWo1rY41hnMIZQ9u8IycRU0bBIh2UPigq3GwzEoK1AMRgfjMoehvw3bcysIAaauIGmlrA=
Received: from CO2PR18CA0053.namprd18.prod.outlook.com (2603:10b6:104:2::21)
 by SA1PR07MB9118.namprd07.prod.outlook.com (2603:10b6:806:1f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 23 Dec
 2021 06:25:14 +0000
Received: from MW2NAM12FT013.eop-nam12.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::ca) by CO2PR18CA0053.outlook.office365.com
 (2603:10b6:104:2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19 via Frontend
 Transport; Thu, 23 Dec 2021 06:25:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 MW2NAM12FT013.mail.protection.outlook.com (10.13.180.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.7 via Frontend Transport; Thu, 23 Dec 2021 06:25:14 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 1BN6PE35023325
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Dec 2021 22:25:15 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Dec 2021 07:25:13 +0100
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 23 Dec 2021 07:25:00 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 23 Dec 2021 07:25:00 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1BN6NOBe021873;
        Thu, 23 Dec 2021 07:23:56 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1BN6NOc1021872;
        Thu, 23 Dec 2021 07:23:24 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <a-govindraju@ti.com>
Subject: [PATCH v4 14/15] dt-bindings: phy: cadence-sierra: Add clock ID for derived reference clock
Date:   Thu, 23 Dec 2021 07:01:36 +0100
Message-ID: <20211223060137.9252-15-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20211223060137.9252-1-sjakhade@cadence.com>
References: <20211223060137.9252-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0271cbeb-e662-4dfd-de2f-08d9c5dcfafd
X-MS-TrafficTypeDiagnostic: SA1PR07MB9118:EE_
X-Microsoft-Antispam-PRVS: <SA1PR07MB9118CA7212CC5E74C6C4DCAAC57E9@SA1PR07MB9118.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z+mj6TWbscp9OM4AEHCsHZF1Qyvfd0JMGGNR3AlpVdv0ibTJF4rsR6KOqrTRE0l+awXz2bWmFpw9i7obQr84ZUQsFYtJCqZCR6Yi58LPdXOkjZCC0FPXGclhAiJP5/RyK9K719aTWMDqGM3YvclkpaqG3+lA29reHNSIrQYH3cmJbT0UEWXy13JFFDFHVvZDrMbfj78lUgrUw2EXboftwbjkiBQh/vW5rjfEEE8vASQY6Gmcs941wqaw2A+fKN2TiaCHy0myyEGn3vkCGq0IV4Zu9t9MuxyP4s4Ug3bEWpZQRBart10MX3/Ysa6bDVzL5k5fzyk9sXY7J9Guu4YLIFE5ugGEdH33/M2YnzwB6zOTLw4hInQ8BTzqv/q+0OmFLkMGR87gHJxU6tPXeMNLqVXNL+ww3e/WHencYaE0as8iGBZHEMJSbihEcPEHpYmlqeM0LyjV+iRyY49Ik6VllWGJjMNFIm3g0ZHkdpFuFGQe2tpCLItcTqc+rL6Ds/rydWnR80V0tAPF7gOcLrVaCF5u61mp9Sq/0z6dO6rKB+PsFlyebhJtxTCl6B4+IhtV3uwSR4fxtCID4vb8KCW3WwetS0B9o8jYmTTGGG1w+NuNbGu4KG451JofzUiGEwyhTupkiPiCK1+WWbrzmlhqfDAzXGatDdT8C/+fOkqm5x45YH2OPqaVQ2U+uKlr/wSLdP7+SDAplPj13o+9nrKYEHGWA651YfqBO95TM9gPWm4kQynLXPH9eEONAPt9UAMB2O+wVqtxBBxEie6wjGH2sUhVmjzkj3k2Npow/kiV7BI=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(46966006)(36840700001)(40470700002)(70206006)(426003)(2616005)(70586007)(2906002)(8936002)(5660300002)(36860700001)(508600001)(8676002)(36756003)(110136005)(54906003)(26005)(336012)(1076003)(356005)(6666004)(7636003)(82310400004)(47076005)(316002)(42186006)(4326008)(186003)(86362001)(40460700001)(4744005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 06:25:14.3585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0271cbeb-e662-4dfd-de2f-08d9c5dcfafd
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT013.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR07MB9118
X-Proofpoint-ORIG-GUID: 876iRbzdvk8d407CIovl6-aOHy9TPP5b
X-Proofpoint-GUID: 876iRbzdvk8d407CIovl6-aOHy9TPP5b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-23_01,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 spamscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112230035
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock ID for Sierra derived reference clock.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/phy/phy-cadence.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/phy/phy-cadence.h b/include/dt-bindings/phy/phy-cadence.h
index d55fe6e6b936..0671991208fc 100644
--- a/include/dt-bindings/phy/phy-cadence.h
+++ b/include/dt-bindings/phy/phy-cadence.h
@@ -18,5 +18,6 @@
 /* Sierra */
 #define CDNS_SIERRA_PLL_CMNLC		0
 #define CDNS_SIERRA_PLL_CMNLC1		1
+#define CDNS_SIERRA_DERIVED_REFCLK	2
 
 #endif /* _DT_BINDINGS_CADENCE_SERDES_H */
-- 
2.26.1

