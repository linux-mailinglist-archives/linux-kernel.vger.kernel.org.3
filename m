Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0831539A2C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 01:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348770AbiEaXpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 19:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348704AbiEaXoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 19:44:46 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCD76F483;
        Tue, 31 May 2022 16:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0dp3viemjhmJpTUjowznotZxm1tPC6INjl8IJxPaz2OOu2ISE6ucejuVKDM5P+5y2pRrW1hK2VGwfBJDGKxfYeXW6i5d4PnhrYUirIJulLXfplvjLe7hXk2bhM0f70YQ95nRifiji8wiYyqD36CdtPUDqqA9kAftEpdi79AEC6hlXP73HNTD10kCLmoY7ho+7GKfZdFbnIDwrl0IsVMHdA2Ujf/ET9zE6CGnNfFlOfpEpgxIOp8KvIHvvlBu162DS0N0lkzuxVe5jKcpgH4zrDi4OW4HwSbY2U6pqmGrxD4X8SqCqq6q61GiOCOEMLfIQ7DJ4Pv08zhaPnAH5hHcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6aHCgssh2OLLT7rX73sNI36T0SKbF/6CHaocfyR2tc=;
 b=kT/hWQyhdTFI6XDgNHlaAt4L4yH1xHFmzarkO6Epb2RWLlThwFajKExnEBnmQ83e2VFF/hbKVf6hlR7ZSvSN8zNEf9zKXPP2grW/qN0i9ZU6PcJfC/R9SQYpBR4CYV1KUHV+brJVB4xCiE8FxiirLIoW9aP5qBFwYRHEwiRPACeGZSeNcFMD4YE9kzzPjipeFd1Vs4upUb7+ETSgIf0rUab4y/0rZyF5Pxn/SLe7uVgZqB2AQpRuH5MZ/5Xh2eCykjn1ts0e4/I7Cit22O8hz+63uL17iXsEaHSQjAijpnPvev1IJe9ZvD5l+I5y+7bKbHqDBJuuMXQsiBTPCl2OnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.openampproject.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6aHCgssh2OLLT7rX73sNI36T0SKbF/6CHaocfyR2tc=;
 b=JtUFXX5+5gAyHhFvtJ0Ywv6lPe8sSf3pRF6v7XhrjmJsM62vPtAgPXP79YN1M/Dz2SKQSBHqA+wi5dYlGHRWepMNIFLhkLI7qH0v7+eRQS41NLABjedxq/vPV3hUNLFpeln/HgEiECRvuyw1/TxgzXxbHoXHQCMCqqpLZ2mZ39w=
Received: from BN9PR03CA0392.namprd03.prod.outlook.com (2603:10b6:408:111::7)
 by SA0PR02MB7178.namprd02.prod.outlook.com (2603:10b6:806:ed::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 31 May
 2022 23:44:42 +0000
Received: from BN1NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::cc) by BN9PR03CA0392.outlook.office365.com
 (2603:10b6:408:111::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Tue, 31 May 2022 23:44:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT041.mail.protection.outlook.com (10.13.2.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Tue, 31 May 2022 23:44:42 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
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
        id 1nwBXV-0006jm-0p; Tue, 31 May 2022 16:44:41 -0700
From:   Tanmay Shah <tanmay.shah@xilinx.com>
To:     <openamp-system-reference@lists.openampproject.org>,
        <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <michal.simek@xilinx.com>, <ben.levinsky@xilinx.com>,
        <tanmay.shah@xilinx.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 5/6] firmware: xilinx: Add RPU configuration APIs
Date:   Tue, 31 May 2022 16:43:09 -0700
Message-ID: <20220531234308.3317795-6-tanmay.shah@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220531234308.3317795-1-tanmay.shah@xilinx.com>
References: <20220531234308.3317795-1-tanmay.shah@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbb94bd2-9283-47a3-787a-08da435f8918
X-MS-TrafficTypeDiagnostic: SA0PR02MB7178:EE_
X-Microsoft-Antispam-PRVS: <SA0PR02MB7178AA47C18652EE434947A8CADC9@SA0PR02MB7178.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QucbXDCUxJUzHJ9OV8hgIiSS3e3PKDmNUw/uNkxG2GBg2b4jMoKAYox8dc2kHkTbC16FGMSIBf1t4B7NkajUT0zqvLIx+Io/mwDrStBsMmayDPw7tP+6ibUb7/CA+LtsNsdSLYIDVYyhkbAiAf7sAp3ZqKBfSZYmQqUVFzAZjrQBaL8NZudYXxg8FLxeRI8xrKxLttBXJ8iJpqrifE/ybPyqcgEgJiAVgn4wdwm1ivx6XIEWVxRSF8p1wdxqSXC7J3/yInj/0mJgA4w27mB6cCfX3ZqFaFBNzIssFyXxekjDF5pclmOMn6f25M9YG3+m26DJrEW8KkLEo+fCFuGZqjrRTVsR1n0mxQxZMoXoaoYc5dRQKap2oS7kSPS3CCpbG7jLI2tmeeAGILlCQNtpv5IreSMnw1S5rT1NSZCOdg8402B6DQWmJzLQXbLej0Uri7aUN3b/cQwpvfgl8li1R5N9OVn1ak1GHTPSGRCIU7Wl+8Y/fvqR6nhKN+unLf5AQyPPMw6i1tLycMDfVgq+3XGITorUBPpGwSwAmnMD98r0m3WzsBekT+BSFDYYNIr24wwYLrW6AGhvwGuc/jScxQWnTFugyNv6Uo1xJv01/9Rr/InDUwQezEU6yVNZsD+IvFVQTsP1h+P6MzSZgGJc9ZHqnEWjNQSlKugeNW/coX6IwFs09g5diljOLiQDZimZlx5DmRRomAKcjHPsKe144A==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(7696005)(9786002)(7636003)(356005)(36860700001)(47076005)(1076003)(26005)(316002)(6666004)(54906003)(8676002)(8936002)(44832011)(5660300002)(82310400005)(40460700003)(70586007)(36756003)(336012)(186003)(426003)(110136005)(508600001)(2906002)(7049001)(83380400001)(2616005)(4326008)(70206006)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 23:44:42.5820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb94bd2-9283-47a3-787a-08da435f8918
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT041.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7178
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Levinsky <ben.levinsky@xilinx.com>

This patch adds APIs to access to configure RPU and its
processor-specific memory.

That is query the run-time mode of RPU as either split or lockstep as well
as API to set this mode. In addition add APIs to access configuration of
the RPUs' tightly coupled memory (TCM).

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
  - Add missing function argument documentation

 drivers/firmware/xilinx/zynqmp.c     | 62 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 18 ++++++++
 2 files changed, 80 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index fabdbac868f5..c66c9b48135a 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1067,6 +1067,68 @@ int zynqmp_pm_release_node(const u32 node)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_release_node);
 
