Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8124159FCAA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238353AbiHXOEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237109AbiHXOED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:04:03 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130077.outbound.protection.outlook.com [40.107.13.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C019C86047;
        Wed, 24 Aug 2022 07:04:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYb1K/R0mn6JQYuI1/Rcyeh4pFnkDlUYmAdtzNCEIwC05jRPyueDNrDJ/Az8TR2HQKLYRaMy8ZkZqaGiQJ6qJm0qjiYSL4AttG3lOlSLsMaYoTNqR66ys9B3ztxSYYIUf/V8U/ManhlCxyDgOYyVyCLkmOz/SUZJ2T2fBoGcZD54oHGOPSuq8jf6yw4pytQmEgAmlTfi1AbOkri5SONCkLpW7tTAOaFMJ0WylN3707VtavGAONKrGx/+IEx+5vEbgS1FMnsIT5uVsUo87+qVx/kJ3dtv8iE73wx4sZu/xZ5qp5EmeP/Str3iZa/3x0U+xwVpuWb4RSb7ZddBMkiTQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAdhPMocuYIFDzOXVOIhxiwfy7Lh+/B542eZ9Qc3eiU=;
 b=Se1DUSVBqxQIC6oknV5y7nov+ua3YEEqg6DnhJZgARAmI9oHH17jp2mSWIkJ53mN3MO1DceIPl+APoNDeDSIxCNKzrwVv1vRIPGDHFs2ZsqxqpGB8AoKHYZ56I1J5oUAhMY5fzqahZlBWtuNtuiUw9amc8NTIReenizRz8JZCZYoQtAkt401p/EytLbXIhwYprEZjQDE4a99VOTvHCP5jNd8WIS7J3buhU7dMZw832M7TgN+oRfYLtCRxs3Gy4ZN3fYl5K0PDcjbfdEwwD3uvxCW9R5JX/bVvZ82KQERPop8geExrHVXyVesZBXGOU1+yY4MWDywmVwWZH5YQXASeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.75) smtp.rcpttodomain=linaro.org smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAdhPMocuYIFDzOXVOIhxiwfy7Lh+/B542eZ9Qc3eiU=;
 b=jsC0OjzRzMEEwgg9o//BB/AsNbMpkAuoAz0qhldKKeqGeq/wEj2irXHFLa9JD6JFpofnHSgu0p6dERkWhDtT6bWeqKJ43cKdAv5ar+8ZX3w4YT+9ZcVKwB+nZ3NcYwGszi4afnaCuSUqk8L8pH6xAmgBPvr9QD3SNuiFy1XaS+nnoeeYCuRtln5H86WvOAtEHZQxJ/N1FWrlx5XCPu/yy1plJh74cEXAR17HpKBliRtxcWKfTXft54+ve+7zjbFzRrYs7CuXNAkl3bbgrshk8VhDaiaIMYR3EWRJsXbLIIPJMYHw6UFIq+KJ6KTF80N1xUjkAVHtxXD1+SpgzG4wiA==
Received: from GV3P280CA0052.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::6) by
 GV1PR10MB6010.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.16; Wed, 24 Aug 2022 14:03:59 +0000
