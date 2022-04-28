Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B167512CF8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239422AbiD1Hhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbiD1Hhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:37:36 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40DF9BAD1;
        Thu, 28 Apr 2022 00:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651131262; x=1682667262;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=tCs7ErG885gKztJRvUVGDYnI/7nNF4ztVwUO/AczKV8=;
  b=Y076bJgAWC9OnwVedBMkuXtvUq1by3OfqsZkLUvhMUcP9OfKKoIeK4Nx
   mRky2Yr7LwNLmFHFpWLF3xKPDCFdwec3n6zrvN2u6roBtiJvL7xi7ipYR
   Lf961z20oPf5hFSdWFKIY53+cJtI3j+7Yjc+vjfuphE9vha22CSkEa3Y/
   8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Apr 2022 00:34:22 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 00:34:22 -0700
Received: from hu-vgarodia-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 28 Apr 2022 00:34:19 -0700
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
To:     <linux-media@vger.kernel.org>, <stanimir.varbanov@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_vgarodia@quicinc.com>, <frkoenig@chromium.org>,
        <quic_dikshita@quicinc.com>
Subject: [PATCH] media: venus: set ubwc configuration on specific video hardware
Date:   Thu, 28 Apr 2022 13:04:08 +0530
Message-ID: <1651131248-20313-1-git-send-email-quic_vgarodia@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UBWC configuration parameters would vary across video hardware
generations. At the same time, driver is expected to configure
these parameters, without relying on video firmware to use the
default configurations.
Setting the configuration parameters for sc7280.

Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
---
 drivers/media/platform/qcom/venus/core.c       |  5 +++
 drivers/media/platform/qcom/venus/core.h       | 18 +++++++++
 drivers/media/platform/qcom/venus/hfi_cmds.c   |  9 +++++
 drivers/media/platform/qcom/venus/hfi_cmds.h   |  1 +
 drivers/media/platform/qcom/venus/hfi_helper.h | 20 ++++++++++
 drivers/media/platform/qcom/venus/hfi_venus.c  | 54 ++++++++++++++++++++++++++
 6 files changed, 107 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 877eca1..75d8e14 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -832,6 +832,10 @@ static const struct reg_val sm7280_reg_preset[] = {
 	{ 0xb0088, 0 },
 };
 
