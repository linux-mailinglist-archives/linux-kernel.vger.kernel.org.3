Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B22348CBAF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356900AbiALTOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:14:03 -0500
Received: from mail-eopbgr70054.outbound.protection.outlook.com ([40.107.7.54]:65286
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1356967AbiALTMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:12:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNpQYfdr9w/sSpNQPBFGz1ST+maJFm/gR0WYHGvCj+rBX9vQdaUUlA6gTOsRSH0sBnvNFQYpnr0vm3ZRN0Zxlqgv77V9GMn1C8ap4+DSM9PgFwhUXqsPmVf9SUCLWfHtdpTpVhftGZl2HyWpPwK7s+eRCJREn9yu+9OozOT41fiOA7tyKE0T6s2E0hMLQq926YZG/MM7tT0podNekhI/jkFlg3l6nJ8SKblLU6EszBZfgyQuT04CUd6MrWE5m6/ckGmIawc5RW5BMI096Gc9/gB732tnXhSFgSreQDKzdrw/HTZM1hqe33dKc96DGoKbKMC3VEJ2uzXdDD3Z38SEKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yN9zoWIvseoAHEknSo0lI0K58hAz1qmYr0Eizj5hqtU=;
 b=MunMsTRPX4JxiRKOBRHCM6FnRrhgJ/DYBziKTx/mZ9t4HyG3Y9F0SKEfQuwRz5dVkjGPrcziW3CyoehkPyw+XFuegzgb/dT7WskeMh6WCKmASG0kUxmWC1CrY2tniHHY+6V3VRYDv8M+XS6qvG0KfsuMGJZO0cfp42S8ckCyAyqeaN1A6GtG8BCc94luq146doVDstqj9ulQ+ahcgSjJupTOyTdWzVwMR5rI+nctAXStSwwW/cmBsYIxGoZafgh79rNuqKvFsV2q8982/chCD6FCa8mx8Ndg0UccDvf1ooaGlEcKWW2zgLVLaCxt0GScKmvJpuEUFHeZXtRql2sPIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yN9zoWIvseoAHEknSo0lI0K58hAz1qmYr0Eizj5hqtU=;
 b=D1kU2AG/YHqLOECA/URg5xsxYisypivumzTyYt+WRcLM9DD3PHNWmC8/LbJlWXJFk8l6psMPNvrJDjlJZrZgzvm9DytVxbJKBL43BVUHP8q4EgGjpTxwJlhD1VFodoOQ+DlDq9o3XyxcMQgwaD340HQLrlz0uSJyRSl70tdyCcw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0401MB2495.eurprd04.prod.outlook.com
 (2603:10a6:800:52::15) by VI1PR04MB6159.eurprd04.prod.outlook.com
 (2603:10a6:803:101::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Wed, 12 Jan
 2022 19:12:21 +0000
Received: from VI1PR0401MB2495.eurprd04.prod.outlook.com
 ([fe80::698a:af10:114f:2487]) by VI1PR0401MB2495.eurprd04.prod.outlook.com
 ([fe80::698a:af10:114f:2487%12]) with mapi id 15.20.4867.012; Wed, 12 Jan
 2022 19:12:21 +0000
From:   Mirela Rabulea <mirela.rabulea@oss.nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        ming.qian@nxp.com
Cc:     linux-media@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, festevam@gmail.com,
        robert.chiras@nxp.com, shijie.qin@nxp.com
Subject: [PATCH v2] media: imx-jpeg: Prevent decoding NV12M jpegs into single-planar buffers
Date:   Wed, 12 Jan 2022 21:12:08 +0200
Message-Id: <20220112191208.823698-1-mirela.rabulea@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0178.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::15) To VI1PR0401MB2495.eurprd04.prod.outlook.com
 (2603:10a6:800:52::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1800c30e-e723-49d2-0dfc-08d9d5ff7543
X-MS-TrafficTypeDiagnostic: VI1PR04MB6159:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB615918D24ADFF1307680A327CE529@VI1PR04MB6159.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W9j6hz1xLbn6oUdr2g7MtI/+HM1D6mugQewjxstwqHctHuYZ65xCLIIcTtN8n9+VE1oGLMW2v1vFi5nx3KzR2v+gSfULYLVgZc3wjZ/ohz6iaJLFXRgP+ZPaCPLrpeVrsJyUQopzeMcRx/tOTdn6k21foko7VFu/7GuKLDqGfLgQ8clpUOwM3GXaJ/ggBPLS5FUYE5EcpsFnOKoagfMb3nyWk5fZ3EbYLj4WkZUmpRkSsRXGs0nnFtktnwDyCrc1l+x3I1MCdCHu1R0s4cXN2zVSbDtCe9yDaI/K4TP0qOglj/1UsmamMb3vN7qFs03990Jidp14yuQ5HoJloYRxHvZmob0ybKEAizHQ49vTVoh+u8KHmj8hGgdo4GRtKuPtmf95gbNQirZ3Jfm+MLS4pFK+3RqIYme3LZPKLRQXfLB7czzUmsKkmscOFT072AEi8Ky3Kj2HswQnORJE1ZoTQihrX2BLyKakJxTZtua43nmarPPQQ+v0rZD4WdJ/RhB9xPkObx3CwPNs99L2EKvuP1YGwlebr9sTvJ8fYWCwVlCc9npMiIr7x8K5isnVPfwIoyjNwQa9sMSCbJAgurYfPiLfa6dRtqEQRueXd0EgONfuK4cGG/vsTeN1IRw/fswsF+ThCv+vM9USiowWtqbkGyun2Mu2mqq6r/4LbNoskhzAPTpaXsg2yJtvVJqvvpVySPqmHOnYfVD1EPG0v6+yAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2495.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(6506007)(8936002)(8676002)(52116002)(6512007)(83380400001)(4326008)(5660300002)(38350700002)(6666004)(1076003)(44832011)(26005)(316002)(186003)(86362001)(2616005)(66556008)(66946007)(66476007)(508600001)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LjXrWsx8IIhLJuk6+nOU5i1d+IshoTPOABU6xcMW6lhGmKKBQwaJ9mZVKgqB?=
 =?us-ascii?Q?jjLRTokk8JWOAyGSwGJSb3l5tAqi2LRGp4MWgUaStUtoV6rVvA5N98Y/1Ak/?=
 =?us-ascii?Q?+eqyuwltY3U4VFaBkkrt5y5uyPEgNJvi34DNJKyIzl329VxWMhooaQvve+57?=
 =?us-ascii?Q?7tzFfakoyp8Y1mNPkxK4b6HNQkHB2855zFIm89D+OIyNraw5e6YVUMCKZBTx?=
 =?us-ascii?Q?jMLccbcDS1+gnsXYOXznkL0r4pkM1EvtRqhwXZKQ3Ny9mDqv7i4CZyiXf0XK?=
 =?us-ascii?Q?VJZCGexl1F+5GQhIKr5gk/QRns+7K4aG38c9lqoHJBHBzZ/H9DVOxKSZuW71?=
 =?us-ascii?Q?A4gMsKvzrGjVNlskY+Yh7pRbZYYfVI9JmyA3ume2dCT02TXoHfB2PnCn48an?=
 =?us-ascii?Q?Onu4KE5WRBrM5aZumifV+zMpAomGMKNT4YdwzK3+O90PH/GGF4rkT3/ab3no?=
 =?us-ascii?Q?vF/+KquTIcSatTutvxmQiEWupZ6Ar8AxcsJMLuvv9Y+B8hHupBpoPG6/F9bz?=
 =?us-ascii?Q?vbAyyqNAfg2PgLdgSvYhZgVql8W8hNrHOQb6bNE/jn8CWPKa9XgML/mLhpQE?=
 =?us-ascii?Q?kkpxvrz+YVn2rBgaGrdbj/3zMzhYseCpUjGMqUfw7U9aqe82OMKapric0Q+1?=
 =?us-ascii?Q?fPLZmD7ebKlHLKcqc2izqs6NAbwSSUHmpIT9moVVj3mE5qETTlrRtl2JLeL9?=
 =?us-ascii?Q?y4iDHT3LVyuq+QBKQdVbxImbb7UlYIdEvY0hrEkYha+lrYGFBqQ05996BsaU?=
 =?us-ascii?Q?gNLCeOh9iAq2MWir7aNB9UFAkhZny1ZA8cwV8UUz/MrxP28oq/fcrBRAqLiw?=
 =?us-ascii?Q?Kf6MHRipUsGanIamspdiU+M4faqYW/beENl5afAN++GYSEIux4s1PXo0pnqs?=
 =?us-ascii?Q?UTQPa+WmuoGhI7t5IhNeoKvQZPr2FjFQzCtEj516GpgjWEEd34Rp2keCzqIu?=
 =?us-ascii?Q?b/Bu/Hb2dGZbzgWEhU3cBJvtkmXvRT7vcRMZSMY9GOPTlyOuR2rX5BJpM4jb?=
 =?us-ascii?Q?uyV/o4fZNYAQTDwcW/pXR6rrEkWmc84KoXXpBVWy4CnRgbDl5hW3lQ4O0Q0c?=
 =?us-ascii?Q?bvtLwlAwC7gjD5rCJPIa9RILj9zho0VJzDFSb3NMEBqVXWHTjhcoBXwZ8Mp0?=
 =?us-ascii?Q?uje18WX4iKR7ncMekiAljw8WSKWLrfdPMgOyv/jCdOz8SuKwbZz26OHJMKRj?=
 =?us-ascii?Q?OTik6dlY7PGdYnLUHp5S05O2j4s3G12/UbVh5/I7pom3vIGXRyj85O8yIIt+?=
 =?us-ascii?Q?9BH7E6h9qikFTWZmZ8P/HK4P2kwEhKQ5wnZwHZYvi6/yTNmVMJ5BEZfmrLsv?=
 =?us-ascii?Q?zRM/vgz88ikVN9xrdl5kpmgsHUtp9HCCyEywd/vWgX67+8i34Pax08T/W20S?=
 =?us-ascii?Q?B7J5goACggJDKtYlhFlLQ/Ze1uSloO14TWrZKJNoi31hKVJzo2TonpervY5r?=
 =?us-ascii?Q?ewpIhR6rfxCL8arYmcT8fZSbLIij+PHjs/pWLgW99UwHpcY9l223gVsS7Bre?=
 =?us-ascii?Q?BRhmOihfgJrDEOO26mN0p5hJLxuM7sWGBVqSr9f9TxtzM6ofgxOtEw+AFnN9?=
 =?us-ascii?Q?JdUC50teFeTgOCZ+zG33f9aY9f6gsWw6/TInlfV5Zhx97+GNl/XnBAj/aA6f?=
 =?us-ascii?Q?2J1XVO5y3YghPOZY9ziNjyQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1800c30e-e723-49d2-0dfc-08d9d5ff7543
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2495.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 19:12:21.2010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/nkO3RwO5oitRpn7iSbIeD/bXAdULBjjohQRnkJb93GfxiueqaKI3ynGcHv1Ni6HUthixEAb74C67quEDABIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6159
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the application queues an NV12M jpeg as output buffer, but then
queues a single planar capture buffer, the kernel will crash with
"Unable to handle kernel NULL pointer dereference" in mxc_jpeg_addrs,
prevent this by finishing the job with error.

Signed-off-by: Mirela Rabulea <mirela.rabulea@oss.nxp.com>
---
Changed in v2:
  Simplified and generalized the condition check for mismatching number of planes (feedback from Ming)
  Updated error message

 drivers/media/platform/imx-jpeg/mxc-jpeg.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/platform/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
index 4ca96cf9def7..b249c1bbfac8 100644
--- a/drivers/media/platform/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
@@ -947,6 +947,12 @@ static void mxc_jpeg_device_run(void *priv)
 	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, true);
 
 	jpeg_src_buf = vb2_to_mxc_buf(&src_buf->vb2_buf);
+	if (q_data_cap->fmt->colplanes != dst_buf->vb2_buf.num_planes) {
+		dev_err(dev, "Capture format %s has %d planes, but capture buffer has %d planes\n",
+			q_data_cap->fmt->name, q_data_cap->fmt->colplanes,
+			dst_buf->vb2_buf.num_planes);
+		jpeg_src_buf->jpeg_parse_error = true;
+	}
 	if (jpeg_src_buf->jpeg_parse_error) {
 		jpeg->slot_data[ctx->slot].used = false;
 		v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
-- 
2.25.1

