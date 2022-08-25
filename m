Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E95F5A0B8F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbiHYIdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237377AbiHYIdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:33:02 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50059.outbound.protection.outlook.com [40.107.5.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1EAA6ADD;
        Thu, 25 Aug 2022 01:32:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGEfnPcnDLA+3OIHRQn/Txv1VVhUJXvLq5P3AROGfjHAvGvWSUF2PzB+tNslNwbnk+bysVYnmtWnfwVWO4NpVoeRIwGSjxr8GyI1xx5Qjhmqdz/qRQffHOC5FGxplCzMi9aXHHjHQ4+D+tzRweQQqQm84pbof4HhMH49v1Fd2ZDBmMkbr1EdeZJyp06y3E/cS0/K65hWpQUh0h8e4iY4KRkzCsgZvyVMHqD5lmE9VVj/NIC+xIX/bxQptB3kYGSupf3k8BDCo6YUaCEiv3uoaEs/6hnNI7XyhjLmV32GN4uQBAmI5kwjvNiMm6DRYNU3lCsbRZ3L5+0Y6QhyLTznEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdq8c6LIrM/UWoQW8Y9QzYYiADG1jHHgY9JFpC+nqpk=;
 b=OAbfp5CnxLk3EkNcGv1Rk5Aqrtb+VDUW0fPEtpnS6BDyJKTWqGIb292x8bXMZq+BFVlnQZYqYK0C7eK37DVkAZ2LStJS9x5Lm7tSsfqwuO9LC+YM36aSFl5CDafsrfOaU4h32kGEVLGy084pcLzHgKDddCCK6Qto9oHSZxSrnVAvxVNu9hCBuro5HTSdqwEd4QMEcG42qdCh4vrcsbK9C/zlx0XwzC62mofk+Cn0nttypeV1ShKgtiFy4SbnotuYJioX6U+FfGEtRBEXLtroDYKoG5jCC/XIE8TL7TnPkCj/Dir/cTSspozQZ5fWrbQaKe1QVViMefM2oQuQNYmuWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdq8c6LIrM/UWoQW8Y9QzYYiADG1jHHgY9JFpC+nqpk=;
 b=U4NepmdiTtPTd83xZuiBqFvw7ytUYMdVYy6AqE/5CNeJ3wa9Ox50BVv2TGY5mC4rZcDsZ5jIb9ieRJEkgrDsJbXvUMMMoRmfC4bhsl5t8x981MkxBmr/IHiPP0LBbfs3XX+H434RsNl9eISudraCGQWBV7F1S0oo12Lx/kciNxM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM6PR04MB4901.eurprd04.prod.outlook.com (2603:10a6:20b:1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 08:32:52 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c%3]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 08:32:52 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     m.felsch@pengutronix.de, linux@roeck-us.net,
        wim@linux-watchdog.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] watchdog: imx7ulp: Add explict memory barrier for unlock sequence
Date:   Thu, 25 Aug 2022 16:32:51 +0800
Message-Id: <20220825083256.14565-3-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220825083256.14565-1-alice.guo@oss.nxp.com>
References: <20220825083256.14565-1-alice.guo@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0225.apcprd06.prod.outlook.com
 (2603:1096:4:68::33) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 657567e6-0bbd-44fc-cb1b-08da86746670
