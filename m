Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB1947FACE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 08:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbhL0Htk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 02:49:40 -0500
Received: from mail-eopbgr40076.outbound.protection.outlook.com ([40.107.4.76]:15936
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235578AbhL0Htg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 02:49:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkiZOyKhoDhtfgNpSZraw1HMzo7yrWMf5Wi2AdTEX1dDeM2I5io8pF2ZcZP9rM+0aJAXtOja+1HB7Tf8GR8Azv6bgZRYGaLOvC83egTSsNbw6noT/mykjKXk39UPg8fm6rFCPabsUwWaX4PJx+Q+RGljBWgmyFZGzWKySNQXm4Zj7M0Jx5xq5FPkaLuKUX2+gZEHV56E7wRHVTzVu0YCmWx92Tz707SfHPO9B5mE1YoZMsfPKv+UIFB3odDQHLkwwxEoEhQ0qxopWyogw20+hwHVih1SaWG+IjKM/2u9kLfcyTK3QWhbtDwJdN7bQOrf41Pnis1K/YCZKb5y3uK7Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7aOp7JfdPBLB0PjrEzdvSJ9jjA8JHcjYlRhhf1GKyM=;
 b=YA9R3Gj0yjLtpDeud6X+BU1rGursQaVqiNr44mV2XOdhHM9GKzhpcpQHK59/AVOZw2q6gChq1t1tfC6qKSjeGQEoFNtyDamE4pB47H9NyFf5rTRJJBJtg4yqqRQtCYMvinic6MCD+ZmWtriRzZ656UsnXxAyw985O7kDoLfocffZVJFMrHLwtdhBCzXhkBbW5GrUrh43ApFX511nv01hBqhdSjOKZgVNsTI+J+grBBm3KgvvdYwDy9T3FOjrea7r47vrSWWzqsmkHH30ffWhLQpjKtl0tSzI8kH+6hQgCYDBQkjghpLUe64g3No5+33r/lN8XJUFtVfv022Pstmzxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7aOp7JfdPBLB0PjrEzdvSJ9jjA8JHcjYlRhhf1GKyM=;
 b=rly9VN4dEbtEraumLWITrNdu0Y/0omdAUX5g3d71IffZPIM9QqX2y012rJwEY4caJx40IM38zJTL3SHVuhuz1Pqv2LGcX1OV17RgvKICrEwQYfhi0GgZQA8yGq7l4gwAJC2UZSoTxUI5O2wBsMoOLxIf7Vy7dzcvFUHk8fx4JXM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5631.eurprd04.prod.outlook.com (2603:10a6:803:dd::27)
 by VI1PR04MB5629.eurprd04.prod.outlook.com (2603:10a6:803:de::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Mon, 27 Dec
 2021 07:49:30 +0000
Received: from VI1PR04MB5631.eurprd04.prod.outlook.com
 ([fe80::90fe:b60a:94b5:c748]) by VI1PR04MB5631.eurprd04.prod.outlook.com
 ([fe80::90fe:b60a:94b5:c748%5]) with mapi id 15.20.4823.022; Mon, 27 Dec 2021
 07:49:30 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 6/8] i3c: master: svc: add runtime pm support
Date:   Mon, 27 Dec 2021 15:45:27 +0800
Message-Id: <20211227074529.1660398-7-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211227074529.1660398-1-xiaoning.wang@nxp.com>
References: <20211227074529.1660398-1-xiaoning.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0132.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::36) To VI1PR04MB5631.eurprd04.prod.outlook.com
 (2603:10a6:803:dd::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10795e74-4cea-4728-9466-08d9c90d6a39
X-MS-TrafficTypeDiagnostic: VI1PR04MB5629:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB5629879475EDF749DD608EB2F3429@VI1PR04MB5629.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fxvpLZPi6H4mkqjG3oI2BNu3SOMUh9BXS9HDTS1vkhUC5Kes0Q4Ztgk6Jhbph0+PzLH7YcARRNqdNiAvXlpd0NUbxqXzzdgwcW9MIsabb1eIkwDNUQUzItRV3gIS7xWrObagRjZaYDLXn2SLurRZyaFYwH7lCdmaWuJvr++G1lR9btY/DmIaq7YHlZ4wk6Ko4jgWBY2fJrxLu4jY1dBTgiHY4hq+HZtu1Qws5TK6ZCWK16HeJ8Ov7IdCFUnyzNJiXUOyIfzpwQ/HWzNtB3yPm2vacrsWo4Q776Q8tRczqbW6JJSIQxg1U9VWdXwolKMbpfSy0LN4vKvkTZffq3deLnVPHHBRkPL8rd4pHXjbCo/CVuvKX+SiMAs9ZIVJzt3bJwUZLL5rVV+kPuQpbAwWvMMUlxZU+G+w2zCcI1o2yvIYRf9d8irl99/D1BvTwn/ihasZUbqNQGDLFNHmPuXCl6gNMFu+Qx4tV9w2HVGOrP21MaPm0Ec1sCuLcxQfrzniJPPeqBON8X6PMEVQjC/SIdKy7CupENSHCmnTfUVbRZJxqzxqcU3/nR73oJuLdFFu2SWtWxM1HAu+XJLW7/xZmfmNeHZ9Hoz5phI2p7vxWrLWWMHqqtZkdJ+ftE2Nvji1XarM06cxftmNoY83BfcTeuzuoNRAEyhhqMgzXyUOL3SnJl9Dx9lPlL44cS2IUQw1k/Uk8t3j/nIx9x4dZlYTQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5631.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(26005)(2906002)(6916009)(83380400001)(86362001)(36756003)(66556008)(6486002)(66476007)(66946007)(8936002)(52116002)(4326008)(38350700002)(38100700002)(2616005)(186003)(508600001)(6666004)(8676002)(6512007)(1076003)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XjE0p+nRp0EGzzRSThYll5pYqVZZBv9omd/i7ocvXudptKiJQDCvEDlK93Tb?=
 =?us-ascii?Q?A4F90FowVl5WcBAWx2GxDLC60RG+vhSOwR6tiRDd311W57PpVfSzTKkhhvYG?=
 =?us-ascii?Q?DFBMnQYKRmtSjUeG+bx11N0q2agQI8WXUwiMLFgXLAvJWXzyVm6UCdo5r1R/?=
 =?us-ascii?Q?Qllen53vQ887X7uYW4ukFxeC+Jrw/tmmuwwg7EMKoVBUQMrWKqaBpEkeVU+N?=
 =?us-ascii?Q?cLn9kkDuD7FS+5UjvqU/I72d9acfUy/d1NhHL80OuoTe06dE8rM7Us9KWN7Y?=
 =?us-ascii?Q?qXuC7QIhqmXSc3FiRG10GiuksjwgZzNUi8ss0g0MD4Gy4wHT2I4MYhVXAaRq?=
 =?us-ascii?Q?m+AvMNMVj/y/ZWxuLP/snbkllx/HrgtKhk/tOE1/jxqTfTWZCUibNPRBKUgM?=
 =?us-ascii?Q?hic/CI+AlUPSI4HnRLjPK+p9fXFyHgPCqVAq5spgWDTCV7NwrBL1OgbAVNTH?=
 =?us-ascii?Q?TCc4khmNXiKZA+Ms+A+yDm4J9xaXl7GFcB6GUpROV3AgmDLRXfQYvbNlzD77?=
 =?us-ascii?Q?kmcuhPqtEsa0I11/X1j8U9JZp6tXmDIJXHmiqYpPy/7F8m7ifVpP+vhrgiwh?=
 =?us-ascii?Q?H/b70kDRRP/AXchx98WIuDcMc6JtekMWwl+nTJQ1LvndGRMN233mD+zEIY8K?=
 =?us-ascii?Q?YJjWRGqDtdcaxBGSZ0iPn/VzVaHt/pgDQj2PcBeea4Rl5ghKyHP2qEQBJK5a?=
 =?us-ascii?Q?rNsUS1nZoEceKqqc1hSN7TLlWzR0xIXOMHUXh3BxhGRYXLQJZ1WG0dgaKP+j?=
 =?us-ascii?Q?Boovh923PleqbTihdSi9zsgpBSmOaY1Nr8dSd9I6HRQeeKp6HVT32eRfClyQ?=
 =?us-ascii?Q?XPX9/0D4huxTFjI6+5+5tIhJHhXqCjR1yPtVZDKDs0mG1FzTXf38U1u+549Q?=
 =?us-ascii?Q?78zC6MLQh5YhY9ms39PxL72U/iQRbp2jEDD8JLP5+JTZC0e2pA79VTxhhwTT?=
 =?us-ascii?Q?+uE00deet1sgq8gTjYnWQgfTww0TuuzEDTv8f679XV+43FAiEhUCUzpO/wRo?=
 =?us-ascii?Q?jC6PMTr9RK9g8Qgww2mu4cuQlrU9p7PLNrN/Q8qBDDvVXheUpQMtCAAtWgip?=
 =?us-ascii?Q?o4cfvyOyrIJDniA61+0Qb0NmaO8MV0JDyyQXSU3U/G2u17rTRRprDvxd1tM+?=
 =?us-ascii?Q?K93L/aDslYL6VLwz6wxmpG9wZVLOE5lsjM6EbT4HifRIyJKb+4WDUV9tL+YS?=
 =?us-ascii?Q?92UVFjjF5/XrC+rrKrwFsyonPX+/5I3rq2gHbznxNAXfgalm6d6EkkBzbaHd?=
 =?us-ascii?Q?AocwwdCAyu2zXyAHHe9qSfMYIc3f/Fxyg+0AEAdVNB/Lpj+oqoxpnNHxiRM6?=
 =?us-ascii?Q?hKGTDka1Npi1L9P521ZRscp/u0BwsxjUkd1R88TaFEy2mzrWO8wpGXLm4dVj?=
 =?us-ascii?Q?29tWtZUyTdFcoCrY2M2XI9xvHD9VjlueW7jYjHp2JWbj1s9VTadN+Cd2W4p/?=
 =?us-ascii?Q?w6faGkD5QNwVjioXgudEtX25IFd/5L79vV4xRRA1UEZKfyHExmLUwC1oDlO1?=
 =?us-ascii?Q?F4rQoKamhh/5tUeTVOs3T1dwnZrcH1Ovyag7Y4CmojcPH26ivmTk2nLGYBLf?=
 =?us-ascii?Q?0PNtt37x4VplY4sW06zwHAwRzYqUUt64oauqFcA7FuHiUf9ze8F1K4YF/DaS?=
 =?us-ascii?Q?MewUn6LOi7xNhaIv6Ztl+nY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10795e74-4cea-4728-9466-08d9c90d6a39
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5631.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2021 07:49:30.6880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Y99YYUsP/fDiwAJnSBZaUKyeITelRTAdg5bTZwO6bRi57ZcnrCJBZYWiIf7MG6kVgkF1HYA432Zy6MbCtOYyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5629
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add runtime pm support to dynamically manage the clock.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jun Li <jun.li@nxp.com>
---
V5:
 - create svc_i3c_master_prepare_clks() and svc_i3c_master_unprepare_clks() 
 - add Miquel's reviewed tag
---
 drivers/i3c/master/svc-i3c-master.c | 196 ++++++++++++++++++++++------
 1 file changed, 156 insertions(+), 40 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index bc9c7fd69cbe..884f5349fb76 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -17,7 +17,9 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 /* Master Mode Registers */
 #define SVC_I3C_MCONFIG      0x000
@@ -119,6 +121,7 @@
 #define   SVC_MDYNADDR_ADDR(x) FIELD_PREP(GENMASK(7, 1), (x))
 
 #define SVC_I3C_MAX_DEVS 32
+#define SVC_I3C_PM_TIMEOUT_MS 1000
 
 /* This parameter depends on the implementation and may be tuned */
 #define SVC_I3C_FIFO_SIZE 16
@@ -480,10 +483,20 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 	u32 ppbaud, pplow, odhpp, odbaud, odstop, i2cbaud, reg;
 	int ret;
 
+	ret = pm_runtime_resume_and_get(master->dev);
+	if (ret < 0) {
+		dev_err(master->dev,
+			"<%s> cannot resume i3c bus master, err: %d\n",
+			__func__, ret);
+		return ret;
+	}
+
 	/* Timings derivation */
 	fclk_rate = clk_get_rate(master->fclk);
-	if (!fclk_rate)
-		return -EINVAL;
+	if (!fclk_rate) {
+		ret = -EINVAL;
+		goto rpm_out;
+	}
 
 	fclk_period_ns = DIV_ROUND_UP(1000000000, fclk_rate);
 
@@ -527,7 +540,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 		odstop = 1;
 		break;
 	default:
-		return -EINVAL;
+		goto rpm_out;
 	}
 
 	reg = SVC_I3C_MCONFIG_MASTER_EN |
