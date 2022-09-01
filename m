Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1475A8CA7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 06:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiIAEd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 00:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIAEd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 00:33:26 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4581FCF7;
        Wed, 31 Aug 2022 21:33:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYTs90w3Z7TyIeUFygSohDCW8xhepBM9vNPm9sSEWmeswZtfTVnUlVOtZpzIe999vftiAimwsTuAKi7iXzt1lW6KDM4Tt6zJN6GSj7DLL+rpjtKdyImpGAGEA64PB+J3GYzq679EQGlTDMo2xSjz+VPyQDdHpaNbfP08lrMKD+HIUfWXIeot70nhe2ZgPgoNfwHMK0rd+vO3wasHqflh4YAmGm5orcSb/jCPRfkEAsb5VKTiivrpNx/Ysj+fv9JsyAJNeo3USPO4l2KTArO1GcksKChU7BnQXzy+v6KQIap7zcTDbUsqNyDGoXO+cQzGyhHxca7xzsfl7GPoXDRGig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNKnhY/VwpdyZTW3oPFSIcsvsNnZr3+jCgc0G+4tk9Y=;
 b=OvHSF+oDCPSx30yh8Zbg6bzi/DOhVhRlqqNuhE7OpRdfMV+51qeRYsljEjlvDSqLypCQYjF0f3bXHL/Ir7f38IdwXiHUmqTehNdwfIB3C3Gg53QdV8fVyWK7wbjzt06BFBWQu9jKUoBQpmiuF0uI/EXv75rJhDpmQTNJJ6VDRpkYVRmfesDmlk9+CYsnZuenbmroSN4yLHJ+o//mwbGQacvDCzLxM+6DMmymd5vNdtWejqR0cNnMnt3oqqqxOlU8coosXEQSp1wPV3vqlrZ/ymnf4YzlzKXs3VSVGnhFsC9O3/kdFBOqNByi7b7PwoQsR4CeWMcTLuLM/9N1MmY1qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNKnhY/VwpdyZTW3oPFSIcsvsNnZr3+jCgc0G+4tk9Y=;
 b=MnkX1FMUzKK5jlV+f6CPoigMhsuKuMRl3FtQQ0+J7NlQ0WbzSGsf947UUtsHXxWUreR83LXObCUWW2BVCQB04alpZsAez+Uh8lq2AcogCLeD//nhxTi+7BOzca2ANZ0mdRFBwTuFm0ifADQf7dw8nZ7DCd+4aeTOTsL6/lbCHfjkjdmA276F/c2wJym3PRzHLHMigL9TFU+pDDS3ulN+M/8bcegMS5zHOLtEnsmQrCx/jSFGQ38XN4lSfmroCo8XnIVkwPiNmvadTiiMSzNVzXJuOIhmz6wc3oo3ay2e63vHFRmdNwBUmQGExFhwLaDK2vHXoRyiNH8p0BO33Lp29w==
Received: from MW4PR04CA0145.namprd04.prod.outlook.com (2603:10b6:303:84::30)
 by MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 04:33:20 +0000
Received: from CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::80) by MW4PR04CA0145.outlook.office365.com
 (2603:10b6:303:84::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Thu, 1 Sep 2022 04:33:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT112.mail.protection.outlook.com (10.13.174.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 04:33:19 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Thu, 1 Sep
 2022 04:33:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 31 Aug
 2022 21:33:18 -0700
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 31 Aug 2022 21:33:15 -0700
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <spujar@nvidia.com>
CC:     <mkumard@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: tegra: Enable HDA node for AGX Orin
Date:   Thu, 1 Sep 2022 10:03:05 +0530
Message-ID: <20220901043305.26634-1-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02c4e894-2198-4d2b-8a95-08da8bd318b5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4159:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CgyIazbEDJBLZ6b/c4YS2o5pcXNeZFajoClwoK86qz0e78Ufjt7Dicrt3fTHu9wMRVmacKOA7x1/KPJW2tWasvfLOUskxO2MDltmO9qZxct1YRjydBi5f/l8761YNhf8AdrXq2aIMY0/vEh7qQSu9j2JYru2RpeYA+mZIwEAS1GanPUt6DNgiZPkfVqSyLtz9Cc1BU9qhhAEiyvseghR2uu/wR2/jG/b9PBziUDl/PNm6toYvD9UTUwwQFK9kPdwDsq0yBOABRMiyXHwbKjRQ3qqByUOauiYYKReOQyheOYydkjWCaAUSKX/dFJFQaIKLYmYIb0fYPB/UDdTviSuVoM6q/rf/2/OXoIRMVXC3iuzq6p2KJo+3egW/GNoT8WWAwkQs+xxTDupQERR/QwS4206qEeQHv+EvYMeo95XnSZl18Ad8i+UvadYeCJMXlzwayQx50icR2WC/z8shuozKgLEYDoPDtdTBc8wI3PSwGXVQou8bCnoM4OjeWP8VQiq+ldUitjscHYZoxRsLPmfXnOh+Z3lRYg5ukTtL6oT8nLizuyhcuMBhR/eYxpuJl2dFn1TbsYjhx/bpngKLt59tOaSw+gQ5HPySwVbX6ZXMOKDTUIrktXMUnWnEhu4bMKYjtfVQvR9hudLLAaf+hacBX8PF6F/BRRL4OgbMtMSKzKIu6cNWC/LVatIfwp81jWatgDHM77BbSTR25Qt9cBqj4klpME6lvGkq9fVGAtHFonuWoGh60SNWjdizVaObg3d/tks4yo7oyojJTTMNxMVikAz/W3XRV+Zv4thCzNOM3U=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39860400002)(136003)(346002)(36840700001)(40470700004)(46966006)(26005)(7696005)(426003)(47076005)(2616005)(1076003)(186003)(81166007)(86362001)(336012)(36860700001)(356005)(82740400003)(40480700001)(40460700003)(36756003)(5660300002)(8936002)(4744005)(8676002)(4326008)(70206006)(70586007)(6666004)(2906002)(478600001)(110136005)(54906003)(6636002)(82310400005)(316002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 04:33:19.4163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c4e894-2198-4d2b-8a95-08da8bd318b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable HDA node for AGX Orin platform.

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
index 02a10bb38562..ee5776816494 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
@@ -2009,6 +2009,7 @@
 
 		hda@3510000 {
 			nvidia,model = "NVIDIA Jetson AGX Orin HDA";
+			status = "okay";
 		};
 	};
 
-- 
2.17.1

