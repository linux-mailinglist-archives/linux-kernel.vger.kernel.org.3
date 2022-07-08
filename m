Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D4556B4F1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237846AbiGHI5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbiGHI5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:57:21 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70050.outbound.protection.outlook.com [40.107.7.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3096B7D1DF;
        Fri,  8 Jul 2022 01:57:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1FJcCiB8GieanPKOOUN7gqxHnMVz2ioJ+oBtsFVQhniXGAN/GfZGGDFTaXZ93QzuB7nGdQmk60XZg5ap62/f9ql2LlAfRPyJRzQoXaboY2GVPtpm78jIBumoBOrmPLVCj06kIW50ZNyNpJq5a4J78skq8gxJKQiXfmTLhpWDQLnBrgDsCz2VxuzUA4oUOea9egHd/k8aZzpHiCQUgh5JDmVd3bBQkn8Dms9CqckGVoaF6CQcZ7SmVpzUPyrV5sCL9TKY7txLYY/WxhVdZOAjVzCWwvwlkXKi8XFpxh88eIEKpTwuS1hCPaNSI/YiNZmIE516Z/nprE/HdwL0Az1Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1ZS+rJro84YShW2YcqO6Xar6bhQxva2OFP+Lb9rGVU=;
 b=f3FPzYK6Oh0ROkRwqfF+7Ozkp/3UIufspX6NWwz+dqVBaFylbkvr2Ub1LsmaWNLWlr4xx3jp7t1EiF4quook9IABP4m/5m0fvq/8/4+oT88pZf9eoR8juYIXYBPpkC+IzM5zCFXXqRrcQFe8cL9vcJIzSTmFGgKDu/NwgM4u/jCNSVl++HCUiJbsvfdoH1PNQ1Y2a2hWGfEsyDu+xbjvVDRbr4zpgABe+9vAWp4iMfP0fYayeU3aKSLH7xuBNZqx+Gc0BAe3dxBGIc8YkSaYZIwJPxZ+ZUOE051Pgbj6YIR4/75fIYbK0UjlVcRNR9ycABu3za0TTEUb4wboWAjIQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1ZS+rJro84YShW2YcqO6Xar6bhQxva2OFP+Lb9rGVU=;
 b=rGanpsOyzl4JCMSFq3zQnxr4Zjo0t4es0dNdwd7QpAIWH+ShjZgoB6hsc98LHr1CzQOVOTbjHYtjKa40cOZBNocySTNkv5XFj3mAH42NdgxiKrjMMnrUKRC56NSVdpcQ0uN7mcoFUhu2KaqjNvGTrjkOkKcXqjo6XEh/Yn1c/sw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR04MB5624.eurprd04.prod.outlook.com (2603:10a6:20b:a1::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 08:57:15 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3582:eb2f:9652:d98b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3582:eb2f:9652:d98b%5]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 08:57:15 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3] media: amphion: only insert the first sequence startcode for vc1l format
