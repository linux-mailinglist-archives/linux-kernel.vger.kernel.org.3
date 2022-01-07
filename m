Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F4A4874A2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 10:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346416AbiAGJZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 04:25:03 -0500
Received: from mail-mw2nam10on2048.outbound.protection.outlook.com ([40.107.94.48]:7936
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231910AbiAGJZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 04:25:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgnZ8dzVVtza5+bfAvjKllUv+fsVqKwSMH+BIHiWRWGuaPur6dG7LVHvv7dJkfdq5D36hO4ESS4zmpk5KooXCzWNF7IT4OdevdWpO661esUeEuLA4AKCJVVXVJkWwjmmYsG98lcoRvdmBNuJfLkaIgn5bS0/bwmpVINuaBrtwuUDmzvuPeF4pjtqk8w1STyTP4VMWdp466YdcEpKmVhOwzeu1q6/F8I22+B+4Q9Z0s7eW0ihe80VwfuRBHPqL3h6ZlxuT+X+OLkQqCrUeZVaK37JOmlGy2o4Y1VBYFlY9JvcNb3tRNXIULYesBJhc22yhsn/BqIoLsWF/ESmhOxWnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UwuX0j8RvF43HzX3RQep145T5Gk2v03/oeAeWU4T7M=;
 b=IeI1Cy8bu2EiC3aezPp0AvDpqSxEAVtQV53l3tkEaVSZgNcjmQDXjFmXskyoMXhPvXcrGlvImBSiUbbHPjGqrGkz3tcbM4DpXtDmRBbwBXDA0lpmkx+2dZ2euZj0o4QUkQvO6RGNyLjVk7CUs8cLwJ/grFJkj115PCijQ8VW272JGrTIGdAVCttPKELhRxSUSdM6IWx70z0F6rgM5n69RMGYl30GPEHUSq3nywmQuQZiqTel5aNAuIl9MPsfIyDRAdEl+s4jZacPFRsL6a0t5YkrT5JYsrcipKHKQR+jqCBrsBBVtCWilGRt4z1F3l9zfUdnfToaEqAm5MrErRwBMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UwuX0j8RvF43HzX3RQep145T5Gk2v03/oeAeWU4T7M=;
 b=fLPGRIxkTpX+1fRQfKSonjbsyD6YwRWsbL1MGtF+3taOVSyRCa1qo4KHZV63VKVOUzcR/Q9wfWKFSnv7gud7UOoSQXWKl2xG4bGkRaM3q4KnMBt1ei7oi68oInxPxLMV7c6ODzxRrwlcreV7TZolMQlfhsYpygnLiaeaLlCcnoKlv9PJsBQXh/45lyKbRJRnCBX4JQycthSu8RHtLK7gXBA3oSBTXTvh3EFsKW7RSKml5kYhCEnA6wgrSdK5oQMOtDeaZUzf9ER0J0tqZmT/bAvjuFKKGHPVt/TughrHwlvn2o0lSTR9Ry2Oey+m2mIgnB3NF6X5J/Pb6dVkwACzLA==
Received: from BN9PR03CA0970.namprd03.prod.outlook.com (2603:10b6:408:109::15)
 by DM5PR12MB1338.namprd12.prod.outlook.com (2603:10b6:3:71::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 09:25:00 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::12) by BN9PR03CA0970.outlook.office365.com
 (2603:10b6:408:109::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Fri, 7 Jan 2022 09:25:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4867.7 via Frontend Transport; Fri, 7 Jan 2022 09:25:00 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 7 Jan
 2022 09:24:59 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 7 Jan
 2022 09:24:58 +0000
Received: from waynec-Precision-5760.nvidia.com (172.20.187.5) by
 mail.nvidia.com (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.18
 via Frontend Transport; Fri, 7 Jan 2022 09:24:57 +0000
From:   Wayne Chang <waynec@nvidia.com>
To:     <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <singhanc@nvidia.com>, <waynec@nvidia.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] ucsi_ccg: Check DEV_INT bit only when starting CCG4
Date:   Fri, 7 Jan 2022 17:24:55 +0800
Message-ID: <20220107092455.150504-1-waynec@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0087f02d-4cba-44e3-787f-08d9d1bf940a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1338:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1338C9F10A182FD335ECBFD9AF4D9@DM5PR12MB1338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aBLc92NP3CauRAz7xcp146N47VGRbh2TbszvJeZHClOwxGTHyJ84fhvGqxmn0KR9cYya+uCaU89hcs4eYK2UGCxhbOIsJVjAyF86YWCRlgRnung994zPJ3dKVdAEaGocjsxmn54KrKGoEGhTTk3xGYTQXV8ExaZFz+GEcZJtwoWJhTTeVE5yWYVSq1I/LzKK6FFKaTAMl+0ImGcct4HIzP2dLVd/r0SHknVshQNj3u2y2kO/EXhdTIScFhcny/35CiVckgRseuEAEXdn9mZ6HtLYdbPBT8InjRFDo8RnS+h19KX3zGQvplyOXrOdkp1H9TD14UNU+qeq4cqXLjwSVaHpR8UdlSMcxL2qC1alhrTp7uC6ksXmwcG4xFtul5V9S9BZzgjxbRQGjY5OHHBMjOCfY+IG4qtrXaYv5pm31UBU3YiQ6W8HBS7rRlW/RgmFd0X9xU0S3j88VJIrMx9LAvEJYDbeygxXX62SZHUUOyMDNGBNxVwY+S96p0xH64cN6OZ2JFpJxfpkoRuu/1IScRqMTSO7O5yg2B4eqciXwVZjbVaDq50Wgqn9q+Y1lhTCBnDy5pJX/Q1D+wO9rhXo9Ts21fpPNoMmvBKDC9tHSUBVSe3eoqjO3G9+h1wIncInp7l0tDycuyYFFGwTNeN0TwAgvUtuf+1ZBw7k7fBUjsJUEOhbnmP7wtBWniXNecHm5NvZdGNeptta2MDAkKQNPwaxRX8/kd3Teq7j8HGlvQg0nEzb+iG33vKZs2hBZqiK9Qhjv3vHNTbZaTwGJLwIpQBXSEK2K4NkR2yMgceAChw=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(40470700002)(46966006)(83380400001)(36756003)(54906003)(82310400004)(110136005)(336012)(81166007)(47076005)(508600001)(36860700001)(26005)(40460700001)(5660300002)(186003)(2616005)(356005)(1076003)(4326008)(426003)(2906002)(8676002)(86362001)(7696005)(70206006)(70586007)(316002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 09:25:00.0590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0087f02d-4cba-44e3-787f-08d9d1bf940a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1338
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sing-Han Chen <singhanc@nvidia.com>

after driver sending the UCSI_START cmd, CCGx would
clear Bit 0:Device Interrupt in the INTR_REG if CCGX
reset successfully.

however, there might be a chance that other bits in
INTR_REG are not cleared due to internal data queued
in PPM and cause the driver thinks CCGx reset failed.

the commit checks bit 0 in INTR_REG and ignore other
bits. ucsi driver would reset PPM later.

Signed-off-by: Sing-Han Chen <singhanc@nvidia.com>
Signed-off-by: WayneChang <waynec@nvidia.com>
---
 drivers/usb/typec/ucsi/ucsi_ccg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index bff96d64dddf..6db7c8ddd51c 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -325,7 +325,7 @@ static int ucsi_ccg_init(struct ucsi_ccg *uc)
 		if (status < 0)
 			return status;
 
-		if (!data)
+		if (!(data & DEV_INT))
 			return 0;
 
 		status = ccg_write(uc, CCGX_RAB_INTR_REG, &data, sizeof(data));
-- 
2.25.1

