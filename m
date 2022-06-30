Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D9056191A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbiF3L1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbiF3L0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:26:55 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80132.outbound.protection.outlook.com [40.107.8.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F9451B01
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 04:26:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtOJAwCmkmolhFRbv5fPndeggNXnhMxJJGiqDJU+5js+0euMaWT4gCVFz7R17Sfwgn6UJ9jGz2S8ufT9iuP+JnVb5UYXXup5EJfz/ba+P3yaF0scDSnSpY3oekKdioFxyPB9huFazzyJgy6f17g6fYzMGg+qiupWsm04Oe836+M0l6ATAX74TX0mFVTT4QKIwP8KymUnnPHkdunP2UOFCrleYES11eaczyAwjRCF4I9VvzUfhgmNQnjKM8dbols9D7rW9vLoP7hw6pvSbPzcax9heIGZXukTPcfLtV+LqDdNNgMtUGcfA55FtzV+ASO2i62/nddtH3YKnDcC9J9XNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBoqQdldwLxm6xGosR/c3weD34Tuv/BI7y3illi6dF8=;
 b=dkFMq8nZtD3/F/Hlid9ISHF2m5czDJI41b3sh/KTJ2DP6HhHWtArRUqbSUQWK6OHpO5/Xzw7W5/ZPdEyoHatgHsRMiQis0mkNN468rRf0+Smji0x/vP1HylH6ZtFcL8n6GheTqp5DN1C6CBlePs5EVZIMDcd+2F28/4r8n+v5Id0SzQewPNxRepQotIuhwpH3d9LAVs4rZnqxN+yEOnwu8HCFjswPEzlg7Dq8VUUWRx6rP+ItCGNjP9MmTbecoPI5/vBVnR5PwVuanGjm1JjNUCUcDw+U8qCd3HbFHLuKiypLM3tbz22lnOrhckVm17FOnSnBYyDggR/wrxTNxKuXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.159.232.72) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=bbl.ms.philips.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=bbl.ms.philips.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Philips.onmicrosoft.com; s=selector2-Philips-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBoqQdldwLxm6xGosR/c3weD34Tuv/BI7y3illi6dF8=;
 b=NnFj+g8nybwALALKaSxWIzU7jFYmmjcUUyQIuloZWcTS8+A0kQYs559LKj2JNycJxAlqiF52skikpuoSiXdq9fnTV8Lhblz2mhLf8MeDSquoxfcoOXHmEUjwnY+k6NEceydsqNLJLK4l5WCIcWIa+SLD8GsUFJ5iZk5XLosE2iY=
Received: from DBBPR09CA0031.eurprd09.prod.outlook.com (2603:10a6:10:d4::19)
 by DB7P122MB0170.EURP122.PROD.OUTLOOK.COM (2603:10a6:10:94::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.22; Thu, 30 Jun
 2022 11:26:52 +0000
Received: from DB5EUR01FT085.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:d4:cafe::77) by DBBPR09CA0031.outlook.office365.com
 (2603:10a6:10:d4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17 via Frontend
 Transport; Thu, 30 Jun 2022 11:26:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.159.232.72)
 smtp.mailfrom=bbl.ms.philips.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bbl.ms.philips.com;
Received-SPF: Pass (protection.outlook.com: domain of bbl.ms.philips.com
 designates 212.159.232.72 as permitted sender)
 receiver=protection.outlook.com; client-ip=212.159.232.72;
 helo=ext-eur1.smtp.philips.com; pr=C
