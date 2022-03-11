Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53F24D5CBF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 08:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240208AbiCKHxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 02:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347080AbiCKHxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:53:35 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7EB6B08D;
        Thu, 10 Mar 2022 23:52:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnPQI+UEJhdh/tb0KBuRqmyVB6EaGk5oKGCpqrUwHW47I8FlVqB8A1IoEU8At3i8Y9s6fI/qSiprWbaBalrvx8ZlPc/CoLIYI+rzCEB/DzTEYNAoNgbeC34koXSzgtIXfI2/i5WQuGtHEbMvYYXAypbUh2knGCdY7PB/EnipBSdDBk2atB3+zmHtR4tElNFUh+CWh/ZoKesAYSS/UoIvpMVzNjbcFXeFTp90gkgkBmI6/4M5U19e71cVmWCXrT2VkXzdi5goJH6c6OcQx9fl9xxWTqcTBV/XudX1Qd+zBvroX/L7CYG2nFQ/vfNBjLeQJMaPGjZGTEA90iuNN+f5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7hcNMneOC9xJkl/Wtf0wJPxGaqpQjEMuKLCGvH/sRI=;
 b=aY9dfsMqi/5MR/u/ITqMj2Zsu1frkUVbowJBJowRTkYPBWwrEHGsoZvP7uLThBuuRfNk5FHlKActle2l6SrfApt/4Mbk5ZBzcQU+TinXCAfLKeyMZschY3QybwbB1nn0qNGvT/8XKZLgY7g2NC6CQlaeogjd69Xjm2YG7EUFzAmf75qURkR6cQM8xb3SrV3cCQ0ziVX8j4iWHubFkNLX/yftqbCevEOPRG09yY3Q0ON0RMPvEOCDQrpOKN8h4M8mr06SVJJszpxntX9NPfSyuIt345fRoR2f/UYbAEnm1MVQWXPj33ws6edaMH886hfRMqCPnib/bggKU13PPwtzpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7hcNMneOC9xJkl/Wtf0wJPxGaqpQjEMuKLCGvH/sRI=;
 b=Q2+4PeiRSRH2bYQPFCNMDbQ0PS8ns36SndqN6SyXYGfATMtoFk7SP7TFuXkjVZ2mpvou2xJzDpMirlvWKzfs4/5Xv4QtKvVMAGougui2vsKZfhgCkCM9eCiyBup1xnldgAHrusY7wJFYu+a3nOKL3Is9S2cya2O5ikcl42ClkPo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB7PR04MB4443.eurprd04.prod.outlook.com (2603:10a6:5:32::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 11 Mar
 2022 07:52:27 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 07:52:27 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/5] media: imx-jpeg: Refactor function mxc_jpeg_parse
