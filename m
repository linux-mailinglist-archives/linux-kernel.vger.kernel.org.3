Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F975A0E28
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241139AbiHYKop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiHYKom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:44:42 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80040.outbound.protection.outlook.com [40.107.8.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180F0AA374;
        Thu, 25 Aug 2022 03:44:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcOsnsdlP17j4eJOgskxVSo18M6NJCK5RCRQ9hlpAg0FIW8psS8pbCRNtCjIcOccMZeApjed4aSqXofKPEKYhpMBj6INrPXRl5amstpiKxEUOaoVn8wTAEVaodp4eMckazF9Su/tn/bMjxDNdKB54HtccKB2YxlPZg66DTNmuyFc0phG90AA0IwHGMOCyEEjYoLojReI9m+yLyXp3jcImoKCwJxsGKYtd/FQcHC5yxStbOEEkVc0A60pjWCEOK6RpXbCd2HJyXdJh0vX6oa5LA0zIz2PiTNxy0dCMiLjfD8nxg+IWb5UBCP+sX3ijR9E7M1IytI0+9CJM5dlDB6p4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZETyLlyBKcILdLFZEJbVrPryecl4Hv+yog2b3jg6uCE=;
 b=JZX/GozJMQPRpgYnC71Md7p0U46dpvSWGSt1TdoJcuQbepltlfP2MaIEReXkcYVtbOlPZtMzSQ3DB5F1G6+L+44eFnPZpkvL/IRe7GnIEMrCenMDVPG2r7sK6M4HCbCXffoutnz8DJqbGwjleDIA3ItIOfFPzZDKkpEov50uEabE7M0SpojCJcOAjUUEw8kv1o83Bd/YdA9xAzC+I0HbuLGje5x0jyAewdlI5mlLwuwGvSQ3ljt5uuakGnPJ1H5H9T0GRc4wtmCuepnYoEPcsUQL/bWR6xbBHOZbjFsBhai6T54kcTnHIj0wOMnood8THIpPjmplQHjRa9ww3W2iuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.76) smtp.rcpttodomain=linaro.org smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZETyLlyBKcILdLFZEJbVrPryecl4Hv+yog2b3jg6uCE=;
 b=htIPzo3jV0jDbXB07GW6nGc1X0GojYDvSCrHiMJ7kAR1VSSrym1dVt0+/+VuIGQazJmDmWTYrQAbjYwSzCUq0VboEB1XgeeT9zghPKd08tD999DElIz6aEbqh18RQp7qV9bKAHDCn/MqtSHCQXlx2kz578pZDXgrz5ZtW20bmUixAme8iu91rRJzw+xJyL1l9YPbi6oNzM+a/hffJRf/GdSV+E29E1Q+uYl6FHgv6jR6s6DxPqpmwx+RZfbj/WsLZzuI+/PA9bc9NfSdZSzQP4hV65behj5Rv1nyKA8cx4aDXnq6AT/ZWo63cq/mlyKBT9vzLZsg0IocrYfmDPyAFQ==
Received: from OL1P279CA0015.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:12::20)
 by VE1PR10MB3952.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:168::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 10:44:37 +0000
