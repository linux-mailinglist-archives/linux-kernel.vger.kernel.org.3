Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE485631D2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbiGAKqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237098AbiGAKqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:46:11 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150073.outbound.protection.outlook.com [40.107.15.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F99B7437D;
        Fri,  1 Jul 2022 03:46:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWk21Lp3evZvXGJ/ZB3b3Vyr1+oELRAH3o8aDyQp7iQAEfqKCxye1/QDIY3yAiq0oE6aZr3zg0akrZQ0ES2vH7MjgNpncYanF20S9C7euw6lRkBasgJ+aty5OcqmKLzWp1T2d9jp2Xjf3vNsh+7uhajL4ny2nYziIf2aUkDvHsnViCG8l3MdtDW7/zZVQVkG8P+mZx99mflYLbyhP39t9Eo1rLYetMTaL3nU9jT0FFvgTtdDgTlpmoD8rI6jSXkVUFlzLZqfs19PJHPwBfYWkAQNktkEzjpTZyDl/PPr0iU1TV0oqHzZpZRWpIv5UOSQi4OSvHTKI/yeaMrhp+DmSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4v1X+G8Uwsw43fPbSGEUIs1mZJalqnDugebOFaA3wc=;
 b=ZB/rC9ug2NHEJuwECLicHX/+lsAFCDIc9AJX59SoIry67UOAxX1wP4mnXZWTPlAkq9cvE2KZbl/lAycY5LEHV8R1iAYUvYxzDz+H9N3blNrk+WlL9h9Vp6EjEmoDIeNEJySkKY62weJV89dIo1CWc4ezlIDhQcRb2HWmuGPlafrduviWv58P5swql+l2TEvo0RmD+jSZY+ZvtcXt65qCg0ud+8taCxKHNuNYYIeZN8XibWiGOzS5I2YxeGsjVPYrOwhbLkVSdMsFMADrLiCMe7ydAjeohTjEmXw/+AHfTDc77PxxwcDCGESRUQI3WRujfdCkm4L7y7VcZZxkIfMBsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4v1X+G8Uwsw43fPbSGEUIs1mZJalqnDugebOFaA3wc=;
 b=FdwwrSDVyPoFKGtnd8npj5Sxsl6bLdtL/q0hXftjtjbLhXqQBPGfd6pl+ZsVylcS8/N52eoGeXvoFaoBrTusHP6PP1Dy7KcSCMBSi9xKYKoiLH7944Y1Qf7gEcgUM8DrOH6RZSCQXNdxIMJ0nMkSSpXUqvdkcMU0iRSwqm18U88=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB4554.eurprd04.prod.outlook.com (2603:10a6:5:35::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 1 Jul
 2022 10:46:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%6]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 10:46:06 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 6/6] remoteproc: imx_rproc: request mbox channel later
