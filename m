Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815BA58884A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 09:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbiHCHvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 03:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbiHCHvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 03:51:51 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED6622B20
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 00:51:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CykpcZXgh6Mf2D5uEs1/R2/fK2TbckWPHw2swVHvfX+GdXReaDP6lRMYNCoRG2L8auCKA2FezS227nZ2bncbVNeU0EWJDX6v/o8ed2awTGFwlcN/NmyS8kKtN3Hk6i0BYKf9VO+duMBso5ljW+j9ECop7CcaX7LxcveVb9e8tselGC1z/NHew6eSaRaSmUFJBkfmuIGz+u9Trn/9fNa9ZiAHlHpvVDkAPb/W8fuB9F/qpXJUQuGHKx1wTDpFFztcdI2oR8RNAspoxpSihan/TSRaoFtuLln+pWyYOhSyhn9r6h6tR9IOlyoftDO+Ivzf/EpAxbU5ik0280wi0/oPSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwOxdqNr3ut9nxiP5PAQw0Zgh+mjWmLSJPMT9Bxlbik=;
 b=UBvpdi01RF3JUsakEdny1XNvCIVq2U35/EvU/FrJxT9OKoYXYv3UIlh3KkAXZZN4t1++ufx562oJwypI1MmcOlWKmblAbNwB9woLOTaZYitbYfp1WuPtSZ7twq3ReyotFA781uUz2fXaAx5VfAdQ6kcLGDLpk+fSxIx3fIAZai+Kz+q6+rmMqaAYQC7lFSOag3p9XVfJ3vNzr9A6pmL9qTHds1R2o732yPpjV0hzwtpLkDp2ux5WKBDC15ZVCd3sOEkvbnjC8MlRhdEc7maqexunhlv6Q027AdlCegR48eewhUu33Qk9pKG49RXo29cfHrSneoOqvaqdr8dsqa02sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwOxdqNr3ut9nxiP5PAQw0Zgh+mjWmLSJPMT9Bxlbik=;
 b=WwKS0a3yrkg0idkDk++AFEXjEaL3YhfBePVWA4ZHBfruhGDz5qZ2dwHMMtdU+lVEZZ2VxhKPRytKBInmj5E98Ry9ot6xLKu0t4LT94CLOq8kgQoeIEq8CBfxzIosOHymYNFxi2eMCbCtiRuLOvbvh67RMaWna9tGdAY1egibd4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6632.eurprd04.prod.outlook.com (2603:10a6:20b:fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Wed, 3 Aug
 2022 07:51:47 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 07:51:47 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Ye Li <ye.li@nxp.com>
Subject: [PATCH] mailbox: imx: clear pending interrupts
Date:   Wed,  3 Aug 2022 15:53:26 +0800
Message-Id: <20220803075326.3490950-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0202.apcprd04.prod.outlook.com
 (2603:1096:4:187::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 760d07d9-4e74-48ed-0dcd-08da75250450
X-MS-TrafficTypeDiagnostic: AM6PR04MB6632:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ePoKmV2GnshSfvJ5GWuZjVtBzywYf2ffK8vz2yC2gLBbssOh1ribDCpLS0N9HV2BeJkYx9XjO8u9jh2pWo4JRsKmsBgEXtYNI6hDvXqXICvxM5Cdr/p2GupzDp8rQqTR15EkudOyUfIH8jS6OBzmNqWrDgabWu3jkXOP6wNRDb7CIET3pcM8qLtQ/ODyyRyCXzX0P/4d9meb4hzospWjtWHPwuauRqSgcBL18jutGnY+qBMt1rH6FyuL1EOY9fE2Y27d4/T86mkPtltZXl7kWwXzNcJJ5LGWVPgjrEFcW/+/SZoOykHMG3P1G8fXAIEaB3ipzq/MpDmU+8qdVkAuT2EES8IH5yqI+LU5h5DKvwqM9HMQCzB8LmZApEegSpV2inB3yE5Y2Z3KawXMrRlVOjKHxAGfqsiF0fqyPU8X4gWKB8HzI7zTPQWdWldJwpcbh/pQIQZ5oX9DwXSaTgWQT+KTDW7c3sQOlbaIym3e1bB/jcMsstiOVs9+ffAgeuzCQ5rVUdyXJvtI1nP4dJWlZt+k30REbxZwfG6O6HQNERhh2JnWTpmQbQ8iq0V3Pt+gc+uSYL7klyaOH8Duv6PyJh9BUK1IkLTfsZqIIr+qcVaidamjPJcIPj81S/ZUeiJ7fFn3o7FCBqxvc7YNyMlJlP8BVvrY49CBYjCvc2hSJKLof7H2IHHKCMxduvFDetlwc73X9l8yRVDXITpVP0SraHrjXjWxX1S+IA+XaTWtxhWakhxoW0qIcxd/wwlFAqKXt8TLhrV8kPNducXSO3QWef+f/T2E1u4GnE0yoFP9EGrILLEB+Is/CL4hcMuAxXCa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(6666004)(6512007)(15650500001)(26005)(478600001)(5660300002)(41300700001)(86362001)(6486002)(2616005)(8936002)(8676002)(66946007)(66476007)(4326008)(66556008)(186003)(83380400001)(1076003)(54906003)(52116002)(38350700002)(2906002)(38100700002)(6506007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FPGnPGozsk6sEj0cT3+Zk9jmiAn6+3hMhcU9hNtpR1H86T4wOuSCs2TmIY2a?=
 =?us-ascii?Q?CggSejIHf46CvxrqWIcmXDfSfustqOAurTxXpoxps7ggoLYC472/3UAVxIC6?=
 =?us-ascii?Q?eFA4I9w2XSTSHX+CoHdInUo7dPcUnatamq/HT3/gs87dmdM8kGYaoDF3Tsxm?=
 =?us-ascii?Q?CkJeJz/Lelm0aahKxf/oYTeuREPu51v3xGruvLSRm61MJNBWB8MniPEYiN5P?=
 =?us-ascii?Q?xBvtw/WhKsJENW47cZbd+/GhQ1HO9m9wRl1J475fQEySKUrnJ0GTnCtY+MJU?=
 =?us-ascii?Q?Yqfj9fCKTYljkpGJcfwJ2ojXMEvPygnHnY1rbUWG5UMkxEWknXrlEbJydsyj?=
 =?us-ascii?Q?Y89aBBqDihud5hnCIGqc2K8rHdJG4O48KP5gL7UF3TS/VNvAuUaISKSB3p3q?=
 =?us-ascii?Q?iIefQVBRWYDJaIUmpXaMyzbJIOU0NFyO0JkNSNtKrOCg7XBzUpFEB4phgXBZ?=
 =?us-ascii?Q?HiX4rZ78xKxy3BECYEmXDRjXWigME1/16NAWablDX4xv1E9uL7XP4VmdCc7x?=
 =?us-ascii?Q?28RbpYtIyq0OuoL1tJQA2zLDiwiddx8S+/WjNwWhCAhVNAp0is1QH1Y90TMo?=
 =?us-ascii?Q?jQw8A6TPuVt5iMwNRlbolNXUWLpxhWJxmVFESgzUt3iiTSO5+fTZrEGYD0DW?=
 =?us-ascii?Q?v0phl39U1Cx3KNgFBXzNrtxHsiR+CziUO/bwgkw2PwbyUf7hz818hT8XkNLE?=
 =?us-ascii?Q?EEmFTlxpPL+Y6j4ithXIE36jSu8iHu8XNaUUeJ1P3FSAYP6Tj/r1Pu1/0cue?=
 =?us-ascii?Q?0/QXAIvWtJkb+6gYGv+SBIiQ2/uQAr3poMsqc3hvD5THxSlLJhHzkm7S6cjw?=
 =?us-ascii?Q?ZEHVrbs+DatShyvEMz6l7ir96Hg8n44lIPOtmiRUwESiQCStIJ2DKqiFSpQ8?=
 =?us-ascii?Q?QFEbFN20ufsE/VZweS6DDIgLUc6kYqn02eKxe0TE2/z6VpvEhOhTwzcce1CX?=
 =?us-ascii?Q?z73vAoS1oobZt0ToqQUkYeAPPaYXrpagi6Th5k8TXCAB0NstMMNCBvLNW3zn?=
 =?us-ascii?Q?hFw266iVWBs7nSBpB8zTpL+h3sDW8K3z8TFR7uoGJ+Mfw2XcKbNFxxu1gJTo?=
 =?us-ascii?Q?dDrssj5+/13HZFpAfrLTI2Wz3SpwhwGTAR8VSAh06723jzHBP1H6unKgsyxh?=
 =?us-ascii?Q?tPD+f+rqJSoOdAQm1B7ilKk1mExRqfccb5+uTedZ+O1myeWMMzDqRdQns/3J?=
 =?us-ascii?Q?hJEuYUX8Hn4BpPfwhJsOrgAGdEOwiD87ZS/u55mWTnl8wbmelmj4pZe3ZiE8?=
 =?us-ascii?Q?9g7W1mRtjG9dx7OkMqqH+Z/OC7JcBWx1lKkvWZsEHYs3minTthhvMdFYMmjO?=
 =?us-ascii?Q?1Ev/7BueQNty7ibEuBpuo0S7fVMfm4517dVASOM5nViRVJVlgquRFllZzZXZ?=
 =?us-ascii?Q?Sb2Q4cCkgQNnamHVNHUB/fXu2RGzWWUhc45G0zN1d4n+YcV2FLvh7h7UKVKn?=
 =?us-ascii?Q?deVwprA3+9fdm6wnACaR9kS/Yo2to8Uk0DNiEKW2Gfzge5jrPtgCx8ObA7Vu?=
 =?us-ascii?Q?QECiadaWj7siRJD3K6r1Pt3DNhzZ40jufck31L/EjGucZCJgzvCe6lRxNBVk?=
 =?us-ascii?Q?KHFGJC511kvU7uvPHdIA0VSL4OKOPjljS2Dm98mX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 760d07d9-4e74-48ed-0dcd-08da75250450
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 07:51:47.4503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TLonmKeffHDtQDcM/B6Ktr844ed9eZ+d/BGPY/yXzV2tQZp9soNhw4d8W9PUoTJfIrm75CAdzQ8lpD6LHSl1AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6632
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

During MU initialization, there maybe pending GSR and RSR pending
interrupt, clear them to avoid unexpected kernel dump when requesting
mailbox channel

Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 Patch got reviewed in NXP internal

 drivers/mailbox/imx-mailbox.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index b10239d6ef93..4042af08a2d3 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -26,6 +26,8 @@
 #define IMX_MU_S4_CHANS		2
 #define IMX_MU_CHAN_NAME_SIZE	20
 
+#define IMX_MU_NUM_RR		4
+
 #define IMX_MU_SECO_TX_TOUT (msecs_to_jiffies(3000))
 #define IMX_MU_SECO_RX_TOUT (msecs_to_jiffies(3000))
 
@@ -694,6 +696,7 @@ static struct mbox_chan *imx_mu_seco_xlate(struct mbox_controller *mbox,
 static void imx_mu_init_generic(struct imx_mu_priv *priv)
 {
 	unsigned int i;
+	unsigned int val;
 
 	for (i = 0; i < IMX_MU_CHANS; i++) {
 		struct imx_mu_con_priv *cp = &priv->con_priv[i];
@@ -715,6 +718,14 @@ static void imx_mu_init_generic(struct imx_mu_priv *priv)
 	/* Set default MU configuration */
 	for (i = 0; i < IMX_MU_xCR_MAX; i++)
 		imx_mu_write(priv, 0, priv->dcfg->xCR[i]);
+
+	/* Clear any pending GIP */
+	val = imx_mu_read(priv, priv->dcfg->xSR[IMX_MU_GSR]);
+	imx_mu_write(priv, val, priv->dcfg->xSR[IMX_MU_GSR]);
+
+	/* Clear any pending RSR */
+	for (i = 0; i < IMX_MU_NUM_RR; i++)
+		imx_mu_read(priv, priv->dcfg->xRR + (i % 4) * 4);
 }
 
 static void imx_mu_init_specific(struct imx_mu_priv *priv)
-- 
2.25.1

