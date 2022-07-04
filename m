Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E80565A24
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbiGDPnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiGDPnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:43:01 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D131181F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 08:42:57 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id j7so5632048wmp.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 08:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RmgxoFmAK1lGXsXs9iowY+s/Fw48xVbsAB2msMG7gcs=;
        b=CRAxHSZWECkI+8JmvQqg8gGqUoFj/OKwNtNcxNLbCUjTUgR73GcyLeFWdtbtUtV9UC
         v3MBNquVA1bghgZKr8NSanryX4+crXIiSTIz7C+c/f+zISaq6WBsAH/KHOl8l1bviDf9
         /PGkHEoLDRYZypjXyMsSPi0ImxVndHc34/lFgoDrri5hlJsHdsxikq9YaiXNaL50lHrJ
         TsZ77kViZlzXRWJi+NWUG6Ste2rUfO+twzdq5RhA7Qd/eeB1JCzQntEfonqoaQAPOYkG
         66YhGHRJLOAZLajiE/e7WlWpa1ZcfYA5vU4q2uHJwHO3icKaDT1LKbbeBcHzQBfJmlbG
         YTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RmgxoFmAK1lGXsXs9iowY+s/Fw48xVbsAB2msMG7gcs=;
        b=MYzz1P0Xqxne6MQI5zRK83pSOUZ2cFwuvh/E1Jtrm52cY6NXO3mKvALADUtEtfJGoN
         FzIGn3LGqD5RTvyWvWUvmn+LKLhLSiD4pL7/vxRpAocS/x5tE62vsmu1s/ldBE+NvHRT
         Ck4kA4UK0ERSd7dMOm6RFE86VVE547b4mePH9dGtFQWUZ6frzxHDvVY9Z8lzHm3aZx/F
         IHvFkBQmufswrmJFfmUqdunJ3vVQdjgE9PuTEjnyvosuMJ6xYppRwG4+FGWG6z1+Xytt
         A6huVsiO53Wx+EJqO0GI8xfbVSSakUjDJUBc7XLZjAxizX9+OGxisoJxV3zobi6VeBpv
         RKog==
X-Gm-Message-State: AJIora8HpvZeJ4OPxpleFH6wJQG5fTiwScT2e/MY6V+5+lbwL8RGQzIM
        oNeeBH62NV44an9qNI1JonDbvw==
X-Google-Smtp-Source: AGRyM1sYDuxHlkafEGY1qCgU81DWHCguKFgZ0wXw0XVNsQ/6bqVT5gHDvgUBAEDrQwAt75L7JvjdxQ==
X-Received: by 2002:a05:600c:1d95:b0:3a0:3cf1:5eb4 with SMTP id p21-20020a05600c1d9500b003a03cf15eb4mr31882325wms.50.1656949375949;
        Mon, 04 Jul 2022 08:42:55 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:a9e8:9fdd:fa2d:1c72])
        by smtp.gmail.com with ESMTPSA id j6-20020adfff86000000b0021d6b851ca1sm2763749wrr.111.2022.07.04.08.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 08:42:55 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        leo.yan@linaro.org, acme@kernel.org, james.clark@arm.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v4 5/7] coresight: tools: Add config file write and reader tools
Date:   Mon,  4 Jul 2022 16:42:47 +0100
Message-Id: <20220704154249.11501-6-mike.leach@linaro.org>
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

Add an example file generator to test loading configurations via a
binary attribute in configfs.

Provides a file buffer writer function that can be re-used in other
userspace programs.

Buffer write format matches that expected by the corresponding reader
in the configfs driver code.