@@ -545,7 +558,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 	/* Master core's registration */
 	ret = i3c_master_get_free_addr(m, 0);
 	if (ret < 0)
-		return ret;
+		goto rpm_out;
 
 	info.dyn_addr = ret;
 
@@ -554,21 +567,35 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 
 	ret = i3c_master_set_info(&master->base, &info);
 	if (ret)
-		return ret;
+		goto rpm_out;
 
 	svc_i3c_master_enable_interrupts(master, SVC_I3C_MINT_SLVSTART);
 
-	return 0;
+rpm_out:
+	pm_runtime_mark_last_busy(master->dev);
+	pm_runtime_put_autosuspend(master->dev);
+
+	return ret;
 }
 
 static void svc_i3c_master_bus_cleanup(struct i3c_master_controller *m)
 {
 	struct svc_i3c_master *master = to_svc_i3c_master(m);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(master->dev);
+	if (ret < 0) {
+		dev_err(master->dev, "<%s> Cannot get runtime PM.\n", __func__);
+		return;
+	}
 
 	svc_i3c_master_disable_interrupts(master);
 
 	/* Disable master */
 	writel(0, master->regs + SVC_I3C_MCONFIG);
+
+	pm_runtime_mark_last_busy(master->dev);
+	pm_runtime_put_autosuspend(master->dev);
 }
 
 static int svc_i3c_master_reserve_slot(struct svc_i3c_master *master)
