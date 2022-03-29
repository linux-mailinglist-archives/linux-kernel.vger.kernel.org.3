Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB7A4EA755
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbiC2Fr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbiC2Frq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:47:46 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CC024A8A9;
        Mon, 28 Mar 2022 22:45:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPnUzs/n4pfFTTvJI5McxGFdMhog9hK+0uxk8JXPQoREMPa1oFpw4XV6C/8lGUKyncvGHVHJUO0ZPz/bRFQi7kMhUeWxDoUEW/JsQK8VJFdaaunAbhGpFS74eD734eRZWA/+oOIw+b7YKonReShzTRL3ZbYg8fLtpnr/2ySlV3iC+unhKFrynSA+ujnCVNru85aDmiCLUtl3JYcfI0RHyi4loU7mbLc8ModUcwR9Ua7MX/ybe6jvoGqxbpSQvrp+r12Mpw6XcHsJ5zELcuHS63nXuho5mzbO/T0u19CD78skp840Vsh89QfvyXyIK8NNQC7NfgKqbkebK5CEYmPpkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arfCdPsLWsD+Wp0ypNL/XEOk0UeOVvq0Xn2HLNzr7i0=;
 b=PSg1MqKzu4oLizcWJsMD8/qQWCQNrPeoLzAlgDDY6vIzR+3tZn1i+QGZS4XA9DcvGCbFwdsTOv/dy2/kwlmtRzq2jarag2p4qTzlBY23502ct7ujhkuxEPjTmOY/+rEMjdA7nOJCLWsM95nlsWiuD7ba8QnSr9t8Fbl0Wo6fbVsXjpS4AqjlsVWJ94/j0jCTrf40shAhA+60QRUJH5U+SqeYRlG/JlKz3OSFgPfcdaQ1r9QolY6ZCuRcXZZt83lscRUVgjVdzzUzl7flcEESqsgNWi8KsvQilyR8196saIGRQGGBVOM8FQAykaAaQWw5y9ugiP6hV3WW0TVYiQqOfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arfCdPsLWsD+Wp0ypNL/XEOk0UeOVvq0Xn2HLNzr7i0=;
 b=RN85kqMZzwFYOxItkE5pz7PRTx/sK8zNGOYa9J8mib/f/SkNnNpCpkWOL0kTalU0/9XCe80dbxPvLNcwHw9gH9FH9ynC392+AlP6Se3wMznjWw1oyLON9xU+nhVi2pJVF1/9Auwt7PWIWoZ46TPfJlNFMNJ/aVYRlhCAFKePg8eTkfm/dqHeG+XJkRK+4FKans+q/VDr4nIeeBreYb1DVzA3RkrM6LB3lOf2LyCliaaBVaLgLk4DEU8AkKoF2IEAYH9RYvWTB08HwuXx4F6Pt9GXLIQ0N3D7zKiWFcbjnerU8mEk87JON7knpujqSfH+XWJVCwXsgYg5ucGS0VRPNw==
Received: from MW4PR04CA0303.namprd04.prod.outlook.com (2603:10b6:303:82::8)
 by CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 29 Mar
 2022 05:45:38 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::5) by MW4PR04CA0303.outlook.office365.com
 (2603:10b6:303:82::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Tue, 29 Mar 2022 05:45:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5102.17 via Frontend Transport; Tue, 29 Mar 2022 05:45:38 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 29 Mar
 2022 05:45:37 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 28 Mar
 2022 22:45:36 -0700
Received: from dipenp.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 28 Mar 2022 22:45:36 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <smangipudi@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH v5 09/11] tools: gpio: Add new hardware clock type
Date:   Mon, 28 Mar 2022 22:45:19 -0700
Message-ID: <20220329054521.14420-10-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220329054521.14420-1-dipenp@nvidia.com>
References: <20220329054521.14420-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4535e5aa-86ec-4b6b-4c80-08da11475a5b
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB53888DDFDA2ABAEACA7000ABAE1E9@CH0PR12MB5388.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /weAxBqD1UeRlORULixF3xjKu+CxymASbLOF/5bX/xZHrYzwJmLuBeX469omnZbdJV8Sd+RlRfhJjP9luXg180xSs+ciJiUMCX6YXe/Mr30ivowtFDtBdkNBnTFGkMABneTBucPV9GyCIFHzEbw1kLCGcVhwiya4WK7KcQTCTvgqLD3uffrFsb/zA3tuhtMKeR3nNVtUObzlx2Ad5qENAAoFQhFSvuhmzgHkB3LPuiq399HNCJCtUSgv9QPJ3RzPHct1S9fGScClyFZMy+uN7oqORfGnt4hZ+8+LHYdvywWwOZ7v/Ey7Hqy55k4YCjouHG395XT/eM0OZpF6K24M/hfM1jG5YpwCOS3QapV4kEwxogqtktqn8fvDrSzWfk+q4FS7hV0fkMk8a3I+j3irkKKPuyGyQ0ShRJJhc/O7uttubBQJlqOnSdpmrruefeWkGek7kbowshja0t/szqqQ0nF9VMULCaRVR20s5dd1oiNmqkseA/5PBBtlVVE6sD0ZlzD/aZn9/T+HQQQDZfn1Aa025npVAZI+GNlIe3nnHO8jCK5eIRI3iAvsDB+owgUUXmkFRMP7R6EG8bivBLgbXoSfsHvQfKPy5FeC6E9yg66PpgXzCwMYfhRHbAPx97S5nFK02WCVOOdZ9A7nOnkvwOo0/uPQQWQqnm64Lv4N7bwPamqNj/JPOVnKnXMVHH52xmuY8n2gsvICdKAf1CsJm+ekBGsH2r5v/1xIgrOjUxcwV44zjtGgJGqMOnrFidKR4VZOKszPTiD/3RBgEJhxDA==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(83380400001)(36756003)(110136005)(508600001)(186003)(107886003)(26005)(336012)(2616005)(426003)(2906002)(1076003)(36860700001)(47076005)(316002)(40460700003)(5660300002)(82310400004)(81166007)(921005)(356005)(7696005)(6666004)(86362001)(7416002)(8936002)(8676002)(70206006)(4326008)(70586007)(83996005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 05:45:38.1535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4535e5aa-86ec-4b6b-4c80-08da11475a5b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5388
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

