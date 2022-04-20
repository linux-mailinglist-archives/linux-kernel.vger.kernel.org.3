Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77155082B5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376431AbiDTHxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376506AbiDTHxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:53:07 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586FF3465C;
        Wed, 20 Apr 2022 00:50:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YV29Zh3DtPop/G3NWDWQoBVZH6IBMGjy1w6u9SAh0/yBoVp5swAWe3E8jFDHGVAhLpuTIIZvT5VR0L5IrLgwdWAE00Oxif2YHvdUC49fmlJ0oT5j6SrTp+UoBPA6AgMZv2cmWt0kIZ10++M+UUFRzrBGJofWs6b8YLHIOIHAKE/rc4ko4p1BYTMmZg7McwL2T52jYvEeqweTVpwH1D+HMGfcXyHsBRQv+mUBt+RK4hu2olmIHpXsqhHrWsOUkpV/qjG5Zl2e3tR4o+YHKIH+zHy1ULHD7NddgCDf4k/cjZTqICt86M/Qvd+xraIe5wbpkzc+QWNeHgFvEUWcjVNL+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hLHZZ6Ghrci7+EYY8AcKClO1X+mESEXR7Wlj5JI9o4=;
 b=ZZENgYiWHIpSSX2p2diQNiPW34gvj7gajg2Xj+fxD1VXguV+IX3UWtxGwao5fcINZSktB+roUawXa0HC08pJIqlr5FpRUjKmjydMa3wV1Q4034I3hK3VzDRi4fLBtHx7ZgNr0h04gx5yGFnFWiIDflWLoW79ro1xQGGR0kgA3lQhpScxIn0Km7xyPTX4wkRM7xOzVU2VFJECPOGIRXQurUwKB8TzvZM6zzqkKcrBMMc0RcPC7iOaTN/o/2MVn9mJvAZIsKiTlbreGJcUPQFbqpP0rsCKRpII1/BDRPs+Vej+TMVi6iqhmENinbpWsscBKDZp2jO5HpFu/P+Zs31UHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hLHZZ6Ghrci7+EYY8AcKClO1X+mESEXR7Wlj5JI9o4=;
 b=oaU7r3B4Zb5C1T9XXZ0vZlxN7UHQgg6oHWCgDCRgssW33fxgWeIY6WXf+cc0m0H4hkuPBi3kUGPP9VxvFzIKbzHtC4bAwQdDHNwfKPxOjSM4YR14z7o1JIfk0Cw3YYCt4UC3Q5O4MB3utDxHG8XG0k/BExZh9l5gkMpAm3y6KdM=
Received: from SN4PR0501CA0072.namprd05.prod.outlook.com
 (2603:10b6:803:41::49) by MN2PR02MB6606.namprd02.prod.outlook.com
 (2603:10b6:208:1db::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 07:50:20 +0000
Received: from SN1NAM02FT0044.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:41:cafe::83) by SN4PR0501CA0072.outlook.office365.com
 (2603:10b6:803:41::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.6 via Frontend
 Transport; Wed, 20 Apr 2022 07:50:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0044.mail.protection.outlook.com (10.97.5.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 07:50:20 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 20 Apr 2022 00:50:12 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 20 Apr 2022 00:50:12 -0700
Envelope-to: mathieu.poirier@linaro.org,
 bjorn.andersson@linaro.org,
 robh+dt@kernel.org,
 bill.mills@linaro.org,
 linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.3.14] (port=51254 helo=xsjtanmays50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nh56E-0001h6-5R; Wed, 20 Apr 2022 00:50:06 -0700
From:   Tanmay Shah <tanmay.shah@xilinx.com>
To:     <mathieu.poirier@linaro.org>, <bjorn.andersson@linaro.org>
CC:     <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <bill.mills@linaro.org>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 5/6] firmware: xilinx: Add RPU configuration APIs
Date:   Wed, 20 Apr 2022 00:44:54 -0700
Message-ID: <20220420074450.2034092-6-tanmay.shah@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220420074450.2034092-1-tanmay.shah@xilinx.com>
References: <20220420074450.2034092-1-tanmay.shah@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9545b249-251c-422b-7c56-08da22a26b16
X-MS-TrafficTypeDiagnostic: MN2PR02MB6606:EE_
X-Microsoft-Antispam-PRVS: <MN2PR02MB660637695A08A9C0D71E855ECAF59@MN2PR02MB6606.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ItvARubVHwLTt5toP6r4XG+Co/Y7V8V0aORP7+/bZHaKVQk1hyrmPGuLp4Nxo0z4//1JLYFFUHT//il5sdPU3QMk0mN8Y8tqnfp3miGgDxB/g1S4BUay35U8IPZLJzLJwq67s3e9XDGBn0PXgea7FPx1Nvif78iVIqsbgJPrNHCdcpTlERGj6B7q7ZUix4QZT8ZLA31n3s4RB7npmllOOADOARjjtyDxVlKV5IEtwijMnZfghajFdMXj9tVG9wsYAJ8naLl788KOcgkrIqoEpa33yp7RN8UDisAUR1k4ALWtF+wS4S8oahKjsoc/jNbQ3Kgg2ecW109TX6w+xqqUZyxnfHY9mD9sJCFHSW9th2DIzS5HTwbhs+SWUKh/zidHO6oYcNVil7SJON2NSEqay21/iac9TgWSULrxT2vvm/UNkYeXawmlr0SVbcPDv7GEm/fDyx0YswH7K3sZcqX1kFmr5DtKjHP0W7CdY7YaZ8iBYrgp507Gn4gHP81kTHyGplizA1ZFfYS/A4aoNq+lDYn9fAmE9xYIgqYhFCF8KY1DdYeD3Tu51mUz6Ge/z+oEvPrRkaJnFe/ElOdbzFmEoPujkf5FNbB+RFU06Vve3W8jMdSe6KthoSt2L7T20wFXFUOWlvnPfAI1flsVCgbmJDYjd1Reryz+Y6YIUB0BAdrIybJZdVIYOiPco09zYdJQMS3N4kaFdADi7ZS6GbwqEw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(186003)(82310400005)(47076005)(316002)(36756003)(7636003)(2906002)(1076003)(6666004)(7696005)(336012)(426003)(54906003)(110136005)(83380400001)(40460700003)(9786002)(70586007)(70206006)(26005)(4326008)(8676002)(5660300002)(2616005)(508600001)(356005)(44832011)(8936002)(36860700001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 07:50:20.2091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9545b249-251c-422b-7c56-08da22a26b16
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0044.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6606
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