X-MS-TrafficTypeDiagnostic: AM6PR04MB4901:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z4K2+ofqI7VK2EVrPju1REpQyL3y95QOGRUBQ3h6W438SeL4T5ohf7drDximkrqk5cY7uAFzuAIh6zzBhMJPJZSx00YXaX3Lg7YEAxnO9JWtWphx8hV2hs540Vroi5ONwk45DxPRAmEYYhavrX3mmigdlO2r2VnB49RfY0I3m6QUyQggEQLnT6zfU5MdQOkp2uyfnl3KH75nell8umwfJuT6uTxSW7XBQdpX8rDpgJbvMGJpTPaZk7TWQ91SKtd+bXlxK4XOxCC8auX3lh94AVbJSRMmJwEgq3oVgmBxmNDaqgXewe83y2wrIreFeBQGe7XGKvSvQkUXY2PxrfaxYaSvLYmuQbau1GipiWZPjaRXcUeWfdT/FDKyO+voSECGm/nz9HRAMeBpNZcRVpZqzduMMI2LV/EzGh/czExqcvenpTfbQ/OKJ38l0HuZNZVMzeRjygGkEPuHakIWR0HkVhcClfvaQVzmvtvuqSTRkEuezGaROV+QWtvRy0A1Q3gWPFZ+C426lid7ssPDCGEuvUYkzctaRHBlc6QE+B7VOeIjRjKxMthot6BJnfOsBBtZ/i2saL7yXpFX8TSYyfhXFr9gHAKITn5GTFemiNPR+TgRhkw5c1sgC+Vj85GFYxZ5YTya3K0X+c+cXvwm803mF8fOh45jOds+GAaIooZ8KeZOv7WhpGJ3BRxTPJDY4+HVZWYFqsKGJMeTiylGz/S0o1VR3hSWl2S/w4qRm8R7BS0wGAYeKzxs4ViIZWvT/Ratlp6IZ4ZrSZ60odwAoxkW4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(8936002)(5660300002)(7416002)(38100700002)(38350700002)(4326008)(66946007)(66556008)(66476007)(478600001)(8676002)(6486002)(41300700001)(316002)(2616005)(186003)(1076003)(26005)(6512007)(83380400001)(2906002)(52116002)(6506007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xSuMh4+zeNDbnpTARcqakOz3eV76U2UUj2+63eXTaWfyzVD6EWm1WQcmyJR1?=
 =?us-ascii?Q?WwbIKCp0I3hf0E0s6p0VVW4003EDtxmJLMZREj/RhEQ/JEMxUs6sY5npTy7j?=
 =?us-ascii?Q?tE+Qgz613RPxn6sFxvFTVsVSlFxfFIGFQ4Co4BxWqF39V9cQxCNQblLVrQ7e?=
 =?us-ascii?Q?czVF3KCSqCSHUCAZyQiv4Hj6qWt7BSacFz63yE5s6HGMRL+Spxy9wZpFpNCF?=
 =?us-ascii?Q?ueW2M+LFDAIbf16RIrkiwZQK+hx+oZPOUsft2MWQttXaHNLBuFNxraO/Prbt?=
 =?us-ascii?Q?db6HmFkL2G21KEHSChl32A9hqmJtDWsprFLZgvtMHEOkSysAHtm9W2ItqdoH?=
 =?us-ascii?Q?pO/cshGRFbUoFCnsFoiOBMrsvWPxaxlP61sbQ5PwMTBE/4DMzkR+PiNYKuZ0?=
 =?us-ascii?Q?/B/jrfYbFeK55csPKhhEy64vWpvttRRKtozz0vjXsdWS+1r7jTT7Ety/v8cB?=
 =?us-ascii?Q?VmXjtOG30zpyvzv8GjqaDwfR+ofQPHODaIQrUxRvVIqGmlT3w40Afs/52Erb?=
 =?us-ascii?Q?G9xM72Ya/ciAvr8ehrg7R+xTYQ9YRW+z8cs6V5muCMcbNARcChAFUTrNThOt?=
 =?us-ascii?Q?U1tyQvMhccN2fKCMy2jTV/sZadrQodU9XBpHceaPNqZE/KznQP6z0Ed6M0SX?=
 =?us-ascii?Q?Fac9MljmQRJsPnD/yFWxzEihTbnru68NSTKGjDLZQ2FYPWnFND9FkCRlmXKQ?=
 =?us-ascii?Q?hWX3oFhttEf4+XGICGkcpegmR3F8g3Ung4ap5322pqSIpevTzphv0UvSKVfR?=
 =?us-ascii?Q?F87A8ip3eHhMus7dU44qA19uH9pOgeYCLhW9pQPucOK3oaaMhhWj8rHRIIFn?=
 =?us-ascii?Q?9av1oLRXBXHmzh4dYvbdT0J0J/4k085r5uL8TrwEWe73dFHkkp0FyFrkQqG+?=
 =?us-ascii?Q?0XXkCWN85SDxP3dszpEr/mt8OFtX4PlgZEwxwrcht7+A75e5bSqHbPudm2qx?=
 =?us-ascii?Q?/KejgftfuxGnb27m+rSnemQKN/DVTatiUB+mdPQzRs1y38+5Un3aFCx/MzJJ?=
 =?us-ascii?Q?L2qKtj1F7TkO+f0rw/gqJCGiZT02BbrpGco6IH+7eLBoB+6q+TUOxiQ4nyMl?=
 =?us-ascii?Q?J7rhzaW4l/o9MZ9NBci/+nGrHukxKTQNcw0YBmwcHj7PzWiKnH+UiydTYtyj?=
 =?us-ascii?Q?94mLtcb+bybJ1ilS1LN1vM1f7CveKbKrRl6aKl+Nbv0Lmwphy+R4Stjt+p0H?=
 =?us-ascii?Q?hSEFHiHHZhJhz0epUv/w7IIjLNZPUxg99WTeY3l5kRmAr+tmOfAbZosQssp0?=
 =?us-ascii?Q?M0BEtmeBmG/3WrSdxwO6yaEL8QxgCJf+pLU7pPdPlKbZhXNFvvpKUcxLMjZo?=
 =?us-ascii?Q?85uqY6B9mpZEj8QZcNjodtTzugdzIurraserFdgZAMjwA6ailN36PqCR1o3k?=
 =?us-ascii?Q?10d6L4hz/gluV/H1WiR5ohNDDtylgbe+iVqM+GUJC0lZkkit0Engn3NMNz4B?=
 =?us-ascii?Q?616PzDHOqgiiEV0unufYCE6fzjPqOxW1vp9TECo/81iCSuJqnsULVZvIP7i4?=
 =?us-ascii?Q?Q/pUC3ITk4SVu6zkVD/Mvt5HfFx6zwA/Ajq+sYsQgOM+P0UCvqAIDkVur7Ge?=
 =?us-ascii?Q?kYAdPhJayZKCXJRVNTI2AxpaYWU6QLSrDg9OeJzU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 657567e6-0bbd-44fc-cb1b-08da86746670
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 08:32:52.0905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hnDJjs2VLDUY1ldjBPc/9UL75tDeZ1UkIuzyeUs6bE+vrW82UaEZsoBEqEZF9EoCWa2uyUO5pL+8+2kqQ2myLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4901
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Bai <ping.bai@nxp.com>

When reconfiguring the WDOG Timer of i.MX7ULP, there is a certain
probability causes it to reset. The reason is that the CMD32EN of the
WDOG Timer of i.MX7ULP is disabled in bootloader. The unlock sequence
are two 16-bit writes to the CNT register within 16 bus clocks. Adding
mb() is to guarantee that two 16-bit writes are finished within 16 bus
clocks. Memory barriers cannot be added between these two 16-bit writes
so that writel_relaxed is used.

Suggested-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---

Changes for v2:
 - add the reason why memory barriers are added for unlock sequence in commit log

 drivers/watchdog/imx7ulp_wdt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/watchdog/imx7ulp_wdt.c b/drivers/watchdog/imx7ulp_wdt.c
index 014f497ea0dc..b8ac0cb04d2f 100644
--- a/drivers/watchdog/imx7ulp_wdt.c
+++ b/drivers/watchdog/imx7ulp_wdt.c
@@ -179,9 +179,13 @@ static int imx7ulp_wdt_init(void __iomem *base, unsigned int timeout)
 	int ret;
 
 	local_irq_disable();
+
+	mb();
 	/* unlock the wdog for reconfiguration */
 	writel_relaxed(UNLOCK_SEQ0, base + WDOG_CNT);
 	writel_relaxed(UNLOCK_SEQ1, base + WDOG_CNT);
+	mb();
+
 	ret = imx7ulp_wdt_wait(base, WDOG_CS_ULK);
 	if (ret)
 		goto init_out;
-- 
2.17.1

