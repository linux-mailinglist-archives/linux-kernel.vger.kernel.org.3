Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9722D5ACE14
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbiIEInS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237238AbiIEInO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:43:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029431C927;
        Mon,  5 Sep 2022 01:43:11 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2856unPe018838;
        Mon, 5 Sep 2022 08:43:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=5noBQ3i8+bbKWKW5cmGwfG2+B6Yygvw259K3AQaberY=;
 b=PsfCXWPY0dYBVAQ5MmbAb9ruZgV3n1simdcOdNhqRWH4T35aGjXpc9A2PLuULDP+Tr+s
 VE0NhFsKIuwCcIZ0C6KaNeePIs0GmCnMvIHAlH2m9PA3CDX4abx7mG8vzq59YX0RPcvm
 Jg8Y/cd4JrWSMAgJ2g51/CdrOmXm9zFxr9mH4Fx9YbBsEyd+nTnj4J2rDkDwG9bXGU5I
 /DWVVyFMnTvHhi7N3eyUzKaEcYnfq5owK6SK66LmaSPnjvGqgCrBV8UO2Wv3M+APZQlc
 rEZC+a9sqhlk9+7uVPb6HP48BR6NNi9RWCCdKWgALrdudXHsPuPx4m4Rm/C6lFZ4HiV4 8A== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jc03v3mpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 08:43:08 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2858h53m012422;
        Mon, 5 Sep 2022 08:43:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3jc00k48p0-1;
        Mon, 05 Sep 2022 08:43:05 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2858eaGJ010668;
        Mon, 5 Sep 2022 08:43:05 GMT
Received: from vboma-linux.qualcomm.com (vboma-linux.qualcomm.com [10.204.65.94])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 2858h4px012398;
        Mon, 05 Sep 2022 08:43:05 +0000
Received: by vboma-linux.qualcomm.com (Postfix, from userid 72083)
        id 3C91B900883; Mon,  5 Sep 2022 14:13:04 +0530 (IST)
From:   quic_vboma@quicinc.com
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Viswanath Boma <quic_vboma@quicinc.com>,
        Vikash Garodia <vgarodia@qti.qualcomm.com>
Subject: [PATCH 1/1] venus : Enabling sufficient sequence change support for VP9 on sc7180-venus
Date:   Mon,  5 Sep 2022 14:12:27 +0530
Message-Id: <20220905084227.24028-2-quic_vboma@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220905084227.24028-1-quic_vboma@quicinc.com>
References: <20220905084227.24028-1-quic_vboma@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 45cjwl5CDmo_8Pa3CHF8GgZVSjc_9Wy0
X-Proofpoint-ORIG-GUID: 45cjwl5CDmo_8Pa3CHF8GgZVSjc_9Wy0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-05_05,2022-09-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209050041
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viswanath Boma <quic_vboma@quicinc.com>

For sc7180 VP9 requires enabling of sufficient sequence change support.

Signed-off-by: Vikash Garodia <vgarodia@qti.qualcomm.com>
Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
---
 drivers/media/platform/qcom/venus/core.h       |  2 ++
 drivers/media/platform/qcom/venus/hfi_cmds.c   |  1 +
 drivers/media/platform/qcom/venus/hfi_helper.h |  2 ++
 drivers/media/platform/qcom/venus/hfi_msgs.c   | 13 ++++++-------
 drivers/media/platform/qcom/venus/vdec.c       | 16 +++++++++++++++-
 5 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 60fcded03b872..007494a4fcfcf 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -25,6 +25,7 @@
 #define VIDC_CLKS_NUM_MAX		4
 #define VIDC_VCODEC_CLKS_NUM_MAX	2
 #define VIDC_PMDOMAINS_NUM_MAX		3
