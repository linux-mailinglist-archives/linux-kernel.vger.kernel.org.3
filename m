Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5806F560EB8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 03:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbiF3BbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 21:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiF3BbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 21:31:02 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80049.outbound.protection.outlook.com [40.107.8.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B41326E4;
        Wed, 29 Jun 2022 18:31:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2pRZmK3jXkP1lGCwVEU9AWYayeCzir9gdAbho6pFPrRYQawlAwczezNZVd0jtAOUhEaZzt5NxRCXu84+C93c9KSuApqQSN07xJVQ1QmLvN1Q4CYRQgAdJVPTq3Ls7kbgzGKqmZdJuHN2ApjanjSlV+S6Nt4P+sIFodohDtMiFw2i7eTLbxvzaqHvAk23F2+TZrBIKQK5sFozjwVd8uzkgXby3kwjwKCJnaORT1gf5VFjxsY2eG1nCswYMUivqFB7Jy08IYRgW231K3cX8CSPwJ4mgGXlBS+4XpHlXLcRxioii6ATHtU9+f2oP+SSut0d04V+jgs2EKSaUqSgfwJSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWLtmlj3LoX+mgqgDkMakzc3Ffja1l5JEczozyDnU4Y=;
 b=OEWvft0vuW52UZOtHgbRRNHF11Crhf99v/fY+xkBueLAbwWvt5Ib1ixcgLMoGhOsW5QuiUtHEiqqIPIent+Q9zZO4xVXcnOZQhG2whnwtbPCXpzKYQYKGodbz62mC3Ps496qVVsJN1DUkqfYkJjTzrxnPTKjHVNnlIuEY6X6T+tDnApmoNm33JTKClfrVTinYGQ4zCEokxi64clAUUqk9lUs/ApLn8WL9zUVlIl3p5+DOJwKft37mKMXc1FTw40LzCv7IzLLkloBJ887xsDaH0KwaprIYmmf0mdv6UT9y0Llf0ENhbGsft6yIs7GK2XKxYJTYXKhbezUxHOs2ZfDVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWLtmlj3LoX+mgqgDkMakzc3Ffja1l5JEczozyDnU4Y=;
 b=iKXeZTKLpsmtt/OIP9hqNjVx9DI7truhyIGJ56I4KNeUrtomp1k/JHS8oBbuYJTsfF8C2mpG+2KPuyzfuuq93AYrUjo1Dc3VhHAuFdWY6VLBO5P6I0nWf4pygJ6ocxHDMoOjxrI+3xQtV9XDf1zAFbcl8tbBUEvvt7AM1+QIBOg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM5PR04MB3124.eurprd04.prod.outlook.com (2603:10a6:206:c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 01:30:58 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3582:eb2f:9652:d98b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3582:eb2f:9652:d98b%5]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 01:30:58 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] media: amphion: only insert the first sequence startcode for vc1l format
