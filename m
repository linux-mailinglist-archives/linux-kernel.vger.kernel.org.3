Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513354AB33B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 02:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348382AbiBGBxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 20:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348292AbiBGBxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 20:53:43 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60054.outbound.protection.outlook.com [40.107.6.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F66CC0401C8;
        Sun,  6 Feb 2022 17:53:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoRX69ETSzuqGfe16bxCR+r633RXdbvcWxYik97ThxGapDk7yf3EG7TFk93vW81AN2cJy+YDot85qWs8TJSpw+hT665EKJPxT8g0zGNGqJ/of3tEajFckV4dntn17Xl391MbK8kSS6vsZ7sAQrHMyXLK5vRvy2ABBRse6NthtWtKMXpPJH4p9uALBtZz7qsDg/Tw+PE6h5DhsCxo8B56iSUGPv7RkI8ZjFXL5Ous5CqWyx3cWY+ESfDjGctnpvKLo1Zur84B3pnxSl+MVEaTeCZx0z6dqfewuRBVQWRyNnlHpXEYAp3rXZbcZx2wNV3hJbmjc/dAje7wPWhDqwaAdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/mYgjP1X/sEqbEKahMjLus6ygwYUuPICUDXCPknzgo=;
 b=ikWIiTtht3KamN5KBUP0ED8gxBKevBXjMNyxL2Zsio1IIkzcOoOIbZPwYQT0RfGDu38fiRbZUk2XatI4ryFfadHlo/Sj4ql3tUPa4ytDoE0HAkrfqrYOStAcrY+jQjU7DeTDiEptRQwbdaDQUHWTrI8bmZFCJdES3hCwfLMDxoloMqScDKPB1jJOW+RR+gq/acAfLMHJVXF/1XOEJl/Mks9sThHgQH0DliT5CwotaVRrBjOc0aMH55zvIpfe+xuqp4G5fQeBcv5mbojhZjgX3DxoURpmQQE8ZtKkGG4tbjwVDDDMtHpZMwGI22xGtO3jFV917NnoRLvbwHYT0OgnXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/mYgjP1X/sEqbEKahMjLus6ygwYUuPICUDXCPknzgo=;
 b=jULV9RD+2FWvUo7gQ5RmwLFX670L6f5UNQp7qI7HH3WcVVehfIPFNnu9grhnGa+vEgvetWQRaOqXjUNgPXWqfvhoPyX/AlIr+pMgrv5szuJ6EApM96Otkh7O5GQakQu4gu8ZAIBQ7HNnKX0tWxJgWvdzjz0zN9lSoYoeBsfd7kg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR0401MB2493.eurprd04.prod.outlook.com (2603:10a6:800:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 01:53:39 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 01:53:39 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 3/6] mailbox: imx: enlarge timeout while reading/writing messages to SCFW
Date:   Mon,  7 Feb 2022 09:52:08 +0800
Message-Id: <20220207015211.394297-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207015211.394297-1-peng.fan@oss.nxp.com>
References: <20220207015211.394297-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0152.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::32) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e3bb10a-c7c5-4678-5666-08d9e9dca94b
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2493:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2493209D69A12CED5F7F2125C92C9@VI1PR0401MB2493.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hxorawF9BbaTLHUL/4gBoN/pKDChfwqZvXJc1Zv9t/ifmQ3luWkV2c3/urQmLDhkf1RtmKvLSba1HfibyHFY8OCiccejbKciiBaRbzxN8IX+GXgZv+pRG2gHbr/y+TSxEoZx+ncE9HarZqv236IlNll/FQRVFnB5pygSbjXV1nNbD4HDB/pgt5UYlagJIqYPPhgC2MIJq2AcGc256mgLnBImsM2s/3GZ3HMtvxlg7D7iTLXD3RnPYWP5slYiNehjFHLr2TiLVqfneuSJiWYNQhl4Uyn9p+6FRPb8L7IVrN9u9cH3cjE6ubjAX8MEprN1dEWeXV5NyWySVmmlZIVpc0IAtPeblict4eg+7qHl3iop+yt4fiClYn3Ds6MPCVxJFDNQSjABTtzQYDdV21mxP5q02LlhqYkKVr+xE/aBuO5mdpiwhf9P76XPDGLg37ZbApj3NbRISYPTYqUffzDrwGozcJwHw+tyNVIBD83Ops0byIgxAtQr5Rr2mYAeowKTXYcz//hVtxI4bQzU3v+2IkJmp5vCy6SmhhckUQv2+2GFcadJbuOq5NW5oKmYWLDkQa3YEgmuUREDjDKpHqauPmQqQvA3WAMnEJv8jQrCs+htmz7fLQwLqYTWWZ0F/xbmEYjM5DbCXzf7f4FIIOfc6Cgh4uBOtHXdN2ITMQEnFiOTrbcTE8uxb3r6z0CYbbinxzEA+Du/505pGlZ9cehin/4lttMFTec/IAb0ve0nLDvkEFn6wBto06KAYFao4Dm87DnWQzdrf+efVENNRLLqJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(52116002)(1076003)(6512007)(6506007)(6666004)(8676002)(8936002)(66946007)(508600001)(2616005)(66556008)(66476007)(26005)(186003)(38350700002)(54906003)(38100700002)(2906002)(316002)(6486002)(5660300002)(15650500001)(86362001)(4326008)(161623001)(147533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pyChvi2FT+pAkIcr7gYNfbYyQIEzTryW7ZOoHoSjjpOLRH3aJUQ7eZCSf/SG?=
 =?us-ascii?Q?7p/N5/IB4MHmdeVZOPwE455+E88AaYbxJDWqGP8U92AKll+ACOtk5ytR1D4f?=
 =?us-ascii?Q?F/ri/f90XZvG8Y1KrjRrfPYeBY2VLz1lh9dAWb20B95PtJUCZAyDKjqHGekL?=
 =?us-ascii?Q?Jt94Wrv4ArN+oYDWagl2uPC7Qroz+0L+c5b7WvKholFe7NChV88e94gg+27J?=
 =?us-ascii?Q?tTAoiVKsBA+jN1PI3zewtkctO+GotWKGeC2EoyFzY3B8hBnfbVTP6TWwUF20?=
 =?us-ascii?Q?VUDPCmjO5Lsgs0Pho9iK/SCjkwTXp6zvc47v2+aC75O0NoNtKpSoTYb6QuX+?=
 =?us-ascii?Q?+3j+xv62G704GXcZCfRo+VLRS6WAZlccTxPmYCTQhkJ2kn6wbdmr2joZ3fXC?=
 =?us-ascii?Q?vrYyUtICMrfhDJBienvkHMb9B0Akd/fQ5uY9udcsnrWmkdX4b1t/kA88D6Np?=
 =?us-ascii?Q?7RQ+ZsE1kXPWDLT6W1FYLlxpLxqmSjKuDd1ReEqMFj0nd2rmJz3kt9S7va6X?=
 =?us-ascii?Q?ie8HUZHEl8jLv4p9OoYEHuyX6ZtZ7h6EQe3NMPxqKE/6fsl9sG/8fSrxvd0V?=
 =?us-ascii?Q?zMl8ffA1VGuUXilJEOlEq4tXtiODWCxSO2UbfOKAN9c42IVzMkrmv6pdK3ba?=
 =?us-ascii?Q?HDBBGVjtVVBJq1ClFyoLVywU75GLt9CD1sNRCFFStuPQgbAVC+/EOrCXSxKb?=
 =?us-ascii?Q?gfXPHdCbxcaMVXRl+ssXiyoUqklxB0D24og8KnNaDXLPVcm5ZfGGMAN3a9rO?=
 =?us-ascii?Q?l6GGrr3K5JKT7S7o0+Zkzhn+fxFncVzE+8fySvBVIz3V+DgEbqtkMeVp4bQ/?=
 =?us-ascii?Q?Rexk8wT520N2NMIXSvBl735dg8bPaX6Al3GFt7wfbs1EZExLO1lqhRPyHO6w?=
 =?us-ascii?Q?qY29rPUjXfY4ngn/1c2RqXX7YyUfbH94COX653NBWHSbOb9ikgy3ogHuP8OT?=
 =?us-ascii?Q?h9+CvmPlY28vFzvBZWvHIuDSNvi5hzYnN7/jt5Yfxy9CTdXypYpDHGNwHh54?=
 =?us-ascii?Q?bfZ/UZ3jky6wQWNHx6EfZsvvVto5Ae+MImBfWOu4BFIjiFBBqcT9xX/c9uCI?=
 =?us-ascii?Q?Cu024yXPO6tFTQBrpr8BUha6fsUvEsKvT8FZCbuesS2Cn0PVIWtkQRpmVVUO?=
 =?us-ascii?Q?tNwRU90LRKrn9BfaRQ2lEowBzRkwRaO7jNCEt0L72ThxD+qXuCqv86TbNClW?=
 =?us-ascii?Q?WlbieBwv1q4kUcUvwjII+iQDjZ8+PBD3LyTVOVzr6DUJXznVGc43t9f1rM1u?=
 =?us-ascii?Q?Y1OjUmRW0+lm7icD/vSvqBvN8EyZUT+X8zTgI03vf0vhAM1MODNDgpPvqFpx?=
 =?us-ascii?Q?hFKfbPvEO2hstdydKU78XYfczzyS9eG2qc2Ox/4Wxzi4SHJNvvxuWzgRwqmv?=
 =?us-ascii?Q?6jYqNO0bJsfeYFGmDFl7nsm9lYfyaILywBz5VqU/QbNmJTgpmMcggmeur4dM?=
 =?us-ascii?Q?n+4px/XUZniGn5YeevzLP4ZqbPNvKeoEoFGDcnVytClgAZrAwLBlYTd/VoQ0?=
 =?us-ascii?Q?o80SonGnXrUoTdZAwpnyzmV5Hb0FlVkLM8C9ocUEhVFTkWd592F+VHGbvitV?=
 =?us-ascii?Q?WSI1PHHAyLV+naS8LIf6FjJDLZwe99jqdIffJAjn2l9ilRZLM/x2+EgWv+TS?=
 =?us-ascii?Q?JtEE7LpchWfB3BEEqbm9dVU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3bb10a-c7c5-4678-5666-08d9e9dca94b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 01:53:39.4812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgmEXcPlwdp6dte4TPhkTzIpM4oMs4KjF29eyAu3kTxltUsZLb1MtxQcRHCVbZEpC58gAIiPY4hD5Sa6/EFI/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2493
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>

