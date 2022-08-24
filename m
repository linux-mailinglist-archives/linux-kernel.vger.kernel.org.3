Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7121859FCA4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238097AbiHXOEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238567AbiHXOEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:04:16 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B57897537;
        Wed, 24 Aug 2022 07:04:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcFh/Qpf2YXD+krknC5uAljfcDZBaYSyy53vHLRLgA8SA4HruoV79bZfDjdS+96v+ea8IdQx3xm+JqCwqv4ERF2syoGXyWXzDj2aqmfi2zfhh2Te+GY8I5oQzsMVDkwlPQcvBTh7fD3I0Ov/E3b5ab/MzJLWjqA4G6Sly4M9TZ/kmYYh3fpRcRNHeE3iEstwCxxtiQP1ZVrjs7036VuRu1QJ9aI74bGdEOWOJfzXVXFvE6x3+ovge9ogdQ/suViePeqYeLRLLowiXYVJ7ZEIp7TcFCCKxXO4UYqnDPRbJIvBHmFn9TzvMYbLOpPz9rqPvoUvTvD8hwWqQWcFXaL7wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/r+FQX2eliYY+NZbS2M+ZUIIXNF73vRJLxYe4sDdtk=;
 b=mODw8oa3pf1vveJCsidZW/dJwhEyKT5smbqGHL95tjirUozfOTvAowqgzYyqS0E8lNVvrHpk4w3uQvtjQYmon3U4N2jdmIxWECUMvY34qXtakdvrd4NJZ9cmhBvK/z3pZVSWGE/+Y/y7LHqQmBvTb6rTET+XiWlQsrleZ7vLMztI6ZkqeYcfJ/oyWhJm1E5+8zJ5/xYLmq4GrXK2AOIxA0xXwAAyLp5boCki7wrIig39KxmpxNCQt2X9TKnbX7OjTswTWenV9Un1gOaskWiVsR+DTHgn3JakV4ge9PiOoyXFoGiTXHRyhNIXSWA409mxw2Enfc6VbwCOZZNORvkL6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.75) smtp.rcpttodomain=linaro.org smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/r+FQX2eliYY+NZbS2M+ZUIIXNF73vRJLxYe4sDdtk=;
 b=ovAi6tWbNcUTKAqp1xkoxzCRShYf5EEiTSaE5JcawhFIuEkC86fLTt0hcRqBj53iBzlGNJA7Xb6PvsNgHAT5uqJqaUEYdYnS42QRZ8PLHi/8Na61TrZ4K+oSpsOQ8ELOAGvhk2fAqTDlMfdOiVXgIgWvcG3uZRV42Webh9+DNzC2zNyBptS1a85Z4Ot5s6HeV6me1EguR+9crWUmLk88kH1XsapqrLGRli/iXM2APUck7OimLBgj3e3v86x3rKzQdDTqTJ5lKK0Itxyzok3F0Xlea87aib0/Y84ok1MPa2UubvzutU7JmJXPV2nXt9DEE4NE9KpqVd0eUifWs4q0gA==
Received: from OL1P279CA0054.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:14::23)
 by VI1PR10MB2000.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:38::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Wed, 24 Aug
 2022 14:04:12 +0000
Received: from HE1EUR01FT021.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:14:cafe::87) by OL1P279CA0054.outlook.office365.com
 (2603:10a6:e10:14::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Wed, 24 Aug 2022 14:04:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.75) by
 HE1EUR01FT021.mail.protection.outlook.com (10.152.0.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15 via Frontend Transport; Wed, 24 Aug 2022 14:04:12 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Wed, 24 Aug 2022 16:04:11 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.0.80) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Wed, 24 Aug 2022 16:04:10 +0200
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
Subject: [PATCH v5 4/5] platform/x86: simatic-ipc: enable watchdog for 227G
Date:   Wed, 24 Aug 2022 16:03:46 +0200
Message-ID: <20220824140347.1842-5-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220824140347.1842-1-henning.schild@siemens.com>
References: <20220824140347.1842-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.0.80]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb59e553-8f38-4acc-e938-08da85d98595
X-MS-TrafficTypeDiagnostic: VI1PR10MB2000:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DamgJOvxkJQ0gwYpdDff8PdkLJ9Y5DlBdTyngia4qL73m0KYYqI/BIyEKoHbI/Vi4TtukAEhF5Zj/VHJk5bMtkmZ8Qfs6T1aRpiX0SgFB74G9k8TNvv4XNTN99TlDIgfozu9GagMzamhXq3MLV4zzGMLJnLFW7L2SzCD5KWfCZ7MaOa5qSphiO03PlsC5V4f+JHvw9Jx8u1zwFRdJuQHH94Z8XrNvNQ0lLUI9gTbP2twpX6TzIxalAVuYSwGPFuUFtMTK+zQA+RJV8bFfNOjyoByL3hebYrd1u0sStLNhtOabyP2yxn0jOMrDNQyu4qHXjgLL7eigdf/rpXZeX3EnLGOZuo1BVa53oZm92Yb4Xx8onPBFPaQoQdOpOnFKVq91CGYk0rHAm/yrHgUF4eQj/07EMQsbAYQ6BQL+EQ7p0k2sx3ZHPZlcLQroS0r6i8l5zTQDW+Jc0+ul27I7DPbXKtjwCGXYa6n299fWZAammod9fkxStjUNYBhivHtNakgoJn5wMpm4jJci2HzLpM786UbBsxMpMcyFP2YVjYh2htISn3V6BT2kHrnYxMiSb9gScoHMyC341RWWAMHT2eB7jz+TMhRkYw1Ka6HnRyEs5FbM3hRysP122Of2xujOhvQi4QuoH28sD9jOk99sCJykBc7Fg4G9EsIWSYHoKxLpXkTav23yj8d/oYSWMXCQ4hYE1qQ0KLZlJM+9m9NQuXUECwm0n41+Qxd2pIqb5kgU0YH6NEplJuBsuM7HQvIN28ElzTEGT1JUkr/BcQcd5wtHptX+POy2e8u5k9AO+VR6fFslDaLuP/EGuj6VcBPP33L5l5bCNFKDW9nWD/avm11YRD9a2KZ3h/mBmCk0NR5LvKZkw9N8tWCjcdmc1+msP+pBYrHbWR4rAKLM6pIj9eeTw==
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(396003)(39860400002)(40470700004)(46966006)(36840700001)(110136005)(36756003)(40460700003)(316002)(54906003)(478600001)(4326008)(8676002)(86362001)(7416002)(41300700001)(82960400001)(921005)(107886003)(6666004)(356005)(8936002)(4744005)(70586007)(5660300002)(70206006)(44832011)(81166007)(2906002)(26005)(186003)(956004)(82310400005)(2616005)(36860700001)(1076003)(16526019)(83380400001)(34020700004)(336012)(82740400003)(47076005)(40480700001)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 14:04:12.0844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb59e553-8f38-4acc-e938-08da85d98595
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT021.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2000
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