Date:   Fri,  8 Jul 2022 16:56:50 +0800
Message-Id: <20220708085650.4409-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0170.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::26) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bc0c31f-9e68-4c20-d6b3-08da60bfda85
X-MS-TrafficTypeDiagnostic: AM6PR04MB5624:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aGuRmkasYA6RMYuglrGkpCAzSx7lQ5HWnYpM8Q9OUlBxj7mkfkzwWnLTmY6C4TkoR9c3wTo/ARIbC9YClUm23N7mV46w9RsMGf7VMXFJNRGDF6Y7sxFx6HDAq0WzvboDzTYZs8Ykoed8MAU51UCBp15SI/BUzHCrTRbR7xZREaOHQ0uEZzcc2zRzluHUy34MGa7cXwlcHVucac/abcRpZYkc4ULpid4wLm2RVcN1Vr9P/rK5JourWKHuzeBBHQw8uLb9If/lD62Y8HeSirP2elbVNIDEjlrARNSjhyrPt2wwSDb1ATP8a1XrQFKx7Y5P/drwDT5e9bMhgyhqisiWz9H62WcXUbI2CWBLidQFUuvFsITcbMcX4Ni/1Ut5VLnK7wHfAohrDX1TSMv4DlsCLaJ32VB677y6gGAV4JwVCvUl5kSQWuZAIMJerEGm60+RCj7Ib2TYtikPB79vPHsNscA+vDWOTFU1jtJfsZY5HJwSsQ6CN+t7PKQZIMGQdGNKdUnHCJyWchYSh5VgqSGo7m1566ZIR0xEU4tKDLFU21FN6tYHoNI2VzFmfX592Ms44ZLjtAz/OmM3gl3M+fhPnE8SA/W1dFs4okQ6l/grII7bLsTeGCvWC6esLFkRcBd99HdO7c84xF08Pqqlr4v5PzZOmxoRslFEOzpJSJMnHyh8EwiadqK+dwvBLV7qOoz1zlqna1DEnRIzyTgge3uZJZOz2J4pS1i+X0DAMM+QTxUn7mEhvK76mnENSy5hdkuqebRerN9to65YtmCrYHLo67XCcnf0YNjD4NpjpDYqRRf5twU5xOnoj8tHxxpRSiuBdnfDvelN9djL1NSP35WpxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(8936002)(41300700001)(36756003)(86362001)(38100700002)(6486002)(44832011)(38350700002)(5660300002)(2906002)(7416002)(6666004)(478600001)(316002)(66476007)(66556008)(8676002)(4326008)(186003)(66946007)(83380400001)(6506007)(52116002)(6512007)(2616005)(1076003)(26005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tOhA4cVMpf22B25q08ioGjqiP2fQvr8+tocxTdDmWa7eietjt+1p0A78ynOp?=
 =?us-ascii?Q?2TMEXqmXYK7PuWEJQqNWYwJH8qCMgtSphEt46QmCqQ1mpAw2+5TdgNGsGDqs?=
 =?us-ascii?Q?2hccesDfjLVIKGu9Q3iKa51vSix7y+8WjcdwnOVPjQqWKz1kb5/52pqz/e8l?=
 =?us-ascii?Q?f1rk2IuNozJJ0D1ujtv51xr6+CksPMAHgY6UJkS81sL9K/CxfJrkQkqVIMK7?=
 =?us-ascii?Q?77F23Xsz1bL2YKriSVZDRupjGGQbrUHqDzPlDPpOtf8ERzxsdJ8FBlnbxGYc?=
 =?us-ascii?Q?43ZIHiLu0Xqw8MaBM/6dESBuLJC/nC4UiXStKIfk5qsPglfyxsunc1iTRxpc?=
 =?us-ascii?Q?g5Gj/8C9CJcDruhMLGAEXzO4dvAZvXEG892IJBDnKVjkvGGt81pZva9/2iQu?=
 =?us-ascii?Q?zfi7ZLzB6v+dSMWyj8J6gvdCO1MdimJ7m1ukM1B8xNqpF8T0jhyJ9ufx+oIt?=
 =?us-ascii?Q?Tnvccas6lN6HouLUZj5K1Xlnt+xg7NxFLrBxVW0yz4DjqBCVnESPplGTjC95?=
 =?us-ascii?Q?rLkKheTvbG5GZcz1536oHs0PhjHae1h0iA+Y+bIEfNBbZhzL47fG2yKO4Gto?=
 =?us-ascii?Q?SSb/kfR40DOIFWPctf9nUIwy3FVp/AhKP6F4rgWQGEamvXrU63pIDTns1NXq?=
 =?us-ascii?Q?SIu8iNm1HzBmIDI+1/nkPt+PBKnXsOjS3ewYftI1o58mrDn9s0XpBZxZSYGA?=
 =?us-ascii?Q?04ojPegJ1zQXWhf8flfmugGKzjBlvWrI3Mt9Tzz+JNLcAc2/AVOwnNO5iwPJ?=
 =?us-ascii?Q?GJXKraJgTBeNYQju/C33QPkxMyaGJcN06i1PINQFE4QLEZMMEX5cs28csMJ1?=
 =?us-ascii?Q?Uw548LKiTf0diG/X0LV7Bm70GngP3JLWUecLJECu2SWUqN8+fEPr6EQHnwkE?=
 =?us-ascii?Q?TaisOe7pMEeSoG7ndSJse4Mq224LSTH61MrT4AEFZVoELifG2FEsSYNkJmwn?=
 =?us-ascii?Q?9FOtBZyZ0isGYHg4xkYE5TW4IMR/fSgaqNXCjT+icgg53gwjLAO496IuarMx?=
 =?us-ascii?Q?YLMZXyeKuhoV66nQ1uGGG+m1c1IS/nvo1Zr+VpVWEAVl4mf64JfnI2BTxlGT?=
 =?us-ascii?Q?CfxxuTc3M88MOUY+PcalauR23XnOeBfuu/d2uY8O4ELyhpu6w43IVUXIyugo?=
 =?us-ascii?Q?e3N3lck919dY1pchkeqvaM/6tSXESAtQGJD/tfswZQkrx+4ZMr48uoMPa+76?=
 =?us-ascii?Q?naUHASmBSdHQHfGFqyaVJuX+Q2hyrm2pMJWyzUw2LFVHAatyfPKWuNpbxnnu?=
 =?us-ascii?Q?nB9wLZrzEHaar7DmPuWNNwUw+6+zfBKYDqdJfSNwFIUYI8urhXZaM50c6366?=
 =?us-ascii?Q?U6WEJvhwXK+dYEnR4tjqzVJvKYQFdAmSnd55074FqVKVBkCQpx0lPj5SXW1B?=
 =?us-ascii?Q?ui4L6KLhki5FqqfHjtbDKp9wWiZlxX0xUI1Ht41dPBzzdN4XJ0U5JkZWUbKY?=
 =?us-ascii?Q?+RXYP98InjoL+GcjUZhzdg8o4+zChWO8oYdxatcsxHl7HB6GTzLzm8g9qyM7?=
 =?us-ascii?Q?D6NjaQp8h4EBYraeq8tKXA0F9TZynb/8j7VGf/fjP8dq8mo3QmV9SHB+t+pP?=
 =?us-ascii?Q?H45sB4q8iJR7WmVzqXj1QOzFE4/P8Zkw+pWZU9mY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc0c31f-9e68-4c20-d6b3-08da60bfda85
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 08:57:14.9289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A9yU3nPe67hyPFzGxUT9wZAKfhoIFJpD7Cl3FALPj3VSkEsGzceCyg/GX5mHbm8lrlECr0n4NQ+FrARtvikUnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5624
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For format V4L2_PIX_FMT_VC1_ANNEX_L,
the amphion vpu requires driver to help insert some custom startcode
before sequence and frame.
but only the first sequence startcode is needed,
the extra startcode will cause decoding error.
So after seek, we don't need to insert the sequence startcode.

In other words, for V4L2_PIX_FMT_VC1_ANNEX_L,
the vpu doesn't support dynamic resolution change.

Fixes: 145e936380edb ("media: amphion: implement malone decoder rpc interface")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
v3
- remove some inappropriate commit message
v2
- remove V4L2_FMT_FLAG_DYN_RESOLUTION from the format V4L2_PIX_FMT_VC1_ANNEX_L

 drivers/media/platform/amphion/vdec.c       | 2 +-
 drivers/media/platform/amphion/vpu.h        | 1 +
 drivers/media/platform/amphion/vpu_malone.c | 2 ++
 drivers/media/platform/amphion/vpu_rpc.h    | 7 ++++++-
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index 09d4f27970ec..6eab9e711cba 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -104,7 +104,6 @@ static const struct vpu_format vdec_formats[] = {
 		.pixfmt = V4L2_PIX_FMT_VC1_ANNEX_L,
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
-		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_MPEG2,
@@ -731,6 +730,7 @@ static void vdec_stop_done(struct vpu_inst *inst)
 	vdec->eos_received = 0;
 	vdec->is_source_changed = false;
 	vdec->source_change = 0;
+	inst->total_input_count = 0;
 	vpu_inst_unlock(inst);
 }
 
diff --git a/drivers/media/platform/amphion/vpu.h b/drivers/media/platform/amphion/vpu.h
index e56b96a7e5d3..f914de6ed81e 100644
--- a/drivers/media/platform/amphion/vpu.h
+++ b/drivers/media/platform/amphion/vpu.h
@@ -258,6 +258,7 @@ struct vpu_inst {
 	struct vpu_format cap_format;
 	u32 min_buffer_cap;
 	u32 min_buffer_out;
+	u32 total_input_count;
 
 	struct v4l2_rect crop;
 	u32 colorspace;
diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/platform/amphion/vpu_malone.c
index c62b49e85060..f4a488bf9880 100644
--- a/drivers/media/platform/amphion/vpu_malone.c
+++ b/drivers/media/platform/amphion/vpu_malone.c
@@ -1314,6 +1314,8 @@ static int vpu_malone_insert_scode_vc1_l_seq(struct malone_scode_t *scode)
 	int size = 0;
 	u8 rcv_seqhdr[MALONE_VC1_RCV_SEQ_HEADER_LEN];
 
+	if (scode->inst->total_input_count)
+		return 0;
 	scode->need_data = 0;
 
 	ret = vpu_malone_insert_scode_seq(scode, MALONE_CODEC_ID_VC1_SIMPLE, sizeof(rcv_seqhdr));
diff --git a/drivers/media/platform/amphion/vpu_rpc.h b/drivers/media/platform/amphion/vpu_rpc.h
index 25119e5e807e..7eb6f01e6ab5 100644
--- a/drivers/media/platform/amphion/vpu_rpc.h
+++ b/drivers/media/platform/amphion/vpu_rpc.h
@@ -312,11 +312,16 @@ static inline int vpu_iface_input_frame(struct vpu_inst *inst,
 					struct vb2_buffer *vb)
 {
 	struct vpu_iface_ops *ops = vpu_core_get_iface(inst->core);
+	int ret;
 
 	if (!ops || !ops->input_frame)
 		return -EINVAL;
 
-	return ops->input_frame(inst->core->iface, inst, vb);
+	ret = ops->input_frame(inst->core->iface, inst, vb);
+	if (ret < 0)
+		return ret;
+	inst->total_input_count++;
+	return ret;
 }
 
 static inline int vpu_iface_config_memory_resource(struct vpu_inst *inst,
-- 
2.36.1

