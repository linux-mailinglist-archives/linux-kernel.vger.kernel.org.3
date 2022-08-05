Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AA158AA76
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbiHEMED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiHEMEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:04:01 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80043.outbound.protection.outlook.com [40.107.8.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E96140ED;
        Fri,  5 Aug 2022 05:03:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QL1Eb22yzLGU1z76UJcfyWb1PGTbjaK95ajYf5H5m0OwKbcJBw2yiCj9POpU/L8A5GVXNsJpe6jbSZKa/5C7CPFgMozI/9mZLT+7+ngsVmPFdygWk7LiMTZdltD/Ghh3/m7HOufi675bw1r8ofsIavFmUzmcaneaTuTi9Cdwo49gVZMmfCNiXM2K30lik5+5NLiIVfwT41DO0Vzjfc+0/6JHPy/Mq+lcOZLFupGfr/gUhhoqyfTMfE5RkQE/kNStiAFjnXSqxIedFLTcDa05nbf3+HqPAT0zNJ4t+52+ZkzMJr6pISX9gjMKuHwTJnsgyVqrBQtbt5QykX8N+WUfZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrqnvOYYg3EExQWLYkdvzrKyXZv0psz6SCt5+a1YYww=;
 b=X/8M/qqvqpsqUVMBZPafKUHljfmdPuTA+yKDOFHPiqYCFpchFNN7C/ufj4gNjimdnmmuzXy8pbk+D6N50ff5ZQHNEve6xnMPlb+6EDW09eM7/jFfUCw9no3VyI6nHuee4LdtmbRHOz4QWz5hsl5Er10fbsPl8EGw3Y1JT/lho4BrFOozDLWWIR2Frhgt96DIMzwIsHsaJEs3g7c+zJkZUr9pjunkoJD47EdSQy2ncArddIg05OoQ9ckymsXjF/skvZo6dYcjYm8nW1y998Hi+jHgVbWBBagI3OJ5iznr343h3f5fVAAxTovTKhZm6IVR3nAHyqRFWU9ZX5DQ+Naf4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrqnvOYYg3EExQWLYkdvzrKyXZv0psz6SCt5+a1YYww=;
 b=zwIU0U8ryYHh1ReMwimQjYr+LQkFSEUMfzxIc/g+03tbcGWTjKmi4Kev/esKzvYm1XqoS/OmLPDda/bM9xqUUlMqGEWUyreQ1z85umBHFodoIi1pA9hsj8n9AVkjK4jF0KKGM20KCsy//uskUpBLLk4tjNh2NvYnvd47RcTMlZ9dSZp5aUVwL4+hdPSqcCdcxWdODOMlHztHfuY/nD40BOmpsHUa7dnbqDvhJw5ry4lWdOy9rZVtJoyJYCk+IJUiKJl8PpkZqA0WydIPTjAvv31d5pSlUl4EMJ/2peV/hMHTIeJcQWWI8gWSmjUauvriCC31T7zmuL2lhqldH7bGLQ==
Received: from GV3P280CA0111.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:8::28) by
 AS1PR10MB5413.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4af::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 5 Aug
 2022 12:03:56 +0000
Received: from HE1EUR01FT004.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:8:cafe::a4) by GV3P280CA0111.outlook.office365.com
 (2603:10a6:150:8::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Fri, 5 Aug 2022 12:03:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 HE1EUR01FT004.mail.protection.outlook.com (10.152.1.233) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 12:03:55 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Fri, 5 Aug 2022 14:03:55 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.0.80) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Fri, 5 Aug 2022 14:03:54 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, <linux-leds@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Henning Schild <henning.schild@siemens.com>
