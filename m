Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456A35A4AF0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiH2ME2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiH2MEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:04:02 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E7B9C1E0;
        Mon, 29 Aug 2022 04:49:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5Vag40Lz230W69eq53V4EJvs091tm5OIj5GN0cSKrKrLL/5j4hq06+81dfdz0kAfjC5oTuOBaNYKVkigRt7A23zUoP2xk1q07TZH30gbkA6JIx2w5oifpYKJeViAP3+MRJrQiIw+S0/u4PdftHKaBsSVdFuwQi5ITOanWyyTkY1H+bYiCHvcl++FJE3ey+Vkd4rEHdK9HVuVW6H45D78pKEmk/nHmcYffafNzoZFlUY8ScsSsUWhdAinTi8pVwGml90hpE2faReV4mPa9hi80BCeeyGckfoiaxoJppzhJZUDyHd7sJzAjbk3ULMShbeah/V5/7MAAQAx1EADSu9gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkGHmtUzmloTu2MJasQ4sGNQnbvxTpAUfn/QfMrFa88=;
 b=niGhmJQkH/vljcxpUol4FjfMD0MXvYLGMtok77clHKLhvBqN0f8d0AMy4Is8iLD3lYFKBhSkkWFe9yWSZRlfE2Y4UpZ2K5nLJUIN3c4hWFXE75Sk5GFMBd5wp0X7CbvBOudh414Bcr1dPuQDxxyirfWGlWRTtDJlpAzbfZz2GcrNKgDfzdCxHGfNsQbN4U7G5maO8ukVANZQnPx5gcG1OHqNZEHwgHtR4yoFsMwnovUS6cMsS99ZTR8SzN9TGaZeBI2kcFHIBi+Fi6+Ji4FqS4+ENEPC80KB+Fwyy8EEn4lJJOK+J7/hF1MVFgFljNdlDI3WGUpNPMlethkgNzye7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkGHmtUzmloTu2MJasQ4sGNQnbvxTpAUfn/QfMrFa88=;
 b=UUCEo6wHUU7DLLXzGu6BoIIZgyQtluKKDoAwRPrzw5Kl3TBvqoWZGJOKzy83Fofk6r3DxG2pzHtdhRoRPrhS/UBdSI2B3SxNf7D4PGLbnifC7q0yVr4lVtXpOGxZgm+G4WEVrrIJukR1fwRjZ01n/mnmcIPycP8mIbUomIBm60d6vagke0BMF2pewr/jNeraPmrcjJh33yViFTNjB42OzovtzQ3E7I+vNzUiGBeQQu9YHT69zG7S+Uz2Op7G93MmD7AAEcL9dcuvw5rw9thEFrxAZQb3KFKev0JzNjba/HEAzsIpjUnWWgwhfKnut2OalZxcij4Ix4YyjqImRH7scA==
Received: from MW3PR05CA0022.namprd05.prod.outlook.com (2603:10b6:303:2b::27)
 by BN8PR12MB3363.namprd12.prod.outlook.com (2603:10b6:408:48::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 11:44:49 +0000
Received: from CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::f7) by MW3PR05CA0022.outlook.office365.com
 (2603:10b6:303:2b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.3 via Frontend
 Transport; Mon, 29 Aug 2022 11:44:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT084.mail.protection.outlook.com (10.13.174.194) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 11:44:49 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Mon, 29 Aug 2022 11:44:42 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 29 Aug 2022 04:44:41 -0700
Received: from sandipan-pc.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 29 Aug 2022 04:44:39 -0700
From:   Sandipan Patra <spatra@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <kyarlagadda@nvidia.com>,
        Sandipan Patra <spatra@nvidia.com>
Subject: [PATCH 2/2] arm64: tegra: Add user PWM support on Jetson Orin
Date:   Mon, 29 Aug 2022 17:14:32 +0530
Message-ID: <20220829114432.19566-2-spatra@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220829114432.19566-1-spatra@nvidia.com>
References: <20220829114432.19566-1-spatra@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fbd424c-9e3f-4a92-16bc-08da89b3e0e2
X-MS-TrafficTypeDiagnostic: BN8PR12MB3363:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zRUeeXTxiuT1KIjr5Ri0tlvd8j399inUzvUnvpzQnJlwKIzrlqiXkjvxsaEwGM7XQtXDGhsPEPrIs8hDKFIznpMdDBKq0QO73uhitCZdhVDQuw+7dpoPS9rQJ8dpu2eaS8CYq5Cxcjt7IZWaAxTnp4jZmLYJ6U4upXjn8GlRygSQP135KKPUTwlbI6SEB+CNrSvZTqS6vsDsLB5X/9d5VnCzrLVRliN3iQopdpKBaPldKXl2rAOwENyXmBQj1ABkSgEdouF+vVoQbHxlBfDuWLbyeYT9J2ap7EsGMUPyMMFoY+MNw1611TIr5vNWKvk0zegs3W8w0cGGXcoolrhjHi4zv5y5NltSh914FIga5MU4eOv+AYBuXYmVpZCLkz2WQqCU40duVPErFsta2R+v5mANid9TTHLcPqOhfz8gtdRdTvs57mFk8YnFmbY0Lp8OimRDelOdBoOVygCWfEp7fqrCRoT2KWbB5fP91pj7lLRQVdKHqJIQonxPdkZoLSielVudfqBdI+4MhYkyBnZU+wDMGQH7Axv7FnhJZKV+FqVP+1DmfLFvoJ8ihybWfd7jvx861mTgLKaDQQX9lg8MGC1qiFYl6W4eQEBg2irnCs8RtLmyqKYyutt+DD7HULT/yP/V3Z2yP6DgPnBviZeWYsUf/Y+stmj01WXWxrED+CCb+0U0bwOBatgRqcTI55876xe3T2E9mdC4tLQxApVl55i65s1lIdI83GSXB4NFfv5YqViEJ0vez/kpUAEnx7/r9OQ1CWituO/iwBbhYeDsJz7HzJgKfXRsX6KGbGnworxIS3km+7sJP6OK3cwVURSSc3jldO+dR50AKhEVxN2S1Q==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(376002)(39860400002)(136003)(36840700001)(40470700004)(46966006)(7696005)(6666004)(86362001)(107886003)(26005)(1076003)(36756003)(426003)(336012)(2616005)(47076005)(478600001)(41300700001)(186003)(82310400005)(40460700003)(316002)(4326008)(54906003)(8676002)(70586007)(110136005)(70206006)(82740400003)(81166007)(356005)(5660300002)(4744005)(36860700001)(8936002)(40480700001)(2906002)(36900700001)(16060500005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 11:44:49.0317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fbd424c-9e3f-4a92-16bc-08da89b3e0e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3363
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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

