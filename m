Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECC752487C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351656AbiELJBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351826AbiELJBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:01:13 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE4E2AE37;
        Thu, 12 May 2022 02:01:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKYx2S1jknMDFREE+Hz2poMg8N5IM1+aBkALOkJ3HjbOwivm4+iMeiBJ4g452oX6/7RvceXIbUx0SUxvilu6gigezSPtHZYlACrECLprI3OEL0cp1qiQ7QOBXNcx4+wqAlah/biB4nfWHdP98+7fk20EHfvDTEXoHSC6K/y9gDGSdAnzoPHHr7hi5lpLtyL54xGSB4c20sB6ezqt6hRqY5RQQB1L8gZzLwKmJN35oy71reyZncafFc5ZfEkGGccBCVRZqhtaCN5AKLoCWVImF4nUfXKiRbvpUF3mB6S1eg/MOYBCZRfkL3MqwuY60FuRKO74PYLveCmH1hl1QLoCZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Da4T1RGUyf1XK76xeft8T9cUeC+gIACCla05YB989x4=;
 b=Y8J79Sfwnkpz6yiG6ae4KCTRxYZCvDg26m13FdqKkCbnfXQLD1ujBMDu5E0WgiSqIx60Zu/d54u9alVcfgcQ2NRd6oLPVPSxPBQHDVS6zbe6XOm7KXw079phqkjEbeJpQsw8+4k6Llwel7ppMxH+h6hPD0vlqv/5dEMm91C3Lh7DeLf9r2VJ98+hWcc9kw4koBpTb/m6/DPj8JH/Fi6TdVOfctWYoJ142YcAHINwOIKton5TiiUuoOFkpMF58dwwB9kei4O44b/tCAjKprRR+j+6IZC+9aio7O3KX+yGVFOiszVnMb8sgrlsOWvw89uXo3V//FHa9iGt7aZEm5aDZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Da4T1RGUyf1XK76xeft8T9cUeC+gIACCla05YB989x4=;
 b=R1jQzfgnxSm44lU3PYTjoUTe8uWFJ0ELWoipX7iF61rlsDatqL4v+6GqWaxfijeoU73s8BKZN82QQd4e/q/wn9wdCi+8uK3MgcYmTtlMDvO/h+rHX4NQvRanrlYNedA61nAA3BYkjnvgwtfdzRDKOkxjHbEMBa32KSHanfk77YJMmU9n8DoTrfqck6KaP2KY93FFOCbxyZH9AWDHtljlUsUJLHpxR/XvqHhL3VilxXmqMX6ZjiHIP92/WvFt7/LOpdoPSAO8EHQGCT16+B7ZbrFv6renxzok1Hw5zhFPnNLS/4TadKECokiNZYAIFmmKhRa55VodNSsA9T7fxHjB9w==
Received: from MW4P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::22)
 by PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Thu, 12 May
 2022 09:01:09 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::ef) by MW4P223CA0017.outlook.office365.com
 (2603:10b6:303:80::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Thu, 12 May 2022 09:01:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 09:01:08 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 12 May 2022 09:01:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 12 May 2022 02:01:08 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 12 May 2022 02:01:05 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH 1/2] dt-bindings: Add headers for Tegra234 GPCDMA
Date:   Thu, 12 May 2022 14:30:51 +0530
Message-ID: <20220512090052.47840-2-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220512090052.47840-1-akhilrajeev@nvidia.com>
References: <20220512090052.47840-1-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82f6a560-452b-4635-3c58-08da33f5f4a1
X-MS-TrafficTypeDiagnostic: PH0PR12MB5417:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB54176C3B99C58557BB86C3B2C0CB9@PH0PR12MB5417.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: garmJn0FTtToleL9W9VMVRoCpVRJZ+0c7X79jcMyEnRpxY2S1iSQE5yOoj0rMq486tscoVhqnXiP7WF4+F6JM2CVfVrZlwcKDv7FIJipTPLM1XaYtNWAng9y2dJDYrtU8dfmSuyZLH80reDeRpkBxVA8Tu/qGxUqeVqJikdEdYo71aDxnsOSD06QSRXNSsFFB814cOVTHzHXAMnknvHsj/Co5jO0H3Nc4x7UHc6ZO7bsUfLjkpAP/LWmtZq14flC0IjtIfra8941lPP2rVseaEZJoX5FapGK2Q8R9Kj1rd543h8G7flKn+yLAtRO+6ive6K8WeHplvy9ml897tg6osgUWmDORzOhwh2mfjMJ1WivB8Gmz+fBiBh3Ajkrnz7A4EmTO2t0pIG3KAFdWAM7dsUYslom98nozFOhcwac5IueL0hJr8ZvpIPJy9LL9iKup40aRLO2NZQgnxmiNDFMOFeh+v+SRQnhSxzw4PTpmk+fOmkmzrSgSZkTalHVylRM8PG0gmzC6c6Dx/rTXn81X0bF2dpS96Bp0HHJy5Mh1FmY7wepsWbVLIT2TXqDbuqNWc6/NZ5ODY04RTe6huj7lKZMqgwAWp+DHloi2ewlODUppC/rtkInJ88v5X2iNy3WVFTsG+9cumW4w5mt5jr+7V/o3bew4bLMcDhUx+7MhZ/tuZsIdIr10qzKyfDe7kN2WUav/kJkFjJDoOhCQNNRTA==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(26005)(2616005)(107886003)(40460700003)(36860700001)(5660300002)(4326008)(36756003)(8676002)(82310400005)(336012)(1076003)(47076005)(186003)(426003)(70206006)(70586007)(110136005)(316002)(2906002)(6666004)(508600001)(86362001)(7696005)(8936002)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 09:01:08.9464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f6a560-452b-4635-3c58-08da33f5f4a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5417
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset and IOMMU header for Tegra234 GPCDMA

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 include/dt-bindings/memory/tegra234-mc.h   | 1 +
 include/dt-bindings/reset/tegra234-reset.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/dt-bindings/memory/tegra234-mc.h b/include/dt-bindings/memory/tegra234-mc.h
index e3b0e9da295d..4bc84a312ad6 100644
--- a/include/dt-bindings/memory/tegra234-mc.h
+++ b/include/dt-bindings/memory/tegra234-mc.h
@@ -11,6 +11,7 @@
 /* NISO0 stream IDs */
 #define TEGRA234_SID_APE	0x02
 #define TEGRA234_SID_HDA	0x03
+#define TEGRA234_SID_GPCDMA	0x04
 #define TEGRA234_SID_PCIE0	0x12
 #define TEGRA234_SID_PCIE4	0x13
 #define TEGRA234_SID_PCIE5	0x14
diff --git a/include/dt-bindings/reset/tegra234-reset.h b/include/dt-bindings/reset/tegra234-reset.h
index 547ca3b60caa..5809245e4e21 100644
--- a/include/dt-bindings/reset/tegra234-reset.h
+++ b/include/dt-bindings/reset/tegra234-reset.h
@@ -15,6 +15,7 @@
 #define TEGRA234_RESET_PEX1_COMMON_APB		13U
 #define TEGRA234_RESET_PEX2_CORE_7		14U
 #define TEGRA234_RESET_PEX2_CORE_7_APB		15U
+#define TEGRA234_RESET_GPCDMA			18U
 #define TEGRA234_RESET_HDA			20U
 #define TEGRA234_RESET_HDACODEC			21U
 #define TEGRA234_RESET_I2C1			24U
-- 
2.17.1

