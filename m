Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC4A529AEE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241549AbiEQHf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241437AbiEQHe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:34:58 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B4C483AD;
        Tue, 17 May 2022 00:33:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKMUIgrn17cX35RNvILQYpL68wxyKfPTbTBtviPThJLlchZ5dtTxrDCpMiS42lf0EeVIrjRq+tx5FK4vRZ5BAtRwmpJtRNGkQPVZtfKGNX66vZcN+m7ggIhUy21DgrC7yL/+naFvkriSIB1aaSTIMwAzNy5OtNDdNN077kNz4mTVFlcV94yIF9VJG6/cH+/QA5KcNs6Rwx0qKrY90iZJEiWC7odxLTvidOpNEKbh39FEBQRC0OpYmu8JLueO48w6T5kblhMVRtkcy071uMnmhSmbjjYQx+cr0efcOtv7ZdILW2O0pr0vbZXQQjotpjrPiG4f2ktRIWH9ya3RD6ixlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7sJFKE8OzJWJ04tzOZAi7h7Inmb7Y+U0kdlRX2bELPo=;
 b=aVSTEZA2UiqZXo6FOvY6Y6Im5uH6g2OcIvdhZfZXjCeUH4MHmk6EBFitz6iwQN1OpEcX5NLYHXKzM0yONSOfVnE8bt1ui9458Ot+KQJOA7BIPcnHlwnaF14JMXSkOU3KZJXBcMMXf8UgGgDjrb6dkjVEo6yyBdP/8yLdZ1ZRX3q8TGuoMc/PzlS7lq0WH1pMco6hodz230SNwxcHqNk3LwnFd/yCVE9R3hn3kmvvO0S+GMSvMMsMmRqkf6v5URMyKo0N+BdMqZ4JiWPcmvyk9IMNF62tCay6lxRvtlPWcVYXdATZEm+DY8oZfgrC4WAzhKvyu8WHBa5LtM7zYpQ8pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sJFKE8OzJWJ04tzOZAi7h7Inmb7Y+U0kdlRX2bELPo=;
 b=Nq1XUiajvG0UBKVpn7qA4BWrDXGkQ2si3jgRZ/tOsgzXgexZ1jrdG5QGDYfyu2CEK+VGRrptp9kP8top/kGywQfC1LOb0L9tvx8MbEeftLsYeFmHv0BK6ru8pQENgycKxP3L6oivSRjBMoBjhCNhQzUe9NkVZCPJRT+6ekhTMDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB4375.eurprd04.prod.outlook.com (2603:10a6:20b:20::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 07:33:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5250.014; Tue, 17 May 2022
 07:33:37 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] dt-bindings: mailbox: imx-mu: add RST channel
