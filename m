Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D719547DEE9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 07:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346538AbhLWGI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 01:08:27 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:53444 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233648AbhLWGIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 01:08:22 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BN3mvTg005509;
        Wed, 22 Dec 2021 22:08:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=2pfTm9eMx8rDFS/G1HRRvMPJRstkV53qxgoEbhf52u0=;
 b=WxAwJ85iB/J3TOT+6Md9N40gFZkSdv8seDkYhn5qI0zIArPWrcH/tKeOi2zKQbv0Lnx8
 ukcI+eGpJWgr8/X/c6HBbMMgyJndqWnvEWFX1HUKJ1QrvSNN7VZyPSTNYpsSg2BcJea/
 L6c8v1ox2FrAAxjeYbuHTqWT5b+C2IWb3436BWV3Dy1j504mLxze93cVFSZhF6bsNgGZ
 4iWjPKjS2z8cypEyRMoKi3GTfBaCWukk7BkPuIweQ8qbTKpufR/1KrXqKzw+FMFn8h90
 mgbl5UrWeF7EY7QIQd/NRc4wP/ZdQZCCtfuki5LRvTFfa0BJcpYcopuhYEtYZ5x3LvA6 BA== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3d3rwxvk1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 22:08:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNcNMgxJnvSr6VFj1RMRRe6fgC6Tjpg0JWjpuLn6mLbCkN9C47an5kSefA1Zv4aHuXD1vGfL3nzN5dTDLDnycmNcZAT2DlumboO2x/CRElG6YBNpq6jabE7PuV/nuzhp/bGy0svwSPdky81aDwkPTFmqsNfCdgTM3PYHqaOTGhV+ZfnIJ+rheJM29n/FI3XAlw49+c6y+1UKHYrnI8s06fmA0T4D36Q0o7XufI26BJ+qJmj8R3gL635a0eOorVJCRh9G9jVqDC4lcQeo3seq4JQQ20+uNLZJ+xxVEAaXwPSnX4JaCtJn9VjzAZDnTfoSqyRJB31W0YtU7TsvH0FpDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pfTm9eMx8rDFS/G1HRRvMPJRstkV53qxgoEbhf52u0=;
 b=lqIqV7XxCn7IajX6jp3J8+iwjAGDzXMLL6PQ/t/YDMJGZ0yH+LfPEFKdGO0Wynse+8BLIh4MMO/Ir4kxd/5vBdvMed40DgH/twvuoRVdoVXED6FiqyII4OsaJH75LxI1h3sgr70wb1mVOHbtriG0kGvKBBNjH8wPk20BfvIRP1igcazgTEBqRTkNn2w1f0Fg/M3jx7ZUYvw/kKXaKXxwA8ahSlKfhWGTqT7P3oSPllvJHE5ErrTqxCz+nBo3HlMsGTxEfkj1ylHqAZXk2PHTJKOKQ0QRVd2Bad4VdtA0TjXL4LQ0ZsxQJ/H1K34kdN117/dwY/rqfONdXNZiyT3z5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pfTm9eMx8rDFS/G1HRRvMPJRstkV53qxgoEbhf52u0=;
 b=2p7tHVFY7X4Vxv23hlWRQM6zaW5kD1mS73Sgjf8GCQ/hz6id/W4tM3eR/Wzos+Q5wyZYf5maovjY4I6nzXiLAOeo7XtT1Kv7EO9y3fdqlhLqpVTHlsfqA+WsP6dcHHzDMi3leGFECZ47Pcms+G8e53fJcAyJlw3WQdywJZnJW7k=
