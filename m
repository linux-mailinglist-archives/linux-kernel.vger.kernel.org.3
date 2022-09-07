Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0794D5AFC56
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiIGG0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiIGG0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:26:08 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE5786C09;
        Tue,  6 Sep 2022 23:26:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtOre6gA0gNDUfSa+jUdjYjxIT5BoOmdXYW77Rhrvz4D0LFpKei/rgAyN5QF7cLOKuOVMifBx7FTA94YF/vQJXdO1hIU2pmLeG5MHlfiv+U7kttxEptovz4BrybbdVEGKbCeWfNnSgyL/66PlzZQJrjPRO3Rfs/vZrFibWLi4DV1FV8UfzxmUliXcreysbciTI/c5q0hP1gWgAtB4ft1gE+DvYGEHAEe0nb9MXE6OAhd9BpZCqSD6T0/hh3rehtUQkc2wkjyMNhg/0xUoP+SsXO+/cucURyuFVLD/pdJQPi3hjkM76TPwKrQNaCyiPdPX/AtojZXid6EtWIey8lkog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkGHmtUzmloTu2MJasQ4sGNQnbvxTpAUfn/QfMrFa88=;
 b=crWJ6mxTAxLK3DRM0MkBwyT9hr5uT60yZL0btmHbvB+71QUXTH6bS/55UWHileRRaMgEZzmrE37wj1tMCrmINDc6nnmUCqKRdTUHTMsf395QiBI+reZ+HjLep6hBPKxknDHH/yr1Rb+QZe9RDmybCJxnSlcmSFRuy+LTdIV57WSe35vNV9UQlsSKcmowvuVFXbzadHMqp6BYR7z/yWO9O0b25mQJhXCqa6ctngzrGsydQud/BdTsyhi6rRUQDU+z2VQpHT3yBFiOlv0qmPzyS5Ae84uk0auiIdJw9tggLVTHVRNWhKFYLDT6xnUoLwKLKDmoHEI6je9FvgnL+2t6BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkGHmtUzmloTu2MJasQ4sGNQnbvxTpAUfn/QfMrFa88=;
 b=rQIzI/4iOLFu1fkRddwc7+1CvveAEQ8Shm8WKRAF3QPnjGxYQhYE/00bg3RMYGWLSQ0syG/3vlVRt9+98zzBQiEIz5fbJ0DbvM/bREQfdU3yTbwYWnR4+dzsDKJ5omb/1dquaTTN0MLUfZvjRz3N/ipe/gcqtJ/MxeQmPS6piHe9GcxlcP8ztbTXEhz/A8X6Xeow5fQJgWt0WvpSGKoYpER6spkfalJjz5c9r8mEKmobIaWMc7vDf500O2mzSa8C7zoYeQMB4HJcnm5JDL9MeQZl6CWvXiDuUKfIc/2b/jG2X6BkJ+5NAIZRbDViBtXuGM8wE4Lq7PBmEmXY/F2bow==
Received: from BN9PR03CA0557.namprd03.prod.outlook.com (2603:10b6:408:138::22)
 by DS7PR12MB5718.namprd12.prod.outlook.com (2603:10b6:8:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Wed, 7 Sep
 2022 06:26:00 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::47) by BN9PR03CA0557.outlook.office365.com
 (2603:10b6:408:138::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15 via Frontend
 Transport; Wed, 7 Sep 2022 06:26:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 06:26:00 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Wed, 7 Sep 2022 06:25:59 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 6 Sep 2022 23:25:59 -0700
Received: from sandipan-pc.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 6 Sep 2022 23:25:56 -0700
From:   Sandipan Patra <spatra@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <kyarlagadda@nvidia.com>,
        Sandipan Patra <spatra@nvidia.com>
Subject: [PATCH 3/3] arm64: tegra: Add user PWM support on Jetson Orin
Date:   Wed, 7 Sep 2022 11:55:45 +0530
Message-ID: <20220907062545.30203-3-spatra@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220907062545.30203-1-spatra@nvidia.com>
References: <20220907062545.30203-1-spatra@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT038:EE_|DS7PR12MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: fe1a4f26-b542-426e-190d-08da9099d522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pdtw8b3OIWIbKCRapyDoIEgsMhF57CTiSjAamm74NEYwslZV/Ic0pG+84YJpOJ1dJgA59PV0VQjU56y4G185fYb1lzJsk3xHcMPZOIHRiY7VR94N9movAHEgPyf3Upt03mj5JNE0bD4Ly91KNP6Z76bqhR7XMcUIGyrxfJt2dEWxOsDtnF1RoOQ1O9j6f6sT6pHp4dnzh2tG+YiMV1uerofTml3msxUsQyTVS1UkDVIqYEuaEUQ1J+WsY2wTjOn1XuUnPCMmMVAG99WGl/WceK+THvb2dJiftQt8QWGV2KscK1N6SYkJqzh86mt0pGhJyBWDqW2i7gEvF5YIauchVujqRA1H0xNKC2X+Lo6qyYue6XXYMgv2JQFsKiLC5JzbjBdgx3gZjrDS5UOlGCP/1zaa43VZ5VfWkF/AFY6Q4x1cGfWzfp+0MZMb/NQc4V40X6e6sj0S7pSJZ1CAMV9cyG+VtWbSYwF6ESxkOsNMixGM01B5uOzD9zqtMrYjcKf8o4cvDHI2vsBl7kY2OkYJnEi+d1UBQBssSLWChDitUCjw0jxLnEtfrIVJOZTuuf1/z3C33LFLyb8lufxaUgYA3HldHiKteH2iRQiKE/3WNmVHAsafLI8SEQ2nLuf/K451EES1ktPArWMBKp3suz/3Cf3xrF5YT4Cl7ZK+fUKLRzck0PDFDqJ0nnuxGpfoe+CI9M2/XoczFs5rkn7Ki+zDFFtPUk3Y6WynSCKTQMUCROQN+HhhseQ2AFaamjU1zehrQcLRjIv9naBEmqdlzdpxeTL8YUP2YBS7BlSde4EbJxZo5q8SepwitbmZgm0WbOyTdCW1/GTEy9pr0XZT8NrLqg==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(346002)(396003)(36840700001)(40470700004)(46966006)(81166007)(7696005)(478600001)(26005)(6666004)(107886003)(41300700001)(54906003)(316002)(110136005)(82310400005)(82740400003)(86362001)(36860700001)(40460700003)(1076003)(356005)(336012)(186003)(2616005)(47076005)(2906002)(36756003)(426003)(8936002)(5660300002)(4744005)(4326008)(70206006)(40480700001)(8676002)(70586007)(36900700001)(16060500005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 06:26:00.4649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1a4f26-b542-426e-190d-08da9099d522
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5718
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable in device tree and use it to drive the PWM controllers on
40 pin header of Orin dev-kit.

Signed-off-by: Sandipan Patra <spatra@nvidia.com>
---
V2: Overriding by node label instead of node path.

 arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi
index a85993c85e45..5108013a18c6 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi
@@ -3,3 +3,15 @@
 / {
 	compatible = "nvidia,p3737-0000";
 };
+
+&pwm1 {
+	status = "okay";
+};
+
+&pwm5 {
+	status = "okay";
+};
+
+&pwm8 {
+	status = "okay";
+};
-- 
2.17.1