Date:   Fri,  1 Jul 2022 18:47:25 +0800
Message-Id: <20220701104725.557314-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220701104725.557314-1-peng.fan@oss.nxp.com>
References: <20220701104725.557314-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71762b70-7be1-4aaf-ae0f-08da5b4ee6ba
X-MS-TrafficTypeDiagnostic: DB7PR04MB4554:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aiad2bybCIDCeESMunMw2Rq5d+FBXa2SB8KuuB4ZELYH+IsjD3aSEB4d2mxe6rSHqgDExsoAAl5NzvTmfRuKt/Uk3qswtMZsKrJhJfvKNnumu+AHdUUCkHNLG+BdQqH98bK3iS884SPsIkxUC0jpBk2yLi0K93BJ8bPfyTNWHzYZXWyRRzvZosIJ0rn6uwz2pttdgjUYzmayXdeVEu7YXKeO8dobpvHNv9cFJVTDhA+VCwoZy+dilRvylgLctu9iA0XayGGKDiJEzxw+tvSijjh5HMRkuW2AJgLaR18iBt3HsyN8wpdI85aV1X2LaNSf8AMMEqx0E0Yv8YNfJW6o5gNlgIWoLzZ/zftfTOHTgYEpoKcIhl4lCtrkBNeqofY4n70+AwE8p21bngxHLUwRK7oyOSLBuAVL7VtUM2qLks8iRIiboK82ThsVYYzHpUTz1hcUVqebivTW5Vii+J2zCs93n1x5dNs5FpWbBS1Y34QPFVl3nr19xHzOr4Um6bWvV5vu8UOOEQGxBk3+/ui4rmZ8dB8NJC5Iyo8gnXIbs3s9ILp8ZiL1G0Z8L6Abok/Md54bkm2PQtypoxCtWX/lue9vk6UgxkADey6P4iNfCmltS2m1k3sk+Yos4X/Ei2jkMtE+fUje2qa2Wn2Ron7hUvdgw61LIAoF/YpQ724fPLW2LFIhQ0/F6BQyHnhwqDw/Y1j9537+X6TGcc76fpE6i6/BMiKf8mjy2TwfzDBoNU01Xg1wvtLdBAa8nVHmqojRiHKB645EUxVKDYeHjhnwcdiuAlzZheKYgwSpjlB875ZTN78kxZVZuWFO17VKu2ga
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(2616005)(186003)(1076003)(38100700002)(6666004)(38350700002)(316002)(8676002)(4326008)(83380400001)(66476007)(26005)(66946007)(66556008)(6486002)(478600001)(7416002)(8936002)(5660300002)(52116002)(86362001)(6506007)(6512007)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a/2qUAXw3lc7zTd4fdslfllaWqo+XFph19ljfpVB3bpW6VZ0gWlyz0ow7oB8?=
 =?us-ascii?Q?Yq4ngWc3xFJ0fbPH0d0CRTENFk7snllfbGFAyl/u0gJ6PHYQPlXuAUkWlTC6?=
 =?us-ascii?Q?tbbcS/XmYrRIe/AyehUDRa6XdipXLEnDYqpnE6jytgx3Hwa7+10A1yVtojef?=
 =?us-ascii?Q?VHHTfA1dfuFqsXz53mCamyo6gQ7TQ2WCTctOgnKmR2ysv49xv+zF2cSgZYA5?=
 =?us-ascii?Q?lr86vcOdgPGyabxOy7LobQKFoMJD5SAkVpDfBd/4vxUwrsZtQrC/l26zdip3?=
 =?us-ascii?Q?K6mGF9Gwz/TtX4ISW6au13tOCrI1zPY8y9mCUjXFcAJZDLauOdtPGPdsfRHV?=
 =?us-ascii?Q?3NOjR6mXvjRQE73yefNmbKqYV0WqhM/puMjzOqetx3f5mc5oIvB9drg1iB7s?=
 =?us-ascii?Q?pi+VwSG9tQG2GK0phYKUlULBu7Enf68lOUNt/q9n+K0IE2HCuuivPJ4sDXhm?=
 =?us-ascii?Q?YCmWEW5Eujz6g12LoipM5AcBcjhpb91F2kqNmvYjTPaMEUOG/HTR6Xn9eAqk?=
 =?us-ascii?Q?nn85ZKAQ7vfVa6zYarI8zPl7pGxcIntQ+9bLKn2sJB4JbdxyXDhNTT68EGtt?=
 =?us-ascii?Q?fsOEOvBgODTCrrp9UfrVr5oCXjTOdpltNfByP0qiu0umqMmfPoIHKfLVQDyO?=
 =?us-ascii?Q?563rKu8rxH5eEJQP2/kJZVC6yfejYJoSjUCzjqvTd3Ra1cydPO7ejwYFoSTQ?=
 =?us-ascii?Q?ylH4hiHvcwXADmVlqelgZ0X7bCxq+siua4gizCjx0wAKggRDYMEXVUMCrgjL?=
 =?us-ascii?Q?MuxIqJYiXI3Hz+a8OPjc63tR89JjRje+XuqAu8kJa1XcbqKB+aV2V/1yM0IM?=
 =?us-ascii?Q?ryDhvQ6oW2pK6yDZlvgy/gBJuz6Cqqn/EkM9FmkCN+/+yc5pGUvdMPVeJE/J?=
 =?us-ascii?Q?+stXsEEBUMF6WypumAfr4XAgCiOebFLYl4XeAOFz0MVm1RjHgFqTuMvvfDpM?=
 =?us-ascii?Q?0PiS0aaaCcUqVdbwl6A/060rxfVUNcgNvtq2aVWMC04Gn6HONYhupihklWD8?=
 =?us-ascii?Q?2FRFB0PWLqypvnS5lRQ7okYnIQRg1a+Oc22CayRDYt2C0Z+4qLWfPEDs/MQU?=
 =?us-ascii?Q?JUen8D3JdMJe6ES0EgXnH0lYOx3ECsIwm/uJJR6w83zNhYW5PxET9gPDemH6?=
 =?us-ascii?Q?KOD0Xx9zuH8xsYpQ1JOhfNQfzGfiYXUX+ojXugWyu69pna/81WtMD4fBYa0x?=
 =?us-ascii?Q?3BqSQmzWKjspnLa28QktFwKI+hHhuX/71qmYwBlTV/2I8gldXA1gEF/accUx?=
 =?us-ascii?Q?9zEdkO4XZhOiYXHlzg+VfpUQrAbkn/PEEkXh5IfUOa6jW6z5z0RwWWel5OlK?=
 =?us-ascii?Q?OiAny8pW7ZN26GnWreVZh01xdVhAJ0BtdaKzC8C+H2LgKUBe3V2miaoFg7KB?=
 =?us-ascii?Q?jaGROkeG3N2ikzmZmFn6B9lQ5TIvBOSxBjSUb7n71aFCbDhlkGQBRj3ra7Bv?=
 =?us-ascii?Q?NvzvQjKZGuouFgf/BwYZqx6LIbFXKp8qPBbxM2W5WmsqHkhJNr92525wz5Mz?=
 =?us-ascii?Q?WBRqJcTm5A673xFNup8HJID1R0VUUzFf/LwlmVaAM8mIWaHKjI+ZGjopLQkA?=
 =?us-ascii?Q?T43DrL9ck6GqZzf3AGm8ZWK2PXvDrQoEqlWBp8oa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71762b70-7be1-4aaf-ae0f-08da5b4ee6ba
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 10:46:06.5585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3IQHxxp775nUez9DVvgLUR9PzTWU8cfvbB2hYakKQMp+4LpCiVj7Motb1+G7g2xwYnKeXv2LkaR08v8NU2bdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4554
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

