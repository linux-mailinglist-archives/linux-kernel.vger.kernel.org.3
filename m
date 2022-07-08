Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1621A56AFED
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 03:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbiGHBlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 21:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237043AbiGHBkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 21:40:53 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2087.outbound.protection.outlook.com [40.107.96.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010C57358C;
        Thu,  7 Jul 2022 18:40:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmfHOMRGri5M7/bB9ERh+xN2E9znlYR9MWsB3xO75M9jlaNrX9AYFEhXRmDjW/ijDEmUtt/hHj/Xo8pTYlDFKuO3iFT3dmAaXcI1sb6VTHXQy8CCf1rcLh5RKpnjNUm5FYqX9Jp/+pFRJHnePPA8I98rBpHFrJFUPFrMxDAP8tV2uWHGY07MLff1xJWmkFRfxj3mvC8CW2C8xWcNPnFmYHpPee9QYXP8jsEJ59G7t9jutn/+uZDibYjNjY3te+KWb5UQ8Fo2YAwY2R8epulfxoynpg7+6MNV/oWEq+mZFt0QNwuMIUG75p4FGxstLdeI6ft3lyxM1CorycOURiWVgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDjNzXR6XMB7/LVT9Nu6+wIQ8n72+B1POfCMH2L7Ho8=;
 b=GpfUAqhbDLDtfFT7H8xS5czomG5Xz+FODBfEfQ0q/YfIJDyCCLRzA7xqCdIZ7qKJpEE6h0PRh33YZp41IRrPrYpGWQdn1Tx6ZMqUYOh384q/DN0/yXXEY5IQ/286pP33FCi45UrXlqTNpKK7Pu1+6xyRGgjrySIbROHSU/Q3GY6D4wrD6tSudSZoq7T95X03RyAHaVTzmeHQNqmSCDgPAuiSEAXvDeiMzKBb2kPV/0HMcz6+iAnlZF5zhs3bJ7Jud+P8y3fD1hfzY6AEGqcoZQXUE+AjJclUjkewwpsPA+FYOaO4I7W0QYy2RQ3G2GfId1et3Da/5r+d3Oh3fVN6oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDjNzXR6XMB7/LVT9Nu6+wIQ8n72+B1POfCMH2L7Ho8=;
 b=n5Q6tmWX9vsduScOJFGVIyWqXe/jG/39SDe2rsXQeH01O4sDJPZh9dMYTR5mFJTYtCqL7IEewqMh4/5hlW1aRONrQXllE8QqqUm3iZ2/K0UljER3GnSwQwAr+YcW7eWov3uV9utHM6qJ7ReetRZY9DdvA7+DqS4rPal1PYqC4T8=
Received: from DM6PR12CA0005.namprd12.prod.outlook.com (2603:10b6:5:1c0::18)
 by DM4PR12MB5262.namprd12.prod.outlook.com (2603:10b6:5:399::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 01:40:49 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::cb) by DM6PR12CA0005.outlook.office365.com
 (2603:10b6:5:1c0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16 via Frontend
 Transport; Fri, 8 Jul 2022 01:40:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 01:40:48 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 20:40:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 18:40:34 -0700
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 7 Jul 2022 20:40:33 -0500
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <michal.simek@xilinx.com>, <ben.levinsky@xilinx.com>,
        <tanmay.shah@xilinx.com>, <michal.simek@amd.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v9 5/6] firmware: xilinx: Add RPU configuration APIs
Date:   Thu, 7 Jul 2022 18:39:54 -0700
Message-ID: <20220708013955.2340449-6-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708013955.2340449-1-tanmay.shah@amd.com>
References: <20220708013955.2340449-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bb5b97a-0114-40f3-bd90-08da6082e285
X-MS-TrafficTypeDiagnostic: DM4PR12MB5262:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8UkVtD2hGQiERb51VAU9Mx4R93uaXEzUsH4ZM3t0OMPItawCottR20Xa7c1Iwyv9NK6lKv6rLtB3oLJdlJquJkSdWmFddn9fJaGcxI/a8EkqZN9qSxif74qk41fTiFcf0Q8482xj02y3tqT+DEm2Gdku1cDGaycrOJvInAyUwxvOrFXTfB5mgbJIlpAXjXg+5m+pvFipsQ4Igdt/TRKWjwrJXKvvoG0OHU9SGoSRu+8QJ+Ybnm5ZDqSdARrS4a3oT3vhcgsuxj99+5KyDGxsensnrzpevFMY2dnIAm1a6KN5RMD6mIozFJa6hI0QyPUkS3v+u4ApKc2NxC81tEXKFXyrPF1YHcLT1eq1C/XU6t+DS12DFE3pPAWDVUf0qZv0YYV6kBJ/BfsEiv/ZG9I7y5JJkbaeKDAZqcTJVrAaTmO2BT3czi5tuR5mdj2oO6NhV3yAh3vLWUX8zH3uT01DVrF4P930TE8Vk6rywnUE7KPzFQLFrsbuSD+M1Z/ELayhOaMW57T3C/LO+RqhawYH3Q+kQvpzz5cXBvKx1619ZoRN+ROtjDVTHj2uNbd5Mk1pUxpc/+I0GFnXrLZdsO2PapltgsmTf4q8kJXNT5eDmbpHtFz4pNujaMI2+28en3Cu1SC49mfmKj1HfOCW3QqrWsJqudsCuDXlgbzm7x65FpS4GCzt9K+sTjR2LmGdoVOTfd4QE5F56+kpTh8jRGIMUBdrDFOFe/zarCpnUjkavxaiIX5lYOP0anaE8+LRud6iIVSfR8arjRsV7GOsrjSNOxPiop2KaQuhfC0pnQo+bLsVhrfPbwXiqzxlgs3RVS/OVjtI1i1NyPAx2Eqt5tEpf1mw/4BQoHNuaycknBb8H1IW91OfJn0f3LuyX+1ogDA2
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(396003)(36840700001)(40470700004)(46966006)(2906002)(47076005)(40460700003)(36860700001)(81166007)(6666004)(336012)(82310400005)(426003)(44832011)(6636002)(186003)(34020700004)(54906003)(36756003)(40480700001)(83380400001)(41300700001)(8676002)(5660300002)(8936002)(1076003)(70206006)(70586007)(316002)(26005)(356005)(82740400003)(478600001)(110136005)(86362001)(2616005)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 01:40:48.7839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb5b97a-0114-40f3-bd90-08da6082e285
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5262
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

This patch adds APIs to access to configure RPU and its
processor-specific memory.

That is query the run-time mode of RPU as either split or lockstep as well
as API to set this mode. In addition add APIs to access configuration of
the RPUs' tightly coupled memory (TCM).

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
  - Add missing function argument documentation

 drivers/firmware/xilinx/zynqmp.c     | 62 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 18 ++++++++
 2 files changed, 80 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 36384c4a4881..a289ff241818 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1145,6 +1145,68 @@ int zynqmp_pm_release_node(const u32 node)
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
index 407796f4464e..f361f5da1c4b 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -496,6 +496,9 @@ int zynqmp_pm_request_wake(const u32 node,
 			   const bool set_addr,
 			   const u64 address,
 			   const enum zynqmp_pm_request_ack ack);
+int zynqmp_pm_get_rpu_mode(u32 node_id, enum rpu_oper_mode *rpu_mode);
+int zynqmp_pm_set_rpu_mode(u32 node_id, u32 arg1);
+int zynqmp_pm_set_tcm_config(u32 node_id, u32 arg1);
 #else
 static inline int zynqmp_pm_get_api_version(u32 *version)
 {
@@ -775,6 +778,21 @@ static inline int zynqmp_pm_request_wake(const u32 node,
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

