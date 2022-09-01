Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A8E5A8D93
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbiIAFsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbiIAFsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:48:08 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC1E1670FE;
        Wed, 31 Aug 2022 22:47:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBQ2iBfUmLVyf/L54G52RXElvzrIqdG6Jl2OCEub9XJlVGXMi3hWW5XVkKk7cLobl2k1aESF0RP4bMONzJ8ZOR9k1+mH67RF9XSO9SQJidAbXWdtofoV0Cr+/oAxPeWyOxVt7WnbJBKkawecfUmCSUXgPJ0uF1sAbw7NKMkZ5Z7bnz2YipK5PJMM2oQeqEAObr6/po0p6vaYaR8UZVMUiKtSxn844ENUqY+5r/pjZ8pSkYs0Kf/NgcTdZfvXreRT/8A8F9w7EmtHAP8hSCIozEespp+hfmNhr+OtScwhKzbblg7i24MpxW+A3470Q8v+vNM3Oc4SgaFX2WQoNpQjWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s87VHqP+2XeWHthr1d+kkQXe1eQImTy+mvdrhSHUPqM=;
 b=dKfTmdQoo+GULRbMllAOZ4ncfdohVHny3AQZIQcWB067sXsDKeo8zzLqxSYQIC2kj1q7JnC96HG35S4qZFPqwsu/ZrMV7wrngQI6zpvuTjPacZV4kGLOLgcUsMHuWCdlPac0EbquYndzULwE5RtAGTY59/5yMoFJQDkTp1wUt7+NGlmhTMLGXXV4uDa5iOjDZS1gfpBhdgYnz3XYYhSgjHwbWgxinMw0QD1dmiTjzqvITkclSGocbGlI4s8bU6FavCXf8EMEQTvPPFhKGBBuZ8v9A6HuWehAx8LL9y0R8+OGgmiJzovuQpXH+dNkR5nlcmX0Q7JNxtLh8zol1Cnl0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s87VHqP+2XeWHthr1d+kkQXe1eQImTy+mvdrhSHUPqM=;
 b=NOHNKMDpWzP5pRqyiDDQR84I7tbY9vHauL5aFdtyYjHLrO4oPixZwUBfPIGQ4XNlICYFv6M2vZBhfAjraHLorwrS28fGTbacILvZAfnVO2s/yvJrTOuVneOodM5080IzxzRCJ6WeEf+qFAcpWxZgbiqFe3vfZ8BVAPG1laH5GSE=