Subject: [PATCH] leds: simatic-ipc-leds-gpio: make sure we have the GPIO providing driver
Date:   Fri, 5 Aug 2022 14:03:43 +0200
Message-ID: <20220805120343.5027-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.0.80]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15e9dfe4-9f90-4630-e6ca-08da76da9289
X-MS-TrafficTypeDiagnostic: AS1PR10MB5413:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YHJaVW6vbEFC57cdQI0gpP2jA/CB0aquNtr/i9bHGk1td+hglSpZr9KNDn1DuY3Jlpl7uumHpitwZN92xgEe9XzC57NVciaG1RdTZ5d5XCmMaVUvHeTmkqsItD8meOFS0W0vAInOT/EkfPNMns56GIBps0gZx7+fYhWC0Mmgi9S+tq5mJVl1oWV/GQbd9Z1Ez5+KfIEWkRe9lDHh6XnuPdnfAiNnqnCCkS3o4nxz8SjLWLzQooJQUSVX2rlNIjUwYfwTql2RfTIMlkDhtsTgVtrwPUXEwfEySmET1URTm11CCEi+lkv1aSzbfPTvNi3kXZi7M7dRozqXnavn12O2hw1+8bl3k8Z/1a+hrxMDIk9Js4GSVOalJCKvor17/FKMWoxB3VnY2DYSo9nwrj64D3blwsxclrz4kAIOLar2VyonaBuyYy/2f5PH9CYmeEGG2Tb5O/RDxsk+f0z/VkQaLlScYsB/BMRIUaPt4qpaxA9P2sP77bLNhQ4uowv0jeW1oEax5wdO+YbcGeE3HGiFRLENSWqgi/pQN41urHrVZeNsKMTIOHu2/CIDR0ZWGciHkrbfRAQOP84uV3kybnZUvryHDBqlOrWUpzfJ67V18E1aOeStylxi9NssY/c1/MsJ+iKHCnsKQqJNeKlklGtd4axOUn7Rpi1yY1p5wTUjYLhhbe2QfSqrhu4Zkg6vfkIggKBLoGSLzy38yEEtfTzgMu2ojg/Y8dRm+HIGpvy7pTUwB2UhuLl1w0Z+MkMwngzoWfjiMqoBQdG5JdHC5YzUc6s7/R/9rKjfUyH4U4uHRoKB91nM6Gk5s4Vi9KmanvKOdFDNpD5yqiWpTXfntDj+hw==
X-Forefront-Antispam-Report: CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(346002)(376002)(36840700001)(46966006)(40470700004)(40480700001)(36860700001)(83380400001)(186003)(82310400005)(956004)(2616005)(36756003)(16526019)(110136005)(336012)(47076005)(82740400003)(356005)(1076003)(107886003)(26005)(82960400001)(81166007)(316002)(478600001)(86362001)(41300700001)(6666004)(2906002)(5660300002)(40460700003)(44832011)(8936002)(8676002)(4326008)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 12:03:55.8868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e9dfe4-9f90-4630-e6ca-08da76da9289
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT004.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5413
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we register a "leds-gpio" platform device for GPIO pins that do not
exist we get a -EPROBE_DEFER and the probe will be tried again later.
If there is not driver to provide that pin we will poll forever and also
create a lot of log messages.

So check if that GPIO driver is configured, if so it will come up
eventually. If not we exit our probe function early and do not even
bother registering the "leds-gpio". This method was chosen over "Kconfig
depends" since this way we can add support for more devices and GPIO
backends more easily without "depends"ing on all GPIO backends.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/leds/simple/simatic-ipc-leds-gpio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c b/drivers/leds/simple/simatic-ipc-leds-gpio.c
index 4c9e663a90ba..0c96ba98e338 100644
--- a/drivers/leds/simple/simatic-ipc-leds-gpio.c
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio.c
@@ -57,6 +57,8 @@ static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
 	struct gpio_desc *gpiod;
 	int err;
 
+	if (!IS_ENABLED(CONFIG_PINCTRL_BROXTON))
+		return -ENODEV;
 	gpiod_add_lookup_table(&simatic_ipc_led_gpio_table);
 	simatic_leds_pdev = platform_device_register_resndata(NULL,
 		"leds-gpio", PLATFORM_DEVID_NONE, NULL, 0,
-- 
2.35.1

