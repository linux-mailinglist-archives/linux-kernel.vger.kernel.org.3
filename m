Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383374F607E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbiDFNqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbiDFNpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:45:51 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2061.outbound.protection.outlook.com [40.107.101.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D5E4929DE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 03:55:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTFyj10kXNa7dEixZIVdCTicMC9sc+b/2PeLkjR7wTLmmsZYptZu82aXQrz6y6BQCA0535NQwNztgo/qv+G5RdLdm0+K0ilQpjzo/+fN22FNVKCB33nT8Ckj5z2Q2GfRxITb4qHdErWg0cX9UE5E+68mENg9Wy7cXlNLXwM4pGTvKgA1ldEic+q768tAHuPftnPsCoQcmV16qrS+MiVrPxsgjwjS+CfC3Ot4+k2eSefoC1Y0MNNmV/T7u67ZVaUWsPJaxRbGYu4brBfiPZUt4GN+6Uha7edydvIKj7XTW7B2/H6eeKPei2nUonGry+r/iE58WkQntR89RtY706MBNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Kb4qgkPNYfnJXYITzcIgPlcdEHsRWEqrpEcR8+j3dc=;
 b=eo3aF8t6vCi53Vjw+lkYJrIoT/SbFsQ02aEsAYYCBZSAyQtVN3nCHHujW6MxxGJOP/AcHiST7DQiDam4VdUxt8pITy7YaHkoE8RG8XLPdouhhlsQ5unT5146/xqlbWOr5kn5OeRG13dRE1vD4n381yMVgiOuqDM3ZItpw09xla0OkjMofYrB95MXOHRJxZZloTX1gzRs3TDxHdJyxEJvJN8PNUOQwiz0NVhHFQnzVBYQbsIXvdHRpAS1k56hsTGyUhPlxXgC47ZdRqXrZN5OX4GzSgr1oYnGWPGXDTn76NDUJf+ujqeBuymstXvR4dCcG1Zc6aubX61XTXSVkClUfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Kb4qgkPNYfnJXYITzcIgPlcdEHsRWEqrpEcR8+j3dc=;
 b=FUaBosFC18cL6scVQHWP7xz30Oq4fKCX8mwi7tEOwNEYtw0KEa7hTDSdZyI30DOc16YNHnufO92L9Bdv8FVEv0RYpaxnO55qSFOZ3vSbt50lcx49N9qJYWmKEzRqXXl5Ju8qLC2jGicy8PXTDN/Vec8AEgOtXKj8MixaJBXaKGw=
Received: from DS7PR03CA0102.namprd03.prod.outlook.com (2603:10b6:5:3b7::17)
 by DM6PR02MB6155.namprd02.prod.outlook.com (2603:10b6:5:1fb::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 10:55:39 +0000
Received: from DM3NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::1b) by DS7PR03CA0102.outlook.office365.com
 (2603:10b6:5:3b7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Wed, 6 Apr 2022 10:55:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT019.mail.protection.outlook.com (10.13.4.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.21 via Frontend Transport; Wed, 6 Apr 2022 10:55:38 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 6 Apr 2022 03:55:33 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 6 Apr 2022 03:55:33 -0700
Envelope-to: linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org,
 corbet@lwn.net,
 linux-arm-kernel@lists.infradead.org,
 arnd@arndb.de
Received: from [172.19.2.243] (port=36060 helo=xsjwillw50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <ronak.jain@xilinx.com>)
        id 1nc3K1-0007fI-Hf; Wed, 06 Apr 2022 03:55:33 -0700
From:   Ronak Jain <ronak.jain@xilinx.com>
To:     <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <corbet@lwn.net>,
        <linux-arm-kernel@lists.infradead.org>, <arnd@arndb.de>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>, <radheys@xilinx.com>,
        Ronak Jain <ronak.jain@xilinx.com>
Subject: [PATCH 3/4] firmware: xilinx: always check API version for IOCTL/QUERY
Date:   Wed, 6 Apr 2022 03:55:25 -0700
Message-ID: <1649242526-17493-4-git-send-email-ronak.jain@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649242526-17493-1-git-send-email-ronak.jain@xilinx.com>
References: <1649242526-17493-1-git-send-email-ronak.jain@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 862daafb-8489-4cf1-b277-08da17bbfc9c
X-MS-TrafficTypeDiagnostic: DM6PR02MB6155:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB6155955AFF007E284C0D2519A4E79@DM6PR02MB6155.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bTG/kox1+vX69OfpQakPeXuj03j7WLlFd6Z2AZ+fBITC1VJQ7Tu8W2yy5Ic6aHkFRq4yV3RCb7idokDTi1MC0GnpNPsXEqWCQbptMjm6fWOf/yDsLIRIG+rQOnfboN/cYLr9wNJBQG1F+MUQL3YjBvUXnGhGLZBppFwKrKbgUVVEltPwZH5aRYNP+6xMdZ02lHs8C6eLsX0G7eZDt6Axg9asVIT+1EOVpe68v0cB7jIgVzIWvS2h81fsg4/ngzuCmK/9Pg7tsTh26z3hNHqDX8sANcca855V9ymEuVzJLK/p7gE2y+4A67rm6WSVLlDYXTLZW8gAh2OSr9Nc8Ksxcr5yFkdqkWSJLJE8oqDFy+fHAS7mqa6nwSGJRo2cTQBArB39/ddcULhtLQ+BVtURFnQsH9SuUUQitO94WGGyCIzZZBKASHt0xQHLnchYcubYsCBmMP8NSX4odqwfoHASDaM2kH6JA+iARE96kmc/OzJiq0blU7xkLTIYPIFpi0Ct1UZTVMcon+N/PdQRRaYju7sz1O+Pe2iOZVpGsDosfh9pnakx24VTbw2MpmgLV0HDg7ftZaMthRO78EjKjNgrJLH8Byu9VBSbaDAGDrMD9vYLq+JqPUhPTKPD7nE3uCjSgucu6qXdT2yq+UwEzgkS8vAUhnzK4f9MLcr/1hbnuOpPrWXuypE+df0OCWr9VnFXocXaR10L97V8bCPgtVm+qw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8936002)(26005)(9786002)(186003)(36860700001)(316002)(336012)(54906003)(83380400001)(107886003)(36756003)(44832011)(2906002)(426003)(6666004)(70586007)(8676002)(5660300002)(7636003)(82310400005)(47076005)(4326008)(70206006)(508600001)(110136005)(7696005)(356005)(2616005)(40460700003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 10:55:38.9860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 862daafb-8489-4cf1-b277-08da17bbfc9c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT019.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6155
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we are not checking feature check version for PM APIs as
the support may or may not there in the firmware. To check the whether
the feature check API is supported or not in the firmware, allow
checking for its own version.

Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index d27a3b20227b..6ee94f31ac98 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -175,7 +175,7 @@ static noinline int do_fw_call_hvc(u64 arg0, u64 arg1, u64 arg2,
 	return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
 }
 
-static int do_feature_check_call(const u32 api_id, u32 *ret_payload)
+static int __do_feature_check_call(const u32 api_id, u32 *ret_payload)
 {
 	int ret;
 	u64 smc_arg[2];
@@ -192,22 +192,12 @@ static int do_feature_check_call(const u32 api_id, u32 *ret_payload)
 	return ret;
 }
 
-/**
- * zynqmp_pm_feature() - Check whether given feature is supported or not and
- *			 store supported IOCTL/QUERY ID mask
- * @api_id:		API ID to check
- *
- * Return: Returns status, either success or error+reason
- */
-int zynqmp_pm_feature(const u32 api_id)
+static int do_feature_check_call(const u32 api_id)
 {
 	int ret;
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	struct pm_api_feature_data *feature_data;
 
-	if (!feature_check_enabled)
-		return 0;
-
 	/* Check for existing entry in hash table for given api */
 	hash_for_each_possible(pm_api_features_map, feature_data, hentry,
 			       api_id) {
@@ -221,7 +211,7 @@ int zynqmp_pm_feature(const u32 api_id)
 		return -ENOMEM;
 
 	feature_data->pm_api_id = api_id;
-	ret = do_feature_check_call(api_id, ret_payload);
+	ret = __do_feature_check_call(api_id, ret_payload);
 
 	feature_data->feature_status = ret;
 	hash_add(pm_api_features_map, &feature_data->hentry, api_id);
@@ -238,6 +228,25 @@ int zynqmp_pm_feature(const u32 api_id)
 EXPORT_SYMBOL_GPL(zynqmp_pm_feature);
 
 /**
+ * zynqmp_pm_feature() - Check whether given feature is supported or not and
+ *			 store supported IOCTL/QUERY ID mask
+ * @api_id:		API ID to check
+ *
+ * Return: Returns status, either success or error+reason
+ */
+int zynqmp_pm_feature(const u32 api_id)
+{
+	int ret;
+
+	if (!feature_check_enabled)
+		return 0;
+
+	ret = do_feature_check_call(api_id);
+
+	return ret;
+}
+
+/**
  * zynqmp_pm_is_function_supported() - Check whether given IOCTL/QUERY function
  *				       is supported or not
  * @api_id:		PM_IOCTL or PM_QUERY_DATA
@@ -255,7 +264,7 @@ int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id)
 		return -EINVAL;
 
 	/* Check feature check API version */
-	ret = zynqmp_pm_feature(PM_FEATURE_CHECK);
+	ret = do_feature_check_call(PM_FEATURE_CHECK);
 	if (ret < 0)
 		return ret;
 
@@ -265,7 +274,7 @@ int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id)
 		 * Call feature check for IOCTL/QUERY API to get IOCTL ID or
 		 * QUERY ID feature status.
 		 */
-		ret = zynqmp_pm_feature(api_id);
+		ret = do_feature_check_call(api_id);
 		if (ret < 0)
 			return ret;
 
-- 
2.7.4

