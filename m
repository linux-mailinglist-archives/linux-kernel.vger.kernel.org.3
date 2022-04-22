Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3596850C204
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiDVWJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiDVWHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:07:34 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2085.outbound.protection.outlook.com [40.107.101.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171E62220F6;
        Fri, 22 Apr 2022 13:52:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XChKhufiRIDYg3IXfhcdPip/izcW1xDMfRUwOEIhEQhUhBq6AFsqssHAat3dTyNpXChAF17PR9s5aXY2JirJMFSqfqTYQ5tHkGlfaF1AFg72AUOHi3vidX5s6PKV0WOXlMRK7nbiviXPuhdp/d8KsF1n17NUwmql/ils3sj6hL0OkoYwYBMC2mun4Wo1+1mbAgBC0thledIVGjLI/vddfEaYpaRlnesCrK07ZsOQr23JtJQrVlxAUY9NrTfS88CQm8n+ed7iE8iFzHEEeMI6od9wLZd5LOJAIdENiWfQPoCXP7L50VzAQ0w+Y7muIhsbZH1GtwZo5pKyKbG5ZBK9VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arfCdPsLWsD+Wp0ypNL/XEOk0UeOVvq0Xn2HLNzr7i0=;
 b=GdzVHFdlcW81ckBrCiySDnfrSXE/aR2xj7OkBn6qLAaL3dsaR1W8MD4pLSTAYe4buTg31//9BN5a8C39HasXRPIHrkVl5XULhmglTFYpXWYUc50IUD/N2hwNBGOwkJwB3iUxJWnHMBO09wTC4aA67ZvFqkGg+eqYS9q82KIX6tMkEK5oQLqUmiGvtLHghBD29gYxTvqIKtaCMX4alDe1KJTomcXfEmI575MJueIFWbluA0NZkIxLeSPmkv6cn+mHinJ1crJMVXSi2ZPCqjFtgYlEVisqLwebkhfZ83biSQjl8SmWbv8SU2nQBcvow/HhpGpplCKvjSN8KssbqrWH3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arfCdPsLWsD+Wp0ypNL/XEOk0UeOVvq0Xn2HLNzr7i0=;
 b=a0Z/mweSWLN/0TXyRzvJ5vybwfvV7AZJxi1cajC8D6/CwpKnM8BBNu/GSYXPiY8ppkGImsfJtfVEdZLk35GW+d6/DktNXu3z3pl/IUqMH9r6hXWQP9xu7O0StRiThatHImq/VVdJa4bwtYy+iavfdK57YAVLUKKP7b+VWITmTZQBYUUInZgkX0a8KyTupQgj1jnKgj5EtZsm1A0ch4ZE9Wdevjn2fzJ5K0rFhOniOUKeZ/KowxRdJiYBrPzKpA0gb1I6tbE3Y0fEy34JqGSkw+w/R/fg1KXk4kVt0skWfseqElEeyQTJANhjIwBVAfTbF60/PgVClRZv4FE5dD+WYA==
Received: from DM6PR18CA0017.namprd18.prod.outlook.com (2603:10b6:5:15b::30)
 by BYAPR12MB2712.namprd12.prod.outlook.com (2603:10b6:a03:65::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Fri, 22 Apr
 2022 20:52:28 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::d2) by DM6PR18CA0017.outlook.office365.com
 (2603:10b6:5:15b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 22 Apr 2022 20:52:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 20:52:28 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 22 Apr
 2022 20:52:27 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 22 Apr
 2022 13:52:27 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Fri, 22 Apr 2022 13:52:27 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <smangipudi@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH v6 08/10] tools: gpio: Add new hardware clock type
Date:   Fri, 22 Apr 2022 13:52:19 -0700
Message-ID: <20220422205221.952-9-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220422205221.952-1-dipenp@nvidia.com>
References: <20220422205221.952-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fd97eda-f5ae-45d4-fbc6-08da24a20370
X-MS-TrafficTypeDiagnostic: BYAPR12MB2712:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB27121CDE1AB0F21A0580ECCFAEF79@BYAPR12MB2712.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qmmw4IR0toCcTApHUaZTPYNdVdX2xtJkzUpX+eqRe3N6iMsMZrbyiZY7aR7Usm0CyzxSqg3yASCy0RJsQvaVvEJIwyLZVejKXpKmRKrntFgSHwJErud7SZIxSIKI27U9Hw9YLvOXFjHG1C8Qqd6HR+1vQ5dmmGRrNdH0dv5KKvowg1vtDc1MrhMzIqJ4N2+aEPD6uXZRYuH1b3i8aY/yvda3VE9bmsZsN+WD80K4a+bRlWIidTSDKBUhbIbYb0SJ9TxwC5bWsDQGllWRx9pQEGfJVtiofDjIQNPng6CEpWHR0T6ZlulwDOJsal0mVAjUFImhgnW0g2lwvUmXkuWfDGRJmZwienxjr1lsQwk0A6Iv9R02+WSgFoRVKWlQ7kFGYYVTMrF7XpmKn1bXoo3uebR0Zljn+K19NK++jC9eWR9ufzbrARFB0xkHx6a7QH+cCqVYQZB6dv3cMV+157RvhJ14/qKypsLfKQyivxketcVA8yeV7w6gOS3QsFMojNStQ34r1poYKV0MMxJK5BOjDMJSKTd31aQDG9x7lY/RzqNaGDeFMXh6jvllG7PLmveweglamHD5m0d9UoOVCus1hH6EfVrqDPXyYpykL/im++xEqrELEM9VWJXApo2BNcZSbptjHt5VqddcTEwP5yS9BYLSRUNRCQwYPn3hvTlPRKSUmuXWphoX/e95ALBnP1RuTShwDkH6+zP/meqFOk2cJiZc4/IW3gE8MimPcwzdJ00VOxCMz8i76uJivB9JIpHhJfFOYoTGnqDdiMC4ROZxLg==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36860700001)(36756003)(186003)(5660300002)(2616005)(47076005)(70206006)(81166007)(70586007)(1076003)(4326008)(8936002)(82310400005)(26005)(508600001)(40460700003)(6666004)(8676002)(86362001)(316002)(7416002)(2906002)(83380400001)(107886003)(921005)(356005)(110136005)(336012)(426003)(7696005)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 20:52:28.6134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd97eda-f5ae-45d4-fbc6-08da24a20370
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2712
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

