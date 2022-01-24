Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B92497C32
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236766AbiAXJjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:39:49 -0500
Received: from mail-eopbgr130105.outbound.protection.outlook.com ([40.107.13.105]:48577
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234484AbiAXJjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:39:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CU0azdYQiffprp75Sc2JwjyR5iFCrNnzXtZAvfHEjZTO7aCFyhE24YKOaI64J2gOMU8itw9NFSb8JDdNDX+VsZShDVCepVs2gXU5t+xQSUG80yromxvKDTXbH6+RERl2M6cGT6uHENepUakNINp/J8UiVSegQALN6i7tqLXywuhdMCDdmBL1xEpJZZqIqkgnlCAArh4rhNDqhVNbp9VWsxN5N5DOTvrdi+4XpHnPE1u5FEnqWTud6Blen4z2UgyGDcVm5YW3TlbbGYVSSsNAZT1Nb5eZ/tqMj9YVK4xCE8KfwV52CZ1U0pUFd5Sd+AogUZAPpSYg+cqhubDdjpz/6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPf28QEpET5P8MbnP9OHJORM/2XVgfCMG6/0VEDgU1o=;
 b=VWElwSEkfGp7xh1b1uxY2UGjI6tJCvB91j2YETAyfeUodMhi1bxMAEOwTz1dg3ub4mVj3qgkqcfn9zsg+7hYP/ui4jhSErAh4ErNhflTc978RGURMKT5/7qkKWyRd2hBXqllbDigNl2Z01qpipHdeqkmXcQSDwnlPBe9el7niV3oK3fIyKuUaltaekNfW1yfCiOfiupU0/3C6xZvXD+zpchoQhBn8rWUqQiQ5ljx70ovh6qmGYlisuKNIGvSlsKQFZUSjbw7m4vI4JELn4RmHQj2vqnEWpBSJm6h7RqRnaf5k4UfMYsrPqf2iLXOkomkjeR8IRx3a4wza6k2eu1VeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.8.40.112) smtp.rcpttodomain=leica-geosystems.com.cn
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=leica-geosystems.com.cn; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPf28QEpET5P8MbnP9OHJORM/2XVgfCMG6/0VEDgU1o=;
 b=NLrMr2ftulYu+w682JOBQiEmVOCAinhVvMY/vLz7LuRH1lHfDBhFk37pi/ZdVfxrO5wyzN52LMMb8oHxObe79hYyV49BXd1Gdj7to+zUQc59kaJUBNnTrxKAnxMzBv11fGam9+p7aE0HBQeK4JKu/62J/jkVvBVtROnT068rfbc=
Received: from AS9PR06CA0037.eurprd06.prod.outlook.com (2603:10a6:20b:463::21)
 by VI1PR06MB4464.eurprd06.prod.outlook.com (2603:10a6:803:5f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Mon, 24 Jan
 2022 09:39:30 +0000
Received: from VE1EUR02FT049.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:463:cafe::c9) by AS9PR06CA0037.outlook.office365.com
 (2603:10a6:20b:463::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Mon, 24 Jan 2022 09:39:29 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 193.8.40.112)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine
 header.from=leica-geosystems.com.cn;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 leica-geosystems.com.cn discourages use of 193.8.40.112 as permitted sender)
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.112) by
 VE1EUR02FT049.mail.protection.outlook.com (10.152.12.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.7 via Frontend Transport; Mon, 24 Jan 2022 09:39:29 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     qing-wu.li@leica-geosystems.com.cn, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, tomas.melin@vaisala.com,
        andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V1 6/6] dt-bindings: iio: accel: sca3300: Document murata,scl3300
Date:   Mon, 24 Jan 2022 09:39:12 +0000
Message-Id: <20220124093912.2429190-7-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124093912.2429190-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220124093912.2429190-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 15e9b8e4-8056-43a5-7c70-08d9df1d6b49
X-MS-TrafficTypeDiagnostic: VI1PR06MB4464:EE_
X-Microsoft-Antispam-PRVS: <VI1PR06MB44648DB77CEC3C57244C8C85D75E9@VI1PR06MB4464.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OaQ2Dbe1Bf4af3lIosGMImKnIgV7id8wx07cHg9W9EE8ulSLpvxdeSz9K1FrRD6xEihOjqkHXMGwZSfFLpWa32PcFMWRACmM6kQCRIa4MKrW2fG1LhPSQa7T4HDeXaWeuhfxJ1d5M9O7Dbkt41bjbsxRd9l1GmDKiQZWigf3KYpwBK+/1WcvJ/RtakKXgIjLXTbE0VLHk5eYSXWvms/52aW2U18WHQQRbrgne/1YvC7I8EbPekP5gTO48c1R+NQvUFb2SwNGYI64hnqRJN2B+8X1qghFZJy+15/Mud8V6yeGmnpxoi2DqwVAYi3UYziWghFKb5WIJr/lgAKYLGHA2eE2LHeaIktMV2+oHVA+j5esj6RdmSTyO6r3pr2995rbC3OqUrAvPj844lYNx3uyUWcpsYcIE2EGFUDP7x03LsoNbqHAH/XdUodVEoinpC20l/Jywc34slEytIBceiuxg8SOcctW7Q75JHLYXwPkVnipbXoNf9eFvDWJZg0uQqO8SuF6Ej245ZOptJc43jP+/qD5m3KC9qEF0nBEo+GCnAAjEq/LqcDBmjECd5RGic1k//ZAsxvNysZAuuC8vCtopDKDTJ9n7d74NjzMWl9oVwU9TwMO56ygoImyDEzzdyJc/gUAA7Qy05t+MGwYesNuCRst5PyhU4kdK3rVRlP8hnoB7SEg2eqD1l1T5pd9i9HlhoFjzkUgAXd8Y+D1cE8uGe9+QDCWQPFhb0XuIeK4XxBq1D/VbpCrym/2wm/3nUSdW+IJvov/qb3rFnjG2hJ2vnLWP4OS+09DbLsrSE+zBx+91HemveRemH/gg2GRue9N
X-Forefront-Antispam-Report: CIP:193.8.40.112;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:mailhost.polymeca.com;CAT:NONE;SFS:(4636009)(46966006)(40470700004)(36840700001)(36860700001)(508600001)(70586007)(4326008)(186003)(1076003)(36756003)(2906002)(336012)(81166007)(82310400004)(47076005)(6512007)(86362001)(2616005)(6486002)(956004)(36736006)(6666004)(316002)(118246002)(8936002)(26005)(8676002)(6506007)(5660300002)(70206006)(356005)(40460700003)(4744005)(107886003);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 09:39:29.4472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e9b8e4-8056-43a5-7c70-08d9df1d6b49
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.112];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT049.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB4464
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

initial DT bindings for Murata scl3300 inclinometer.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml b/Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml
index 55fd3548e3b6..f6e2a16a710b 100644
--- a/Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - murata,sca3300
+      - murata,scl3300
 
   reg:
     maxItems: 1
-- 
2.25.1

