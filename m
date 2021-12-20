Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896B647A8D6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 12:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhLTLgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 06:36:49 -0500
Received: from mail-eopbgr70085.outbound.protection.outlook.com ([40.107.7.85]:41913
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231134AbhLTLgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:36:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7OQZZUJ3LSxEP1h6sAUOdqi4CHcf/WLpVjtsF9OTaEzytgEK6yHR47+xpRtfLfUWhqd5NVw9C+tuDkq+4JWS4dZhJENS3ZMZVimoOc2CT57BeYZL80VCy+LS6FqMvfzt0DGmpYaIBuUWDjWlFHaONmmnaHJDxCEYdxvBrMRxuF9tnBIdQIwp3NjigxWgbZFoVYcQHhCWm4AaVA3Lbeu5Z8zarabSlaD/WDmcL2F76034YiTBFthOX/zRdJh9SAqA4lUqpoZSKrW9xBvnUVqYFKwr9k7Z+V1tqc5tZk2AgtHb8IQdC3TXdNCuX6uLjKjfs1NiDeQxaXt4mJqYpiOPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I48NjDwVHZnqsLf3gMwdM4os+Ih4aWjVFM+MJneLKxk=;
 b=Tsv1TzuF4pBapJBYswYTBRsMbBlXh1xW5lT+aVcd3aWmM0k2opJImJwl0haL+uqZOJe8d/7Amvm7TVurEQRhUl7GXf5cUdmZWf2boYJD5jBzvf0hWS2aOqfEiZpJpPDFz/Prck7cZfxpa8UjhK60yZ+dlTWnRPK+6LQqVJu+4s4zI2MODVeLzE2ZrZJxLlqhfdFkQ8gUED05/UZI5YqGbEk1ui5F4iUIVa8uQPlUaaBQ7WQ9vedbTRS3Wzu4Ak3ui8Fx/K1+VpuesZVC1i7NSaM8hlMBjGGOKy1tM4K8KhN4zfgwjH0w9W7eAo4+R6jAkT3RghoZPyAy0DDepnBkAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tbs-biometrics.com; dmarc=pass action=none
 header.from=tbs-biometrics.com; dkim=pass header.d=tbs-biometrics.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tbsportal.onmicrosoft.com; s=selector2-tbsportal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I48NjDwVHZnqsLf3gMwdM4os+Ih4aWjVFM+MJneLKxk=;
 b=QeOaQG2Tfofq1Lki7B/FDa8pEso41XYc81EnMNuW/RmmsjeKvY+8lOKxt6rGm5MuMFBNHA/9r8ecuFe9c8c2eIVZlCBiwufbmb1ixPMsE9jRvCHjelEi2TFeqLgYwgOXsXS0kt6hy98FXA5n7stDkkEL1OG4p60DSgHjDHNjVlM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tbs-biometrics.com;
Received: from PAXPR06MB7534.eurprd06.prod.outlook.com (2603:10a6:102:153::11)
 by PA4PR06MB7280.eurprd06.prod.outlook.com (2603:10a6:102:f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Mon, 20 Dec
 2021 11:36:44 +0000
Received: from PAXPR06MB7534.eurprd06.prod.outlook.com
 ([fe80::9016:ebaf:8070:8f44]) by PAXPR06MB7534.eurprd06.prod.outlook.com
 ([fe80::9016:ebaf:8070:8f44%3]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 11:36:43 +0000
From:   Radim Pavlik <radim.pavlik@tbs-biometrics.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Radim Pavlik <radim.pavlik@tbs-biometrics.com>
Subject: [PATCH v2] sc16is7xx: Prevent dereferencing invalid data when gpio_hog used
Date:   Mon, 20 Dec 2021 12:36:03 +0100
Message-Id: <20211220113603.1311-1-radim.pavlik@tbs-biometrics.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <CAHp75VeaWJBstu2j1-wkBkPfgc0dXvjWZR01d8-q0P8t_3gvNA@mail.gmail.com>
References: <CAHp75VeaWJBstu2j1-wkBkPfgc0dXvjWZR01d8-q0P8t_3gvNA@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0014.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::27) To PAXPR06MB7534.eurprd06.prod.outlook.com
 (2603:10a6:102:153::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b88db101-d7b2-4684-d167-08d9c3acff37
X-MS-TrafficTypeDiagnostic: PA4PR06MB7280:EE_
X-Microsoft-Antispam-PRVS: <PA4PR06MB72807846F70366F86EF10A07BA7B9@PA4PR06MB7280.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:207;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xgLs9KFhOzMi7XLwcG5HKXCkFy/6BHYDLBgu+Ndyc8eis76KMv6lQecZS7gNB6m+P9F/vEUH90kHncU8FF1ewpMy60FWj1Bx8mHHDnoQ0lHPy+2HuLjA5rExdjuQqyjLF8CbeLJbrg/+hI3r4MpwE/PbLpi/LByGCKTeAJ40Cfy40tUr/2J8BxFdlH0CMgtt38cFWkd1Y+H78Bli4UI+Go//Dr7GWOE92GgiOhIxCfkpnVA0oUyInhRtjouxl4x+bZVUGzEooLvZskBhYGt/VwjMG8MDLP5RnjJ1v0hKoqaZnig6bBdQIK/74o8W3aJz/xfiLmxKC36zd87W0Tcve5uPhzXLAHI//h/X/PglDbdbpn1/1wxFobpDI9tWcvoZ3VELPPCtlxogRyG/qzsfTNcBRL0W8L1y1rZn289VxOHxLdH/t1V5YqAeCkq87mJM7KJSP/ZtxhsT9Fvjvnq9jKPgbLRAczZGpZ+0Oqv8OF54eve04T7MVCJVbJ/tZyguXb2m1cfl9WTn5oE/KyQ19FjgEkmtd8IKBK/8Sepi89cnRoambRi8WqBPJRCTfwUmM52tw16rEdxtExdmTXxzDKOPLKdL7cdAiPaq45SqgQDC+F7w+z0mUPmFYjxm4vYRxHhFDpdR+dguaBj4zgnnnIuQCt4+ikiJln3Ws7LrB0OMa119dN6QijfMo5PzHcoNGnl1cs+bYTeS+5C4OYrkvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR06MB7534.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(346002)(39830400003)(366004)(66556008)(2906002)(83380400001)(66946007)(66476007)(38350700002)(38100700002)(26005)(6506007)(52116002)(186003)(86362001)(36756003)(2616005)(110136005)(316002)(6512007)(4326008)(107886003)(508600001)(44832011)(5660300002)(8676002)(6666004)(6486002)(1076003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FXX54vUFz3LptYOz6hgp85pkGZWBCmVxmbLHsXy9WzzlcK+mLbH/GhiqX+qH?=
 =?us-ascii?Q?zB+xu94WjAQ2DjuR0icfUEbOoeGPGA4KsbelR6JiGgRjVzazy6qfa9nnDkMK?=
 =?us-ascii?Q?8zjRsk5yBi4lgPD/InQHwVcV3mXTvR1vFF88Jxi2w0R8KQYhs2FsrCjzRxZn?=
 =?us-ascii?Q?5J+UBdxCRXAtrdmcVL4vp0oPnRdOyz0x1cDq2VjtuPr2VtMstZXpc96gxPt7?=
 =?us-ascii?Q?Ivag2WOL9Y7Z1bEQl08UzJd1ekSdnZshRAkBtxsxdfKuS+ztHoeKHzj1kvpX?=
 =?us-ascii?Q?JMK+m8sA41Rrc5xk7MmXArx0QnXWX0chgy/UoH/2sprh3fodsRivIgm6qKIv?=
 =?us-ascii?Q?yun4in5OuPax05J6dsJswvuAAT8sEUxB+GrV4QD9vZ8lBaLhMwKo3xm7sFxu?=
 =?us-ascii?Q?/9LFO/8h74lr+wXtIsGgK9reEOIYV9/mvJtraIUMoYnW6TGd6HmehLHLGlHK?=
 =?us-ascii?Q?H/cjtnO6rKkykrIDTVUyiBntDnSgrkCS1uWBVsAC/IF60PXgCX35QY8iLeO9?=
 =?us-ascii?Q?XSkwaklsyv/qxu5+Y88KgHuyBTdV6ARwnl//3wlzyUlIyoxE7drWoxIvPe85?=
 =?us-ascii?Q?JLXnlFgosP62Z9BNfky7EdJmM1FjhT6Z7iIQMP5gzOmGOKXeayGFBPDXl2I1?=
 =?us-ascii?Q?Zp1Tix8Q4Y4eW3s5Ot/kuBGzvtvdj4r9V14phzegdyg0mbWuCHodyZaF8cD7?=
 =?us-ascii?Q?RYj4JUJGtPGsfzd93CNXyybJFiOtF91KnUOVb9jOXqjKz1F+R6nB6sBp0x0P?=
 =?us-ascii?Q?JKq40tQy1k9JF05O/EDVzSDEqrPR1IlLeD9BKCzukY4NxwgxW/0aYleNxRrn?=
 =?us-ascii?Q?o4zwzfVU8I1VGUX049EtymoLcNkRGIVnAiayqt0tapm3WeBL+5TfZaSQdWX6?=
 =?us-ascii?Q?3FP25g8DYtvE/Ur5mobI4NassLZIwV+iRoTFvbA9MPt8cCEh2cPcv2BCJQQ5?=
 =?us-ascii?Q?gnFeramcNo3bn37/gnuJa0Kclz7pnDjD4aXnU5dnKSumCdn7FVL1gk/HQhRa?=
 =?us-ascii?Q?aVjftnIa6fdX040nJ8ddtpTP9496bcp5QaZZM3dYzm2G/CnCM2HDMIkd+Kxe?=
 =?us-ascii?Q?Ql4ujQG1NCR9PspQW8xxT8B5CVkmkN0dL+46u8Z8TuT7VcDRncdpaPUurgLx?=
 =?us-ascii?Q?LZNqnoU5Az6S2Xqa7dOhljMeKiAJWIA8i/mPDniQfXMVocAWL5So0FfYi9v6?=
 =?us-ascii?Q?wkCEhzxvYY4LOo+gMh0FaaKUCcXkg5jdwiynziZAdWGaGWnD3VDpjP+/P3Qz?=
 =?us-ascii?Q?2l0eL1U/UAtFY2SAxgitY0DBBF3JnPJ8sBCnbG17rks29Svy+nZNVhM0jHK7?=
 =?us-ascii?Q?RGvo7E91oeEA49i/da2yhh57al4jjfBH9mZWyclK6BWr01ALdXHPNoiSvbl8?=
 =?us-ascii?Q?r9LLcleE9ZK0+te3xT0rxDK5uT8YYDr+6+4xFt7KzTdluBavlX/AbsTJO/y/?=
 =?us-ascii?Q?yQG8oN0gBUX6hP+iNk2Wp4bSI4XPEL708ew+VrCyv46+2EM/EHalEco7lK7p?=
 =?us-ascii?Q?nzBn7Gqy4u+SmTu+Yv/kbjuFlZRIdOujijTE2vXzZrCQX/KQGzP0nu1dje16?=
 =?us-ascii?Q?+BxnLLp2s2ImlzG7d5AuPDHXtuuXWRmwax20/4f8GrcaoMKlp8PboTjSyG7d?=
 =?us-ascii?Q?YZPi2hW5JlA1I5VRNsEvJyMq9SKOhbSpQI7MgopsinFJA9fA/XRgKubtmEQX?=
 =?us-ascii?Q?B80EGQ=3D=3D?=
X-OriginatorOrg: tbs-biometrics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b88db101-d7b2-4684-d167-08d9c3acff37
X-MS-Exchange-CrossTenant-AuthSource: PAXPR06MB7534.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2021 11:36:43.5630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03c5283b-bdcc-41a6-b827-b66aa8b838e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHUvJgwzClbrFX4mG1mWP+6alJDDwfcahqKQ7RPobBSOpt5exWEeo9VabrHz+cLf52rRvNRWr6uZf3O0G3y3AkNh0xEV6ufQkSUoSFNrgzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR06MB7280
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpio_hog is trying to use gpio functions during probe call.
At that time we dont have initialized port data which are dereferenced
via assigned gpio.direction_input/output functions.
This results in unable to handle kernel NULL pointer dereference
followed by Kernel panic.
This patch prevents that.

Due to changed order of initialization 'port' before 'gpio controller'
was also changed error path which resulted in removed label.

No fixes tag because patch spans across multiple patches.

Signed-off-by: Radim Pavlik <radim.pavlik@tbs-biometrics.com>
---
 drivers/tty/serial/sc16is7xx.c | 49 +++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 64e7e6c8145f..416fa71dcde1 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1242,25 +1242,6 @@ static int sc16is7xx_probe(struct device *dev,
 	}
 	sched_set_fifo(s->kworker_task);

-#ifdef CONFIG_GPIOLIB
-	if (devtype->nr_gpio) {
-		/* Setup GPIO cotroller */
-		s->gpio.owner		 = THIS_MODULE;
-		s->gpio.parent		 = dev;
-		s->gpio.label		 = dev_name(dev);
-		s->gpio.direction_input	 = sc16is7xx_gpio_direction_input;
-		s->gpio.get		 = sc16is7xx_gpio_get;
-		s->gpio.direction_output = sc16is7xx_gpio_direction_output;
-		s->gpio.set		 = sc16is7xx_gpio_set;
-		s->gpio.base		 = -1;
-		s->gpio.ngpio		 = devtype->nr_gpio;
-		s->gpio.can_sleep	 = 1;
-		ret = gpiochip_add_data(&s->gpio, s);
-		if (ret)
-			goto out_thread;
-	}
-#endif
-
 	/* reset device, purging any pending irq / data */
 	regmap_write(s->regmap, SC16IS7XX_IOCONTROL_REG << SC16IS7XX_REG_SHIFT,
 			SC16IS7XX_IOCONTROL_SRESET_BIT);
@@ -1315,6 +1296,25 @@ static int sc16is7xx_probe(struct device *dev,
 		sc16is7xx_power(&s->p[i].port, 0);
 	}

+#ifdef CONFIG_GPIOLIB
+	if (devtype->nr_gpio) {
+		/* Setup GPIO cotroller */
+		s->gpio.owner		 = THIS_MODULE;
+		s->gpio.parent		 = dev;
+		s->gpio.label		 = dev_name(dev);
+		s->gpio.direction_input	 = sc16is7xx_gpio_direction_input;
+		s->gpio.get		 = sc16is7xx_gpio_get;
+		s->gpio.direction_output = sc16is7xx_gpio_direction_output;
+		s->gpio.set		 = sc16is7xx_gpio_set;
+		s->gpio.base		 = -1;
+		s->gpio.ngpio		 = devtype->nr_gpio;
+		s->gpio.can_sleep	 = 1;
+		ret = gpiochip_add_data(&s->gpio, s);
+		if (ret)
+			goto out_ports;
+	}
+#endif
+
 	if (dev->of_node) {
 		struct property *prop;
 		const __be32 *p;
@@ -1345,18 +1345,17 @@ static int sc16is7xx_probe(struct device *dev,
 	if (!ret)
 		return 0;

+#ifdef CONFIG_GPIOLIB
+	if (devtype->nr_gpio)
+		gpiochip_remove(&s->gpio);
+#endif
+
 out_ports:
 	for (i--; i >= 0; i--) {
 		uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
 		clear_bit(s->p[i].port.line, &sc16is7xx_lines);
 	}

-#ifdef CONFIG_GPIOLIB
-	if (devtype->nr_gpio)
-		gpiochip_remove(&s->gpio);
-
-out_thread:
-#endif
 	kthread_stop(s->kworker_task);

 out_clk:
--
2.32.0

