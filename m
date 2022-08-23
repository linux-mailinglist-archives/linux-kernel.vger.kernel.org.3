Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3BC59E45B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 15:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241437AbiHWNY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 09:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236311AbiHWNYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 09:24:24 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140040.outbound.protection.outlook.com [40.107.14.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4714C8D3E1;
        Tue, 23 Aug 2022 03:24:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmjW6/IlzUmgUSirgd+SCCtKsTIRYObZujqFKIhQ4Bsp9T0dF8IrJF/boHlQtHKd9vJgbna9YREjINZMK5F98SpEeokdnG84fz9Zzi9paTZ/Ys637pwQKPu/5NJs3Fua71RbD7/bihTch+XYx4ue5tf6p3KvVGW8R0xantn2B8SClgLQYuzfvmWko1JQPNWXmZh4Ch7xtg+wq+bdVdef5bCNO4M/RK9EZ89a7aTR2CuXME1p4TsezwS/R18dDbl1Eg73vBUa/W/zGGAAgw4z2e8y6zy/DMaWSw4t6z39xIN39iPypKgVwvPRcWQBEaMl4bAOWiBZC3XXt0IvIzqzyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAqhycPKyY39OMNQW1QVgI9xbc5oqCjiBVJK6DG0S5Q=;
 b=NcD/xvwOjgitDW8RqYMh19X4KcPHCuDMDSIcDiBBbXNZwJv4jDhzRPW7q/MTatfxxfeGKFNPcX5EvbTVTaX1nkP8Rl5YfVVIgiV6OYiZ9og0OV5BQGEJNV++zk+o+Z3QLHFcRwEWaQZIUNs7Dkokz3mE/09PemYMP+lbYNu5n6QiCPmf6We4FrcO9t4XKkRrvz7IEwwjitdk8KElJmCIaWgPYpE5+7M6hDf8TCpBunjlHSy0Fg6IM40dq0x2SFhjW9YDyotLj5msMOKxfKnObI68RfXQotT7jcmNcIiuPdeUorwxOPQ+gJAT85mF5vGUbdG64ZE0uoRhBOTq0NmFIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.75) smtp.rcpttodomain=linaro.org smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAqhycPKyY39OMNQW1QVgI9xbc5oqCjiBVJK6DG0S5Q=;
 b=Gz7aZ0F0dz4JDMoPclyFIZvVVD2XNfwUgXRMUnDCjNg6GmAcRa/s8Yy+ae9U0m8c7ypFCpv4EZbLSD5nFxm0YOyapIB9C0leOJpoxwBb1d8+2k5RxMc5WJDdQ1SIO2V6zos7q4L+8NzkOjF0KtJbLQruKYHwzZ7n8mS+LIus8b3X0g1LshA1hKcE1xSjGSARSrUbJELyvPL+5NVpEJHHB/4TnM8kauYSmxM5hcHtrVnEVO2osMYs1dhNvcf7WAzTxBnNimseP7v/pMW6qhJ763Vv/i5LrNfjcEb1loTZ8LAvL36G7vz7L5lPmJHXGkAXwZgs4M9MxMisjVqEIgMkSg==
Received: from GV3P280CA0107.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:8::9) by
 DB8PR10MB3177.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:118::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.19; Tue, 23 Aug 2022 10:23:55 +0000
