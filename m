Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D698C53896E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 03:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243049AbiEaBLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 21:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiEaBLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 21:11:14 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2107.outbound.protection.outlook.com [40.107.236.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411219398B;
        Mon, 30 May 2022 18:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnLN5cTBv6bHRd91yvILZYd9dQ9asrYoFxhpV3Z+uYC2OF2ftP1pcKUKcYkAh4zKcs5TJOhruNmOvxvCgnTbWD/CjVCxZied4t0G/Mksv3dARcYa/53qq26XbKvrDSNj0eYmUELdMvWVaulIyxZDmRNf9OhCVMI4NC4WwPE+t/JemJ1U2HRAuMwaCyAsJge1KOCxKlf4uiNOmkATxk3OGprsw9TAoN7GJ8r6WwctaWHEiwEmo1efg9Sd4a9CZ2ZmXFjSmHgJF9XLDwTaJGS7ZWlqPJZf4bsO2V3+nc0PxNHhaudcDVduH0PUhs/ifrtplUgFd+8Be93nG+x0UtJe+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kI0aOq/ehwMNmBHLk/oqofQNDlV1/emXeVLPy40k48=;
 b=Jknchmwv+uECGeH1RWPOwPt08fTAT8/P5RHCPHUzWTzAvnARCijpgAaJKbV/E561IUo8R9BCsir4m57Ej0e/6dQhQNLt2mLLv5f5G2O0NLzJD8E7AXTFw3b6RswkNLHWCObuH8jHrpz1JM/nbhWd3pf24P+z3nFpUveSTd0ylRxIAyZBgOFDSzD2LPYKIx3Zhl6Od55oJgE0Z5PJHB5kNa1NTwW8Q4cC8TvqE3iCaMVObOZtQQTUZkFwuwNdPWIvutFdT/BaoGrBMOipQcDHt28qWMExd/SMg+jtan79oQq8imicHVCUwDYK5gzNMs0ZlR10pNPmiqrAazfS2vf9pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.14.198.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=jabil.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=jabil.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabil.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kI0aOq/ehwMNmBHLk/oqofQNDlV1/emXeVLPy40k48=;
 b=POSICHUpYbgBz0eWytRaP1fwYDZgM/PVAdP92ZBSuu7y3whhBUq0OsNcpN1aQrM6hxGskmAsoVgITxnfrxuCf73Wopue7fESVhTanjUYlkcyZBzuNR5h66QfIW9U5NUcAFmCqv9V7OrEIqaAcX4/5/f+0WeyHjcXoRLYvk5Rj1+u1+mmU/K0C4D0lV42vkN4WfYImUpACT9lfHK4wU0lGJnacMiJi0jXyygK7ZR9ph75RINZIJtZXM5KHBqc5gUFmS30fW90hpacHnZrooUcmUi5IA3Daf5xu7K5D9g3gcxIEhwSAeCzxZfiBEFOtpLZf7pe28I9VSuo6ceoTtvajw==
Received: from MW4P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::34)
 by DM6PR02MB7066.namprd02.prod.outlook.com (2603:10b6:5:25b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 31 May
 2022 01:11:11 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::b6) by MW4P223CA0029.outlook.office365.com
 (2603:10b6:303:80::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Tue, 31 May 2022 01:11:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.14.198.160)
 smtp.mailfrom=jabil.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=jabil.com;
