Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5740D56AFE8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 03:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbiGHBkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 21:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237029AbiGHBki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 21:40:38 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B3373584;
        Thu,  7 Jul 2022 18:40:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lj+gAz8hYvCAlnAOyWIUJGguoyI3d0myQWSZwgbanNx2pMHJWIAiISceE/+zXGU6AIks7XYVtYGl6RCoIHd+aAY+Zy/Loqi3pAHutL3npJbSiZxc7P0IqJyAt5BjbktqFlmH+cOg7Whdcx+008JCdgvf51/jTDw92rxRf7nXl+sckJxPBjlwYiUn0GwwvgxSE0H2pUIX1afjOTipvfS3dEfSmtfzUBLMPQwPQDp5ie6fzjL8j1b3swfbXV5OLwu2XqFWDuRJmvpxjllIZm/xuZH8/Tg8l4mrETeIYWUKysWqr2naO9sJerqJ0EoQNfKQe579DxIROBOITGURyIL7gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jf5b3pbFtNwWBiYisMVxW4eaLh/8nu+vZd+3X4Dwd4Q=;
 b=ffgy0v9PePAo/jbvnPBVD4/P91Mcs8huLtI3GG2JOUbMc7Y3ipWbkjqJOVGAsmFSLvs0fvwtnOOdKlRStPL8ZHhG0f42ygCHqC4wOvlKLtTRcl5PJ1coQVMBUaOG4KI8vAxXcp4SllquGlXAXMDCZ7CpEXjHGhdiAt4QGwOm8ZdN+NpyThAh1TkYFMuWur6qZxtittfxX4Dzp05Eo/w6F92l00b39ifWwga6avqXo+/Mw3rLDGMTNf+K/EU5z0qPlVxaau+y3duD2B0umr6jhCoQqWtoxQKe9xTV7Mv5mT9vgRB6/bQ6V5yjq0tSEs/rK5OumL7l9VEY/Wt2zKj8tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jf5b3pbFtNwWBiYisMVxW4eaLh/8nu+vZd+3X4Dwd4Q=;
 b=G31NuMkx7vwSAxkeGuPcPXNy+V9oG93cGw3y5g/JN/2v5M1Tjqt9S0ASEJqq75w7lvboMWVIIxcovVM2vtvDLzuYWdRo6NQV35VVJgq1tsh601BvtLB+L6Rp5dBQvIs8J4BqK5BKHooFkPyy6XF7nGD5hZeLvUbYUwbwAnU83OI=
Received: from MWHPR10CA0017.namprd10.prod.outlook.com (2603:10b6:301::27) by
 DM6PR12MB4449.namprd12.prod.outlook.com (2603:10b6:5:2a5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Fri, 8 Jul 2022 01:40:35 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::f6) by MWHPR10CA0017.outlook.office365.com
 (2603:10b6:301::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17 via Frontend
 Transport; Fri, 8 Jul 2022 01:40:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 01:40:35 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 20:40:34 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 20:40:33 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 7 Jul 2022 20:40:32 -0500
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <michal.simek@xilinx.com>, <ben.levinsky@xilinx.com>,
        <tanmay.shah@xilinx.com>, <michal.simek@amd.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v9 4/6] firmware: xilinx: Add shutdown/wakeup APIs
Date:   Thu, 7 Jul 2022 18:39:53 -0700
Message-ID: <20220708013955.2340449-5-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708013955.2340449-1-tanmay.shah@amd.com>
References: <20220708013955.2340449-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c662aef-9c50-49f7-c0de-08da6082da9e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4449:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tuh8XfT048Q5e0fk43zoeH50hnV1UyMh/1cBlMoBJ2PXquO0p4wGpjMPVhelbomErK8kDLyfXH9/aeEDBIxdIYy2tEtqCrZ5eawYQ6RRosSY5UFo+s/IFvMDb2vzgxOYBGAxUNT5iWyGAIWtWIuYP7h9j+mTFdjLtj7RSs0DdEcIz9QAIkQEV5AERx9OgDIyQIpeqMPF0sfTPRmMU5Cuns/gHbrzUI5mJy73Syr4A9/EZHs6/9aE/UqHOPtkkyIeh1hQXKL4mvRJMkBV9hUf8eGyNHNW4mAhUyldvp4k4K3XtB3uogn2sGU0rTxzRdJH606/hhdTTTmvPNRsGMWfKCvbI23p1/qkJgoOOtYdV6NCNWG9qwM5fCOWkEIAOY3oHoQi9YXIpqE5zUpaULNtzLbNX89z9JlKzIUmMaX4Gk2BAGoGpOk6GuQ/issAQ6e4g9TtzP37eD93AoB9TQxjxO/8Q63uQZQpqJxzOupO+V8d9F2ROhObAqlRL8hz+S9znw9kSM5RRCeWiXmyXwAw33+dTMSUkfOKC9x7XjetOLvtTPcZ3ajr8hUDxRgSWIm4vc7Zn6FqivtaOUQSbfO7TRuk0/7uqJhrglahFN1jcdDCo8uFhciQpMxVZ2a6jcThF0a1DA78/vF+REOp4YVneK8zfsFNLcHFg/T1zxRYlH2Vou3nCjhMqDxsvarWM66YE2SN1bKPvc6nx6ZzSEgvX4MKtOTxJJaVbqyTeIQI8cDlOpYKpaSZjkAsI12OPbsy2swVYzkacBOFqLNYiY+XmFC6RHE/wUVy91zBRdIBh8p1LdPL14pXw+CcQy2+rdTqenwFGLYl7cbYrjvXHhqZrbwCeSBo7bhwRjJ+2IU6T6ZVxURUuYSTNCfdC6zkfqiv
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(376002)(396003)(40470700004)(36840700001)(46966006)(86362001)(4326008)(6666004)(478600001)(44832011)(41300700001)(1076003)(2906002)(81166007)(316002)(70586007)(2616005)(70206006)(8676002)(36756003)(186003)(82740400003)(34020700004)(426003)(336012)(40480700001)(6636002)(26005)(82310400005)(83380400001)(356005)(110136005)(54906003)(5660300002)(36860700001)(8936002)(40460700003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 01:40:35.4011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c662aef-9c50-49f7-c0de-08da6082da9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4449
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

Add shutdown/wakeup a resource eemi operations to shutdown
or bringup a resource.

Note alignment of args matches convention of other fn's in this file.
The reason being that the long fn name results in aligned args that
otherwise go over 80 chars so shift right to avoid this

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

 drivers/firmware/xilinx/zynqmp.c     | 35 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 23 ++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 7977a494a651..36384c4a4881 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1145,6 +1145,41 @@ int zynqmp_pm_release_node(const u32 node)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_release_node);
 
