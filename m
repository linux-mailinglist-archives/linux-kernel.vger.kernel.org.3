Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A960452C3C0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 21:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242158AbiERTq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 15:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242089AbiERTqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 15:46:55 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2088.outbound.protection.outlook.com [40.107.101.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994C6190D37;
        Wed, 18 May 2022 12:46:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtjV9l3BX5ubnuFjcd7cUJ0n4sE73EBEODzWdizV2eTa3YhtxgZ4stcZNXPvZ7I0Kgji5hgByb4/n29vufrWsDfnjuqwpcYJk6BHIXLFBRvRZM7/YXuVzd3z+D4wZTO6qfrZm0nxZmYPL9l2/sPX5NIMMC0nSVi3nHH01RaNZNYcCokBORAeBqnpyFuvlNMDyb0cNvx4bPaaXMIKQc8cqS0gPFqtf/GTIEpviHWLvLj/JkRSYdc9N7ENv9PedgmHLVh2Eiubwi3pa1jgrFiigZHXwZehzDK5q88WjJFSnuU6oq0L+vEpv3nNk/dTr4uuoq23Aor2G/pOgIM2Wg3+sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=is8LVbe/h7L9f5aRoDKIJ8ZU24wgA1xmN3x73fXZHv0=;
 b=Sratx73y4TAsLucI48Oz0oZaX9CQA/xvsv2E5Ye1s7XH+tPbXbIqVOYxp7vtSvkldPSo37TkvwSqStwGYvRj1175FMsQsT7nE//az9D0x/HbhisN23yFo0g2/P8Aql9MpeKPUUK/JIuZC30vbDzMNq0F8X3zCm1nB7WrP1tGnrLhd8w4i3R86+CZIfXkL3556clwI7UIR3gkkYD3VVJmgov8CYMPrnIVfvPG4mevxVRb9XY6CwsnZJgG3GwR/MWQDEUZ07IfuD0nPqkxS2EPS60cPMB/NLDjLH29kpAWBGly53LR0LyTmMGQolGW2/uFeUaQhf6NstzBmIyc3pyqvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=is8LVbe/h7L9f5aRoDKIJ8ZU24wgA1xmN3x73fXZHv0=;
 b=E8NzuGrqiMEOtr4NuoXUHGZ4/KssjE7UkaTHndaFuH+tvvUKJuDfcopItQ7olU+qL5XmfGENh48CPSWYKB8ogAdPbKdcJeXS0/gZdtdShzdCrMtb4bVzkDoqN0nLS56oqNNSh31rQ/DChVj2NrDazEFTlkRQvtTCTlN0YV2f7kA=
Received: from DM6PR08CA0015.namprd08.prod.outlook.com (2603:10b6:5:80::28) by
 DM6PR02MB5610.namprd02.prod.outlook.com (2603:10b6:5:33::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.15; Wed, 18 May 2022 19:46:50 +0000
Received: from DM3NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::e1) by DM6PR08CA0015.outlook.office365.com
 (2603:10b6:5:80::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18 via Frontend
 Transport; Wed, 18 May 2022 19:46:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT032.mail.protection.outlook.com (10.13.5.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Wed, 18 May 2022 19:46:50 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 18 May 2022 12:46:48 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 18 May 2022 12:46:48 -0700
Envelope-to: bjorn.andersson@linaro.org,
 mathieu.poirier@linaro.org,
 robh+dt@kernel.org,
 krzk+dt@kernel.org,
 linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.3.14] (port=40706 helo=xsjtanmays50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nrPdA-0004Ew-3a; Wed, 18 May 2022 12:46:48 -0700
From:   Tanmay Shah <tanmay.shah@xilinx.com>
To:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <michal.simek@xilinx.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Ben Levinsky <ben.levinsky@xilinx.com>,
        Tanmay Shah <tanmay.shah@xilinx.com>
Subject: [PATCH v5 3/6] firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU configuration.
Date:   Wed, 18 May 2022 12:44:26 -0700
Message-ID: <20220518194426.3784095-4-tanmay.shah@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518194426.3784095-1-tanmay.shah@xilinx.com>
References: <20220518194426.3784095-1-tanmay.shah@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9afd6c3-921c-4bc7-cdeb-08da39072693
X-MS-TrafficTypeDiagnostic: DM6PR02MB5610:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB561083FD8D19855F24BA50F7CAD19@DM6PR02MB5610.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GwQtFI2vJ/BHKXw+jeSK2tu+dw/Og6wC9bDqoQT1t6Xh1/2/mwh6aFW1PkmMYkjzM83IpGa8c7aaczsMEYR6me0c4NtHipMJ59S34MeOy92rwPyqRRE8fdJRfO8ivSt3Ef5fBjduQQ5ZG8xhWZWzC6MHMV0jpj+x6x0u/rRtePUkoTprIbBcqd/8su9vpl1uLGDwXSd8Ivqp+FFxc9RnQUMcqHDneni1UGK6UvEV9wnG9ghNw/bz6tlQNE/BlIpnmqsauIQnQuQt/fVw1D37q8saBLLTyggAfqdsqiRk35OfQ2M1j97mlQ6LUaWW47vAyySG9CdP483IiFORBF3AwsuxIN5+ZRxtCXF7WN+hI0VxoBZp54NjqHl8YGgM5G2hnMhcIjy+1ZlwvhGBokVgEIKm59cm1plPPSDlV9o/nFBlOy5aLVQ34byoF0iJEkkeesnT6Gci7L5jbSW5kVfcFsI7FEcd4g8hgu9gH2IYQaKwCD4H96OCM2rqStJGY2t9XvfMvF7YxTKNWe3/23G9JgdEUCe7HOAO+nQVtkpAD6XuXHIfjcHwwgYOFWY/2yep5Qn/5SpzhiZayix/BhblX4py++Kyqo3gN+IiT5/bRpXt/atrJWmlbejvrr2NttDg8IjYgOjkmXBpSrRZZZyiDTepRHHv7g0Zmp7zoz2mosjJsGVvLILlQ6gv9harmq555R0gwsmoCfa1ls+yYTQ/nQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(47076005)(4326008)(40460700003)(70586007)(82310400005)(70206006)(8676002)(26005)(426003)(336012)(36756003)(54906003)(1076003)(83380400001)(2906002)(186003)(6636002)(7636003)(6666004)(5660300002)(7696005)(356005)(9786002)(8936002)(44832011)(316002)(110136005)(36860700001)(508600001)(107886003)(2616005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 19:46:50.0184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9afd6c3-921c-4bc7-cdeb-08da39072693
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5610
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

