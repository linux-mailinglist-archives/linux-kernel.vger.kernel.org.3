Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14A14A851F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 14:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350796AbiBCNYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 08:24:49 -0500
Received: from mail-mw2nam12on2046.outbound.protection.outlook.com ([40.107.244.46]:52576
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235110AbiBCNYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:24:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGb9f8r1PPTvyXprBiNx4JwlizA5s7O6MPGiEHA7NB0OHeEZxZ4mIAhsBtNIL3Fs/MQQT8g2Ovkzk4unazZyLuuVx5qp+oWFtw3yUljtMXTaVgyXK/Ain5sylVNI5C+UcjQ9vOXcV8jxfBaO/6kTlJo0VYRjnmz1FRGfWsMA630IOTARr/09MuGXe6Ii3TNnKhKV3LwgQwG6b6V9xlkFaoIytH5hDeK22MlGTcGTRb8rE6ocO8oc2bT0HZ8Bu0wNEvs1xv7qu7Vqy/uvQhgBX10wDFbLPyj2apePHjzFaiDowA3fWInx6ay0DPgqb6QHNQLsERzSM69y/vW9arFkJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hh/Bl6mv7SPKvuzzxd+jIVrnqsyQBo3bwkcYhte1I7c=;
 b=e65oHU3CIlYQWn4N/8trF6QDC16F0RJ8cQHP52fze8N0GeoeMqBAFK2YzJwxAs7dr2AAkAzZWgzuOzc3BWmI2KOp3VxvqF/9SYPBKzbh0MnxEEBs4uNP6PJJtRKf+xp6SEVkuJRv7NdwLkUahQzAm4XR5XTvj1qejo1XaWhvEaGi5yQBGTGwuT/y0IFjTTmZGjewo8ryUJNrVw3Do2vWbnOG+gSM+FA2tiqhgPLc6J+x/heimheBUV4SqRuyX+7P1Rp35oXjhuMfQMcO5b1mAh3Bb8Cf7uRknpPJYh5+RcmgI7vKJ7v2r8DwgOTkWvKt1feWTvREqbrCiaiBUOzlbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=bootlin.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hh/Bl6mv7SPKvuzzxd+jIVrnqsyQBo3bwkcYhte1I7c=;
 b=alzM+L2Ok6i9+8Ttmg0j8AfEcT28CLnX7JEGMqqpmSRTQb6JxBx8zlN75dwN6K7t8I97r77ea3mHWokBrwL0vO/Kh3DA83GbePRdsoRRKkzGlHAWC+ANEM6TlulUmezUihYMaQuRlRRLHbGK09D+u5tL254OCNsJdxDrvyG9BqQ=
Received: from DS7PR03CA0133.namprd03.prod.outlook.com (2603:10b6:5:3b4::18)
 by BL3PR02MB8050.namprd02.prod.outlook.com (2603:10b6:208:359::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 13:24:45 +0000
Received: from DM3NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::ca) by DS7PR03CA0133.outlook.office365.com
 (2603:10b6:5:3b4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Thu, 3 Feb 2022 13:24:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT008.mail.protection.outlook.com (10.13.5.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 13:24:45 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 3 Feb 2022 05:24:43 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 3 Feb 2022 05:24:43 -0800
Envelope-to: git@xilinx.com,
 miquel.raynal@bootlin.com,
 richard@nod.at,
 vigneshr@ti.com,
 linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.18] (port=53850 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1nFc6M-0007ZG-P6; Thu, 03 Feb 2022 05:24:43 -0800
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [RFC PATCH] mtd: tests: Fix eraseblock read speed miscalculation for lower partition sizes
Date:   Thu, 3 Feb 2022 18:54:34 +0530
Message-ID: <20220203132434.25769-1-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f096885-3f95-4ed8-fb73-08d9e7188b48
X-MS-TrafficTypeDiagnostic: BL3PR02MB8050:EE_
X-Microsoft-Antispam-PRVS: <BL3PR02MB805015ED1478A35B50BBB78EBA289@BL3PR02MB8050.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XP/N0vE+AsPTAg9JetRejWB4iL8zR6Z60NzGQtNI2aaaJqJxb8o2ptqTI8oljIkgy4uMV4OBX0sPpYvlq9NI0+mRJINzfp2s0+jWJXYoyiA9bT21WtDz7r2w2OIuOGWd1zg9EEvofCXfGHx854rqG4eanp2qiyz5E5CICQBa+o8LXNO3CX3aE8F+LwJziybL4LXM2iJKIWqGwCW9UHCN2g4MqDxS3ep7hBdObE1xgZaaTBhWCyEgZQXT/na6LDUopN9LVEFALSvdMFq1gXm3ICADB9O8yjxVMh2agpC8F4f55AzcmMHRci6bGnK0q1QYcwnBLetyDTrj5IiJD5Fu+tb4xjuNnLLti2/3WKmLpscFuBlKTz28QqLxKv2PqEbWqNKJ/IoXYWw484zoesyium8ZrH+bgkAK/JYZfxuo07DknXh1zTw0Pc1WGltMido5FCZNYaAJ/nE1ShPaN5JkJc6Lab2Wk/d1uIAZp9vf14bilgkFeTSIR2P7fxVbm1szdIyGuqaJP3qe1zjfpoqGjQ+k8WfpYU4/5FDhXmT7rFYK1DccT/oVfWEnfd4xyDCQ5av9ZjpbpTNkNptyTrrFs/iMnWcQjIVSrJxL0ufWKNpnD8vLL8lArINkUbnOOLMmChMKfm8SZeYe7vzJCMLCHxgOzzv53RLJnvaW77ONnr0DIeMBr6a1YUtCrJg/YvQ1oHpoicLW73W10XRaXfCGOg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(82310400004)(8676002)(7696005)(316002)(6666004)(54906003)(110136005)(5660300002)(508600001)(7636003)(356005)(9786002)(4326008)(8936002)(70586007)(70206006)(336012)(426003)(83380400001)(40460700003)(36756003)(47076005)(36860700001)(1076003)(186003)(26005)(2906002)(2616005)(107886003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 13:24:45.0745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f096885-3f95-4ed8-fb73-08d9e7188b48
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT008.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While calculating speed during  mtd_speedtest, the time interval
(i.e., start - finish) is rounded off to the nearest milliseconds by
ignoring the fractional part. This leads to miscalculation of speed.
The miscalculation is more visible while running speed test on small
partition sizes(i.e., when partition size is equal to eraseblock size or
twice the eraseblock size) at higher spi frequencies.

For e.g., while calculating eraseblock read speed for a mtd partition with
size equal to the eraseblock size(i.e., 64KiB) the eraseblock read time
interval comes out to be 966490 nanosecond. This is then converted to
millisecond(i.e., 0.966 msec.). The integer part (i.e., 0 msec) of the
value is considered and the fractional part (i.e., 0.966) is ignored,for
calculating the eraseblock read speed. So the reported eraseblock read
speed is 0 KiB/s, which is incorrect.

There are two approaches to fix this issue.

First approach will be to keep the time interval in millisecond. and round
up the integer value, with this approach the 0.966msec time interval in the
above example will be rounded up to 1msec and this value is used for
calculating the speed. Downside of this approach is that the reported speed
is still not accurate.

Second approach will be to convert the time interval to microseconds
instead of milliseconds, with this approach the 966490 nanosecond time
interval in the above example will be converted t0 966.490usec and this
value is used for calculating the speed. As compared to the current
implementation and the suggested First approach, this approach will report
a more accurate speed. Downside of this approach is that, in future if the
mtd size is too large then the u64 variable, that holds the number of
bytes, might overflow.

In this patch we have gone with the second approach as this reports a more
accurate speed. With this approach the eraseblock read speed in the above
example comes out to be 132505 KiB/s when the spi clock is configured at
150Mhz.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
BRANCH: mtd/next
---
 drivers/mtd/tests/speedtest.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/tests/speedtest.c b/drivers/mtd/tests/speedtest.c
index 93e76648f676..2b76e7750c68 100644
--- a/drivers/mtd/tests/speedtest.c
+++ b/drivers/mtd/tests/speedtest.c
@@ -161,13 +161,13 @@ static inline void stop_timing(void)
 static long calc_speed(void)
 {
 	uint64_t k;
-	long ms;
+	long us;
 
-	ms = ktime_ms_delta(finish, start);
-	if (ms == 0)
+	us = ktime_us_delta(finish, start);
+	if (us == 0)
 		return 0;
-	k = (uint64_t)goodebcnt * (mtd->erasesize / 1024) * 1000;
-	do_div(k, ms);
+	k = (uint64_t)goodebcnt * (mtd->erasesize / 1024) * 1000000;
+	do_div(k, us);
 	return k;
 }
 
-- 
2.17.1

