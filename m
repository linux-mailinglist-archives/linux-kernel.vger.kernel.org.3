Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56E24F6097
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbiDFNqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbiDFNpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:45:51 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC219319E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 03:55:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hI+HSwdB+xqYaJK5Sil4Z+s+UwFz1nzVM8pp8TKdhk1caGL+ijmyb2tR0kONyDpLlyNAOC2wo4vvTS9ImGmo+gfR7LTX/+6OsS+Ig3uQ/kZn4/W7FjSUiwF+afnxlJr3ByuqeNxUHEu/4ziyLUj6+0PxrgvXGeMVvxv2h71zuUJmBuoxrJShiN29o1Ae84fZ7OlVMeUJc7XpbnHRdVW5PCVZsv3wx7jKNTerI9p1hUDbpstxOFF3HvXXVPhgPFaPUI364nMtQoBDFdsiQ/aaXpjGdTgDV/bcjWNXKdy6C57wn+npw3AecVC7eW+mNUii5QrFZak8kcjrG0xMJew6hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dNOROgwWaKb/XeZ2AEYZ8G4UBcBsUX9iIkwlWX4Xn8=;
 b=Lws4sknobqXsPe5jRKsaNxd5zSFdqCjcBvJHggwSWXEHNWSc0MObv8hNVAvfaWsvMZKetTUE0sLFnXp8XrOM2671l0zIWH+n88HKd0j/7fTnZJZPGEpbKn1Q/K3tzu43CIi1N3LAM4Fn2o74XxxDep6LvU7Y2XdHr+abZ1gaQgKRNEKXqXWLpuBClTunMdh0Vvk8G9DVfWDgXcmZzeDMxQ3ycRXDY2AmWXok0SsbYXh5FjfW9ieFxMYF2aoZg9IPRWxw82opI+g0mBYnw59Zr6poVjXTV2+WRfuctKTzLSQWSzX5OK0heorNF2DE1QYSMEkHUtUk/X0W1WM39QU4tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dNOROgwWaKb/XeZ2AEYZ8G4UBcBsUX9iIkwlWX4Xn8=;
 b=dl6y8Q+MXQrl1NCZDo5ySN5BVh47a5t9iR/Tew6sTczWZpvs+Df/a7Qf/kQcCUi5iX8rqBISt84njpVXIhzHrXBzguOsPKhdclAMnWkx/xu/NTajREn2K9nGVVEkQBFYujPdunzRNb6u/fABS1M71rz3795zKUfn2Fmze+RX9NI=
