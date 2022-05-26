Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CA5535408
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 21:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348780AbiEZTjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 15:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236622AbiEZTjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 15:39:36 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AC65B3F9
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 12:39:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyd8kqphYalYqnKP+v4mN/JvttuS3rvE3P1k1p5CAZJsL8gX1ewMrLS/F5RV4kVpy8M95dl3/DdbDCRzEvtDbCRGjsVhG0kVtlpj0iJ/Jf197hRkosWfoQXoxyCPQ7rBFXbnvIuaj5bD4fJmKXm5fpDJqGbl1zpHfvr92ONRKlCxRWjHWryd49gVDEOIejl81Nxt5X45RuGfgRR4JN38AIEqJKjHuGmY0BttVVQBXzr66sx+pFFayCVbSod053o9Cc6NqeUld3sYk5UKLWqFjyJ/Wa+jl2ogMt+BdBqXi7p5DOHjTbkNHng+JaAsEM6Tvbo+IwFX9NbXAueX7xd5uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5B5v3jV7EKPjaPLdZTMVeoYacQ4KUGV4SFw/SB3yDyc=;
 b=RvTfL/dzGqG/Q0vWos4ZJ/fLFw/ViGIrHVF+xXPeUgaCN+BxRWTrNdZIaTkwgY1g4zMkCd4SB9eJA1xzDJKImRUOsIFm94Y4xTraE2QWZaVsw6xHbfZLxzHGBN6LfHIjVYi4UrYVepQ+4jkA/NxpfFnyB8dxy1M2nv1/3l1GusgN6oIe/fm7i79gPnCeQhPj286uQpazXc0fp1oSUPSIMDR8rMeS+p9ssWvq/xg0LbLo7jvKRa95H4DToVE4RnvqI18oGZMB3ZUsjNN2gAZ0/m6Y2riI6290TlqOdpin64lUB7d8HLENeQK9SLMtj7dz16D3Jc8pI9dm7V78JCEebA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5B5v3jV7EKPjaPLdZTMVeoYacQ4KUGV4SFw/SB3yDyc=;
 b=Y89eb6jtMXhfX9HU1H190SUW07RhcF+GWQWTIIoQm7EDLyx9hBFf8K7nNYJkN3DryllNv2Ut8yTLAYX8eCo10wXC/JQWEDD44fZ8LHsT6pdeBL9FIp/lJuDdORHS7KYGLhdF3+ZrHqmm3s3IZgjhgAny8+zlDsPopT4R83kA9iw=
