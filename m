Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE854DD5F8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbiCRITO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbiCRITK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:19:10 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150072.outbound.protection.outlook.com [40.107.15.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638302E1A83;
        Fri, 18 Mar 2022 01:17:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWmVyvIVMVIgX6zFe2NuWnXGlit34UvFHFyXHbM5MFPws6dP4+MEmHcnFRndijo/irwKYnc03XZtRH8awxrznDxq7a7bRMQZhpp8LiW6GETG5ZwLnWPSfCf99htBjlSP/+drA2C+OO2Iww9gLd8SKuKxYIjUWCCjqaOaHPtxYwcTEPNHernfX2ZqM5uqCJHAoq3hJ5aW09QuRCiV+MxabriG5BCvAWXQa3RxPy3piOM1rrQZPNlFHWRyr8PlVqZuYUEWGW4ml/p8JPp2yrp6Bq8YfllrLzUe0LYTKzqecMkmnDp1PScrfgNyjGzlMPZ/NckxnZDWlgNur8sw6nEP8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICyghvJRyomCtrEkMPimsa5pCA8XKB6BWA6hy0c0UlU=;
 b=UIeMRrQclPfDzYeOsiuxj9VJMoEkQK3NfOW5RkmK8VlWW54uRrYegJoSFi9QdYMLZKR2U6mbhD9l7FS+A0EcWwXzW17tZC7ihQvLBNE/p8lQQzDbzHraAK+UVN1DdAM7x2UQ/JygI8pVOqc33mF40bef/5Fqp11GE/NC/Sw4fTkRuXwshsuuIUvlt0lufDiDLXRk5UEx8QoEaehvfX9dSTF/AEXenOG73IeZuSmaCt1ybpNelMVDJQMpikZKHRK7KIEFnvnByhg2XExRBjYMAfjnOvTSJ6tsPsiVJ/tCAisizgaUNUa9tSJvg13xQFLM6yJBHUJXF5DsC/ffJ4LNAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICyghvJRyomCtrEkMPimsa5pCA8XKB6BWA6hy0c0UlU=;
 b=MBpsr3qfWxCTS9LTvnDjLZJtBYlJlbzsu4eoWjpktSKMIAGvs4LDodGjcTps/jwvr4dwDLNCCwPOZyEFixLKPUIeHFKUwZ3h6Hh9wheEoS/1dZnHSNVPOQivENM94VBVEGK+jYn31InP+g7EQqc5hkzqLo3Je0BBuBVhhz2WAs0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6346.eurprd04.prod.outlook.com (2603:10a6:10:10c::14)
 by VI1PR04MB6285.eurprd04.prod.outlook.com (2603:10a6:803:fc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 08:17:47 +0000
Received: from DB8PR04MB6346.eurprd04.prod.outlook.com
 ([fe80::a8a5:945f:4d08:69c2]) by DB8PR04MB6346.eurprd04.prod.outlook.com
 ([fe80::a8a5:945f:4d08:69c2%4]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 08:17:47 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/5] media: imx-jpeg: Propagate the output frame size to the capture side
Date:   Fri, 18 Mar 2022 16:16:53 +0800
Message-Id: <18af657bba31a7aa49a23e9952884beba7cd4f04.1647590462.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e5fed04f-46d2-4259-eb1a-08da08b7c914
X-MS-TrafficTypeDiagnostic: VI1PR04MB6285:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB6285A8EF902E5191CF31185FE7139@VI1PR04MB6285.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 543763QqF2FgvIqpXGK7cLDgB6LnINEWHnMNvut88QRSfGJbSPMmeyvAsiapAD19tQSJjB+4l/V63O3yzOyzUYoTVDQNwMAXuUjLycThXS06rH3o2ZRopkeJBprykCvFehFkfPu7+DU+6VP+0k1iUcSNrw1MeHBU/2lwrkU5LESxN50LTWNKmQt3DSeXXHgR8vwxHa8DhFpbxWl3RsW5m5lLIekYDH9tkvfQ1xjOQKDtXje3qHyj2tTFvEE6qGqQBTEHRA2akyJT/4TjSiejvMuI5ehIdEAIScm+PE08zcw5JU8lksfdgUk1ykeFP5Q4NrZ3WRdqXZOO945q7+2nt7YIvk6AfEETy28k92RGmmTGhj9s+Ew7dZdst8Gqf5/3xta5VLUJjhKVoPUFKDA2CQ98uF3EjgAQQR9bw5v0lJxt9xoKiyaFC5X4Ud2fzr/KeQ6huAeGW/hVvD2exFDzpJIEObKTD7nLY98AYFgM0HNMEs/5IpR1KiaQuDnNHL9sYIigs8UP+Wuhjx3MM8Pd/Au67hXeSibCL7/upluL4FNvwbBEX2L+PQvj9neUA102hlQe7YKGYdv9LW/H87GhSPUQfw+62CDvqa93IfR4E6zKOq+wD7MwPOgVBkcdIZOuT8C53VJDY7CokgNO0AbkGqy+BxB5kqolqR4skS/ee1/BZy3Mq+bFfxojs7Wo06p/6nFKx2V1kX00dGk7PbXp7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6346.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(38350700002)(26005)(38100700002)(5660300002)(6506007)(4326008)(8676002)(66946007)(66556008)(66476007)(52116002)(86362001)(7416002)(8936002)(44832011)(6512007)(6666004)(2616005)(316002)(508600001)(83380400001)(6486002)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P6AAu/kzcpPYzDbRZTfnv4X/90VEaUqlu65BKy/W0MGYH0uG0V5EzBsVy0M5?=
 =?us-ascii?Q?Mz5urNLfZOxQKzfaacTIyLYXjX8URNDLmmlfZ+sqhIMq/u8Qn9ZaYrbNKvsU?=
 =?us-ascii?Q?ALaOFY9nu0qOKtYP6ST9epIHvt2MF26P7axtb79OLp14nyH5ZGKtqUTkYviZ?=
 =?us-ascii?Q?CvKcVa0rJBOVKgNQm0ToKqplxrloJQB6XQjB0ziLSj63bOYaeZ0KLVjxo1FP?=
 =?us-ascii?Q?ETXowobOop755WLCS3+KEOsjUf2iFHKM96GpW4Cd/wq0+XK59+H8hft0p3Pd?=
 =?us-ascii?Q?2K3krLjpRUt5+GfKgNBlA4WO3PPCY7vZnpnqiXRdSMeHVL1WOFBgL98mt4bB?=
 =?us-ascii?Q?0s+qrSPA9e5mNWBTX+UheA3uN1hCZJW5XS29UNPCComf5OOqwJTogcJvJjg7?=
 =?us-ascii?Q?IlnNcIJxG97dcmd/Cj7JB4KbCLTGxloZm+ed6lpcgzF0rL/qQ3DnGCtHxSnq?=
 =?us-ascii?Q?SAQzaoORQfdAXVZvB7MgqLWat55C0lVz5ivu9B3QXqZpoThHsF0KcfEGqorO?=
 =?us-ascii?Q?PnWxF9PXQHfmfwRjxmrDxZ993qDSA11r1ruZQfFVua8Jj2aO8ipo+y/2d7xq?=
 =?us-ascii?Q?IV968eJhwe33tBq9wt2k/AYGcRny3yOCWqtOjs/eMqi8F2a5wMz7LUr0m4F0?=
 =?us-ascii?Q?7C8xXuVCL5k1JtPnRjMRO1BIMfdHnR1DKiRU7/1la5afLT+xcUgX5ov1uDUM?=
 =?us-ascii?Q?Jkt3bRDDRTcTbBEV/PVKzWC8Y2a3tSzhQXxThpXexloSyUbsHhf348m0kyJP?=
 =?us-ascii?Q?kp4LwEC0l5lhhX/FFiamOwUnaM8Wbc585h2de09RRr7c1iOOlC01dHVEKpwb?=
 =?us-ascii?Q?ff40OT1IBe32NcFC0OUNGNFg75CIdahd01Jke80mcTK4uZMaCN33vvagexBl?=
 =?us-ascii?Q?uhv7WZqrjCNPmcZuOr3mMrC0QDQNZnYmmJiMMUoVka358iXJiUamlRiUw7hq?=
 =?us-ascii?Q?rnyYgWB1ZTTq5U37oVhw67qpQlJMndf2vKQjoTLHTNoUBoKTQSn9Md1XSIFT?=
 =?us-ascii?Q?jcJZCDVyq4bauloVgi/tlJ2v5Kz1nYqC0KX8OWdO3uUqhzCKCjYxniJ8lvWS?=
 =?us-ascii?Q?AkomAhldrkNh11YNpHCEihfp/XCroaLabD3ydL+NQQKipzVIxaXGaChEXz71?=
 =?us-ascii?Q?AC6Rh9ebBVc2b4UeWWiMg4zSgxDYZcbXVtURT/Z/Ka5vlAxInELomsyEd7Nb?=
 =?us-ascii?Q?F3O3vO0BDPTHJyDSPXwIFBjN6QVS+dfwC4VJr9F6sC9KewjyNiU5VRl2Mo8d?=
 =?us-ascii?Q?d+Jkdu7a85LHGmW9JavcWFNwt4y1VpbOHfgEPvopsCCv+hJ8dUr4cP6lObWv?=
 =?us-ascii?Q?Z1SKoPbd97pd7AIgPsaE4gbM6V3MHDai9zGKlxu+sMJcC7Fhp4mTx7TccVvl?=
 =?us-ascii?Q?xJGHJinNl84v9sd5gXBRatBkz5yDZ1FLrI8QLc5vNEGnJGEN1cBUQWa6kDpI?=
 =?us-ascii?Q?sBTaVoluTgvp9GwDX5aqiMZG5T16/G1P?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5fed04f-46d2-4259-eb1a-08da08b7c914
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6346.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 08:17:47.3850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cbvkUMDKUt6kRVZuIUl3dR63LOep27OBZbHsCgP6iNG3uOD7vTnpI0pVP1p9us2Z6Hn8IcH8iHpBw71gmNHRCg==
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

The GStreamer v4l2videodec only ever calls S_FMT on the output side
and then expects G_FMT on the capture side to return a valid format.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index a95305639dd9..d2110731346b 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -1831,12 +1831,35 @@ static int mxc_jpeg_s_fmt_vid_out(struct file *file, void *priv,
 				  struct v4l2_format *f)
 {
 	int ret;
+	struct mxc_jpeg_ctx *ctx = mxc_jpeg_fh_to_ctx(priv);
+	struct vb2_queue *dst_vq;
+	struct mxc_jpeg_q_data *q_data_cap;
+	enum v4l2_buf_type cap_type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
+	struct v4l2_format fc;
 
 	ret = mxc_jpeg_try_fmt_vid_out(file, priv, f);
 	if (ret)
 		return ret;
 
-	return mxc_jpeg_s_fmt(mxc_jpeg_fh_to_ctx(priv), f);
+	ret = mxc_jpeg_s_fmt(mxc_jpeg_fh_to_ctx(priv), f);
+	if (ret)
+		return ret;
+
+	dst_vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, cap_type);
+	if (!dst_vq)
+		return -EINVAL;
+
+	if (vb2_is_busy(dst_vq))
+		return 0;
+
+	q_data_cap = mxc_jpeg_get_q_data(ctx, cap_type);
+	memset(&fc, 0, sizeof(fc));
+	fc.type = cap_type;
+	fc.fmt.pix_mp.pixelformat = q_data_cap->fmt->fourcc;
+	fc.fmt.pix_mp.width = f->fmt.pix_mp.width;
+	fc.fmt.pix_mp.height = f->fmt.pix_mp.height;
+
+	return mxc_jpeg_s_fmt_vid_cap(file, priv, &fc);
 }
 
 static int mxc_jpeg_g_fmt_vid(struct file *file, void *priv,
-- 
2.33.0

