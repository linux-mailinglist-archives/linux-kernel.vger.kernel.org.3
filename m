Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9994F54DBC0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359420AbiFPHce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359468AbiFPHcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:32:22 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2043.outbound.protection.outlook.com [40.107.104.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1B35C772;
        Thu, 16 Jun 2022 00:32:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lw9g9+YQ/KEKvNn4iA+mNcl5XTP9RFauREzgCDdrEoXpY0LPb4BZvXs77580kzg/pdEoIX7drXWbThz1oBMizCPEta0Ta3IVnDT7ZAKcHu8crMQ141Zat9GfT0SJo2DpfRUcKn9Rvv7GbLY0m48A67VpWyC0lFhdkFYt0re9juAIe5MKxgZGnjVwhFM2f1gA2u5dQvKV5s9KyeXL4r7GQhbQINsdZEkMzSLNuEWuxmJwQqxEb84LriiRagMEzIcUgOcCSmKHmz08OYiNLmkEvE1Zx3GD1+rPo/JUcbxBOynKWD3v/LYedNkU2piTc4C18zdm7zsJht42h+Swes8/jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsCBv03YMON/LGFRqdyaB7553gxFeYD3FG2+X/3brNs=;
 b=l52CUkmCtQGNpQMCc3lpTRfuNKfkUDHun3o5H+v6wf8mPRie/JyrXl2GQicxnqr+asW3uli+AMgoWMBJwEGZZTlYHV/UctX47HXEcD5XVyJvaK3ugVe22w8l9lK95wiJ+b+wPZtuAK9OWSBMcvkX80cwQ46mwpSEc8h5u2iBX+xLD3uA3FMj5zMWA7UlThYM8UOvKvwV042vzuzF1k/RIiyZMHEacTEVWs6YR1Z8noNC4LLQ7WmKryxlxCSfVzqrxZlpLkBPfP8PNkf1bQZecxqYBMQsR5zpJcSeA75HPF+m+HNhT+SFiLViLiucWXYpakH9p99FBRsA7iY0AmzGeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsCBv03YMON/LGFRqdyaB7553gxFeYD3FG2+X/3brNs=;
 b=GIfsbAsHH5wW4FfNb52ETUbug0x75y/P9dMb2P5gtfwhNqQty5kv5XBKxn6FYMUq/3+RU1SZ6aLa9uVQPcKq0eTzE58CVvbVITZgumlBxCMZM2qqcYpyRL+UZ3qoRCHVTJ8cj0/S9C7xGyLbqPjsabD2okpq1GcYhvZat5g61J8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8435.eurprd04.prod.outlook.com (2603:10a6:20b:346::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 16 Jun
 2022 07:32:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5353.014; Thu, 16 Jun 2022
 07:32:12 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@nxp.com,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        abelvesa@kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 5/9] interconnect: imx: set src node
Date:   Thu, 16 Jun 2022 15:33:16 +0800
Message-Id: <20220616073320.2203000-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616073320.2203000-1-peng.fan@oss.nxp.com>
References: <20220616073320.2203000-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0121.apcprd02.prod.outlook.com
 (2603:1096:4:188::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7548e98d-6789-4f0d-0f07-08da4f6a53f4
X-MS-TrafficTypeDiagnostic: AS8PR04MB8435:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB8435B4D7E2CB737E8E272A42C9AC9@AS8PR04MB8435.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D6OY1rSvy2YOj5Re49r4K0jyiKyImL2Pnk9pcjyc9er1Pfh+RQebptCKDENQgp/+qUveY4mTYBhmVgN/pWXA8otrHEF2mhVbfq7QRcH41cEqEHe5KMQJ3QedMc9pIx2WMzDUxie7gEkr0/s+NShPVGv1ZRJdXxMkQhJsPZ+IznRB8os5VVMgFJH903nBMLtcr4ggXisVz3oIbfXVpYa2F3ZzUBY/7EUS5MYYld/tg+XVpbZs2jsylX1LYuUF/14UcftnbnS0GkxGxMCnGtx7P6VhjDurM0SgHfxDV3JsyIqonOiB1i77DThj3018UII20/9zNWIFCi3uo6t5PEqJ52nfeid9lN6XMGtsWS5jlAb4mQayl5nmXqOOrQErXXZM7R6Xf/JMeGUv+T3/LGn1OLgxaGo1S41Jnt+8PEuoB0oyMRJ3jYy8LOt0cSLs6s8IHFWZWuGjUDGJk7NSFu3gUSryR3blFauTtpcp0YGBpVTuZtis+9BuwGzlIC0brM2yoldB34qt7Xc61F4FyAZYxhyB46s8pcMWd+ibJPfrorDTVv860PmkXOTl2Cl7pvWyie5Nv4bDUX9aeUd5xyh31WtBpcJjlOvsQyjIMMEBx6JY70cujPXvC+YPFVuFGMOgAcZigXh7ZvJy5WdAADXAg/Sigt3ttBXeMTJVI0aqI4eminNTylZqo4y526a6es9i2pAkSlJZelbiPgNSkIzXaEyXP1EzhkL7+MrpQSC0Upw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(26005)(316002)(6512007)(52116002)(66946007)(66476007)(4326008)(66556008)(8676002)(2616005)(86362001)(6506007)(921005)(5660300002)(7416002)(4744005)(38350700002)(38100700002)(508600001)(2906002)(6486002)(1076003)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JoyGCYTtRkxKPv0KXFbyDwV/ovDD52NXgYHdKG++5g6E/xhKHJuvcpMqKBX8?=
 =?us-ascii?Q?chYhiBxgiSE6IKoGJEmvpTPqshkMYnoEdSfSlt9PTtPYqkFDK4WoeLznSHKt?=
 =?us-ascii?Q?A+UMdpKrSvse8xxTsEmOKyBec6Ee3lEQu4c4e8WRvWeOoxgxK08xJjYQpUtf?=
 =?us-ascii?Q?aH1Prgf5kdn8zptfwU1xNgv/+IzpR4qT85ZyFyIRaLSQ38knVNotq8B5+N3K?=
 =?us-ascii?Q?Qdpt6irb8q74oEElU8BrFL6rWUSQRnHUuKVb1aXypYwEQX+Pg87o4BDL9JzF?=
 =?us-ascii?Q?YgagojnPpFypXQJy+XW/1z5W+meH3sLqRwuw7enGoN15PLrs3ssI6nlgAfAA?=
 =?us-ascii?Q?qXyDEGCLczCcFdsw1LPxDvsQXOLL+09e1iFyBS0Wjb9NFzgueFyfOu9Z1sO4?=
 =?us-ascii?Q?TAKhk0ADYqyMPaASwKhGX+ajiOMAesjkc5LrJAMqJLn69rph390ZjKwoh5Jt?=
 =?us-ascii?Q?0hjQU2jAnGaap4H5xN7QE960ZPnD7jgyzk06TDrqNZk6tBNd5+4kZaa2Oj5e?=
 =?us-ascii?Q?Y1MtfEkX7JyHnB1Yk2ibHGWJEXOglR9EqWP9BydQ/Z28CQd7QCh42PvZpU2m?=
 =?us-ascii?Q?3lfwfC+Eqa7TuProCSf7gXeklycLoz/eXVoQtDLTjlHll/5VPvU4kZdn5Bnh?=
 =?us-ascii?Q?3yPeZJ5+a585ZjbznApTVwV8QB0ovWaJlP2Yn5wNctb6OQsJAmWt+Wb0QX3W?=
 =?us-ascii?Q?uTcb4BJYxcne9WtDUncR5LcaepN9zENBVBei0LSWzKZtCjMBNVjPixJedS0N?=
 =?us-ascii?Q?N+sI9Epw8B/TOFfki/VcJv+s4uKeVbdy/l6fuQ5ruRqbhjx6G6srKSeznraR?=
 =?us-ascii?Q?gTBPR6I3yyyiTIv2LX1m9xNmyvFG/cWjSMtBPkHqpdqxG9hweim/vKfOtEu8?=
 =?us-ascii?Q?KjfalH+PUdvDPyEclWAUCP0n6Qjymoj7gPiXe/DmIbaQ6yPtMG+l3HW5CvlJ?=
 =?us-ascii?Q?9xPor/kxnmSAFwJFJXKYil9dBewhnVIloN7Jn0sRVjzEfwUDZ86cLDW+hcc7?=
 =?us-ascii?Q?6Oglus4ETkfzjlpLRcJ8+fmU4iK91ODpufxnBj86QyAHw7RvBlTO9ougPpdC?=
 =?us-ascii?Q?RVS8SDk+PLbzNQ1hS3o6iV7ZMpWWtRIWNrUYpHQyNsEzwe94WfzsKEELU4aP?=
 =?us-ascii?Q?ZE8T/utUm+uYGFeJ8qBFI/1nq7YBKWjbrT4ixuZEOYaOrLVzPWzgL+JT+HOk?=
 =?us-ascii?Q?FnfTge3SFB+iU8jj6Gcawahtbo04VLTxsrGFr5ZMc7LHfiL9IgZV/HcIKy7w?=
 =?us-ascii?Q?vZXVxT9vL58i8lT12umVrlEwL8BQzcOapEZx6VJvmchYGDvC3J14dJCTegIr?=
 =?us-ascii?Q?WgQI/5iwALZDLpVjD+PoI6CKjTHII1tccSiPhDz4K2knEBeaugQ1lHdMrFcJ?=
 =?us-ascii?Q?Phsf+F+yiO3oiPjykljQ6bQoyjMlQlJLnjts2pMLat2vc2MaLwKavAITMRe6?=
 =?us-ascii?Q?ClmrRmoTQVu3xIYlTnOzVdNLVlLdxGESveCfjAVS+Z0WrcYqjpjvSgAzdW2g?=
 =?us-ascii?Q?SvEJNJIaLTjRLG0Qu8lZFxfiZV4FDE+w0CILMC2WFxZ9kaSJ8vd1pyEjfwyg?=
 =?us-ascii?Q?bHuf+jmtE5hLryGXBB+V95QGPBVQ7KkhtOl/A6A0q6TQq2hFTunW4Cwr20KO?=
 =?us-ascii?Q?yBdiZjI5VGjinb+E56lDAoJjOvVDP2MBwlaAsMaA7u8sSnPxe5yNjrheE2re?=
 =?us-ascii?Q?RHLq+DYBQRx3JobKDaCtV7O3E6yCw25DLxeNb8+UZuR865/BpWyPyLl0N90e?=
 =?us-ascii?Q?vmiqGEN/SA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7548e98d-6789-4f0d-0f07-08da4f6a53f4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 07:32:12.3727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q6pUsgQvYER0xctY7AlewFAOdeekUp0W96vUOdvLFlF+Y8nnab+9qRM+HfGx2WOk7ozQy+ygW1mfScCL0T138A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8435
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

When set QoS for a icc path, only set dst icc node is not enough,
also need to set src icc node.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/interconnect/imx/imx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
index 4406ec45fa90..9b83f69945d8 100644
--- a/drivers/interconnect/imx/imx.c
+++ b/drivers/interconnect/imx/imx.c
@@ -61,6 +61,12 @@ static int imx_icc_node_set(struct icc_node *node)
 
 static int imx_icc_set(struct icc_node *src, struct icc_node *dst)
 {
+	int ret;
+
+	ret = imx_icc_node_set(src);
+	if (ret)
+		return ret;
+
 	return imx_icc_node_set(dst);
 }
 
-- 
2.25.1

