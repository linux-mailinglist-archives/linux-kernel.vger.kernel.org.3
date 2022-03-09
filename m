Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72ECA4D2810
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 06:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiCIFEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 00:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiCIFEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 00:04:07 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70087.outbound.protection.outlook.com [40.107.7.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EAA986E1;
        Tue,  8 Mar 2022 21:03:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYJQoaIA5I9s4/BfzjY9ietOf22yMxkXoGef+ce8kbqs3qj+0Porc9F1hB+lnSyKjNMaNZN8tjIUJD4f8JrMGc3fui9SNVDzOlfBpjyzzx3xJHq6D+b8zx0NEacvW3KcM3yzYa06DWae510pDBhET4vgshhYWPg/vLu4xSNeAOtwyv93sUSS9W5ZRC7q2+cWjUKIiLv5zVNpmxW6IWla1OrpdntrktOBV+wrNUC1mhK0qCgX4Ry3b1MNlAnfUgme+f9qvJ+vzz4erv7ko90Sa7xbeYXK2q6UoqFLoBI21F+4PRb1pG98bJaYgnhZm47tMDV7ytYQF4kFW8HLJsAEgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrAQf7QlHD6g7PknFXU/HcErO8J3vFpE0uDHu+1wAHA=;
 b=WVeNi0JMUxOxZiujh+lSkY3y+7B/NhHdjfnTyX9cGm87tX2N383m+AROE4LH56ia078q7ZfjAiITZ7JBUCLKXWLZaVWUkMJISWTDAAaHgma/l0+vzZLk1oHLzN0vMtT2AigXon8IrpEXRInCb8vb/a1kuA2WYTXk1e3IHeG4W4RGz2mWpJbm63zKeUdEoXmS4CT2yHacwsMJDLItFGxRE3fGRjwMV8UB/Iwnfg9IWldZ70lPBRCb6l6WMATJD6ou3YkUsso3EyLdl7gOv88Z870wMjYkcG0XoLOUlv+584KlN0U2xfX1Zid9EoZcVBzDonLW//fGPicpQa/KdCgXOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrAQf7QlHD6g7PknFXU/HcErO8J3vFpE0uDHu+1wAHA=;
 b=R1UJXnviVkN4dykAyRO2fsLp349GiKC3NcJvHNosDLTlIVNvsgd/5Fqk7e2yPK2nuRQZpyEhNFLgiW42eUf+Qxr+t1W6blmDpZpQPq0Xh9YFp2YPok5xb7lxPsCaFsfKQEgRPNTQZ1o8J1PgXTR8IBdqiOaG3fMaDp6pcMFYs7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB3PR0402MB3898.eurprd04.prod.outlook.com (2603:10a6:8:3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 05:03:04 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 05:03:04 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: fix some error related with undefined reference to __divdi3
Date:   Wed,  9 Mar 2022 13:02:21 +0800
Message-Id: <20220309050221.971-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::18)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe2b6046-5896-4a0d-10be-08da018a17a8
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3898:EE_
X-Microsoft-Antispam-PRVS: <DB3PR0402MB3898501534F11C10EE2C21F6E70A9@DB3PR0402MB3898.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IzfuKtLl4J27ht1D7PdXKZVdrW+MeesMqYOr0hl/GM6gQyrQI6667gjEcu3AKKNpUq0tNjQr+tiPvDjG/8z48rBaB0j22xjvO5iRPDg21HtwZWNzsW052Kb2d6t1HQnkwCI0INFSLoTdJsvWOlU2aTjb8Q+UnbhjX2mHeNfXN9PJ29/DyO23rMO4J/jWOwItTWTHd53ANMDbmUdW3cMaUTVPU/8oMlfC4BnS1ENVq97q7v6JTZX7472IaQtE2AftU92tt6T+Y4BSIBH3oXEaWwStpL6SPqr3NSma0wEauPrCF9qYpxS57jDSXdsiuOyM4OV8DMeiz5z5S6u4um3wUbx0A2cLuSYe5Da2AmQ6/jOUwklhMpOjOkZ/QFiupK/rXi5o9XqY6+47sKgZaWJoeaJh+AosjDu8KX392xIX6/yJZ+e7EiabBOyUQQTNc1qJ/Q20uGvlVFoLxt4pK+cZ4IbqH9oNQtLBmz5mM4eyn74A9qdJVnBTnce+oC+w3r2+8qIh87LdqSPJxovop4+zsuqzXpRxkxsJmfOolNIrKRVAk1HLvg4WCTJJ5zYoPS3dWtK141SoX5OAfo9VvUdflZryoX8Lp2g3Nz4X8Uo2VTw6BcVY7CykYuD8dIMtezNRZr97YVwLmzYPa6/aiZuXxBszKw1twkUGZrH8uk6o45mw5QaFYIL+cKcoMt6e9gTAit611TWzIXrXOpUL0v5Tyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(38350700002)(508600001)(6486002)(52116002)(44832011)(1076003)(38100700002)(26005)(8936002)(2616005)(6506007)(186003)(5660300002)(36756003)(86362001)(316002)(6512007)(7416002)(66556008)(66946007)(6666004)(83380400001)(66476007)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p1NcH31qfcvvi4GXmoY+K2MU65JwcgD9LcFeAPnQ650jW2jgpV9wradOaTDl?=
 =?us-ascii?Q?I5gJGCbgloZvW+AB5XV2LypH+auUyf54AhYFA5wF9fokDbNRn0QtU3usmGPw?=
 =?us-ascii?Q?gCq7hbXNT/znn1BD5cNfI2L98faXaV8jRMLIYt4gdW8+1u8kWXf2qdp/Ed1q?=
 =?us-ascii?Q?mkC3Ezxxuy/MQ5nHpA2kDZMdctGM32dQOEU7agHgUIMckn59kpzIckcJAJRq?=
 =?us-ascii?Q?HUY0Pgtemr5LaIpCokR8K3Yncu2kFkejv0v9DRzMZ7z5ydCeANKT4ZVFo8GT?=
 =?us-ascii?Q?vh3YbkXxM8aN1xVYA3ugPAwwxpgkK0XCmf1/4g8QDS2IvCUjD8jJyQqEQqrn?=
 =?us-ascii?Q?p+EbH30PE66nfQLOCq87NlPL+tllVYsU/ciXrWFWaYFKFdDLStNlxYWgJsEQ?=
 =?us-ascii?Q?KHvVQg0LP/fIFEO/Mvap6mya2JBz/wOS1bfufe9ENlX2LZNYW/kEnE29PDWa?=
 =?us-ascii?Q?M6Eh9Z4CYvgrwIuIXr2ygY0Fjbw4jbDQxvcMGqNOsFpvJX42iNMWJctagmTM?=
 =?us-ascii?Q?ldkSUR1oxH8amk3XqEkphwRTA+Q5GGZSsnQzaAc9/0eMwK6TeDfTnc73ZULY?=
 =?us-ascii?Q?N24uteu3aoq03NCIcYDUq6z5igd5lBfDoqavvHZVIYFq0N2KUav1RvX7W2CG?=
 =?us-ascii?Q?FXa04vc7QNlluDcizW6Ik4Qv3iEFNeCpLfdmt1D7vhy4Z2MT/CGejg58UOyc?=
 =?us-ascii?Q?S7NynRFUrcGGyvktBUkeOC7KsOv8Fv5GzBOfw5G5bOg3nVw/0ZQsiUhur6UC?=
 =?us-ascii?Q?y+QhLSzrUX++9WJkKoU8P5fdZlS/D91wuqzBgneZ3jGWduvs41g2CUXMDKf5?=
 =?us-ascii?Q?n9HUfhzpHilxq5c/BQSdr/9macs1Zv6Ov2KBhwAubuBVO47do1VL2Qdpe86g?=
 =?us-ascii?Q?Bi8+sU6HKjqamClifxrcJ+2FnN339nw+qQL6HmBFtdqe2p4qLcUsjrMD7QWt?=
 =?us-ascii?Q?OSFBV+7FSNcHJShMXoSTeVKAcYknyLXWJ1BNAQ6CqPg/BpnucMuQoX3VkSIL?=
 =?us-ascii?Q?iOEGaNbWHdy09KcBvOnnQS8S4sa6GL0c+VurO0wXcl7a3MIbNNf6VDcyphWy?=
 =?us-ascii?Q?Q6KZp25aVdaw5aTqa8UzqFdwYRpilFyshAfBh2lAGWIUr5FAbkvVFzFByMXo?=
 =?us-ascii?Q?oMpK5rQoIOqNCeUBjKgtulNFQ4vyoul26GGX3pBE2JYGKBHv0MzGiS55CNh/?=
 =?us-ascii?Q?KBaquMHWfha5M3WTVQpkNMr9SxAgWSn5mvGJN9yDXYjCjxhBWoie8LjJ6app?=
 =?us-ascii?Q?vr/vbh3XKToI4D8Nie6EzM1ybP64i898/JrkiDtMg/wS0HISRis2FoizzCns?=
 =?us-ascii?Q?Iw6axnouSQSr48+8t/zJwTx6BhGnCtHJDR0gwIwhJ3/rJaAkkaZ4r/ugflAa?=
 =?us-ascii?Q?7zW9wnTTTYjQcaSb9UQNU9Z2scyFcLRjhSDQKBQ6GUkVvdjMD/ntadCYkLS5?=
 =?us-ascii?Q?6H6n5K6tKhXynWt2gV8HP6Lf/2ozfHf69hTaPsfh/FsDcuVBN3Jc+4mAlLoG?=
 =?us-ascii?Q?52LhRs3ETThoe0Ec6uDJ527kJ6tSXHiUS07WT/7n0CmCiIm4ha6ldjEcdp9M?=
 =?us-ascii?Q?LIHpUaw1UMZDLd++6cuua4P4Knkhp5L9ft6oNBjrAx3RkzQ1TMgFD9FLQ1Lx?=
 =?us-ascii?Q?KNDL/OSCVomWz9TcOiZF5Q0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2b6046-5896-4a0d-10be-08da018a17a8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 05:03:04.4726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSayuLRCy8q4Aa29CloyeZLx9GO56PieVB92fu1vSMN+846foXXKCeb8mBLiltXz0Cm96myUl2h6BrUzkEp+yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3898
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. use ns_to_timespec64 instead of division method
2. use timespec64_to_ns instead of custom macro
3. use 'val >> 1' instead of ' val / 2'
4. remove unused custom macro
5. don't modify minus timestamp
6. remove some unused debug timestamp information

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/media/platform/amphion/vdec.c        | 35 --------------------
 drivers/media/platform/amphion/vpu_helpers.h |  3 --
 drivers/media/platform/amphion/vpu_malone.c  | 24 ++++++++------
 drivers/media/platform/amphion/vpu_v4l2.c    |  5 +--
 drivers/media/platform/amphion/vpu_windsor.c | 18 +++++-----
 5 files changed, 22 insertions(+), 63 deletions(-)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index 24ce5ea8ebf7..8f8dfd6ce2c6 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -65,9 +65,6 @@ struct vdec_t {
 	u32 drain;
 	u32 ts_pre_count;
 	u32 frame_depth;
-	s64 ts_start;
-	s64 ts_input;
-	s64 timestamp;
 };
 
 static const struct vpu_format vdec_formats[] = {
@@ -693,7 +690,6 @@ static void vdec_buf_done(struct vpu_inst *inst, struct vpu_frame_info *frame)
 
 	v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
 	vpu_inst_lock(inst);
-	vdec->timestamp = frame->timestamp;
 	vdec->display_frame_count++;
 	vpu_inst_unlock(inst);
 	dev_dbg(inst->dev, "[%d] decoded : %d, display : %d, sequence : %d\n",
@@ -713,9 +709,6 @@ static void vdec_stop_done(struct vpu_inst *inst)
 	vdec->params.end_flag = 0;
 	vdec->drain = 0;
 	vdec->ts_pre_count = 0;
-	vdec->timestamp = VPU_INVALID_TIMESTAMP;
-	vdec->ts_start = VPU_INVALID_TIMESTAMP;
-	vdec->ts_input = VPU_INVALID_TIMESTAMP;
 	vdec->params.frame_count = 0;
 	vdec->decoded_frame_count = 0;
 	vdec->display_frame_count = 0;
@@ -1228,7 +1221,6 @@ static int vdec_process_output(struct vpu_inst *inst, struct vb2_buffer *vb)
 	struct vdec_t *vdec = inst->priv;
 	struct vb2_v4l2_buffer *vbuf;
 	struct vpu_rpc_buffer_desc desc;
-	s64 timestamp;
 	u32 free_space;
 	int ret;
 
@@ -1252,12 +1244,6 @@ static int vdec_process_output(struct vpu_inst *inst, struct vb2_buffer *vb)
 	if (free_space < vb2_get_plane_payload(vb, 0) + 0x40000)
 		return -ENOMEM;
 
-	timestamp = vb->timestamp;
-	if (timestamp >= 0 && vdec->ts_start < 0)
-		vdec->ts_start = timestamp;
-	if (vdec->ts_input < timestamp)
-		vdec->ts_input = timestamp;
-
 	ret = vpu_iface_input_frame(inst, vb);
 	if (ret < 0)
 		return -ENOMEM;
@@ -1333,9 +1319,6 @@ static void vdec_abort(struct vpu_inst *inst)
 	vdec->params.end_flag = 0;
 	vdec->drain = 0;
 	vdec->ts_pre_count = 0;
-	vdec->timestamp = VPU_INVALID_TIMESTAMP;
-	vdec->ts_start = VPU_INVALID_TIMESTAMP;
-	vdec->ts_input = VPU_INVALID_TIMESTAMP;
 	vdec->params.frame_count = 0;
 	vdec->decoded_frame_count = 0;
 	vdec->display_frame_count = 0;
@@ -1550,21 +1533,6 @@ static int vdec_get_debug_info(struct vpu_inst *inst, char *str, u32 size, u32 i
 				vdec->codec_info.frame_rate.numerator,
 				vdec->codec_info.frame_rate.denominator);
 		break;
-	case 10:
-	{
-		s64 timestamp = vdec->timestamp;
-		s64 ts_start = vdec->ts_start;
-		s64 ts_input = vdec->ts_input;
-
-		num = scnprintf(str, size, "timestamp = %9lld.%09lld(%9lld.%09lld, %9lld.%09lld)\n",
-				timestamp / NSEC_PER_SEC,
-				timestamp % NSEC_PER_SEC,
-				ts_start / NSEC_PER_SEC,
-				ts_start % NSEC_PER_SEC,
-				ts_input / NSEC_PER_SEC,
-				ts_input % NSEC_PER_SEC);
-	}
-		break;
 	default:
 		break;
 	}
@@ -1599,9 +1567,6 @@ static void vdec_init(struct file *file)
 
 	vdec = inst->priv;
 	vdec->frame_depth = VDEC_FRAME_DEPTH;
-	vdec->timestamp = VPU_INVALID_TIMESTAMP;
-	vdec->ts_start = VPU_INVALID_TIMESTAMP;
-	vdec->ts_input = VPU_INVALID_TIMESTAMP;
 
 	memset(&f, 0, sizeof(f));
 	f.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
diff --git a/drivers/media/platform/amphion/vpu_helpers.h b/drivers/media/platform/amphion/vpu_helpers.h
index 3676cc83e85b..130d1357c032 100644
--- a/drivers/media/platform/amphion/vpu_helpers.h
+++ b/drivers/media/platform/amphion/vpu_helpers.h
@@ -11,9 +11,6 @@ struct vpu_pair {
 	u32 dst;
 };
 
-#define MAKE_TIMESTAMP(s, ns)		(((s32)(s) * NSEC_PER_SEC) + (ns))
-#define VPU_INVALID_TIMESTAMP		MAKE_TIMESTAMP(-1, 0)
-
 int vpu_helper_find_in_array_u8(const u8 *array, u32 size, u32 x);
 bool vpu_helper_check_type(struct vpu_inst *inst, u32 type);
 const struct vpu_format *vpu_helper_find_format(struct vpu_inst *inst, u32 type, u32 pixelfmt);
diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/platform/amphion/vpu_malone.c
index c2b424fb6453..d9cecbb42b2a 100644
--- a/drivers/media/platform/amphion/vpu_malone.c
+++ b/drivers/media/platform/amphion/vpu_malone.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/rational.h>
+#include <linux/time64.h>
 #include <media/videobuf2-v4l2.h>
 #include <media/videobuf2-dma-contig.h>
 #include <linux/videodev2.h>
@@ -725,9 +726,9 @@ static void vpu_malone_pack_fs_alloc(struct vpu_rpc_event *pkt,
 		 */
 		if (fs->luma_addr == fs->chroma_addr)
 			fs->chroma_addr = fs->luma_addr + fs->luma_size;
-		pkt->data[2] = fs->luma_addr + fs->luma_size / 2;
+		pkt->data[2] = fs->luma_addr + (fs->luma_size >> 1);
 		pkt->data[3] = fs->chroma_addr;
-		pkt->data[4] = fs->chroma_addr + fs->chromau_size / 2;
+		pkt->data[4] = fs->chroma_addr + (fs->chromau_size >> 1);
 		pkt->data[5] = fs->bytesperline;
 	} else {
 		pkt->data[2] = fs->luma_size;
@@ -748,14 +749,12 @@ static void vpu_malone_pack_fs_release(struct vpu_rpc_event *pkt,
 static void vpu_malone_pack_timestamp(struct vpu_rpc_event *pkt,
 				      struct vpu_ts_info *info)
 {
+	struct timespec64 ts = ns_to_timespec64(info->timestamp);
+
 	pkt->hdr.num = 3;
-	if (info->timestamp < 0) {
-		pkt->data[0] = (u32)-1;
-		pkt->data[1] = 0;
-	} else {
-		pkt->data[0] = info->timestamp / NSEC_PER_SEC;
-		pkt->data[1] = info->timestamp % NSEC_PER_SEC;
-	}
+
+	pkt->data[0] = ts.tv_sec;
+	pkt->data[1] = ts.tv_nsec;
 	pkt->data[2] = info->size;
 }
 
@@ -916,6 +915,8 @@ static void vpu_malone_unpack_rel_frame(struct vpu_rpc_event *pkt,
 static void vpu_malone_unpack_buff_rdy(struct vpu_rpc_event *pkt,
 				       struct vpu_dec_pic_info *info)
 {
+	struct timespec64 ts = { pkt->data[9], pkt->data[10] };
+
 	info->id = pkt->data[0];
 	info->luma = pkt->data[1];
 	info->stride = pkt->data[3];
@@ -923,7 +924,8 @@ static void vpu_malone_unpack_buff_rdy(struct vpu_rpc_event *pkt,
 		info->skipped = 1;
 	else
 		info->skipped = 0;
-	info->timestamp = MAKE_TIMESTAMP(pkt->data[9], pkt->data[10]);
+
+	info->timestamp = timespec64_to_ns(&ts);
 }
 
 int vpu_malone_unpack_msg_data(struct vpu_rpc_event *pkt, void *data)
@@ -1566,7 +1568,7 @@ static bool vpu_malone_check_ready(struct vpu_shared_addr *shared, u32 instance)
 	u32 wptr = desc->wptr;
 	u32 used = (wptr + size - rptr) % size;
 
-	if (!size || used < size / 2)
+	if (!size || used < (size >> 1))
 		return true;
 
 	return false;
diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index cc3674dafda0..6fe077a685e8 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -459,11 +459,8 @@ static void vpu_vb2_buf_queue(struct vb2_buffer *vb)
 	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
 	struct vpu_inst *inst = vb2_get_drv_priv(vb->vb2_queue);
 
-	if (V4L2_TYPE_IS_OUTPUT(vb->type)) {
+	if (V4L2_TYPE_IS_OUTPUT(vb->type))
 		vbuf->sequence = inst->sequence++;
-		if ((s64)vb->timestamp < 0)
-			vb->timestamp = VPU_INVALID_TIMESTAMP;
-	}
 
 	v4l2_m2m_buf_queue(inst->fh.m2m_ctx, vbuf);
 	vpu_process_output_buffer(inst);
diff --git a/drivers/media/platform/amphion/vpu_windsor.c b/drivers/media/platform/amphion/vpu_windsor.c
index e8852dd8535b..a056ad624e9b 100644
--- a/drivers/media/platform/amphion/vpu_windsor.c
+++ b/drivers/media/platform/amphion/vpu_windsor.c
@@ -12,6 +12,7 @@
 #include <linux/of_device.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/time64.h>
 #include <media/videobuf2-v4l2.h>
 #include <media/videobuf2-dma-contig.h>
 #include "vpu.h"
@@ -682,7 +683,6 @@ static struct vpu_pair windsor_msgs[] = {
 int vpu_windsor_pack_cmd(struct vpu_rpc_event *pkt, u32 index, u32 id, void *data)
 {
 	int ret;
-	s64 timestamp;
 
 	ret = vpu_find_dst_by_src(windsor_cmds, ARRAY_SIZE(windsor_cmds), id);
 	if (ret < 0)
@@ -691,15 +691,12 @@ int vpu_windsor_pack_cmd(struct vpu_rpc_event *pkt, u32 index, u32 id, void *dat
 	pkt->hdr.num = 0;
 	pkt->hdr.index = index;
 	if (id == VPU_CMD_ID_FRAME_ENCODE) {
+		s64 timestamp = *(s64 *)data;
+		struct timespec64 ts = ns_to_timespec64(timestamp);
+
 		pkt->hdr.num = 2;
-		timestamp = *(s64 *)data;
-		if (timestamp < 0) {
-			pkt->data[0] = (u32)-1;
-			pkt->data[1] = 0;
-		} else {
-			pkt->data[0] = timestamp / NSEC_PER_SEC;
-			pkt->data[1] = timestamp % NSEC_PER_SEC;
-		}
+		pkt->data[0] = ts.tv_sec;
+		pkt->data[1] = ts.tv_nsec;
 	}
 
 	return 0;
@@ -714,6 +711,7 @@ static void vpu_windsor_unpack_pic_info(struct vpu_rpc_event *pkt, void *data)
 {
 	struct vpu_enc_pic_info *info = data;
 	struct windsor_pic_info *windsor = (struct windsor_pic_info *)pkt->data;
+	struct timespec64 ts = { windsor->tv_s, windsor->tv_ns };
 
 	info->frame_id = windsor->frame_id;
 	switch (windsor->pic_type) {
@@ -736,7 +734,7 @@ static void vpu_windsor_unpack_pic_info(struct vpu_rpc_event *pkt, void *data)
 	info->frame_size = windsor->frame_size;
 	info->wptr = get_ptr(windsor->str_buff_wptr);
 	info->crc = windsor->frame_crc;
-	info->timestamp = MAKE_TIMESTAMP(windsor->tv_s, windsor->tv_ns);
+	info->timestamp = timespec64_to_ns(&ts);
 }
 
 static void vpu_windsor_unpack_mem_req(struct vpu_rpc_event *pkt, void *data)
-- 
2.33.0

