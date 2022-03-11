Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D824D5A5D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346376AbiCKFSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240271AbiCKFSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:18:06 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A71C484C;
        Thu, 10 Mar 2022 21:17:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtTVmrA8dT3pIv5AeJehlbC0zTC+62ql1+lDS9pgIR6kdCbwg+0Dx9kI60CBr5GWLijwu1HbnZCZKWMxxIjxPf7EunrnrirdHnzi0PqRq4Aug2QkPsGC73s99PKzN4n7OPw0IbwfMe42/uN/WyRJXkpgJXpaZnXU9wA+GMfwVQ66D414wDTEcbj9dD3y9cXfVexP0XDN0CBXgDTep+v/NHB9LJ9M8qGVQCN3yiv4scp3WhVGti8vAtSZP2uMYzyJL393ssx8UDkDqFLOXWcHqP02rdjeA0AyxfeespPsiP+Wxz3WtzsLPD96iLwjG7NoKiqo/yFjVIluOgUnbXL+yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tEX9gLLZ1gezUhRnNRyymaL+OTibfdQ8Sy3lBr4ZUA=;
 b=j2F79qPWaCAC8y1HqBiz9ZochNgpU8eejPZY+/XE6exyeLc1jxU4s/pMt/ZmTRdG1ww/aLmCgUKDNDaGGSa8kuhuMt9YfrDyNlyjZWoS203FUpMcoav1gL/E4eZKjq4InJDcJZ/cyVfUoE7+OxRXDSDJxy81qldnnr0bbygC7p0wwMjQ5H+F3la/d/4M2T0xptW0Grx7NbAky12rmZlRdaX2SLpOzb93chfZs2OCN2lK3qcJ7oPjE8igETERoeW+ZbFQt4jeG4SVhbrKSR2zbLYB6rwCvkfz6EPvaGvn0EsWsl+Df63EdbHN2vWzw3BVYTTiWKnUWB1NTMTo6Mm5lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tEX9gLLZ1gezUhRnNRyymaL+OTibfdQ8Sy3lBr4ZUA=;
 b=SR2UWNxa66nkXqX9+luBzCpn40FAL1aPG4TGB/5qavCekyZ4zfqmpe+d8X972S/FPRUVDhTeKSRo2gnHBurr2e8VmfSaeVxRsO+thwXB1BPEO+LxwpC0Agg6r5XnqriqxbMzi1XYG/rbGEqrXzFYB/NxG7sa/+Ms+xdr632tHmk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM5PR04MB3284.eurprd04.prod.outlook.com (2603:10a6:206:11::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 05:16:59 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 05:16:59 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org
Cc:     hverkuil-cisco@xs4all.nl, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] media: amphion: fix some error related with undefined reference to __divdi3
Date:   Fri, 11 Mar 2022 13:16:34 +0800
Message-Id: <20220311051634.28537-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e6d393a-e2bd-4dd7-c271-08da031e5e3b
X-MS-TrafficTypeDiagnostic: AM5PR04MB3284:EE_
X-Microsoft-Antispam-PRVS: <AM5PR04MB32848A61F12E2F76FFA44255E70C9@AM5PR04MB3284.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o4QjVgI7XqMspq3IGZBKNAWRJjX9K2mgvFqsODdrkQTrrkXN+4fg56e7iDV1BqJ7KEUDB2XoynQgHQ2GsJfjsgjw4o1raukTLa+WRz7g2aDDXDmdb8rdjOu70lDwy2AgpLdXVGAbzqRCIurtuABwZLcJOoiLjIBEhyTa/CkvYq2pfO/v2M6hOWGXmfIAS9ZZSkL8Y5UGogxcDqyrgcLfo+oPsBf2gij4sfYtrkGrYSuPG3eKUhSLcOlOB4NABfHR5ZZRV/FPHzkFOcvI7vr6AVDvBejgq3Chl26UaisC9V4dJZRn/RNERWqVvgePuu5/9ZVkXvGENd308tjfmyk6V8QN+e3SNH3q3QJn/RTpWmaNyfcTkNIQApi7j/EErPkpJJMIOElmOsSRmeKFEWffo/FDxJAhnHfkvO9sRbAeuUB43Gipp887a7uTDBu20vE1d/TxSwZVW+GsMThfc9ExomaI+0jOCfPUPzi+WtDyF6LS1eepkqBd7cbCK5JD3KrUkSrSYV77bThO+O5uac8UijkIl+749psU49YFDJfzJOhzKj6iO5ySQNbobawwoSX42CZdHrV2iwJ8la0QH01euEWbEaOnWobt2kdbpBoWWs8xG1GaNBTDG6eH31l8QFMVG1M4bbJmcYnkOo0ZPtU/7DzVjYxV6AwegE8TeO655qj0PipXOCN//DjdEDDu94O54r7IING091UKpr9pmQ969g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(44832011)(36756003)(508600001)(5660300002)(86362001)(8936002)(2616005)(1076003)(6486002)(66476007)(2906002)(6666004)(6512007)(66946007)(83380400001)(38350700002)(186003)(66556008)(38100700002)(4326008)(52116002)(316002)(6506007)(8676002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?So3p3bmdtB5PvZ1xZviG5hVqbjzKEaS7sdAeW0A8dR6rv5MlqZ6eI7Sfu0lw?=
 =?us-ascii?Q?65SlKsWwebShLMrZsjw19saCps4LHZ+0mtNWpCgm4z+cd7OpXwVvJG3ZBWax?=
 =?us-ascii?Q?Y5iDDRlI30FVUEmk1pPhAODQQRjUSjs3oVWTBCERH+wTHM8aI/ITv2l6o0a7?=
 =?us-ascii?Q?eA3mbNerX7cZis2x6ys/uCdE90fP/IrmNh21ECzWWfhxoLw67LIQwer5kIPH?=
 =?us-ascii?Q?4qQGEwmnOjzxsTJsmbQVYQBoVM+mIJwb1BYwWpi6gUVs+QCPlJ1OcvSqcqxB?=
 =?us-ascii?Q?Zu45csmtIte1HJEqinXEnwSw0MkVk+YlGQ8xOOCvaQ6GvFTmoaLpf7wtcZ5l?=
 =?us-ascii?Q?zWfgbfZfGKQfgkXRKkSmeNkT901EhH12tDIAb5sj0MfQKYC34XlGQ7W4povd?=
 =?us-ascii?Q?/bYklsssI15ZGcfBFcx3zojq/0bM7bTzlR77cOuXvzUUteMzINzSmobam50G?=
 =?us-ascii?Q?8dkAwegoWFb2ILBwOB0MoTcjgoxQrD+J4k2cOpmILzdjeoyvllurYFUEEZCM?=
 =?us-ascii?Q?f1w6C5o0aeG8bqRGWK7KBko31tqPaetHB/RER0Vp7ncGxrU6Fm7dnTSQzNqB?=
 =?us-ascii?Q?xCZFpX8mDXivlCHybTDOC1sf6QZbKdLmgu3Ifp/gjUrFbZ8tQRFbG6y4uFoa?=
 =?us-ascii?Q?htvBHLrMrp33OYFzVVf1lR5IeLphN8PlhmMZC3INvF73x2nzbeRiV/K9/djB?=
 =?us-ascii?Q?dFD5AMJwcN+sRaKU5z2KiS86+2Pt7C7QIIoTvk+zHCxUAY+Lo/Rpq2Sz0pUc?=
 =?us-ascii?Q?QbBZ0ngD1Id7fedjHn8Wibxm/0ZFVMj6b8/xmURzgzDTqxNzdqYJdmPF2920?=
 =?us-ascii?Q?Vg1wT4zZqvUwmhzmjpVvwbClR1+HPg0eubZDfZxIlQd5Dp/44VyH0L0rBRVc?=
 =?us-ascii?Q?Fm6Vv3Pcmu6DJ+KW5vYD7ENOIYft86yYvFmDrs6azfzCi7svyTMvg5DDyBdS?=
 =?us-ascii?Q?M70zWkkVhBX0xbk1Ei9eWfUzfbz3ksS1GxNQQJ4etFDUpYw5AMmh03MpNmm3?=
 =?us-ascii?Q?NfwmotgOCh+dsvjvYlIXaQjlxoex0fhJL0MqkVKJEllfGqYAdDrFKHjfAO5h?=
 =?us-ascii?Q?h/NXTouD63Kyr/DtP81UQRsKY0Zd42v3FOCtUGkLW2Y7sxROgv0SvOd6yX6i?=
 =?us-ascii?Q?+ntyPx3iPU85egQgk1xZSkyqIqRVQXwFVJh4IqDdap3XVkZgq7O94/hMyoKt?=
 =?us-ascii?Q?quRQTTiFXGzeKz6Wu7AVl+qTN4lra90FjnKVOcSe0ZqIYQcyFOoYE9wO8Sw0?=
 =?us-ascii?Q?ZU4Xhb6vNjS4FY+frPgPx/6irrth1NrFUYMlKBoiRXbarGQJuTcK5qbyzAdj?=
 =?us-ascii?Q?GPIiVoLeqesGuISdAY1wiOZh531VAUjklU87s1W1Z37jVLOr6HFvJni77IRZ?=
 =?us-ascii?Q?tlrt+gOU5+L2sXSU0CXt7pA7YccdfvVSK4QAf6/kN4lQxEi2SxkZ1FcCvfKF?=
 =?us-ascii?Q?JaDm55tsZeKWk9Pr2zMHw50vFSP3pDcC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6d393a-e2bd-4dd7-c271-08da031e5e3b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 05:16:59.4504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tYeOIyW2ngWwwhB0U76yt2ooU8a8yidjEpwZycTwOHIx40KUsjn6mNiy+UBTCDg42a2L4L1e4fPeBH3b5QYeWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3284
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
3. remove unused custom macro
4. don't modify minus timestamp
5. remove some unused debug timestamp information

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/media/platform/amphion/vdec.c        | 35 --------------------
 drivers/media/platform/amphion/vpu_helpers.h |  3 --
 drivers/media/platform/amphion/vpu_malone.c  | 18 +++++-----
 drivers/media/platform/amphion/vpu_v4l2.c    |  5 +--
 drivers/media/platform/amphion/vpu_windsor.c | 18 +++++-----
 5 files changed, 19 insertions(+), 60 deletions(-)

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
index c2b424fb6453..80ba3ad9045c 100644
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