Date:   Thu, 30 Jun 2022 09:30:41 +0800
Message-Id: <20220630013041.1251-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95442a84-b02c-416c-ee6b-08da5a382f0b
X-MS-TrafficTypeDiagnostic: AM5PR04MB3124:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: neSOWxHKgXjPtCKyY+YniMGcNuNT1FjtHLr42er/cDbwPo5dM8+zwYsDlTdNIuVeKvHPCX6JvRFa/ZG8T9aQqJvHkRN4Lrp/5vL34rr2EFPP4ITdo0DBK2oWr0yizMBJ/r5ae1w+mYWks9crzAEzmemVYfYMXmfseLakf842TqcFOFG8dDR1Kw1mGkq06PEeskZwhYv3zH16RoxIrJzcyTgpk0RX3XNkunUb+/Mp/dl4NG3/GgqjG1ag0Dj/XC2OlkPGBKNqZWa/rVjQQ/P8vCS0nclNktaK2oFjrpd3UqCP9LH5QhdNbAlQnCENa0ZX5crWqc3eQj/kyq7EgFxeOQeaM3w2eq+egHDuMiDB/rSQx0jbc+0BDBY+qLKA1Cx6emVfeBIAsOrqVHx2HkPhtTq6WZrfKfmI/2JqFAoNXRPXriX+qxbKaGjmqayJ/a6pZoNn436vvtbIYZfkx3TlpaPE6f9g5BFhRqFqqZwCTlqly6Sa1VOUkG2wlU/2Q1A8LSrMoWReSwsKJFYN8rnZQkYzUH/01XBHOL0zQyRaXsObgal9QjIywLQvShEyE5dEUzeVUXgsGKRk5f6h1zAkXg+ynkXOU2UMwiMElrQ8Ct7h0lvRHJZIaVlZM7oj93nn2kz6cLTykpGYQnq+QK5Axh6Oifzzd1ZE1g9BF3u+fm3iHYPn8JakGctbpH1P5F8KH1PktfOuRk99pUOuVXR2vzigSFTKQWkfVh2kLaw2M7+AWluq8MRLt+oANuSLHgOkYPjebTjbC6JC+z/wDC43ObHNxVDcv+42Mo0v5JeDfP/ObUYfe6r4eMBrMLK7q1My
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(38100700002)(38350700002)(8676002)(86362001)(66946007)(66556008)(66476007)(4326008)(83380400001)(7416002)(36756003)(316002)(186003)(26005)(6486002)(41300700001)(2616005)(52116002)(6506007)(8936002)(6512007)(5660300002)(44832011)(6666004)(478600001)(2906002)(1076003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D4A5NeBrKaGo1XNEsXw2meAV2z3iNA1P5zjweJQFxNFfs/+OaYqM6Xgt6B0K?=
 =?us-ascii?Q?g0L4J5cLGs1NYrBS2RuP7Y/btRx5lWg/r+/9J5OmCRFKslfWHHk4q3cHtuCY?=
 =?us-ascii?Q?o2JjT3WBP2ypYI/VswUO/c/prCVIVOIPpz6mPCs+VsfgTm8nA+Oo49nLUBBM?=
 =?us-ascii?Q?qvJYdFy1Riu1VVuA1EFSU0YoVIzkrMi73p9yu712g3eAH7lH7Gmsc03ZgcM4?=
 =?us-ascii?Q?o3v9JpcLLT1hOrBtzsvlf08Y+QcALlNA9bMh2XHJHi6Wta9oYsHNmMwj9TWt?=
 =?us-ascii?Q?b6ThT3lGny4HvWdnuyNyHzk31IQld1aNKe4QOCoSIG08C8IzLHwdAFhiD9lr?=
 =?us-ascii?Q?iW9n9xcplJFZtBSykuzTlnDuselsEjysv7qvvgtE8hJTUv7v8XQj8VDHcL85?=
 =?us-ascii?Q?McIB7hGwbDymzWULGY8S3gHvmhJAZzlJrmkBuZUlLeHjNLYOskFxyqsa8dSJ?=
 =?us-ascii?Q?LNVNQop/tufw6HYD7qz6UHSPYmOqYXbostaa6w4UaTB6hJmFR9rIrIupnFx6?=
 =?us-ascii?Q?SJRcm+J0qpOpNRWjF9ypC5rHdtUGYcPP4yHlq+KgywmH34nLEulrrBp2/KBy?=
 =?us-ascii?Q?Vx5Ik53XBzQoX/dRX7S3rFaqL1vi0kL08wUdlVezCNG8zjnAagviXxqzwVLn?=
 =?us-ascii?Q?AJOkgUwKyc8ncQUSjfxUtimRjfhs3iv0ZBhTt7tjuek0zQ3CTrC5H3p+qkV2?=
 =?us-ascii?Q?w+2W2Omn3F7y6M5gNToB7GgSuh6ty7hd+g687UZJoB2VmxXpcer3sGBp+VrM?=
 =?us-ascii?Q?0mgrU2GXEN6+V13hkPueuuIc1PvHo06tXT8fvBduLSbM7gOcaWloRuUb812W?=
 =?us-ascii?Q?3+60NUMp3Esca5/KHeseXe4I1+ED04ewQkN7ohRkEzdjuIdPUdXhuFg2lkah?=
 =?us-ascii?Q?5EMkH4ePSm/QjLR/YHvN9N4sM7vJvRt81uJxb16L/3M8uW7D7qgJN1TR+Hx7?=
 =?us-ascii?Q?sk84/r1dRJJBz6yROYUjDZ2T3VanJnRUCAP18O+nJtokBNgWBqheHyJ/yag4?=
 =?us-ascii?Q?aba1ydYsyBr7F5tz9gziBbPUmQfCpLCUC0S0VxEvt16g59Z/2Xk+Qs+TJQHc?=
 =?us-ascii?Q?VHpXvIkwivueY6sjFTwkdU1A0VuxDxukG+FP8ccEBQa8Sf5C2HVdSj4XpDsN?=
 =?us-ascii?Q?T1HS/d52JF/MsM4ihI2mEFbs8NGNPhwkqL2zqCouD1eYv0IWV0n80y/DUpVU?=
 =?us-ascii?Q?FL7Q0qa5XeibbOSQd58ZxWsTWm+d807xOQVI5OP2SBQvMIJlOs3pcO+UusaZ?=
 =?us-ascii?Q?qU4SaD+/2JtnnwY5A/oU2KygjNW3eMRG06yE/QmWYIFGJ5A2FCG4Mhx3uqsP?=
 =?us-ascii?Q?OrKwL9s7n/XlNIk3eFVjYjDUyeXCAp0vg+NEusEOotMeKtVF6MZpkzKfxpQf?=
 =?us-ascii?Q?eiUzQ8FpIQkNaIFbxJux9p6WqUxheYZmI+q8qaRbMzVHviBlp6tK9E1Uwy+4?=
 =?us-ascii?Q?UOJeObC61xFjvXvGcf2EIi7UDtdZYTyVh4ulX/A+3HHTgh8o6TDT6leLzpl5?=
 =?us-ascii?Q?5y61ZwrMvx+Vv+8+tt9MimbU6uTktw2ULBwZOGDUoNQhF9H3rzX0ZL5YdYhx?=
 =?us-ascii?Q?wA/3Byj8E5lV1q3GqvrIckZ1GUyMoCPH2BVddOLw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95442a84-b02c-416c-ee6b-08da5a382f0b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 01:30:58.2044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2UtQhCHSM+xMNyz/STLuhoil/ZGqlBfjS9kSaRAV48PKmKbZn1i3u/2QKWjpNTf/zRPUCusFu/9Hr9DS7bZRQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3124
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some formats, the amphion vpu requires startcode
before sequence and frame, such as vc1, vp8.

But for V4L2_PIX_FMT_VC1_ANNEX_L, only the first sequence startcode
is needed, the extra startcode will cause decoding error.
So after seek, we don't need to insert the sequence startcode.

In other words, for V4L2_PIX_FMT_VC1_ANNEX_L,
the vpu doesn't support dynamic resolution change.

Fixes: 145e936380edb ("media: amphion: implement malone decoder rpc interface")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
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

