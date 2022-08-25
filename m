Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926DB5A0E2C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241162AbiHYKos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbiHYKom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:44:42 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2082.outbound.protection.outlook.com [40.107.105.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7B8AA36F;
        Thu, 25 Aug 2022 03:44:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJKGyGWhLq07tyX33t4RBaVfJwxc8iwHtgLcaJZQtiXR8fQTM+bCnjrIk5XAQhn9BX98glyYTakH2KtkrU09KajPq+GouuXUunWLe3BCnbqPnzOEAlR6WQ8mIYsGu7QhCxfbwL6xG+1WMATTT6LVGjDFQcOSg6VxkqTePREe4xUO4uRJHDXIH1faBDKHHiZ41k+brqOCGDwCmWb2MhlTe/XrgHIBoBUMUqs9LjTMU16Q3SessxBlsxUGLoRMh18D4M4UFJi+0MxPhTYvMz/L6XWYUll6eZm+5ogNx1KdUb6S3RCv1ix+93v4CuqwtbOShwWSTQXd8FCoEFQ3LWyINQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRCBzMP08a86QV3+iQNYbEM8PajRVQlJ5OjM+5s9UyE=;
 b=XrLi4s60jM2bY5foeWfMa+/U4iLBYp2BNlLlPyConcUyY82pgjDWLI/WBxmcoWmfZC7FnhOGu94RFGJEVJ6G3KjJ+xY3ojUiOsK9A/Jqo2JD5mwfXFGf2coWyuZ+EXjoh2tJLPTv/aFFLndR54ZzUB3I5QMh4t/1lZY2vaKzPCg4FOyoS2JIzLBEKsGkBmaGNcIB1Z/66F/2KAvT7s5ryrDrS49s85r5t3i/y+UZ/KWGyCMyyzLgIILVt+eIWRppDIL7xUH5bOTmiUhKryWgYMa95uXMJXd1cJcZoRGZDZDZW7IZiboXm+fiMgDQ0suoo51tXg38lqQXUV3oDf5Nsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.75) smtp.rcpttodomain=linaro.org smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRCBzMP08a86QV3+iQNYbEM8PajRVQlJ5OjM+5s9UyE=;
 b=rWLJW9jHovO080fCEu+UMuIuJ/XtgB7QAjMGE8C5IY+F0cXGupdYZe2PZDiPsCWwxjQ+GHqQTmQEUbyMgZWxX2bY0NLWALrO3qYkpE9oIkxWpEUHfJtZSDsUVylPw19a2VhcpU0xBlUwXhPLcY+pCmz5IOO5s6VTYlFt8iHyMApiur6uHwMBkanXw8GTAxWJpAclN5ZM/JCzIoT6laQbMWshsZiMZKbc5cFRH4ir9VI5qdfMLgDPeFhiTkw+XnTQ0stbcJUo0+PM+m6fooUeoExx2kXTE1rPH/QeNCwhmuSrBlQt3WWM3CvPz/1kaL3B8edqD7bJ3Mw9zwjDS0jfkg==
Received: from AS4P192CA0026.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::10)
 by PA4PR10MB4511.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:105::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Thu, 25 Aug
 2022 10:44:39 +0000
Received: from VE1EUR01FT086.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:5e1:cafe::19) by AS4P192CA0026.outlook.office365.com
 (2603:10a6:20b:5e1::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Thu, 25 Aug 2022 10:44:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT086.mail.protection.outlook.com (10.152.2.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15 via Frontend Transport; Thu, 25 Aug 2022 10:44:38 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Thu, 25 Aug 2022 12:44:37 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.0.80) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 25 Aug 2022 12:44:36 +0200
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
Subject: [PATCH v6 1/7] gpio-f7188x: switch over to using pr_fmt
Date:   Thu, 25 Aug 2022 12:44:16 +0200
Message-ID: <20220825104422.14156-2-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220825104422.14156-1-henning.schild@siemens.com>
References: <20220825104422.14156-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.0.80]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--11.376600-8.000000
X-TMASE-MatchedRID: +czlWKbBGYFzI+dG37rJkJZVmFGg61XXBZzfOdtebLR08zy97KsgJnFa
        /hQHt1A1Yy6fApvL8BdAHOg8qEtqyCp6C6A3Owl9/loNwYTKhKGoXh0SiGjEzEeDzzDviY0OTFQ
        nI+epPIYda1Vk3RqxOL7MIEVzBlttgTMB89obbzHU1g4lO1dF7W31FZ8LNR0ExVQFfLw4zf+MwE
        e0REwvkOZMicrOlIVJWZ5SeHs/EKwSREDsWlFRcPy6tSSuZMgS921KMlA7Vdon6YVq3MQsI3oCB
        x19i+GMmyiLZetSf8mfop0ytGwvXiq2rl3dzGQ1u/SjjL7lkPOD7WkSJoQpshWUI90Y/2jE2n3G
        Kv1+wijdr1MDrcCkeA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.376600-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: CE4F6D7C5BC5F49D0DA48FF424D65095871529BC38358A62C99638AA9F96A8272000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e459f4f-4a40-4467-7aa4-08da8686cf0e
