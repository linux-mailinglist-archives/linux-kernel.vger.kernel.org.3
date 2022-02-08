Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62CB4AD18D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 07:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347459AbiBHGcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 01:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347443AbiBHGcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 01:32:04 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60066.outbound.protection.outlook.com [40.107.6.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E20C03FEC6;
        Mon,  7 Feb 2022 22:32:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/StXvHoCE4dUnkMVEYt7hIEK6LaXA8PqX1ilWN4wHTz/PYtpSEgUEeCACk5gmygN9+/x6S200Qc0E9o0CCJK0hqw7bm88UQDHP2HZjqq8b5qAvgZrjD0+K2hOxdkJxUOAbq+oeU1YH6c88EtOZBgZ8IL43tWglpZEmTT+ndBEN8RwaACeoSj1qyYUEMgqg9mjQ997wxzsfpqNasbBjJ4Q8X1rTQgKe3Zj9U16Sda1nnt7PhUvFQ3/oCBftZI9ZrfscCEECdZ21sTCxvlxnhqXm3VLyk81DY71C3MdJ6L2A4uz8KwLcoW2bEgjam8h+6zFO+4BEPU+NfeZL6OS894A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9BKoOi4tAOesIotZkm3ll4pO/2B/OQVVHULsgO4Xfc=;
 b=KyNX1ehEHbumVydGps6yuWUBa7BnfoMo+ftqWtKQC4o+sI+ePVKNg4E2bHUgHp9lziTqkWS41q8EmcxcqUub/xPs84eUjVOUkNEQDjIDiXvUhRhEC9Vv+Un6MhLCZqZNcICL5M6LBuRdfn+1/HmSMRoy+5j6MEXWwm6YVp4tvEUhEYWUJO1l+1zObpm9mqEq5SIJuq5kLycTC8uLo7DPEPT7CR1viNw0BpupG56JvtREpowblldwnoidg4xDGECTAUf6G1Y9hUxQ7+5alABVBdZYXxqZv1DYOVP6r+pNuwW3lO3lwIr7l/+dm4g56E306SuAZGJ+laey/EWglozBRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9BKoOi4tAOesIotZkm3ll4pO/2B/OQVVHULsgO4Xfc=;
 b=mkNw/VTx5cwH7hAzAd1cAH/b+a7gZHrC8zfbBy3e1/K9UzrZZReUh7oBIu+T9jnDVD3hs3uupmqNA+ll+7hdt7IsRPZpLhSA5HWYn0Bh3Izqxmaw2xi03MOsFcIhjBu5HU3rnfJli/fTsuJwRqetbISVJprZtP6AIQUQ31rvzuY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0402MB3531.eurprd04.prod.outlook.com (2603:10a6:7:83::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Tue, 8 Feb
 2022 06:31:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 06:31:57 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 3/4] mailbox: imx: extend irq to an array
Date:   Tue,  8 Feb 2022 14:30:45 +0800
Message-Id: <20220208063046.2265537-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208063046.2265537-1-peng.fan@oss.nxp.com>
References: <20220208063046.2265537-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0215.apcprd04.prod.outlook.com
 (2603:1096:4:187::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34cae3a1-f8fd-44db-65eb-08d9eaccb452
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3531:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <HE1PR0402MB3531B29666E3BBA773FC399EC92D9@HE1PR0402MB3531.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Izg2W56A02J/QNXrmZVu7jU4cTqkfcmC17QZ1FgF3ppyDDsqalB4Fa7w7LKOKJ2up8SMrGpSCcxbIdrx7XuMLFnoEg6oRqTu26ePYtK4W3DQiH/K8u6DMMd+PjqfpyyuKV21u+FyAQ+ezeht4pi+I8AQTpb8ot8wHHjxG90mzTaNsiRKkjU+9cloN6jK1bZzUB39LiwW+U0CUcmJYOhYKNE/J1OfLGKXLXrBabcvIMn07/WibUj9OP2gPC2EzGN3rcjsWMxp92v6p5OkIHxIx5oP7ABLH3i8/gIch+4qhmO2T/xguMjqjiwTQvZqBovFA0j8Ay96+8C/JackBtoyVNOztRDLHqOreTf0Sk847ksb2ZdKRciMlpHj6bs9izOuWxpu7jWL3SR1/FQcJeLPqWSqDrB947fThIh/Hq1tx2bbrP4DSpoiqXaEn5AY5prOWEnyGPMZeaHCWl4+9XSKgAs0BDafd075DhIE+sjZT5JfNPeZg9zcs0LkwYtDefdLhQOI/+kX6xXyV2P2o+NdM+s/V7IFAtuLjXzqQ3pdRZ3QivoovTLmIqK5Y7E+5yQ4oiOmoT9FWcUt0eRG5Fcv/8w+6njRjjsHjY4gUd9jzlqLfoA0GdHA4JBGj0mfpsF79fIH7MlC5IsiOhrk3LhGvz/e+JADnGUEo1kfBjF2o50iPZ8ayNxSG3OXacVfhQEi4251v/BWdNE2zAuzaLvKRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66476007)(66946007)(2906002)(8676002)(186003)(86362001)(15650500001)(4326008)(8936002)(508600001)(1076003)(38350700002)(7416002)(38100700002)(2616005)(6506007)(6512007)(6666004)(6486002)(83380400001)(316002)(52116002)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+97MTnTTjDukQDt812oedqnei/iL42WDpvw/JG85/qQEE9bSLzbNWoxiejnA?=
 =?us-ascii?Q?8pgR9UmIHjaQWRdE4HarH9tBaLO4L38EsGof+muj0GVBY9UVu5qgaiABAeIM?=
 =?us-ascii?Q?ZicqL3/TzqNxqjbOLscmmrrSn6cCK+P0VRToZOPgEp+sgSqDLvCf4NFZia9b?=
 =?us-ascii?Q?12Uhx1jsnb3bGik9cN5rgl561wZPWgk1E/BHP1gomJP9NSJ/tpnYGZlIl4pr?=
 =?us-ascii?Q?91JjdDu590ATFUwEzs3zFytIyFcxeQdn7Pbc0rU4JXL2+N4TvDpTDY4dDCtL?=
 =?us-ascii?Q?pZAELCX+wu9rIfYtQ1hGKh1RYnnrRWxHMl2vkAalVw2WERkGLIoKexMuOYqs?=
 =?us-ascii?Q?VTeBtK5CPHUtxIer7Lt/xRUyOTMIplVu48JWccJIN1GqLX0Mk1fZxqPO/Lc7?=
 =?us-ascii?Q?bZKpxnblicoFHIIJIicw07vkyPlYCwfETfwACaRMXIopYxZsJgiGwC8fBLAV?=
 =?us-ascii?Q?8akCDFvOWmYw4MhR2ApE4S+Hk67N6CVn25yQba9j3kbslPBGeQD7u3wp98N/?=
 =?us-ascii?Q?WltwQIfuMsHGPQSwXQ8vBXvbLJ5cpz26nZNLCRuHvrtFk9omR0fH9sBVUQl4?=
 =?us-ascii?Q?fFe8xZl96RGvwo317K22ChFfqZh3cawfcm/eRtGGC4hsQyT5X5EBhEoXHEa8?=
 =?us-ascii?Q?h90c6Rx/2UfcTve5N5cIF5Yunn0TM3VCWC2YV0Z1js+M7RsEiyFCPXRrdwZL?=
 =?us-ascii?Q?qggwiUZXMjnU+RSwn0hTNpfDAFVwSRFMtmoVW2MO+lDcBI5ZlQ5LMK1j7FZN?=
 =?us-ascii?Q?rwzAaTOHIbFdMxEsWpigiAW0+mgJ5SAUyS+dUiKs/u12yCvAkf79Q32+GYq5?=
 =?us-ascii?Q?1fM9ZwvaO0XdBVHm4iAFhXyxBZnwFqdjUgowFKD03EVVhQyfa+MkPN/h4dl/?=
 =?us-ascii?Q?H8m3iwpVmD9Qd8sTgNbOguw6HJFBkEM6lqNEcB2/NBIRdsgurbFun/yTcUio?=
 =?us-ascii?Q?5wNRAv4jgUmBuIwK3M6g+H7KElLn3iVoj3U9fhj5BQdq6EoW1fex2qZIF9iT?=
 =?us-ascii?Q?anRCXg6L90G6AhHG/quGu46S+d2pERBRm5EOkxAZ4dusNFTjAiCKfVtzq31O?=
 =?us-ascii?Q?rH/i2+JNULRxRww8PiU8YY3glDE2vmcaWJ5zjWMSkNWQOrVkWFPw5IGpcbC0?=
 =?us-ascii?Q?LRxnx/V0TFB8qvmZnYnPY2Bcsidufz2XIdE06lqUEMfKEKsAGw//5vcC5+Tw?=
 =?us-ascii?Q?eHqUoM1ttmYHqs0+ejLXXZXQlLtjmGLtvfVrekEib17tSbIuKPh09Dteq4Fx?=
 =?us-ascii?Q?Xu6bF9CmaQ6FGKMWSi6r+pQRYONbfWaKbOArGp4TNp23ILlX90j0mbvK5uOb?=
 =?us-ascii?Q?VnzWNi2D77ekCKk/44Piq9+x7jAXppSYhjfQlO9UeXa3Mao/uUw+8Q/KwEi2?=
 =?us-ascii?Q?79JaOWygxIxzoWGp2c+vKDqczsvAnDD5Y/3sQj4CMFoZA4sZH3OZ18ApmNoN?=
 =?us-ascii?Q?K/+d/6Ku6rdyJHBX7g7348HtsEPRqg8xrqdTpGw/8FYeylxAr7mGYSRVSby2?=
 =?us-ascii?Q?WSvf9XVVKqkEHY0bc0Ah0H97x58sGeaTJSJ6RQ3dDuRVmmxItFXMBaZl0uWe?=
 =?us-ascii?Q?7+nDZ5akh6O+Oo+ZBEfGluKpzYHWVu1xg1OqJHzcMqTf4MqUm8IEqEZxNV3b?=
 =?us-ascii?Q?LdccIEorlaTR6Y/ERFtrGUQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34cae3a1-f8fd-44db-65eb-08d9eaccb452
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 06:31:57.0881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UkJZCzDB4SrYMSWwVa07hBLKL5TuIdXeHb5IQ7gbgSo0+UbP6T+SVL7/bUX1OJhn1kkc3CYSx+1tPtXWXE3gPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3531
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

To i.MX93 S401 MU, there are two interrupts: rx full and tx empty.
So extend irq to an array to prepare i.MX93 S401 MU support.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index cd011ca5707e..03699843a6fd 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -80,7 +80,7 @@ struct imx_mu_priv {
 	struct imx_mu_con_priv  con_priv[IMX_MU_CHANS];
 	const struct imx_mu_dcfg	*dcfg;
 	struct clk		*clk;
-	int			irq;
+	int			irq[IMX_MU_CHANS];
 	bool			suspend;
 
 	u32 xcr[4];
@@ -551,11 +551,11 @@ static int imx_mu_startup(struct mbox_chan *chan)
 	if (!priv->dev->pm_domain)
 		irq_flag |= IRQF_NO_SUSPEND;
 
-	ret = request_irq(priv->irq, imx_mu_isr, irq_flag,
+	ret = request_irq(priv->irq[0], imx_mu_isr, irq_flag,
 			  cp->irq_desc, chan);
 	if (ret) {
 		dev_err(priv->dev,
-			"Unable to acquire IRQ %d\n", priv->irq);
+			"Unable to acquire IRQ %d\n", priv->irq[0]);
 		return ret;
 	}
 
@@ -598,7 +598,7 @@ static void imx_mu_shutdown(struct mbox_chan *chan)
 		break;
 	}
 
-	free_irq(priv->irq, chan);
+	free_irq(priv->irq[0], chan);
 	pm_runtime_put_sync(priv->dev);
 }
 
@@ -762,9 +762,9 @@ static int imx_mu_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	priv->irq = platform_get_irq(pdev, 0);
-	if (priv->irq < 0)
-		return priv->irq;
+	priv->irq[0] = platform_get_irq(pdev, 0);
+	if (priv->irq[0] < 0)
+		return priv->irq[0];
 
 	dcfg = of_device_get_match_data(dev);
 	if (!dcfg)
-- 
2.25.1

