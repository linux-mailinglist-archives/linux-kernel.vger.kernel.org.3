Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8455A529B40
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbiEQHmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242747AbiEQHlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:41:25 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377D1186;
        Tue, 17 May 2022 00:41:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDtJjj8s/+h0eMjYt6VhMKuXmD2Og03a2ylXfDs9jOrRHPaYcAFwTQEU4G07050OdGn2ux5/rzpSOVp1gCNXdHnDgGxij4kcbUGHzxtpF0Ir46WuNItjBoF5zqFi0RY8F2HoUIMw7rdpgWiXoHafQrmo+yM2ClxFRxGCDj3uzGkfTu0/5yIQ1WnnsKICzmxKTzciBqN63hD3d0cqImnQ6qLb1mL7TiAfU7ci84q4z+VB6TibYK9TG8Qr8LOq9eCx5fYAfHiNys4t8nWDGbDPJuX4YZeLLy7/kuIdrxgc205BcqpO/1SyfpcD1M3gMQdaQp9gUZXXjpm8bKMtccUZAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EezxtI9vpzXHyqpeGa03+5oswBslb/GZhZtXHTGdVTU=;
 b=LlKUjchsekGPsHyQNuk0Wt0nCra6db10925/1wQWqWUapJCVNj57vuYjxJruMvyJd1lNwGvSgzvTZnwrgSeAShKtN5eZfVuXqpn+J/7lNbojQ5BP5aA83z9h1JSnqXIloemLZSF0Z0O7/i4h2C9jmnN9bi2F59aYCL2+AMyaXz3gpv7v36tqb/lV3GgTMyosgTGUCA5xBRkn0VIWKIfGGi3jCZPsrEIIcwcLaRy1tN99Zec77t++cz5ZlLI2ZTo2wKchb7xuIJRzvM/f4nAF0UKGptxqEX/jTvyqQY9leH1TbotZJf5e4+qhtER3WVt198lzVPf/HsbxZI8XY35dPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EezxtI9vpzXHyqpeGa03+5oswBslb/GZhZtXHTGdVTU=;
 b=VBi9uRKXRyeqsyjqaRcbDNiLvnWTMQ5NTdm25SUM5CQy+ppDlRF8rwO/swbZNOmYV+z8Wats/9UWmniUE+6mx5ZbH6AR47RDvkKhj4dATkGRSCY0Fgy9vn7PJVDP38NXM7Fg77PNKeABm1EajwUYYKGCwU1MRBfXw9Rsd6tvgqdtkoCZe9nAGXBHK5LtuS3VM+E0omPANOZjh8/HBp0ctqnMXoiEJczv2fV4Gve7ujG4OebgGXS/eRNamCFPSoJSBGAOYZ2RfE9UJGBlAzCW4sAYa+E5pLi0cY/xS4QGeA0O4C351iEaodwxRQiSpgmApB2R+LdbrFCybkPIBZJu3A==
Received: from MW2PR16CA0022.namprd16.prod.outlook.com (2603:10b6:907::35) by
 BY5PR12MB3939.namprd12.prod.outlook.com (2603:10b6:a03:1a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 07:41:20 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::77) by MW2PR16CA0022.outlook.office365.com
 (2603:10b6:907::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18 via Frontend
 Transport; Tue, 17 May 2022 07:41:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Tue, 17 May 2022 07:41:19 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Tue, 17 May 2022 07:41:18 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 17 May 2022 00:41:17 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 17 May 2022 00:41:15 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v2 1/2] dt-bindings: Add headers for Tegra234 GPCDMA
Date:   Tue, 17 May 2022 13:10:47 +0530
Message-ID: <20220517074048.54347-2-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517074048.54347-1-akhilrajeev@nvidia.com>
References: <20220517074048.54347-1-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22642784-df2a-4f6a-a314-08da37d8a21e
X-MS-TrafficTypeDiagnostic: BY5PR12MB3939:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3939EAE74298DBFF618D0BB6C0CE9@BY5PR12MB3939.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6EtbiRQ8SXFWp4c34awlsyzFWo6jCqhSdxDcVTIQHyxmnpAFhn4EkO/8T6uQ6Njd8Tlc2W+5b+zClHpYmCffK1VPQuXqoXf6AsEaaWZadGw9+wDWUYUzwzMZ8oGZOKznue6LYD9vMwuZ+ZltkVVgTZ+fwFghiorBiSYwtLQtENcze283wI4oGcaySLBr823esnX/A/X5uOK5zMV06rrErPU4HyiDjGxmRGqim8tnFpLpLM/uVvOCXKoA8bgTA9MBkUOSeoZwGeAW8vT7NduoTbKWIgRxhEAi5c+3i84b/I8BOnC4WlEz7qyUA44lWCQ+/156NRdajHcc9aHLSwk2qw847MclWgQVHNWOtvg8QwhtG5ldQjlqgtdEIxaeR/W0U/SSwAgxBQgY44nMHbf91uJ4uWGsckHsDvRLuec9udl7bgz8Ym0088xR3yp0yXVg6Aw+V+colDZcOs7jqjwn79F5e49w80Cot1nrvbF9AsgY8rUOCuttMXUFVlfs/diWbUmUgdnCuDT3EXDFB6nid1reliG0inSYdBAI+V9gY+MndfwUJFk/CE3EJKTakhZGS+FcRaAberWPrqlHYBc9obhub74NdhjM5R1yCBpwi4jGl41NjqFNUfgSwE/QPsZvzuFH59fiSvCOR3hTW3suhxHV0BHjaDF72J11C44ErEUUyyYgGnUjzaVDiGT06IPD4c0zvgt0KVXHMgI6SWLn5A==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(47076005)(316002)(336012)(426003)(82310400005)(1076003)(40460700003)(2616005)(7696005)(110136005)(107886003)(36756003)(26005)(356005)(81166007)(5660300002)(70206006)(86362001)(70586007)(6666004)(4326008)(8676002)(508600001)(186003)(8936002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 07:41:19.7477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22642784-df2a-4f6a-a314-08da37d8a21e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3939
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

