Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5132A55DC72
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245034AbiF1FWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 01:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244940AbiF1FVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 01:21:51 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41E8286DE;
        Mon, 27 Jun 2022 22:20:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiJoVDotGFoCioYGDlwZRUwlme/zPnN7mZHzeFP0otJHVMPz3VKeBYkNJk89rsirrTMxn2Q0GIRapC9/Xtw8UWFt9nRgScWy1/tDvyc1VY+TjXCesr0Sm71tYjwilgMynmG6UyJ84eWwc52E47mt34Wgq4UNeiOjlLkZ50pcEYbgOxPtltlMwftbVf6jqF3xoHmSHlcw/bGGdkwo0dkunh6ZxG2uvaELkRYdzVox9AFQwPe4GmcTAoredxre9tfouNPxrc9nyM8jvR3ATx++btrfxGD/k+7N1oBrjt8pa/fsD1ZNzI4ZdYeFwelk4DSK7Uq7DPDfCNNpZZFA1MR80g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkrXp0BXX7Sz8l3pnrZ5hzps0DG05kz93DlCzJAbEZY=;
 b=CuBNI5H5lZehXXa49e6pp3rtJ6cWaUXU3vIZQ5ygmhGvQnzFFmBiNeXpUNpJbpFkgdcOa3NygZq6a9f3AeKDfR/fAkeNjPCuevK4ww5s7U8tL/vTEbGlfvx6j7nHO7lxDCist/Oo0RyeRF3zMXzPTWYEK4SWI/Q1GgIwJsEbYLXJSklVAqFRAJDhSaW0pXgVwjRksQmzQkZY/cpUydTRno7HSsIOMWbRWoENfOXJqr0pSuPjRxgnS8vR7hLlyDQo2d4HgHI/UClkBMALDbQrkteSQEJutIonctx7KT9qz6YaqAYorMvdRpaYBq1pxySNQzkTPZYbcnIic387SJJIew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkrXp0BXX7Sz8l3pnrZ5hzps0DG05kz93DlCzJAbEZY=;
 b=s2JibFY5KqJczLwFDZ7R+i+wOCp/58Vl8AhJMS6qoS9xPCCn6p4K/DauK+JnJmlBXac9cJsqtl5VSLMFaUEW0JuLIgVTAJb6bJr0o5sfLfuvbIb0OabOkd2kwAYfIMowxofYGIM+4K/B5/XNgTFPSOmE6AcFPzOXUWO6EjdbABs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB5168.eurprd04.prod.outlook.com (2603:10a6:803:56::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 05:20:32 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3582:eb2f:9652:d98b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3582:eb2f:9652:d98b%5]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 05:20:32 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: only insert the first sequence startcode for vc1l format
Date:   Tue, 28 Jun 2022 13:20:17 +0800
Message-Id: <20220628052017.26979-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096::12) To
 AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c9d03f9-0a15-4a1d-5a65-08da58c5ec3d
