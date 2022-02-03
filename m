Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED894A851D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 14:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350772AbiBCNVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 08:21:33 -0500
Received: from mail-bn7nam10on2047.outbound.protection.outlook.com ([40.107.92.47]:45857
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344590AbiBCNVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:21:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHjh2CQGvC6EbpywAa4sUSg8tuPYFvsjytUngW9RDp6XPbSsHDPMjw6U9s934k/fEgiAnumuh4LGGOPzdxMffcY2hA7pt6M8bwgHaQj0iBA/H8dBhvAzPG/5xoylLYvL8n0AL4o6KpoIE9wQiaQATInvhCOK6c6b2YCh0uZaXe7ikrOMOalOAweXJglJ7JWTsMAsowBpovoaM/BUPsgL2b4TE6O+lP1Cd05iXiedsALRZ6A6EWdWYVNgfuTOIiBEPhFICOgkl398qXYHdLyrtD2pPe4stLMp1fASlO7wkEzB6hzlAQkSHKWljzAvtw6Iopztj/In1Kvtlv6Xop7ZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUInhKcED0K1hqwNBeq8MsvASFjArpcbrnoYbYtvtpU=;
 b=WZrE6uILPhTmw+abqmQe/AInBgY9Yxb4KIio8CzNupA3bKLna4zi1JfgqnsPD88ZZLj0oXuB8IUTZdI4hZQU0qM2CSkNMkwIgpKE6ZroWIVq8TpLIiJtcKSbrMmp1sF6dO73p86qhkN29gJGHGebMihWw0a1DALj3r314d0DNvDCK9XafX/4d/yQKhGb4o0ENqSl5XFJAiyvv35dy0Gf4XqRjYN1t1sEbkTPV5zXe0l3Q4lN3u7V4gEGT+ZtwAyTFM5senqontVNsoADr/ET4xrT1c0svJb9/Qk0gkPpQfikY4YNI97Oie8XsSY2nuSn7wXZEt1ZtMe05qjllmnHrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=bootlin.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUInhKcED0K1hqwNBeq8MsvASFjArpcbrnoYbYtvtpU=;
 b=tG0e/BmzLOTcYWrLo7eXQqvMvYOCnjAJj9pdC9OGjqWP89KulmDkpNCIyBHDDrhbOIJoi1HWdEmore/PAnR0CWBm2So1/r/0k+SRdBt+BtCguauoqstJTKvEE3fvVjEy0ztjBjY8A9jgXbiV/3/Sb1QW982QjCaawaDqqguFTb8=
Received: from DS7PR03CA0173.namprd03.prod.outlook.com (2603:10b6:5:3b2::28)
 by SA1PR02MB8559.namprd02.prod.outlook.com (2603:10b6:806:1fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 13:21:28 +0000
Received: from DM3NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::82) by DS7PR03CA0173.outlook.office365.com
 (2603:10b6:5:3b2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Thu, 3 Feb 2022 13:21:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT004.mail.protection.outlook.com (10.13.5.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 13:21:28 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 3 Feb 2022 05:21:22 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 3 Feb 2022 05:21:22 -0800
Envelope-to: git@xilinx.com,
 miquel.raynal@bootlin.com,
 richard@nod.at,
 vigneshr@ti.com,
 linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.18] (port=53848 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1nFc37-0006TT-QJ; Thu, 03 Feb 2022 05:21:22 -0800
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>
Subject: [RFC PATCH] mtd: tests: Fix eraseblock read speed miscalculation for lower partition sizes
Date:   Thu, 3 Feb 2022 18:51:19 +0530
Message-ID: <20220203132119.25684-1-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd001a19-096c-4623-d1f3-08d9e71815d4
X-MS-TrafficTypeDiagnostic: SA1PR02MB8559:EE_
X-Microsoft-Antispam-PRVS: <SA1PR02MB85592CFBF79C243746B3AF1ABA289@SA1PR02MB8559.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bdV09Tn/1FP2fbWymu2SUIqbscoZVYK9vAH64u6OiC7s32YlQQ2koM264/Z8JmVm/FLz8U5DAwasZPAdYpljlD1B5B3r11uHWLMy75bl6Ei3wAWqUwh4BzstkxB8i66IIcwJCA11m9NG1kE2PXlvpX9gH8p55O4xGnvuCY0QBSvkDb3tMJoOqwQMpdKntPkqDTm5Xgk8Uluhml8SgsCOd/ZNRiPv9EvZ+G9EyqPv7gaMz7/IfnhCo7djXBJIC5bSya6RP34+1qdJMHUJ4aXop3MDKE8CScekl499vzrbqHLo3R/g6CPEm6L2kk5SiJEyneu7F0IPKNc1NL9v7RQac2DWBCQhp5IT/jGbv2sUXCfHqy8lQdKDX3bKt9rup6lnjJPSKszzDqRL1v7dPdhmQfMXOgdsAhyRCC18O8aIfOENqEgqKRC93t7PjBF4GtcvQ2IjKDZmeBBKGrYND+ISPHzx264y6LIq/ed8WP2NNNEXBYiuqL2pF3fJqOKzFlEOkm9jq1Dpogne1s68IWIHFzpCVZabinBlm1V7sH9IqZjvS+tXpxeIUhZk3ValxnZ3n10qCM/oQOp8xmLLHVKJMGmeWJbXB2sjwOb8P8JCRuPaFgpi3SSLxz7BXryOdIwu8SKAmB0WkCAnllvq4FGCdmheu+s++3AfQC5ddAl2iBrWQJoKBPfUhURB4s0D5rb1vRNSbUnJDTn9I0nT0ZcKZQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36756003)(7696005)(8936002)(40460700003)(2906002)(1076003)(5660300002)(47076005)(83380400001)(186003)(26005)(36860700001)(426003)(336012)(70586007)(7636003)(2616005)(107886003)(54906003)(110136005)(70206006)(316002)(508600001)(4326008)(356005)(82310400004)(9786002)(8676002)(6666004)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 13:21:28.0198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd001a19-096c-4623-d1f3-08d9e71815d4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT004.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8559
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