Add a config file reader and printer. Takes in config files and prints
the contents. Uses file reader source from kernel driver.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 MAINTAINERS                                   |   1 +
 .../coresight/coresight-config-file.c         |   2 +
 tools/coresight/Makefile                      |  52 +++
 tools/coresight/coresight-cfg-bufw.c          | 309 ++++++++++++++++++
 tools/coresight/coresight-cfg-bufw.h          |  26 ++
 tools/coresight/coresight-cfg-example1.c      |  62 ++++
 tools/coresight/coresight-cfg-example2.c      |  95 ++++++
 tools/coresight/coresight-cfg-examples.h      |  22 ++
 tools/coresight/coresight-cfg-file-gen.c      |  61 ++++
 tools/coresight/coresight-cfg-file-read.c     | 227 +++++++++++++
 tools/coresight/coresight-config-uapi.h       |  76 +++++
 11 files changed, 933 insertions(+)
 create mode 100644 tools/coresight/Makefile
 create mode 100644 tools/coresight/coresight-cfg-bufw.c
 create mode 100644 tools/coresight/coresight-cfg-bufw.h
 create mode 100644 tools/coresight/coresight-cfg-example1.c
 create mode 100644 tools/coresight/coresight-cfg-example2.c
 create mode 100644 tools/coresight/coresight-cfg-examples.h
 create mode 100644 tools/coresight/coresight-cfg-file-gen.c
 create mode 100644 tools/coresight/coresight-cfg-file-read.c
 create mode 100644 tools/coresight/coresight-config-uapi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 171563d8dc14..0cb75b1186c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1989,6 +1989,7 @@ F:	drivers/hwtracing/coresight/*
 F:	include/dt-bindings/arm/coresight-cti-dt.h
 F:	include/linux/coresight*
 F:	samples/coresight/*
+F:	tools/coresight/*
 F:	tools/perf/arch/arm/util/auxtrace.c
 F:	tools/perf/arch/arm/util/cs-etm.c
 F:	tools/perf/arch/arm/util/cs-etm.h
diff --git a/drivers/hwtracing/coresight/coresight-config-file.c b/drivers/hwtracing/coresight/coresight-config-file.c
index cf9f178eef97..43aaa44e86d5 100644
--- a/drivers/hwtracing/coresight/coresight-config-file.c
+++ b/drivers/hwtracing/coresight/coresight-config-file.c
@@ -39,6 +39,8 @@ static void cscfg_free(void *mem)
 #include <string.h>
 #include <stdlib.h>
 
+#include "coresight-config-uapi.h"
+
 static void *cscfg_calloc(size_t num, size_t size)
 {
 	return calloc(num, size);
diff --git a/tools/coresight/Makefile b/tools/coresight/Makefile
new file mode 100644
index 000000000000..584e2271b0f5
--- /dev/null
+++ b/tools/coresight/Makefile
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0-only
+include ../scripts/Makefile.include
+include ../scripts/Makefile.arch
+
+# Makefile to build the coresight configuration file reader and generator tools
+
+this-makefile := $(lastword $(MAKEFILE_LIST))
+tools-src := $(realpath $(dir $(this-makefile)))
+srctree := $(realpath $(dir $(tools-src)/../../.))
+
+# ensure we use all as the default - skip anything in included Makefile
+.DEFAULT_GOAL = all
+# MAKECMDGOALS isn't set if there's no explicit goal in the
+# command line, so set the default.
+MAKECMDGOALS ?= $(.DEFAULT_GOAL)
+
+# compile flags
+CFLAGS += $(CPPFLAGS) -c -Wall -DLINUX -Wno-switch -Wlogical-op -fPIC -I$(srctree)/drivers/hwtracing/coresight -I$(srctree)/tools/include/  -I$(srctree)/tools/include/uapi
+
+# object files
+coresight-cfg-file-gen-objs := coresight-cfg-file-gen.o coresight-cfg-bufw.o \
+				coresight-cfg-example1.o coresight-cfg-example2.o
+coresight-cfg-file-read-objs := coresight-cfg-file-read.o coresight-config-file.o
+
+# debug variant
+ifdef DEBUG
+CFLAGS += -g -O0 -DDEBUG
+else
+CFLAGS += -O2 -DNDEBUG
+endif
+
+.PHONY: all
+all:  coresight-cfg-file-gen coresight-cfg-file-read
+
+coresight-config-file.o: src_copy
+	$(CC) $(CFLAGS) coresight-config-file.c -o coresight-config-file.o
+
+.PHONY: src_copy
+src_copy:
+	@cp $(srctree)/drivers/hwtracing/coresight/coresight-config-file.c $(srctree)/tools/coresight/.
+
+coresight-cfg-file-gen: $(coresight-cfg-file-gen-objs)
+	$(CC) $(LDFLAGS) $(coresight-cfg-file-gen-objs) -o coresight-cfg-file-gen
+
+coresight-cfg-file-read: $(coresight-cfg-file-read-objs)
+	$(CC) $(LDFLAGS) $(coresight-cfg-file-read-objs) -o coresight-cfg-file-read
+
+clean:
+	rm -f coresight-cfg-file-gen coresight-cfg-file-read
+	rm -f *.o
+	rm -f coresight-config-file.c
+	rm -f *.cscfg
diff --git a/tools/coresight/coresight-cfg-bufw.c b/tools/coresight/coresight-cfg-bufw.c
new file mode 100644
index 000000000000..891fff4e3264
--- /dev/null
+++ b/tools/coresight/coresight-cfg-bufw.c
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020-2022 Linaro Limited, All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+
+#include <string.h>
+
+#include "coresight-cfg-bufw.h"
+#include "coresight-config-uapi.h"
+
+/*
+ * Set of macros to make writing the buffer code easier.
+ *.
+ * Uses naming convention as 'buffer' for the buffer pointer and
+ * 'used' as the current bytes used by the encosing function.
+ */
+#define cscfg_write_u64(val64) { \
+	*(u64 *)(buffer + used) = val64; \
+	used += sizeof(u64); \
+	}
+
+#define cscfg_write_u32(val32) { \
+	*(u32 *)(buffer + used) = val32; \
+	used += sizeof(u32); \
+	}
+
+#define cscfg_write_u16(val16) { \
+	*(u16 *)(buffer + used) = val16; \
+	used += sizeof(u16); \
+	}
+
+#define cscfg_write_u8(val8) { \
+	*(buffer + used) = val8; \
+	used++;	\
+	}
+
+#define CHECK_WRET(rval) { \
+	if (rval < 0) \
+		return rval; \
+	used += rval; \
+	}
+
+/* write the header at the start of the buffer */
+static int cscfg_file_write_fhdr(u8 *buffer, const int buflen,
+				 const struct cscfg_file_header *fhdr)
+{
+	int used = 0;
+
+	cscfg_write_u32(fhdr->magic_version);
+	cscfg_write_u16(fhdr->length);
+	cscfg_write_u16(fhdr->nr_configs);
+	cscfg_write_u16(fhdr->nr_features);
+	return used;
+}
+
+static int cscfg_file_write_string(u8 *buffer, const int buflen, const char *string)
+{
+	int len, used = 0;
+
+	len = strlen(string);
+	if (len > CSCFG_FILE_STR_MAXSIZE)
+		return -EINVAL;
+
+	if (buflen < (len + 1 + sizeof(u16)))
+		return -EINVAL;
+
+	cscfg_write_u16((u16)(len + 1));
+	strcpy((char *)(buffer + used), string);
+	used += (len + 1);
+
+	return used;
+}
+
+static int cscfg_file_write_elem_hdr(u8 *buffer, const int buflen,
+				     struct cscfg_file_elem_header *ehdr)
+{
+	int used = 0;
+
+	if (buflen < (sizeof(u16) + sizeof(u8)))
+		return -EINVAL;
+
+	cscfg_write_u16(ehdr->elem_length);
+	cscfg_write_u8(ehdr->elem_type);
+
+	return used;
+}
+
+static int cscfg_file_write_config(u8 *buffer, const int buflen,
+				   struct cscfg_config_desc *config_desc)
+{
+	int used = 0, bytes_w, space_req, preset_bytes, i;
+	struct cscfg_file_elem_header ehdr;
+
+	ehdr.elem_length = 0;
+	ehdr.elem_type = CSCFG_FILE_ELEM_TYPE_CFG;
+
+	/* write element header at current buffer location */
+	bytes_w = cscfg_file_write_elem_hdr(buffer, buflen, &ehdr);
+	CHECK_WRET(bytes_w);
+
+	/* write out the configuration name */
+	bytes_w = cscfg_file_write_string(buffer + used, buflen - used,
+					  config_desc->name);
+	CHECK_WRET(bytes_w);
+
+	/* write out the description string */
+	bytes_w = cscfg_file_write_string(buffer + used, buflen - used,
+					  config_desc->description);
+	CHECK_WRET(bytes_w);
+
+	/*
+	 * calculate the space needed for variables + presets
+	 * [u16 value - nr_presets]
+	 * [u32 value - nr_total_params]
+	 * [u16 value - nr_feat_refs]
+	 * [u64 values] * (nr_presets * nr_total_params)
+	 */
+	preset_bytes = sizeof(u64) * config_desc->nr_presets * config_desc->nr_total_params;
+	space_req = (sizeof(u16) * 2) + sizeof(u32) + preset_bytes;
+
+	if ((buflen - used) < space_req)
+		return -EINVAL;
+
+	cscfg_write_u16((u16)config_desc->nr_presets);
+	cscfg_write_u32((u32)config_desc->nr_total_params);
+	cscfg_write_u16((u16)config_desc->nr_feat_refs);
+	if (preset_bytes) {
+		memcpy(buffer + used, (u8 *)config_desc->presets, preset_bytes);
+		used += preset_bytes;
+	}
+
+	/* now write the feature ref names */
+	for (i = 0; i < config_desc->nr_feat_refs; i++) {
+		bytes_w = cscfg_file_write_string(buffer + used, buflen - used,
+						  config_desc->feat_ref_names[i]);
+		CHECK_WRET(bytes_w);
+	}
+
+	/* rewrite the element header with the correct length */
+	ehdr.elem_length = used;
+	bytes_w = cscfg_file_write_elem_hdr(buffer, buflen, &ehdr);
+	/* no CHECK_WRET as used must not be updated */
+	if (bytes_w < 0)
+		return bytes_w;
+
+	return used;
+}
+
+/*
+ * write a parameter structure into the buffer in following format:
+ * [cscfg_file_elem_str]    - parameter name.
+ * [u64 value: param_value] - initial value.
+ */
+static int cscfg_file_write_param(u8 *buffer, const int buflen,
+				  struct cscfg_parameter_desc *param_desc)
+{
+	int used = 0, bytes_w;
+
+	bytes_w = cscfg_file_write_string(buffer + used, buflen - used,
+					  param_desc->name);
+	CHECK_WRET(bytes_w);
+
+	if ((buflen - used) < sizeof(u64))
+		return -EINVAL;
+
+	cscfg_write_u64(param_desc->value);
+	return used;
+}
+
+/*
+ * Write a feature element from cscfg_feature_desc in following format:
+ *
+ * [cscfg_file_elem_header] - header length is total bytes to end of param structures.
+ * [cscfg_file_elem_str]    - feature name.
+ * [cscfg_file_elem_str]    - feature description.
+ * [u32 value: match_flags]
+ * [u16 value: nr_regs]	    - number of registers.
+ * [u16 value: nr_params]   - number of parameters.
+ * [cscfg_regval_desc struct] * nr_regs
+ * [PARAM_ELEM] * nr_params
+ */
+static int cscfg_file_write_feat(u8 *buffer, const int buflen,
+				 struct cscfg_feature_desc *feat_desc)
+{
+	struct cscfg_file_elem_header ehdr;
+	struct cscfg_regval_desc *p_reg_desc;
+	int used = 0, bytes_w, i, space_req;
+	u32 val32;
+
+	ehdr.elem_length = 0;
+	ehdr.elem_type = CSCFG_FILE_ELEM_TYPE_FEAT;
+
+	/* write element header at current buffer location */
+	bytes_w = cscfg_file_write_elem_hdr(buffer, buflen, &ehdr);
+	CHECK_WRET(bytes_w);
+
+	/* write out the name string */
+	bytes_w = cscfg_file_write_string(buffer + used, buflen - used,
+					  feat_desc->name);
+	CHECK_WRET(bytes_w)
+
+	/* write out the description string */
+	bytes_w = cscfg_file_write_string(buffer + used, buflen - used,
+					  feat_desc->description);
+	CHECK_WRET(bytes_w);
+
+	/* check for space for variables and register structures */
+	space_req = (sizeof(u16) * 2) + sizeof(u32) +
+		(sizeof(struct cscfg_regval_desc) * feat_desc->nr_regs);
+	if ((buflen - used) < space_req)
+		return -EINVAL;
+
+	/* write the variables */
+	cscfg_write_u32((u32)feat_desc->match_flags);
+	cscfg_write_u16((u16)feat_desc->nr_regs);
+	cscfg_write_u16((u16)feat_desc->nr_params);
+
+	/*write the registers */
+	for (i = 0; i < feat_desc->nr_regs; i++) {
+		p_reg_desc = (struct cscfg_regval_desc *)&feat_desc->regs_desc[i];
+		CSCFG_FILE_REG_DESC_INFO_TO_U32(val32, p_reg_desc);
+		cscfg_write_u32(val32);
+		cscfg_write_u64(feat_desc->regs_desc[i].val64);
+	}
+
+	/* write any parameters */
+	for (i = 0; i < feat_desc->nr_params; i++) {
+		bytes_w = cscfg_file_write_param(buffer + used, buflen - used,
+						 &feat_desc->params_desc[i]);
+		CHECK_WRET(bytes_w);
+	}
+
+	/*
+	 * rewrite the element header at the start of the buffer block
+	 * with the correct length
+	 */
+	ehdr.elem_length = used;
+	bytes_w = cscfg_file_write_elem_hdr(buffer, buflen, &ehdr);
+	/* no CHECK_WRET as used must not be updated */
+	if (bytes_w < 0)
+		return bytes_w;
+
+	return used;
+}
+
+/*
+ * write a buffer from the configuration and feature
+ * descriptors to write into a file for configfs.
+ *
+ * Will only write one config, and/or a number of features,
+ * per the file standard.
+ */
+int cscfg_file_write_buffer(u8 *buffer, const int buflen,
+			    struct cscfg_config_desc **config_descs,
+			    struct cscfg_feature_desc **feat_descs)
+{
+	struct cscfg_file_header fhdr;
+	int used = 0,  bytes_w, i;
+
+	/* init the file header */
+	fhdr.magic_version = CSCFG_FILE_MAGIC_VERSION;
+	fhdr.length = 0;
+	fhdr.nr_configs = 0;
+	fhdr.nr_features = 0;
+
+	/* count the configs */
+	if (config_descs) {
+		while (config_descs[fhdr.nr_configs])
+			fhdr.nr_configs++;
+	}
+
+	/* count the features */
+	if (feat_descs) {
+		while (feat_descs[fhdr.nr_features])
+			fhdr.nr_features++;
+	}
+
+	/* need a buffer and at least one config or feature */
+	if ((!fhdr.nr_configs && !fhdr.nr_features) ||
+	    !buffer || (buflen > CSCFG_FILE_MAXSIZE))
+		return -EINVAL;
+
+	/* write a header at the start to get the length of the header */
+	bytes_w = cscfg_file_write_fhdr(buffer, buflen, &fhdr);
+	CHECK_WRET(bytes_w);
+
+	/* write configs */
+	for (i = 0; i < fhdr.nr_configs; i++) {
+		bytes_w = cscfg_file_write_config(buffer + used, buflen - used,
+						  config_descs[i]);
+		CHECK_WRET(bytes_w);
+	}
+
+	/* write any features */
+	for (i = 0; i < fhdr.nr_features; i++) {
+		bytes_w = cscfg_file_write_feat(buffer + used, buflen - used,
+						feat_descs[i]);
+		CHECK_WRET(bytes_w);
+	}
+
+	/* finally re-write the header at the buffer start with the correct length */
+	fhdr.length = (u16)used;
+	bytes_w = cscfg_file_write_fhdr(buffer, buflen, &fhdr);
+	/* no CHECK_WRET as used must not be updated */
+	if (bytes_w < 0)
+		return bytes_w;
+	return used;
+}
diff --git a/tools/coresight/coresight-cfg-bufw.h b/tools/coresight/coresight-cfg-bufw.h
new file mode 100644
index 000000000000..08e0e796bf2e
--- /dev/null
+++ b/tools/coresight/coresight-cfg-bufw.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020-2022 Linaro Limited, All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+
+#ifndef _CORESIGHT_CFG_BUFW_H
+#define _CORESIGHT_CFG_BUFW_H
+
+#include <linux/types.h>
+
+#include "coresight-config-file.h"
+
+/*
+ * Function to take coresight configurations and features and
+ * write them into a supplied memory buffer for serialisation
+ * into a file.
+ *
+ * Resulting file can then be loaded into the coresight
+ * infrastructure via configfs.
+ */
+int cscfg_file_write_buffer(u8 *buffer, const int buflen,
+			    struct cscfg_config_desc **config_descs,
+			    struct cscfg_feature_desc **feat_descs);
+
+#endif /* _CORESIGHT_CFG_BUFW_H */
diff --git a/tools/coresight/coresight-cfg-example1.c b/tools/coresight/coresight-cfg-example1.c
new file mode 100644
index 000000000000..c562116ffc94
--- /dev/null
+++ b/tools/coresight/coresight-cfg-example1.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020-2022 Linaro Limited, All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+#include <linux/types.h>
+#include <linux/unistd.h>
+#include <stdio.h>
+#include <unistd.h>
+
+#include "coresight-cfg-examples.h"
+
+/*
+ * create a configuration only example using the strobing feature
+ */
+
+/* we will provide 4 sets of preset parameter values */
+#define AFDO3_NR_PRESETS	4
+/* the total number of parameters in used features - strobing has 2 */
+#define AFDO3_NR_PARAM_SUM	2
+
+static const char *afdo3_ref_names[] = {
+	"strobing",
+};
+
+/*
+ * set of presets leaves strobing window constant while varying period to allow
+ * experimentation with mark / space ratios for various workloads
+ */
+static u64 afdo3_presets[AFDO3_NR_PRESETS][AFDO3_NR_PARAM_SUM] = {
+	{ 2000, 100 },
+	{ 2000, 1000 },
+	{ 2000, 5000 },
+	{ 2000, 10000 },
+};
+
+struct cscfg_config_desc afdo3 = {
+	.name = "autofdo3",
+	.description = "Setup ETMs with strobing for autofdo\n"
+	"Supplied presets allow experimentation with mark-space ratio for various loads\n",
+	.nr_feat_refs = ARRAY_SIZE(afdo3_ref_names),
+	.feat_ref_names = afdo3_ref_names,
+	.nr_presets = AFDO3_NR_PRESETS,
+	.nr_total_params = AFDO3_NR_PARAM_SUM,
+	.presets = &afdo3_presets[0][0],
+};
+
+static struct cscfg_feature_desc *sample_feats[] = {
+	NULL
+};
+
+static struct cscfg_config_desc *sample_cfgs[] = {
+	&afdo3,
+	NULL
+};
+
+struct cscfg_file_eg_info file_info_eg1 = {
+	.example_name = "example1",
+	.filename = "example1.cscfg",
+	.config_descs = sample_cfgs,
+	.feat_descs = sample_feats,
+};
diff --git a/tools/coresight/coresight-cfg-example2.c b/tools/coresight/coresight-cfg-example2.c
new file mode 100644
index 000000000000..6312a185bd46
--- /dev/null
+++ b/tools/coresight/coresight-cfg-example2.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020-2022 Linaro Limited, All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+#include <linux/types.h>
+#include <linux/unistd.h>
+#include <stdio.h>
+#include <unistd.h>
+
+#include "coresight-cfg-examples.h"
+
+/*
+ * create a dual configuration only example using the strobing feature
+ */
+
+/* we will provide 10 sets of preset parameter values */
+#define AFDO_NR_PRESETS		10
+/* the total number of parameters in used features - strobing has 2 */
+#define AFDO_NR_PARAM_SUM	2
+
+static const char *afdo_ref_names[] = {
+	"strobing",
+};
+
+/*
+ * sets of presets leaves strobing window constant while varying period to allow
+ * experimentation with mark / space ratios for various workloads
+ */
+static u64 afdo_set_a_presets[AFDO_NR_PRESETS][AFDO_NR_PARAM_SUM] = {
+	{ 2000, 100 },
+	{ 2000, 1000 },
+	{ 2000, 5000 },
+	{ 2000, 10000 },
+	{ 4000, 100 },
+	{ 4000, 1000 },
+	{ 4000, 5000 },
+	{ 4000, 10000 },
+	{ 6000, 100 },
+	{ 6000, 1000 },
+};
+
+
+static u64 afdo_set_b_presets[AFDO_NR_PRESETS][AFDO_NR_PARAM_SUM] = {
+	{ 6000, 5000 },
+	{ 6000, 10000 },
+	{ 8000, 100 },
+	{ 8000, 1000 },
+	{ 8000, 5000 },
+	{ 8000, 10000 },
+	{ 12000, 100 },
+	{ 12000, 1000 },
+	{ 12000, 5000 },
+	{ 12000, 10000 },
+};
+/* two configurations with differing preset tables */
+struct cscfg_config_desc afdo_seta = {
+	.name = "autofdo_set_a",
+	.description = "Setup ETMs with strobing for autofdo\n"
+	"Supplied presets allow experimentation with mark-space ratio for various loads\n",
+	.nr_feat_refs = ARRAY_SIZE(afdo_ref_names),
+	.feat_ref_names = afdo_ref_names,
+	.nr_presets = AFDO_NR_PRESETS,
+	.nr_total_params = AFDO_NR_PARAM_SUM,
+	.presets = &afdo_set_a_presets[0][0],
+};
+
+struct cscfg_config_desc afdo_setb = {
+	.name = "autofdo_set_b",
+	.description = "Setup ETMs with strobing for autofdo\n"
+	"Supplied presets allow experimentation with mark-space ratio for various loads\n",
+	.nr_feat_refs = ARRAY_SIZE(afdo_ref_names),
+	.feat_ref_names = afdo_ref_names,
+	.nr_presets = AFDO_NR_PRESETS,
+	.nr_total_params = AFDO_NR_PARAM_SUM,
+	.presets = &afdo_set_b_presets[0][0],
+};
+
+
+static struct cscfg_feature_desc *sample_feats[] = {
+	NULL
+};
+
+static struct cscfg_config_desc *sample_cfgs[] = {
+	&afdo_seta,
+	&afdo_setb,
+	NULL
+};
+
+struct cscfg_file_eg_info file_info_eg2 = {
+	.example_name = "example2",
+	.filename = "example2.cscfg",
+	.config_descs = sample_cfgs,
+	.feat_descs = sample_feats,
+};
diff --git a/tools/coresight/coresight-cfg-examples.h b/tools/coresight/coresight-cfg-examples.h
new file mode 100644
index 000000000000..a13e1553b271
--- /dev/null
+++ b/tools/coresight/coresight-cfg-examples.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020-2022 Linaro Limited, All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+
+#ifndef _CORESIGHT_CFG_EXAMPLES_H
+#define _CORESIGHT_CFG_EXAMPLES_H
+
+#include <linux/kernel.h>
+
+#include "coresight-config-uapi.h"
+
+/* structure to pass configuraiton information to generator program */
+struct cscfg_file_eg_info {
+	const char *example_name;
+	const char *filename;
+	struct cscfg_config_desc **config_descs;
+	struct cscfg_feature_desc **feat_descs;
+};
+
+#endif /* _CORESIGHT_CFG_EXAMPLES_H */
diff --git a/tools/coresight/coresight-cfg-file-gen.c b/tools/coresight/coresight-cfg-file-gen.c
new file mode 100644
index 000000000000..0840732dbd50
--- /dev/null
+++ b/tools/coresight/coresight-cfg-file-gen.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020-2022 Linaro Limited, All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+
+#include <linux/types.h>
+#include <linux/unistd.h>
+#include <stdio.h>
+#include <unistd.h>
+
+#include "coresight-cfg-examples.h"
+#include "coresight-cfg-bufw.h"
+
+/* references to the configuration and feature example structures */
+extern struct cscfg_file_eg_info file_info_eg1;
+extern struct cscfg_file_eg_info file_info_eg2;
+
+/* array of example files to generate */
+struct cscfg_file_eg_info *info_ptrs[] = {
+	&file_info_eg1,
+	&file_info_eg2,
+	NULL,
+};
+
+int main(int argc, char **argv)
+{
+	struct cscfg_config_desc **config_descs;
+	struct cscfg_feature_desc **feat_descs;
+	u8 buffer[CSCFG_FILE_MAXSIZE];
+	int used, idx = 0;
+	FILE *fp;
+	const char *filename;
+
+	printf("Coresight Configuration file Generator\n\n");
+
+	while (info_ptrs[idx]) {
+		printf("Generating %s example\n", info_ptrs[idx]->example_name);
+		config_descs = info_ptrs[idx]->config_descs;
+		feat_descs = info_ptrs[idx]->feat_descs;
+		filename = info_ptrs[idx]->filename;
+		used = cscfg_file_write_buffer(buffer, CSCFG_FILE_MAXSIZE,
+					       config_descs, feat_descs);
+
+		if (used < 0) {
+			printf("Error %d writing configuration %s into buffer\n",
+			       used, info_ptrs[idx]->example_name);
+			return used;
+		}
+
+		fp = fopen(filename, "wb");
+		if (fp == NULL) {
+			printf("Error opening file %s\n", filename);
+			return -1;
+		}
+		fwrite(buffer, used, sizeof(u8), fp);
+		fclose(fp);
+		idx++;
+	}
+	return 0;
+}
diff --git a/tools/coresight/coresight-cfg-file-read.c b/tools/coresight/coresight-cfg-file-read.c
new file mode 100644
index 000000000000..c808fb2747f9
--- /dev/null
+++ b/tools/coresight/coresight-cfg-file-read.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020-2022 Linaro Limited, All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+
+#include <linux/types.h>
+#include <linux/unistd.h>
+#include <ctype.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include "coresight-config-file.h"
+#include "coresight-config-uapi.h"
+
+/*
+ * tool to read and print a generated configuration
+ * re-uses the read code source from the driver.
+ */
+
+static void validate_config_name(const char *name)
+{
+	int i, len = strlen(name);
+
+	for (i = 0; i < len; i++) {
+		if (!isalnum(name[i]) && !(name[i] == '_')) {
+			printf("\n************************************************\n");
+			printf("ERROR: Configuration name %s invalid character(s)\n", name);
+			printf("     : must contain only alphanumeric and _ only\n");
+			printf("************************************************\n");
+		}
+	}
+}
+
+static void print_configs(struct cscfg_fs_load_descs *load_descs)
+{
+	struct cscfg_config_desc *config_desc;
+	int i, j, p, cfg_idx = 0;
+
+	config_desc = load_descs->config_descs[cfg_idx];
+	if (!config_desc) {
+		printf("File contains no configurations.\n\n");
+		return;
+	}
+
+	while (config_desc) {
+		printf("Configuration %d\nName:- %s\n", cfg_idx + 1, config_desc->name);
+		validate_config_name(config_desc->name);
+		printf("Description:-\n%s\n", config_desc->description);
+		printf("Uses %d features:-\n", config_desc->nr_feat_refs);
+		for (i = 0; i < config_desc->nr_feat_refs; i++)
+			printf("Feature-%d: %s\n", i + 1, config_desc->feat_ref_names[i]);
+
+		printf("\nProvides %d sets of preset values, %d presets per set\n",
+		       config_desc->nr_presets, config_desc->nr_total_params);
+		if (config_desc->nr_presets) {
+			for (i = 0; i < config_desc->nr_presets; i++) {
+				printf("set[%d]: ", i);
+				for (j = 0; j < config_desc->nr_total_params; j++) {
+					p = (i * config_desc->nr_total_params) + j;
+					printf("0x%lx, ",  config_desc->presets[p]);
+				}
+				printf("\n");
+			}
+		}
+		printf("\n============================================\n");
+		cfg_idx++;
+		config_desc = load_descs->config_descs[cfg_idx];
+	}
+}
+
+static void print_reg_type_info(u8 type)
+{
+	if (type & CS_CFG_REG_TYPE_STD)
+		printf("std_reg ");
+	if (type & CS_CFG_REG_TYPE_RESOURCE)
+		printf("resource ");
+	if (type & CS_CFG_REG_TYPE_VAL_PARAM)
+		printf("param_index ");
+	if (type & CS_CFG_REG_TYPE_VAL_64BIT)
+		printf("64_bit ");
+	else
+		printf("32_bit ");
+	if (type & CS_CFG_REG_TYPE_VAL_MASK)
+		printf("masked ");
+	if (type & CS_CFG_REG_TYPE_VAL_SAVE)
+		printf("save_on_disable ");
+
+}
+
+static void print_regs(int nr, struct cscfg_regval_desc *regs_desc_array)
+{
+	int i;
+	struct cscfg_regval_desc *reg_desc;
+	u8 type;
+	u16 offset;
+	u16 info;
+
+	for (i = 0; i < nr; i++) {
+		reg_desc = &regs_desc_array[i];
+		type = (u8)reg_desc->type;
+		offset = (u16)reg_desc->offset;
+		info = (u16)reg_desc->hw_info;
+
+		printf("Reg(%d): Type 0x%x: ", i, type);
+		print_reg_type_info(type);
+		printf("\nOffset: 0x%03x; HW Info: 0x%03x\n", offset, info);
+		printf("Value: ");
+		if (type & CS_CFG_REG_TYPE_VAL_64BIT)
+			printf("0x%lx\n", reg_desc->val64);
+		else if (type & CS_CFG_REG_TYPE_VAL_PARAM) {
+			printf("param(%d) ", reg_desc->param_idx);
+			if (type & (CS_CFG_REG_TYPE_VAL_MASK))
+				printf(" mask: 0x%x", reg_desc->mask32);
+			printf("\n");
+		} else {
+			printf("0x%x ", reg_desc->val32);
+			if (type & (CS_CFG_REG_TYPE_VAL_MASK))
+				printf(" mask: 0x%x", reg_desc->mask32);
+			printf("\n");
+		}
+	}
+}
+
+static void print_params(int nr, struct cscfg_parameter_desc *params_desc)
+{
+	int i;
+
+	for (i = 0; i < nr; i++)
+		printf("Param(%d) : %s; Init value 0x%lx\n", i,
+		       params_desc[i].name, params_desc[i].value);
+}
+
+static void print_features(struct cscfg_fs_load_descs *load_descs)
+{
+	struct cscfg_feature_desc *feat_desc = 0;
+	int idx = 0;
+
+	feat_desc = load_descs->feat_descs[idx];
+	if (!feat_desc) {
+		printf("File contains no features\n\n");
+		return;
+	}
+
+	while (feat_desc) {
+		printf("Feature %d\nName:- %s\n\n", idx + 1, feat_desc->name);
+		printf("Description:- %s\n", feat_desc->description);
+		printf("Match flags: 0x%x\n", feat_desc->match_flags);
+		printf("\nNumber of Paraneters: %d\n", feat_desc->nr_params);
+		if (feat_desc->nr_params)
+			print_params(feat_desc->nr_params, feat_desc->params_desc);
+		printf("\nNumber of Registers: %d\n", feat_desc->nr_regs);
+		if (feat_desc->nr_regs)
+			print_regs(feat_desc->nr_regs, feat_desc->regs_desc);
+		printf("\n============================================\n");
+
+		/* next feature */
+		idx++;
+		feat_desc = load_descs->feat_descs[idx];
+	}
+}
+
+int main(int argc, char **argv)
+{
+	FILE *fp;
+	struct cscfg_fs_load_descs *load_descs;
+	int err, fsize;
+	u8 buffer[CSCFG_FILE_MAXSIZE];
+
+	printf("CoreSight Configuration file reader");
+	printf("\n============================================\n\n");
+
+
+	/* need a filename */
+	if (argc <= 1) {
+		printf("Please provide filename on command line\n");
+		return -EINVAL;
+	}
+
+	/* open file and read into the buffer. */
+	fp = fopen(argv[1], "rb");
+	if (fp == NULL) {
+		printf("Error opening file %s\n", argv[1]);
+		return -EINVAL;
+	}
+
+	fseek(fp, 0, SEEK_END);
+	fsize = ftell(fp);
+	rewind(fp);
+	if (fsize > CSCFG_FILE_MAXSIZE) {
+		printf("Error: Input file too large.");
+		fclose(fp);
+		return -EINVAL;
+	}
+	err = fread(buffer, sizeof(u8), fsize, fp);
+	fclose(fp);
+
+	if (err < fsize) {
+		printf("Error reading file %s\n", argv[1]);
+		return -EINVAL;
+	}
+
+	/* allocate the descriptor structures to be populated by read operation */
+	load_descs = malloc(sizeof(struct cscfg_fs_load_descs));
+	if (!load_descs) {
+		printf("Error allocating load descs structure.\n");
+		return -ENOMEM;
+	}
+
+	/* read the buffer and create the configuration and feature structures */
+	err = cscfg_file_read_buffer(buffer, fsize, load_descs);
+	if (err) {
+		printf("Error reading configuration file\n");
+		goto exit_free_mem;
+	}
+
+	/* print the contents of the structures */
+	print_configs(load_descs);
+	print_features(load_descs);
+
+exit_free_mem:
+	cscfg_file_free_load_descs(load_descs);
+	free(load_descs);
+	return err;
+}
diff --git a/tools/coresight/coresight-config-uapi.h b/tools/coresight/coresight-config-uapi.h
new file mode 100644
index 000000000000..d051c01ea982
--- /dev/null
+++ b/tools/coresight/coresight-config-uapi.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020 Linaro Limited, All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+
+#ifndef _CORESIGHT_CORESIGHT_CONFIG_UAPI_H
+#define _CORESIGHT_CORESIGHT_CONFIG_UAPI_H
+
+#include <linux/types.h>
+#include <asm-generic/errno-base.h>
+
+#include "coresight-config.h"
+
+/*
+ * Userspace versions of the configuration and feature descriptors.
+ * Used in the tools/coresight programs.
+ *
+ * Compatible with structures in coresight-config.h for use in
+ * coresight-config-file.c common reader source file.
+ */
+
+/**
+ * Device feature descriptor - combination of registers and parameters to
+ * program a device to implement a specific complex function.
+ *
+ * UAPI version - removed kernel constructs.
+ *
+ * @name:	 feature name.
+ * @description: brief description of the feature.
+ * @match_flags: matching information if loading into a device
+ * @nr_params:   number of parameters used.
+ * @params_desc: array of parameters used.
+ * @nr_regs:	 number of registers used.
+ * @regs_desc:	 array of registers used.
+ */
+struct cscfg_feature_desc {
+	const char *name;
+	const char *description;
+	u32 match_flags;
+	int nr_params;
+	struct cscfg_parameter_desc *params_desc;
+	int nr_regs;
+	struct cscfg_regval_desc *regs_desc;
+};
+
+/**
+ * Configuration descriptor - describes selectable system configuration.
+ *
+ * A configuration describes device features in use, and may provide preset
+ * values for the parameters in those features.
+ *
+ * A single set of presets is the sum of the parameters declared by
+ * all the features in use - this value is @nr_total_params.
+ *
+ * UAPI version - removed kernel constructs.
+ *
+ * @name:		name of the configuration - used for selection.
+ * @description:	description of the purpose of the configuration.
+ * @nr_feat_refs:	Number of features used in this configuration.
+ * @feat_ref_names:	references to features used in this configuration.
+ * @nr_presets:		Number of sets of presets supplied by this configuration.
+ * @nr_total_params:	Sum of all parameters declared by used features
+ * @presets:		Array of preset values.
+ */
+struct cscfg_config_desc {
+	const char *name;
+	const char *description;
+	int nr_feat_refs;
+	const char **feat_ref_names;
+	int nr_presets;
+	int nr_total_params;
+	const u64 *presets; /* nr_presets * nr_total_params */
+};
+
+#endif /* _CORESIGHT_CORESIGHT_CONFIG_UAPI_H */
-- 
2.17.1