X-MS-TrafficTypeDiagnostic: VI1PR04MB5168:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ibmy+ezupwWyfU05HsK5CXPHzLADmBxDygShgYpZDxg1B95JTv9DXdsiI4YQ3jgptItnpRvEALInePekWAy8Y8o8aQLyHRafA9/HFQHaRlGLIJzqb8bMz41ApmvFlL5fV3eYmpHGiSbU4CENyvYrWUfRfv16GZl7uqfS6gTjp6Le3ToIkZV1s7AZrQe3TpH+Zcnj6Zz0yWLnsbyWG95lTilfjVRDY41xjzd+OiG3sRBuBDTZ27IUsBadqJ46ccWm+5WXhsgU/dQHSunwk8uvvI3a6vPAoHGnfOLHrSKFmqYFLstq47Kdcn97x3U98VQnFJc5dPLgZYNgCaekm5fglO3wmJjTBGub8LL5cw96eFxBWuH32mJfTzX0Bm8sYMYU7tYYm4eljxAQkVt6qygkoxQsStuKDzY1okCDTn6QvJXGf4THFs071pzxZlNPlb7fz7SpLywE0suZm6hEgZUxPxvx52XmaAV9C/TKCPv+ELDhy/MGyoxMShQkNCz0xdaixhThY/B1G0FFTTEyoCxuNbCyTBFJ6aY7YaeZbuDbqauBMGQ3QaWIeK6kOQCzaddFQmcsJcCEmmiCkPEBBavPF2Jf0Q4rrdbCq7UAjgJptYTGRE8wLK/m7SSvppdYhUJUDmkCeNEn3cx1eLOYvAiBBEkrjIBl89vWls3ZibkuvKhJiWCHW9DE2I0fxVMF+wTcj5oREnbJphOjytF/IWuAkA3PesOebAZsR76hvBTlEyZcFVPKhKpy4uhHRw9i4iMH5F9Syy1oNxx41Gf25rLdzzHwQew0GZfofy0s1C1sJw2xoUw+yqZXXHmfsHmnwzBE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(6512007)(36756003)(26005)(83380400001)(8676002)(66476007)(66556008)(4326008)(66946007)(1076003)(2616005)(38100700002)(52116002)(316002)(86362001)(6506007)(478600001)(7416002)(38350700002)(5660300002)(6666004)(186003)(6486002)(44832011)(8936002)(41300700001)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iv5cokIbYSbgC3WPM5F7ch4LEvG5UU7aqRk4THazpjP6FDiw2LpBN1yC6/Dt?=
 =?us-ascii?Q?8Im6NrMoGrKWHmCRGZgfk1gW3+9mQ28cXJXV6flM+c0DOvjwd1IssdfQUgMT?=
 =?us-ascii?Q?umfI66RbUYqcD5EI3PChMljW0CmjyaGZP9ho7em4Ru2DjUXpYF37UdmoO35H?=
 =?us-ascii?Q?0vx+ptfqAreb9gNwO9Jby53z4ZasKoESlkWX7mPBeLR00vP+kNQps15PsK8J?=
 =?us-ascii?Q?Ma7XSSmlq0xvl2JtLEgDuX5GQt/3CpRkGvjYvQ5J5y4BgdYM0L1dMZ/X+lat?=
 =?us-ascii?Q?ZhgAYDWTItFT3KycCY9zztIrwu1QVCbKB8/sUJCXb2A7mG1cVPn+EIBlIoYJ?=
 =?us-ascii?Q?8q1c7MWtprNXMhXiCVysDUEf/cYmx8zeauTNLo4Hll45sw32tVkLYVg6qIKF?=
 =?us-ascii?Q?KqDUWN4VpaywM0WQDbv2+WKFO5kizaue7mlwc5Op1o6sXNvenoFqR5vAJoWX?=
 =?us-ascii?Q?LePWuv16OTAL7etysopywx+mpcNOR3KN41zVbStlmxb2qRG5gx1DGl/xjgzs?=
 =?us-ascii?Q?Hdb2ERBTNNfD199ypNXE+xnqVhLE9Y66yRfXSI/IdI5JkxOJcSVw1O2xfwgP?=
 =?us-ascii?Q?maQkDZDbLSRByz+S38ZizSvjxKS0OrqtyQytXSMiFCeMf4O0LvDcQIIbBd8g?=
 =?us-ascii?Q?v3nvotssefB5Pe8TrdUY3NphVIpTceOqKGjb4DPjjjEZmUlGQ3FgAqDWRXah?=
 =?us-ascii?Q?Pk8tKXrUeGTtIZDEeqY+8b4q8Lj3/7OwjPCQvBCB5v88Ep2Cq9D6mvURt21j?=
 =?us-ascii?Q?7J61cp+0hO6uA5CyVMs+i+iEuh4U/65SpTWI4noF1OcJkuEqKESCU6va2A8M?=
 =?us-ascii?Q?5tSAoqb1sutAF9EYCSwtEG4vfJj3bxqIvAx+h0a3S4zR+NOZIamjX+XpCdy2?=
 =?us-ascii?Q?mdMQUS5nIx6MqRpVsNNWV4bBsC3cbkFSyDxjxjOzapmqL1R9MbFimKEGlnce?=
 =?us-ascii?Q?d2DXXBjhteiSIUXpebY2KuNGW01yKBxgQPhz3qE2k5VZPiC1v+0NM66/bMDV?=
 =?us-ascii?Q?2RBRJm8kx1/pwJEPkH/n/wfCvnFVA4fHKljyuheEpNw8krgE4Dv2TOKYUft9?=
 =?us-ascii?Q?lhTOdlLXn+1TVSlP8EUoawHdw1j2IG3xN9Tha0kaOlzuzcKcggTq0gezBi6j?=
 =?us-ascii?Q?q21GaWhnYBeNoZD39ghBaZed6EmH919oxRCZYuZ9xJnrdFGrHGNCP29xP0I5?=
 =?us-ascii?Q?DDQOf23C/fOj4/bX1/LHtbr/GtTf5mbQL3ZhVWtsT3+eIxjR3gal1Rw4gnQk?=
 =?us-ascii?Q?TI1TXlULvLgtcBSgEkND8Zq6d0T52f5ZcVRcg365xR/vIZnq4JXU3/HiO5Qs?=
 =?us-ascii?Q?3P7r7e7THTA1ulisZg0nbeTqB2xO6XvaJFqjL3NzLpG9TJMGmzx4ymDNsSIV?=
 =?us-ascii?Q?Bmn4viEzJKExkTI3hoaSqeK3VahH2imKdUvygP+DAzZjQ+KovTmznKAsS8+V?=
 =?us-ascii?Q?gRIrnqepSJFM2TUGIqTVZhuLLUrSVU90hOwUzdVWvVHjJeKoUjvqNHBJJTuN?=
 =?us-ascii?Q?U3gsJUIcOKBADqZZVFm7G5Uj+259r+p5W2VgDLZStVcVYqOO9TTHV/LQUVWb?=
 =?us-ascii?Q?zOKdrgvHkdgWOpNcT420Xou75ZvqYvRaIi45PGPv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9d03f9-0a15-4a1d-5a65-08da58c5ec3d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 05:20:32.3466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ciFteOz8P3YPZ4eHYgbDsc4xEGoUBzBw4fd/Wo1Oj3j/7Bs/XLWQ8QyEXmibH2veGYMcQgOI6pW0jFeyxhVjGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5168
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
 drivers/media/platform/amphion/vdec.c       | 1 +
 drivers/media/platform/amphion/vpu.h        | 1 +
 drivers/media/platform/amphion/vpu_malone.c | 2 ++
 drivers/media/platform/amphion/vpu_rpc.h    | 7 ++++++-
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index 09d4f27970ec..51218a41a5ac 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -731,6 +731,7 @@ static void vdec_stop_done(struct vpu_inst *inst)
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