Date:   Tue, 17 May 2022 15:35:17 +0800
Message-Id: <20220517073518.34474-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517073518.34474-1-peng.fan@oss.nxp.com>
References: <20220517073518.34474-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91a8a0bb-7df2-48db-e288-08da37d78e71
X-MS-TrafficTypeDiagnostic: AM6PR04MB4375:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB4375D8E540BD1F49F5731192C9CE9@AM6PR04MB4375.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cF0VVKpy6BNjcp+wgfisuX1udqvof0h9qAnPxoBiL4b+D2BPZnsEuYbFU9oIMlPDp6NS5settr+Cub7l18K5VMrC9inPQmLkrfN9NWw96/crugYIxZhfDMv19r5gzpi1Y7ETI+zUqAvJSsM5N81w+/gA9t9jgprIliMJR9q1u4Exqlww6Uh+tPzkCS8ixyclOinhDrKlgp+H6PlTJLHWSFgydlpeSLCquetY2i0IG6JjPFgL6RPfj21GNB/UcwE8NVhls9+hwIFvJ4QLriFCgt619Up+vNm1KoSln8yFcVpIzZPYRPoL06ojyQBELSAm9xnw0GS8xtJNLurhxVvbaahwjpMZC6O8knxSLKXV9cjLuQkgG/kQmrNehjd+TFBYB0U/R//aA0cPwhcYXLMruMpkbTTtz5jXCifvh7Ml0O9h7asq+892bVZHn8utRJN56/qAEjndWfwo+VaY7zmnCKU32NpXsxTqY9xWVD3TYUBMRoqXY/jwTmSw2C4Z7lANj6ffz+2mk/CB+FS1u6gprvzVnXEqSwe09VS1zN5wp8JRhgJFofJpBj35g6ok1OAPyz5FkL9HRI0KHUdPb4Ze669INh19FgLidD/97Cp5YR4bhyGI0P2ItFLfmYMRL8vaHCSu1l+ilV88nuk0Znsooi2lxqX+rmwwx8jgfwAwqZnMggybcOcEm+4rLPc/OSyxT2iEIfTHMGi36Ps9PYCN3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(8676002)(4326008)(66556008)(66476007)(2616005)(6666004)(15650500001)(316002)(38100700002)(38350700002)(86362001)(83380400001)(8936002)(5660300002)(186003)(6506007)(26005)(6512007)(6486002)(2906002)(52116002)(508600001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YdqE4em25CKooPgmeNB18K1gc265gixjrpftWXSwSxxfubzmvXPTC/G4kv/P?=
 =?us-ascii?Q?I6apyfLHsTLAiZUBmQf5+vBqrkQ97fw9RWp8uoeloNN9QhTZpZQlCDWjmA2u?=
 =?us-ascii?Q?P7mVL0lpKF8hRdUT5i1/41JAzztyIPBBZ6j33+Ch97hIYJOMRmQGeGBxxj0U?=
 =?us-ascii?Q?OPza+yggNqmnqwpap1raTcHZXZFv9auipLuoKOxnjo9dl27Su0RtnpGYTR+i?=
 =?us-ascii?Q?6xS7HkfuVUJXQXmsPeyJF6suKjjN3GJo4T+VP/0fGW2Dh6BY3ydDkuQcLter?=
 =?us-ascii?Q?KGmsBTt99Pb6vJwMRaifD+5aRYpzbKFlh7YrxOPOHDkumfIWNcIM0BkE5S4Y?=
 =?us-ascii?Q?5VbhT2J7ckJygj4rqdVDlfMhwdnHBBq2+9KdzSsbNvenOYxA0nQdrZoHyJNk?=
 =?us-ascii?Q?JLrsoNXzPOohj19aJXvqJwISLqHScKH4zJR5nyAxH6pmts4AYKB4r+O+wbBp?=
 =?us-ascii?Q?S0DEO25kjMpW5edMtVj/7wAYGPhzCnHmFOpWSW6Y/coWptgbmp+O4ZWbZ4Of?=
 =?us-ascii?Q?h1ZyHKwg7JXzpF+9+jPq56Cb9W8NqTau5/BpshrSp4tCdT2SKObLLGUvmV34?=
 =?us-ascii?Q?g4YvG//FgQWV9cJOwEmFIdGfmsx/Ku4HefmtBcuona6GLqcfKIUzU0xvPoPD?=
 =?us-ascii?Q?U6X9ZoURCZOJ9EkRlwesUoxwG6+/GM4rmzb3WZVl1HFiqoMpNorUBiSguWBY?=
 =?us-ascii?Q?4xFxpEUHCDUVLnxdmvWgVQDNstP8q6GchVhFJmlbAM+rP/0EaxMfun36ZlIQ?=
 =?us-ascii?Q?6Hd7BKkG60loXNBTzWpMT+Jtsm7QFvNvEQTUKR05FMiHqsgY0JD75hITmudt?=
 =?us-ascii?Q?nId/RN++mTRKzgaejWMb0NFRm1e0ZifmX76NCX8dIxaifc61cXKnA9/m9+VG?=
 =?us-ascii?Q?UwhfBK/pdRAwj9c6YE4o90p1LXqASGuf/pE650Ari+oZdGzOw8txEt9SjBC6?=
 =?us-ascii?Q?TvoQpnofp4QHvoGVm5DTiLNstPQyuIFjY9ad8v6AIn1+GGZnAdqL0Tn8z3H/?=
 =?us-ascii?Q?LI6kLsm0ocz/Y8p8Qla0khBiWNFvFaNmMHqzMI+ktd4hp8jX3M02NgNGaH6j?=
 =?us-ascii?Q?vXtcoHWewo8v69rmS/8j3LNplyOjhleteS9PmOb2JxRkBqNiGJmLnkR8NApV?=
 =?us-ascii?Q?p/fP8/wLUY4LXUrmZR5j5bAnisxaNciPf3J7l/OZom9R5ScFLn7MvzcLrBu3?=
 =?us-ascii?Q?AMjsZqaLjUqKz7aIau9piHd/RAMHwgvnyV3cHXOaMukcJgNUP2RdPmKc5t/1?=
 =?us-ascii?Q?NEMny9LLHCMCILPZ96vOtG3OU+Qw2x/3opO3TjO8IVZ/ln+igoPm3TfVe/Ow?=
 =?us-ascii?Q?Mi726c5p3Ex11ibwWElf5Lvquht5DXRziyI/SapFzutzT0tUA7pH2OOcjW4o?=
 =?us-ascii?Q?VKgQSkOt1vYPh7JIPe+on8An/sSSEQvr0aO0Mcs8/20cfapU+UB4hngDosHS?=
 =?us-ascii?Q?KxDc3IXZt1PPMFYsahlMRekKl8jR7rh8XkloVx9HOe06GSKNZAkaw2wsXpcm?=
 =?us-ascii?Q?m/T5jBrz2og3yvBvLeJKO6Sd2Szugj7go9i5koCFFGgWZn2sGzykEj5lPiS9?=
 =?us-ascii?Q?UvrapKJklwYw0BCbXESLjLzNwwe6cQFDxrEZat4kEJmbWyF0YRe500POsqRe?=
 =?us-ascii?Q?Wpak/1BEPOj2KVX/L6HJFlGXLtO18WQW5kiK/dyBFhvIbsiM7XN382JQhYoN?=
 =?us-ascii?Q?xsXyQroi7jlFVfqFQtkw2yr0ZGtI9spDx2dYXPEQ1Raq2lp7UTKumJ4aKOdJ?=
 =?us-ascii?Q?yJeYXVULeg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a8a0bb-7df2-48db-e288-08da37d78e71
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 07:33:37.6326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WxIOLgsk/8DZ/hPqi5N8+Sd3WvOUvryGW3Hm469fTXeo90PDpOp57yve0aV3c+0kaQt1BOqujZTSdnhDLWaYgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4375
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX MU has a MUR bit which is to reset both the Processor B and the
Processor A sides of the MU module, forcing all control and status
registers to return to their default values (except the BHR bit in the ACR
register and BHRM bit in BCR register), and all internal states to be
cleared.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index 7a86e7926dd2..191c1ce15009 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
@@ -72,14 +72,16 @@ properties:
       type      : Channel type
       channel   : Channel number
 
-      This MU support 4 type of unidirectional channels, each type
-      has 4 channels. A total of 16 channels. Following types are
+      This MU support 5 type of unidirectional channels, each type
+      has 4 channels except RST channel which only has 1 channel.
+      A total of 17 channels.  Following types are
       supported:
       0 - TX channel with 32bit transmit register and IRQ transmit
           acknowledgment support.
       1 - RX channel with 32bit receive register and IRQ support
       2 - TX doorbell channel. Without own register and no ACK support.
       3 - RX doorbell channel.
+      4 - RST channel
     const: 2
 
   clocks:
-- 
2.25.1