+/**
+ * zynqmp_pm_force_pwrdwn - PM call to request for another PU or subsystem to
+ *             be powered down forcefully
+ * @node:  Node ID of the targeted PU or subsystem
+ * @ack:   Flag to specify whether acknowledge is requested
+ *
+ * Return: status, either success or error+reason
+ */
+int zynqmp_pm_force_pwrdwn(const u32 node,
+			   const enum zynqmp_pm_request_ack ack)
+{
+	return zynqmp_pm_invoke_fn(PM_FORCE_POWERDOWN, node, ack, 0, 0, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_force_pwrdwn);
+
+/**
+ * zynqmp_pm_request_wake - PM call to wake up selected master or subsystem
+ * @node:  Node ID of the master or subsystem
+ * @set_addr:  Specifies whether the address argument is relevant
+ * @address:   Address from which to resume when woken up
+ * @ack:   Flag to specify whether acknowledge requested
+ *
+ * Return: status, either success or error+reason
+ */
+int zynqmp_pm_request_wake(const u32 node,
+			   const bool set_addr,
+			   const u64 address,
+			   const enum zynqmp_pm_request_ack ack)
+{
+	/* set_addr flag is encoded into 1st bit of address */
+	return zynqmp_pm_invoke_fn(PM_REQUEST_WAKEUP, node, address | set_addr,
+				   address >> 32, ack, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_request_wake);
+
 /**
  * zynqmp_pm_set_requirement() - PM call to set requirement for PM slaves
  * @node:		Node ID of the slave
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 31386c82411a..407796f4464e 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -12,6 +12,7 @@
 
 #ifndef __FIRMWARE_ZYNQMP_H__
 #define __FIRMWARE_ZYNQMP_H__
+#include <linux/types.h>
 
 #include <linux/err.h>
 
@@ -86,6 +87,8 @@ enum pm_api_cb_id {
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
 	PM_REGISTER_NOTIFIER = 5,
+	PM_FORCE_POWERDOWN = 8,
+	PM_REQUEST_WAKEUP = 10,
 	PM_SYSTEM_SHUTDOWN = 12,
 	PM_REQUEST_NODE = 13,
 	PM_RELEASE_NODE = 14,
@@ -487,6 +490,12 @@ int zynqmp_pm_feature(const u32 api_id);
 int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id);
 int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value);
 int zynqmp_pm_get_feature_config(enum pm_feature_config_id id, u32 *payload);
+int zynqmp_pm_force_pwrdwn(const u32 target,
+			   const enum zynqmp_pm_request_ack ack);
+int zynqmp_pm_request_wake(const u32 node,
+			   const bool set_addr,
+			   const u64 address,
+			   const enum zynqmp_pm_request_ack ack);
 #else
 static inline int zynqmp_pm_get_api_version(u32 *version)
 {
@@ -752,6 +761,20 @@ static inline int zynqmp_pm_get_feature_config(enum pm_feature_config_id id,
 {
 	return -ENODEV;
 }
+
+static inline int zynqmp_pm_force_pwrdwn(const u32 target,
+					 const enum zynqmp_pm_request_ack ack)
+{
+	return -ENODEV;
+}
+
+static inline int zynqmp_pm_request_wake(const u32 node,
+					 const bool set_addr,
+					 const u64 address,
+					 const enum zynqmp_pm_request_ack ack)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.25.1

