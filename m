Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5208559FAFB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236358AbiHXNOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbiHXNOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:14:43 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2054.outbound.protection.outlook.com [40.107.104.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF2829CA9;
        Wed, 24 Aug 2022 06:14:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgEAd3LtoNRkUR9N2Wdn4KkvWoaLyAXS8pFYzErrw/0DXbgv9BC9CWMjEHZ1sYsJaoqBLMphOOo6rybFRy/r8VdldQIx2Frl0cj757+DUnRkzaZYAZF7aWdehjk2F29RX+LnAQHffguXJ9p1v2sTpqJIID/wAEXu67pa0vy/+ltF0FxNnM4WgUA0jyaBMK6Zl4+U6PdGoPCD/80LplskDMQMFsYcSzjExU0r1Wk+tyPeBMOJTGbRpYAgdNE3pyvFIj5iQTovswBPRhpGHrwjK+o6VZmnsevqUiAPnQRPPE4FtYviWn3h2vEJjV5EbvG7qT6S/tgqCVj300f8q6eS0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwkWFwG23T9fVQCGQdIAHnYQwHOvmad4F7EVz7okapU=;
 b=dcRRxjsyZIeyIkkHxYjrA9LA8RGjJk5F0lgtTnKehjm5qC/5POnb3JsPaPjRH94CiXrMdWndELPmY+ife2sWFgs1mxwGud1lKP5spunZl4NF3YjYQN7WSbpsediwLRu9ioIUBICEOSSf+/2TOHrn7wDvDZI4ECH7nymJBhAmqX4Iir/3BNsSWqFsjFn0u/5Um+klThi0eQGHNh39XQRa1vXgoJ8KaaEIouKq3n8uBLSIdAhZywlb5JyaWSqbZDwEDLwUb1xIHiF3Es7kWdXjdW/1l3EiXpdx209xcoCIH/xL1rwbBl4rqkgdI+w+sXYPZ3QBTHRJ56mERror36UObw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.74) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwkWFwG23T9fVQCGQdIAHnYQwHOvmad4F7EVz7okapU=;
 b=oB6MRjcrS5mO/h1UuTUso825+SboiAiXYXrRZYw16Ml/Y4Y8UgyD/QQm8VdME93fMHFH8IK+3Jj5EO38fF1nTvG5mBJ6XvE58g/ge2emp8VMf3G0tVCZQbTfDmS27XbQS9/h+AcyzxZh/EJRMoTdDTc3TirxbdH9X77ylp7cBJd4P4MC1z5IoUZOKY8IDfbPhZslWB4SHLkRFA9jSwKI0i8hJAAmA+bKIdOp5WrIyLbWNlsJ6BoQL2x2ljBa6BHWBgFjNL49Gtbae4D43yrgupB4GSUxRCIfi37zDzetoIZW1/Xoh7R0zELrWzmJQ918o0r7NQImihEQcUWytvN3YQ==
Received: from DU2PR04CA0280.eurprd04.prod.outlook.com (2603:10a6:10:28c::15)
 by DB9PR10MB5643.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 13:14:39 +0000
Received: from DB5EUR01FT074.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:28c:cafe::13) by DU2PR04CA0280.outlook.office365.com
 (2603:10a6:10:28c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Wed, 24 Aug 2022 13:14:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT074.mail.protection.outlook.com (10.152.5.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15 via Frontend Transport; Wed, 24 Aug 2022 13:14:39 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Wed, 24 Aug 2022 15:14:38 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.0.80) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Wed, 24 Aug 2022 15:14:38 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v2] leds: simatic-ipc-leds-gpio: make sure we have the GPIO providing driver
