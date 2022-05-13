Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBB7525CD5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378100AbiEMIJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378089AbiEMIJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:09:08 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F5A1D5004;
        Fri, 13 May 2022 01:09:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYvTGL2rIz/F+SBosaTfR2+uRn2vT/HKrX1ZhpOpeJ2N/nqUMaUp4pmWeWRPwFdYm1yE+yzGfBPvPActZ500/tq37pN7bxvv99ReprSlAJMqrhlsnFQ2oLzdLFT8I5LFBCRojQ9E2YZb2YjPTecs2bj90ek4ZG4HYWi1OLW5GyaUYjwpKYuXM3Mo/Nus1Y2Tvb6792sztQOYxrBL/XWm4m43i+JGxbWqO/Rph8x5bn4C9BWjVbPgj329lf1R0PHkm9ZoOWiFK+6SenQLnnXi8eNi2warzohPojA3aKLB2WEBDj0fH2PiV9Nz/3qKtX9ipBC/EERyq78kEI5SWnUlRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ygycUowgxXD+vPfmC1VGnu+gzuVsKbMoxxpasgil/Q=;
 b=cudvYEp/0k13R/N0XDk313NLHGTykPcznwuGnkwTBHuptOfFdW9t1axufyOpIGMZ0PZSVpxB+cJd+wGlN0BoJ1dQexccrUK08orCHcMWdTVAyQv73pTO6yYEjBhYkmjV3RQZWzOUDPxK/+9u6MpXd4dtP1JAjisYS2/EqnBC/R7Rd/rnEUVXQLrm9q/hbb1KavT7wvtG1+2Gc24Vdv/FeX5+myiFAf/Tnpiu51uX7yK5R32oLOD820NOX56LpFdmvd1in6TgXE20eRPSuAP78jvc6EHuAt14nBurcyAae1vfl6H0svqfgjtPXRolyr1kSG2Fz2TyiPMqN5/KytlI8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ygycUowgxXD+vPfmC1VGnu+gzuVsKbMoxxpasgil/Q=;
 b=P4h6UElTTetgMMEKKZHI7+NebwGB+Z1aOCp2I88NVY85b+QcEV6v1hVdrnHbY4dLk2b6TZhGRet9Qi1qXOd+p29sfNjkSKo7NTf0ppTQ9Zf2BhordiA5eG4zcCu6ZBuUUFlA1Q6lan9LZ5+jnwdpxFsz/arJji+DDH4MysOR8rnkb7vjntT5YceLJ6Q5e2GA3EKf0YbNV7j6Y6V7CXHjri6QJp44sYgED/XDTEDh6ejjFZWhkbb3R571KfGYQ+W812HGFKbpxQUOJqUFFcPIaYDTVr+Y6Q+c4CuKP8Q383T/vB3Rspdslw4GPhI/8HT93vWYsJqabVFRUG11JqBN0A==
Received: from DM6PR13CA0046.namprd13.prod.outlook.com (2603:10b6:5:134::23)
 by PH0PR12MB5449.namprd12.prod.outlook.com (2603:10b6:510:e7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 08:08:59 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::67) by DM6PR13CA0046.outlook.office365.com
 (2603:10b6:5:134::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Fri, 13 May 2022 08:08:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 08:08:59 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 13 May
 2022 08:08:58 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 13 May
 2022 01:08:57 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Fri, 13 May 2022 01:08:54 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <ashishsingha@nvidia.com>,
        <robh+dt@kernel.org>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Krishna Yarlagadda" <kyarlagadda@nvidia.com>
Subject: [Patch V2 3/3] spi: dt-bindings: Add compatible for Tegra241 QSPI
Date:   Fri, 13 May 2022 13:38:28 +0530
Message-ID: <20220513080828.22079-4-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220513080828.22079-1-kyarlagadda@nvidia.com>
References: <20220513080828.22079-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74255f7d-ff17-41bf-9f9d-08da34b7d5b0
X-MS-TrafficTypeDiagnostic: PH0PR12MB5449:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB544912459339F9FBF335DDCCC3CA9@PH0PR12MB5449.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6kuGQ39hWTbU17/4XwmZC171Le7WxS2Skq1i2U5M1Pw8Jj/m1fI7qARN/LtvW6UJj47op/miJxhNqD/6aLZD/LbqelW9WQw5T2KfxNf4h7Ckm59F4t5woB+HtO4gNKZjCKCOyowb0m+7sHtIKOdBmlFfefdGa+8nsbMht6vV57d3dG4SxkNqRdZz3TCSXFLh92WaW/OsrGARbPm9P6zD0Tk6SHeVo2mhzU+yqTglm8GKJe/QFgyDJs9mmbdnS/4cE9fTgdqpgKHGMKCYbGKfLD+He/2etD5tiWaKw1pyXzdjI1WKzt4nxkPT4IUOzZroF1EJe2AcF1aiKFnPyUW6vVh1qHw02M3QWARMsCNIfh/rGV/T7w4o0Vc+CCyoEZGaAoGnFW8UOE510cb2y7UAoDN35r1EK6fSAcw3/cTwk9QcJMwSwwbQIj8HPV20sD73mg7b+WadXEyz1zTYB2QatHni1CBHK/GQY4aF1/zm/UsfhxcLB8D8rugiKeqcBcxUlRtp0D5A9vtHPJbO1VEc19qpl8uCkeTG5WK9PN8t0FUYizrg1LZswo5oosiZQe9V2Nce2gARtt9944NiyzNr3/MNO9tOF7bBTjfvSWXqGY2Wf4yuySfCgKMXkFPX0S+GEUfmtsnfZ8qp8ZMMaYC6LuTU36DmoMRkdyhEnMuqstFw++tAfY8MsmVi0CLnGR2pEPLG0hiZ0bYEiCOEtx35Qw==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(4744005)(81166007)(82310400005)(7696005)(2906002)(8936002)(26005)(36860700001)(508600001)(36756003)(426003)(47076005)(336012)(186003)(40460700003)(86362001)(5660300002)(110136005)(316002)(54906003)(2616005)(1076003)(70586007)(8676002)(107886003)(356005)(70206006)(4326008)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 08:08:59.3878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74255f7d-ff17-41bf-9f9d-08da34b7d5b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5449
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new compatible for Tegra241 QSPI controller which has
multiple chip select lines.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
index 7d60bb1af047..3ba9df4f3a0b 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
@@ -20,6 +20,7 @@ properties:
       - nvidia,tegra186-qspi
       - nvidia,tegra194-qspi
       - nvidia,tegra234-qspi
+      - nvidia,tegra241-qspi
 
   interrupts:
     maxItems: 1
-- 
2.17.1

