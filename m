Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873DC565A26
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbiGDPnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbiGDPm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:42:57 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175D111448
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 08:42:55 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id k129so5648405wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 08:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+/qhlqAn1+lyzdXpSXR4rFVGbOoEQWBDWuMIJIRGZ3A=;
        b=e9Wp7gRva44v2ejPGQXq0uT0hR/4+K82UL/RFN/o3Ac6YZE4cpyss4xB+Dl+Lq2gzg
         5wpfL4b5lN3sV9s0WZTIaIblFAWYyY0BLhwQc/twA+CpF2y1PNaR8dmGzjq9sJjY4C8r
         YvpqhKZED2AVLoAM6wL25e+NdhxKJ+9vBmHAnL1KTKESIvNbvRWKAZT6zzEu43WkEDWz
         8lze71GGIkxxsx0V3K/wqAVUf5zlvqB3ybjs0H9nY3nL2duUXqBWm/RPxUzCzZjsOlHB
         GJp5U8VoxUqDMtdMf24nQSdRjYryNSfj9iC3IOClOL14g1+l2zOFkV3K7hhUA6LjtSNF
         fx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+/qhlqAn1+lyzdXpSXR4rFVGbOoEQWBDWuMIJIRGZ3A=;
        b=dpC++QRZ9VwKUaAkP7Fzpp4Juo5Fg4X251FJqQ4BYY9MA2diXoDBos36NFOxtFylv9
         NS9pIqPwN/hxsoMpHJuGBNf4ggpgQ9chudKs3tymsKz5qQ/b4n7poee4ynMaMJAzwtt1
         1Duu1YfZK/MmplXs0l06Mv/sy3C4zb1hSdfEH3/x8CPepXBv2HFysr7zVYFK13OKpo3i
         Syikh6zMgFMkppNMSKDLRVWgtbtV2gzOdqSwdjiRQSF98FjXARVLQynVm7gRUNuQPCgD
         aNJJqV+I5bXT5T2lfMDPTaMxeEl4ja1d+Nd7VfJtPtiSLZ1FHPDWZEELde/0aFESAZLj
         GckA==
X-Gm-Message-State: AJIora/IzB/LNjlJxVZ4nBT06BHUjMyUxzl5XAmuP4E+eLTQcG79N1L8
        I3a7CQ98e05xUv6DsMwcDJ06bQ==
X-Google-Smtp-Source: AGRyM1sYLvw68OWNDVsdoJ99vrbtzMIRKZ58kxDMIAzg9YVtCRtOjZAOrDx2/zMgzIUeIPJ/DfHlqw==
X-Received: by 2002:a1c:19c3:0:b0:39c:6479:3ca with SMTP id 186-20020a1c19c3000000b0039c647903camr32962682wmz.27.1656949373388;
        Mon, 04 Jul 2022 08:42:53 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:a9e8:9fdd:fa2d:1c72])
        by smtp.gmail.com with ESMTPSA id j6-20020adfff86000000b0021d6b851ca1sm2763749wrr.111.2022.07.04.08.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 08:42:52 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        leo.yan@linaro.org, acme@kernel.org, james.clark@arm.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v4 2/7] coresight: configfs: Add in functionality for load via configfs
Date:   Mon,  4 Jul 2022 16:42:44 +0100
Message-Id: <20220704154249.11501-3-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220704154249.11501-1-mike.leach@linaro.org>
References: <20220704154249.11501-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add in functionality to allow load via configfs.

Define a binary file format and provide a reader for that format
that will create and populate configuration and feature structures
use by the driver infrastructure.

Adds API to access new functionality.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/Makefile          |   2 +-
 .../coresight/coresight-config-file.c         | 520 ++++++++++++++++++
 .../coresight/coresight-config-file.h         | 139 +++++
 .../hwtracing/coresight/coresight-config.h    |  15 +
 .../hwtracing/coresight/coresight-syscfg.h    |   1 +
 5 files changed, 676 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-config-file.c
 create mode 100644 drivers/hwtracing/coresight/coresight-config-file.h

diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index b6c4a48140ec..5de2bb79f4ac 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -6,7 +6,7 @@ obj-$(CONFIG_CORESIGHT) += coresight.o
 coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
 		coresight-sysfs.o coresight-syscfg.o coresight-config.o \
 		coresight-cfg-preload.o coresight-cfg-afdo.o \