Date:   Fri, 11 Mar 2022 15:51:43 +0800
Message-Id: <73ea0dba34b5bf02104517fce3f66ef2e6d96a16.1646983646.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1646983646.git.ming.qian@nxp.com>
References: <cover.1646983646.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::27)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11317b55-abf6-4ba8-9740-08da0334166b
X-MS-TrafficTypeDiagnostic: DB7PR04MB4443:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB4443E809E669A0F35ABFE692E70C9@DB7PR04MB4443.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eWIIn3dVgvz5oQ0aAQoCZcEJyS4KgMWIGx4WYIPRKhkUBRAJ5zifsQerjuaaix0BjMMN4m/UP91xIdR/1qFWh7fgYYWO5eGty7FDQRhPOsTXaWJUY3Kf7d1hnP+6f8mlEHzwMyL8fkds+4JjEhaZV6qKe+vfQH4xgFVtSmFHShHkISSliHBY9zocftSESdMFrdFwX1W5b099RAOrBAruSXk7JvdkoaCjFM+7MLBG+/7dnyl9qqEJEFhae/XwoZgA3J9DcAfqaZPTJFGPdAOodngeq+KDU/gp4Eslx6e6daK2txzGq9xmYeoxx3QZaT9nAfJAeVwesAv3OwZZn4E0BxRRmmHxq6X41vMRxC0l4PUT4IwKeCvalCUgIkQcaotu7gsZnbQNMErWkMrC7Xna4Jh6bxLn31/7JGXRKrnFVqIFFpWbvw1xj7Sp4vUKUoM6pMZnjZD4taWJeVlvUhyApFui4RwQsAHRxsQPLZn4OxJhSqyC79b1SNq/mVT9abEb+AHyQ04fLVezIfZL2pdkTqxr5o/Hucw8aLfzMb4dL7cxDAHY0DNf1KpkGq9RE0BmL+thG5pmB1TzykXBYXt+kRSfFe2gzNLTNjMaMruTdKNllRk8HJg1JJu9dSXWWap8WJtA0JF7vFnoeFjYCXnlOF2tlwrValN1EXgUQRdbj+la+67eaing5YVsAExjcnXqpB0bobWG8jXGCeSWm/MBAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(8936002)(26005)(52116002)(44832011)(2906002)(8676002)(6486002)(2616005)(508600001)(86362001)(4326008)(186003)(66946007)(6512007)(6506007)(5660300002)(66556008)(38350700002)(6666004)(38100700002)(66476007)(316002)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0hiZ06YDnZHHvWPuVouM+ZobIAQ7MjSakku7dDO1p94aBd8NHPbO4IA2rbqn?=
 =?us-ascii?Q?gJ/qO2ZxAVllJfiEJvps+Y/TC7o9Bvu/qZm4pfdCBmHXdLIzxuV2kz9XBqc/?=
 =?us-ascii?Q?0iq4Fx7PDbMw8QKuVdm21jsYcMvfSNxowLlEr8hfCkRZD3hrkRMrJtHj1tLQ?=
 =?us-ascii?Q?c8TYR8Qee8Io0j2TTnzQ7CVbby5Z/qS5hepG9YvVzH3/4HAMHomEVkyucW4w?=
 =?us-ascii?Q?oh1CDn9GUntJuWlD/PbS3cop9byCHvxQojPIShMQvnD+AHnTUO4Oohxw8rdD?=
 =?us-ascii?Q?UHpWJnRRuON2Wh1Sr2wV3e52+AglBu2Q9MCQWrvcR6lL2zNnPebfHtDMy7Lf?=
 =?us-ascii?Q?8pcCCU3SJTE/SB5gI7H3VU+DvQ0SV7ZTbFBX8NIBimlouQPGEAf+Ob/O7EbS?=
 =?us-ascii?Q?TvfwOkEnaJRs/sNfOh6jGXlWLe+7X/BtuhTm8Cx8OWrlKhuc09rz3sImMUqo?=
 =?us-ascii?Q?U3b2AmUBWDbVjtd2+cR1kSPMoXk/AaKYsnMPdx6741Mdy5CNzX6H46q6xoQN?=
 =?us-ascii?Q?g6NK2De9NDntCj/rZY7+WQT/zgcd7LUmXwYajIHN8DSXj2ZaS4UKortclPKa?=
 =?us-ascii?Q?blZeFQFuoCz6eklhdrvfd8nE4PYt7FYV1lT6nPF0blAO+1+3qJcF9wpgHplZ?=
 =?us-ascii?Q?7RJe4LjUc+iZx0dXyJSUL1ea8uqkBjHJ0YRoBtWcHdfUAJoZbCpX4WXVLEoo?=
 =?us-ascii?Q?9K2KzRKUoajaH1AOh93JcaJW2mNYWLsoStEi7HsU6wKs7/tafP3tHk5LYkOW?=
 =?us-ascii?Q?bG0ojWNGM6X/NwEjDLdmwQD62TmwQ91adjqKimkSpHczq1UUOTikei9NUyvr?=
 =?us-ascii?Q?GuJN5oWIeyb9yrzxXqieLCVwVFMmtSU7nThdD+dB5twPaT3c04nS0BwfGP02?=
 =?us-ascii?Q?e0sSMhkGKWDVYwYk96t31wdU1fyeimEHVVK6MYZvS35bkGBVutbGaFLNxc7A?=
 =?us-ascii?Q?l3keqxN6Vlya7IiOQGUKXp8SLK0ag3XWSxpSzfxsGm9aFlUJ059NbOOXmodi?=
 =?us-ascii?Q?yp+CQ+xYQUxjwFm70VeUCIs5TZ2MfYjxkwdcvItXBn8nnNSDOowfR0M6RYz/?=
 =?us-ascii?Q?oKSUuQ8XEXzovWRlkx8SuMkN+CpUSCyNRvm/YQbIZBXf6mFsPGlrPGHOuDzJ?=
 =?us-ascii?Q?z3DKU84IiMRaAsGLQxKg4KO0kt5YHeUEY9nsL5KEGJKp0wVXhlP0N2ban94G?=
 =?us-ascii?Q?ZTu6b+4m3fjZU/HCaxn0Yd9v3NplUX5n3LXQ4jEfR5b+LPx0IlBAAHZMZ8AV?=
 =?us-ascii?Q?aW9uQ5uuSg8/ljgL88rxKV9ujNtzcX3qmcYpRVl6v94X+n8FH/Lme7sfbu2u?=
 =?us-ascii?Q?6/0GKPpusKUh6Olp6MZPAmFJjSw241M4UaSde3FIq0tSWNHxgy1flOEr49GZ?=
 =?us-ascii?Q?OziEmXNMgJGKyIxULjCoLPVexoa0UDJ/AdHS3dHuj8nK1Q5ebKyCljrOU9tq?=
 =?us-ascii?Q?F5uWykVyh688VPJBE5WDuoNJUQuxJAa1R3Ecm4nVG+DMcFyzduae3l/8QKWb?=
 =?us-ascii?Q?kE7Xre3b10PUDjGz4JsxX3l56mRw1eXDtMCYRK6HmG2UJal9G89wsVDI9OBq?=
 =?us-ascii?Q?N4jS4SdNswJdh8x0BjnBdCKodZlyNHLGB2z7IenHw5g4sJI/Gfe+l1THO06m?=
 =?us-ascii?Q?4rPGZd+KWbdFLe6Y/cQdvzY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11317b55-abf6-4ba8-9740-08da0334166b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 07:52:27.7710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JId3ZNfD/y2qNkYRfh5r4cp+UJRWv3TQ+4Wfp1wAeNOOyurgL4daSrSG4FjZkPqV+kJ8+ht8R7W/zZjEPVblCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4443
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
 drivers/media/platform/imx-jpeg/mxc-jpeg.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
index 1de0400750aa..d8d24c19f423 100644
--- a/drivers/media/platform/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
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

