Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FCB4DAD6F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354884AbiCPJ1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 05:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354874AbiCPJ1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:27:23 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2C965420;
        Wed, 16 Mar 2022 02:26:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwbtH2YeGURz9qfTg/RBraLEgAfE1uUWABgJqh1EHmPf19Uc2oUpgGuG5v7ZH+S5EFdqGEotqydi3Q3THuq0DK5ofXUztb6zikfe2VE9IkOWv8CBDNzJxhhCx0m0iYpbHs8Ejd8+JvpRedbBoyCYbNfdF5MIIKe4TpYF+oIUWMi0k6/fAjMuUK7+c5EJTag4bTT5DUa7OMrw++t1KulyMLZxJjX8044WwTEH8cRguZ25aCj1qnLxOm4u6xAHqip8wIyx//Qfh67v/Pgs7shLOwkiGT8CMJEdZ6EBuIbD6MBzFG3gywNgj1u5aL++DdaiQ7XBsbBqWIhiMmv6kNZ9FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OepuICjE3S40JQB2mYhK/WOp1+/u6lcRmM49osFNSWM=;
 b=JMUSM4jfk5LSF/zEvi9j+9P1+RwO0JWeJuprpeDPfoFiyWFV2zgLarVyDxOEhrn9rdARnitFuwoz7//ELiwUmP7F5q8cVCiVr0leyTU85tAuHsBOwq7nLOYIF/lGiGq2k0GE9IwE9dOjgOad0GyjLYyb4oL8umekKEHP6R7R5wtok7KBFYUb/QaGMrw/BYHSeIEqm+nyqz8TKSFrAGj73oYfFhkZ/i4r7WBmERvL4v0nWsCKnLbvNVrhN+acn+PmT4HZfWb2dY8uSniV5uccaMUnnkfCuNC8QBqedqoEnp7aiCx6gQriDMQPwRg8CzIi8uyrE+n+QfNCOW0vuR8L9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OepuICjE3S40JQB2mYhK/WOp1+/u6lcRmM49osFNSWM=;
 b=sO3ci4teP3y5DhDd3jl6XcDl8zdompGozi0440KfZ8Q+aBiBUFiaq9gJVp5Az86/Z7vK2QAcbCEKYIiqLPu+i5O9RMpVW7gP2gMLm9MTC/dLuyVfGR+5vRN6PgdMN6ULFgFkZ0dDb3Vp8obq4wcMPbZ73j+k4vx27PGYFGAx3qQcwEaicxpzvfPXrkdE4iyHIgY1kYF8IMul5QUZjxvpgU2EcVqZMaqRhoQYu2m4N5tE7aO7tOaBm1Wdy9kZ5WCPhDprIn69Y4t0pAxUHGV2Gc4e7aJq4Dj9Zwkgjk18cQqIwEf5CLgkmkZ5oDUA84bvGgrjasM9Dc5tCdK+yrYIcQ==