Received: from HE1EUR01FT025.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:9:cafe::7f) by GV3P280CA0052.outlook.office365.com
 (2603:10a6:150:9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16 via Frontend
 Transport; Wed, 24 Aug 2022 14:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.75) by
 HE1EUR01FT025.mail.protection.outlook.com (10.152.0.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15 via Frontend Transport; Wed, 24 Aug 2022 14:03:58 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Wed, 24 Aug 2022 16:03:58 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.0.80) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Wed, 24 Aug 2022 16:03:58 +0200
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
Subject: [PATCH v5 2/5] gpio-f7188x: use unique labels for banks/chips
Date:   Wed, 24 Aug 2022 16:03:44 +0200
Message-ID: <20220824140347.1842-3-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220824140347.1842-1-henning.schild@siemens.com>
References: <20220824140347.1842-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.0.80]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--9.309700-8.000000
X-TMASE-MatchedRID: D+XfgODzmzordWdGoKfUymdUGQPHutoBOT0VlJjRfnH27WtDgGBc8tGO
        cAfHKa6uB2QWi8BF5ShpRezoWC5XLXFnQp1moK9xjO5iMKbqS0z7XyLXPDdLs6chFrOB9kanCy8
        7Unb7MRibKItl61J/yZ+inTK0bC9eKrauXd3MZDVENTKcqcJOap8S2Wughs08CwBu4RolLn4r79
        Ggi/FvwJ6EY745USl+
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.309700-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 11880E53CE8DC5DC6E99F7093A5821D6EE537A25DA6431365C0FCD49B2BEE4D82000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bcaf5a5-3414-4414-f6eb-08da85d97db1
X-MS-TrafficTypeDiagnostic: GV1PR10MB6010:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eETL5gGlDCkrDBph7ywbD0qY39OrtUeNl/ILrURgA4RkY+DRwHoyQxqxTZoI5uV8TJSCY9m7lNWfk7FR3MkVFNh12E1Ke/jZ6XCKW3RptBCNK3ghsTdlX3Er4VPoris2h60PfwEymdzwlQ5EOPeMkDdQFnvTGReNBpRVtOFEFd/LYWOHFQ8LTdl5Jl6g+nrg8Lmp+fh7ApqjjDiVWru6I5jfVUQ2jeGrt93/2RVv8KSI0CU3hB4c6RvYjRvb/vQ3Ae20bRcF/2ucRcTASEzNgt7Qth4BoxRBQhaKN49lnmTfNuZi8raWLGYTtZXys+KWcIMCtvfGOu7LuPTD8al1e46YRGli+8Ik61KqPrGzfL1Zk9ih6rrrA1/Dr/c1SwNSlsynRJPcZw/TwwOrVoA2Z83Ywt8bMtYY1/9T1yJ2slH75fBZHVgkRbFNRphWof0wC2/UKmuDWGJgaEP0wUYGwJusdLs5Wh3yb9iipT3GVYKQdv7x1Cx/kCz8lBumRBN+C6PGowaaQXAE8+0jTw3eVbM4FPpm44E6GcR0Lw+s3Ti/YS9pNJ+/qDxMFpFRESKw6oh+0S+z25HTWoLliP2jBZsjSkoaeJNwutTi+zdbdi9US2eaKZ6dIvj1VHG5yq0aqML1m2nwMb1hKnQ+wUkibypQB/llCrHwVvPb9/YYa5GXtb9DZqzzZBhKiwJ45stDVpoN+yfbYe7odlFmxYmmPLeNC1A460j1aRZDOxExHPS+6GZp0lthVZ8DkZbRY81nrdWmX1wRhqrjp38BpPG01GZ3XnruR+RTeVZJHWF3l02ldHLOT7WiUw2O8ibLLvjansjjl+4ya1G6X1cAMnmxSQGxGgdP6YasYjSYbnHi9esSf+pYIoOl/gTVOQ1bJ3+8W+8CNXwZL/zlnKLaagTkCw==
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(346002)(376002)(40470700004)(46966006)(36840700001)(921005)(5660300002)(6666004)(8936002)(86362001)(2906002)(82960400001)(44832011)(36756003)(26005)(40460700003)(478600001)(110136005)(356005)(54906003)(7416002)(81166007)(316002)(82740400003)(40480700001)(34020700004)(41300700001)(36860700001)(4326008)(336012)(16526019)(83380400001)(186003)(956004)(1076003)(2616005)(70586007)(107886003)(8676002)(82310400005)(47076005)(70206006)(83996005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 14:03:58.8620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bcaf5a5-3414-4414-f6eb-08da85d97db1
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT025.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6010
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

So that drivers building on top can find those pins with GPIO_LOOKUP
helpers.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Simon Guinot <simon.guinot@sequanux.org>
Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/gpio/gpio-f7188x.c | 138 ++++++++++++++++++-------------------
 1 file changed, 69 insertions(+), 69 deletions(-)

diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
index b73bf28bf347..565840586150 100644
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