+static const struct ubwc_config sc7280_ubwc_config[] = {
+	{{1, 1, 1, 0, 0, 0}, 8, 32, 14, 0, 0},
+};
+
 static const struct venus_resources sc7280_res = {
 	.freq_tbl = sc7280_freq_table,
 	.freq_tbl_size = ARRAY_SIZE(sc7280_freq_table),
@@ -841,6 +845,7 @@ static const struct venus_resources sc7280_res = {
 	.bw_tbl_enc_size = ARRAY_SIZE(sc7280_bw_table_enc),
 	.bw_tbl_dec = sc7280_bw_table_dec,
 	.bw_tbl_dec_size = ARRAY_SIZE(sc7280_bw_table_dec),
+	.ubwc_conf = sc7280_ubwc_config,
 	.clks = {"core", "bus", "iface"},
 	.clks_num = 3,
 	.vcodec0_clks = {"vcodec_core", "vcodec_bus"},
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index c3023340..ef71462 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -47,6 +47,23 @@ struct bw_tbl {
 	u32 peak_10bit;
 };
 
+struct ubwc_config {
+	struct {
+		u32 max_channel_override : 1;
+		u32 mal_length_override : 1;
+		u32 hb_override : 1;
+		u32 bank_swzl_level_override : 1;
+		u32 bank_spreading_override : 1;
+		u32 reserved : 27;
+	} override_bit_info;
+
+	u32 max_channels;
+	u32 mal_length;
+	u32 highest_bank_bit;
+	u32 bank_swzl_level;
+	u32 bank_spreading;
+};
+
 struct venus_resources {
 	u64 dma_mask;
 	const struct freq_tbl *freq_tbl;
@@ -57,6 +74,7 @@ struct venus_resources {
 	unsigned int bw_tbl_dec_size;
 	const struct reg_val *reg_tbl;
 	unsigned int reg_tbl_size;
+	const struct ubwc_config *ubwc_conf;
 	const char * const clks[VIDC_CLKS_NUM_MAX];
 	unsigned int clks_num;
 	const char * const vcodec0_clks[VIDC_VCODEC_CLKS_NUM_MAX];
diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
index 4ecd444..036eaca 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.c
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
@@ -58,6 +58,15 @@ void pkt_sys_coverage_config(struct hfi_sys_set_property_pkt *pkt, u32 mode)
 	pkt->data[1] = mode;
 }
 
+void pkt_sys_ubwc_config(struct hfi_sys_set_property_pkt *pkt, struct hfi_ubwc_config *hfi)
+{
+	pkt->hdr.size = struct_size(pkt, data, 1) + sizeof(*hfi);
+	pkt->hdr.pkt_type = HFI_CMD_SYS_SET_PROPERTY;
+	pkt->num_properties = 1;
+	pkt->data[0] = HFI_PROPERTY_SYS_UBWC_CONFIG;
+	memcpy(&pkt->data[1], hfi, sizeof(*hfi));
+}
+
 int pkt_sys_set_resource(struct hfi_sys_set_resource_pkt *pkt, u32 id, u32 size,
 			 u32 addr, void *cookie)
 {
diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
index 327ed90..ce7179e 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.h
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
@@ -256,6 +256,7 @@ void pkt_sys_init(struct hfi_sys_init_pkt *pkt, u32 arch_type);
 void pkt_sys_pc_prep(struct hfi_sys_pc_prep_pkt *pkt);
 void pkt_sys_idle_indicator(struct hfi_sys_set_property_pkt *pkt, u32 enable);
 void pkt_sys_power_control(struct hfi_sys_set_property_pkt *pkt, u32 enable);
+void pkt_sys_ubwc_config(struct hfi_sys_set_property_pkt *pkt, struct hfi_ubwc_config *hfi);
 int pkt_sys_set_resource(struct hfi_sys_set_resource_pkt *pkt, u32 id, u32 size,
 			 u32 addr, void *cookie);
 int pkt_sys_unset_resource(struct hfi_sys_release_resource_pkt *pkt, u32 id,
diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
index 2daa88e..d2d6719 100644
--- a/drivers/media/platform/qcom/venus/hfi_helper.h
+++ b/drivers/media/platform/qcom/venus/hfi_helper.h
@@ -427,6 +427,7 @@
 #define HFI_PROPERTY_SYS_CODEC_POWER_PLANE_CTRL			0x5
 #define HFI_PROPERTY_SYS_IMAGE_VERSION				0x6
 #define HFI_PROPERTY_SYS_CONFIG_COVERAGE			0x7
+#define HFI_PROPERTY_SYS_UBWC_CONFIG				0x8
 
 /*
  * HFI_PROPERTY_PARAM_COMMON_START
@@ -626,6 +627,25 @@ struct hfi_debug_config {
 	u32 mode;
 };
 
+struct hfi_ubwc_config {
+	u32 size;
+	u32 packet_type;
+	struct {
+		u32 max_channel_override : 1;
+		u32 mal_length_override : 1;
+		u32 hb_override : 1;
+		u32 bank_swzl_level_override : 1;
+		u32 bank_spreading_override : 1;
+		u32 reserved : 27;
+		} override_bit_info;
+	u32 max_channels;
+	u32 mal_length;
+	u32 highest_bank_bit;
+	u32 bank_swzl_level;
+	u32 bank_spreading;
+	u32 reserved[2];
+};
+
 struct hfi_enable {
 	u32 enable;
 };
diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 3a75a27..25131d0 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -904,6 +904,52 @@ static int venus_sys_set_power_control(struct venus_hfi_device *hdev,
 	return 0;
 }
 
+static int venus_sys_set_ubwc_config(struct venus_hfi_device *hdev)
+{
+	struct hfi_sys_set_property_pkt *pkt;
+	u8 packet[IFACEQ_VAR_SMALL_PKT_SIZE];
+	struct hfi_ubwc_config *hfi;
+	const struct venus_resources *res = hdev->core->res;
+	const struct ubwc_config *ubwc_conf = res->ubwc_conf;
+	int ret;
+
+	hfi = kzalloc(sizeof(*hfi), GFP_KERNEL);
+	if (!hfi)
+		return -ENOMEM;
+
+	pkt = (struct hfi_sys_set_property_pkt *)packet;
+
+	hfi->max_channels = ubwc_conf->max_channels;
+	hfi->override_bit_info.max_channel_override =
+		ubwc_conf->override_bit_info.max_channel_override;
+
+	hfi->mal_length = ubwc_conf->mal_length;
+	hfi->override_bit_info.mal_length_override =
+		ubwc_conf->override_bit_info.mal_length_override;
+
+	hfi->highest_bank_bit = ubwc_conf->highest_bank_bit;
+	hfi->override_bit_info.hb_override =
+		ubwc_conf->override_bit_info.hb_override;
+
+	hfi->bank_swzl_level = ubwc_conf->bank_swzl_level;
+	hfi->override_bit_info.bank_swzl_level_override =
+		ubwc_conf->override_bit_info.bank_swzl_level_override;
+
+	hfi->bank_spreading = ubwc_conf->bank_spreading;
+	hfi->override_bit_info.bank_spreading_override =
+		ubwc_conf->override_bit_info.bank_spreading_override;
+
+	pkt_sys_ubwc_config(pkt, hfi);
+
+	kfree(hfi);
+
+	ret = venus_iface_cmdq_write(hdev, pkt, false);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int venus_get_queue_size(struct venus_hfi_device *hdev,
 				unsigned int index)
 {
@@ -922,6 +968,7 @@ static int venus_get_queue_size(struct venus_hfi_device *hdev,
 static int venus_sys_set_default_properties(struct venus_hfi_device *hdev)
 {
 	struct device *dev = hdev->core->dev;
+	const struct venus_resources *res = hdev->core->res;
 	int ret;
 
 	ret = venus_sys_set_debug(hdev, venus_fw_debug);
@@ -945,6 +992,13 @@ static int venus_sys_set_default_properties(struct venus_hfi_device *hdev)
 		dev_warn(dev, "setting hw power collapse ON failed (%d)\n",
 			 ret);
 
+	/* For specific venus core, it is mandatory to set the UBWC configuration */
+	if (res->ubwc_conf) {
+		ret = venus_sys_set_ubwc_config();
+		if (ret)
+			dev_warn(dev, "setting ubwc config failed (%d)\n", ret);
+	}
+
 	return ret;
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