Received: from HE1EUR01FT069.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:8:cafe::70) by GV3P280CA0107.outlook.office365.com
 (2603:10a6:150:8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21 via Frontend
 Transport; Tue, 23 Aug 2022 10:23:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.75) by
 HE1EUR01FT069.mail.protection.outlook.com (10.152.1.52) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.15 via Frontend Transport; Tue, 23 Aug 2022 10:23:55 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Tue, 23 Aug 2022 12:23:54 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.0.80) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 23 Aug 2022 12:23:54 +0200
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
Subject: [PATCH v4 2/5] gpio-f7188x: use unique labels for banks/chips
Date:   Tue, 23 Aug 2022 12:23:41 +0200
Message-ID: <20220823102344.17624-3-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220823102344.17624-1-henning.schild@siemens.com>
References: <20220823102344.17624-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.0.80]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86b9daae-2ee1-464f-75e3-08da84f19555
X-MS-TrafficTypeDiagnostic: DB8PR10MB3177:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sBIQ46Ovbeprjt8DrbINAm9ubTGHJRDln0OXlYslojNZTc3vI+5Smolp2fdRoBtNOWlZ62QGepUUIls+QcJ9h5v7GR2sqtqFCnB/Q6uRpJMTQtjqE22TnbgkLTFCJBToFj/yEShp85PcJLI66ETPADf9fZ2Il5OiteHM4hnhDRIClBOuFj9uB89eV/1g7BFoupnEJ7T3ZO98bHdOfAdSi3pWAE+yDlhrayrNxcl4PXs/099qW7ifM3p9atYMkRYxr2BpuPMiiaTZyBT109UmrpRU3U1SZiH2pGcRrUOly9ZdJ9gcpy2inQ16bMsSj9orenYCvxWFJq4bPsqtSjel3P/pvEduC3Qh1n62yW+LVLwND4umVy0yD6lksgGeYLdPUr9IUaB+Q1ELOsutkl/k2l2KPyZS0kc+K6rfa8gnApqJoQEvk9cCYRiDs73K+T7vlm/4U94I0QGh2AQtth+YNdWArRMSfQtebr87KlrKWqy5nk/b913k/+LY1fKPc4h8APB7bwLs3De6OZGhjDZ8Rf1HYqWb9cQT/Tw2vcj0tQid/8kAqm6BtpKtR3b4sWwGfHFJEGZAmXkmYZw/XWpOuooHQBMp48/47CSNeCcJA9ukdQPYoBEnx5qn0RYEA1XocOEV/O4zsRfioTt0P7eW5v7OxTSTHanogpu5m5Jw/mpRA1i5CRd/6jl9+SnqnpqDy14MjQ0ykpEh+/qxx3t2So5+wHA66muVyYh0EbiR9sgCh5Ufb8TwRokQvaZTGEnrIJUEtL73g7dtVuWanGPzTvEZFGTwGGcZ/L0nnBEPxutXv87k6a63E/fVVdk0Xbz8NQHqUgs9CQt3KvgSLSIMysaKa+K58tqTup1rwdveLbaiHteRMPmCq7EZHuqP7eRp01pP5Z8EZ0mqaUZf+oJHvg==
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(376002)(136003)(40470700004)(46966006)(36840700001)(8676002)(4326008)(70586007)(86362001)(110136005)(82740400003)(54906003)(34020700004)(81166007)(36860700001)(36756003)(82960400001)(356005)(921005)(70206006)(186003)(83380400001)(1076003)(47076005)(26005)(107886003)(6666004)(41300700001)(478600001)(7416002)(316002)(5660300002)(40460700003)(82310400005)(16526019)(40480700001)(2906002)(2616005)(336012)(8936002)(956004)(44832011)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 10:23:55.2748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b9daae-2ee1-464f-75e3-08da84f19555
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT069.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3177
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So that drivers building on top can find those pins with GPIO_LOOKUP
helpers.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Simon Guinot <simon.guinot@sequanux.org>
Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/gpio/gpio-f7188x.c | 138 ++++++++++++++++++-------------------
 1 file changed, 69 insertions(+), 69 deletions(-)

diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
index 820ac5d60fda..c9b18c6d8464 100644
--- a/drivers/gpio/gpio-f7188x.c
+++ b/drivers/gpio/gpio-f7188x.c
@@ -162,10 +162,10 @@ static void f7188x_gpio_set(struct gpio_chip *chip, unsigned offset, int value);
 static int f7188x_gpio_set_config(struct gpio_chip *chip, unsigned offset,
 				  unsigned long config);
 
