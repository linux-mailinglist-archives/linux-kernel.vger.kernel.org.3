Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620DD53F718
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 09:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237611AbiFGHXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 03:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237584AbiFGHXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:23:42 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60063.outbound.protection.outlook.com [40.107.6.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A4C205E9;
        Tue,  7 Jun 2022 00:23:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IN888fHBm2xxN3w7VFU0GO9gemkYRqga+Ns0yHrSMXzT5ycGYB/V9F8RDYXevQT/RWAWS3xbgdwTzMD9n5mdOkatBZjlOtgYDv3TmEvjbbmiJ9a3X9J+mkESowPZYmCODg6qjgeY/VRU5eS6oFuLuHJmGWAeIL803vlLbnNDIDjkLC1Uf6O5uBT8Pz8u4ud87SsA7/3dFgza+Axow9WFP+IV6BMhJv+WVlhF5nuMjyDKl68u+L2WzeUCmuDiqSOJzAqmRzGiySGDtNmpHo7xd2/eV+a8/+LlQcM3BTNJkw9FI9x7oJczKWWhPIZPrtGjTPs6OV8tkKFRvbYql5INqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p43aOVL41XDfLIKXTvhnmGLZww/3j6qwCGyPvHr+Ydw=;
 b=WSEDq3AohtqPNTfnXOmwG8C9hFFmYoaJYjEZdBCVdhKeN+uScfzJbWG9yIsu2d/bIjsc2R4sx3YI4lgESUagu4LBqMEQA5NT/Bmf0H8Z7N+M077t80VoXWGiByP+jTCPR9xqW5kJ/Uw2CJbcEqIRWmN+rzhWW3/4KPV6rcfdAQdB/sI+McYp28h4CrUsPJG0irgHvjVOSFR2owMZrPyILy8bw1KCvw5/CuTW3ZvjwPVFJmmKNhrS7SqwqHbCn61/vz7gAIzO5p4QLXtYJb4lWvWQ86d8uc7jnE4K04nxbPQdNoT3NTZX0ESvAF2sWNOMyOi016p6r41MP7vLvxXzbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p43aOVL41XDfLIKXTvhnmGLZww/3j6qwCGyPvHr+Ydw=;
 b=ddp0gTUl17iK0+0nKioiXS9y+QrL9U4f31+gkG0btwWOs4+5YEi11uNa9p4/uETVvGoqoka/UQ0Pi17b7sCPdql29ZkIS5LoxwPRgNA7EUZAJolsQpHsoTx4LQD1puqEMg0jiWmuq4h0a4+Wi+qUAfCGbH47iRRNVs1tzaWO+IQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM0PR04MB5972.eurprd04.prod.outlook.com (2603:10a6:208:120::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 07:23:38 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 07:23:38 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: imx-jpeg: Disable slot interrupt when frame done
Date:   Tue,  7 Jun 2022 15:23:15 +0800
Message-Id: <20220607072315.23209-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b79c45b1-6790-452e-1a7c-08da4856a411
X-MS-TrafficTypeDiagnostic: AM0PR04MB5972:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB5972F707796D5587770C71D1E7A59@AM0PR04MB5972.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K4jj5/KBlj7qy1bgQbB9qguKlh03tlQXqWL+3pXO/9IYppEa5jFuN118f6FH/a/TVWdWVt1wXq3BFlb+c8uponn7UOI8gVBekCjK0f3Q0N9tYkgF9S6K4DHuk/+bQXnH1O7NnSX0+KoW5EewWNLdOd5uSH6cpRKPtSwZ6po/W9cChBIFsC4aspCNHB19PTJneBEUdjMm6r9X+oNyUk9dOzeRgrvlJoATYYbEpWKqqNACC1QVkwQ/KAv/jfPV0X2AsHPUELGTWYSbkQn8xvHUImybGBvusFf1WbPOxRozd2RzcAY1wFLewv6bfac04UKNScGP67aafWQ4Rw1Wxu5MBmqxFvOC9h2bkEMYt+UE+pgzDIlmDT6wtaHfJLPXrwXDq82eEFSMbXZ2FSZf6qDN/m7uEXJXxemsCYq06+axGLSh7poEVflK5XJDwnV1MB8SchgMSg+dujZspv2d41UinDb6gt5dg95gmlxlrCPipnqGBuXT29jdHdWZejtB0nJPw+9JO17u7GQAjtmWiPS9RWUZPhxX2d/yAn1uY/RtkvuV49fzMu8wkB2+aRAiV4HoWOArkHHxzQCqfeBjnsktaiDBm8fTneKjktImMoEvuS4Z3IEnrGD+wcsa0mNO39k62BAvM92OJHCcRmSa8AsT9QkZCjaMjZndh59PQsZs0YL/4nDkfRAqitZ7NxX1N6XN4HBnRsnNONv7aBxNQkKoXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(4326008)(316002)(8676002)(6506007)(44832011)(86362001)(2906002)(5660300002)(66556008)(66946007)(8936002)(66476007)(6512007)(26005)(186003)(1076003)(6486002)(508600001)(52116002)(2616005)(38100700002)(38350700002)(83380400001)(36756003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Eg4XyMfiv6p6adIC+xVgbASeq6C4dH79sPZjM72JNOaxmjVQS6v70jF+iRFM?=
 =?us-ascii?Q?rI98cWDGYZKX57vFNo5D9a0xxXasJ74WpLVR/K6fKAAAOm7o0ew/QpFBknwP?=
 =?us-ascii?Q?VA6v0ETZH/bKuciGMKWaRhaD0dpJFz+mkY+meirATXPkGK8lBfKg78oJxy31?=
 =?us-ascii?Q?pw8//A/xgze2Ti8jlmSQFFB2RTOGuj4rMLdbFlWzSBUtXKLQr3hs/pEcPt7q?=
 =?us-ascii?Q?UiFqIsn7SgAvpU9Bby80XpkIxjh91+YQNwYhgdP7C0WELlUYLeV54KmrQOBS?=
 =?us-ascii?Q?MNic6BoS1F5nF+7fEz3QrkBLgPDaHX+ckU8kQJYjlxoNgYu3tXqIbl6cAms1?=
 =?us-ascii?Q?3Bgxp3cfEOMc9lEBqr+OwT77Opk0ZkUpGWQpx3zyEMRzumLF704TqM6l33GX?=
 =?us-ascii?Q?UUAODc5ptllkSE4St0CR01Hl0gOjND67wSvrDbrW3YgALPvb4hIodNdb64Wp?=
 =?us-ascii?Q?ZNT9cjag7nLf1cU9pVXiF5rhsSx1HmQ0rrKRJ+jq5Ason5E4FoshweYPuKli?=
 =?us-ascii?Q?zCEEDhx/782sf3bY9c8eyVPmVrfOl/6lFebOOLlbb2VgO9NSrgnfmD5Px/Id?=
 =?us-ascii?Q?GQCmcx4pB2Z21RQpiUg8U5+iHtZioUpT6mpQqBSxCdYNe+dLuUHKeYFxJHMy?=
 =?us-ascii?Q?Y+htfRiznb/o9Wi3L7p53705SQcd9gGBsie+xLiPnncEHA4m1BDXgxYFMrun?=
 =?us-ascii?Q?CyUlNjhfffjtvYK9F1hojXaHefY1qVRQTVcOPgLTQwkUpR1lfe1NuHtYBcVh?=
 =?us-ascii?Q?rWGBPYeWSQ2Y6nOlHACGqxzrVQXUlznL1w3iiDkoQ7/8udFeiEhHH/M7vHj6?=
 =?us-ascii?Q?GtFzb5wRFLo4GfEVDHEO2y3EHQ33K+3iHMPA5FoEo8Yn+7MAXKecnJW8Gt4l?=
 =?us-ascii?Q?qIxXvwJ0kH2/CmCVuBtRahxc5sx7v+A8PqGbDmQnfQx6S8dpTBTsDL79uFJE?=
 =?us-ascii?Q?1wBjjjUAJjBa50K4cTJSDQYha3JgYBRjnthvG5uLe3GuleoHoIas8kvLBILV?=
 =?us-ascii?Q?Fuk390e54H69Ti5svwbZDKe7LLTNmiAZKgk+V/4sR3kSMTV1LTsnevrB7GmS?=
 =?us-ascii?Q?LPTKYrtL0S2tjakCIpT7+wfCZ5Vzu1hij3i3JLptFe4dy35Rj7nhys76ubAI?=
 =?us-ascii?Q?lXUcne7dHaST897A+eoqbLKhnSobOq34mnZGXby+qJyaLbb6SCKSNMQuUEy7?=
 =?us-ascii?Q?MdR14i6LvXCaPj5cC1GVWxcZYAd/a+enxu1s6R+ixLSKCkdnVQhjqg2AsUd3?=
 =?us-ascii?Q?i6Slmmx2KDnUg7WfptJrLuXirrz9em1OCpx2yxDAumme/SQYNIb84rTHAbiE?=
 =?us-ascii?Q?hi0ZEph4l7p4xDOd0HivIm/8zQx55XXBz5nYZ9bGcTfoh6pyc32y6mXLFqwk?=
 =?us-ascii?Q?21rzBqUycxp9ryqFrYmBVOv6ui6zufZEklFwisAw+avxD6Cn7ezUx6ILUcWV?=
 =?us-ascii?Q?Gw7twCGfTCjTmla2aFj8KJw2VhCzG5wFN8EpoSZEWhAg9Xv5atPnbvaufwF1?=
 =?us-ascii?Q?sBBLLN25Wj3dO4LiiO67GXK5bPrxHBTfVaS+zdHs+tpI224VtHORJISFCKYE?=
 =?us-ascii?Q?p5hCh6Qj6JTqMsfi7EVIGXWezfOzK7mlIbQaDAF16vYEwDkNSa9HR6V1nPnP?=
 =?us-ascii?Q?H77NwFAaw/j00W39gsgBCRrsfRmdJzzyxY3WAGCT9T6F9AcsSOH9YchP0DRy?=
 =?us-ascii?Q?Ln51GWAWbNhAodyRg4KUsK0RMpHHipeMZiQ+h6xGqfMYYw2KaUBfzMQScycm?=
 =?us-ascii?Q?uh4ZgN7aLQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b79c45b1-6790-452e-1a7c-08da4856a411
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 07:23:38.4880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qazaaOIYP5z8ka2C9ne1u59L3ZMiSnh0ipBoCvde5+g8uwOiCDOvretb7bhk481cQccJ5K3f1ME2mdSf/cq+tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5972
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt STMBUF_HALF may be triggered after frame done.
It may led to system hang if driver try to access the register after
power off.

Disable the slot interrupt when frame done.

Fixes: 2db16c6ed72ce ("media: imx-jpeg: Add V4L2 driver for i.MX8 JPEG Encoder/Decoder")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c |  5 +++++
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h |  1 +
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 11 ++---------
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
index c482228262a3..9418fcf740a8 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
@@ -79,6 +79,11 @@ void mxc_jpeg_enable_irq(void __iomem *reg, int slot)
 	writel(0xFFFFFFFF, reg + MXC_SLOT_OFFSET(slot, SLOT_IRQ_EN));
 }
 
+void mxc_jpeg_disable_irq(void __iomem *reg, int slot)
+{
+	writel(0x0, reg + MXC_SLOT_OFFSET(slot, SLOT_IRQ_EN));
+}
+
 void mxc_jpeg_sw_reset(void __iomem *reg)
 {
 	/*
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
index 07655502f4bd..ecf3b6562ba2 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
@@ -126,6 +126,7 @@ u32 mxc_jpeg_get_offset(void __iomem *reg, int slot);
 void mxc_jpeg_enable_slot(void __iomem *reg, int slot);
 void mxc_jpeg_set_l_endian(void __iomem *reg, int le);
 void mxc_jpeg_enable_irq(void __iomem *reg, int slot);
+void mxc_jpeg_disable_irq(void __iomem *reg, int slot);
 int mxc_jpeg_set_input(void __iomem *reg, u32 in_buf, u32 bufsize);
 int mxc_jpeg_set_output(void __iomem *reg, u16 out_pitch, u32 out_buf,
 			u16 w, u16 h);
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 965021d3c7ef..b1f48835398e 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -592,15 +592,7 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
 	dev_dbg(dev, "Irq %d on slot %d.\n", irq, slot);
 
 	ctx = v4l2_m2m_get_curr_priv(jpeg->m2m_dev);
-	if (!ctx) {
-		dev_err(dev,
-			"Instance released before the end of transaction.\n");
-		/* soft reset only resets internal state, not registers */
-		mxc_jpeg_sw_reset(reg);
-		/* clear all interrupts */
-		writel(0xFFFFFFFF, reg + MXC_SLOT_OFFSET(slot, SLOT_STATUS));
-		goto job_unlock;
-	}
+	WARN_ON(!ctx);
 
 	if (slot != ctx->slot) {
 		/* TODO investigate when adding multi-instance support */
@@ -673,6 +665,7 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
 	buf_state = VB2_BUF_STATE_DONE;
 
 buffers_done:
+	mxc_jpeg_disable_irq(reg, ctx->slot);
 	jpeg->slot_data[slot].used = false; /* unused, but don't free */
 	mxc_jpeg_check_and_set_last_buffer(ctx, src_buf, dst_buf);
 	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
-- 
2.36.1