Mailbox driver needs to wait and read all the words in response to a
SCFW API call, else the protocol gets messed up and results in kernel hang.
When the responses are longer than 3 words its possible that SCFW will
take some time to fill up the rest of the words in the MU, a timeout of
100us is arbritrary and too short. While waiting for Linux to consume the
first 3 words of the response SCFW can be busy doing other stuff and hence
Linux needs to wait for the rest of the words.
Similar restriction applies when writing messages that are longer than
3 words.
This patch increases the timeout to 5secs while waiting for response
or writing long messages to SCFW.

Signed-off-by: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index a0c252415c86..a29f8006ad0d 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -218,7 +218,7 @@ static int imx_mu_specific_tx(struct imx_mu_priv *priv, struct imx_mu_con_priv *
 			ret = readl_poll_timeout(priv->base + priv->dcfg->xSR[IMX_MU_TSR],
 						 xsr,
 						 xsr & IMX_MU_xSR_TEn(priv->dcfg->type, i % num_tr),
-						 0, 100);
+						 0, 5 * USEC_PER_SEC);
 			if (ret) {
 				dev_err(priv->dev, "Send data index: %d timeout\n", i);
 				return ret;
@@ -263,7 +263,8 @@ static int imx_mu_specific_rx(struct imx_mu_priv *priv, struct imx_mu_con_priv *
 
 	for (i = 1; i < size; i++) {
 		ret = readl_poll_timeout(priv->base + priv->dcfg->xSR[IMX_MU_RSR], xsr,
-					 xsr & IMX_MU_xSR_RFn(priv->dcfg->type, i % 4), 0, 100);
+					 xsr & IMX_MU_xSR_RFn(priv->dcfg->type, i % 4), 0,
+					 5 * USEC_PER_SEC);
 		if (ret) {
 			dev_err(priv->dev, "timeout read idx %d\n", i);
 			return ret;
-- 
2.25.1

