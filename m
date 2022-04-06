Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2694F5769
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 10:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbiDFHM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 03:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242012AbiDFG6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 02:58:13 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104084A62D3;
        Tue,  5 Apr 2022 22:25:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuTvrEZF8UbWu4emPcusZWmMbrE5Pe8Sag2twzXtUtWjEaVZ3F6GPizEGfygP+MubS/8yPdghJNaWFfBo9I5OWjuyU1tg9bS5APaNfnA3urF7FHFcpyAd7eP+H9hdLxETAtw2AP1ksjn1tbjH0h26QRMhD683vRFvwnZH4V9NqfkmeiD9usLHFzTjVu3V5eNVieCM7HHxm8e3RwEbVvpK927KjzSomi9ElG/BQr5pABSLyVHna5rP94U+xXeY6GIwwrl4WUepgXed41UZebtxLa9+KoycBOUYJop1YOFH5A2B0OXRv8SlR9QppwNVYCE7kPBGpgNi7H3EGg4QK6sSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQrb6KhWqep3OVVq+EeB09DdW2RVtznAkJnWB3/5h/0=;
 b=XF9EXgdjo87XAR3SLgvduTnvR2fW4Fs1oDC82ASGJtUSf+I9Jrgy8YoXeDZVWt/lmf6drBNdrkZ8XPZbPeJ6D5xSwCjv7ajkHIcge/TTew86+6eBJY9WCRgQe1cbMRtBioTM7+a9Fch1hThkuQ5YWY1vNQM7dXw5mtpRl6F9ROCd9wZvP4uDLvcEqx05mjOdc44HcwCI7VAr8dKTZ5TsoamzimD1LhMyb50cYAzMBs5A9W6h5h+WYWQeJM/YCnxaoZCS5r9mI3d8GyZ1Ee/iiJ5cqU9tVyYsHu3JS4VaAZ+nTRNDcsq8Jd3+CfyDh0MIrcw2KzIqTH4w7++TdxkoIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQrb6KhWqep3OVVq+EeB09DdW2RVtznAkJnWB3/5h/0=;
 b=K912k3R/Gwv9Y6eM+mME8/Q396CurwBZt/sE0zvIkbAbrRoZeG15qC72zPXNzvVNDI23fovy8YaNbLaWBFkKE0lMEdJTZBXP12e1HoYuvOzoDkcEbEpQPHHV9OAHq5uc/sZlplZgbgZV8O1pPTFus4Gvi2setfg81kZnpgFy5CpMjN78Pe95kXvHKXDCFSPSe/gE3uhDbzBjfYUdxgbkV/QUvU5ydaWGcwZmYviWvxF70ExxHfivQPsVihlwk3pZN0Bb2otFNcWTablyMv4wSQgrsWRhrP4lf64/p/Wn87UXF28bkr1+38u4WG/ce/hK4vgSnyue4ilWmCf2L9v60g==
