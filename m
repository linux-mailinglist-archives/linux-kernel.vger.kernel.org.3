Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4ED56AFE4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 03:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237040AbiGHBkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 21:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbiGHBki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 21:40:38 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C26E72EFC;
        Thu,  7 Jul 2022 18:40:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEkEU+NLxPbsULEAvSgSQiS3xa+VnxkQFJDLurGgh24xy2kNaJkvHsDTwtzvEFXrBHMGpsddDwJHB6NSKvAoculmoryAswnlKPmcdCEa89KPhajO2s4PUH7N6ei+wwLLHwTzka1ob65wz0yBKt9pPQoKZxhLLnXuRMv5UO/e/DUQz49jfIiVrhtASsLwlZ79znK2tlkNbzzBYj6PujmC7tnsbM7z+veTUIPEaTWCfKoj8tINaeGIaPzBfdzsQi9eByOWXlElAQqy+RkwcVHYQTPt3m/seCy1OwuwKFTdwu5uF8HhyQMOX5pVbjNlxAxTfyiOtM/AU2Asw9s99Yzldg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ict1F/1oRYnx4vckWXsQLTYcMPvaboaGfBHU3iRMSI=;
 b=CuDf05Ud96i9lHdzs6yoCKjCCKHlU9HIt7VHPFo4kyAID7Vz32m+ykChEO7pH9Awn5T7AqA5F9Z62U77+9AtIcatRudxhV2zfx2AQfWIIwyxmXAwzJfcgGjW0VjPbTj8RRobforoKpm/AyBQ71RILy9xRHc8SiVBnL7VUyF6ganvkaIWD87ufA4VTwqX7LVUQK+vCYrww6aYj3fRdAT9/uZIpbXTM6uL+45iZeDn5K2+0wn3WUz6wMAiyqLaUsfy2NnKDTd3pSqivUZ/vbO7K5fb/QLB2vyqREUk89WS+p4zXYcfwQ4l2UA0xhDOtqJWqYSjz7G1AROCNv1cYoRoqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ict1F/1oRYnx4vckWXsQLTYcMPvaboaGfBHU3iRMSI=;
 b=agRAFHwzjKXtnv8CA8M0k7E3NSGmdACPXoaDhFjXAwKL+IXdDMUCfRt3Hs2bHSQ7N8IKMNyVgn0SVoE1gSx6gD45R/R9iVd/bkXSSguerN5vrjYyPKjuc3J2b1R37a4Qb9zVQ7iZPXceQtv6CxHHfDeNrVG1pcQMcD1Fe979enI=
Received: from MWHPR10CA0005.namprd10.prod.outlook.com (2603:10b6:301::15) by
 DM5PR12MB1195.namprd12.prod.outlook.com (2603:10b6:3:7a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Fri, 8 Jul 2022 01:40:34 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::2c) by MWHPR10CA0005.outlook.office365.com
 (2603:10b6:301::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Fri, 8 Jul 2022 01:40:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 01:40:33 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 20:40:32 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 7 Jul 2022 20:40:31 -0500
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <michal.simek@xilinx.com>, <ben.levinsky@xilinx.com>,
        <tanmay.shah@xilinx.com>, <michal.simek@amd.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v9 3/6] firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU configuration.
Date:   Thu, 7 Jul 2022 18:39:52 -0700
Message-ID: <20220708013955.2340449-4-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708013955.2340449-1-tanmay.shah@amd.com>
References: <20220708013955.2340449-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7829e069-bac9-463a-6b80-08da6082d9c3
X-MS-TrafficTypeDiagnostic: DM5PR12MB1195:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dr9290t5EeFbYewlsuEKjZ7FaHRUnQeyo2hmMt+oZrzwq7qVTsA+/r9HiuIuwR5sY/Nx5APR7xiJMRXrpdvDNddXHYuDbSRB81BRcaiijO9/1SM1tNPjzthMLM52UM89TW3C0hgr5XrV0DJfEJYjnmCAq1VmGiF1ZJstu7ntq+WsyRVr0V0tcCiAn9lSX/aM5CXai2RXsfqdLn48vcQJBsZcNvBv3NXvE7p74lOVYAcXJldPr6duwCvoKSYZ2088yqTut7V3oOE3p/5Pf1Bhuxe2vA+eL+V5S0DQyed0WhWoMWIhhRtLwVYDZoyY8xsRT0Rb6oz3/RVIDlN4mmn+pwlEqqS9ZKt7pV/HN9YL87bhbThJfpK0++wW9MfRCXzXh01CGCtzKjhPCDfyYOd4SFwY3VIjGHtIl+t/87H+ce+mel7zRJYVEG6VSWVJAdTDXyo1E//d9N8hMiFq39JMTdUZEVBpIU7Zv5wuFD9T0wx8A1SwyzJWp4jeM5lArYbEYIQm+pxOTRic0jvXW187FhzO4XSQKUluZ3socKdoVg+ct0LYUy1GxTvaJUtFSiCCdp2qjKLGxmhJnN1wDJggShRo62MG+jV7RZIGFLXBiRODPjKB+YQOf5SY9vhNSys4zMVJABjApbVyLes+VY0phNdrsFEmUM7W6AC1nYCBdZTMRg7H81hOwpRrFF1OW5zy2pfAPN/3zXg4D2J2nfEsQzhbmYhiBerX9jowHZfdtz8gUGKJ8hEfYQVpcXAQPkvMmFj5+TnYQC64W3SKqMNYMAWXzkSOS9qkVCp4x1TUcqPD0LLuXfzP380uJlo9+qHnOuytIrSEq75iC7JDb9jzdz+jBXzebsLuLyEipZluyRmXY02ZYIUmP5IFaIWv6XWB
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(136003)(346002)(36840700001)(40470700004)(46966006)(86362001)(26005)(40460700003)(6666004)(2906002)(82310400005)(8936002)(41300700001)(478600001)(2616005)(44832011)(1076003)(5660300002)(54906003)(83380400001)(40480700001)(186003)(336012)(426003)(47076005)(81166007)(82740400003)(34020700004)(356005)(36860700001)(70586007)(110136005)(6636002)(70206006)(316002)(8676002)(4326008)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 01:40:33.9480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7829e069-bac9-463a-6b80-08da6082d9c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1195
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---

Changes in v9:
  - None

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
index 1ec73d5352c3..31386c82411a 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -134,6 +134,10 @@ enum pm_ret_status {
 };
 
 enum pm_ioctl_id {
+	IOCTL_GET_RPU_OPER_MODE = 0,
+	IOCTL_SET_RPU_OPER_MODE = 1,
+	IOCTL_RPU_BOOT_ADDR_CONFIG = 2,
+	IOCTL_TCM_COMB_CONFIG = 3,
 	IOCTL_SD_DLL_RESET = 6,
 	IOCTL_SET_SD_TAPDELAY = 7,
 	IOCTL_SET_PLL_FRAC_MODE = 8,
@@ -171,6 +175,21 @@ enum pm_query_id {
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