Received: from DM3PR11CA0022.namprd11.prod.outlook.com (2603:10b6:0:54::32) by
 DM6PR02MB4300.namprd02.prod.outlook.com (2603:10b6:5:1f::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Thu, 26 May 2022 19:39:31 +0000
Received: from DM3NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::30) by DM3PR11CA0022.outlook.office365.com
 (2603:10b6:0:54::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Thu, 26 May 2022 19:39:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT055.mail.protection.outlook.com (10.13.5.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Thu, 26 May 2022 19:39:31 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 26 May 2022 12:39:31 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 26 May 2022 12:39:31 -0700
Envelope-to: linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.3.14] (port=33702 helo=xsjtanmays50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nuJKV-000AW2-2P; Thu, 26 May 2022 12:39:31 -0700
From:   Tanmay Shah <tanmay.shah@xilinx.com>
To:     <michal.simek@xilinx.com>, <abhyuday.godhasara@xilinx.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tanmay Shah <tanmay.shah@xilinx.com>
Subject: [PATCH] firmware: xilinx: Add TF_A_PM_REGISTER_SGI SMC call
Date:   Thu, 26 May 2022 12:39:28 -0700
Message-ID: <20220526193928.3033286-1-tanmay.shah@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1f40b4e-6d2e-4cd5-fd18-08da3f4f74a0
X-MS-TrafficTypeDiagnostic: DM6PR02MB4300:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB430094291B087736A781A5F4CAD99@DM6PR02MB4300.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SsW+qX0ghiOtSOOPWbyGm2KmOx/O5s+dV9ElCOZYrawtZDZ7rYZLsyzYzOvxbFv2eK7SJ7La7qmnC4fV8PUq96SSY2PpvyqjINVAJWy3R/thgiJJavBU0TrVq1VEoWjy4fjejNr2rr0Q4V1cKo/wgPEd/twcAN+guH3Z7xdu4WioAI1RHabTNEhf6gARXh5MKsAo1PxSRGN6u42AK6zWfojqN43RVjh/a+A3H5ujH6SuL6mvWRF4J8q4496EpWrnaIeGq6/xR+fKxVPJSxWWfZJ7unPdvc9GaGULU6bX7ZMyAOPLWKUBGRsH0ttCHbxmIEkknResSFbCGJl18MpJ2vWTWtpdffRUv/F1HFZMqnJqqrZNAcdchSal4Yu+RoppGxMFgs7fSxjNBCerQ+zUfKeYWJM0h6Xfqy6tsE6qW3SIlReFjoJCluG28S3lSHRFVH3ecGrJDEYtLZkW5yW4PuzEgLpFcCAdmJEkcn2nKsLZz87nCKbWCDhWkLs34jGzAxYP9NSP+9yDbO92DLHivA+Svu3gH//e+my631M3dcnobg0fL6XBlh8RdKN6u7ru4Ws7kNWBDiZDMTFaO7bL6G8/MaLQyoxJGCSNqyM85gz76NY1/E+LXHIytv3GlDye2gbDBFwBsm1EbYV5dU2Afdpp+yhQjbGGyjdJCANaLJTXPbs+t/oXOlnx46KNSB1bsMcKB4TZls5Twldw/mW6dg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(356005)(40460700003)(47076005)(426003)(36860700001)(83380400001)(44832011)(336012)(186003)(1076003)(107886003)(2616005)(7636003)(9786002)(316002)(4326008)(70586007)(70206006)(8676002)(36756003)(82310400005)(5660300002)(6666004)(2906002)(7696005)(6636002)(54906003)(110136005)(8936002)(26005)(508600001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 19:39:31.7082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f40b4e-6d2e-4cd5-fd18-08da3f4f74a0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT055.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4300
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGI interrupt register and reset is performed by EEMI ioctl
IOCTL_REGISTER_SGI. However, this is not correct use of EEMI call.
SGI registration functionality does not qualify as energy management
activity and so shouldn't be mapped to EEMI call.

This new call will replace IOCTL_REGISTER_SGI and will  be handled by TF-A
specific handler in TF-A. To maintain backward compatibility for a while
firmware driver will still use IOCTL_REGISTER_SGI as fallback strategy if
new call fails or is not supported by TF-A.

This new design also helps to make TF-A as pass through layer for EEMI
calls. So we don't have to maintain PM_IOCTL as EEMI API ID in TF-A.
Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c        | 16 +++++++++++++++-
 drivers/soc/xilinx/xlnx_event_manager.c |  5 ++---
 include/linux/firmware/xlnx-zynqmp.h    |  7 +++++++
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 7977a494a651..d1f652802181 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -2,7 +2,7 @@
 /*
  * Xilinx Zynq MPSoC Firmware layer
  *
- *  Copyright (C) 2014-2021 Xilinx, Inc.
+ *  Copyright (C) 2014-2022 Xilinx, Inc.
  *
  *  Michal Simek <michal.simek@xilinx.com>
  *  Davorin Mista <davorin.mista@aggios.com>
@@ -340,6 +340,20 @@ int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
 static u32 pm_api_version;
 static u32 pm_tz_version;
 
+int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset)
+{
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(TF_A_PM_REGISTER_SGI, sgi_num, reset, 0, 0,
+				  NULL);
+	if (!ret)
+		return ret;
+
+	/* try old implementation as fallback strategy if above fails */
+	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_REGISTER_SGI, sgi_num,
+				   reset, NULL);
+}
+
 /**
  * zynqmp_pm_get_api_version() - Get version number of PMU PM firmware
  * @version:	Returned version value
diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
index 5dcb7665fe22..2de082765bef 100644
--- a/drivers/soc/xilinx/xlnx_event_manager.c
+++ b/drivers/soc/xilinx/xlnx_event_manager.c
@@ -647,8 +647,7 @@ static int xlnx_event_manager_probe(struct platform_device *pdev)
 	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "soc/event:starting",
 			  xlnx_event_cpuhp_start, xlnx_event_cpuhp_down);
 
-	ret = zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_REGISTER_SGI, sgi_num,
-				  0, NULL);
+	ret = zynqmp_pm_register_sgi(sgi_num, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "SGI %d Registration over TF-A failed with %d\n", sgi_num, ret);
 		xlnx_event_cleanup_sgi(pdev);
@@ -681,7 +680,7 @@ static int xlnx_event_manager_remove(struct platform_device *pdev)
 		kfree(eve_data);
 	}
 
-	ret = zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_REGISTER_SGI, 0, 1, NULL);
+	ret = zynqmp_pm_register_sgi(0, 1);
 	if (ret)
 		dev_err(&pdev->dev, "SGI unregistration over TF-A failed with %d\n", ret);
 
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 1ec73d5352c3..cbde3b1fa414 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -34,6 +34,7 @@
 #define PM_API_VERSION_2	2
 
 /* ATF only commands */
+#define TF_A_PM_REGISTER_SGI		0xa04
 #define PM_GET_TRUSTZONE_VERSION	0xa03
 #define PM_SET_SUSPEND_MODE		0xa02
 #define GET_CALLBACK_DATA		0xa01
@@ -468,6 +469,7 @@ int zynqmp_pm_feature(const u32 api_id);
 int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id);
 int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value);
 int zynqmp_pm_get_feature_config(enum pm_feature_config_id id, u32 *payload);
+int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset);
 #else
 static inline int zynqmp_pm_get_api_version(u32 *version)
 {
@@ -733,6 +735,11 @@ static inline int zynqmp_pm_get_feature_config(enum pm_feature_config_id id,
 {
 	return -ENODEV;
 }
+
+static inline int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */

base-commit: b1d84fc09a961e0a8be3d3dc6ca1b7cddc3ced87
-- 
2.25.1