Received: from ext-eur1.smtp.philips.com (212.159.232.72) by
 DB5EUR01FT085.mail.protection.outlook.com (10.152.5.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 11:26:51 +0000
Received: from smtprelay-eur1.philips.com ([130.144.57.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
        (Client did not present a certificate)
        by ext-eur1.smtp.philips.com with ESMTP
        id 6kPmoelKMl9Zi6sJvoXdVP; Thu, 30 Jun 2022 13:26:51 +0200
Received: from mail.bbl.ms.philips.com ([130.143.87.230])
        by smtprelay-eur1.philips.com with ESMTP
        id 6sJvodLaMBXNN6sJvoZUwr; Thu, 30 Jun 2022 13:26:51 +0200
X-CLAM-Verdict: legit
X-CLAM-Score: ??
X-CLAM-Description: ??
Received: from bbl2xr12.bbl.ms.philips.com (bbl2xr12.bbl.ms.philips.com [130.143.222.238])
        by mail.bbl.ms.philips.com (Postfix) with ESMTP id 92C3A1833DC;
        Thu, 30 Jun 2022 13:26:51 +0200 (CEST)
Received: by bbl2xr12.bbl.ms.philips.com (Postfix, from userid 1876)
        id 8667B2A35B7; Thu, 30 Jun 2022 13:26:51 +0200 (CEST)
From:   Julian Haller <julian.haller@bbl.ms.philips.com>
To:     linux-kernel@vger.kernel.org
Cc:     julian.haller@philips.com, zbr@ioremap.net
Subject: [PATCH 3/4] w1: ds1wm: Add support for permanent strong pull-up
Date:   Thu, 30 Jun 2022 13:26:50 +0200
Message-Id: <20220630112651.2739425-3-julian.haller@bbl.ms.philips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630112651.2739425-1-julian.haller@bbl.ms.philips.com>
References: <20220630112651.2739425-1-julian.haller@bbl.ms.philips.com>
Reply-To: julian.haller@philips.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 853e9d56-5d67-4448-210d-08da5a8b6e14
X-MS-TrafficTypeDiagnostic: DB7P122MB0170:EE_
X-MS-Exchange-AtpMessageProperties: SA|SL
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1H1hD1RG44iC7ptHTVs4HracnEnfJCsWVsev7p4JqCYEfPV+3w4aWcImgIxLGHP4PiW9nuP52hVXDi5TSqSesNgDiWoG0mmQAqLMerQ0Da/ZEmJdIUTsuMS2z7Y359agL4aTef3toDHsJU8krbeR8YdCE3S9HfeH5zyfp3DNG9DwuAocjHJrLhaMQ5j/Xcc3ifOSWBnCOQ9VeD4H+JcpGTD58FssH/ZPOZyT7zrwEY5USOElKTwpa4PHGL1X+o/ntbNr7VkRnh5oyskRbuWIUkH5jB19CPP41KkqooCK8PVuWzZ20ORYt5ExiIEW7WfErj7kvANW4VmRibbuds/PuXKc20hOBTpNCL7grjozq9y5qMiIe6TchSvaWGHXvR3ZAcwKIp6L/an0elFHSCYpNIO0Ox7P/Dhhftv3WqpNrjnMbecboRDYdQPD9kIBXxc0NChL/jA4T33Q6neIxcrFdCY6be/Nm1fJhalJ0Sq3ryyDBinbNe1LBYfC5jXMZTkTxNtCTcbGBRhT7EJi90nfADM6oOMnBQJ46id7S39HGCyIMH1J37JpwqgvlLFROg1FsSbHbZDBlNAOxQoebGWVuYBA3Spxro7uc5Cn9TmaK0eQhCkcMGimgh3WWR9CTPRI0zKoXXLhCyGIp6WNlvrtSDKZUbUVDA7ErxmKIhQGvZVZ0frFCBHO4ErsLFPLU2EnRIdUBbF16SPh8htHh/53LyTRXww3zrYue0KTmk8ZVngOQpbQ4BzcVqf6ZAMooKKJohqjTGdsM5KaHT4DfAFoWRv8PMhvQSodeLEpYJ63DvXGKeIycJQi6hfe/CdH8SkSjbKcUzQLI58vyOhxspsp8/fjoz7zcxwphKPRPu4jGVY=
X-Forefront-Antispam-Report: CIP:212.159.232.72;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:ext-eur1.smtp.philips.com;PTR:ext-eur1.smtp.philips.com;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(396003)(136003)(36840700001)(40470700004)(46966006)(316002)(107886003)(6916009)(82960400001)(356005)(8676002)(82740400003)(5660300002)(70586007)(4326008)(70206006)(186003)(1076003)(2616005)(36860700001)(82310400005)(42186006)(44832011)(426003)(2906002)(40480700001)(7636003)(478600001)(7596003)(40460700003)(6266002)(336012)(26005)(83380400001)(8936002)(41300700001)(47076005)(32563001);DIR:OUT;SFP:1102;
X-OriginatorOrg: ms.philips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 11:26:51.9459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 853e9d56-5d67-4448-210d-08da5a8b6e14
X-MS-Exchange-CrossTenant-Id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1a407a2d-7675-4d17-8692-b3ac285306e4;Ip=[212.159.232.72];Helo=[ext-eur1.smtp.philips.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT085.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7P122MB0170
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Haller <julian.haller@philips.com>

Add support for enabling the strong pull-up, both via device tree and
platform data.

Signed-off-by: Julian Haller <julian.haller@philips.com>
---
 drivers/w1/masters/ds1wm.c | 38 +++++++++++++++++++++++++++++++++++---
 include/linux/mfd/ds1wm.h  |  2 ++
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/w1/masters/ds1wm.c b/drivers/w1/masters/ds1wm.c
index a764b016758f..5768430a536e 100644
--- a/drivers/w1/masters/ds1wm.c
+++ b/drivers/w1/masters/ds1wm.c
@@ -25,6 +25,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/bitops.h>
 
 #include <asm/io.h>
 
@@ -36,7 +37,7 @@
 #define DS1WM_INT	0x02	/* R/W interrupt status */
 #define DS1WM_INT_EN	0x03	/* R/W interrupt enable */
 #define DS1WM_CLKDIV	0x04	/* R/W 5 bits of divisor and pre-scale */
-#define DS1WM_CNTRL	0x05	/* R/W master control register (not used yet) */
+#define DS1WM_CNTRL	0x05	/* R/W master control register */
 
 #define DS1WM_CMD_1W_RESET  (1 << 0)	/* force reset on 1-wire bus */
 #define DS1WM_CMD_SRA	    (1 << 1)	/* enable Search ROM accelerator mode */
@@ -60,6 +61,15 @@
 #define DS1WM_INTEN_ERSRF   (1 << 5)	/* enable rx shift register full int */
 #define DS1WM_INTEN_DQO	    (1 << 6)	/* enable direct bus driving ops */
 
+#define DS1WM_CNTRL_LLM     BIT(0)	/* long line mode */
+#define DS1WM_CNTRL_PPM     BIT(1)	/* presence pulse masking */
+#define DS1WM_CNTRL_EN_FOW  BIT(2)	/* enable force 1 wire command */
+#define DS1WM_CNTRL_STPEN   BIT(3)	/* active pullup enable */
+#define DS1WM_CNTRL_STP_SPLY BIT(4)	/* strong pullup power delivery */
+#define DS1WM_CNTRL_BIT_CTL BIT(5)	/* bit control */
+#define DS1WM_CNTRL_OD      BIT(6)	/* overdrive speed */
+
+
 #define DS1WM_INTEN_NOT_IAS (~DS1WM_INTEN_IAS)	/* all but INTR active state */
 
 #define DS1WM_TIMEOUT (HZ * 5)
@@ -115,6 +125,8 @@ struct ds1wm_data {
 	/* considering active_state (IAS) (optimization) */
 	u8       int_en_reg_none;
 	unsigned int reset_recover_delay; /* see ds1wm.h */
+	bool     strong_pullup_enable;
+	bool     strong_pullup_supply;
 };
 
 static inline void ds1wm_write_register(struct ds1wm_data *ds1wm_data, u32 reg,
@@ -313,6 +325,7 @@ static void ds1wm_up(struct ds1wm_data *ds1wm_data)
 {
 	int divisor;
 	struct device *dev = &ds1wm_data->pdev->dev;
+	u8 cntrl;
 
 	if (ds1wm_data->cell && ds1wm_data->cell->enable)
 		ds1wm_data->cell->enable(ds1wm_data->pdev);
@@ -330,6 +343,20 @@ static void ds1wm_up(struct ds1wm_data *ds1wm_data)
 	/* Let the w1 clock stabilize. */
 	msleep(1);
 
+	/* Set strong pullup */
+	cntrl = ds1wm_read_register(ds1wm_data, DS1WM_CNTRL);
+	if (ds1wm_data->strong_pullup_enable) {
+		cntrl |= DS1WM_CNTRL_STPEN;
+		if (ds1wm_data->strong_pullup_supply)
+			cntrl |= DS1WM_CNTRL_STP_SPLY;
+		else
+			cntrl &= ~DS1WM_CNTRL_STP_SPLY;
+	} else {
+		cntrl &= ~DS1WM_CNTRL_STPEN;
+		cntrl &= ~DS1WM_CNTRL_STP_SPLY;
+	}
+	ds1wm_write_register(ds1wm_data, DS1WM_CNTRL, cntrl);
+
 	ds1wm_reset(ds1wm_data);
 }
 
@@ -589,8 +616,10 @@ static int ds1wm_probe(struct platform_device *pdev)
 		}
 		ds1wm_data->clock_rate = clock_rate;
 
-		ds1wm_data->strong_pullup = of_property_read_bool(node,
-				"maxim,strong-pullup");
+		ds1wm_data->strong_pullup_enable = of_property_read_bool(node,
+				"maxim,strong-pullup-enable");
+		ds1wm_data->strong_pullup_supply = of_property_read_bool(node,
+				"maxim,strong-pullup-supply");
 	} else {
 		/* Using platform data */
 		ds1wm_data->cell = mfd_get_cell(pdev);
@@ -608,6 +637,9 @@ static int ds1wm_probe(struct platform_device *pdev)
 		ds1wm_data->reset_recover_delay = plat->reset_recover_delay;
 
 		ds1wm_data->clock_rate = plat->clock_rate;
+
+		ds1wm_data->strong_pullup_enable = plat->strong_pullup_enable;
+		ds1wm_data->strong_pullup_supply = plat->strong_pullup_supply;
 	}
 
 	/* how many bits to shift register number to get register offset */
diff --git a/include/linux/mfd/ds1wm.h b/include/linux/mfd/ds1wm.h
index 43dfca1c9702..dd9285ea507b 100644
--- a/include/linux/mfd/ds1wm.h
+++ b/include/linux/mfd/ds1wm.h
@@ -26,4 +26,6 @@ struct ds1wm_driver_data {
 	 * Only 0,1,2 allowed for 8,16 or 32 bit bus width respectively
 	 */
 	unsigned int bus_shift;
+	bool strong_pullup_enable;
+	bool strong_pullup_supply;
 };
-- 
2.25.1

