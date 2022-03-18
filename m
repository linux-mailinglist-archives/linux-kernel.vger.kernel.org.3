Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66244DD5ED
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbiCRITF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbiCRITA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:19:00 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150045.outbound.protection.outlook.com [40.107.15.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E22B2DD9BD;
        Fri, 18 Mar 2022 01:17:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E59V/KY1vmRgbHQf1XT1nmY7pRdEZRtqN9jCPmdtzMdQXSB52HY7gsBteTkS18VV0BRqQ/IgktmPLWHde7fHgfw4XUTt/r151mbDcCmgb/j7A23AeS1c1VgZcX0hJoGSYxAEm5z+0B1glMq3XySG2uCjcfBZsCqwMAOXHoHzz1QSvqbIYnkAgDQssp71Dln8aDnlkaZ/aeO7HpynsAQP4FWr7ICypNqiqjUD1MbAuDJf/NyS4WQNElg0PYvAzCBjNriJia3YUBzzX6Ppg8B8GkZVfNJUZCCEKpKlth4Hc9CK7TISXqa/KZORFiKiaSgitRMlwV51xcspViShhTI2/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nV+4+ggQij4sZAFQbBSSvSn62mz5psI8ZHje06+CNwc=;
 b=Yv5BOcWXKH7gjwhP0yB0HQRxWF1YZ3jSSkeiSCfN0ahvxIcC24GyjoTgRgI5KWLiY0FRBlMdyaNrN27bRmfdRBk+vLXYg85BxvPh1iYWVrl3+jXWqx++faBI/OA26S9HP08TIGCnUF9Ow43DhcnEmJgrHt8j5eizqrI836uPeNwQdNNvKgiTrj8KIStnDUlwckA3HIxAe+MquWw9kFFPWvDo8BAFtphWf6KhA5LJoOM8nxWSSV+EwmTsMiXqIzkFNNnkwR1hhPHMOWhpAPL/OOMa0duWmvZdXUvBS6U25stcwM2y+0O+P+bLu7w/rKY9foKsTbOTnFEH9FgSZz7+Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nV+4+ggQij4sZAFQbBSSvSn62mz5psI8ZHje06+CNwc=;
 b=aGl2FXfnL8esoq7L+6ag6cVP1w37fUGV2IIiVYNRwBQuLCU7P8eODjtO2kWbvML5MkbgPbCMpH6KHgAeuoDdOEmZm9bhUaWmgUlztk2sOSC/mZQtlmry9ONCbxS+78zV+ds+e0UScaavRtC8XR8Wr6Q1Yh1nvTesW80w8ikN6mo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6346.eurprd04.prod.outlook.com (2603:10a6:10:10c::14)
 by VI1PR04MB6285.eurprd04.prod.outlook.com (2603:10a6:803:fc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 08:17:40 +0000
Received: from DB8PR04MB6346.eurprd04.prod.outlook.com
 ([fe80::a8a5:945f:4d08:69c2]) by DB8PR04MB6346.eurprd04.prod.outlook.com
 ([fe80::a8a5:945f:4d08:69c2%4]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 08:17:39 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/5] media: imx-jpeg: Refactor function mxc_jpeg_parse
Date:   Fri, 18 Mar 2022 16:16:51 +0800
Message-Id: <9f67125ccbab5d36f985c783990ac2767df50f36.1647590462.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1647590462.git.ming.qian@nxp.com>
References: <cover.1647590462.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To DB8PR04MB6346.eurprd04.prod.outlook.com
 (2603:10a6:10:10c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d43917a2-1cdb-4283-e6cd-08da08b7c46c
X-MS-TrafficTypeDiagnostic: VI1PR04MB6285:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB6285B9FF1A10480C5491EB75E7139@VI1PR04MB6285.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8sG6MlP5zitEKqADsdSEvbzDkfWPfjVTiP6A6180IfR+IRYF2sRm2kNkxKkypPLJy0x7+q+TNLyMXyXoHE8uClxYH65OtoZgh/x9NWe8+qSn12I2X2KpnUKsSZfpobnehBWfbKaMRiDQDLnJGSejTyazYAhknMVV4U00oqCmKW3WhaQCDOQ225p4o263QAJqdwlgp2x3rNsMDgi8ugsPnZwqMaX5hFqE26xbLT2aX9eazuDsycPpA0U4WlqV6M4MiiXfSWZld+PwtfcC1VM9L66Og0hlJRtr6mhISI11cbJnEh9NbCEKZSqX/xhJtPxJGzJpn7DbGLfi0Eb9kPkKhwTBmjBVk8Fc1g2iIHGQU4rNtOnzEVU187Jj0JuwWCB37ndcieI6z1/EmFak3RLs443PqLudEenUXkZzGxEMxYIVJDfD+IHJo4KDcmcbv2spyg5Ji8CF0eMyOTA8UXQe9M63JPwkFCVfh6vP7WhSRyzLNx/AMHEuCllzmxphEJVZ0ifCB0Y4ihxQAtqACR/FY2DiCZ3K2wVp6myQGQwN9H4ccu/5XyRsaIW9+/7NwbzdqIQqt+TjqgJGFvzVwFFbpOwCVann4sBwTxy/XQptZh9CTBVY7C03IzANtGfShpGPxiLqxr0BvaqCNcnnAOj0U5xgaHstGtjj1QrrVytntStvZIq783SJ6VU4+EIbfvoM11mp2XciB0yymi4Yjycidw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6346.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(38350700002)(26005)(38100700002)(5660300002)(6506007)(4326008)(8676002)(66946007)(66556008)(66476007)(52116002)(86362001)(7416002)(8936002)(44832011)(6512007)(6666004)(2616005)(316002)(508600001)(83380400001)(6486002)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mb3Rpk2D2Psh/jHFqgtyaHkmKwkk5uyeA8OvwdDHG2hV9xje1adb3TqKCI9h?=
 =?us-ascii?Q?IF9F4y9X/a2/0geICWr54ZESIs5E61AzPLuYO2MdQdKdKxa4R3SjrWI+L2aw?=
 =?us-ascii?Q?ZMKiknKgrLRHjkecEHP4Wp5g0CwQXdhDk8FCsJF9bbrGqLaPiIwiW/Rix4SF?=
 =?us-ascii?Q?ltibm0IFTO+LgWpe00hQ8ukWaiDJEXG7E1I15sSc+NAAbOo2kupjFZ76q5uh?=
 =?us-ascii?Q?EEShJxtUrYMivw7Imxxwi8orIu4y6PGTJK7zCTPCWVdDzcWOdtdEBTtnBtaa?=
 =?us-ascii?Q?INtRi3iLiryIssj18nKWMspM2tA0lVcQOdWlHGrJSmM7A5p0KA9yB36KsCnu?=
 =?us-ascii?Q?6Tmxa1JD93Aw4W74WndcoJ8AMxlnlmd0oEgWQkzTvarztDBLYCWDj0DrmkH3?=
 =?us-ascii?Q?ti8PqZwVbxT07KEnEx5n6Ihpssryl4HKR+tgJowNqUCL+Trvp0TsQK4TVfKZ?=
 =?us-ascii?Q?fs+owHSbFzRpgbVUcGmiyi/exCf6fC0mt4mu/7Cia7vKBVQKAtDHEbu0lelG?=
 =?us-ascii?Q?VbCh7xxoVa7rDMizLj03fko0FxJEWF5Ns66RDVjllLx3Q7XqzApll/u2UpKn?=
 =?us-ascii?Q?mKT16FmYCIQJCCOC1smMRWMPnlRROTwfP6VJuHOYWA2+1CitvzBjZWV0kVzu?=
 =?us-ascii?Q?4utGDSzCEL9oSKIoDQdgE/eK0LYIJj34wANFzT/vKUDsMjiuy8Fdolzl//bv?=
 =?us-ascii?Q?rEAo99N+zG2VIVRCJbFmc1GGn3tgzhdO3XG0wuRcWNkgZ8BpUrmqIJk2WkRf?=
 =?us-ascii?Q?mkG6zmVqvWiHLm9R9zVGFkeAxMpq6t6UlMe2S9l27eGcTf/y0sfZvBG9opp6?=
 =?us-ascii?Q?eR3e4lfO9qRjkHs31fySZl2/3/fdpjbg2ixbHrnWrePsRlCDg4DiBgNaH9rd?=
 =?us-ascii?Q?Z9wgL8yDb27Z89tVaNgorL2uHdNlOXeTELqscZCffeHP11+tH9pzIUNGRFLQ?=
 =?us-ascii?Q?vitrcstBQTMfAljnzPVydCC9ffej5S8ppYjvgL9gVr6u8qlhRYTPf7uCTEdf?=
 =?us-ascii?Q?fkJ966W8caiV7nZsw/gdoDejFBHvZlE3FMc7ob9ufiGRaiFrnA5mUPE3v48b?=
 =?us-ascii?Q?ajJhgi9a78Ij0T1fmXN+aQX0+rGl6RvS+6vwhusp/hJ8FQQV0RUL2+N0xzI8?=
 =?us-ascii?Q?1EHP8tbR9UACTZs1PS+GpXFMuh++0IAnFiFZpXSsTw7SFrZsMFggPTMhB0SZ?=
 =?us-ascii?Q?xv+wqBsqJd/OL5TD/R2eZlIzESwIS7BGwBPrkESoEK5dSg0lkWM5Vwr/Y7/0?=
 =?us-ascii?Q?7fM0RYs8mwlTRUs6Eb/9u4IG6vtjB5u1SNpq5rbCESXXCK+tOADAuvOWi5au?=
 =?us-ascii?Q?VtHGYgAsr34E0fdN4huJyvZBSQe1AjGaCy6qIzjcMYBbbsRHQucW7Ernceb8?=
 =?us-ascii?Q?Bbq1ymPtXRzQ9eh3Dz2i0sCNPeJG3FoAYahlTAb2Xtweu4zTwGz/TUfTeluN?=
 =?us-ascii?Q?qrxayV2qrt9w2h3BQPlroLpoWAnEppzh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43917a2-1cdb-4283-e6cd-08da08b7c46c
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6346.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 08:17:39.5730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3e59wMcGzfsXCg9B5KsaK9JXNMycwdPvFlEm8NxK9TVclQsesmMQxwHIW94obnliebC4nkRpp5qqqGfw2bilg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6285
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refine code to support dynamic resolution change

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index d1ec1f4b506b..48e496cec04d 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -1245,8 +1245,7 @@ static void mxc_jpeg_sizeimage(struct mxc_jpeg_q_data *q)
 	}
 }
 
-static int mxc_jpeg_parse(struct mxc_jpeg_ctx *ctx,
-			  u8 *src_addr, u32 size, bool *dht_needed)
+static int mxc_jpeg_parse(struct mxc_jpeg_ctx *ctx, struct vb2_buffer *vb)
 {
 	struct device *dev = ctx->mxc_jpeg->dev;
 	struct mxc_jpeg_q_data *q_data_out, *q_data_cap;
@@ -1256,6 +1255,9 @@ static int mxc_jpeg_parse(struct mxc_jpeg_ctx *ctx,
 	struct v4l2_jpeg_header header;
 	struct mxc_jpeg_sof *psof = NULL;
 	struct mxc_jpeg_sos *psos = NULL;
+	struct mxc_jpeg_src_buf *jpeg_src_buf = vb2_to_mxc_buf(vb);
+	u8 *src_addr = (u8 *)vb2_plane_vaddr(vb, 0);
+	u32 size = vb2_get_plane_payload(vb, 0);
 	int ret;
 
 	memset(&header, 0, sizeof(header));
@@ -1266,7 +1268,7 @@ static int mxc_jpeg_parse(struct mxc_jpeg_ctx *ctx,
 	}
 
 	/* if DHT marker present, no need to inject default one */
-	*dht_needed = (header.num_dht == 0);
+	jpeg_src_buf->dht_needed = (header.num_dht == 0);
 
 	q_data_out = mxc_jpeg_get_q_data(ctx,
 					 V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
@@ -1381,10 +1383,7 @@ static void mxc_jpeg_buf_queue(struct vb2_buffer *vb)
 
 	jpeg_src_buf = vb2_to_mxc_buf(vb);
 	jpeg_src_buf->jpeg_parse_error = false;
-	ret = mxc_jpeg_parse(ctx,
-			     (u8 *)vb2_plane_vaddr(vb, 0),
-			     vb2_get_plane_payload(vb, 0),
-			     &jpeg_src_buf->dht_needed);
+	ret = mxc_jpeg_parse(ctx, vb);
 	if (ret)
 		jpeg_src_buf->jpeg_parse_error = true;
 
-- 
2.33.0

