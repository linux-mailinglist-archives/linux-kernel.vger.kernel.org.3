Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211E15887AD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 09:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236933AbiHCHBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 03:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbiHCHBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 03:01:40 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9FC6463;
        Wed,  3 Aug 2022 00:01:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+h+Ifa6w39uq1gahUxyZ5LRXNikMxcDZ6XIDlxa8XgS1uTqZV79QIFoR8r1qxeLXl6ke9RXQvTE0eFbNt76WqLyqt9YR68mLbN8AhkWfzAHtbtfM94xl7qS4VSlnGdA6kWV4qhusCugjemB2/XrEPZI5htnh/hZrWwvZr910hgjUgHXbj1MJDJPdV2uDa8G0GtjREAFY2DHbA2IgDHhsha/2dOHIp77XErtNdzJHHgaL4/S+BucfyiTrl3Ew0IvvzChWI2j0veiPkvNrQpVQ9N1sqHzwYiN5V1yZDfUDdrz4Wviq9kVr3v566oXmk+sKGFKC9p9dbclKx+GdYEi8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BslB4pNoOoBbnd+CFDwyLJTW8eORRZAHBqOsZBH7UOo=;
 b=PV5/VeAJeBSGEpm+DhXk7saW1Krg4FbOWlj1XTPEVy7YLzevdqBJ2EruVsNZrVuSLttp2Tudc3Os5R4/1jyF9jCwJRBnOLc4uajp86gby1GyzyZmHnD98whDETB3VpsF8o0eXz+ya82g4vOMDyo4/2HnjCKrC8nR9V7oMYexNaUtIof9yefGELqAhDzqt0VBHLQtEXvLLuNJhinwVtAlkn8SpOL9KasqXxHMD5EWVqKdwvr1kHJIq/UuZDSMcgKzw+PNRgDAe92gzdJPdfBdi3ARki6GVo4v1PRVl3oaYYiNs+FWpwBKBYQ5kuPU+PYzqSuXAI6/EOCgondBGuGXJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BslB4pNoOoBbnd+CFDwyLJTW8eORRZAHBqOsZBH7UOo=;
 b=GgPztku7UT3xgASI6SeN8peMDBlyY3U+UWRH3dv6TP2A45MTDID9VKjVGawvEVuWcZPkl61cYX2AcFJllH+A/h2mqymOd2SL9QWFen7obTx0Ev50QQWQvIP8iH2V/NnG48oeHRqC8xNygVpGYkqtGq1bmRIzBLcEKd73jsrs2gQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB8024.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 07:01:36 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::d547:3040:284e:580c]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::d547:3040:284e:580c%8]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 07:01:36 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] tty: serial: imx: initialize peripheral_config/peripheral_size for sdma config