It is possible that when remote processor crash, the communication
channel will be broken with garbage value in mailbox, such as
when Linux is issuing a message through mailbox, remote processor
crashes, we need free & rebuild the mailbox channels to make sure
no garbage value in mailbox channels.

So move the request/free to start/stop for managing remote procesosr in
Linux, move to attach/detach for remote processor is out of control of
Linux.

Previous, we just request mbox when attach for CM4 boot early before
Linux, but if mbox defer probe, remoteproc core will do resource cleanup
and corrupt resource table for later probe.

So move request mbox ealier and still keep mbox request when attach
for self recovery case, but keep a check when request/free mbox.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index f129cc840931..503435ad1f11 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -84,6 +84,8 @@ struct imx_rproc_mem {
 #define ATT_CORE_MASK   0xffff
 #define ATT_CORE(I)     BIT((I))
 
+static int imx_rproc_xtr_mbox_init(struct rproc *rproc);
+static void imx_rproc_free_mbox(struct rproc *rproc);
 static int imx_rproc_detach_pd(struct rproc *rproc);
 
 struct imx_rproc {
@@ -357,6 +359,10 @@ static int imx_rproc_start(struct rproc *rproc)
 	struct arm_smccc_res res;
 	int ret;
 
+	ret = imx_rproc_xtr_mbox_init(rproc);
+	if (ret)
+		return ret;
+
 	switch (dcfg->method) {
 	case IMX_RPROC_MMIO:
 		ret = regmap_update_bits(priv->regmap, dcfg->src_reg, dcfg->src_mask,
@@ -407,6 +413,8 @@ static int imx_rproc_stop(struct rproc *rproc)
 
 	if (ret)
 		dev_err(dev, "Failed to stop remote core\n");
+	else
+		imx_rproc_free_mbox(rproc);
 
 	return ret;
 }
@@ -592,7 +600,7 @@ static void imx_rproc_kick(struct rproc *rproc, int vqid)
 
 static int imx_rproc_attach(struct rproc *rproc)
 {
-	return 0;
+	return imx_rproc_xtr_mbox_init(rproc);
 }
 
 static struct resource_table *imx_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
@@ -721,6 +729,9 @@ static int imx_rproc_xtr_mbox_init(struct rproc *rproc)
 	struct mbox_client *cl;
 	int ret;
 
+	if (priv->tx_ch && priv->rx_ch)
+		return 0;
+
 	if (!of_get_property(dev->of_node, "mbox-names", NULL))
 		return 0;
 
@@ -753,8 +764,15 @@ static void imx_rproc_free_mbox(struct rproc *rproc)
 {
 	struct imx_rproc *priv = rproc->priv;
 
-	mbox_free_channel(priv->tx_ch);
-	mbox_free_channel(priv->rx_ch);
+	if (priv->tx_ch) {
+		mbox_free_channel(priv->tx_ch);
+		priv->tx_ch = NULL;
+	}
+
+	if (priv->rx_ch) {
+		mbox_free_channel(priv->rx_ch);
+		priv->rx_ch = NULL;
+	}
 }
 
 static void imx_rproc_put_scu(struct rproc *rproc)
@@ -781,6 +799,8 @@ static int imx_rproc_partition_notify(struct notifier_block *nb,
 	if (!((event & BIT(priv->rproc_pt)) && (*(u8 *)group == IMX_SC_IRQ_GROUP_REBOOTED)))
 		return 0;
 
+	imx_rproc_free_mbox(priv->rproc);
+
 	rproc_report_crash(priv->rproc, RPROC_WATCHDOG);
 
 	pr_info("Partition%d reset!\n", priv->rproc_pt);
-- 
2.25.1