@@ -867,31 +894,36 @@ static int svc_i3c_master_do_daa(struct i3c_master_controller *m)
 	unsigned int dev_nb;
 	int ret, i;
 
+	ret = pm_runtime_resume_and_get(master->dev);
+	if (ret < 0) {
+		dev_err(master->dev, "<%s> Cannot get runtime PM.\n", __func__);
+		return ret;
+	}
+
 	spin_lock_irqsave(&master->xferqueue.lock, flags);
 	ret = svc_i3c_master_do_daa_locked(master, addrs, &dev_nb);
 	spin_unlock_irqrestore(&master->xferqueue.lock, flags);
-	if (ret)
-		goto emit_stop;
+	if (ret) {
+		svc_i3c_master_emit_stop(master);
+		svc_i3c_master_clear_merrwarn(master);
+		goto rpm_out;
+	}
 
 	/* Register all devices who participated to the core */
 	for (i = 0; i < dev_nb; i++) {
 		ret = i3c_master_add_i3c_dev_locked(m, addrs[i]);
 		if (ret)
-			return ret;
+			goto rpm_out;
 	}
 
 	/* Configure IBI auto-rules */
 	ret = svc_i3c_update_ibirules(master);
-	if (ret) {
+	if (ret)
 		dev_err(master->dev, "Cannot handle such a list of devices");
-		return ret;
-	}
-
-	return 0;
 
