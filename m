Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F93E4A67EA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 23:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbiBAWXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 17:23:46 -0500
Received: from mail-bn7nam10on2082.outbound.protection.outlook.com ([40.107.92.82]:30177
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239707AbiBAWWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 17:22:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ybu7vn5BeVnHdlCIFWfOt673gXEdfYvQMlHhGBXuCLFeG4VQhjCU5S1fyfJz4F1AYFXAHDLLWg8toRrnPyzwP/pU/1zlMlD/hZsCz/I33VfcHxXh1ONorEJA4VDs30IQcUA50RbdLS5SoMmH9wrvQG0IpT9VVZUzkjdPjdQR1ormfsY1yXLgjxspZpoDHUzK2YPWHCCR6umbo2ZLeDF5goimN+gGcxbZYNcxmuyEMP0KuDd2kDpGB2poQN3RoGpu1vMue561dl3gOOnncl7oOy/OHIfeJDO73bHQK4aNpwjxAwHuPsr49Lomd8tQC8efdOJH+aUNLZcgbRnispji6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arfCdPsLWsD+Wp0ypNL/XEOk0UeOVvq0Xn2HLNzr7i0=;
 b=LwF0jDt2StVFTG1sfbb9oLRTX+4Ii1d5hvm93ysn/QI41dAEwDOsFNw96BrGepB3xSSn+bPEww5AuKA4XfXrqqNdsraum8NFMkPO70qTkIHAXOd/Ka2vC0wGcW0Awgf4itQysu04HZ76JJZJ6cFFJH4Ozz6Rnp7xUqRsY2Wvds5WeS8/Af5Wt7iJ2KC9z0RGK4XTQy2I3Wog7tDDn+8lPn69PUCz5ejic1gKrjvXqozx4Nzd0VIK9kEP3lBUzAj7GQgS27V7f5FnOf1GppXj+obz7bbUADMGY4XQ66aFFYSu1Y1s0a5WXtZozHFAFzDSloA7e7TrkTPxPJYlYG9zGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arfCdPsLWsD+Wp0ypNL/XEOk0UeOVvq0Xn2HLNzr7i0=;
 b=dvnfUL6CoDGtRCqWRCbUZi134NE0xa2cAcFJ2ou+6TuZYFhA+TRPDhK6zl8zihCdHTlKcTOBvqFrY55xBl/a/RrVmKdS2PdMyaR/qteAE0jumGjom4xeu94wMQBtKs2AmfAGzBJjz0Awp0StVQ8H6vUKPBp7TqKYmDvquWAVVuMVomaQI+ZtA21+hw/CAvWaNsM3IovbJXu8P+gyyBH2skp3xiXHOUKPosbrIoL+oOee1wkSwcaY+yalvqUshLaOZFTWDv2DPSoVqUVp6Ff9gZa+AnWPLlZgtMdXAjT2DGDSs28mUGIDuVMLS5n0fpOx+bmGoBf7AGiBU7NALTAtig==
Received: from DM5PR2001CA0018.namprd20.prod.outlook.com (2603:10b6:4:16::28)
 by SJ0PR12MB5634.namprd12.prod.outlook.com (2603:10b6:a03:429::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 1 Feb
 2022 22:22:35 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::67) by DM5PR2001CA0018.outlook.office365.com
 (2603:10b6:4:16::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22 via Frontend
 Transport; Tue, 1 Feb 2022 22:22:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Tue, 1 Feb 2022 22:22:35 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 1 Feb
 2022 22:22:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 1 Feb 2022
 14:22:33 -0800
Received: from dipenp.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 1 Feb 2022 14:22:33 -0800
From:   Dipen Patel <dipenp@nvidia.com>
To:     <smangipudi@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH v4 09/11] tools: gpio: Add new hardware clock type
Date:   Tue, 1 Feb 2022 14:26:28 -0800
Message-ID: <20220201222630.21246-10-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220201222630.21246-1-dipenp@nvidia.com>
References: <20220201222630.21246-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e71aaf5f-e1ed-4c07-35b0-08d9e5d1590b
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5634:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5634906D2D187E77006289F6AE269@SJ0PR12MB5634.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cbdRppQLfTgB5TshDMVj5I6Wk+46rrOAqOg3E2+KCFd3Lm7ITuI/g5PjV2Gn2WC8xNrt+T5sRGwszdE1GT70IFr3dlYwuOayjPBLXlG9C2WvzAF8mF53JV4aupAfvsQfNRhFjWOWR06OiMX4pxgY4rgIflJxGyKfPxJbjP6p9uUjmiSy5YjLHS1GE3lEqTWd6bUwMb67vUef7xNDjm3M3D7Oark1Uq1R4ACaIXwu7528uJHqVIMUZW574BHZtzI59ceMsOnDQSym+AU4oNhWYyGfb4LTbzl+VRQFWiLgCTuvw76CTa3Z+dmXfdPLwVtlGnhAuV7QCJGCgCaP6v0QcZWSZDYUwMHZKtsV2Idv7bEtixR36HQvwqD3p5VfMdFPTRnVbN59MRoGvlAjG9U951Y8KnysDIz0VIAoCld/WtR2v2yXap/+EdUWRgocibAyKCIv7yzDl2SNhL9QtJhiY+qzMWWIsy6+2g7iFAMQ0r9Kgt6ebJQ9C2FUhjtASfPbVahm6A7i6f8BBwooEgMHRRMeUg9NNnwcSJJJMSVlC6rWS/H8VIw69lml0itSSmuuUG+hq1UfArt/kdnjJawCPrPDLD+FviX5cO3UK3E4rR7A4wUONbWfNzGAGt1RgFkk4cqTM/71ssC8Ml2VyDVovMUKiAAvINsX7F15gifA64NffOuzm/rbGP6lgzArH3EZGJJXiHQXrymoTBE9xyDt3vc1aZ5iSPD9oKQQ7aFSMdOt6FZV9LF53K0sBkfgXI9DKwPtixZxD/D7b7fBewHFfA==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(47076005)(81166007)(356005)(83380400001)(336012)(186003)(426003)(107886003)(2616005)(40460700003)(921005)(36756003)(5660300002)(7416002)(2906002)(26005)(1076003)(4326008)(70206006)(70586007)(8936002)(508600001)(86362001)(110136005)(7696005)(82310400004)(316002)(8676002)(36860700001)(6666004)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 22:22:35.3218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e71aaf5f-e1ed-4c07-35b0-08d9e5d1590b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5634
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpiolib-cdev is extended to support hardware clock type, this
patch reflects that fact.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 tools/gpio/gpio-event-mon.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/gpio/gpio-event-mon.c b/tools/gpio/gpio-event-mon.c
index a2b233fdb572..6c122952c589 100644
--- a/tools/gpio/gpio-event-mon.c
+++ b/tools/gpio/gpio-event-mon.c
@@ -149,6 +149,7 @@ void print_usage(void)
 		"  -r         Listen for rising edges\n"
 		"  -f         Listen for falling edges\n"
 		"  -w         Report the wall-clock time for events\n"
+		"  -t         Report the hardware timestamp for events\n"
 		"  -b <n>     Debounce the line with period n microseconds\n"
 		" [-c <n>]    Do <n> loops (optional, infinite loop if not stated)\n"
 		"  -?         This helptext\n"
@@ -174,7 +175,7 @@ int main(int argc, char **argv)
 
 	memset(&config, 0, sizeof(config));
 	config.flags = GPIO_V2_LINE_FLAG_INPUT;
-	while ((c = getopt(argc, argv, "c:n:o:b:dsrfw?")) != -1) {
+	while ((c = getopt(argc, argv, "c:n:o:b:dsrfwt?")) != -1) {
 		switch (c) {
 		case 'c':
 			loops = strtoul(optarg, NULL, 10);
@@ -208,6 +209,9 @@ int main(int argc, char **argv)
 		case 'w':
 			config.flags |= GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME;
 			break;
+		case 't':
+			config.flags |= GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE;
+			break;
 		case '?':
 			print_usage();
 			return -1;
-- 
2.17.1

