Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F1C5459D1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 04:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242370AbiFJCBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 22:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241068AbiFJCBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 22:01:16 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70040.outbound.protection.outlook.com [40.107.7.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA02222A55;
        Thu,  9 Jun 2022 19:01:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HeR+1bXBELFGbNkeIZtpaPyfCyZduSiekR2oFA8kigxMKxlZevaErnNj0pKfuFB2D90mm2xI01qvt4sBr4hxmNK87at5ywObhGtL9JGkNiNlNctMOv//l/GaNusliM6ToB7N8HS/rcB6/lroJPx0j8Fb2eCoaPRbn8yojMCblixXm5qEpLR2AbG1iviufsPBjoH/+s3GLrmu8fsJLELg4UMqxBKCPO5HVW/cVS1XmNwdoaSbPfsC1N6JGYb41FIGpleZqhTzeLhWF7234E7lguyIywt/oBFmmZ8SdzzTfKDZD46zRHqRv/63/cF8QHvONGu6XR4LiMeUUQr6GQS0pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6u4hEEhYn54Ul9LclNgtG/hmf57LAryMt/Wmds0Rrg=;
 b=MxeTaXj9PL36FHvURoFX/0LuNkAmk9+KLsZVosIitOAbnQeSdlXJ+txxyTVSIYI4VbkTi2DusZrLpiUcyYyFivltJxlOws9OsEGmeeXJAFOjNHuLKvuvJRKEA1zZ8GaiQ11eaKFvsxVLz/m3qFWm0anYguK9jPmW6HQF0/x5cRczjEJ3sG2kxmUzbPJIwKqOCSKWc+7AasN3z5CEUz4q10LWhDNH54gRPhProPNo6qhee3QPp0ZEm2Jd7jI8CExtkV0b7sJrDa4P+9ACMZM4E0bq5wa+jGvxdrw7UecS/GuJYBxv3dZ+uVQhAAufbjN+IRZg5q/H8MEvCaYHwH2v0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6u4hEEhYn54Ul9LclNgtG/hmf57LAryMt/Wmds0Rrg=;
 b=f9gLSjnhb4VV8FiD+iuI0u7AZcxy+hwSdf/eZgDHdGmQsVlTQzWfG64wHjfGecz7ksuHkAjtmB9jegsm9Sv0DthPlBhJP1G3UFkvPCp10ODqjtacpjx130FVRFWs07MYwv6dwQ6OVcpcfwGhfDX7zAxYwOuFxp0QYKlVoWzVGxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB8PR04MB6811.eurprd04.prod.outlook.com (2603:10a6:10:fa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 02:01:13 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5332.014; Fri, 10 Jun 2022
 02:01:13 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] media: imx-jpeg: Disable slot interrupt when frame done
Date:   Fri, 10 Jun 2022 10:00:57 +0800
Message-Id: <20220610020057.18124-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3faf1d6a-820e-4407-625f-08da4a85186a
X-MS-TrafficTypeDiagnostic: DB8PR04MB6811:EE_
X-Microsoft-Antispam-PRVS: <DB8PR04MB68116E279D20EB4498C5C917E7A69@DB8PR04MB6811.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tZD6xT/siZRNUzMOTS5lcI6F5NUxZr+lPA8y03ThfTQsa6z/ivzywSx+MeHNjUyQLJIj8toSVxZ64UO1ddgT3A10B8STouGiEd8/y/vr5DzAg3YpUA/4kCMlrYLgqeWL97pt/LGdyK+S9nnVXFXeomJh6SqWBzjRYr9dMtQZm/dYUgkxZuGiHY/7m6QBNhUFlW6rcsS/y9yP8YsJZ1Kggb8MJFK/Qfoa9mLi2F3If7x6YNVC7SDvmiykROq0FmPN7fFvRED5Gq5bFEfqW4z3Xxsb/kc8q5xrhOIPI6ksA+ZcCkoQGAh+dTNSdqZbyuvB56OCbBXmIJZBKXfLE290flnuPVp/QRwrYw5rNHu8f1uaZ74ND0H/fJkcXG2326WR5wEl1cK2yqJP/yqt35+/+G/J0j1Sq8LYR54eIZA1aaqiZHkR+LDTLP8VWblLU5W/NsEXzIAKt7ZzTLInXAmeGke2aMBJPGiRIc55WZ4gR0VZsjHO0DjfbF/aGx7c43G7o6CeukYnV05hX/eTkg3IbhZi0ZVkIbWolqfypokcA4W+wk5z+vtifEsAkGrPgjbJLFq2g1HvA/GJyJpN4+u35YBfMnWfRuoqvhiF5vQj6qbfGaSZJrEl7sPbOUMbOtNPcnkuUrtqEYp62QogwNh/VVAKshbxKyf464Ztacm6ucASxBzZGx0rZ25w6/mYepfIFAXsh8LgJVh3XB76r1VsDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(6506007)(6486002)(186003)(8936002)(6666004)(52116002)(316002)(38100700002)(2616005)(83380400001)(36756003)(5660300002)(44832011)(38350700002)(7416002)(86362001)(508600001)(6512007)(4326008)(8676002)(26005)(66476007)(66556008)(66946007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CxPD2wqH7rMG572IkiCo7+qXcSitFVdEMY5G4kR9LqS4lObYJSeRZn4j2+Nj?=
 =?us-ascii?Q?HAJfAh0ePXER5yJNwxcjSiFyTsjmkjGpc6Hfd3+JPCjULqxIwSg338GVHgEa?=
 =?us-ascii?Q?1v6sjUPtAlsDqrrsOqXoJbnTMDhaQxMoDNN9WrZ87h9jIdt16Q0k0X22xjBW?=
 =?us-ascii?Q?yVMjFUPu8CBedj88Nf88mbaUmC1/aHfQd+g2+IdWfC8WVcGfxuO7NFr12bxc?=
 =?us-ascii?Q?l4x80org7pTL9XSZdwfioDZIMnm1N09oux4UuiLA495w10sCBotua3QGsKXk?=
 =?us-ascii?Q?4uGABqMqyJ4Vy/wwtCN3FvG3B7hkOufTbPNWeTNuXFlf/FsuzGC91k4xHaZm?=
 =?us-ascii?Q?USnaNo37Cd6eRIvSXcRiOu735D3bGRcwlcEaBhB3XwCaSBzqgMoyk/VsKa7G?=
 =?us-ascii?Q?YJ+NjUmQwoH9dyaul9dGYUKk39qMPUq8PYpRyuczF0MCvXcCFd2O8o/L6/FU?=
 =?us-ascii?Q?3M+CiHyQu706tZEWn0x+MtPe0G4+UVnOtqigDci0STJvacMs8EtuyB7twjAx?=
 =?us-ascii?Q?mHl8kdDR5AOfzjmiLCd/zB7X9WCKk4ugsFONEx14vmmYxZ6L19l+jeSwVGhD?=
 =?us-ascii?Q?E7jPTHU+r7JxklXzdT0AbBgYmL1R1Vu0fdpfmyrFUMi32dsQj6CUlsB4PefF?=
 =?us-ascii?Q?ehYd/B11Ntwd+1HmhCHvU0d+VYC3OaWSiXIDBfTk22mgyW3vRgU0fHVF3rLf?=
 =?us-ascii?Q?rCJb/xtMiQY25G8eY8/HpLKua4X/BTnmNVMjw1iY/gcKp7m6fGufuk4r8ERM?=
 =?us-ascii?Q?jk4MerkiNiZGVVwgT59Yv+l2xg/u6u4cbTw3BqpHLtVh0qD3QYV/KNSPh3wt?=
 =?us-ascii?Q?fKjh+LZH/r+Xe2g9zlRi/Kt9wwH1NdFeyXWAldAMVObfdOx56hYPTLdRlo3N?=
 =?us-ascii?Q?mTpSyoYg3W7i55qTxg7t5Rwk+cCaKQC4D2YgNujhn4gnN+pAWoBPH+eOaICd?=
 =?us-ascii?Q?NDoGP5kgm1zGDawmP6yKLXCy/LAEVC7UK0PjEJ488XiZQFZHR7D7+WDXKa0g?=
 =?us-ascii?Q?cNMvJbGqB4cAHMHb/ExVP5nbwCQc4fsPgv8DJ/ONuB3jTfTVt5rubLAmw3E7?=
 =?us-ascii?Q?XN/46CCywUtHUI6mJQIXlyVrWcg13OYZMrqNTQYbbi1xPtHYi7PiwmyWjprp?=
 =?us-ascii?Q?WF3RgcIq6rhvWIvL8KeRpSBqlgzywbHn2zBqZmEvMtZhMvyCf8gyg3657gII?=
 =?us-ascii?Q?TaSvCQv0EhSe0zXIhsVPiwtJ3TVzDlqhxkwHd1kC163MIfoBT8z24IVORzYg?=
 =?us-ascii?Q?psAFxykkZ6eSDy5LQ9/GlifOiSsz4XcabyVG2a5bxGYlMrk1ClrWcwXqnyoX?=
 =?us-ascii?Q?A8rqDJsLrLZnx7xb+rI39j6uXVadk+WLr/iu5g9YTBPzgEqHdXs5D1XYO5ku?=
 =?us-ascii?Q?dz2Vcly+LLnCasGdWFEjJBPsYfCwds7BrSXBZ+9DiroeWCvIH41l0fZJOGPD?=
 =?us-ascii?Q?0GTs8isflcKg7mjRfAQ/f3tgj4X2N+vdOg8YXTGgpNqFonSnC2UyEK6xpB6W?=
 =?us-ascii?Q?buz6D63a8f0J9llHcNiQRo/1WzEBmOii97TMRAf08ZxbOoEBAoQlbXEHACP+?=
 =?us-ascii?Q?ibOHdBYHmWtP/2qbc/uDKGam4xeKWDsHu9M7IdsKR3tW6aYsWvUqLj1Hf/30?=
 =?us-ascii?Q?RVOKRYSU2KYAhBwtNT01s2XXhmzVxB2z4c/AD332oS2PT+ZH+PSgdl91O4W3?=
 =?us-ascii?Q?83pN75fQuetkxsMFUA4YfDQEDcSZslq1RcqxbrnaZykgL/lujvEe35sZ71U/?=
 =?us-ascii?Q?5l7maC9kLg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3faf1d6a-820e-4407-625f-08da4a85186a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 02:01:12.8952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kAbWxKNaUtAYZVN6FDOt1nYTkGUEgOVY73HPq7DvxPq+H6nuP1fUd1wFhaPRaX2/8Z2WBm/1CKvkpI0BKrTg/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6811
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 10 ++--------
 3 files changed, 8 insertions(+), 8 deletions(-)

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
index 965021d3c7ef..c65d480c27ff 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -592,15 +592,8 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
 	dev_dbg(dev, "Irq %d on slot %d.\n", irq, slot);
 
 	ctx = v4l2_m2m_get_curr_priv(jpeg->m2m_dev);
-	if (!ctx) {
-		dev_err(dev,
-			"Instance released before the end of transaction.\n");
-		/* soft reset only resets internal state, not registers */
-		mxc_jpeg_sw_reset(reg);
-		/* clear all interrupts */
-		writel(0xFFFFFFFF, reg + MXC_SLOT_OFFSET(slot, SLOT_STATUS));
+	if (WARN_ON(!ctx))
 		goto job_unlock;
-	}
 
 	if (slot != ctx->slot) {
 		/* TODO investigate when adding multi-instance support */
@@ -673,6 +666,7 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
 	buf_state = VB2_BUF_STATE_DONE;
 
 buffers_done:
+	mxc_jpeg_disable_irq(reg, ctx->slot);
 	jpeg->slot_data[slot].used = false; /* unused, but don't free */
 	mxc_jpeg_check_and_set_last_buffer(ctx, src_buf, dst_buf);
 	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
-- 
2.36.1