Received: from BN8PR12CA0031.namprd12.prod.outlook.com (2603:10b6:408:60::44)
 by CH2PR07MB6757.namprd07.prod.outlook.com (2603:10b6:610:21::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Thu, 23 Dec
 2021 06:08:11 +0000
Received: from BN8NAM12FT042.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::78) by BN8PR12CA0031.outlook.office365.com
 (2603:10b6:408:60::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.16 via Frontend
 Transport; Thu, 23 Dec 2021 06:08:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT042.mail.protection.outlook.com (10.13.182.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.7 via Frontend Transport; Thu, 23 Dec 2021 06:08:10 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 1BN68AIN018761
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Dec 2021 22:08:11 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Dec 2021 07:07:57 +0100
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 23 Dec 2021 07:07:57 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 23 Dec 2021 07:07:57 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1BN664pb013494;
        Thu, 23 Dec 2021 07:06:36 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1BN664vN013450;
        Thu, 23 Dec 2021 07:06:04 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <a-govindraju@ti.com>
Subject: [PATCH v4 03/15] dt-bindings: phy: cadence-torrent: Rename SSC macros to use generic names
Date:   Thu, 23 Dec 2021 07:01:25 +0100
Message-ID: <20211223060137.9252-4-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20211223060137.9252-1-sjakhade@cadence.com>
References: <20211223060137.9252-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c652750b-2039-4101-8fee-08d9c5da98f5
X-MS-TrafficTypeDiagnostic: CH2PR07MB6757:EE_
X-Microsoft-Antispam-PRVS: <CH2PR07MB67575BB3F8723C292A3C994DC57E9@CH2PR07MB6757.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4wRTqfB1vc3vL57ReK3yumavAEviXWtu9+3dLkicwBlqKhxrCe4azMoNj/p0frpFfKQhtkcphAuzILCcGh7QDMOkVslySUXrAvDwqhKbEZSrZE+h4x+++Xl681Ak0imhNyVf4wN84UMhD/j4+otWAsbdz8Oxfr6SrR3iWF6hRlodKp6r8Kj8Xssz+rsB/T2g+oJ22janf0vwh8f0SuL8W0JmM3tEoDNCrN1AiS5QC+7x/RTCJJ7U1A94K6vQ3AvZMnrzBfZfePYfUI2YmWmJFoaWOfKbDh7hBydBP6rlxIUExhX8JHJGdYZuB9wd137XeTEEXIS8nOy3QqtBmZGh1PcrYi5Gtx0u/b21iUxS9Glk5DkAGlLBaOoIVoR/a/O1jg2Gz490Al/bk0OsI+i3AkmguVhaIx4H5BflLokNjrz3Yv+nyF4kA2x7JWza+NpEtzadCVeganiIH43k4mOjq/grHo86hGVoxW8Pt4sO/KygaRR0dlT3JwCbQHdgTW2Vg2TLr3n8JZIYSjJE53KppfphoFIR4Au3JLCsJd7bnZyL3nyvGefOJrCWIN91iHn+OJvHMBfag7u2Q4W8tB1XnU9q1If7YHAs2ktPdWZy4qJXCyXSPk8rIg35uX/Wk+Fqw2zxIuUhe6nOZcYs6QisTz+wu6v0st+GJKGBgfIcAIKkzo2EPS6ONJtiRWU7O6IORUCrk7dVmFX+844HeiHVIa11ZcidfZOFQRev8ZCh2Y3sm4Zbj4rfwNtzw7HHf8gRchb5hYAP06B7sxp0ZcoxvVM8tdZhxA/8/uA6YffIara5l84Vi18uU0gtFgln23TO
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(46966006)(40470700002)(36840700001)(1076003)(70586007)(5660300002)(508600001)(70206006)(4326008)(7636003)(2616005)(36756003)(356005)(26005)(6666004)(83380400001)(8676002)(186003)(336012)(426003)(8936002)(42186006)(47076005)(54906003)(316002)(86362001)(36860700001)(110136005)(40460700001)(2906002)(82310400004)(41533002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 06:08:10.8002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c652750b-2039-4101-8fee-08d9c5da98f5
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT042.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR07MB6757
X-Proofpoint-ORIG-GUID: bkW7P8M4WwMAtzpcruuQK6xWTrsgf3se
X-Proofpoint-GUID: bkW7P8M4WwMAtzpcruuQK6xWTrsgf3se
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-23_01,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 mlxlogscore=778 spamscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112230034
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename SSC macros to use generic names instead of PHY specific names,
so that they can be used to specify SSC modes for both Torrent and
Sierra. Renaming the macros should not affect the things as these are
not being used in any DTS file yet.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/phy/phy-cadence-torrent.yaml      | 4 ++--
 include/dt-bindings/phy/phy-cadence.h                     | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
index bd9ae11c9994..2fec9e54ad0e 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -202,7 +202,7 @@ examples:
                 #phy-cells = <0>;
                 cdns,phy-type = <PHY_TYPE_PCIE>;
                 cdns,num-lanes = <2>;
-                cdns,ssc-mode = <TORRENT_SERDES_NO_SSC>;
+                cdns,ssc-mode = <CDNS_SERDES_NO_SSC>;
             };
 
             phy@2 {
@@ -211,7 +211,7 @@ examples:
                 #phy-cells = <0>;
                 cdns,phy-type = <PHY_TYPE_SGMII>;
                 cdns,num-lanes = <1>;
-                cdns,ssc-mode = <TORRENT_SERDES_NO_SSC>;
+                cdns,ssc-mode = <CDNS_SERDES_NO_SSC>;
             };
         };
     };
diff --git a/include/dt-bindings/phy/phy-cadence.h b/include/dt-bindings/phy/phy-cadence.h
index 24fdc9e11bd6..d55fe6e6b936 100644
--- a/include/dt-bindings/phy/phy-cadence.h
+++ b/include/dt-bindings/phy/phy-cadence.h
@@ -6,11 +6,11 @@
 #ifndef _DT_BINDINGS_CADENCE_SERDES_H
 #define _DT_BINDINGS_CADENCE_SERDES_H
 
-/* Torrent */
-#define TORRENT_SERDES_NO_SSC		0
-#define TORRENT_SERDES_EXTERNAL_SSC	1
-#define TORRENT_SERDES_INTERNAL_SSC	2
+#define CDNS_SERDES_NO_SSC		0
+#define CDNS_SERDES_EXTERNAL_SSC	1
+#define CDNS_SERDES_INTERNAL_SSC	2
 
+/* Torrent */
 #define CDNS_TORRENT_REFCLK_DRIVER      0
 #define CDNS_TORRENT_DERIVED_REFCLK	1
 #define CDNS_TORRENT_RECEIVED_REFCLK	2
-- 
2.26.1

