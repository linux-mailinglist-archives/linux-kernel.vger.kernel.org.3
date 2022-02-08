Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDEF4AD6B2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359481AbiBHL3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356405AbiBHKjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:39:17 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE16C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 02:39:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RseSTn2E21Gn6ZhlcVO3cMgaLWNaIbEDweCorwcee19y9FD8dVhWKRLvizh1wwp1wF+DKy0ykQvFEK4m6SgcerkNuhmi+ES76H3Wrm9aC4Hz96WU+ngAJ6g9y8L4xxmDKeraXYY6EOqbAukdgtX9wdP5eyNn4VKYAzm9W8Ba1dcQMWU+4iMoWcDyvLMn7fWpv+O7oJF6l1wni9JAtE4reb3UC0oWLnzdIPRf3vHy68v0+OwV8GeePWGlwuyghvcu6ziJUo1+//T9jykTNNgk3u5fnqDEEJhMFDd2OVfpeUl4GG+0o718mxzTyCE2+EmXfj2P4biFGnoI2BoHlJdM5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4Tdrg6BUMNptEXjjgr4I1B2km5tqQ4wqcq15AleRAM=;
 b=cMS9vLG+QfY0Yut2g/SZusR3U8nhGFtyqC5/OR0kNlPoTmWZIsp/7ySeEXbkYqHhGVuns3tfzoppf/BAX/KIQ8jMQ0/ZvXtK6hUJaxZS1AZxueOrrpVwAvS28vSpMcahzmG7Ix7BIn0p48LUvMDCOEI5PQ/JR0QLMF6agiFsHSzuVfHNcMPEdEdozcOIb7qNKNSszXV+dIHvdGTeSMY0ArIdbilZagjun1L+J7f1NIS5hta8jFuL1rSevQGnaZzqlFuGJKB8kGrF3z3erZRoKW10OaaDKkboVxKMAFpWP5c8L3VIQRxQrfZofJcBGJFl7fcX2j3whDOheF0FnlbXWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=bootlin.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4Tdrg6BUMNptEXjjgr4I1B2km5tqQ4wqcq15AleRAM=;
 b=UAEcPXt9tbxAqW6Q4IYnLQprRWsPmcrPWHHxhoBJLFxJaQCQ9LD6388lEE0sIrLs9p2A3eSdLDc6G8EE9UdJUSHCQ20cQULmC8JAELjxg3NlVRW55AsuPKN0tZ5IQh9hsALhnPmsAG+356uLeVGNXLcxr8pXU4cfKyyJA9qPKEg=
Received: from DM5PR07CA0130.namprd07.prod.outlook.com (2603:10b6:3:13e::20)
 by SJ0PR02MB8545.namprd02.prod.outlook.com (2603:10b6:a03:3fb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Tue, 8 Feb
 2022 10:39:13 +0000
Received: from DM3NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:13e:cafe::58) by DM5PR07CA0130.outlook.office365.com
 (2603:10b6:3:13e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Tue, 8 Feb 2022 10:39:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT029.mail.protection.outlook.com (10.13.4.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Tue, 8 Feb 2022 10:39:13 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 8 Feb 2022 02:39:11 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 8 Feb 2022 02:39:11 -0800
Envelope-to: git@xilinx.com,
 miquel.raynal@bootlin.com,
 richard@nod.at,
 vigneshr@ti.com,
 david.oberhollenzer@sigma-star.at,
 linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.18] (port=57156 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1nHNtu-0006xq-PB; Tue, 08 Feb 2022 02:39:11 -0800
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <david.oberhollenzer@sigma-star.at>
CC:     <git@xilinx.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH] mtd: tests: Fix eraseblock read speed miscalculation for lower partition sizes
Date:   Tue, 8 Feb 2022 16:09:05 +0530
Message-ID: <20220208103905.13354-1-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13a399bd-b946-4868-e991-08d9eaef3f72
X-MS-TrafficTypeDiagnostic: SJ0PR02MB8545:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR02MB8545842D3DB0AEDE4F3AF0E9BA2D9@SJ0PR02MB8545.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: trmbZqoCDVpQlv9VLrOOR5ge28KcIvxjkTGt9TEQj14vh1tIEJMLYQZZwDJfzd8dv+rbIKP7RDtQFZd4LLY0MGaQobMjgmbLqB6QB9fo3xYuz3zgQKZZChdTvHHgqAH5wFLidGuu/kJ3Wj/JFqOLz5hsnR+r/2c9nMuVK/A4Z44zWyKcbvY4UeTbM1p2qgVSjUiBASl5vjrqO2Th0FIV3d4Cc9cX6plcjQ3yeDJxETXhCayZOSa+9DlYWnqHJWnok8oyX8K6kaXcW4WkxA6WoMibvVSyxkM0fu4rwFgMaB5TrvlItbGQLH0L693r2KSB/ZnmUZagpVJFNm0vGbID03kNV7YnqY7a6YRZusDpirceg6W+rID6R6P4QaVUfW3pkf6CSnv3ULUIvXXKctNENLUPlpoE6BsWMBga9ztWxma13higJr64dptN5cuypMtI2yzeepwiSaDeaiETiMJFvgRKoQ+LdBQ8D5alvRBHKgGfXxIWZ/8oPYrlJ/rEkjXnefco0ZdN2+kMoNl85FLsR2uN5dyFFkRerTDY+ep+HJ1f/jmMxjDNTahA79Fqwi6BkceHbXyuB3LQ8ClbB1KNBQl8Yz0EYMq9iT4OkbC3uhGC3aB8kX6//dRIviUH82+zN2nkBf9pvksB1GxJ5raJ05CpquY4i/fw2zDRNy/ljeFR0Gnn0cnqWaheZhBPkW+Sbf1JxI4LgEjz6jw5gnFUgfvB2sIFkxazOtbNaHl2HMY=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(2906002)(6666004)(4326008)(83380400001)(54906003)(26005)(336012)(186003)(1076003)(70586007)(36756003)(110136005)(7636003)(82310400004)(8676002)(9786002)(316002)(107886003)(7696005)(5660300002)(356005)(426003)(508600001)(36860700001)(70206006)(2616005)(8936002)(47076005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 10:39:13.1277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a399bd-b946-4868-e991-08d9eaef3f72
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT029.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8545
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
BRANCH: mtd/next

Changes since RFC:
 - changed time interval variable type from long to uint64_t.
---
 drivers/mtd/tests/speedtest.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/tests/speedtest.c b/drivers/mtd/tests/speedtest.c
index 93e76648f676..c9ec7086bfa1 100644
--- a/drivers/mtd/tests/speedtest.c
+++ b/drivers/mtd/tests/speedtest.c
@@ -160,14 +160,13 @@ static inline void stop_timing(void)
 
 static long calc_speed(void)
 {
-	uint64_t k;
-	long ms;
+	uint64_t k, us;
 
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