X-MS-TrafficTypeDiagnostic: PA4PR10MB4511:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cm5r2E5MslHm2OQev0XyToRHvcqfKvs0TH/RxeTkgePjUlsYr+qsXENnC1MMMppBftAbS777GWX2zDSQM7dZ0QABAY7c2EbjF1SPkRjIFBUNMsJBO89qaToXBkIIMq9g+6F/WFp/kC30iz65HeUolJ2ilFnRhxVUvhmQphTkXtl4brf+Zudy4DdJU51FaEgjjlxoUonLQfiORrRAF7FwTlPoOmxr0X4LfqUNqF9hb1WzCSQagxqydhOsg6Sj1VYU1bZ89xPo90sR79pmBXL8STrvoxlgge9ZOx5EG4GMxlKyu7N5IFQR3KrKBE4xQ4W5oGuAndn2IZ+5b2ZYq9Pu5UnYQgeAbnkB98GSBo8Bwsj9cNB2dCJM7ophTmjun3mm2ZvQzApdr8Y3hsXCOGE6h6QHLkTb0HTDgefLio0ng58geOuvHsrtIpDJlu1xxwejoJVaxGBVIgAi3NFaFVboZFCDzDr2jljZctS/SPaSlQPejl7Bw3kskwgXTkRCwvbr+dJUVfF4JcAs18JrHJIfRGsWRfmuPwRA/+XemYVEzK4eggnnO1KPGriiRF7ngWTjP91F/BNK6tDZShhr/ccAVJOdzW3H2cZ5LYtw12MHgb6v7BB7Q28CB4FKKhkG5tTJ9PXNSJDCTWhK36G34+y0WKt2kuAweULP9Lml2GW4Rwz6OZByQp7SaUNl4dJqNhJNNYa5lHkBW/aoDjQSjn54g3wZOpCH+S3elkXojhSH8RvAvmPb2dQ8Q99mgpRjQchxq58WPuIozElyWXBNABWQ6FAQGhL3OvMM+el6JFIMKPwJSdzaR5fQjeg6zK3PZcGmF19DE8DD9ybDmU8IQBBuNkp1evK7f77pj4r5NyuQDdlQHzdC7J0LnouKezZsOP81
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(376002)(136003)(36840700001)(40470700004)(46966006)(6666004)(54906003)(41300700001)(8936002)(5660300002)(110136005)(36756003)(82310400005)(107886003)(316002)(40460700003)(478600001)(44832011)(7416002)(8676002)(70586007)(4326008)(70206006)(40480700001)(2616005)(956004)(1076003)(336012)(16526019)(26005)(47076005)(2906002)(83380400001)(86362001)(356005)(36860700001)(921005)(81166007)(82960400001)(82740400003)(186003)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 10:44:38.3293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e459f4f-4a40-4467-7aa4-08da8686cf0e
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT086.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4511
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subsequent patches will touch that file, apply some nice to have style
changes before actually adding functional changes.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/gpio/gpio-f7188x.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
index 18a3147f5a42..fef539bbc03a 100644
--- a/drivers/gpio/gpio-f7188x.c
+++ b/drivers/gpio/gpio-f7188x.c
@@ -7,6 +7,9 @@
  * Author: Simon Guinot <simon.guinot@sequanux.org>
  */
 
+#define DRVNAME "gpio-f7188x"
+#define pr_fmt(fmt) DRVNAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -14,8 +17,6 @@
 #include <linux/gpio/driver.h>
 #include <linux/bitops.h>
 
-#define DRVNAME "gpio-f7188x"
-
 /*
  * Super-I/O registers
  */
@@ -110,7 +111,7 @@ static inline int superio_enter(int base)
 {
 	/* Don't step on other drivers' I/O space by accident. */
 	if (!request_muxed_region(base, 2, DRVNAME)) {
-		pr_err(DRVNAME "I/O address 0x%04x already in use\n", base);
+		pr_err("I/O address 0x%04x already in use\n", base);
 		return -EBUSY;
 	}
 
@@ -487,7 +488,7 @@ static int __init f7188x_find(int addr, struct f7188x_sio *sio)
 	err = -ENODEV;
 	devid = superio_inw(addr, SIO_MANID);
 	if (devid != SIO_FINTEK_ID) {
-		pr_debug(DRVNAME ": Not a Fintek device at 0x%08x\n", addr);
+		pr_debug("Not a Fintek device at 0x%08x\n", addr);
 		goto err;
 	}
 
@@ -518,13 +519,13 @@ static int __init f7188x_find(int addr, struct f7188x_sio *sio)
 		sio->type = f81865;
 		break;
 	default:
-		pr_info(DRVNAME ": Unsupported Fintek device 0x%04x\n", devid);
+		pr_info("Unsupported Fintek device 0x%04x\n", devid);
 		goto err;
 	}
 	sio->addr = addr;
 	err = 0;
 
-	pr_info(DRVNAME ": Found %s at %#x, revision %d\n",
+	pr_info("Found %s at %#x, revision %d\n",
 		f7188x_names[sio->type],
 		(unsigned int) addr,
 		(int) superio_inb(addr, SIO_DEVREV));
@@ -548,13 +549,13 @@ f7188x_gpio_device_add(const struct f7188x_sio *sio)
 	err = platform_device_add_data(f7188x_gpio_pdev,
 				       sio, sizeof(*sio));
 	if (err) {
-		pr_err(DRVNAME "Platform data allocation failed\n");
+		pr_err("Platform data allocation failed\n");
 		goto err;
 	}
 
 	err = platform_device_add(f7188x_gpio_pdev);
 	if (err) {
-		pr_err(DRVNAME "Device addition failed\n");
+		pr_err("Device addition failed\n");
 		goto err;
 	}
 
-- 
2.35.1