Received: from HE1EUR01FT086.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:12:cafe::c7) by OL1P279CA0015.outlook.office365.com
 (2603:10a6:e10:12::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Thu, 25 Aug 2022 10:44:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.76) by
 HE1EUR01FT086.mail.protection.outlook.com (10.152.1.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15 via Frontend Transport; Thu, 25 Aug 2022 10:44:37 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Thu, 25 Aug 2022 12:44:36 +0200
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
Subject: [PATCH v6 2/7] gpio-f7188x: add a prefix to macros to keep gpio namespace clean
Date:   Thu, 25 Aug 2022 12:44:17 +0200
Message-ID: <20220825104422.14156-3-henning.schild@siemens.com>
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
X-TM-AS-Result: No-10--10.255400-8.000000
X-TMASE-MatchedRID: MWbpXFXsFA5zI+dG37rJkJZVmFGg61XXBZzfOdtebLR08zy97KsgJnFa
        /hQHt1A1Yy6fApvL8BdAHOg8qEtqyI+pAn19BHXOybpNH7+LubuplamT4YpFU5XIRfiL5JZTuaL
        iYlmqWfdRl9RGGk4QA+GSO/vwd6PhaUkFFARetjGAMuqetGVetnyef22ep6XYOwBXM346/+wmcp
        slEXGWqV+Z7nYsdNhzkRi5ABIRNlyTI7BQVR47eoEXinL0Onln
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.255400-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: EDC9E1C0F0347AFD1EA1E08E30DDEC91D36732885E9F307F01131F7C59764DB72000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbeea725-9e2e-4b17-45e3-08da8686ce96
X-MS-TrafficTypeDiagnostic: VE1PR10MB3952:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E9o29YtSCCcg2n4RxgHTzsVh9iYeRHnkM+h4oAfq+3rynwk6hd1iVJQ31PgSuPtSBPCzCNRmoBdFrz/gHAzqN81nBhVT/NoqjfpYgIu3lxQRXnS0iEwJSjbx0QLjEG1OivVBxxtyAeoWyvLZipvMcV3DwMGv1pnjehb+2nkX2+bf4/3J/YFClk6MJ5XTBG9LUYti1XsZOkQR3VznHXI9mHKeoBwjUetHbC5hL9Z2bxd64SuGVN5tqX6s1BaTmXJTuhnNFywbfyyPlsLZhu0ySCni4njz2TKFCd5M7vwvaInPMq90nefg29/DlqvU5znCRLefh4Hnz8niCL2P6iXbu7Oz1KGFopWBH7ykZHpH9HKePeqZCCzAPzPxs5mK4p84PJmCA7pYn7N4Y9PMnIO0m+w2vruzDPvn7aOBseB7Nq4BTKR1TvzhIfr0lqKegsg6A8Vilxzt3X+jnROWKGlVUcTLq2cYuHTJDpqeOyo0QZZlL0MkvrbBcw6JHRLAxr/V66HgvbEeMdkALfs72atFesDLy9sPh7GUabj3rcSzUqTTnDEzhxF/TQx6lXUoKmPV/2xfKprAjVY9rsHQjgRhBMLAa3Byqt/segyxH+vI6TqxJ/5Zp1ICEm27n0IA67W/YAwqouEKxy1Tr4xjb6zkbb138QCxsQCwuK//RO8pFVYUofVlcx6WK9LwwY0eqFWuiRmeJOYSUn4Q8mXAabQOn+qqISP7XYDBakkvZRA9SXiXTq37K9pV8jZwEtB2bGcx8JWiQ0CXDard/B7COanni1t9H80Impki7GxZNMAMsUwtx+lx71n3dxS33nERhHrHF4iSDk0dSDwqVsSdrlu4HJNz3Iwz4Od1v6vjJDKxNybYnY/F0c2T6X5ImnLhSvq+
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(376002)(39860400002)(136003)(40470700004)(36840700001)(46966006)(36860700001)(82740400003)(86362001)(82960400001)(81166007)(356005)(54906003)(40460700003)(70586007)(70206006)(921005)(316002)(2906002)(110136005)(44832011)(8936002)(7416002)(5660300002)(8676002)(4326008)(83380400001)(2616005)(82310400005)(47076005)(956004)(1076003)(336012)(186003)(478600001)(16526019)(26005)(40480700001)(6666004)(107886003)(41300700001)(36756003)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 10:44:37.5037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbeea725-9e2e-4b17-45e3-08da8686ce96
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT086.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3952
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

Subsequent patches will touch that file, apply some nice to have style
changes before actually adding functional changes.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/gpio/gpio-f7188x.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
index fef539bbc03a..878458249833 100644
--- a/drivers/gpio/gpio-f7188x.c
+++ b/drivers/gpio/gpio-f7188x.c
@@ -165,11 +165,11 @@ static int f7188x_gpio_set_config(struct gpio_chip *chip, unsigned offset,
 		.regbase = _regbase,					\
 	}
 
-#define gpio_dir(base) (base + 0)
-#define gpio_data_out(base) (base + 1)
-#define gpio_data_in(base) (base + 2)
+#define f7188x_gpio_dir(base) ((base) + 0)
+#define f7188x_gpio_data_out(base) ((base) + 1)
+#define f7188x_gpio_data_in(base) ((base) + 2)
 /* Output mode register (0:open drain 1:push-pull). */
-#define gpio_out_mode(base) (base + 3)
+#define f7188x_gpio_out_mode(base) ((base) + 3)
 
 static struct f7188x_gpio_bank f71869_gpio_bank[] = {
 	F7188X_GPIO_BANK(0, 6, 0xF0),
@@ -267,7 +267,7 @@ static int f7188x_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
 		return err;
 	superio_select(sio->addr, SIO_LD_GPIO);
 
-	dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
+	dir = superio_inb(sio->addr, f7188x_gpio_dir(bank->regbase));
 
 	superio_exit(sio->addr);
 
@@ -289,9 +289,9 @@ static int f7188x_gpio_direction_in(struct gpio_chip *chip, unsigned offset)
 		return err;
 	superio_select(sio->addr, SIO_LD_GPIO);
 
-	dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
+	dir = superio_inb(sio->addr, f7188x_gpio_dir(bank->regbase));
 	dir &= ~BIT(offset);
-	superio_outb(sio->addr, gpio_dir(bank->regbase), dir);
+	superio_outb(sio->addr, f7188x_gpio_dir(bank->regbase), dir);
 
 	superio_exit(sio->addr);
 
@@ -310,12 +310,12 @@ static int f7188x_gpio_get(struct gpio_chip *chip, unsigned offset)
 		return err;
 	superio_select(sio->addr, SIO_LD_GPIO);
 
-	dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
+	dir = superio_inb(sio->addr, f7188x_gpio_dir(bank->regbase));
 	dir = !!(dir & BIT(offset));
 	if (dir)
-		data = superio_inb(sio->addr, gpio_data_out(bank->regbase));
+		data = superio_inb(sio->addr, f7188x_gpio_data_out(bank->regbase));
 	else
-		data = superio_inb(sio->addr, gpio_data_in(bank->regbase));
+		data = superio_inb(sio->addr, f7188x_gpio_data_in(bank->regbase));
 
 	superio_exit(sio->addr);
 
@@ -335,16 +335,16 @@ static int f7188x_gpio_direction_out(struct gpio_chip *chip,
 		return err;
 	superio_select(sio->addr, SIO_LD_GPIO);
 
-	data_out = superio_inb(sio->addr, gpio_data_out(bank->regbase));
+	data_out = superio_inb(sio->addr, f7188x_gpio_data_out(bank->regbase));
 	if (value)
 		data_out |= BIT(offset);
 	else
 		data_out &= ~BIT(offset);
-	superio_outb(sio->addr, gpio_data_out(bank->regbase), data_out);
+	superio_outb(sio->addr, f7188x_gpio_data_out(bank->regbase), data_out);
 
-	dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
+	dir = superio_inb(sio->addr, f7188x_gpio_dir(bank->regbase));
 	dir |= BIT(offset);
-	superio_outb(sio->addr, gpio_dir(bank->regbase), dir);
+	superio_outb(sio->addr, f7188x_gpio_dir(bank->regbase), dir);
 
 	superio_exit(sio->addr);
 
@@ -363,12 +363,12 @@ static void f7188x_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 		return;
 	superio_select(sio->addr, SIO_LD_GPIO);
 
-	data_out = superio_inb(sio->addr, gpio_data_out(bank->regbase));
+	data_out = superio_inb(sio->addr, f7188x_gpio_data_out(bank->regbase));
 	if (value)
 		data_out |= BIT(offset);
 	else
 		data_out &= ~BIT(offset);
-	superio_outb(sio->addr, gpio_data_out(bank->regbase), data_out);
+	superio_outb(sio->addr, f7188x_gpio_data_out(bank->regbase), data_out);
 
 	superio_exit(sio->addr);
 }
@@ -391,12 +391,12 @@ static int f7188x_gpio_set_config(struct gpio_chip *chip, unsigned offset,
 		return err;
 	superio_select(sio->addr, SIO_LD_GPIO);
 
-	data = superio_inb(sio->addr, gpio_out_mode(bank->regbase));
+	data = superio_inb(sio->addr, f7188x_gpio_out_mode(bank->regbase));
 	if (param == PIN_CONFIG_DRIVE_OPEN_DRAIN)
 		data &= ~BIT(offset);
 	else
 		data |= BIT(offset);
-	superio_outb(sio->addr, gpio_out_mode(bank->regbase), data);
+	superio_outb(sio->addr, f7188x_gpio_out_mode(bank->regbase), data);
 
 	superio_exit(sio->addr);
 	return 0;
-- 
2.35.1

