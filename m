Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB1F48AE87
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240608AbiAKNgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:36:53 -0500
Received: from mail-dm6nam10on2064.outbound.protection.outlook.com ([40.107.93.64]:44577
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240582AbiAKNgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:36:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQiFIOhCylL6/QnAj2dQF1LF6UxfJtw+IeCx2sJlSMyvEL3Qr6zyfldbdjibsAF+Yf8ozsGRUm+5OB5tStt9ftpiw+Ga+qsJ24rzelgN0EZ/nhc0JmfUXTdIjfDh0EKUZnxxsFtEDGlqXTk/0F1P5VTz/m09Mmc57Y59g+qToeAe8pZoHhmzaF9NZXKEEyVdu3wdqKrne6jd+5fJxGksPoKs96kiGT0o7qe7Wt+QmvdebJnIQ1kk5oagomUCsjbR4/giCnqKDqkaQbStvJvdIN5FHJoK8hciCR3QjBy6HzJvJmsPvLGOSTCbzJAclnD1eIHv34Vc8v9cFRKHNJHUww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TEiQ1J5Bv18CtQ7ySEeocw87rz2RMAdfeG4X1YdisQ=;
 b=Ujks3F2WlKZLy9FDkb3wHMiXzR++uqTZXMQCpvim9+xtUN9LQy33uXsfuzzKj8WCLSklivomO07aexmn2WBzVz59+4N8EforC3Y5ii4/koTQwJWa/vDF8Nq49KFYAi63k4dXjhCo4yjP/OBPl4iP3m3+F+mIbbOWYHllbyYUAGv7xJjTQUHdNqoUgIPq9xa5qXja28cirHKAn/htkfYFbcyVXlb0UltOH9zOlN1DTck94wiyuU+VjC09KayCK2RNnTBwv+90KQ1wNRxN6P29yDqPHcWgnaXY2XAr1JkJfTXgnc6boxdskwnBVLKVPSpBLWFk48beOFuOzelGduIL3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TEiQ1J5Bv18CtQ7ySEeocw87rz2RMAdfeG4X1YdisQ=;
 b=djUk2ol2eeysF6uSfAuKKsYVSbdyU24ZVePietM3oq3euIvkVUvTLKgvloB1nAX2OGSQLeYwBJijr3Uxi3pp/W7gObu1Phnz/02psWeFguW8s4jNzf6EffzAsD4I0DsVCXvH0es2T+mLSvorc/fhBmwUh9tAE71LHp/G6wdo6T6bFcjR93Tw0F7TeM+ZX4UWXvKMij8jRhXbrlwcjxPPDEM02FPkAvzdUOgGF+cuYp2MykMTVKpPM2O6n3+bdPKIa8mFzTGB0kffs3WgTNrXzqgXTvv5ViLn3YfYdtVW/VrsKkOr/qY0CqJLg4ie3g0jsraN2u1JSlkFxq+DEmaCyg==
Received: from MWHPR04CA0042.namprd04.prod.outlook.com (2603:10b6:300:ee::28)
 by MWHPR12MB1486.namprd12.prod.outlook.com (2603:10b6:301:10::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 13:36:47 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ee:cafe::57) by MWHPR04CA0042.outlook.office365.com
 (2603:10b6:300:ee::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Tue, 11 Jan 2022 13:36:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4867.7 via Frontend Transport; Tue, 11 Jan 2022 13:36:47 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 11 Jan
 2022 13:36:47 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 11 Jan
 2022 13:36:46 +0000
Received: from waynec-Precision-5760.nvidia.com (10.127.8.13) by
 mail.nvidia.com (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18
 via Frontend Transport; Tue, 11 Jan 2022 05:36:45 -0800
From:   Wayne Chang <waynec@nvidia.com>
To:     <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <singhanc@nvidia.com>, <waynec@nvidia.com>
Subject: [PATCH v2 1/1] ucsi_ccg: Check DEV_INT bit only when starting CCG4
Date:   Tue, 11 Jan 2022 21:36:43 +0800
Message-ID: <20220111133643.589346-1-waynec@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44206838-589a-45dc-fe1c-08d9d5076a66
X-MS-TrafficTypeDiagnostic: MWHPR12MB1486:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1486843C864AF66E685B7D6BAF519@MWHPR12MB1486.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xBMeHpbsXRbIrUuuYKq0/wtjUacE1Rn8r3lLNDpyjJSnKSYLQyl3tijqfV7kZWEoOrYz2i+95aySK8yROYoQrzGJ5EMVEP83sLVHwNa69p1h0NBtHMzyB28BDriPQ7PmEey09UehNU6QmJ4tB1Sv/OBvfO5txdlzuk5+prsWG5tp23UMyHhIcilo0UWbdrVH2Igy8OmhDalLigbr98dtejzqQkRHa0j+1gJ5hqPFLGgNthLnZOjc6W8jNKlBZdRaCgwVhVIdjT/1WI3LuNTdTEDMhtfq2KxIf1PI43uH4lPbWurgFr1+iFkIrzX5riDNqNg1eTINAdcdFZ6ovHqjmJqvTepA6PH3U/pgw+NU8X6RcTL3VmJPuGL7kbfImw6Pn38cTMqxrTqRYybthLQyejBpm9z+qzRMELnYu1rqyKAc5tsavxAvGv59mwy1iCFcxQZtRDpZ/3hAvU5MRuJyqo9Ve+ahASJE6jEnVNu9IntFKED+ttjR3GQSX7d5rdmTVvZ9x1hotN0pUvwTT9eHZuTo6/IFyvHrSM0wFRqrcSIIrN7cxNCcC7n3IMCzOdrbb+P8pGMKn755C3Ct4yEoRYjkjIjyLNHJXlVEfo5wooSdSvuCDP9hhs8aCJ/tpaM6wmtBZDF700Lke/fZq1Wb5FeUdKqe0f8OnklVOtatsXSR9Ne5xKnc2AQusCvpBwAfNqkgOy8p8S4ujaMA0ge2soBU1BZ5nIlK00oOlcWtNEZFflLX4+XflHBaVgG51gKSdQB4kBxsZdjsR7AXNKZqkgNw0FVLKgyq9yzcDOZfCMk=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(40470700002)(36840700001)(70206006)(70586007)(5660300002)(426003)(107886003)(83380400001)(7696005)(508600001)(2616005)(4326008)(81166007)(1076003)(336012)(356005)(40460700001)(2906002)(8936002)(8676002)(316002)(36860700001)(82310400004)(36756003)(86362001)(26005)(47076005)(186003)(110136005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 13:36:47.5164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44206838-589a-45dc-fe1c-08d9d5076a66
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1486
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
Signed-off-by: Wayne Chang <waynec@nvidia.com>
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

