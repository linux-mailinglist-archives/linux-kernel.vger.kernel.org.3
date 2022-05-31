Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64341539A2E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 01:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348741AbiEaXoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 19:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbiEaXop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 19:44:45 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2067.outbound.protection.outlook.com [40.107.102.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6B36EC7A;
        Tue, 31 May 2022 16:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0ZpuDH3lvZipMmbQ244sH3t3L7qbhz1IMFBRFQjBBMqLAKT6bEPMyNVbr+j6bGvdGDBMP7QrPtF8reqLQo8Vs13GURu9dBkSYTi+PcCHrpssuRZ6+ehKHSjyzUhlz2eqVNxRNOu4Evu92NGtU/EBWJ9BaIlwH4HuQMl7aTxGugc4T8DiNM/kHveNOj0dSW+tk6g8ya+PZRc3AX4+T1bUdvCR+hh7wO0zTrBhv27rx+gqYxww6DPKt1aVPBjyiw+87K6211KGxMfpUiMW2TfqMbPbYGXbZg+q1o8eVQEVl4/vmuGm8C8rAh57ymZBqHI2z4gVKXru3s8l8HkVHdC7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGpiX34glS3099uptCgpWGaxoWD5DpITex0SUkAdqLI=;
 b=dfcsPJJryTdysslBRZSmABgO03xRrxpY+fgxQBax5nV3I79VSjAL51o9vJMtHURF8bDu6BmnDv52Kykg1quFugFAjuBgoR94aevvnLgBV1DNVVeThMfV+pcS4VH02VmX35bHJZ8IADuM9K7hcsBPUkZTcDTWb0/T3FxWL+4Rh08o1UzDiPPxtIriBd0k7MrUUIHVjdfNg0oQJ31cpdv0bUY/eHaEgMNzkdldn2RubMnlAaJTg2frPyzja1X0dIxR7WD8Ift4BA3rbcRtzECO0Cz9UviYIpuMCT16rPLpRii8PH+SObfSRFAkLYHui3ntK4A8vd/vTvOgYMSEP1i8TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.openampproject.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGpiX34glS3099uptCgpWGaxoWD5DpITex0SUkAdqLI=;
 b=XobGEyc3n0c2Vj9YBvVTU1WRJgELh8Lb5xU9p/DGx9dCZouKi44yryKpVLSZsbDrr7pmXWxxEMtLH0p8/TgvRFcUlMSis5uJ9FJcDBrV91bZhFnji4ADeJ9lgDITOazSFwA/lhVGNBNdaGck+xxMgd9YFe0LrwksUpa8TgdKTyw=
Received: from DS7PR03CA0307.namprd03.prod.outlook.com (2603:10b6:8:2b::13) by
 PH0PR02MB8812.namprd02.prod.outlook.com (2603:10b6:510:f6::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Tue, 31 May 2022 23:44:42 +0000
Received: from DM3NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::b7) by DS7PR03CA0307.outlook.office365.com
 (2603:10b6:8:2b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Tue, 31 May 2022 23:44:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT037.mail.protection.outlook.com (10.13.4.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Tue, 31 May 2022 23:44:42 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 31 May 2022 16:44:41 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 31 May 2022 16:44:41 -0700
Envelope-to: openamp-system-reference@lists.openampproject.org,
 bjorn.andersson@linaro.org,
 mathieu.poirier@linaro.org,
 robh+dt@kernel.org,
 krzk+dt@kernel.org,
 linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.3.14] (port=48904 helo=xsjtanmays50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nwBXU-0006jm-VG; Tue, 31 May 2022 16:44:40 -0700
From:   Tanmay Shah <tanmay.shah@xilinx.com>
To:     <openamp-system-reference@lists.openampproject.org>,
        <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <michal.simek@xilinx.com>, <ben.levinsky@xilinx.com>,
        <tanmay.shah@xilinx.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 3/6] firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU configuration.
Date:   Tue, 31 May 2022 16:43:07 -0700
Message-ID: <20220531234308.3317795-4-tanmay.shah@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220531234308.3317795-1-tanmay.shah@xilinx.com>
References: <20220531234308.3317795-1-tanmay.shah@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e1366f6-d2d0-4505-837a-08da435f88ef
X-MS-TrafficTypeDiagnostic: PH0PR02MB8812:EE_
X-Microsoft-Antispam-PRVS: <PH0PR02MB8812039AA213006FB9697D69CADC9@PH0PR02MB8812.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SFnZnm4AKpefV7WqKToTZfcz6nRLjd7S7yaHb57moMY3Wc/2bfiawymjHf+eqgyqndYGQ4c1y3vdkOi24mhJeDPrnZGUV8kIRFbAqI/A609y9ufj1IwJiYBzwoL60MxERzYa9fX/jWXMgFdxNQCSWZdGuzk4MsTvBP4WeivVNrlt2T8VDsJCTYK+KKl5exJ6rCUmmAdbdwKyTokIkBRYUq8xOVK3E3KNNNvUEFx1Qq5A4PH3goh+jgTKA9q6S2w73S+jwf8SaXguJCYuiu5Vtz8JKvfPA5poHlDV94Cae4y4G3SDiBk8KF8ZNWrYy7Dgjvc2DWlIiv+WUq08PFd2GcdrFMEAFUWFAsy7uPTGIii2aT9HskNYdhoYCOASmLLjZfpNHKUl2m+wgt1dipDSXILW/mv47jEkauzFgGwOXizfMh5mNPJmAaVeiZot8rm6792KuC90izlCGc5t2eBbba3Fy7U/vpBrKH5v/uDn9P5rcOpQs1KZ1lsb2/QlQINue+5d+3T2ny3Yq+YDChtOZALCZfa+QT75QNikfMsmdzh0ZEAIvKO/Sl65+4MenMeixWQvs7xoPSpChOGU/Hs8PSnJ0+agTc6hYyvBtNmMlHBFQlZLIZh6jdtpDQIgHX1Jq9ZzPdDcaCLioJMtH+amvOwJmsaQ06C1+tgroWqvEN/WLSHq+3f6aXfnXWFngYkeaojrrpce3kXO06vbpUMg7A==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(54906003)(8936002)(7636003)(8676002)(83380400001)(5660300002)(40460700003)(82310400005)(9786002)(7049001)(44832011)(70206006)(70586007)(36860700001)(508600001)(4326008)(6666004)(7696005)(110136005)(316002)(2906002)(1076003)(47076005)(336012)(186003)(2616005)(426003)(36756003)(26005)(356005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 23:44:42.3761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1366f6-d2d0-4505-837a-08da435f88ef
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT037.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8812
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Levinsky <ben.levinsky@xilinx.com>

Add ZynqMP firmware ioctl enums for RPU configuration and TCM Nodes for
later use via request_node and release_node

Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
---

Changes in v6:
  - None

Changes in v5:
  - None

Changes in v4:
  - None

Changes in v3:
  - None


 include/linux/firmware/xlnx-zynqmp.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 14f00a7672d1..54331b726ab0 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -129,6 +129,10 @@ enum pm_ret_status {
 };
 
 enum pm_ioctl_id {
+	IOCTL_GET_RPU_OPER_MODE = 0,
+	IOCTL_SET_RPU_OPER_MODE = 1,
+	IOCTL_RPU_BOOT_ADDR_CONFIG = 2,
+	IOCTL_TCM_COMB_CONFIG = 3,
 	IOCTL_SD_DLL_RESET = 6,
 	IOCTL_SET_SD_TAPDELAY = 7,
 	IOCTL_SET_PLL_FRAC_MODE = 8,
@@ -166,6 +170,21 @@ enum pm_query_id {
 	PM_QID_CLOCK_GET_MAX_DIVISOR = 13,
 };
 
+enum rpu_oper_mode {
+	PM_RPU_MODE_LOCKSTEP = 0,
+	PM_RPU_MODE_SPLIT = 1,
+};
+
+enum rpu_boot_mem {
+	PM_RPU_BOOTMEM_LOVEC = 0,
+	PM_RPU_BOOTMEM_HIVEC = 1,
+};
+
+enum rpu_tcm_comb {
+	PM_RPU_TCM_SPLIT = 0,
+	PM_RPU_TCM_COMB = 1,
+};
+
 enum zynqmp_pm_reset_action {
 	PM_RESET_ACTION_RELEASE = 0,
 	PM_RESET_ACTION_ASSERT = 1,
-- 
2.25.1