Date:   Wed,  3 Aug 2022 14:57:37 +0800
Message-Id: <20220803065737.14752-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:3:17::18) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 006e29f4-982d-42bd-856b-08da751e0160
X-MS-TrafficTypeDiagnostic: AS8PR04MB8024:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /5VF6utvHqAUBO4Aa21fR9eZxzXcoLXDVxzJzHnCUikWhbSoj8wnkAoZRMhOq89U8IjoNXA1JcC6wCkc5RPg/7qOx6V68SkRpfoNlC8q0JP2tEFX6ixJhuiMTixhOTWM3+vaEB6WNoTI0qczV3sgZcreZMPwdf+PnQlGLU2s7ULLP1Qq8ZGlIxJsM7RQnunS5TJDPikxGNEFHwkjszn7Z2rZEwFAanwOdsz81bvZsAf9Qr7xsxWrTy2dvo9v89aCN5V4avtPKlWuZmVOQHRylwzzj3Tjd59IrmjxM88pUTFsmtdYXpeCwMqddECmT4VNemKtH/sbMTFvEckSMc7g9I+/ylk6ZgXrAcoDn1QhvZBuv1PbvsElpFTVfsA9wlpZyOZZPPa0e6jiSbmTpU6J22M1Lh9HRJrPXaCFk2CJKy+Z1X2vUrkx1p4iylzKv9sEaOqvxrNhHHVhRpTPUlwnVfzR1LdsFVOsDZI1befSRvPK65h2KEhNLkgXj+0lqUZfo9fJBOGTVngo9qo0YLmzNSnMzI0UfI/D00vfE530CjvhyK8+KXcU7JCYecQVEvXhbwZ9PKZOa/+fArSHvZi6d8qmY1QCgltHLGvw1N8dtXVOoP5fDWGG3dT/Ut+CP5ZGe9LQtSi64POJ5zjt+6e6f8/6eNZ/s91LldNhNXvQPvC0+nNHYd2n1lAG1tmwhFI8ZXaOTVgEGj/syELynZIFoXKpTTvz2IkOIax2hF99vg1mO8iWOlB8spZUv+up5QLIBIGZNYBwat3R2hGJh+g9a5EMy9357OfZLJH1cf65HonO7rZkwq/eePbLwsfj5omb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(38100700002)(316002)(38350700002)(44832011)(186003)(36756003)(4326008)(5660300002)(8676002)(66946007)(2616005)(66556008)(66476007)(6506007)(6486002)(41300700001)(2906002)(8936002)(1076003)(86362001)(6512007)(26005)(52116002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D6gJAQYM4/PwUciLdvE2Z8aPWHdiu3pf66XitZQceRFOti4OJIuGQ9Ba7/3L?=
 =?us-ascii?Q?ebJE0kiZdkLc3mBGAab6Un8tCdEFKFU4DAlCRE9JpIS41J7pQB7gkfCRdIZr?=
 =?us-ascii?Q?8Y20WTUlVcAsOXsTm3325mNXrk9C5hfDyHoVjaX9AbRYV5mR56BLaHFFvziX?=
 =?us-ascii?Q?TZocEiTBmr3DLqJxHdtLa+OTKmdgKLL7DaIl4brhehYvXLmOEjnZ5o3cmKyD?=
 =?us-ascii?Q?v2m/r8D4csUa8SAhrokgcq7aJvSBtMujvKoqXY9qQvw1AlgGIs0HNl7vVoze?=
 =?us-ascii?Q?Y0EZkoY1cJl6UmZ6m6TaoxYRGmOairCdU3iuNUrsRstVeKigXFeUS2CazxyB?=
 =?us-ascii?Q?pghudGouB7TF4vigVg+ZcjQANKWJ1Peb76xRls8CA/74T7uURJ1tz3wmRUYV?=
 =?us-ascii?Q?MBM8EgpygxzIdzZWcrTjU5Vh7yfxUyfc707tZUVLX1gJ+rUbkhAskuPmR0vt?=
 =?us-ascii?Q?A38DeqI9EhpAKVYBO2++BHBFSpU9m8SHWm7CHX1Lb1CqC/e5k0a06CdMkTaR?=
 =?us-ascii?Q?tXcH8A87X+deuI/oBQ/AcGsy08f9wx1CVPJDNpavbhQSHcHkjFQiuIl8w1Nw?=
 =?us-ascii?Q?m3p9hsbaSWUygmjOdDpD+qlks8TVwQzbfOZ6ErOQQ6A5RUUTONx8GlflXGAA?=
 =?us-ascii?Q?/71zCDQCmddk5nylXLGvTDKtvfM1WzSmfzNghETIxOr/Fg18m4Uc6c79Pulz?=
 =?us-ascii?Q?AGh0xt5hdn5+kC+kxgLZAhuaDsiBUqb0FrS6YIIXfjJHZzkbg3YNTlMfpHeN?=
 =?us-ascii?Q?lMiDsr0ksdxSimXxapz+ekg+f/co0RfzqzSbzksLuioPY+QupyvBUeWFK94y?=
 =?us-ascii?Q?3NbR/MyA81BIiUQtjTPZA8qYvSSul4OJjHlGqrIe5JZzjD7ppcG1Yp2GZf6q?=
 =?us-ascii?Q?6mRrAUgwf5Jynhc2kqD6Rgg/3gA3/3RRmui3DYkLeIMemw1Aw0Q3oYo4N7rN?=
 =?us-ascii?Q?mTZ7aTJg7Z3DYwgECilbZB8e/MdnnIxkSiGTHoVHO0K/3Mhi3vMVTVoRiEzC?=
 =?us-ascii?Q?Bz4LGkgOTg5dT4AOJFHK7WwpEpodjsyYy+eGbXwBLArNZHn3yxcc5EDfLFQf?=
 =?us-ascii?Q?N8YIFPCqCuHf4D5t4wS0w9UKPcazu3Aq7lRQmi6BcbVNORAz2TpeQmZdghtZ?=
 =?us-ascii?Q?sEoolpOX2HbTR766dKdjPKW1/vqGmigXy7XYyh+zg4COQvVHiOpKuk0zsRiT?=
 =?us-ascii?Q?IqdeU2oiB/2kwqpKP8m+nPF1d3pkBffShfo0fOLgdBR0MAaWAWW2VmKg8cHV?=
 =?us-ascii?Q?V4w1owc8AnZpu8Iq77UPQwKOufKJkz64y9tOJ3JyNAT0hFww8DTHPZvgf+DI?=
 =?us-ascii?Q?WEaLuSQsmEP/Ea1Rt+DFA8ZHn61iBf2kynQb3X8neHt7Eyi0xtCGeJsRR9TP?=
 =?us-ascii?Q?fSVUcTV+OFa6+8JVwvZlXkkFUPy+wOpvQiWzA+n7NiR4peHtXVXX9AG8pckN?=
 =?us-ascii?Q?FhAtP+UngC+nlAJ8QawB5EOula9HXdZJPd81UZ+HtAGOM8V0ssphrQCebuTK?=
 =?us-ascii?Q?COrf5dJePGUVwwtetWgo5adphFih+iY9ridoRPR99+WRgcRlkjoW1RPUKaGO?=
 =?us-ascii?Q?kT1foYKt2yxi8MHgSKl6vjay9Xyljsaf0QTr9xGj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 006e29f4-982d-42bd-856b-08da751e0160
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 07:01:36.2198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzXWPZYj4YX0/hyknuZdDoBNlfD8RMLU4bq5uWpVrTfE4ciyx0ieXdHMi0ZJCn92rni+1AvIFVDkvOhUylmyYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8024
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 824a0a02cd74 ("dmaengine: imx-sdma: Add multi fifo support")
adds the use of dma_slave_config->peripheral_config/peripheral_size to
sdma driver, the client drivers like uart need to initialize the
peripheral_config/peripheral_size for sdma, otherwise, the random value
of local variable slave_config may cause unexpected peripheral_config
and make sdma mess up.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/imx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 522445a8f666..bb8c2a712e94 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1320,6 +1320,8 @@ static int imx_uart_dma_init(struct imx_port *sport)
 	slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
 	/* one byte less than the watermark level to enable the aging timer */
 	slave_config.src_maxburst = RXTL_DMA - 1;
+	slave_config.peripheral_config = NULL;
+	slave_config.peripheral_size = 0;
 	ret = dmaengine_slave_config(sport->dma_chan_rx, &slave_config);
 	if (ret) {
 		dev_err(dev, "error in RX dma configuration.\n");
@@ -1346,6 +1348,8 @@ static int imx_uart_dma_init(struct imx_port *sport)
 	slave_config.dst_addr = sport->port.mapbase + URTX0;
 	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
 	slave_config.dst_maxburst = TXTL_DMA;
+	slave_config.peripheral_config = NULL;
+	slave_config.peripheral_size = 0;
 	ret = dmaengine_slave_config(sport->dma_chan_tx, &slave_config);
 	if (ret) {
 		dev_err(dev, "error in TX dma configuration.");
-- 
2.17.1