+/**
+ * zynqmp_pm_get_rpu_mode() - Get RPU mode
+ * @node_id:	Node ID of the device
+ * @rpu_mode:	return by reference value
+ *		either split or lockstep
+ *
+ * Return:	return 0 on success or error+reason.
+ *		if success, then  rpu_mode will be set
+ *		to current rpu mode.
+ */
+int zynqmp_pm_get_rpu_mode(u32 node_id, enum rpu_oper_mode *rpu_mode)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
+				  IOCTL_GET_RPU_OPER_MODE, 0, 0, ret_payload);
+
+	/* only set rpu_mode if no error */
+	if (ret == XST_PM_SUCCESS)
+		*rpu_mode = ret_payload[0];
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_get_rpu_mode);
+
+/**
+ * zynqmp_pm_set_rpu_mode() - Set RPU mode
+ * @node_id:	Node ID of the device
+ * @rpu_mode:	Argument 1 to requested IOCTL call. either split or lockstep
+ *
+ *		This function is used to set RPU mode to split or
+ *		lockstep
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+int zynqmp_pm_set_rpu_mode(u32 node_id, enum rpu_oper_mode rpu_mode)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
+				   IOCTL_SET_RPU_OPER_MODE, (u32)rpu_mode,
+				   0, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_set_rpu_mode);
+
+/**
+ * zynqmp_pm_set_tcm_config - configure TCM
+ * @node_id:	Firmware specific TCM subsystem ID
+ * @tcm_mode:	Argument 1 to requested IOCTL call
+ *              either PM_RPU_TCM_COMB or PM_RPU_TCM_SPLIT
+ *
+ * This function is used to set RPU mode to split or combined
+ *
+ * Return: status: 0 for success, else failure
+ */
+int zynqmp_pm_set_tcm_config(u32 node_id, enum rpu_tcm_comb tcm_mode)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
+				   IOCTL_TCM_COMB_CONFIG, (u32)tcm_mode, 0,
+				   NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_set_tcm_config);
+
 /**
  * zynqmp_pm_force_pwrdwn - PM call to request for another PU or subsystem to
  *             be powered down forcefully
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index bce3465a70a4..ffc2cea7c604 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -490,6 +490,9 @@ int zynqmp_pm_request_wake(const u32 node,
 			   const bool set_addr,
 			   const u64 address,
 			   const enum zynqmp_pm_request_ack ack);
+int zynqmp_pm_get_rpu_mode(u32 node_id, enum rpu_oper_mode *rpu_mode);
+int zynqmp_pm_set_rpu_mode(u32 node_id, u32 arg1);
+int zynqmp_pm_set_tcm_config(u32 node_id, u32 arg1);
 #else
 static inline int zynqmp_pm_get_api_version(u32 *version)
 {
@@ -764,6 +767,21 @@ static inline int zynqmp_pm_request_wake(const u32 node,
 {
 	return -ENODEV;
 }
+
+static inline int zynqmp_pm_get_rpu_mode(u32 node_id, enum rpu_oper_mode *rpu_mode)
+{
+	return -ENODEV;
+}
+
+static inline int zynqmp_pm_set_rpu_mode(u32 node_id, u32 arg1)
+{
+	return -ENODEV;
+}
+
+static inline int zynqmp_pm_set_tcm_config(u32 node_id, u32 arg1)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.25.1

