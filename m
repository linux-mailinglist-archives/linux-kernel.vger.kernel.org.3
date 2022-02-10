Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C0E4B08B0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237811AbiBJIoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:44:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237817AbiBJIoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:44:11 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80079.outbound.protection.outlook.com [40.107.8.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF2E10CB;
        Thu, 10 Feb 2022 00:44:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZB/uRKEirLi2tqOctAHm+bjXBJy72j3lKfNTyDp+YJtvFxpLfpKqDS5gcGIMUaXIRQt5A3PryyZn+OaxB66OvXTPJ7LetMECTKUE7NOeY/hMJK9uB+H0fsKUo1kbTeQYE6qdG0VKqRnRecZcbkFqAFu7Tx6jd64PVlFuR7+Uh9LYNvGkcVcTof6yXj9nI5g0ywBll08i9iryu8VObELxLf2Yl+/BLYqxhHms/I7oZd2PWdzTw/hF+Kwr72zEJ63Nb8BB1vheyUhqZqyyp53uoVSxWGAZyM2bvHFq5G23vpKQ5Mqb85q/RDnWyG5r8mPV/7sPdV4eJR3Uc8WokOBalw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkE0DDSzY8X5qyngegafkRM1uTMRx4vahRmjlMSzAw8=;
 b=WE6SAfT4EulVSLYnxTChCz86l6Ew6/F3Wj9oe8ARuz6OAal8jMtGGtnBGMSv/mKTDwZgcWPTnkl7y4Ce9aD9Q8k02NhkwCzArgc9UcghWket+41Qamz+C6Dp1F/SEIrkaDw7B3HrqjgXijbfa2NLEIeJPD7zSM6xrgYyCX7JRIkjyZmEr6MLLEppKy0qX889+ToNCFJdUlwEDgOs/AIoi7KSqahUmW+eRiN+PVZlhdn7iqsreT9TUNLQau+LG0/fvdurvzSU3iou95vHzgKw87cEMSucNAkLfq95vReytkPi46xfh7JI7Zkm+YawdzbbVvv4KBfEv4w857W0Kawl0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkE0DDSzY8X5qyngegafkRM1uTMRx4vahRmjlMSzAw8=;
 b=sopIK8nQSbHrRZneKJAng4+jputBp45zPCb0rRjm4LoF6v9J5f6BP7+uZsVIvaTppBUfBXzviubmtqnbt2LFU7sU4hGYHywoZxvObU1fOU9CCUCIjtnggoJZR1yEKMcW6mKXS7M+0ZtUiQJ1yR0QqDGZ87KJOXV5VbjBxccfEXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB5771.eurprd04.prod.outlook.com (2603:10a6:10:af::27)
 by AM0PR04MB6211.eurprd04.prod.outlook.com (2603:10a6:208:141::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Thu, 10 Feb
 2022 08:44:04 +0000
Received: from DB8PR04MB5771.eurprd04.prod.outlook.com
 ([fe80::1cb4:559d:eae5:f409]) by DB8PR04MB5771.eurprd04.prod.outlook.com
 ([fe80::1cb4:559d:eae5:f409%3]) with mapi id 15.20.4951.018; Thu, 10 Feb 2022
 08:44:04 +0000
From:   Kane Jiang <jian.jiang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Kane Jiang <jian.jiang@nxp.com>
Subject: [PATCH 2/3] Change to cyclecounter for GPT input capture. Add support for i.MX8MM.
Date:   Thu, 10 Feb 2022 16:43:34 +0800
Message-Id: <20220210084335.1979778-3-jian.jiang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220210084335.1979778-1-jian.jiang@nxp.com>
References: <20220210084335.1979778-1-jian.jiang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To DB8PR04MB5771.eurprd04.prod.outlook.com
 (2603:10a6:10:af::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01436c24-714a-4b28-5e4d-08d9ec717e0e
X-MS-TrafficTypeDiagnostic: AM0PR04MB6211:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB62111BAC4CD612EF062EDBCE9A2F9@AM0PR04MB6211.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JU0bCd7+Hx4CzNX3X6Z5ddNsQexlKaog+vqvrki4h+i77oDaBl+EkQcsl5geElEN8R8Zpu/vc6MNwl9PPR7MZOzRdFa3ztEbdtrlUQkOZWx82nbL5xyPyYIEU20PS0JJ4lpDegPWOPAfOnAsBP+SasOFs4/fkyhpiwsy1v6zAvVbyXr4GTjw7ppdsl053w9dtbeDYiiysUR3EsnR/bgvxF0369m19IDZmxYambm6eMoml5LDRFtrpXSE8HKqlAflw4QMQrTukPGYlWg+ql2GOtSJJMzVCwV1KSsmrTdLGmrwJb7E6T1gBguST6298Rd2zVrp9oeBdiBz6MuFmtXU41CNklX09QLjiETlHu0FJnd7/P3VocyWWqOPjSg2+lyKIq5VwObdasx4YYXzrzmWOomEHmUacEU1t/0GmT0e/4gZrcrjZyxyz12XcgBMupFnsBnnSoB153RNGCInQJr9yvJ+ARnhlQllkjLO7r3PJdkIpZO7qWDJN4jnYc62X2SjDnHfZWISqN/Zi1d7mw8sORQM3AaOw4iRN4PKKeQX9vAp/RilCX1zOvWH6mct1Pq5ZmKV4PAQ9NYdC44/mkPNp4psGDvvefFb/CsQ26064zDlmxiw6RkIsUTekEeozMzyRDDh6aXQwXz1UFdE9pqAv50O64l469LWgE+0uTG6VZYkAc+CXpeUb0lAfY6dJcaPGBXtPZ/NPJf2BhKW4fRDdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB5771.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38350700002)(6512007)(8676002)(110136005)(6506007)(316002)(86362001)(6666004)(508600001)(66476007)(66946007)(4326008)(66556008)(6486002)(52116002)(36756003)(8936002)(5660300002)(7416002)(83380400001)(2616005)(1076003)(2906002)(26005)(186003)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qiWcGww0gZexvP4lmERyU/Lj/mEV7HXw8hx1UkgPxEaR6XEMrusSrV3LAZfA?=
 =?us-ascii?Q?eKnrJiShKUEsolew7mKbgVSrChjNmkzqnFmdAIh589MZFy3KEDqtrNXcNcVx?=
 =?us-ascii?Q?6CR01QUfE01dYm2TwoGzAIcELeIdNx7/QsZMdoW1pXQlTSWyFXyM7xj3//Y5?=
 =?us-ascii?Q?syuzVzf2h33EEwizWvNz9AHwjb5IIwYZpsPNnBuPBSz4DwX0SacBWNwkKRFA?=
 =?us-ascii?Q?IZKNywNpk0+m/pJEY5z/bLO/tJ5br6Ic2rNHSkN+npfYObqQvfMYNIrxE0j9?=
 =?us-ascii?Q?bf8JkRYqmFtqxYql+onh6r0TUn0/8Up4L2L4bIYLqhr3m2EXyBRoOFkMLv6j?=
 =?us-ascii?Q?6Rh1NfpBDVc4zz+ArmSVbffc2/8f3c56VCYmZ49FcrNctueCk49hXO6tkQ20?=
 =?us-ascii?Q?sl9T3+OGo5a66PxNk0jvlQR8DGaCWDvdaZDa3NMqZc7UFmAmPpikxNtifQtF?=
 =?us-ascii?Q?Rpk4njBk7D5/xtGeMR+hLa+knViEqPUDtWxe8yXo2jv6RtbX8kbadXbXmcRu?=
 =?us-ascii?Q?IKdPiTyvtdq7y0DQY1FyCSiKJ5doFS926onEHV+ZdSUHpGzcK44dLVhlfnRH?=
 =?us-ascii?Q?UNLsP8AgaxXxJocTcmhPLQ1JJ78eB3l5PiacvSxHL4ij5mRbge7KYDxArHdT?=
 =?us-ascii?Q?pdXN6ZZU4jXLoUvWK8+I+0Zv/iuy9nm6j15QaI4Eer8MYzQkcYQtgm3pUrUq?=
 =?us-ascii?Q?GrlaIVjiz0R7B25LKYfoQf3LMjCuaM5BAWmgWc3E/qokBAuK9o1NQRQlhkx7?=
 =?us-ascii?Q?Ro8AnklktVb2kFVmi2Kt1ZtmdExvlsA8gJsIjtBCfy0aD76YCXpWtbkuZW0D?=
 =?us-ascii?Q?nHLaugeHY9CkinWS262IYaclT4+wF/2/iq/qZ4UN0A3D8NRSL6lTR6zOu3+v?=
 =?us-ascii?Q?Z0pYipmKsZFp0F2k7KrQq/dJAmdc7SZglfUCH/GofFKj7XmhggNZOLOD6QRW?=
 =?us-ascii?Q?zUVap6amCFhxnGs61eYqVT1GWmnZaKiddSqleto9RvHGgtx8y8uxZN4+yfLS?=
 =?us-ascii?Q?VwDM+NuFReTpGZNLaOkGt4tOnvvlB9hPzBHeG1h1bKm4OIupzSm9GWj6suA9?=
 =?us-ascii?Q?U+KclDrA2ALFqLzkpDZuViWO539jkF03TugO03jIQOOjvUMWWzjtSaOS65HW?=
 =?us-ascii?Q?WGmcdjVuakR96oqcINu8hpSCOKsFvlAFIp6XqZRL0dMKdaSLM9FDmIsd0lNa?=
 =?us-ascii?Q?E3nKxellmsEoBjaQM6j4MU2jh/Rw/shAR8cA83iTk13HtzSYLgZVUW6mgrYm?=
 =?us-ascii?Q?GYqe0ItDuBM30Qm3iGTHY1uubARC/aj85g+izEhyE6vWQCnCWmup95jIBC8q?=
 =?us-ascii?Q?+qP6KAen8P1Z/x/AlFxxsma+SPh6dx04KeExQVSuzxJMvkVace1MXqh7m8HW?=
 =?us-ascii?Q?X0lj188Z9ytvg9nh35PS/JPI8CqXEet4MZHNLZJ/ePro95ATMIto2GTWAtG/?=
 =?us-ascii?Q?TqWysDaQ6tpddxQkFuE56RhxLOEMf4bIC+qNuWZ0uvevvhxspsKzN5CWoP4g?=
 =?us-ascii?Q?fz+eDKJg95DohmAB+lD7f1J7F91nUZFxCb6YRkEoT9PmXo/6NCLG3+/HDsgN?=
 =?us-ascii?Q?Lsqe/1mOpcP4UcYbprlR2YwzXK092myt9zm30EwD3AKIvB/b2SgyMGT207Y8?=
 =?us-ascii?Q?5rndIru/ELaglB9rwOCMG3w=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01436c24-714a-4b28-5e4d-08d9ec717e0e
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB5771.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 08:44:04.1841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CMzCNspv6NxC4bDaWixax9uZSbIxiMZZ1sg96HjNQqLeV0onqipanrzlILC28cr3KFZW/DNU8bhi2JLdqalxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6211
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the timestamp to cyclecounter in i.MX GPT driver
for input capture function.
Add compatible support for NXP i.MX8MM chip in driver.

Signed-off-by: Kane Jiang <jian.jiang@nxp.com>
---
 drivers/clocksource/timer-imx-gpt.c | 11 +++++++----
 include/linux/mxc_icap.h            |  2 +-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
index c6aa1462e441..816bf4e123c3 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -417,22 +417,23 @@ static irqreturn_t mxc_timer_interrupt(int irq, void *dev_id)
 
 	for (i = 0; i < 2; i++) {
 		struct icap_channel *ic = &icap_channel[i];
-		ktime_t timestamp;
+		u64 cyclecounter;
 
 		if (!imxtm->gpt->gpt_is_ic_irq(ic, tstat))
 			continue;
 
 		imxtm->gpt->gpt_ic_irq_acknowledge(ic);
 
-		timestamp = ns_to_ktime(timecounter_read(&ic->tc));
+		cyclecounter = ic->cc.read(&ic->cc);
 
 		if (ic->handler)
-			ic->handler(ic->chan, ic->dev_id, timestamp);
+			ic->handler(ic->chan, ic->dev_id, cyclecounter);
 	}
 
 	if (imxtm->gpt->gpt_is_oc_irq(imxtm, tstat)) {
 		imxtm->gpt->gpt_oc_irq_acknowledge(imxtm);
-		ced->event_handler(ced);
+		if (ced->event_handler)
+			ced->event_handler(ced);
 	}
 
 	return IRQ_HANDLED;
@@ -802,6 +803,7 @@ static const struct of_device_id timer_of_match[] = {
 	{ .compatible = "fsl,imx6dl-gpt" },
 	{ .compatible = "fsl,imx6sl-gpt" },
 	{ .compatible = "fsl,imx6sx-gpt" },
+	{ .compatible = "fsl,imx8mm-gpt" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, timer_of_match);
@@ -901,3 +903,4 @@ TIMER_OF_DECLARE(imx6q_timer, "fsl,imx6q-gpt", imx31_timer_init_dt);
 TIMER_OF_DECLARE(imx6dl_timer, "fsl,imx6dl-gpt", imx6dl_timer_init_dt);
 TIMER_OF_DECLARE(imx6sl_timer, "fsl,imx6sl-gpt", imx6dl_timer_init_dt);
 TIMER_OF_DECLARE(imx6sx_timer, "fsl,imx6sx-gpt", imx6dl_timer_init_dt);
+TIMER_OF_DECLARE(imx8mm_timer, "fsl,imx8mm-gpt", imx6dl_timer_init_dt);
diff --git a/include/linux/mxc_icap.h b/include/linux/mxc_icap.h
index fa5ffdf3b589..292c15b6b028 100644
--- a/include/linux/mxc_icap.h
+++ b/include/linux/mxc_icap.h
@@ -7,7 +7,7 @@
 #ifndef __MXC_ICAP_H__
 #define __MXC_ICAP_H__
 
-typedef void (*mxc_icap_handler_t)(int, void *, ktime_t);
+typedef void (*mxc_icap_handler_t)(int, void *, u64);
 
 int mxc_request_input_capture(unsigned int chan, mxc_icap_handler_t handler,
 			      unsigned long capflags, void *dev_id);
-- 
2.25.1