Received: from DS7PR03CA0124.namprd03.prod.outlook.com (2603:10b6:5:3b4::9) by
 SN6PR02MB3936.namprd02.prod.outlook.com (2603:10b6:805:35::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.21; Thu, 1 Sep 2022 05:47:50 +0000
Received: from DM3NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::21) by DS7PR03CA0124.outlook.office365.com
 (2603:10b6:5:3b4::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Thu, 1 Sep 2022 05:47:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT062.mail.protection.outlook.com (10.13.5.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 05:47:50 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 31 Aug 2022 22:47:49 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.6 via Frontend Transport; Wed, 31 Aug 2022 22:47:49 -0700
Envelope-to: broonie@kernel.org,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 git@amd.com,
 michal.simek@amd.com,
 linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 akumarma@amd.com
Received: from [10.140.6.18] (port=60724 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1oTd3M-000Eqz-Ux; Wed, 31 Aug 2022 22:47:49 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <git@amd.com>, <michal.simek@amd.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <akumarma@amd.com>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH 4/7] firmware: xilinx: Add qspi firmware interface
Date:   Thu, 1 Sep 2022 11:17:28 +0530
Message-ID: <20220901054731.7705-5-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220901054731.7705-1-amit.kumar-mahapatra@xilinx.com>
References: <20220901054731.7705-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3040dec-3dd8-441e-a3a6-08da8bdd81b7
X-MS-TrafficTypeDiagnostic: SN6PR02MB3936:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AxBaZnyHsnH+n29W/6EAYouvXUmNyVU5Mtn/vYXaff68lzTssFSaCgTw0gJnXdAt0h3KLWkYpMEVr0uX7pjZXoh18CIN0la9ZSwEbglCZFMLLNCg4PfYxbQzL+0nD6+oP3VCEwOBHPhdl2e3x3I5DspDt+R76f1rqBDtSKt0cTbRAfwPKoGy/VlxaZuvNgIqMoNE6D72ZhYdRNTxM8aNy4DWmmAV6gDMCvm/Jt7UtBqiz3ru7KgWbcDJ+HtPsMYKNKoxnTWG+LHaf+9FxCWCB51kbXMeK+IMX/68EJ7LUpwrEhn/TroLcDkIRGEmOm+vv5VocxLjgM21JltBKS5afgfxj+r/lyJMD+SDb6sRmIV83bpwp5DNx+1HyoMo0AGhC9f0B1kL1jQiVebYeBo6YGWRBelSMna85uRdN4sZbzMO7M399SOsDeHZ0Chi3PvvX0POtZvRxa33YmlumW+mj0oTgvmBxpPR1dr9Ns8LnH0OQDucUIkcaMSynG25cfAR0sJ/6ONcbrSJfTW1Sztv1uDuiCOW7DMXd3sN6kggy0ExnDHxH1nWDmOSxP+8qe8UCqIICfPBk3Xz7xu4N/+yzs7rICbXmKGVXC/xLVju72E4bEyOVGbXlfMqkmZW1ATeU+komxpaus4d/KMG93SQLWXZZGnZxJTxWRdL+JupTvX4jxyO40nNRluZ2zSeZHpg3eHL6d3pvWS1QDqAKPkxXR1MNtlPf6Bqvb5DJFloSvliitvibYPG2h15rrzIpFTIKnRekw8onnBYNvUYHfy1gjdABBVeNiZ+BPX1RKI3FnA=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(136003)(346002)(46966006)(40470700004)(36840700001)(336012)(7696005)(2616005)(1076003)(7636003)(186003)(47076005)(426003)(2906002)(83380400001)(36756003)(26005)(356005)(7416002)(478600001)(6666004)(41300700001)(54906003)(5660300002)(8936002)(110136005)(70206006)(36860700001)(70586007)(40460700003)(9786002)(4326008)(316002)(82310400005)(107886003)(82740400003)(8676002)(40480700001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 05:47:50.5581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3040dec-3dd8-441e-a3a6-08da8bdd81b7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT062.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB3936
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add support for QSPI ioctl functions and enums.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     |  7 +++++++
 include/linux/firmware/xlnx-zynqmp.h | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 7977a494a651..b119f170437a 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -829,6 +829,13 @@ int zynqmp_pm_read_pggs(u32 index, u32 *value)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_read_pggs);
 
+int zynqmp_pm_set_tapdelay_bypass(u32 index, u32 value)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_TAPDELAY_BYPASS,
+				   index, value, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_set_tapdelay_bypass);
+
 /**
  * zynqmp_pm_set_boot_health_status() - PM API for setting healthy boot status
  * @value:	Status value to be written
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 1ec73d5352c3..b38d12b6040f 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -134,6 +134,7 @@ enum pm_ret_status {
 };
 
 enum pm_ioctl_id {
+	IOCTL_SET_TAPDELAY_BYPASS = 4,
 	IOCTL_SD_DLL_RESET = 6,
 	IOCTL_SET_SD_TAPDELAY = 7,
 	IOCTL_SET_PLL_FRAC_MODE = 8,
@@ -380,6 +381,18 @@ enum zynqmp_pm_shutdown_subtype {
 	ZYNQMP_PM_SHUTDOWN_SUBTYPE_SYSTEM = 2,
 };
 
+enum tap_delay_signal_type {
+	PM_TAPDELAY_NAND_DQS_IN = 0,
+	PM_TAPDELAY_NAND_DQS_OUT = 1,
+	PM_TAPDELAY_QSPI = 2,
+	PM_TAPDELAY_MAX = 3,
+};
+
+enum tap_delay_bypass_ctrl {
+	PM_TAPDELAY_BYPASS_DISABLE = 0,
+	PM_TAPDELAY_BYPASS_ENABLE = 1,
+};
+
 enum ospi_mux_select_type {
 	PM_OSPI_MUX_SEL_DMA = 0,
 	PM_OSPI_MUX_SEL_LINEAR = 1,
@@ -451,6 +464,7 @@ int zynqmp_pm_write_ggs(u32 index, u32 value);
 int zynqmp_pm_read_ggs(u32 index, u32 *value);
 int zynqmp_pm_write_pggs(u32 index, u32 value);
 int zynqmp_pm_read_pggs(u32 index, u32 *value);
+int zynqmp_pm_set_tapdelay_bypass(u32 index, u32 value);
 int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype);
 int zynqmp_pm_set_boot_health_status(u32 value);
 int zynqmp_pm_pinctrl_request(const u32 pin);
@@ -659,6 +673,11 @@ static inline int zynqmp_pm_read_pggs(u32 index, u32 *value)
 	return -ENODEV;
 }
 
+static inline int zynqmp_pm_set_tapdelay_bypass(u32 index, u32 value)
+{
+	return -ENODEV;
+}
+
 static inline int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype)
 {
 	return -ENODEV;
-- 
2.17.1