Received-SPF: Pass (protection.outlook.com: domain of jabil.com designates
 8.14.198.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.14.198.160; helo=jabil.com; pr=C
Received: from jabil.com (8.14.198.160) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Tue, 31 May 2022 01:11:11 +0000
Received: from usplnd0hub02.corp.jabil.org (10.10.47.157) by
 USPLND0HUB01.corp.JABIL.ORG (10.10.32.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 30 May 2022 20:11:10 -0500
Received: from JDSBuild.corp.JABIL.ORG (10.10.7.5) by
 usplnd0hub02.corp.jabil.org (10.10.47.157) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 30 May 2022 20:11:09 -0500
From:   David Wang <David_Wang6097@jabil.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <edward_chen@jabil.com>, <ben_pai@jabil.com>,
        David Wang <David_Wang6097@jabil.com>
Subject: [PATCH v5 3/3] dt-bindings: arm: aspeed: document board compatibles
Date:   Tue, 31 May 2022 09:10:59 +0800
Message-ID: <20220531011100.882643-2-David_Wang6097@jabil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220531011100.882643-1-David_Wang6097@jabil.com>
References: <20220531011100.882643-1-David_Wang6097@jabil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8f6803d-37ca-4bb0-2794-08da42a27336
X-MS-TrafficTypeDiagnostic: DM6PR02MB7066:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB7066E97AF53C4FB5942DCE27EFDC9@DM6PR02MB7066.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N5YOdRmE9KEpVQiCTJqWE4kkwLArwzGDzesYPxoYV8ZToZQ/0oIBnjgJeDPLiU7dYeuc69PRy9UT1ryt4GPnT/xoiy32aC9f0RYjpjq9ugTrPX1mOxM8e+bbzQkhTfaHDIdGjOhxrxq52hhLAXfvYQvYcRSgcDsAN4IQaDwIwd4Pqv6B1gudiGoj6cDNdEh6Gv8qvk1k25X8y/xjTzsI0RyDjNHZ5efEZFkcmjehRTiISSwh0yjnKgO7N08TN7fu0ZY+erWm8b0HJgZin3dUooaekT4+efgwKXj1b3vWpY+BirZB/afKnEQqT97pmqbeg37Cz1yZDDwW1wkdM/VdFouKf6vHoM+OYTwFkJMMJCUdzb6sT1g3eaHGR0r7arsLXJdSMlwbP2Rwt76TkY6Wf55DeybfeyR8w7eARY7N0HysYtSJihVYQ/gUTyfr2tHduh69JVP1NPNXn4n7F5PXw82+lORUSP6w7RpVlCGCPQDsoAZeH2BsZEatMiU1g+GmnZYjfv/3g3f0M69Jyow6lb9mjoOAb2+tk3DdK1A0l1efmpQzcNL/StRoAzlF4tPPuw2jOjMHLRRGt46wSDi5c8IqOmtalw2l2+3GMD/sw0F5UvQzLFCUR8J14EuyX2bFHLJ8Wryks7uNe4X3rwz20lGtbyj7R/J1+6Dz+8BoHw6/+hG6lsKxBzhFOgRkuOVVUjITewAcI9fHknLpEPq71Q==
X-Forefront-Antispam-Report: CIP:8.14.198.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:jabil.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8936002)(70206006)(70586007)(36756003)(4326008)(6666004)(110136005)(54906003)(316002)(8676002)(40460700003)(26005)(81166007)(82960400001)(2906002)(4744005)(356005)(508600001)(336012)(186003)(1076003)(5660300002)(2616005)(107886003)(36860700001)(86362001)(82310400005)(47076005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: jabil.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 01:11:11.0316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f6803d-37ca-4bb0-2794-08da42a27336
X-MS-Exchange-CrossTenant-Id: bc876b21-f134-4c12-a265-8ed26b7f0f3b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bc876b21-f134-4c12-a265-8ed26b7f0f3b;Ip=[8.14.198.160];Helo=[jabil.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB7066
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document jabil board compatible.

Signed-off-by: David Wang <David_Wang6097@jabil.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 5c9aa014432d..407cfbe85153 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -78,6 +78,7 @@ properties:
               - ibm,rainier-bmc
               - ibm,tacoma-bmc
               - inventec,transformer-bmc
+              - jabil,rbp-bmc  
               - nuvia,dc-scm-bmc
               - quanta,s6q-bmc
           - const: aspeed,ast2600
-- 
2.30.2

