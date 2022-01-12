Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38BD48BD9E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 04:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349175AbiALDVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 22:21:17 -0500
Received: from mail-dm6nam12on2046.outbound.protection.outlook.com ([40.107.243.46]:46653
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348321AbiALDVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 22:21:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwXRGhWX0k1ckmB6/9MrqnUCahvsvXRtgtBRbmgMQOAGEgJkCzgrCGxKlh+raUZWL5rHbOPUmrKOwayheZUQaQPAfaUHIjfuJTt6lUZkDfqfZRBfNp47JGHY1EU4STG8fmUJVCGCw8Xizmjui247xbVJWhAwMUOggwtmICMUVS2b8DkxatTmYypkjTVPvr0L2Nr7I/F99E4RChXDMDHSpKM7Z0kt0OtlJYi3zxC8WTstuiDqqF73D34j+KcujioaMlRNDiNfl2pQzUL1/MSYH5buefnXUmVzpVJS1CqS+eXU7Okfy39S0yREcNHDeB+Tqj1KDvlQHGP1wyXU+KVqfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeCBl07NE4L2YwHYzPiE4DJyexpLUeV8M+WBF//R5p4=;
 b=fEFWjB5fFGzJEJDQls4SATEHXdYqsfxFsreedKYnWjXxslRAbx2MajutBXTrnXTe87qFSGVRUqvNgG5O2ya9zGYLqvvX49gGEpQGRlkzY31Jeu5MVueS7abQzEbdL5SvwwhLXoes0L0iqvlxsWTZAXDADQFqUIG7eu2qY2HrT0lJ4uonQaTmr0S7iVhc0QA4bvm8yjjtRPKitfd4r+q6tT3NwdynXr0q7rU3GgB8IyCyPZPPBW5omqdlJBBa2SbSuLY7JW88bEo9r7OWYDLdQ/q19N4X4jgP1DVk13Ho6SzrqoUwogAipFuIF4HSCod9wDaxX2nbXFsIOI2MzBdSGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeCBl07NE4L2YwHYzPiE4DJyexpLUeV8M+WBF//R5p4=;
 b=g/niX0GgMlslUntwo/Q3814rKPdK27VppMSA65tI6y5hShirXC04w4k5qeUPTuWxjOwD34OBF+lyC4bSG+RC3QlASd9wSIi5NLR7LxtqojRRbmjYqTFIx4AfvwPlnL5eXSqsYmQs3KDWaaUfmerM8MTk76fHfTsyeJRE32p5kqwDuEVyKk/TbeCKST9P062+3KNy6/u+rk4IK4VCVFFxdQ9sOLRaEzZoxOQv4nglXb+ugi9yGuyq5pCrMDa9qZcPQAZZGSaBCZIy8x/IpEnQRflFIEqBuYE4+79Omgwz4orE6j9zw3zZVuDSBcY+AXgpgCUCIWrXZHBdksYCAJYCVQ==
Received: from DM5PR13CA0023.namprd13.prod.outlook.com (2603:10b6:3:23::33) by
 DM5PR12MB1500.namprd12.prod.outlook.com (2603:10b6:4:11::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Wed, 12 Jan 2022 03:21:10 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::bc) by DM5PR13CA0023.outlook.office365.com
 (2603:10b6:3:23::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.4 via Frontend
 Transport; Wed, 12 Jan 2022 03:21:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4867.7 via Frontend Transport; Wed, 12 Jan 2022 03:21:10 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 12 Jan
 2022 03:21:04 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 12 Jan
 2022 03:21:04 +0000
Received: from waynec-Precision-5760.nvidia.com (10.127.8.13) by
 mail.nvidia.com (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18
 via Frontend Transport; Wed, 12 Jan 2022 03:21:03 +0000
From:   Wayne Chang <waynec@nvidia.com>
To:     <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <singhanc@nvidia.com>, <waynec@nvidia.com>
Subject: [PATCH v3 1/1] ucsi_ccg: Check DEV_INT bit only when starting CCG4
Date:   Wed, 12 Jan 2022 11:21:00 +0800
Message-ID: <20220112032100.610146-1-waynec@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb762c27-f6a9-4aa0-6255-08d9d57a94b0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1500:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB150030626A89968018AF7A3FAF529@DM5PR12MB1500.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V0GvoyPZmgjbFpec8gQAKKg/jx1fUzsoeUaFhPv452k3Ny1r4lnwJbUfs6wsRQOj8IqPi75SccPc9zgisvCMEVqYbgRUBIiaxEbDASqiX27Rftigps2KFh32zMdMa4wF5w156tAbh9LDk7St++haGOAIq3+swGkkA+rrJpF0ySYfpQqUq/0LOue0cGGab2QBqylrNnKkv07tCZAIoZktddhKqWN2xgmx9dABPMEtz7mYdJm8I5+m/1GoH0M+yyaEmnKWI7uJ94zm6iZ1yhUpsREB6/Ms5O+kSj+1drZJoa2+t5PNjIP0ImHXFbOqla2uvetd559cnTG//LHI/QTRoWK9oZQsYr4IiJq/8eOyPrkBPYvOcW3Ekyq0TVar++X1wI3GtQdd09QBc6IidAwPiECDDGteDoVnl761Y/YTL7Knv0nSfbGtBMDvz2SCGBr6wI4v1/qf3J2+T/eOXUwr4Zs1SNAIu7RNankX9CjAE/85/m2mEJI+KA1JUTUd910hHtXdsBaxbvT/oEvtrOfb6oiP/++/Jhvq6W0VDU76XqlC3q1aDwcDO/a7mialFzn0VnnkqpOkzLYj3U2w8SR79+YmM1iSNKtt12S99H+tqD2lVgjl/0iOz4X6MzXALqzxZ8AMhrIjKRxgNPp6V0Ww925xRYb1Cu+ba5TlnvOAE1u6boQdKls+ZUliezOHzwFwWMMkILaguMznyft/LfAj2uBBa7G5L2zYwq8DpmqBd9byi6d+1fG9Gko5NBxNfLhNAT7keiJjUapr8QzdwIdcYswoHMqITUy2Dl779Fm3n1E=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(40470700002)(46966006)(36840700001)(54906003)(316002)(8676002)(110136005)(36756003)(82310400004)(40460700001)(2906002)(2616005)(4326008)(8936002)(356005)(508600001)(83380400001)(107886003)(426003)(81166007)(70586007)(47076005)(5660300002)(26005)(70206006)(36860700001)(186003)(1076003)(336012)(86362001)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 03:21:10.5387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb762c27-f6a9-4aa0-6255-08d9d57a94b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1500
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

Fixes: 247c554a14aa16ca ("usb: typec: ucsi: add support for Cypress CCGx")
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

