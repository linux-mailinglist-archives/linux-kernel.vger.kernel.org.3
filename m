Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928E24C9F9A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239748AbiCBIpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240158AbiCBIpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:45:05 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115FFBAB92;
        Wed,  2 Mar 2022 00:44:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdSbKYDtw12IgJFmGhT4T/H1II7ZP1S13PXDt8Nz818Zi9Ysc9X0bjZOQKSj6HO0izBNAnibYVNEtH9+XgU7cNOyfDbf7gkfIT7RLOtcM5l6Ev2J87KdG13pwOblkIEXMAQD6qsty44Nc3rQ1oRdXfr6bHnCvD28NSk1TUCQFNQR45lH3bZ6VoJaEv18w7QzkRBVPrlI9ZG08t4Hi3LX2kicHSvPBidxFjjPi3GH+0t50ULX9tOIpfsYxH+2oH5jB16rkg/b1eitqLhhvM0pbPhaR9X4Agzrg/vha84PcYzbk/7K+YkCCgR7wDhFNkR1oBJqhnR1kI6xDgdLzEb7ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIj6WkZ8iWnNb+fBRbU79JH930UZGBYGVj9Up6Id7WQ=;
 b=U7+1OcgMtiY/XuFVvPfCJYjvsBg5v+rQQTIbtmu2ki920zgB3qrXLBhqQf6JXKDnwrDKDV36VwPfPI3UH2RFsAn6pECLwE6/K4l7XxvlAQHoFShRZxfgWYCtNEC6mnQrbh06Swp0/2WAMsn5XNMxSydpH1eEpfJND4eengQkFDV/NnEpqX2ZtB9NLXyuTYvEeX/Hrv6hxYPJHhKNs8k58s0SZdTPxZTA/QBCy5+wATRTL5XqxurFCwyKBKu8qdd517glSzrv/gccrl/kZ0A/+P9Ha5bFBM0UX9OxQP/SizRC5pkCmwg3r6MjiqFdQ3X8iSdzTRD8IFockQecGvlIjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIj6WkZ8iWnNb+fBRbU79JH930UZGBYGVj9Up6Id7WQ=;
 b=FVlL2yIe5yTHtYoQFuTNEacYqicsZneyTzBOm3zPnc0H0gMpa2XfFlKejb6I99j6aDyQUX/Sr9SEw2eUDsxThBnKxKwZ67uFNBj7wku1+AblGQM0XFsalJ7yRgkZ4ZVmfDcqGfrCxpXeSpUo2Vz7ZyBJbm5zmaf4j7Hg6QJQi9w9G+L3POwgSqpGVOmh9cEun7eDqyeZ5n9dMk2Rwsall2GIq3r3L35LsfkMDQyBBpeSqs+LpJ0tpNU+5MHZ7IdqbYJup8L05CEKjHeAH4tSMSY/AjebVYl50b2pUIDIdveozTYbEaIbRnc7WjXR+btczs+RvZkhXrXCqoOQOKvtFw==
Received: from MW4PR03CA0030.namprd03.prod.outlook.com (2603:10b6:303:8f::35)
 by SJ0PR12MB5424.namprd12.prod.outlook.com (2603:10b6:a03:300::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 08:44:16 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::76) by MW4PR03CA0030.outlook.office365.com
 (2603:10b6:303:8f::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24 via Frontend
 Transport; Wed, 2 Mar 2022 08:44:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Wed, 2 Mar 2022 08:44:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 2 Mar
 2022 08:44:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 2 Mar 2022
 00:44:14 -0800
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Wed, 2 Mar 2022 00:44:10 -0800
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <digetx@gmail.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>, <amhetre@nvidia.com>
Subject: [Patch v4 2/4] dt-bindings: memory: Update reg maxitems for tegra186
Date:   Wed, 2 Mar 2022 14:13:27 +0530
Message-ID: <1646210609-21943-3-git-send-email-amhetre@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646210609-21943-1-git-send-email-amhetre@nvidia.com>
References: <1646210609-21943-1-git-send-email-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d127c84-ec95-4872-523d-08d9fc28d5ba
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5424:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5424AE0AC2E80CCB67E44380CA039@SJ0PR12MB5424.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eGgLfOl0ROVVd75hzYPsy34e5tF3AdOQPz7xdXfx7kC2Z1dg2z9N9BS6Xs5PI8PGnCsd6x6CYZl2MFCmK0pfgTjIRMHyZ5VujqEy4WqLhBgHf9ij0iGdQEVQHrgwyNcpMVxlaYh9eoHi/cOdGB2De4CoOFnw9ATqi+wY2aK5WIo6xBjGe8hdv1Q4MH4GntlurhJi+yqeULbr4G1jH/1KZnvs5DNro8+1ZUxS2JCxU3SlOaaifpvp8KcirQNO/ZB95G8vYxa7AUH6/SM/umonMdp7/ZgbZP4kTGgrPbHlKWWZ1XvqyzZUJ6ZQfZzb83aQTaCIE7a7qu5EvDVcHpYlLPeMOLMMsP3uTPZ6SQTn4wF6yYqsw/3bBbubdvXnEkFdFjiDW0cHWLlUipo5UojOdijgP3ryU7/X6lj4XYJa04fwIMsm7XZ6oL0rx3qA2ovDcvBFo2AmtHkk8BkuojoQ+f1sqch3i6ALwBThFBpKQYsI9Yv/0AOIzpfKImiqKD9AlU7K6GL8iwu6PX6vWv9RLOQzvPHAlIzXb3GtekxUf9+hbRE+noio5c8IQrV5TZuWOWttAHvD4wy7/wHH53lMeMq3QbRADjTBT3kJEHcwRBZh4ZE3zvWVA3L7Wq7yxFdJcBWV/ZAyUEsNFdFjhD4Ck6Hk58cSHJp7mwTdLSi4XJDAaqyeFGCwm51d8aerZB+m7VkoubWJpAObJfyqJ9rEuQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(47076005)(40460700003)(508600001)(36860700001)(107886003)(110136005)(54906003)(8936002)(86362001)(5660300002)(15650500001)(81166007)(356005)(4326008)(82310400004)(316002)(8676002)(36756003)(83380400001)(26005)(186003)(336012)(2616005)(426003)(2906002)(70586007)(70206006)(6666004)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 08:44:16.3191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d127c84-ec95-4872-523d-08d9fc28d5ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5424
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
 .../devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
index 13c4c82..eb7ed00 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
@@ -35,7 +35,7 @@ properties:
 
   reg:
     minItems: 1
-    maxItems: 3
+    maxItems: 18
 
   interrupts:
     items:
-- 
2.7.4