+#define VER_STR_SZ              128
 
 struct freq_tbl {
 	unsigned int load;
@@ -162,6 +163,7 @@ struct venus_core {
 	unsigned int core0_usage_count;
 	unsigned int core1_usage_count;
 	struct dentry *root;
+	char venus_img_ver[VER_STR_SZ];
 };
 
 struct vdec_controls {
diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
index 7ed19050fab49..c296b0d343532 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.c
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
@@ -511,6 +511,7 @@ static int pkt_session_set_property_1x(struct hfi_session_set_property_pkt *pkt,
 		pkt->shdr.hdr.size += sizeof(u32) + sizeof(*en);
 		break;
 	}
+	case HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT:
 	case HFI_PROPERTY_CONFIG_VDEC_POST_LOOP_DEBLOCKER: {
 		struct hfi_enable *in = pdata;
 		struct hfi_enable *en = prop_data;
diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
index 507ff8c5a9b38..52517aafde214 100644
--- a/drivers/media/platform/qcom/venus/hfi_helper.h
+++ b/drivers/media/platform/qcom/venus/hfi_helper.h
@@ -463,6 +463,8 @@
 #define HFI_PROPERTY_PARAM_VDEC_PIXEL_BITDEPTH			0x1003007
 #define HFI_PROPERTY_PARAM_VDEC_PIC_STRUCT			0x1003009
 #define HFI_PROPERTY_PARAM_VDEC_COLOUR_SPACE			0x100300a
+#define HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT \
+								0x0100300b
 
 /*
  * HFI_PROPERTY_CONFIG_VDEC_COMMON_START
diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
index e8776ac45b020..4ef5d6b6e7ec0 100644
--- a/drivers/media/platform/qcom/venus/hfi_msgs.c
+++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
@@ -16,7 +16,6 @@
 #include "hfi_parser.h"
 
 #define SMEM_IMG_VER_TBL	469
-#define VER_STR_SZ		128
 #define SMEM_IMG_OFFSET_VENUS	(14 * 128)
 
 static void event_seq_changed(struct venus_core *core, struct venus_inst *inst,
@@ -241,11 +240,11 @@ static void hfi_sys_init_done(struct venus_core *core, struct venus_inst *inst,
 }
 
 static void
-sys_get_prop_image_version(struct device *dev,
+sys_get_prop_image_version(struct venus_core *core,
 			   struct hfi_msg_sys_property_info_pkt *pkt)
 {
+	struct device *dev = core->dev;
 	u8 *smem_tbl_ptr;
-	u8 *img_ver;
 	int req_bytes;
 	size_t smem_blk_sz;
 
@@ -255,15 +254,15 @@ sys_get_prop_image_version(struct device *dev,
 		/* bad packet */
 		return;
 
-	img_ver = (u8 *)&pkt->data[1];
+	strncpy(core->venus_img_ver, (u8 *)&pkt->data[1], VER_STR_SZ);
 
-	dev_dbg(dev, VDBGL "F/W version: %s\n", img_ver);
+	dev_dbg(dev, VDBGL "F/W version: %s\n", core->venus_img_ver);
 
 	smem_tbl_ptr = qcom_smem_get(QCOM_SMEM_HOST_ANY,
 		SMEM_IMG_VER_TBL, &smem_blk_sz);
 	if (!IS_ERR(smem_tbl_ptr) && smem_blk_sz >= SMEM_IMG_OFFSET_VENUS + VER_STR_SZ)
 		memcpy(smem_tbl_ptr + SMEM_IMG_OFFSET_VENUS,
-		       img_ver, VER_STR_SZ);
+		       core->venus_img_ver, VER_STR_SZ);
 }
 
 static void hfi_sys_property_info(struct venus_core *core,
@@ -279,7 +278,7 @@ static void hfi_sys_property_info(struct venus_core *core,
 
 	switch (pkt->data[0]) {
 	case HFI_PROPERTY_SYS_IMAGE_VERSION:
-		sys_get_prop_image_version(dev, pkt);
+		sys_get_prop_image_version(core, pkt);
 		break;
 	default:
 		dev_dbg(dev, VDBGL "unknown property data\n");
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 0525fd0d3ef2c..409705b2b1c88 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -627,7 +627,7 @@ static int vdec_set_properties(struct venus_inst *inst)
 {
 	struct vdec_controls *ctr = &inst->controls.dec;
 	struct hfi_enable en = { .enable = 1 };
-	u32 ptype;
+	u32 ptype, major, minor, rev;
 	int ret;
 
 	if (ctr->post_loop_deb_mode) {
@@ -637,6 +637,20 @@ static int vdec_set_properties(struct venus_inst *inst)
 			return ret;
 	}
 
+
+	/* Enabling sufficient sequence change support for VP9 */
+	ret = sscanf(inst->core->venus_img_ver, "14:VIDEO.VE.%u.%u-%u-PROD",
+			 &major, &minor, &rev);
+	if (ret != 3)
+		return -EINVAL;
+
+	if (major == 5 && minor == 4 && rev >= 51) {
+		ptype = HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT;
+		ret = hfi_session_set_property(inst, ptype, &en);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.17.1