Received: from MW4PR04CA0042.namprd04.prod.outlook.com (2603:10b6:303:6a::17)
 by CH2PR12MB4056.namprd12.prod.outlook.com (2603:10b6:610:a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 05:25:27 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::96) by MW4PR04CA0042.outlook.office365.com
 (2603:10b6:303:6a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Wed, 6 Apr 2022 05:25:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5144.20 via Frontend Transport; Wed, 6 Apr 2022 05:25:26 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 6 Apr
 2022 05:25:26 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 5 Apr 2022
 22:25:25 -0700
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 5 Apr 2022 22:25:21 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>
Subject: [Patch v6 3/4] dt-bindings: memory: Update reg maxitems for tegra186
Date:   Wed, 6 Apr 2022 10:54:58 +0530
Message-ID: <20220406052459.10438-4-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220406052459.10438-1-amhetre@nvidia.com>
References: <20220406052459.10438-1-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a91603c5-a2dc-47d7-778c-08da178ddba4
X-MS-TrafficTypeDiagnostic: CH2PR12MB4056:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB40565CDEB608F115B7C8E497CAE79@CH2PR12MB4056.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sWDaEF0waY3n85E2Emis3DU1rkymGdPjOZjCm1hEJ5HifR9/pY9aDaINEseMiu2KA4FzB8Jl5jWAwH/hAG982iJH5R09fkZ8uHVYYKAi7CNwE68w3pez9zw9AAO/x/4VSSyCj5UPi1eBIeBS3mXviNSbpe+iAsXDRJ4ZCOw4L54J5y9YnuSF+C0pXgGAPLU0KRc3SoyEio36WdO3W5KPjOAyMObogJdVqn9TbXo0UWhXH0mmo4KOOkYEbmEIJnoojKLDvIGJX1rZhkuAf+Z7ehO6FCrj12JerorQ2FOZpmlZZT8skgI0U3axbRjMLpQGmfA62tX0qAtLZePRY4c2ADEclLOCWlYFb3SGyhrwiEwER5zctxHy4de9U/gQhARg9Xq7f8uilwNUEZQjaJsxKa/sFwgwzNeEGJhJQnpzGSyYxraIxGpcmVAVMg5WtWjUiQzqG9uyiqkNS19mrwS6xsYxi2FeseNavrSqfGJGeAEJL79jEjtjZZOGHAt7gsbLHkQN+vFuCA2e2SIT+/7QA5vkt/MYBV3AWpoBIgaIGpUjikrmMTxzzNmUinXQHp3CrPWfjs8uhlAexVaO6yYP65sM5sMwovyQF/aoX2YJTI1H+rUIziZCy9WDtAjVFi1CfDlm/z7s5LOFfBknvvT4nq0sPOUxvcUE4Fh+kFrCpBd5AhX7AF2jTuHWBcLQiq97e6mBHF0hXoavWtwnrykoXw==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36860700001)(336012)(356005)(40460700003)(86362001)(4326008)(8676002)(6666004)(7696005)(47076005)(426003)(2906002)(508600001)(15650500001)(81166007)(316002)(5660300002)(82310400005)(83380400001)(2616005)(54906003)(107886003)(70206006)(26005)(70586007)(1076003)(186003)(110136005)(8936002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 05:25:26.8069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a91603c5-a2dc-47d7-778c-08da178ddba4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
 .../memory-controllers/nvidia,tegra186-mc.yaml    | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
index 13c4c82fd0d3..0fe396a2e162 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
@@ -35,7 +35,7 @@ properties:
 
   reg:
     minItems: 1
-    maxItems: 3
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
@@ -152,6 +153,7 @@ allOf:
       properties:
         reg:
           minItems: 3
+          description: 17 memory controller channels and 1 for stream-id registers
 
   - if:
       properties:
@@ -161,6 +163,7 @@ allOf:
       properties:
         reg:
           minItems: 3
+          description: 17 memory controller channels and 1 for stream-id registers
 
 additionalProperties: false
 
@@ -182,7 +185,13 @@ examples:
 
         memory-controller@2c00000 {
             compatible = "nvidia,tegra186-mc";
-            reg = <0x0 0x02c00000 0x0 0xb0000>;
+            reg = <0x0 0x02c00000 0x0 0x10000>,    /* MC-SID */
+                  <0x0 0x02c10000 0x0 0x10000>,    /* Broadcast channel */
+                  <0x0 0x02c20000 0x0 0x10000>,    /* MC0 */
+                  <0x0 0x02c30000 0x0 0x10000>,    /* MC1 */
+                  <0x0 0x02c40000 0x0 0x10000>,    /* MC2 */
+                  <0x0 0x02c50000 0x0 0x10000>;    /* MC3 */
+            reg-names = "mc-sid", "mc-broadcast", "mc0", "mc1", "mc2", "mc3";
             interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
 
             #address-cells = <2>;
-- 
2.17.1

