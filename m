Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2073F4E4EEE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 10:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243149AbiCWJIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 05:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243098AbiCWJHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:07:50 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70053.outbound.protection.outlook.com [40.107.7.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089D27523D;
        Wed, 23 Mar 2022 02:06:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dh/QtLEXij8ODAO8pn3P0su8WYR0tIHCxeN5cuO/33mPP63/5nRQZxmT4khg7VJLAa5KdHQgx2Dtr6cViQ73/HflDVh9h9VtkiShPgPEUdWyrPgaEu7u1CzliNlOy9EoAzAjYYQQVYH5jcT0SU0FgXCDKnee12oxpc4aMFonayr+HU6M0n2c/ViF4Zgc98gSTJbQhOhkQcy7nmBuu9Aqq5a5o7gH3H19MLOlWimWIqLVhCCdrSeWjqh4YBD1UY5xm4BnO1TSeGlzQnTTj12mfgXFhsObc8+FbGVZiKN7HpNDflpsM+BQkDxJZgD+K7ijEpi8GOhd9R1Vjqmxk+rugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nV+4+ggQij4sZAFQbBSSvSn62mz5psI8ZHje06+CNwc=;
 b=YAaQVp9aiCz3G8WAui6U1N1n7QTGul/GPXtyCAHIlBnsfAZEx2+ZszctkUzj812HRQYRI2NCDvXIlocAW8LSiGoRavnho3gW4ujhVGf2lHbBWN/FNZJloynokKRNri48mLiKQnhS2v/XoPXpVNCBzR3zAxCOh4uXBnI/KJWcmEHVlBkGZ/xyecNLZYn1NOgi/6oWFKDeXb2mSu5555e9BmOG21CK3fYD44zWA9WZhecUdmzwaQAd/8mRd++9DQfCX0E32YfFQMqpfr8fv9Fr3lD2lXU5VaI+IkID9c6exWT0F+D6AvvOUcgM/+7aH8+6fjcp+X5tJE0V3MJE33Tn1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nV+4+ggQij4sZAFQbBSSvSn62mz5psI8ZHje06+CNwc=;
 b=KtiOONj2iapUFXpzQCBhltiPVpMwPb/gawExTS7lJYTdwsqA6bx8uA2xedpOQDi8iGjFH6WWhBEaoWa9tKvkEgVpk2L05qMCzCmi72s2ud3XAlvLtJecpBU00pMXXVMPke6LfHQ0qy7VA32KsU/hG3GsuD/6PajsCb2XA7Son0Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR04MB4901.eurprd04.prod.outlook.com (2603:10a6:20b:1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23; Wed, 23 Mar
 2022 09:06:18 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5102.017; Wed, 23 Mar 2022
 09:06:18 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/5] media: imx-jpeg: Refactor function mxc_jpeg_parse
Date:   Wed, 23 Mar 2022 17:05:54 +0800
Message-Id: <9f67125ccbab5d36f985c783990ac2767df50f36.1648023273.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1648023273.git.ming.qian@nxp.com>
References: <cover.1648023273.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0401CA0014.apcprd04.prod.outlook.com
 (2603:1096:3:1::24) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0046c55c-68b5-4fc6-03fc-08da0cac6438
X-MS-TrafficTypeDiagnostic: AM6PR04MB4901:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB49017952623DC0798D8635EEE7189@AM6PR04MB4901.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: flrJmAd6lUceAqs/sS26ZJWhXoEMbCU+cKtXdD1Q+OiOsaA7B5qLU1x5VAqLf/FLUnqUgVtzzS3aAwL4eHufNi+2V3tUmQYGoPn50zeaqTZng1jJtEwTT5GbLBI/hv/XqPqSY5W+NChdTXMEgD6RosKMH7GMw4d9wAohe/B30a/uJLTW0xr4251ceskW1Bl2veKTHk/uyMHgFvQ0i2Inx3dm/577PviM6yM+4DAuwZoX0UNAFFOpxhsbB6NG5sYdsLTspMN3MaeBSh45Oit8kGnNnBV94RLYnbAeC4/OJEZzXl3ma8QUEX7aHoraRtHe91Wclvdv24J9dmTwGgv9baTbg0TgssVQzhWM6qljllixnqlaEdbnhZb5brcQPX1lsL/Pu7WdaRohJ/ewEkPGnTfynAL1H3JL8o42f3UkZLdolKty4O6h4O3bU1BVlwVA7zNLZNXqUicjIhdp25qO2WHCUgQB1SiR7MCk9yYDLoxMQj795fgmoN3xHRhJkGvqert6JsiizkLjpqEj06KD039rFfLIVrRA638JFKkglGfzu07qp/omMvwbnZ6ehwsaVlrf1So0s2o+xUMMghOzju2As+LaWanjtCO36hdIT/ILnKWXMGp8Eiwf53vOcrSGZs+WBXyj217OH5BtuROIUhq91lUcpWpUwy2FqorsZ2dbibGP4KUamQiefE0IhekbDV5Nh+cLZVuSMbTKgxcWcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(2906002)(38100700002)(38350700002)(316002)(8676002)(4326008)(66946007)(66556008)(66476007)(6486002)(6506007)(86362001)(508600001)(8936002)(83380400001)(7416002)(52116002)(6666004)(44832011)(5660300002)(26005)(186003)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?49iIVbEeBSdDIF42GMc4hJrwBgGs/Ndvz3pGgEjWQ5JUIUHj0bmCTAQYhJ3N?=
 =?us-ascii?Q?t5NYdMRcbwhUPdQIxUYJ4p+D4cjVZBpZLMXQ6Os0p636frpgb7Ul0ycdlOu5?=
 =?us-ascii?Q?WvBkHbL5qCzRhZFu3JOmQMikhZJXXZ3N2w4/agzK8tM5r85rvWhuAorsHLWk?=
 =?us-ascii?Q?B8GRkvELMOkUwBizLkrgrdxP9OXZPjHK39pt/s08JYD2p85fMc9+T34Nr6YA?=
 =?us-ascii?Q?XN+KST4+gIZCZhDJfb9N0PjRjXj7HJnEat6LtSrQZKsDQFdx5NG09uGyqX9H?=
 =?us-ascii?Q?ar66WAFO3PWOW7OpJGDL3zACWFlM4Kl+RQNqiCbelJfe5j+VLOQrebIFhoKV?=
 =?us-ascii?Q?zjLNzxAogDPlF30+4yvdICkyL5ktOqhtrUiSkPN1CQxSY7OBO56VNTZ5+xHy?=
 =?us-ascii?Q?7qPRE0ViBN/2ruglz1QEb60OFlxl3uMywcjp/yYLB7Md9zh3a98WpRhozrAO?=
 =?us-ascii?Q?HJoixXTla1+bACUO5EpuBxGUEqKsUQ4IUu91L9OTjwu5Xl8KVNlOVqy/XHys?=
 =?us-ascii?Q?A6KC8Qpd89wBrVvcwgbyEmvc8kIywRUKou74/KONh3ev3gHLYGgkADvinKpm?=
 =?us-ascii?Q?uzHCoKfbLmdBbFdYQUXI5BSoZVNKL2SYrC+B8oIO+ZtsmD+RxaBkuWgMAtw/?=
 =?us-ascii?Q?r6sFnEGXz/Hvfd31xM+GhW24SGpr9gc/HPJUhwmQro8/a5+r/c5m0Jji4Byd?=
 =?us-ascii?Q?ldtaFArwS87/y7NoTVOIPBMr4rbumRjZFm/7fNQN+omQYCuXPEq/stgkFluw?=
 =?us-ascii?Q?uaxxSN6cF/0nX8oRelX9rqfG5pwrb6hCS0dgzJ28LG1QwItl9TLbFTK5LqB/?=
 =?us-ascii?Q?3m+qNzqzVp1DdQjrCgJM6uBcyAl32ayY8+UGM1ck3Rk4dG6PdY8UJgAm3oJG?=
 =?us-ascii?Q?lu6utk1OwmHTxg31iUSdnhlJrMvpR+p9CbtzAg5wNHlfvzJcUPGqxjDr/vUk?=
 =?us-ascii?Q?qrcNwrmU87Qi3eVrwwsEBwLYhUzqBw1ujgzHAbXA/ewmU+ThebVjCBgDhFli?=
 =?us-ascii?Q?kB5bQCpepEpuJ5jvNFzfzN0Wt8y8BUJx+5LuzKejcz6IkluZ8bFOB8ixjEz8?=
 =?us-ascii?Q?i4bMGmwOXogPHxOK7PtQnVHxQH5LPse56B7OP2UwvmSDhgRXmKa1ujRMhA+6?=
 =?us-ascii?Q?LO4KmAd+icbEPewtxgW+nPMEnLqdE1l2llYuP0gENsSs7PPrS3dtSvHiFsjX?=
 =?us-ascii?Q?2v6TlF+NF6nU2/riaoVQ57r9eCjyWsmT11C3TUjpFe4oRGqPJgGczc8AuJwf?=
 =?us-ascii?Q?hCF1qGoQxklkQ9vuCVU7beHVKfION6RTZwXyUhH4McITKaFWLBDk30y5m1Zx?=
 =?us-ascii?Q?cpwPxy376e/4ve5/SKUfXpO42UwRPZgkN1tMLEO2HCpC0I0EEW8SgotzCskZ?=
 =?us-ascii?Q?AE5gI8lF5A9RMjRNfTB7Pb8px8fQ01pRTnruxT700Jt9pixdVAXNmvd0TEeU?=
 =?us-ascii?Q?ghQT38/7t6DHQmyR2VpQduOyhX1bfWcm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0046c55c-68b5-4fc6-03fc-08da0cac6438
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 09:06:18.3522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bs3Mt+Qeo7rLiW8ocve2CI4bYJOT/H/NiZttdPhP2n03O8KlgWFeydDwhlb7NHB6FoLrKh25Z2s4ZpdwMckk4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4901
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

