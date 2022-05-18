Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EBC52C3C3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 21:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242197AbiERTrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 15:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242166AbiERTrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 15:47:03 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7831A6AE5;
        Wed, 18 May 2022 12:47:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZ5sb8u7m2NPuCjtyzLhN3QE3po1RUzqmmBhC9hUk9Yz9VLrhZCUhWnw6uQFOR3gNfCH9vTrmGi5dgV5CvYugURlapZkxmO4AzNbJrsF4ICMq7wfX1GoL6e1BmOm71Op2W8xQjmaeDcf1v97YMsRng1FkvHvwy0lQOjK+NYnlEkhF95yT+wpjraND0x+SHYFUe8PCSnl80KLqX0Ujro5OJLBCzLcBLxvSv28klXhTOcc/h27LvJupeS0ZYPwqS9H+4mBipu070nkYh0jMkgftGcYdVFHtvxPQ+pfx/pdDJOkB263aLJk4MaLT70/r6mbfMDKPN0XK39P9uMQGdvOCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9GfrNZEtH64PLB3Bc1/vBUZBz3Zn3JA8uDhosaX5dE=;
 b=HgFgSDDlg/e2Iw0bpF0BZ3l5t+eqvb5UuVtl5BUzAfCfJtJCHZtynURMERw7jUtwx4reZ2w7j4X94nC77pa1+T2q5lHahVuySSouamHZlQyeQ3tCyLpFaWdJWEBdbzhQyBMLUTlcbYs0ze1kddxdBRQzg3hGvBANuIuLsae+V/0pDtMm3t2wkdcvIaiZMRJWiq+zbJEG7A7vO3wOk6Cqlkl5O62JQW869njObWmTx3FTtO97WQQJGOU0vHCalBQPHSoU6nClqu6hqGDGW7L1Mws4Fhq9vQ3ZUGsNPo1q/fzv0dnrdPEcjANJ9RNdbBeUJ5MEHm+biR71MC+HMoK8bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9GfrNZEtH64PLB3Bc1/vBUZBz3Zn3JA8uDhosaX5dE=;
 b=ZlP9qd8MWpuiR3rpGoTb5YdYE2Boi6C1FB/bb3rpCt0624qRHJZKLJcL7w4Akv9Tnb74AzVWI1fxAhn+rBqibC+IXaCc7hdsNzWmxB+O3nDkEtbIaHUfxgrjq+mdyYmYMiyT8xVCszu0wjPCj/d70vwyfVEvjZKnUAYnVI3/JOo=
Received: from DM6PR08CA0001.namprd08.prod.outlook.com (2603:10b6:5:80::14) by
 PH0PR02MB7272.namprd02.prod.outlook.com (2603:10b6:510:9::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Wed, 18 May 2022 19:46:56 +0000
Received: from DM3NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::17) by DM6PR08CA0001.outlook.office365.com
 (2603:10b6:5:80::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15 via Frontend
 Transport; Wed, 18 May 2022 19:46:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT032.mail.protection.outlook.com (10.13.5.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Wed, 18 May 2022 19:46:56 +0000
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
        id 1nrPdA-0004Ew-4X; Wed, 18 May 2022 12:46:48 -0700
From:   Tanmay Shah <tanmay.shah@xilinx.com>
To:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <michal.simek@xilinx.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Ben Levinsky <ben.levinsky@xilinx.com>,
        Tanmay Shah <tanmay.shah@xilinx.com>
Subject: [PATCH v5 4/6] firmware: xilinx: Add shutdown/wakeup APIs
Date:   Wed, 18 May 2022 12:44:27 -0700
Message-ID: <20220518194426.3784095-5-tanmay.shah@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518194426.3784095-1-tanmay.shah@xilinx.com>
References: <20220518194426.3784095-1-tanmay.shah@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65704f8b-d2ce-48f9-27d0-08da39072a71
X-MS-TrafficTypeDiagnostic: PH0PR02MB7272:EE_
X-Microsoft-Antispam-PRVS: <PH0PR02MB72724924E764690CF2377CA0CAD19@PH0PR02MB7272.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: clwv0RJbh/3DlODryZo4Qjeyxo5TAuYzStqQp9UiNBO0xkhv1PY3F4T26YpWk1Cl9SMckNLqg7FoDqv1VQCwzenZdaLEZMRuHCrwArWzTtiQWX0EzIa7lPrfcEaNmSMBuSrimUuvsMeq1QpJhbur7ydqR+paAZs7RPAMF6MfP+jqMvMGkotEnVmEvqjaI98QZ9in8K/74uxzJOcu1H0snE0cv9l6Vez/Sl2YwTk3b6+vt7m4dGDk8bqW5Kka72p5btV5dT+x6eVZm9uvOI++NxnJoh7VSSam3gbOBZu8O4UX1fJoHpJ9ONW6EqBOF3VrlPXaQ4sN9GwVopEsrb2BmmILLuRvetiUSvHEkuX7OB3xTjRu5HNU7rXQaK6TnwRPRz9qL6K4/VbeQhXp51AqSoR2CUd2yTUdhwO+Y76M1IA1pxKrOHrkp5HZR7uT/vNmHJsAdO7TwVerscLNwHuAT+rlm9CufSnCDUQTgdLSLmryJS3frDH9DOW9rCFI/VJcXzngAJL0XZUOT9OcQaXsN1KJ5Tay3J7sSettSuhc8ZIX+zBbxpKql8PYvUcL+kM5p0/W1rdAhLqqywN79xX0wM5ALGRWHIpPGQWshB3Gymwar7oyQZId0LsfqMPT11VMkbmHj/6LOq0tzsMMxfkk66DGOaaTrrNc+7dGJ3QszbzytHjUKPkAnptgm3MSnbQt0a0Km5qJzdaIUA0wBj4Ozw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2616005)(82310400005)(70206006)(508600001)(4326008)(70586007)(110136005)(8676002)(6636002)(316002)(36756003)(36860700001)(54906003)(7696005)(107886003)(1076003)(336012)(9786002)(8936002)(7636003)(47076005)(83380400001)(426003)(6666004)(5660300002)(40460700003)(44832011)(356005)(186003)(2906002)(26005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 19:46:56.5178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65704f8b-d2ce-48f9-27d0-08da39072a71
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7272
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
---

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
index f21ece56695e..fabdbac868f5 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1067,6 +1067,41 @@ int zynqmp_pm_release_node(const u32 node)
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
index 54331b726ab0..bce3465a70a4 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -12,6 +12,7 @@
 
 #ifndef __FIRMWARE_ZYNQMP_H__
 #define __FIRMWARE_ZYNQMP_H__
+#include <linux/types.h>
 
 #include <linux/err.h>
 
@@ -81,6 +82,8 @@ enum pm_api_cb_id {
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
 	PM_REGISTER_NOTIFIER = 5,
+	PM_FORCE_POWERDOWN = 8,
+	PM_REQUEST_WAKEUP = 10,
 	PM_SYSTEM_SHUTDOWN = 12,
 	PM_REQUEST_NODE = 13,
 	PM_RELEASE_NODE = 14,
@@ -481,6 +484,12 @@ int zynqmp_pm_register_notifier(const u32 node, const u32 event,
 int zynqmp_pm_feature(const u32 api_id);
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
@@ -741,6 +750,20 @@ static inline int zynqmp_pm_get_feature_config(enum pm_feature_config_id id,
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