Date:   Wed, 24 Aug 2022 15:14:28 +0200
Message-ID: <20220824131428.31904-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.0.80]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--11.105600-8.000000
X-TMASE-MatchedRID: amD70iupjS3ITpavYyPdekKt7woFwOAt+UviL1yO5g1bjFVYvBzkwFxo
        0H+7nJCrLX3qyf3ewG+pTtnpKpQyOgPEvA3Yio/GqaHo+UkmnD5eVDccyVYmY0hwlOfYeSqxbsF
        LINmYCfGCXgJyFho1RoO6W2ZdoUAOGgGhKVztRDuj9Csdp/rgSWs0SgWtnXgnSszr2nuUNKwmKH
        /Kj46+VYAjsy+r+wvn2yTG00/Sv02t2gtuWr1Lmtr+D80ZNbcyn9v8HoDZ0FEPe5gzF3TVt30tC
        KdnhB58I/9UW5M5dRNp7qEhmmPgy46HM5rqDwqtYrmWAAgA5gsBO/YlB7JL7S6M2wQfhKTGYOiD
        QYrf3Ay0PpfkhE0Zww==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.105600-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 628BEC332E03109B05079E09EE94CB6DF85B2A2123EE742B885358C50300BE342000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ceaf1943-5441-4f8d-28e1-08da85d29992
X-MS-TrafficTypeDiagnostic: DB9PR10MB5643:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MbXfgWMQsdeylacWlPdnsSfcPe3LsAhLlIO3hqq3EHoxaSWTsElO+1++3iWeL4LRSrpbxnO7xeyhqANZ2IqHvKEqCbqVz0KINpd11cB7d7dGGIUVtkeJBYQ9evGmlI7GmnsT5ietyYMTCP+9kBNSD6MlNHG4UQTnakDQ06ezwZqkxpuvTITEMJ+oJW8mR/595snO1QDB8SgSeyX2NdBhaVUfml0erc45vnbUjhQRCjmn8L+RpABpoxYu9bHzgNkiR2vdyk1b64iutcFo7KiLpJ+vyym7JOo233yKLh4tO2PPv/PZNioUsh4eu9FGX98N8h0CqgWJis1l4vtlGen6tjltNtaZBkOSGTG2NBwmi11juAwK1ZknNHIQ7gLhoehY5x3kugUdrb8J0z0zNCZHae36g5RlgDzElMA1pTsnG/H3tl5h7fIDHY/yl+25M7V+1Qa3YO8JQqDG+NKmPqX8s27MBP/vaotgf6oJ6elUAqybb6mUFF7hsm9VUKL1LMM3pTjpQoIXaKPllxr2TYJF5KwK4gPy9KJdiIFX6NxM1ia7xuphYgVynNJap4GsAQefptjvmxcE5Sh6jGvdAS6JnXLNkjUi1e2thcxV1pNDwIdTy79SaQvkJfZ/fR2/fQDYoVD8pV97+ZoJCkFb6wq1yFYROnTTs5ZWxp+oZNQ/vc/VT3/PNK8kPB0tT+OM4775z/S+snpSCaccEtA4IhWxhXZcPAb9OcEp5zKqbr1a7wpgkFxTd5AX74TQ6QUIMwWH7VxM42xTLiN4jGH79I3ytJ6Z7xrBvYMFv0fl319Omib8fzeq7a2TZRP04WtWgrpD4jJOiuFnboOD/u5pWpZKmA==
X-Forefront-Antispam-Report: CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(376002)(136003)(46966006)(40470700004)(36840700001)(70206006)(70586007)(956004)(2616005)(8676002)(44832011)(186003)(1076003)(47076005)(2906002)(83380400001)(107886003)(82740400003)(5660300002)(4326008)(7636003)(41300700001)(7596003)(40460700003)(356005)(8936002)(26005)(82960400001)(316002)(40480700001)(478600001)(336012)(16526019)(6666004)(36756003)(34020700004)(110136005)(36860700001)(86362001)(82310400005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 13:14:39.1840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ceaf1943-5441-4f8d-28e1-08da85d29992
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT074.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5643
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Fixes: a6c80bec3c93 ("leds: simatic-ipc-leds-gpio: Add GPIO version of Siemens driver")
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

