Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D904F5A5B17
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 07:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiH3F14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 01:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiH3F1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 01:27:54 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F9C86B64;
        Mon, 29 Aug 2022 22:27:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFuaBYki5qUMqVfRfFMkiI/Z5mC/vDfmSWiO6AyLoDkCjDWZALJT4LFPZZ5a2GxM2V+JjzY3d6Wi5E7zGHfIbcmD8CZ+zmYUBCBhLxRdCXLkrciDa21svC34H6hzq4cdZub4RuIJfr3p0Y0dAyY87C7zqQYZgk/vxI749LbiyuHXW2wnuSJfUzj0lPNcmaZLPvKu1oy7twTO4+CKvcC6qD69FngUv7JY0CtEAiiby9tjI4eKVqrlMujhoclkMIhdS1EnefzQ/Yv+34DSsCv3Uq3eIoWcbnz9zpfK4lHQP/qLdISFSgw6vSEJpcJojl4gvxfTMIEI9KMnBMMYgiaWNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wulo87bfDzRXrDB9shNu4p2mW3gg843XbJUidjIUbP8=;
 b=fTwqZOeYaFL0I12vJHm0iCBpeIznJibNLODcOx3o17jx81NFcLsSV4pI5QSVtAjy9fuAoOajtELqhFOy4AuBhl1Q59vH3N/KtCSoet4iqJ+6dEblo1CTkCYjzBsff0Z8hybaLjm5GutvPI/T9rRrQEkLIfdAaRhYu0GAGyJN0w3NKxlwCXKRNwzaHTYMBz8LZ/tFpIxPtQDCy98UGKd97BhKXnzsi6rVuy3IIIRO68kkML9Ll/qnMbaZshO2I/wHjMUIq0azBeHDf7UIBtE/uLkq0eB7ZZq/q1XueeV5NAbeJwb64iE+BENWWBvhi6l89mPmw8noopDLDk7CsmZwdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wulo87bfDzRXrDB9shNu4p2mW3gg843XbJUidjIUbP8=;
 b=n4oLLLd03x3bHRuYJFqKx+vssKZBzYfinr2Nsjwi7ABAi0UirUCVpY0/6OIyKj0yKN+bQsYUUCXb+em7GdciKbjVPCG3ZGV+k6ayDq1ZnEMwA2fdmeQ278TCgWPVWdv55IXLnWu9rfsJiwqYiErWRTrLt/Zg4aqjVnHJAdbB6MgnoowacwFfcJuq3aObFJwise/g+f1VVxycunGYkSYDNdFIpCC7t8J3N+qJmO1eSPtZ8wpT6JkyGiAQvrczXNA0R1razSIgfkCfrVNLxYLceIEtR0L+iX6i5eGkfgy5zCBu/AdjqTsi70njCnJdamyC47WYyde8ZmzVmS8r3u74eA==
Received: from MW4PR02CA0018.namprd02.prod.outlook.com (2603:10b6:303:16d::17)
 by DM6PR12MB3116.namprd12.prod.outlook.com (2603:10b6:5:38::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Tue, 30 Aug
 2022 05:27:52 +0000
Received: from CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::81) by MW4PR02CA0018.outlook.office365.com
 (2603:10b6:303:16d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Tue, 30 Aug 2022 05:27:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT111.mail.protection.outlook.com (10.13.174.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5566.15 via Frontend Transport; Tue, 30 Aug 2022 05:27:51 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Tue, 30 Aug 2022 05:27:51 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 29 Aug 2022 22:27:50 -0700
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 29 Aug 2022 22:27:48 -0700
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <spujar@nvidia.com>
CC:     <mkumard@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: tegra: Add iommus for AGX Orin hda node
Date:   Tue, 30 Aug 2022 10:57:36 +0530
Message-ID: <20220830052736.21348-1-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45b202d7-a3a8-472d-be60-08da8a48626f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3116:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7zCcXDrbCvdhGHmjGHq+iRvYqnvBST7tjZJU6HLObeYlmFeS++TJoQDu+IHWQbn8VCWXIbtGh9lJao0teMUK6rxkT+zBG/8tAXtXCqK6iaNd3x0shvNi2fkGWK1KFQQzjhBKjAHKEVwate8yC/3LrOZkhlsC8UAxNRO7ncE0raz/K00H2Fp1AAa17Loi+TV2H5r4CPmcr/vE73er730wqbwqL5JJIwXfASkv/vDmIvXucY5ze/L0t35oBbEzlM63h+ucUXD+W+n1Hg5/YXBtVgXJmX8AmY2jA+PHYnL2noh+F5E6DvhAzuwHJaQXehnvpocaXlp2KePVsANeOQ7o36YV2vx4W7iRx4qvz0ucwCV+vu4gvlfnc9pSCdmXQRUbnin4xesSLlpwSAMDCbyNNmGfm26IKTLncD2K5KRwAGSUb1ke/vDTSMZyAeGxnyVYxKkPcIkJsE/b4lRdpMtSLAVMXDQC7fUivtx/BwGuuFsyIoG1Rm3f1y5c77MA0ATGlE5dFQlQkby6AkwuKfxZsYtERSXjClZ1ViLOt1Jo2FtbLoY65rWsZXdY3czU5NazvPGp7cPB4DKe9hf8yXOWYMsAXDUIayxXSoPWikhN0XryFvuYaHZJ30onCSlrwVb1lGxmZ02SwLAE5GqnI2GnDgrlkHiAoo4/yvR1JXJJMdcDM7YwlEiJ/4R3QlXeDwMPi7DV8hnhnqqQwXJ+03lguBVmAMBHP78dJd8HLeZ+4YFGrBCewTHipddXfFGU3LozuBOkrYFAfYUj9NOwlbiZudimgGiuyHdFfsABdRSx1euS1gUaEPd1F0QJojREeTMa
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(376002)(136003)(46966006)(40470700004)(36840700001)(40480700001)(82310400005)(36860700001)(356005)(40460700003)(86362001)(82740400003)(70586007)(70206006)(81166007)(8676002)(4326008)(41300700001)(5660300002)(54906003)(478600001)(110136005)(8936002)(316002)(6636002)(2616005)(426003)(1076003)(47076005)(186003)(2906002)(26005)(6666004)(83380400001)(4744005)(7696005)(336012)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 05:27:51.8865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b202d7-a3a8-472d-be60-08da8a48626f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3116
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add iommus entry for hda node for AGX Orin platform.

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 81a0f599685f..a1a6d703c002 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -897,6 +897,7 @@
 			interconnects = <&mc TEGRA234_MEMORY_CLIENT_HDAR &emc>,
 					<&mc TEGRA234_MEMORY_CLIENT_HDAW &emc>;
 			interconnect-names = "dma-mem", "write";
+			iommus = <&smmu_niso0 TEGRA234_SID_HDA>;
 			status = "disabled";
 		};
 
-- 
2.17.1

