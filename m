Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B205A0E40
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241296AbiHYKpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241203AbiHYKp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:45:26 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60063.outbound.protection.outlook.com [40.107.6.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F85A5708;
        Thu, 25 Aug 2022 03:45:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/iBEOLS8YecCagT8MudD0vUcUt1GaJaWTKd/vvky2DRvJ+ooUffELoNdNMBhx29OUeWE53oqzMvuZx2Qwep8y9c8OUcaltiIgSjSa9jB4EcD31pZfJuhQJ3ymV/Swj3gIoEURTdAuLbc65RAjehznjiaNPfJaH6jdNaApU58uxg+qSlEoDINfWvm+tdipWLbdHbl0IYBdzA0tnxIiT/DQh3YnNd78DPHaL3647Cdq5cgOdOwEWeqxeVtfAx9favSdyupFuNt3Qh/2N/SxI/aOrbBMUzUA7+KgoqJYG/jHPrkOH1vVUeiITweJUcgpcuwWIjn8NSrpqL5xD3K785gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/r+FQX2eliYY+NZbS2M+ZUIIXNF73vRJLxYe4sDdtk=;
 b=ReFWGAFTPK7c08qJ1Oi1hK/63GPU5D/VV9zU0/biKv+399kEEPZYTW0tNL4UGmLZjdQs+7LSag3njBgBdJ6Q3z5Pejm/5shAIwGg4vQ/jpgMi9RQyOs6dVEtge/a+P+HxxOe9TzbrogN8atDGMSiMlzPYiOJAg6QSMGK67RfChADAYO82CzYrp6P/lFkqYPlfw4AZZmKUY0L4DbMJ6nCcYzl/C5i1qgdVcy/hPmiQK5qyrtgbYuG5OEUsXUGx7HgYzE9tI+VkCLsfiedVXxzRDf32gE3e4vyjzij2EwuOLS7OpjkzeO28ZDsmXgx45/pkqVsngXxyezZGQsIny4GZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.75) smtp.rcpttodomain=linaro.org smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/r+FQX2eliYY+NZbS2M+ZUIIXNF73vRJLxYe4sDdtk=;
 b=XyhFT4i071GQj9DHK9Am1oLXI7ZaGpBXkeMFEfC9aznguX7FIIc0OpM2zI4DdYCeDXX9hWXmEfCZZcwgc/fmFooSZwIFHIhAr2mlsohzAdf+qyItK7ymwUV00pHG7NhSl0xeQwwR+Lj3fYS8luroX+rBWoNhUL70XI/tmBZm2q1xz0sw/+sc5rQ2Y9XCFvIYyic8BOUoClpEdK2SDuJVcJ8nLAXWNEwNktIL9yZvK8SgSHfI5/te6YQ0uLavvn38dwvrdD/9jRZo8gDtQdmPUQfjXY6WzE+lk/iwMJTXEf5s9niLFfd3y07QAymTt4V9HMTbgogaozZ/+ofkvmEQyw==
Received: from AS8PR04CA0006.eurprd04.prod.outlook.com (2603:10a6:20b:310::11)
 by AM6PR10MB2648.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Thu, 25 Aug
 2022 10:45:06 +0000
Received: from VE1EUR01FT059.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:310:cafe::bb) by AS8PR04CA0006.outlook.office365.com
 (2603:10a6:20b:310::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Thu, 25 Aug 2022 10:45:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT059.mail.protection.outlook.com (10.152.3.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15 via Frontend Transport; Thu, 25 Aug 2022 10:45:06 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Thu, 25 Aug 2022 12:44:56 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.0.80) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 25 Aug 2022 12:44:56 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Machek <pavel@ucw.cz>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        <simon.guinot@sequanux.org>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v6 6/7] platform/x86: simatic-ipc: enable watchdog for 227G