-		coresight-syscfg-configfs.o
+		coresight-syscfg-configfs.o coresight-config-file.o
 obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
 coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
 		      coresight-tmc-etr.o
diff --git a/drivers/hwtracing/coresight/coresight-config-file.c b/drivers/hwtracing/coresight/coresight-config-file.c
new file mode 100644
index 000000000000..be11261e3a14
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-config-file.c
@@ -0,0 +1,520 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Linaro Limited, All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+
+#include "coresight-config.h"
+#include "coresight-config-file.h"
+
+#define cscfg_extract_u64(val64) { \
+	val64 = *(u64 *)(buffer + used); \
+	used += sizeof(u64); \
+	}
+
+#define cscfg_extract_u32(val32) { \
+	val32 = *(u32 *)(buffer + used); \
+	used += sizeof(u32); \
+	}
+
+#define cscfg_extract_u16(val16) { \
+	val16 = *(u16 *)(buffer + used); \
+	used += sizeof(u16); \
+	}
+
+#define cscfg_extract_u8(val8) { \
+	val8 = *(buffer + used); \
+	used++; \
+	}
+
+static int cscfg_file_read_hdr(const u8 *buffer, const int buflen, int *buf_used,
+			       struct cscfg_file_header *hdr)
+{
+	/* file header always at the start of the buffer */
+	int used = 0;
+
+	if (buflen < sizeof(struct cscfg_file_header))
+		return -EINVAL;
+
+	cscfg_extract_u32(hdr->magic_version);
+	if (hdr->magic_version != CSCFG_FILE_MAGIC_VERSION)
+		return -EINVAL;
+
+	cscfg_extract_u16(hdr->length);
+	if (hdr->length > buflen)
+		return -EINVAL;
+
+	cscfg_extract_u16(hdr->nr_configs);
+	cscfg_extract_u16(hdr->nr_features);
+
+	*buf_used = used;
+	return 0;
+}
+
+static int cscfg_file_read_elem_hdr(const u8 *buffer, const int buflen, int *buf_used,
+				    struct cscfg_file_elem_header *elem_hdr)
+{
+	int used = *buf_used;
+
+	if ((buflen - used) < (sizeof(u16) + sizeof(u8)))
+		return -EINVAL;
+
+	/* read length and check enough buffer remains for this element */
+	elem_hdr->elem_length = *(u16 *)(buffer + used);
+	if ((buflen - used) < elem_hdr->elem_length)
+		return -EINVAL;
+	/* don't use extract fn as we update used _after_ the comparison */
+	used += sizeof(u16);
+
+	/* read type and validate */
+	cscfg_extract_u8(elem_hdr->elem_type);
+	if ((elem_hdr->elem_type < CSCFG_FILE_ELEM_TYPE_FEAT) ||
+	    (elem_hdr->elem_type > CSCFG_FILE_ELEM_TYPE_CFG))
+		return -EINVAL;
+
+	*buf_used = used;
+	return 0;
+}
+
+static int cscfg_file_read_elem_str(const u8 *buffer, const int buflen, int *buf_used,
+				    struct cscfg_file_elem_str *elem_str)
+{
+	int used = *buf_used;
+
+	if ((buflen - used) < sizeof(u16))
+		return -EINVAL;
+
+	cscfg_extract_u16(elem_str->str_len);
+
+	if ((buflen - used) < elem_str->str_len)
+		return -EINVAL;
+
+	/* check for 0 termination */
+	if (buffer[used + (elem_str->str_len - 1)] != 0)
+		return -EINVAL;
+
+	elem_str->str = kstrdup((char *)(buffer + used),  GFP_KERNEL);
+	used += elem_str->str_len;
+
+	*buf_used = used;
+	return 0;
+}
+
+static int cscfg_file_alloc_desc_arrays(struct cscfg_fs_load_descs *desc_arrays,
+					int nr_features, int nr_configs)
+{
+	/* arrays are 0 terminated - nr_configs & nr_features elements */
+	desc_arrays->config_descs = kcalloc(nr_configs + 1,  sizeof(struct cscfg_config_desc *),
+					    GFP_KERNEL);
+	if (!desc_arrays->config_descs)
+		return -ENOMEM;
+	desc_arrays->feat_descs = kcalloc(nr_features + 1, sizeof(struct cscfg_feature_desc *),
+					  GFP_KERNEL);
+	if (!desc_arrays->feat_descs)
+		return -ENOMEM;
+	return 0;
+}
+
+/* free up the data allocated to a config desc */
+static void cscfg_file_free_config_desc(struct cscfg_config_desc *config_desc)
+{
+	int i;
+
+	if (!config_desc)
+		return;
+
+	/* free presets */
+	kfree(config_desc->presets);
+
+	/* free feat ref strings */
+	if (config_desc->nr_feat_refs) {
+		/* each string */
+		for (i = 0; i < config_desc->nr_feat_refs; i++)
+			kfree(config_desc->feat_ref_names[i]);
+
+		/* and the char * array */
+		kfree(config_desc->feat_ref_names);
+	}
+
+	/* next the strings */
+	kfree(config_desc->name);
+	kfree(config_desc->description);
+
+	/* finally the struct itself */
+	kfree(config_desc);
+}
+
+static int cscfg_file_read_elem_config(const u8 *buffer, const int buflen, int *buf_used,
+				       struct cscfg_fs_load_descs *desc_arrays,
+				       const int cfg_index)
+{
+	struct cscfg_file_elem_header elem_hdr;
+	struct cscfg_file_elem_str elem_str;
+	struct cscfg_config_desc *config_desc;
+	int used = *buf_used, nr_preset_vals, nr_preset_bytes, i;
+	int err = 0;
+	u64 *presets;
+
+	/*
+	 * read the header - if not config, then don't update buf_used
+	 * pointer on return
+	 */
+	err = cscfg_file_read_elem_hdr(buffer, buflen, &used, &elem_hdr);
+	if (err)
+		return err;
+	if (elem_hdr.elem_type != CSCFG_FILE_ELEM_TYPE_CFG)
+		return 0;
+
+	/* we have a config - allocate the descriptor */
+	config_desc = kzalloc(sizeof(struct cscfg_config_desc), GFP_KERNEL);
+	if (!config_desc)
+		return -ENOMEM;
+
+	/* read the name string */
+	err = cscfg_file_read_elem_str(buffer, buflen, &used, &elem_str);
+	if (err)
+		return err;
+	config_desc->name = elem_str.str;
+
+	/* read the description string */
+	err = cscfg_file_read_elem_str(buffer, buflen, &used, &elem_str);
+	if (err)
+		return err;
+	config_desc->description = elem_str.str;
+
+	/* read in some values */
+	if ((buflen - used) < sizeof(u64))
+		return -EINVAL;
+	cscfg_extract_u16(config_desc->nr_presets);
+	cscfg_extract_u32(config_desc->nr_total_params);
+	cscfg_extract_u16(config_desc->nr_feat_refs);
+
+	/* read the array of 64bit presets if present */
+	nr_preset_vals = config_desc->nr_total_params * config_desc->nr_presets;
+	if (nr_preset_vals) {
+		presets = kcalloc(nr_preset_vals, sizeof(u64), GFP_KERNEL);
+		if (!presets)
+			return -ENOMEM;
+
+		nr_preset_bytes = sizeof(u64) * nr_preset_vals;
+		if ((buflen - used) < nr_preset_bytes)
+			return -EINVAL;
+
+		memcpy(presets, (buffer + used), nr_preset_bytes);
+		config_desc->presets = presets;
+		used += nr_preset_bytes;
+	}
+
+	/* read the array of feature names referenced by the config */
+	if (config_desc->nr_feat_refs) {
+		config_desc->feat_ref_names = kcalloc(config_desc->nr_feat_refs,
+						      sizeof(char *), GFP_KERNEL);
+		if (!config_desc->feat_ref_names)
+			return -ENOMEM;
+
+		for (i = 0; i < config_desc->nr_feat_refs; i++) {
+			err = cscfg_file_read_elem_str(buffer, buflen, &used, &elem_str);
+			if (err)
+				return err;
+			config_desc->feat_ref_names[i] = elem_str.str;
+		}
+	}
+
+	desc_arrays->config_descs[cfg_index] = config_desc;
+	*buf_used = used;
+	return 0;
+}
+
+/*
+ * Read a config name - if there is a config at this position.
+ *
+ * Reads the element header at the current position.
+ * If it is a configuration header (type = CSCFG_FILE_ELEM_TYPE_CFG),
+ * then continue and read the configuration name into @elem_str and update the
+ * @buf_used pointers.
+ *
+ * Otherwise return 0, without updating the used pointers.
+ */
+static int cscfg_file_read_elem_config_name(const u8 *buffer, const int buflen, int *buf_used,
+					    struct cscfg_file_elem_str *elem_str)
+{
+	struct cscfg_file_elem_header elem_hdr;
+	int used = *buf_used;
+	int err;
+
+	elem_str->str_len = 0;
+	/*
+	 * read the header - if not config, then don't update buf_used
+	 * pointer on return
+	 */
+	err = cscfg_file_read_elem_hdr(buffer, buflen, &used, &elem_hdr);
+	if (err)
+		return err;
+	if (elem_hdr.elem_type != CSCFG_FILE_ELEM_TYPE_CFG)
+		return 0;
+
+	/* read the name string */
+	err = cscfg_file_read_elem_str(buffer, buflen, &used, elem_str);
+	if (err)
+		return err;
+	*buf_used = used;
+
+	return 0;
+}
+
+static int cscfg_file_read_elem_param(const u8 *buffer, const int buflen, int *buf_used,
+				      struct cscfg_parameter_desc *param_desc)
+{
+	struct cscfg_file_elem_str elem_str;
+	int err = 0, used = *buf_used;
+
+	/* parameter name */
+	err = cscfg_file_read_elem_str(buffer, buflen, &used, &elem_str);
+	if (err)
+		return err;
+	param_desc->name = elem_str.str;
+
+	/* parameter value */
+	if ((buflen - used) < sizeof(u64))
+		return -EINVAL;
+	cscfg_extract_u64(param_desc->value);
+
+	*buf_used = used;
+	return err;
+}
+
+static void cscfg_file_free_feat_desc(struct cscfg_feature_desc *feat_desc)
+{
+	if (!feat_desc)
+		return;
+
+	/* free up the register descriptor array */
+	kfree(feat_desc->regs_desc);
+
+	/* free up the parameters array */
+	kfree(feat_desc->params_desc);
+
+	/* name and description strings */
+	kfree(feat_desc->name);
+	kfree(feat_desc->description);
+
+	/* finally the struct itself */
+	kfree(feat_desc);
+}
+
+static int cscfg_file_read_elem_feature(const u8 *buffer, const int buflen, int *buf_used,
+					struct cscfg_fs_load_descs *desc_arrays,
+					const int feat_idx)
+{
+	struct cscfg_file_elem_header elem_hdr;
+	struct cscfg_file_elem_str elem_str;
+	struct cscfg_feature_desc *feat_desc;
+	struct cscfg_regval_desc *p_reg_desc;
+	int used = *buf_used, err, i, nr_regs_bytes;
+	u32 val32;
+
+	/* allocate the feature descriptor object */
+	feat_desc = kzalloc(sizeof(struct cscfg_feature_desc), GFP_KERNEL);
+	if (!feat_desc)
+		return -ENOMEM;
+
+	/* read and check the element header */
+	err = cscfg_file_read_elem_hdr(buffer, buflen, &used, &elem_hdr);
+	if (err)
+		return err;
+
+	if (elem_hdr.elem_type != CSCFG_FILE_ELEM_TYPE_FEAT)
+		return -EINVAL;
+
+	/* read the feature name */
+	err = cscfg_file_read_elem_str(buffer, buflen, &used, &elem_str);
+	if (err)
+		return err;
+	feat_desc->name = elem_str.str;
+
+	/* read the description string */
+	err = cscfg_file_read_elem_str(buffer, buflen, &used, &elem_str);
+	if (err)
+		return err;
+	feat_desc->description = elem_str.str;
+
+	/*
+	 * read in some values
+	 * [u32 value: match_flags]
+	 * [u16 value: nr_regs]	    - number of registers.
+	 * [u16 value: nr_params]   - number of parameters.
+	 */
+	cscfg_extract_u32(feat_desc->match_flags);
+	cscfg_extract_u16(feat_desc->nr_regs);
+	cscfg_extract_u16(feat_desc->nr_params);
+
+	/* register descriptors  - 32 bit + 64 bit value */
+	if (feat_desc->nr_regs) {
+		nr_regs_bytes = ((sizeof(u32) + sizeof(u64)) * feat_desc->nr_regs);
+		if ((buflen - used) < nr_regs_bytes)
+			return -EINVAL;
+		feat_desc->regs_desc = kcalloc(feat_desc->nr_regs,
+					       sizeof(struct cscfg_regval_desc), GFP_KERNEL);
+		if (!feat_desc->regs_desc)
+			return -ENOMEM;
+
+		for (i = 0; i < feat_desc->nr_regs; i++) {
+			cscfg_extract_u32(val32);
+			p_reg_desc = (struct cscfg_regval_desc *)&feat_desc->regs_desc[i];
+			CSCFG_FILE_U32_TO_REG_DESC_INFO(val32, p_reg_desc);
+			cscfg_extract_u64(feat_desc->regs_desc[i].val64);
+		}
+	}
+
+	/* parameter descriptors - string + 64 bit value */
+	if (feat_desc->nr_params) {
+		feat_desc->params_desc = kcalloc(feat_desc->nr_params,
+						 sizeof(struct cscfg_parameter_desc), GFP_KERNEL);
+		if (!feat_desc->params_desc)
+			return -ENOMEM;
+		for (i = 0; i < feat_desc->nr_params; i++) {
+			err = cscfg_file_read_elem_param(buffer, buflen, &used,
+							 &feat_desc->params_desc[i]);
+			if (err)
+				return err;
+		}
+	}
+
+	desc_arrays->feat_descs[feat_idx] = feat_desc;
+	*buf_used = used;
+	return 0;
+}
+
+/*
+ * Read a feature name.
+ *
+ * Check the element header to ensure that a feature (type = CSCFG_FILE_ELEM_TYPE_FEAT)
+ * is at this position and read the following string & update @buf_used.
+ *
+ * If not a feature then return -EINVAL.
+ */
+static int cscfg_file_read_elem_feat_name(const u8 *buffer, const int buflen, int *buf_used,
+					  struct cscfg_file_elem_str *elem_str)
+{
+	struct cscfg_file_elem_header elem_hdr;
+	int used = *buf_used;
+	int err;
+
+	elem_str->str_len = 0;
+	/*
+	 * read the header - if not feature, then don't update buf_used
+	 * pointer on return
+	 */
+	err = cscfg_file_read_elem_hdr(buffer, buflen, &used, &elem_hdr);
+	if (err)
+		return err;
+	if (elem_hdr.elem_type != CSCFG_FILE_ELEM_TYPE_FEAT)
+		return -EINVAL;
+
+	/* read the feature name */
+	err = cscfg_file_read_elem_str(buffer, buflen, &used, elem_str);
+	if (err)
+		return err;
+	*buf_used = used;
+
+	return 0;
+}
+
+/*
+ * Read a buffer and create the configuration and feature
+ * descriptors to load into the cscfg system
+ */
+int cscfg_file_read_buffer(const u8 *buffer, const int buflen,
+			   struct cscfg_fs_load_descs *desc_arrays)
+{
+	struct cscfg_file_header hdr;
+	int used = 0, err, i;
+
+	/* read in the file header */
+	err = cscfg_file_read_hdr(buffer, buflen, &used, &hdr);
+	if (err)
+		return err;
+
+	/* allocate the memory for the descriptor pointer arrays */
+	err = cscfg_file_alloc_desc_arrays(desc_arrays, hdr.nr_features, hdr.nr_configs);
+	if (err)
+		return err;
+
+	/* read elements */
+
+	/* first elements are configurations */
+	for (i = 0; i < hdr.nr_configs; i++) {
+		err = cscfg_file_read_elem_config(buffer, buflen, &used, desc_arrays, i);
+		if (err)
+			return err;
+	}
+
+	/* now read and populate all the feature descriptors */
+	for (i = 0; i < hdr.nr_features; i++) {
+		err = cscfg_file_read_elem_feature(buffer, buflen, &used, desc_arrays, i);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+int cscfg_file_read_buffer_first_name(const u8 *buffer, const int buflen,
+				      const char **name)
+{
+	struct cscfg_file_header hdr;
+	struct cscfg_file_elem_str elem_str;
+	int used = 0, err = 0;
+
+	*name = NULL;
+
+	/* read in the file header */
+	err = cscfg_file_read_hdr(buffer, buflen, &used, &hdr);
+	if (err)
+		return err;
+
+	err = cscfg_file_read_elem_config_name(buffer, buflen, &used, &elem_str);
+	if (err)
+		return err;
+
+	/* no config string - get first feature name */
+	if (!elem_str.str_len) {
+		err = cscfg_file_read_elem_feat_name(buffer, buflen, &used, &elem_str);
+		if (err)
+			return err;
+	}
+	if (elem_str.str_len)
+		*name = elem_str.str;
+	return err;
+}
+
+/*
+ * Need to free up the dynamically allocated descriptor arrays on unload
+ * as the memory used could be significant if many configurations are loaded
+ * and unloaded while the machine is operational.
+ *
+ * This frees up all the memory allocated by this file during the load process.
+ */
+void cscfg_file_free_load_descs(struct cscfg_fs_load_descs *desc_arrays)
+{
+	int i = 0;
+
+	if (!desc_arrays)
+		return;
+
+	/* free up each of the config descriptors */
+	while (desc_arrays->config_descs[i]) {
+		cscfg_file_free_config_desc(desc_arrays->config_descs[i]);
+		i++;
+	}
+
+	/* free up each of the feature descriptors */
+	i = 0;
+	while (desc_arrays->feat_descs[i]) {
+		cscfg_file_free_feat_desc(desc_arrays->feat_descs[i]);
+		i++;
+	}
+
+	/* finally free up the load descs pointer arrays */
+	kfree(desc_arrays->config_descs);
+	kfree(desc_arrays->feat_descs);
+}
diff --git a/drivers/hwtracing/coresight/coresight-config-file.h b/drivers/hwtracing/coresight/coresight-config-file.h
new file mode 100644
index 000000000000..6e8d259dfaaa
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-config-file.h
@@ -0,0 +1,139 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020-2022 Linaro Limited, All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+
+#ifndef _CORESIGHT_CORESIGHT_CONFIG_FILE_H
+#define _CORESIGHT_CORESIGHT_CONFIG_FILE_H
+
+#include <linux/sizes.h>
+
+#include "coresight-config.h"
+
+/*
+ * Structures to represent configuration descriptors in a memory buffer
+ * to serialise to and from files
+ *
+ * File structure - for loading configuration(s) + feature(s)
+ * from configfs.
+ *
+ * [cscfg_file_header]	- mandatory
+ * [CONFIG_ELEM] * [cscfg_file_header.nr_configs] - optional.
+ * [FEATURE_ELEM] * [cscfg_file_header.nr_features] - optional.
+ *
+ * File valid if it has both config(s) and feature(s), only config(s)
+ * or only feature(s).
+ * Invalid file if no config or features.
+ *
+ * File structure for [CONFIG_ELEM]:
+ *
+ * [cscfg_file_elem_header] - header length value to end of feature strings.
+ * [cscfg_file_elem_str]    - name of the configuration
+ * [cscfg_file_elem_str]    - description of configuration
+ * [u16 value - nr_presets] - number of sets of presets supplied
+ * [u32 value - nr_total_params] - total of all params in referenced features
+ * [u16 value - nr_feat_refs] - number of features selected by this configuration
+ * [u64 values] * (nr_presets * nr_total_params)
+ * [cscfg_file_elem_str] * nr_feat_refs - names of features selected by configuration.
+ *
+ *  A configuration must reference at least one feature.
+ *  Referenced features may be in this file, or have been loaded previously.
+ *
+ * File structure for a [FEATURE_ELEM]
+ *
+ * [cscfg_file_elem_header] - header length is total bytes to end of param structures.
+ * [cscfg_file_elem_str]    - feature name.
+ * [cscfg_file_elem_str]    - feature description.
+ * [u32 value: match_flags]
+ * [u16 value: nr_regs]	    - number of registers.
+ * [u16 value: nr_params]   - number of parameters.
+ * [cscfg_regval_desc struct] * nr_regs
+ * [PARAM_ELEM] * nr_params
+ *
+ * File structure for [PARAM_ELEM]
+ *
+ * [cscfg_file_elem_str]    - parameter name.
+ * [u64 value: param_value] - initial value.
+ */
+
+/* major element types - configurations and features */
+
+#define CSCFG_FILE_ELEM_TYPE_FEAT	0x1
+#define CSCFG_FILE_ELEM_TYPE_CFG	0x2
+
+#define CSCFG_FILE_MAGIC_VERSION	0xC5CF0001
+
+#define CSCFG_FILE_U32_TO_REG_DESC_INFO(val32, p_desc) \
+	{ \
+	p_desc->type = (val32 >> 24) & 0xFF; \
+	p_desc->offset = (val32 >> 12) & 0xFFF; \
+	p_desc->hw_info = val32 & 0xFFF; \
+	}
+
+#define CSCFG_FILE_REG_DESC_INFO_TO_U32(val32, p_desc) \
+	{ \
+	val32 = p_desc->hw_info & 0xFFF; \
+	val32 |= ((p_desc->offset & 0xFFF) << 12); \
+	val32 |= ((p_desc->type & 0xFF) << 24); \
+	}
+
+/*
+ * Binary attributes in configfs need a max size, as an internal buffer is declared,
+ * and will not be exceeded to prevent kernel OOM errors / attacks.
+ *
+ * Use a value that will reasonably cover all the usable & programmable registers in
+ * an ETM, the most complex device we have.
+ */
+#define CSCFG_FILE_MAXSIZE	SZ_16K
+
+/* limit string sizes - used for descriptions and names. */
+#define CSCFG_FILE_STR_MAXSIZE	SZ_1K
+
+/**
+ * file header.
+ *
+ * @magic_version: magic number / version for file/buffer format.
+ * @length       : total length of all data in the buffer.
+ * @nr_configs	 : total number of configs in the buffer.
+ * @nr_features  : total number of features in the buffer.
+ */
+struct cscfg_file_header {
+	u32 magic_version;
+	u16 length;
+	u16 nr_configs;
+	u16 nr_features;
+};
+
+/**
+ * element header
+ *
+ * @elem_length: total length of this element
+ * @elem_type  : type of this element - one of CSCFG_FILE_ELEM_TYPE.. defines.
+ */
+struct cscfg_file_elem_header {
+	u16 elem_length;
+	u8 elem_type;
+};
+
+/**
+ * string file element.
+ *
+ * @str_len: length of string buffer including 0 terminator
+ * @str    : string buffer - 0 terminated.
+ */
+struct cscfg_file_elem_str {
+	u16 str_len;
+	char *str;
+};
+
+/* kernel configfs needs to read the incoming file buffers to load. */
+int cscfg_file_read_buffer(const u8 *buffer, const int buflen,
+			   struct cscfg_fs_load_descs *desc_arrays);
+/* to unload we just need the first name - config or first feature */
+int cscfg_file_read_buffer_first_name(const u8 *buffer, const int buflen,
+				      const char **name);
+/* on unload we need to free up memory allocated on read */
+void cscfg_file_free_load_descs(struct cscfg_fs_load_descs *desc_arrays);
+
+#endif /* _CORESIGHT_CORESIGHT_CONFIG_FILE_H */
diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
index 6ba013975741..ad212954f99e 100644
--- a/drivers/hwtracing/coresight/coresight-config.h
+++ b/drivers/hwtracing/coresight/coresight-config.h
@@ -85,6 +85,21 @@ struct cscfg_regval_desc {
 	};
 };
 
+/**
+ * Dynamically loaded descriptor arrays loaded via configfs.
+ *
+ * For builtin or module loaded configurations / features these are
+ * statically defined at compile time. For configfs we create the arrays
+ * dynamically so need a structure to handle this.
+ *
+ * @config_descs:	array of config descriptor pointers.
+ * @feat_descs:		array of feature descriptor pointers.
+ */
+struct cscfg_fs_load_descs {
+	struct cscfg_config_desc **config_descs;
+	struct cscfg_feature_desc **feat_descs;
+};
+
 /**
  * Device feature descriptor - combination of registers and parameters to
  * program a device to implement a specific complex function.
diff --git a/drivers/hwtracing/coresight/coresight-syscfg.h b/drivers/hwtracing/coresight/coresight-syscfg.h
index 66e2db890d82..d0c9543850c0 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.h
+++ b/drivers/hwtracing/coresight/coresight-syscfg.h
@@ -79,6 +79,7 @@ struct cscfg_registered_csdev {
 enum cscfg_load_owner_type {
 	CSCFG_OWNER_PRELOAD,
 	CSCFG_OWNER_MODULE,
+	CSCFG_OWNER_CONFIGFS,
 };
 
 /**
-- 
2.17.1