Received: from DS7PR03CA0115.namprd03.prod.outlook.com (2603:10b6:5:3b7::30)
 by MWHPR0201MB3433.namprd02.prod.outlook.com (2603:10b6:301:7c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 10:55:37 +0000
Received: from DM3NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::49) by DS7PR03CA0115.outlook.office365.com
 (2603:10b6:5:3b7::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Wed, 6 Apr 2022 10:55:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT019.mail.protection.outlook.com (10.13.4.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.21 via Frontend Transport; Wed, 6 Apr 2022 10:55:36 +0000
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
        id 1nc3K1-0007fI-Gp; Wed, 06 Apr 2022 03:55:33 -0700
From:   Ronak Jain <ronak.jain@xilinx.com>
To:     <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <corbet@lwn.net>,
        <linux-arm-kernel@lists.infradead.org>, <arnd@arndb.de>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>, <radheys@xilinx.com>,
        Ronak Jain <ronak.jain@xilinx.com>
Subject: [PATCH 2/4] firmware: xilinx: add new function for do_feature_check_call
Date:   Wed, 6 Apr 2022 03:55:24 -0700
Message-ID: <1649242526-17493-3-git-send-email-ronak.jain@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649242526-17493-1-git-send-email-ronak.jain@xilinx.com>
References: <1649242526-17493-1-git-send-email-ronak.jain@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38675bc7-1d08-42f7-8d1a-08da17bbfb4c
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3433:EE_
X-Microsoft-Antispam-PRVS: <MWHPR0201MB34339F33F60A0E1C1481DC20A4E79@MWHPR0201MB3433.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LZt6WI1FpqCuz2VWNtX2JXS8we1BQP6RJJrBwUMlsKT0fmI51if0oYyFcWzWZ1e2lNYDBFxf/wY1LgjhFaZ2JbkRjCKk8HTCkY9LoTcqU4LKZD8xWe0C/AbiEJKrtXY2jBJuayimZdqoVSYFTmgPwRU2P3GC/asl13f/yUl2vwuGXCxYYtw/wUIocCdXla6jJiSXRd96GN0RycWpl2TGSl33xWlHiGDkFK/n5x8qD44DDl1/jltICWgDdFkjhlgYFzM7z2oi0pbfOg9QmbPHonNqCDkUc8u0x4I034WKU44I0Z01jSsQ7k3knzymL+n0T8MF0oZTPlGQEToYGpkYydKwMGswVwgubVT7zS8vnVfoERWjHRamj4xg/bRc/8AuRy9WDOTiuOhtC8XbdDTczlpLwFE7/WiNPbKamWqPSiQUrzUqbXteLM6ZpyMutI3VxM/RpI1EDPfAJNstyxKVjTcnJoYa5Qnkip6wkS55IehbSdjZKbLTmIxjbqY+yLeLjSCu5s5drPIYznj/lToRvqGvoSyxPfIWKrBrvp4SjCyWXxNOc6FqML7mJKOZcWafoZdMgFB8JJSOeKRVoX6+cgLlrxVIkAjdh9DSmsJzp2klDVkb4ZwSYM3U1RKg469UlPlhWCqnFG5Ir07Vjjh/bnIuUcECH2unJPN9ktZiO+DXkkIHQK12jNK5b72yh1ymQqkR5/52tF/V+4Qsj80LvA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(5660300002)(36756003)(110136005)(7696005)(9786002)(6666004)(47076005)(4326008)(44832011)(54906003)(83380400001)(40460700003)(2906002)(8936002)(26005)(186003)(7636003)(508600001)(426003)(2616005)(336012)(82310400005)(316002)(36860700001)(356005)(8676002)(70206006)(70586007)(107886003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 10:55:36.7830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38675bc7-1d08-42f7-8d1a-08da17bbfb4c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT019.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3433
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new function for sending feature check request to firmware and
call it from zynqmp_pm_feature().

Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 41ca41697790..d27a3b20227b 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -175,6 +175,23 @@ static noinline int do_fw_call_hvc(u64 arg0, u64 arg1, u64 arg2,
 	return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
 }
 
+static int do_feature_check_call(const u32 api_id, u32 *ret_payload)
+{
+	int ret;
+	u64 smc_arg[2];
+
+	smc_arg[0] = PM_SIP_SVC | PM_FEATURE_CHECK;
+	smc_arg[1] = api_id;
+
+	ret = do_fw_call(smc_arg[0], smc_arg[1], 0, ret_payload);
+	if (ret)
+		ret = -EOPNOTSUPP;
+	else
+		ret = ret_payload[1];
+
+	return ret;
+}
+
 /**
  * zynqmp_pm_feature() - Check whether given feature is supported or not and
  *			 store supported IOCTL/QUERY ID mask
@@ -186,7 +203,6 @@ int zynqmp_pm_feature(const u32 api_id)
 {
 	int ret;
 	u32 ret_payload[PAYLOAD_ARG_CNT];
-	u64 smc_arg[2];
 	struct pm_api_feature_data *feature_data;
 
 	if (!feature_check_enabled)
@@ -205,14 +221,7 @@ int zynqmp_pm_feature(const u32 api_id)
 		return -ENOMEM;
 
 	feature_data->pm_api_id = api_id;
-	smc_arg[0] = PM_SIP_SVC | PM_FEATURE_CHECK;
-	smc_arg[1] = api_id;
-
-	ret = do_fw_call(smc_arg[0], smc_arg[1], 0, ret_payload);
-	if (ret)
-		ret = -EOPNOTSUPP;
-	else
-		ret = ret_payload[1];
+	ret = do_feature_check_call(api_id, ret_payload);
 
 	feature_data->feature_status = ret;
 	hash_add(pm_api_features_map, &feature_data->hentry, api_id);
-- 
2.7.4