Date:   Thu, 25 Aug 2022 12:44:21 +0200
Message-ID: <20220825104422.14156-7-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220825104422.14156-1-henning.schild@siemens.com>
References: <20220825104422.14156-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.0.80]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c010fa7f-bc28-45ca-d98d-08da8686dfbd
X-MS-TrafficTypeDiagnostic: AM6PR10MB2648:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mrnYKCAE7RD//IMW7UPwf8HgeiZ4X8WngwYhD7GcEu74kXur36ghDeqEa3OQFu7Q+WsP3R+hvpcp7sUISN7ud7Cqqn8dL6pan+9hE8x/8WACm54BDY9ADN0HsOdz33vn/FPx33vxa9TWtqT3OPBBrh6yo4raXpR432UGfCdLrbVz5UphDalYAvwiEH8S43DOU+f7ZMf04E4L1aOEcr3vkLgnmwZzUpYHRgVwK1dOs81pIxBcSAdiONChsGkmshR172IOEaZJ2DpPZJhXTa0uMi7eGTRtuwMIdtXH2oYzmOJk56plhFvWiIt6RHFFQBdVj0mlGbM/f3CsUlPid4YdtY0k6Eb5G3P/Qwuq4P5/bAs/ShghPZjg0CpfJdKSqFfknoNAOr8DIvDs4nUqFZG+yEubkMRm5sa3fJUMy6SBHBdva/TJ69Opi3bM77AmCloo3DvpjvdmFKTarAWepD6jr0QubhSGZSEuH5mFl7IXS5cOnJ6nUchssu3GYxqtTI0CIdy0LVrBjB5Q/g8tUQETHyU/yrbm3qEhyunm6IlqxZgX+P2M6kpjRob8R5z51lRXA/M8goqqxX57GEwx7W/JVZDgwRUpt0hDkFrfdNHuYhnK8FltyObS4v9p7vOmLq01rC3Qzgt0KUGrUnI/UI4jqOKZXrv0UxIw6xrg22doKryivqqxgzLQsjIcxEb5sXWdwRNCBfsMJgRGc4aZwIPueVDMEgm2uALxfficrWA+0Yjogdopwv7ypg4V91hDftWgwC8+VFC8RYDOt84IphtrIRQBjn6dHhjYy9KciuDOflOmXQ6VpTt6Mc7Ur7egqBzbOiENkN/qhzgo0nNR+Mps2enH87kg5UnFzhk71Ngoitk=
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(346002)(136003)(40470700004)(36840700001)(46966006)(83380400001)(2616005)(316002)(356005)(47076005)(16526019)(956004)(186003)(82960400001)(921005)(107886003)(336012)(1076003)(81166007)(36756003)(54906003)(110136005)(4326008)(86362001)(2906002)(41300700001)(6666004)(40460700003)(8936002)(478600001)(5660300002)(70586007)(8676002)(70206006)(82310400005)(40480700001)(82740400003)(36860700001)(26005)(44832011)(4744005)(7416002)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 10:45:06.3222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c010fa7f-bc28-45ca-d98d-08da8686dfbd
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT059.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2648
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just load the watchdog module, after having identified that machine.
That watchdog module does not have any autoloading support.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/platform/x86/simatic-ipc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/simatic-ipc.c b/drivers/platform/x86/simatic-ipc.c
index 1825ef21a86d..8dd686d1c9f1 100644
--- a/drivers/platform/x86/simatic-ipc.c
+++ b/drivers/platform/x86/simatic-ipc.c
@@ -96,6 +96,9 @@ static int register_platform_devices(u32 station_id)
 			 ipc_wdt_platform_device->name);
 	}
 
+	if (station_id == SIMATIC_IPC_IPC227G)
+		request_module("w83627hf_wdt");
+
 	if (ledmode == SIMATIC_IPC_DEVICE_NONE &&
 	    wdtmode == SIMATIC_IPC_DEVICE_NONE) {
 		pr_warn("unsupported IPC detected, station id=%08x\n",
-- 
2.35.1

