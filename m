Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B912553BFF3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 22:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbiFBUj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 16:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiFBUi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 16:38:58 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56EDB5E;
        Thu,  2 Jun 2022 13:38:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHhiT03A5E2sfFe6MM7NtKMj4s3qZxGksOUUetpU8U/srGQ8rpWLqECcEZmxN665aPXwBUYHi8SodVy5oGa0eIio+pY/EJGdZZ6+SsRef4HtBrVvLtbty8/qUHQwb5UGjTN+C1+xl8GnhOEIaggXuynC9WF7uQOCvf0O57zecKFIenidJluxgoqQHjDEcOtE7uhOiZDQuzY9FyW1Qyr7y7Y7QPGjHbXaFcGG+99AKJeJ6Ya4Mj0Pu/MdENvwbEHNR6kPFaWPh259jjtXydwhH8yKQGL4nFsfDdmZjV+1S4eVFlULsQueujgJPT/B+fDyI4qwNtNqV337pjQnnNvksQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImS6rjZlO0u0VFlGfbk/X+3mkdIzchuLFAwqgn8EGQc=;
 b=Fn0LE072JVlEgUdBcKAUgUZOopZUoZu0UZsjbm5pvchrWpEAIZjj4OyqsCxiHTB5B+ePXwkNyS7PPz3EC66M/mNtL0MooLxbm0Tmgo5EpVz35or53UAa8YiSu+49IWPVKBFrwciD0dh4P7Xojhar3vcT8nn1fg8nYehVTkgKFsPAry6vp3cPrjnJS9tuIPwTNhJBfpnIo/npRkqse2LKp1+BB6cX5cgFYwnj0ZqIuCScpDrwttbaK85NTXiR5lSIdaFtZzybLv0DVAXaIkVRaLfxc97sRDZ4SeV+pIFBBztj3mpZBn0m2ZQvKuyTXgvxJr39f7Rx7lr90PzXM3amcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImS6rjZlO0u0VFlGfbk/X+3mkdIzchuLFAwqgn8EGQc=;
 b=WKMRy/F/8sDJzmGL8InzjblEWJZwCsvaksY2RcyG2gv55soBHOjNpte4cTtaE4IUR0Q9J8Tidth710O4SXrnf1UWucrmzpHDEKvbB4n9VqGsvsPaYnj9OiO654KgWwe3k4zQeJUMMEnJZ694PBN42Yw3KTlAT894WAEHqDRgAlg=
Received: from BN9PR03CA0351.namprd03.prod.outlook.com (2603:10b6:408:f6::26)
 by DM8PR02MB8262.namprd02.prod.outlook.com (2603:10b6:8:9::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Thu, 2 Jun 2022 20:38:51 +0000
Received: from BN1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::5b) by BN9PR03CA0351.outlook.office365.com
 (2603:10b6:408:f6::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Thu, 2 Jun 2022 20:38:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT052.mail.protection.outlook.com (10.13.2.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Thu, 2 Jun 2022 20:38:50 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 2 Jun 2022 13:38:49 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 2 Jun 2022 13:38:49 -0700
Envelope-to: bjorn.andersson@linaro.org,
 mathieu.poirier@linaro.org,
 robh+dt@kernel.org,
 krzk+dt@kernel.org,
 linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 openamp-system-reference@lists.openampproject.org
Received: from [172.19.3.14] (port=53866 helo=xsjtanmays50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nwraj-0007MG-88; Thu, 02 Jun 2022 13:38:49 -0700
From:   Tanmay Shah <tanmay.shah@xilinx.com>
To:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <michal.simek@xilinx.com>, <ben.levinsky@xilinx.com>,
        <tanmay.shah@xilinx.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <openamp-system-reference@lists.openampproject.org>
Subject: [PATCH v8 3/6] firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU configuration.
Date:   Thu, 2 Jun 2022 13:38:31 -0700
Message-ID: <20220602203834.3675160-4-tanmay.shah@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220602203834.3675160-1-tanmay.shah@xilinx.com>
References: <20220602203834.3675160-1-tanmay.shah@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c5f20d5-d64c-4383-81bc-08da44d7e6e9
X-MS-TrafficTypeDiagnostic: DM8PR02MB8262:EE_
X-Microsoft-Antispam-PRVS: <DM8PR02MB826286F54C610CBFE044AFBFCADE9@DM8PR02MB8262.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /wrdEdR/GFk+Gc2s+hTcs/S8jo7MGDsxqq8DpK4Yc1K10mtBKIxC/f1uHgLhcwxteWK4kCWe5/yb6mPkliQCG98oWj/hCJjOn0TYUYv0kyFJHh7j6KQ3PNQjjgnUCgT+cqu8cX0Mqb8i2YlRTPNa4CBI1FkPCx71hjHUVFOVd65mWzzNlry/y+JMSUl3z3KCE+kMJpADBFAs3eDMPhV2Tc3/jJZMead+EogD122J2TwSprtCmcrciw4boAHl6OWhq8DsRQtKu7vO0XW+e/IrlvjYtbuoG0KIdHB2l086gjv+EHCpn9IpAGNvA+MpMNGtyyst+kPOOMjuGn2ZsFpfib+gFsXs64lbUG2JVhEUVs8tIyDpIysPb1MHLGjFjW1WHuslt6L06C/U7zcUD8kIgAiPpVoLI841nyFNrtmgGL3STKbFz6A0IIX1vVxWxvccMH6GEJ2+LCrssRYXlOJNg92rvP4LBdtRGQ7mPO3k8jRWULaeRmIBEhzWWDwdbiuwRc5O2ypjEQK7O3wSkFd6ehGM5rCnlVrM+VOmm2wfsMFZ5iSnuRMqhjrMrq9bdgQisfhUCA+ice4xaMX8+zOU3eakjczFIBGF9RFElhdxaO9/C/XTnvZq0LYN/x/dvWrpO6r9C82ZLn7uO+YtARzUOC0FVMHgJFg99T30N7gpJjGD98LuGZwn2M03nKV+r0v0G9YdLYC0DvB5F5zEUD/53w==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36756003)(7636003)(6666004)(26005)(356005)(110136005)(54906003)(7696005)(44832011)(316002)(508600001)(40460700003)(7049001)(426003)(5660300002)(336012)(70206006)(186003)(2906002)(47076005)(70586007)(9786002)(8676002)(4326008)(36860700001)(8936002)(82310400005)(2616005)(83380400001)(1076003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 20:38:50.7660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5f20d5-d64c-4383-81bc-08da44d7e6e9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT052.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8262
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
Changes in v8:
  - None

Changes in v7:
  - None

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