-#define F7188X_GPIO_BANK(_base, _ngpio, _regbase)			\
+#define F7188X_GPIO_BANK(_base, _ngpio, _regbase, _label)			\
 	{								\
 		.chip = {						\
-			.label            = DRVNAME,			\
+			.label            = _label,			\
 			.owner            = THIS_MODULE,		\
 			.get_direction    = f7188x_gpio_get_direction,	\
 			.direction_input  = f7188x_gpio_direction_in,	\
@@ -190,98 +190,98 @@ static int f7188x_gpio_set_config(struct gpio_chip *chip, unsigned offset,
 #define gpio_data_single(type)	((type) == nct6116d)
 
 static struct f7188x_gpio_bank f71869_gpio_bank[] = {
-	F7188X_GPIO_BANK(0, 6, 0xF0),
-	F7188X_GPIO_BANK(10, 8, 0xE0),
-	F7188X_GPIO_BANK(20, 8, 0xD0),
-	F7188X_GPIO_BANK(30, 8, 0xC0),
-	F7188X_GPIO_BANK(40, 8, 0xB0),
-	F7188X_GPIO_BANK(50, 5, 0xA0),
-	F7188X_GPIO_BANK(60, 6, 0x90),
+	F7188X_GPIO_BANK(0, 6, 0xF0, DRVNAME "-0"),
+	F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
+	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
+	F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
+	F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
+	F7188X_GPIO_BANK(50, 5, 0xA0, DRVNAME "-5"),
+	F7188X_GPIO_BANK(60, 6, 0x90, DRVNAME "-6"),
 };
 
 static struct f7188x_gpio_bank f71869a_gpio_bank[] = {
-	F7188X_GPIO_BANK(0, 6, 0xF0),
-	F7188X_GPIO_BANK(10, 8, 0xE0),
-	F7188X_GPIO_BANK(20, 8, 0xD0),
-	F7188X_GPIO_BANK(30, 8, 0xC0),
-	F7188X_GPIO_BANK(40, 8, 0xB0),
-	F7188X_GPIO_BANK(50, 5, 0xA0),
-	F7188X_GPIO_BANK(60, 8, 0x90),
-	F7188X_GPIO_BANK(70, 8, 0x80),
+	F7188X_GPIO_BANK(0, 6, 0xF0, DRVNAME "-0"),
+	F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
+	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
+	F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
+	F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
+	F7188X_GPIO_BANK(50, 5, 0xA0, DRVNAME "-5"),
+	F7188X_GPIO_BANK(60, 8, 0x90, DRVNAME "-6"),
+	F7188X_GPIO_BANK(70, 8, 0x80, DRVNAME "-7"),
 };
 
 static struct f7188x_gpio_bank f71882_gpio_bank[] = {
-	F7188X_GPIO_BANK(0, 8, 0xF0),
-	F7188X_GPIO_BANK(10, 8, 0xE0),
-	F7188X_GPIO_BANK(20, 8, 0xD0),
-	F7188X_GPIO_BANK(30, 4, 0xC0),
-	F7188X_GPIO_BANK(40, 4, 0xB0),
+	F7188X_GPIO_BANK(0, 8, 0xF0, DRVNAME "-0"),
+	F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
+	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
+	F7188X_GPIO_BANK(30, 4, 0xC0, DRVNAME "-3"),
+	F7188X_GPIO_BANK(40, 4, 0xB0, DRVNAME "-4"),
 };
 
 static struct f7188x_gpio_bank f71889a_gpio_bank[] = {
-	F7188X_GPIO_BANK(0, 7, 0xF0),
-	F7188X_GPIO_BANK(10, 7, 0xE0),
-	F7188X_GPIO_BANK(20, 8, 0xD0),
-	F7188X_GPIO_BANK(30, 8, 0xC0),
-	F7188X_GPIO_BANK(40, 8, 0xB0),
-	F7188X_GPIO_BANK(50, 5, 0xA0),
-	F7188X_GPIO_BANK(60, 8, 0x90),
-	F7188X_GPIO_BANK(70, 8, 0x80),
+	F7188X_GPIO_BANK(0, 7, 0xF0, DRVNAME "-0"),
+	F7188X_GPIO_BANK(10, 7, 0xE0, DRVNAME "-1"),
+	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
+	F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
+	F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
+	F7188X_GPIO_BANK(50, 5, 0xA0, DRVNAME "-5"),
+	F7188X_GPIO_BANK(60, 8, 0x90, DRVNAME "-6"),
+	F7188X_GPIO_BANK(70, 8, 0x80, DRVNAME "-7"),
 };
 
 static struct f7188x_gpio_bank f71889_gpio_bank[] = {
-	F7188X_GPIO_BANK(0, 7, 0xF0),
-	F7188X_GPIO_BANK(10, 7, 0xE0),
-	F7188X_GPIO_BANK(20, 8, 0xD0),
-	F7188X_GPIO_BANK(30, 8, 0xC0),
-	F7188X_GPIO_BANK(40, 8, 0xB0),
-	F7188X_GPIO_BANK(50, 5, 0xA0),
-	F7188X_GPIO_BANK(60, 8, 0x90),
-	F7188X_GPIO_BANK(70, 8, 0x80),
+	F7188X_GPIO_BANK(0, 7, 0xF0, DRVNAME "-0"),
+	F7188X_GPIO_BANK(10, 7, 0xE0, DRVNAME "-1"),
+	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
+	F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
+	F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
+	F7188X_GPIO_BANK(50, 5, 0xA0, DRVNAME "-5"),
+	F7188X_GPIO_BANK(60, 8, 0x90, DRVNAME "-6"),
+	F7188X_GPIO_BANK(70, 8, 0x80, DRVNAME "-7"),
 };
 
 static struct f7188x_gpio_bank f81866_gpio_bank[] = {
-	F7188X_GPIO_BANK(0, 8, 0xF0),
-	F7188X_GPIO_BANK(10, 8, 0xE0),
-	F7188X_GPIO_BANK(20, 8, 0xD0),
-	F7188X_GPIO_BANK(30, 8, 0xC0),
-	F7188X_GPIO_BANK(40, 8, 0xB0),
-	F7188X_GPIO_BANK(50, 8, 0xA0),
-	F7188X_GPIO_BANK(60, 8, 0x90),
-	F7188X_GPIO_BANK(70, 8, 0x80),
-	F7188X_GPIO_BANK(80, 8, 0x88),
+	F7188X_GPIO_BANK(0, 8, 0xF0, DRVNAME "-0"),
+	F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
+	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
+	F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
+	F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
+	F7188X_GPIO_BANK(50, 8, 0xA0, DRVNAME "-5"),
+	F7188X_GPIO_BANK(60, 8, 0x90, DRVNAME "-6"),
+	F7188X_GPIO_BANK(70, 8, 0x80, DRVNAME "-7"),
+	F7188X_GPIO_BANK(80, 8, 0x88, DRVNAME "-8"),
 };
 
 
 static struct f7188x_gpio_bank f81804_gpio_bank[] = {
-	F7188X_GPIO_BANK(0, 8, 0xF0),
-	F7188X_GPIO_BANK(10, 8, 0xE0),
-	F7188X_GPIO_BANK(20, 8, 0xD0),
-	F7188X_GPIO_BANK(50, 8, 0xA0),
-	F7188X_GPIO_BANK(60, 8, 0x90),
-	F7188X_GPIO_BANK(70, 8, 0x80),
-	F7188X_GPIO_BANK(90, 8, 0x98),
+	F7188X_GPIO_BANK(0, 8, 0xF0, DRVNAME "-0"),
+	F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
+	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
+	F7188X_GPIO_BANK(50, 8, 0xA0, DRVNAME "-3"),
+	F7188X_GPIO_BANK(60, 8, 0x90, DRVNAME "-4"),
+	F7188X_GPIO_BANK(70, 8, 0x80, DRVNAME "-5"),
+	F7188X_GPIO_BANK(90, 8, 0x98, DRVNAME "-6"),
 };
 
 static struct f7188x_gpio_bank f81865_gpio_bank[] = {
-	F7188X_GPIO_BANK(0, 8, 0xF0),
-	F7188X_GPIO_BANK(10, 8, 0xE0),
-	F7188X_GPIO_BANK(20, 8, 0xD0),
-	F7188X_GPIO_BANK(30, 8, 0xC0),
-	F7188X_GPIO_BANK(40, 8, 0xB0),
-	F7188X_GPIO_BANK(50, 8, 0xA0),
-	F7188X_GPIO_BANK(60, 5, 0x90),
+	F7188X_GPIO_BANK(0, 8, 0xF0, DRVNAME "-0"),
+	F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
+	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
+	F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
+	F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
+	F7188X_GPIO_BANK(50, 8, 0xA0, DRVNAME "-5"),
+	F7188X_GPIO_BANK(60, 5, 0x90, DRVNAME "-6"),
 };
 
 static struct f7188x_gpio_bank nct6116d_gpio_bank[] = {
-	F7188X_GPIO_BANK(0, 8, 0xE0),
-	F7188X_GPIO_BANK(10, 8, 0xE4),
-	F7188X_GPIO_BANK(20, 8, 0xE8),
-	F7188X_GPIO_BANK(30, 8, 0xEC),
-	F7188X_GPIO_BANK(40, 8, 0xF0),
-	F7188X_GPIO_BANK(50, 8, 0xF4),
-	F7188X_GPIO_BANK(60, 8, 0xF8),
-	F7188X_GPIO_BANK(70, 1, 0xFC),
+	F7188X_GPIO_BANK(0, 8, 0xE0, DRVNAME "-0"),
+	F7188X_GPIO_BANK(10, 8, 0xE4, DRVNAME "-1"),
+	F7188X_GPIO_BANK(20, 8, 0xE8, DRVNAME "-2"),
+	F7188X_GPIO_BANK(30, 8, 0xEC, DRVNAME "-3"),
+	F7188X_GPIO_BANK(40, 8, 0xF0, DRVNAME "-4"),
+	F7188X_GPIO_BANK(50, 8, 0xF4, DRVNAME "-5"),
+	F7188X_GPIO_BANK(60, 8, 0xF8, DRVNAME "-6"),
+	F7188X_GPIO_BANK(70, 1, 0xFC, DRVNAME "-7"),
 };
 
 static int f7188x_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
-- 
2.35.1