-emit_stop:
-	svc_i3c_master_emit_stop(master);
-	svc_i3c_master_clear_merrwarn(master);
+rpm_out:
+	pm_runtime_mark_last_busy(master->dev);
+	pm_runtime_put_autosuspend(master->dev);
 
 	return ret;
 }
@@ -1060,6 +1092,12 @@ static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
 	if (!xfer)
 		return;
 
+	ret = pm_runtime_resume_and_get(master->dev);
+	if (ret < 0) {
+		dev_err(master->dev, "<%s> Cannot get runtime PM.\n", __func__);
+		return;
+	}
+
 	svc_i3c_master_clear_merrwarn(master);
 	svc_i3c_master_flush_fifo(master);
 
@@ -1074,6 +1112,9 @@ static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
 			break;
 	}
 
+	pm_runtime_mark_last_busy(master->dev);
+	pm_runtime_put_autosuspend(master->dev);
+
 	xfer->ret = ret;
 	complete(&xfer->comp);
 
@@ -1350,6 +1391,14 @@ static void svc_i3c_master_free_ibi(struct i3c_dev_desc *dev)
 static int svc_i3c_master_enable_ibi(struct i3c_dev_desc *dev)
 {
 	struct i3c_master_controller *m = i3c_dev_get_master(dev);
+	struct svc_i3c_master *master = to_svc_i3c_master(m);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(master->dev);
+	if (ret < 0) {
+		dev_err(master->dev, "<%s> Cannot get runtime PM.\n", __func__);
+		return ret;
+	}
 
 	return i3c_master_enec_locked(m, dev->info.dyn_addr, I3C_CCC_EVENT_SIR);
 }