Received: from MWHPR10CA0063.namprd10.prod.outlook.com (2603:10b6:300:2c::25)
 by BN6PR1201MB0097.namprd12.prod.outlook.com (2603:10b6:405:54::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 09:26:07 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:2c:cafe::b0) by MWHPR10CA0063.outlook.office365.com
 (2603:10b6:300:2c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14 via Frontend
 Transport; Wed, 16 Mar 2022 09:26:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5081.14 via Frontend Transport; Wed, 16 Mar 2022 09:26:02 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 16 Mar
 2022 09:26:01 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 16 Mar
 2022 02:26:00 -0700
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 16 Mar 2022 02:25:57 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <krzysztof.kozlowski@canonical.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <digetx@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>, <amhetre@nvidia.com>
Subject: [Patch v5 3/4] dt-bindings: memory: Update reg maxitems for tegra186
Date:   Wed, 16 Mar 2022 14:55:24 +0530
Message-ID: <20220316092525.4554-4-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220316092525.4554-1-amhetre@nvidia.com>
References: <20220316092525.4554-1-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d92f2bf4-5b32-4599-c1b9-08da072efd0b
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0097:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0097909300426A1710D4C5C8CA119@BN6PR1201MB0097.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D0uYEwYaZVFRO474j0yQsRcC8iQpIlGzZRFdjPpihKWwHLAjfXzpZkIJ9LgmwiKjmidapqxvYoZFkFJ5yt8XwB6wttOZtYtsLQkI5LOJq2qEL86QTHR8oXV2wV219YC901fatFmY4jHi43sC+gnuYvRCW3M7v3mIfwvBUI/jzQNyGRIt7Qb4GtE19efNINLL0GLyAkdyZp8s4eNFKuUo3aU9po10/RlYY1Lv1JiCRmQ+9vo/TYNja++4XUxN8k6AodH9aL8XhAHq2fqjv1+CfEKrj5JOWUsnzrRK5fhEZMZNvROQ6FxCXPD/ZlWKv/ZFv+A2YZjHd8ODu0qLHpnjlu4oEvzot/jvpGxixGsbYp2ZQRH3dibgr+kVZxa6hgSVbvkgrJzhGVmlRx5/rWQqUqJ3RQjWufL3WO1cxGhVSh+Q0Xn0hRQ72fwo5oj99NieJ2gEaXtIm1WPKtaeuZ2imuuVUfYshgcvm1yA9Yo1aWkF6+X0AX2y4vbiFHU5m1IujoE2bogzKZEbxsvLUGvLUsuoEOpjpSj1oZUVmh9F6z365cuVXIuD8Z1+DlvzMtxMye5TA5fWcoRlpwgapQvF1QC5qQXoDnjKz2XMOTKt/9gQPErRmJA4hLo4ge9sCOllmqq4zdRE9C8y7lAYpzhugolM+IdGSGv4Tlfa55UTEJcdcw2X1S2FdPzFo30CCsz4WUfZfQ6nT/qdxSvwORcecg==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(83380400001)(5660300002)(47076005)(15650500001)(7696005)(2906002)(426003)(336012)(8936002)(36860700001)(36756003)(107886003)(86362001)(508600001)(70586007)(70206006)(40460700003)(6666004)(54906003)(110136005)(1076003)(26005)(186003)(4326008)(2616005)(8676002)(82310400004)(81166007)(356005)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 09:26:02.0549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d92f2bf4-5b32-4599-c1b9-08da072efd0b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0097
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From tegra186 onwards, memory controller support multiple channels.
Reg items are updated with address and size of these channels.
Tegra186 has overall 5 memory controller channels. Tegra194 and tegra234
have overall 17 memory controller channels each.
There is 1 reg item for memory controller stream-id registers.
So update the reg maxItems to 18 in tegra186 devicetree documentation.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 .../nvidia,tegra186-mc.yaml                   | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
index 13c4c82fd0d3..3c4e231dc1de 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
@@ -34,8 +34,8 @@ properties:
           - nvidia,tegra234-mc
 
   reg:
-    minItems: 1
-    maxItems: 3
+    minItems: 6
+    maxItems: 18
 
   interrupts:
     items:
@@ -142,7 +142,8 @@ allOf:
     then:
       properties:
         reg:
-          maxItems: 1
+          maxItems: 6
+          description: 5 memory controller channels and 1 for stream-id registers
 
   - if:
       properties:
@@ -151,7 +152,8 @@ allOf:
     then:
       properties:
         reg:
-          minItems: 3
+          minItems: 18
+          description: 17 memory controller channels and 1 for stream-id registers
 
   - if:
       properties:
@@ -160,7 +162,8 @@ allOf:
     then:
       properties:
         reg:
-          minItems: 3
+          minItems: 18
+          description: 17 memory controller channels and 1 for stream-id registers
 
 additionalProperties: false
 
@@ -198,7 +201,12 @@ examples:
 
             external-memory-controller@2c60000 {
                 compatible = "nvidia,tegra186-emc";
-                reg = <0x0 0x02c60000 0x0 0x50000>;
+                reg = <0x0 0x02c00000 0x0 0x10000>,    /* MC-SID */
+                      <0x0 0x02c10000 0x0 0x10000>,    /* Broadcast channel */
+                      <0x0 0x02c20000 0x0 0x10000>,    /* MC0 */
+                      <0x0 0x02c30000 0x0 0x10000>,    /* MC1 */
+                      <0x0 0x02c40000 0x0 0x10000>,    /* MC2 */
+                      <0x0 0x02c50000 0x0 0x10000>;    /* MC3 */
                 interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
                 clocks = <&bpmp TEGRA186_CLK_EMC>;
                 clock-names = "emc";
-- 
2.17.1

