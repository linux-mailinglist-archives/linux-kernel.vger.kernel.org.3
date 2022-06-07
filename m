Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E368542240
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbiFHBy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1586886AbiFGXwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:52:05 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86EF2914C3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 15:43:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0SQ2RsDsSaMJDavlYOQ6ZqI9prh6cHBwCumln8MSO2+xdSnTFuvuNgpeeUYGIDVgF24Gw5NNE3SjoazyMfnTp/S+ltMeUkFNIqUgiOsFM8Ro8XtjGUbBoAGqzuxF7RTEcLfTBWHhnFbHX66BuFc2hQgezx4xoRlZT+98RkurXa/FO4h6vpFBVU2h9JGShMDc1MT4uIMgwvEwJvHj3A8Nb9jm0GqS0SMoeQutVyBPonq1Y9YZN4SpcMa6oK53XpnZ4Rmt/+siHnXJwaRtnRWmMlkpG9wmIonCtSC/bmraR40kUPsLg+rZfftsZMiTe+GMqhP/io2M2nLWaB8HAJkGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UNFOd4SSFIUFxj1Gmk/oGwGtlL9Jec/tgbwZ3VVBAY=;
 b=b89xjf/IfOK5Xl/cYRdvApHnsmjCWvrqBAkloqoJ4dLH4UuFQT/oa5iMvq5BC8tOEAlJ4NR5lI+crjfd1V/76J09KxmEwzxiu6BNIlyBPGI9PsyP38SRVpeqzxUmF+P6bJDM94Ez2dfIoAtSeGFFoqimjXE14KclXhwqgu9vDZHvEjXTP4ouenktykL61IYBXZpMjMC9Zeolyy9nJTYyXrbpTJq/bb/o0F6Sd9kNv23EnegX64AtnR8Vs77UVkAGu+e4JWychmmGJ2ThgTLYP3woKN57lB2QrV/NC7D6kuKeIexQxBFgb67Z2GI26GRnGLU8NJftApD9xw3l7Sry7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UNFOd4SSFIUFxj1Gmk/oGwGtlL9Jec/tgbwZ3VVBAY=;
 b=kNQIrqZ61ldxl6bAp2aBirP2nA9r9hpd0avHHS+tMEDUYaGxEH+G+dB4R1pThErWnrLsuXk/9dbhB7SBouS02DvkmpCQ03a3iewvT+PcZVE1yBuMITclomaSroD1Drf//jpQ968VaremrrlkImFREyDdIeOXuMfVceHPiQxR7MU=
Received: from BN6PR1201CA0023.namprd12.prod.outlook.com
 (2603:10b6:405:4c::33) by BL0PR02MB4578.namprd02.prod.outlook.com
 (2603:10b6:208:49::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17; Tue, 7 Jun
 2022 22:43:18 +0000
Received: from BN1NAM02FT054.eop-nam02.prod.protection.outlook.com
 (2603:10b6:405:4c:cafe::80) by BN6PR1201CA0023.outlook.office365.com
 (2603:10b6:405:4c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Tue, 7 Jun 2022 22:43:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT054.mail.protection.outlook.com (10.13.2.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Tue, 7 Jun 2022 22:43:17 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 7 Jun 2022 15:43:16 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 7 Jun 2022 15:43:16 -0700
Envelope-to: linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.3.14] (port=38018 helo=xsjtanmays50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nyhuu-000DnG-Dy; Tue, 07 Jun 2022 15:43:16 -0700
From:   Tanmay Shah <tanmay.shah@xilinx.com>
To:     <michal.simek@xilinx.com>, <abhyuday.godhasara@xilinx.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tanmay Shah <tanmay.shah@xilinx.com>
Subject: [PATCH v2] firmware: xilinx: Add TF_A_PM_REGISTER_SGI SMC call
Date:   Tue, 7 Jun 2022 15:42:54 -0700
Message-ID: <20220607224253.54919-1-tanmay.shah@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47769c96-35d1-40d2-c8fa-08da48d71d9c
X-MS-TrafficTypeDiagnostic: BL0PR02MB4578:EE_
X-Microsoft-Antispam-PRVS: <BL0PR02MB457844E525CEC68DB4518E10CAA59@BL0PR02MB4578.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0T1vxmQLpX3EC4LGsfJLEDQdp+KrjJ+C34dzx6ewYu7cO0hY/O7HNqV0fWEcrv5QPGJaL4RrYf2NSzd7zjdc1JM1Qq0e9VxOXVk2gINsOK7zsAAjYkZoUa7t4EEcRjeRpzzW69G9kgCfwT4izXxjoiWd0obODssyajZnFlJt9agbpd8PWPTvSwQE9oVlOJlt/FYCOEQ4fCfdqHdmdI3P9Vayq/dOg0T+0xvYiPhQjqFcNColgC/11/Q8cVYO0G2YievzXVgDkZ/ynLWxTBRhyrhr9s9RNjVVlh+wTK4/OTRWYkmD4vGnCfiCm+Lb8ZAX3jalfTdzgvHdK3GuwiaddWjGuUGvpQ2DJNcfRMKa2pX1Zhn6aH7exXDAe/Jej7cOx8faEUWwxhoA30fpHG0HmiJuPZiSk4SvDZnpWZo6GMwWcwa1YHekZ5cWHf1oD5/sHwXpCXEfEaDjaWSW85EeTEhddcLqCoqW4BF1uy6rSXAEjo8JWLkUCIW7SNkLPGxV6PeBm3MT9DLGYd0Y8L3zdjLKq0IkNXcoSiMD3X8h7XrwTCe7N8eUGM+gWUp+dz+Znjwi1bmRvHa5a3VC+1MQuyc1GzNWKRGYYduZJF8R1DIk3gRLeWYsk6nBUrKT5Qv87wG0rG1V9t6EETTCJ8XY01nNy3Eoe4YmW7WcH1b+wwsJS0qRm1KfYQI0er86oPYlWY8yaDUSmRMxBsgHg6eONg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(70206006)(83380400001)(336012)(426003)(186003)(1076003)(107886003)(36860700001)(8936002)(508600001)(5660300002)(47076005)(40460700003)(9786002)(82310400005)(26005)(36756003)(356005)(7696005)(6666004)(110136005)(316002)(2616005)(7636003)(2906002)(54906003)(8676002)(4326008)(6636002)(70586007)(44832011)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 22:43:17.6766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47769c96-35d1-40d2-c8fa-08da48d71d9c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT054.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4578
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

Changes in v2:
  - fix commit tag. add new line before signed-off tag

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

base-commit: 73d0e32571a0786151eb72634f1a4c5891166176
-- 
2.25.1