@@ -1357,8 +1406,15 @@ static int svc_i3c_master_enable_ibi(struct i3c_dev_desc *dev)
 static int svc_i3c_master_disable_ibi(struct i3c_dev_desc *dev)
 {
 	struct i3c_master_controller *m = i3c_dev_get_master(dev);
+	struct svc_i3c_master *master = to_svc_i3c_master(m);
+	int ret;
+
+	ret = i3c_master_disec_locked(m, dev->info.dyn_addr, I3C_CCC_EVENT_SIR);
 
-	return i3c_master_disec_locked(m, dev->info.dyn_addr, I3C_CCC_EVENT_SIR);
+	pm_runtime_mark_last_busy(master->dev);
+	pm_runtime_put_autosuspend(master->dev);
+
+	return ret;
 }
 
 static void svc_i3c_master_recycle_ibi_slot(struct i3c_dev_desc *dev,
@@ -1389,6 +1445,37 @@ static const struct i3c_master_controller_ops svc_i3c_master_ops = {
 	.disable_ibi = svc_i3c_master_disable_ibi,
 };
 
+static int svc_i3c_master_prepare_clks(struct svc_i3c_master *master)
+{
+	int ret = 0;
+
+	ret = clk_prepare_enable(master->pclk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(master->fclk);
+	if (ret) {
+		clk_disable_unprepare(master->pclk);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(master->sclk);
+	if (ret) {
+		clk_disable_unprepare(master->pclk);
+		clk_disable_unprepare(master->fclk);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void svc_i3c_master_unprepare_clks(struct svc_i3c_master *master)
+{
+	clk_disable_unprepare(master->pclk);
+	clk_disable_unprepare(master->fclk);
+	clk_disable_unprepare(master->sclk);
+}
+
 static int svc_i3c_master_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1421,24 +1508,16 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
 
 	master->dev = dev;
 
-	ret = clk_prepare_enable(master->pclk);
+	ret = svc_i3c_master_prepare_clks(master);
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(master->fclk);
-	if (ret)
-		goto err_disable_pclk;
-
-	ret = clk_prepare_enable(master->sclk);
-	if (ret)
-		goto err_disable_fclk;
-
 	INIT_WORK(&master->hj_work, svc_i3c_master_hj_work);
 	INIT_WORK(&master->ibi_work, svc_i3c_master_ibi_work);
 	ret = devm_request_irq(dev, master->irq, svc_i3c_master_irq_handler,
 			       IRQF_NO_SUSPEND, "svc-i3c-irq", master);
 	if (ret)
-		goto err_disable_sclk;
+		goto err_disable_clks;
 
 	master->free_slots = GENMASK(SVC_I3C_MAX_DEVS - 1, 0);
 
@@ -1452,29 +1531,38 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
 					 GFP_KERNEL);
 	if (!master->ibi.slots) {
 		ret = -ENOMEM;
-		goto err_disable_sclk;
+		goto err_disable_clks;
 	}
 
 	platform_set_drvdata(pdev, master);
 
+	pm_runtime_set_autosuspend_delay(&pdev->dev, SVC_I3C_PM_TIMEOUT_MS);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	svc_i3c_master_reset(master);
 
 	/* Register the master */
 	ret = i3c_master_register(&master->base, &pdev->dev,
 				  &svc_i3c_master_ops, false);
 	if (ret)
-		goto err_disable_sclk;
+		goto rpm_disable;
+
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
 
 	return 0;
 
-err_disable_sclk:
-	clk_disable_unprepare(master->sclk);
+rpm_disable:
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 
-err_disable_fclk:
-	clk_disable_unprepare(master->fclk);
-
-err_disable_pclk:
-	clk_disable_unprepare(master->pclk);
+err_disable_clks:
+	svc_i3c_master_unprepare_clks(master);
 
 	return ret;
 }
@@ -1488,13 +1576,40 @@ static int svc_i3c_master_remove(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	clk_disable_unprepare(master->pclk);
-	clk_disable_unprepare(master->fclk);
-	clk_disable_unprepare(master->sclk);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
 
+static int __maybe_unused svc_i3c_runtime_suspend(struct device *dev)
+{
+	struct svc_i3c_master *master = dev_get_drvdata(dev);
+
+	svc_i3c_master_unprepare_clks(master);
+	pinctrl_pm_select_sleep_state(dev);
+
+	return 0;
+}
+
+static int __maybe_unused svc_i3c_runtime_resume(struct device *dev)
+{
+	struct svc_i3c_master *master = dev_get_drvdata(dev);
+	int ret = 0;
+
+	pinctrl_pm_select_default_state(dev);
+	svc_i3c_master_prepare_clks(master);
+
+	return ret;
+}
+
+static const struct dev_pm_ops svc_i3c_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				      pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(svc_i3c_runtime_suspend,
+			   svc_i3c_runtime_resume, NULL)
+};
+
 static const struct of_device_id svc_i3c_master_of_match_tbl[] = {
 	{ .compatible = "silvaco,i3c-master" },
 	{ /* sentinel */ },
@@ -1506,6 +1621,7 @@ static struct platform_driver svc_i3c_master = {
 	.driver = {
 		.name = "silvaco-i3c-master",
 		.of_match_table = svc_i3c_master_of_match_tbl,
+		.pm = &svc_i3c_pm_ops,
 	},
 };
 module_platform_driver(svc_i3c_master);
-- 
2.25.1

