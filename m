Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF83529B33
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241404AbiEQHl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242808AbiEQHlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:41:36 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73837186;
        Tue, 17 May 2022 00:41:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N35ofyLx6hhX9rl6Bppzb5DfoQxuGM8bE3ZW5ojNELQUUQv+k9Y5a/uQrfxcZ5G7WiGqM5DQSxrx6tAiIWC3B7WXHj8O3n51hB7SWFfIm08w8qnfksbOrZ0CS6IMgdtVi2esZg58Zyc6lfs3+nek57x9sue/vxfaAOKZoLF1gZqIE0cXaZbTajzPdimETMMsnt6PKHDuLOhkM0o1a1HNsHq9HgzaNlNMECCKna/GkHOUo+1FjU4TIOEMwz13v6+7VHa55Vk6MNxnbD3np4JwjDywgZgVgV3xiJphAVUw3rGpYs2pR3UCTHom+1+SPnYigObFdAL0rZS6YXid1SXcUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTlQjqishUd6hpbR03IRHh8CxyKCvM7330RlHgw2fXI=;
 b=eLMUgBBgkg1KpCQb+/RDyE/bhGiV5O3y39ddso07daSSc7Grt4bZ9xnifTUaPzUslblROt0NjSrUXik0xAaZH+UwQXTy2+643Mun7lAn/FqhMc2dz/CcM+zOUwMFbOuZaKCl3WxtJHw3aos3D1qPYywlL2yD5G9FHNem6GM3UagKQ5HM+yXVCOA4Mi+AH187ksAiXeIxoeirkbVTMD8lp0F2QTKr3f5wNiMlW/zNI3w36Yq+j3AO1+9CrmxjLWizobJGoURukvpL+zu0MEfgznFCzEPtyeiLlUHHo55NibD+zeti7MtF0bPqxDZaENkZvlfiTnTdrSxqhE+BG7SklQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTlQjqishUd6hpbR03IRHh8CxyKCvM7330RlHgw2fXI=;
 b=A8Kk6OW64a1s8y7OMwKVPIAP6dqZhjfIMOb3AFFHLx81u4ZnTBlYJMC0o5FPFwN2JEJuQkKuDiUMzt1ly0kzYexpNp2aCpV7Jz21HNxZp3t5inGk08mo6h/nENr5UbpG80WLddQhQ5vOkSkB4/wyQWLaPINB3dzm5oQalN7IKBFpiroN4IoDhtv5hQ0DK50wdBK31CPB0P9xOZaW7wf9BCFWs7Fl3+on1Vu1IN/XyZNEK4hbvEnOngMjevHoWd1sHieZwZsJsaGV0zyX9g6kp0mradE5IUW4XZ9NLwnIZXWPEKpLS0SHnAnDcpG//T5OvtMMtn1sQxcvfn9o1VZsHg==
Received: from MW4PR04CA0100.namprd04.prod.outlook.com (2603:10b6:303:83::15)
 by CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 17 May
 2022 07:41:33 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::d4) by MW4PR04CA0100.outlook.office365.com
 (2603:10b6:303:83::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18 via Frontend
 Transport; Tue, 17 May 2022 07:41:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Tue, 17 May 2022 07:41:33 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Tue, 17 May 2022 07:41:32 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 17 May 2022 00:41:31 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 17 May 2022 00:41:29 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v2 2/2] arm64: tegra: Add Tegra234 GPCDMA device tree node
Date:   Tue, 17 May 2022 13:10:48 +0530
Message-ID: <20220517074048.54347-3-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517074048.54347-1-akhilrajeev@nvidia.com>
References: <20220517074048.54347-1-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16db16c8-1d4d-4714-fe8d-08da37d8aa0a
X-MS-TrafficTypeDiagnostic: CY5PR12MB6252:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB6252D61764410120F8100570C0CE9@CY5PR12MB6252.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cb7kcifnszMtQ+03n1rC/buFzztD3+Uha9bLDFKGobir1xytcdwFayeRN7RkpA1trzZ2Q6eEKHkcAZvcvz+wHghRWBJ2POaw6ytORXB1bm07yMCkQsZLCGKpBtJWc3T6FZLeob5A1AQzr8ajdN7OvDEIM99O7Zg0qnnNCw7jJdCJ3pWsy2KzhkA2MVXfCjTMrUAiRMzBtBuO37E7c1jP1UgYap7xYjU+2h0y88Dpg+qloizwFqjgV6oVIo+mZr7z/e7l4nAdzEqMaJBPCsCCvicdghXYc9Kwywyac8egU5GBqNHftxmp3IHvaQeEeymmnuyKwlqVG97Pj5ivrSyaB03baLIwUY0ipkRF3ecyEzMUnqy+GA60ko8Uibc95osxBm0BNeVZi91JquwQatmfxa5by32al23VZMYmuwiO+NccfTo+kF7ktT9fymQLofGjM5JzT/bQ1ePJVhKJDoZ41aoHHUZyRtKs5t7dbq9pX8+4k+uPmQpUBgPXrx0N+tkFFvIqB17ZROoPSkn7RSMRFO6KiW3FardZm02PZbV9FEvVDJriMPkzrDE+1U85zh6y0DYHCSYhJ6E9jezFShXXJGweIHWJ8+7Uy9sMsfrdz+JenxT/HXi7ck886pZPu6KCMBbBUIBj9YDfWZh9RhN8pDU9I5CSGO3MJFTmw8CH5IoCUbmLmW4yf+oIN9zdzSs3cOFvB/O2xA5pbZ2YTI6I+Q==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(508600001)(2906002)(36756003)(316002)(81166007)(82310400005)(6666004)(36860700001)(7696005)(110136005)(26005)(1076003)(107886003)(186003)(2616005)(70586007)(5660300002)(356005)(70206006)(8936002)(8676002)(4326008)(86362001)(47076005)(40460700003)(426003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 07:41:33.0563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16db16c8-1d4d-4714-fe8d-08da37d8aa0a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6252
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree nodes for Tegra234 GPCDMA

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 42 ++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index cb3af539e477..d54167845d04 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -21,6 +21,48 @@
 
 		ranges = <0x0 0x0 0x0 0x40000000>;
 
+		gpcdma: dma-controller@2600000 {
+			compatible = "nvidia,tegra194-gpcdma",
+				      "nvidia,tegra186-gpcdma";
+			reg = <0x2600000 0x210000>;
+			resets = <&bpmp TEGRA234_RESET_GPCDMA>;
+			reset-names = "gpcdma";
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			iommus = <&smmu_niso0 TEGRA234_SID_GPCDMA>;
+			dma-coherent;
+		};
+
 		aconnect@2900000 {
 			compatible = "nvidia,tegra234-aconnect",
 				     "nvidia,tegra210-aconnect";
-- 
2.17.1

