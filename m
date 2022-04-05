Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493774F4E72
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241944AbiDFATz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348962AbiDEJsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:48:50 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907CDA5EBB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 02:38:08 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so1177802wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 02:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d4jB3djPX10WcZTI6rW+C0rQK94UmI79p5ZbxcZQAWw=;
        b=xd+udpVeXE7Et/uacVYzKho70vyeWGh4Ij0lXsOI/GaVlpFvDfdsc24KOcu8aJmBWF
         3FuMDLcj/RVGcv44kUnmY6atkjAHTqbpA9UfwTg9gEw6ndkI4FIvFkMDb/vSPVwCIonK
         KGPci4JC4wcb0L7dXvyf/+HKbBBkr+fOM0s04oGf977g8MydlxKtQ7xZksQqjG/QoSZq
         9tK+ewTvxM4kRRvUBPy0zwOi8N/dS/bCCx5y59k5oISAheaumxtCB46kgnX1Osz0MvdX
         oWLsR4CE7qg100mK2IlTrGazcRHwPl8zEWL2CZ8PxHLL0+fkx2srUf6cRmuqUGxhg/i9
         ZqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d4jB3djPX10WcZTI6rW+C0rQK94UmI79p5ZbxcZQAWw=;
        b=5m04odR9XS4R4n2aXAdiW2Ft/dAqhK3F/UwDtKGxfuTbauj0MmAydl/e71andCF+ve
         FjDvwukCz9m/x5glYUqngE5v6S6v/FFC4lJkJRRttKmzdxN5aKryCTNYiAAavuKTLjp8
         rXcPCleF1C1SgQgCyyoQpdkuXgxQUHd2D1A4p5VO97ayFlFJUb6QR0IuZk41JBdPHLtC
         UnaUrJGX01/HKY9h5/TFLiLsoe5xDiRCPQa2fPz6l3dBRvjE23W2W0UaIezHFc8Q2c0d
         4h0l4ecnKOgYBp5UXPWHUdBFEgK8vGzC2PMbyIfI4NTpe2SA+/foM9+dvfHU2td1hr1j
         4uAw==
X-Gm-Message-State: AOAM532qglz1Hh/qgPPLF1WuEXRUKQ6/FbIYAyrWKvaHEX5vnMsfRMVp
        L3gsBxvh9CARJce/V8lu8F4DGQ==
X-Google-Smtp-Source: ABdhPJyfEKkHt/FOyqqqAk5VV5w8J0Eep1ova1ZnbCDT2b7IMjJfkjEjvAVgJbjsbDbQ7Le/0gBsFw==
X-Received: by 2002:a1c:f717:0:b0:38e:6bed:2aad with SMTP id v23-20020a1cf717000000b0038e6bed2aadmr2272316wmh.45.1649151486917;
        Tue, 05 Apr 2022 02:38:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id l3-20020a1ced03000000b0038ce57d28a1sm1564609wmh.26.2022.04.05.02.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 02:38:00 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 29DC41FFBC;
        Tue,  5 Apr 2022 10:38:00 +0100 (BST)
From:   =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     maxim.uvarov@linaro.org, joakim.bech@linaro.org,
        ulf.hansson@linaro.org, ilias.apalodimas@linaro.org,
        arnd@linaro.org, ruchika.gupta@linaro.org, tomas.winkler@intel.com,
        yang.huang@intel.com, bing.zhu@intel.com,
        Matti.Moell@opensynergy.com, hmo@opensynergy.com,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Alexander Usyskin <alexander.usyskin@intel.com>
Subject: [PATCH  v2 4/4] tools rpmb: add RPBM access tool
Date:   Tue,  5 Apr 2022 10:37:59 +0100
Message-Id: <20220405093759.1126835-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220405093759.1126835-1-alex.bennee@linaro.org>
References: <20220405093759.1126835-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add simple RPMB host testing tool. It can be used to program key,
write and read data block, and retrieve write counter. It's based on
Tomas' original tool but only deals with the virtio-rpmb device. I've
also split the RPMB specific functions (vrpmb_*) from the generic
hooks (op_rpmb_*) to make it easier to add other RPMB implementations.

A simple test.sh script will exercise the interface (assuming a virgin
RPMB device awaiting a programmed key).

Signed-off-by: Alex BennÃ©e <alex.bennee@linaro.org>
Cc: Tomas Winkler <tomas.winkler@intel.com>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>

---
ajb:
  - new per op ioctl API
---
 MAINTAINERS           |    1 +
 tools/Makefile        |   16 +-
 tools/rpmb/.gitignore |    2 +
 tools/rpmb/Makefile   |   41 ++
 tools/rpmb/key        |    1 +
 tools/rpmb/rpmb.c     | 1083 +++++++++++++++++++++++++++++++++++++++++
 tools/rpmb/test.sh    |   22 +
 7 files changed, 1161 insertions(+), 5 deletions(-)
 create mode 100644 tools/rpmb/.gitignore
 create mode 100644 tools/rpmb/Makefile
 create mode 100644 tools/rpmb/key
 create mode 100644 tools/rpmb/rpmb.c
 create mode 100755 tools/rpmb/test.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a744da21817..70716250aa51 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16751,6 +16751,7 @@ S:	Supported
 F:	drivers/rpmb/*
 F:	include/uapi/linux/rpmb.h
 F:	include/linux/rpmb.h
+F:	tools/rpmb/
 
 RPMSG TTY DRIVER
 M:	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
diff --git a/tools/Makefile b/tools/Makefile
index db2f7b8ebed5..0cc62dcae581 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -27,6 +27,7 @@ help:
 	@echo '  objtool                - an ELF object analysis tool'
 	@echo '  pci                    - PCI tools'
 	@echo '  perf                   - Linux performance measurement and analysis tool'
+	@echo '  rpmb                   - Replay protected memory block access tool'
 	@echo '  selftests              - various kernel selftests'
 	@echo '  bootconfig             - boot config tool'
 	@echo '  spi                    - spi tools'
@@ -65,7 +66,9 @@ acpi: FORCE
 cpupower: FORCE
 	$(call descend,power/$@)
 
-cgroup counter firewire hv guest bootconfig spi usb virtio vm bpf iio gpio objtool leds wmi pci firmware debugging tracing: FORCE
+cgroup counter firewire hv guest bootconfig spi usb virtio vm bpf iio \
+  gpio objtool leds wmi pci firmware debugging tracing rpmb: FORCE
+
 	$(call descend,$@)
 
 bpf/%: FORCE
@@ -101,7 +104,7 @@ all: acpi cgroup counter cpupower gpio hv firewire \
 		perf selftests bootconfig spi turbostat usb \
 		virtio vm bpf x86_energy_perf_policy \
 		tmon freefall iio objtool kvm_stat wmi \
-		pci debugging tracing
+		pci debugging tracing rpmb
 
 acpi_install:
 	$(call descend,power/$(@:_install=),install)
@@ -109,7 +112,7 @@ acpi_install:
 cpupower_install:
 	$(call descend,power/$(@:_install=),install)
 
-cgroup_install counter_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install vm_install bpf_install objtool_install wmi_install pci_install debugging_install tracing_install:
+cgroup_install counter_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install vm_install bpf_install objtool_install wmi_install pci_install debugging_install tracing_install rpmb_install:
 	$(call descend,$(@:_install=),install)
 
 selftests_install:
@@ -129,7 +132,7 @@ kvm_stat_install:
 
 install: acpi_install cgroup_install counter_install cpupower_install gpio_install \
 		hv_install firewire_install iio_install \
-		perf_install selftests_install turbostat_install usb_install \
+		perf_install rpmb_install selftests_install turbostat_install usb_install \
 		virtio_install vm_install bpf_install x86_energy_perf_policy_install \
 		tmon_install freefall_install objtool_install kvm_stat_install \
 		wmi_install pci_install debugging_install intel-speed-select_install \
@@ -157,6 +160,9 @@ perf_clean:
 	$(Q)mkdir -p $(PERF_O) .
 	$(Q)$(MAKE) --no-print-directory -C perf O=$(PERF_O) subdir= clean
 
+rpmb_clean:
+	$(call descend,$(@:_clean=),clean)
+
 selftests_clean:
 	$(call descend,testing/$(@:_clean=),clean)
 
@@ -173,7 +179,7 @@ build_clean:
 	$(call descend,build,clean)
 
 clean: acpi_clean cgroup_clean counter_clean cpupower_clean hv_clean firewire_clean \
-		perf_clean selftests_clean turbostat_clean bootconfig_clean spi_clean usb_clean virtio_clean \
+		perf_clean rpmb_clean selftests_clean turbostat_clean bootconfig_clean spi_clean usb_clean virtio_clean \
 		vm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
 		freefall_clean build_clean libbpf_clean libsubcmd_clean \
 		gpio_clean objtool_clean leds_clean wmi_clean pci_clean firmware_clean debugging_clean \
diff --git a/tools/rpmb/.gitignore b/tools/rpmb/.gitignore
new file mode 100644
index 000000000000..218f680548e6
--- /dev/null
+++ b/tools/rpmb/.gitignore
@@ -0,0 +1,2 @@
+*.o
+rpmb
diff --git a/tools/rpmb/Makefile b/tools/rpmb/Makefile
new file mode 100644
index 000000000000..e9429be4eaba
--- /dev/null
+++ b/tools/rpmb/Makefile
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0
+include ../scripts/Makefile.include
+
+CC ?= $(CROSS_COMPILE)gcc
+LD ?= $(CROSS_COMPILE)ld
+PKG_CONFIG = $(CROSS_COMPILE)pkg-config
+
+ifeq ($(srctree),)
+srctree := $(patsubst %/,%,$(dir $(shell pwd)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+#$(info Determined 'srctree' to be $(srctree))
+endif
+
+INSTALL = install
+prefix ?= /usr/local
+bindir = $(prefix)/bin
+
+
+CFLAGS += $(HOSTCFLAGS)
+CFLAGS += -D__EXPORTED_HEADERS__
+CFLAGS += -Wall -Wextra -ggdb
+ifdef RPMB_STATIC
+LDFLAGS += -pthread -static -Wl,-u,pthread_mutex_unlock
+CFLAGS +=  -pthread -static
+PKG_STATIC = --static
+endif
+CFLAGS += -I$(srctree)/include/uapi -I$(srctree)/include
+LDLIBS += $(shell $(PKG_CONFIG) --libs $(PKG_STATIC) libcrypto)
+
+prog := rpmb
+
+all : $(prog)
+
+$(prog): rpmb.o
+
+clean :
+	$(RM) $(prog) *.o
+
+install: $(prog)
+	$(INSTALL) -m755 -d $(DESTDIR)$(bindir)
+	$(INSTALL) $(prog) $(DESTDIR)$(bindir)
diff --git a/tools/rpmb/key b/tools/rpmb/key
new file mode 100644
index 000000000000..2b6bd3bc3fe6
--- /dev/null
+++ b/tools/rpmb/key
@@ -0,0 +1 @@
+˜ƒÆÐh«#×¢ö‹pRTà¿®åô\r|OŠ	¯mo«
\ No newline at end of file
diff --git a/tools/rpmb/rpmb.c b/tools/rpmb/rpmb.c
new file mode 100644
index 000000000000..ff7ea198eda1
--- /dev/null
+++ b/tools/rpmb/rpmb.c
@@ -0,0 +1,1083 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (C) 2016-2019 Intel Corp. All rights reserved
+ * Copyright (C) 2021-2022 Linaro Ltd
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <keyutils.h>
+#include <dirent.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <libgen.h>
+#include <limits.h>
+#include <ctype.h>
+#include <errno.h>
+#include <stdint.h>
+#include <stdbool.h>
+
+#include <openssl/engine.h>
+#include <openssl/hmac.h>
+#include <openssl/rand.h>
+
+/* if uapi header isn't installed, this might not yet exist */
+#ifndef __packed
+#define __packed __attribute__((packed))
+#endif
+
+#include "linux/rpmb.h"
+#include "linux/virtio_rpmb.h"
+
+#define RPMB_KEY_SIZE 32
+#define RPMB_MAC_SIZE 32
+#define RPMB_NONCE_SIZE 16
+#define RPMB_BLOCK_SIZE 256
+
+#define min(a, b)			\
+	({ __typeof__ (a) _a = (a);	\
+	   __typeof__ (b) _b = (b);	\
+		_a < _b ? _a : _b; })
+
+
+static bool verbose;
+#define rpmb_dbg(fmt, ARGS...) do {                     \
+	if (verbose)                                    \
+		fprintf(stderr, "rpmb: " fmt, ##ARGS);  \
+} while (0)
+
+#define rpmb_msg(fmt, ARGS...) \
+	fprintf(stderr, "rpmb: " fmt, ##ARGS)
+
+#define rpmb_err(fmt, ARGS...) \
+	fprintf(stderr, "rpmb:%d error: " fmt, __LINE__, ##ARGS)
+
+
+/*
+ * Utility functions
+ */
+static int open_dev_file(const char *devfile, struct rpmb_ioc_cap_cmd *cap)
+{
+	struct rpmb_ioc_ver_cmd ver;
+	int fd;
+	int ret;
+
+	fd = open(devfile, O_RDWR);
+	if (fd < 0)
+		rpmb_err("Cannot open: %s: %s.\n", devfile, strerror(errno));
+
+	ret = ioctl(fd, RPMB_IOC_VER_CMD, &ver);
+	if (ret < 0) {
+		rpmb_err("ioctl failure %d: %s.\n", ret, strerror(errno));
+		goto err;
+	}
+
+	printf("RPMB API Version %X\n", ver.api_version);
+
+	ret = ioctl(fd, RPMB_IOC_CAP_CMD, cap);
+	if (ret < 0) {
+		rpmb_err("ioctl failure %d: %s.\n", ret, strerror(errno));
+		goto err;
+	}
+
+	rpmb_dbg("RPMB rpmb_target = %d\n", cap->target);
+	rpmb_dbg("RPMB capacity    = %d\n", cap->capacity);
+	rpmb_dbg("RPMB block_size  = %d\n", cap->block_size);
+	rpmb_dbg("RPMB wr_cnt_max  = %d\n", cap->wr_cnt_max);
+	rpmb_dbg("RPMB rd_cnt_max  = %d\n", cap->rd_cnt_max);
+	rpmb_dbg("RPMB auth_method = %d\n", cap->auth_method);
+
+	return fd;
+err:
+	close(fd);
+	return -1;
+}
+
+static int open_rd_file(const char *datafile, const char *type)
+{
+	int fd;
+
+	if (!strcmp(datafile, "-"))
+		fd = STDIN_FILENO;
+	else
+		fd = open(datafile, O_RDONLY);
+
+	if (fd < 0)
+		rpmb_err("Cannot open %s: %s: %s.\n",
+			 type, datafile, strerror(errno));
+
+	return fd;
+}
+
+static int open_wr_file(const char *datafile, const char *type)
+{
+	int fd;
+
+	if (!strcmp(datafile, "-"))
+		fd = STDOUT_FILENO;
+	else
+		fd = open(datafile, O_WRONLY | O_CREAT | O_APPEND, 0600);
+	if (fd < 0)
+		rpmb_err("Cannot open %s: %s: %s.\n",
+			 type, datafile, strerror(errno));
+	return fd;
+}
+
+static void close_fd(int fd)
+{
+	if (fd > 0 && fd != STDIN_FILENO && fd != STDOUT_FILENO)
+		close(fd);
+}
+
+/* need to just cast out 'const' in write(2) */
+typedef ssize_t (*rwfunc_t)(int fd, void *buf, size_t count);
+/* blocking rw wrapper */
+static ssize_t rw(rwfunc_t func, int fd, unsigned char *buf, size_t size)
+{
+	ssize_t ntotal = 0, n;
+	char *_buf = (char *)buf;
+
+	do {
+		n = func(fd, _buf + ntotal, size - ntotal);
+		if (n == -1 && errno != EINTR) {
+			ntotal = -1;
+			break;
+		} else if (n > 0) {
+			ntotal += n;
+		}
+	} while (n != 0 && (size_t)ntotal != size);
+
+	return ntotal;
+}
+
+static ssize_t read_file(int fd, unsigned char *data, size_t size)
+{
+	ssize_t ret;
+
+	ret = rw(read, fd, data, size);
+	if (ret < 0) {
+		rpmb_err("cannot read file: %s\n.", strerror(errno));
+	} else if ((size_t)ret != size) {
+		rpmb_err("read %zd but must be %zu bytes length.\n", ret, size);
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static ssize_t write_file(int fd, unsigned char *data, size_t size)
+{
+	ssize_t ret;
+
+	ret = rw((rwfunc_t)write, fd, data, size);
+	if (ret < 0) {
+		rpmb_err("cannot read file: %s.\n", strerror(errno));
+	} else if ((size_t)ret != size) {
+		rpmb_err("data is %zd but must be %zu bytes length.\n",
+			 ret, size);
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+static void __dump_buffer(const char *buf)
+{
+	fprintf(stderr, "%s\n", buf);
+}
+
+static void
+dump_hex_buffer(const char *title, const void *buf, size_t len)
+{
+#define PBUF_SZ (16 * 3)
+	const unsigned char *_buf = (const unsigned char *)buf;
+	char pbuf[PBUF_SZ];
+	int j = 0;
+
+	if (title)
+		fprintf(stderr, "%s\n", title);
+	while (len-- > 0) {
+		snprintf(&pbuf[j], PBUF_SZ - j, "%02X ", *_buf++);
+		j += 3;
+		if (j == PBUF_SZ) {
+			__dump_buffer(pbuf);
+			j = 0;
+		}
+	}
+	if (j)
+		__dump_buffer(pbuf);
+}
+
+/*
+ * MAC bits
+ */
+
+/* The hmac calculation is from data to the end of the frame */
+#define vrpmb_hmac_data_len \
+	(sizeof(struct virtio_rpmb_frame) - \
+	 offsetof(struct virtio_rpmb_frame, data))
+
+static int vrpmb_calc_hmac_sha256(struct virtio_rpmb_frame *frames,
+				  size_t blocks_cnt,
+				  const unsigned char key[],
+				  unsigned int key_size,
+				  unsigned char mac[],
+				  unsigned int mac_size)
+{
+	HMAC_CTX *ctx;
+	int ret;
+	unsigned int i;
+
+	 /* SSL returns 1 on success 0 on failure */
+
+	ctx = HMAC_CTX_new();
+
+	ret = HMAC_Init_ex(ctx, key, key_size, EVP_sha256(), NULL);
+	if (ret == 0)
+		goto out;
+	for (i = 0; i < blocks_cnt; i++)
+		HMAC_Update(ctx, frames[i].data, vrpmb_hmac_data_len);
+
+	ret = HMAC_Final(ctx, mac, &mac_size);
+	if (ret == 0)
+		goto out;
+	if (mac_size != RPMB_MAC_SIZE)
+		ret = 0;
+
+	ret = 1;
+out:
+	HMAC_CTX_free(ctx);
+	return ret == 1 ? 0 : -1;
+}
+
+
+static int vrpmb_check_mac(const unsigned char *key,
+			   struct virtio_rpmb_frame *frames_out,
+			   unsigned int cnt_out)
+{
+	unsigned char mac[RPMB_MAC_SIZE];
+
+	if (cnt_out == 0) {
+		rpmb_err("RPMB 0 output frames.\n");
+		return -1;
+	}
+
+	vrpmb_calc_hmac_sha256(frames_out, cnt_out,
+			       key, RPMB_KEY_SIZE,
+			       mac, RPMB_MAC_SIZE);
+
+	if (memcmp(mac, frames_out[cnt_out - 1].key_mac, RPMB_MAC_SIZE)) {
+		rpmb_err("RPMB hmac mismatch:\n");
+		dump_hex_buffer("Result MAC: ",
+				frames_out[cnt_out - 1].key_mac, RPMB_MAC_SIZE);
+		dump_hex_buffer("Expected MAC: ", mac, RPMB_MAC_SIZE);
+		return -1;
+	}
+
+	return 0;
+}
+
+/* Compute the frames MAC and insert it */
+static void vrpmb_compute_mac(const unsigned char *key,
+			      struct virtio_rpmb_frame *frame)
+{
+	vrpmb_calc_hmac_sha256(frame, 1, key, RPMB_KEY_SIZE, &frame->key_mac, RPMB_MAC_SIZE);
+}
+
+/*
+ * VirtIO RPMB Bits
+ */
+
+static const char *vrpmb_op_str(uint16_t op)
+{
+#define RPMB_OP(_op) case VIRTIO_RPMB_REQ_##_op: return #_op
+
+	switch (op) {
+	RPMB_OP(PROGRAM_KEY);
+	RPMB_OP(GET_WRITE_COUNTER);
+	RPMB_OP(DATA_WRITE);
+	RPMB_OP(DATA_READ);
+	RPMB_OP(RESULT_READ);
+	break;
+	default:
+		return "unknown";
+	}
+#undef RPMB_OP
+}
+
+static const char *vrpmb_result_str(uint16_t result)
+{
+#define str(x) #x
+#define RPMB_ERR(_res) case VIRTIO_RPMB_RES_##_res:         \
+	{ if (result & VIRTIO_RPMB_RES_WRITE_COUNTER_EXPIRED)	\
+		return "COUNTER_EXPIRE:" str(_res);  \
+	else                                         \
+		return str(_res);                    \
+	}
+
+	switch (result & 0x000F) {
+	RPMB_ERR(OK);
+	RPMB_ERR(GENERAL_FAILURE);
+	RPMB_ERR(AUTH_FAILURE);
+	RPMB_ERR(COUNT_FAILURE);
+	RPMB_ERR(ADDR_FAILURE);
+	RPMB_ERR(WRITE_FAILURE);
+	RPMB_ERR(READ_FAILURE);
+	RPMB_ERR(NO_AUTH_KEY);
+	break;
+	default:
+		return "unknown";
+	}
+#undef RPMB_ERR
+#undef str
+};
+
+#define RPMB_REQ2RESP(_OP) ((_OP) << 8)
+#define RPMB_RESP2REQ(_OP) ((_OP) >> 8)
+
+static void vrpmb_dump_frame(const char *title, const struct virtio_rpmb_frame *f)
+{
+	uint16_t result, req_resp;
+
+	if (!verbose)
+		return;
+
+	if (!f)
+		return;
+
+	result = be16toh(f->result);
+	req_resp = be16toh(f->req_resp);
+	if (req_resp & 0xf00)
+		req_resp = RPMB_RESP2REQ(req_resp);
+
+	fprintf(stderr, "--------------- %s ---------------\n",
+		title ? title : "start");
+	fprintf(stderr, "ptr: %p\n", f);
+	dump_hex_buffer("key_mac: ", f->key_mac, 32);
+	dump_hex_buffer("data: ", f->data, 256);
+	dump_hex_buffer("nonce: ", f->nonce, 16);
+	fprintf(stderr, "write_counter: %u\n", be32toh(f->write_counter));
+	fprintf(stderr, "address:  %0X\n", be16toh(f->address));
+	fprintf(stderr, "block_count: %u\n", be16toh(f->block_count));
+	fprintf(stderr, "result %s:%d\n", vrpmb_result_str(result), result);
+	fprintf(stderr, "req_resp %s\n", vrpmb_op_str(req_resp));
+	fprintf(stderr, "--------------- End ---------------\n");
+}
+
+static bool vrpmb_check_req_resp(uint16_t req, struct virtio_rpmb_frame *f)
+{
+	uint16_t req_resp = be16toh(f->req_resp);
+
+	if (RPMB_REQ2RESP(req) != req_resp) {
+		rpmb_err("RPMB response mismatch %04X != %04X\n.",
+			 RPMB_REQ2RESP(req), req_resp);
+		return false;
+	}
+
+	rpmb_msg("validated response: 0x%x\n", req_resp);
+	return true;
+}
+
+
+
+static struct virtio_rpmb_frame * vrpmb_alloc_frames(int n)
+{
+	struct virtio_rpmb_frame *frames;
+
+	frames = calloc(n, sizeof(struct virtio_rpmb_frame));
+	if (frames)
+		memset(frames, 0, n *  sizeof(struct virtio_rpmb_frame));
+	return frames;
+}
+
+static int vrpmb_program_key(int dev_fd, void *key)
+{
+	struct rpmb_ioc_reqresp_cmd cmd;
+	struct virtio_rpmb_frame *out, *in;
+	int ret;
+
+	out = vrpmb_alloc_frames(2);
+
+	/* construct outgoing frames */
+	out[0].req_resp = htobe16(VIRTIO_RPMB_REQ_PROGRAM_KEY);
+	out[0].block_count = htobe16(1);
+	memcpy(&out[0].key_mac[0], key, RPMB_MAC_SIZE);
+	RAND_bytes((void *) &out[0].nonce, RPMB_NONCE_SIZE);
+	out[1].req_resp = htobe16(VIRTIO_RPMB_REQ_RESULT_READ);
+	RAND_bytes((void *) &out[1].nonce, RPMB_NONCE_SIZE);
+
+	cmd.len = sizeof(struct virtio_rpmb_frame) * 2;
+	cmd.request = (void *) out;
+
+	vrpmb_dump_frame("pkey", &out[0]);
+	vrpmb_dump_frame("request", &out[1]);
+
+	/* space for response */
+	in = vrpmb_alloc_frames(1);
+	cmd.rlen = sizeof(struct virtio_rpmb_frame);
+	cmd.response = (void *) in;
+
+	/* do it */
+	ret = ioctl(dev_fd, RPMB_IOC_PKEY_CMD, &cmd);
+	if (ret < 0) {
+		rpmb_err("pkey ioctl failure %d: %s.\n", ret, strerror(errno));
+		goto out;
+	}
+
+	vrpmb_dump_frame("response", in);
+
+	/* validate response */
+	if (!vrpmb_check_req_resp(VIRTIO_RPMB_REQ_PROGRAM_KEY, in)) {
+		ret = -1;
+		goto out;
+	}
+
+	ret = vrpmb_check_mac(key, in, 1);
+	if (ret) {
+		rpmb_err("%s: check mac error %d\n", __func__, ret);
+		goto out;
+	}
+
+out:
+	if (ret)
+		rpmb_err("RPMB operation %s failed=%d %s[0x%04x]\n",
+			 vrpmb_op_str(out->req_resp), ret,
+			 vrpmb_result_str(in->result), in->result);
+
+	free(in);
+	free(out);
+	return ret;
+}
+
+static int vrpmb_get_write_counter(int dev_fd, void *key)
+{
+	struct rpmb_ioc_reqresp_cmd cmd;
+	struct virtio_rpmb_frame *out, *in = NULL;
+	int ret;
+
+	out = vrpmb_alloc_frames(1);
+	in = vrpmb_alloc_frames(1);
+	if (!out || !in) {
+		rpmb_err("couldn't allocate frames");
+		return -ENOMEM;
+	}
+
+	/* Query frame */
+	out[0].req_resp = htobe16(VIRTIO_RPMB_REQ_GET_WRITE_COUNTER);
+	out[0].block_count = htobe16(1);
+	RAND_bytes((void *) &out[0].nonce, RPMB_NONCE_SIZE);
+
+	cmd.request = (void *) out;
+	cmd.len = sizeof(struct virtio_rpmb_frame);
+	cmd.response = (void *) in;
+	cmd.rlen = sizeof(struct virtio_rpmb_frame);
+
+	ret = ioctl(dev_fd, RPMB_IOC_COUNTER_CMD, &cmd);
+	if (ret < 0) {
+		rpmb_err("get wcount ioctl failure %d: %s.\n", ret,
+			 strerror(errno));
+		goto out;
+	}
+
+	vrpmb_dump_frame("write_counter", in);
+
+	ret = be32toh(in->write_counter);
+	rpmb_msg("counter 0x%x\n", ret);
+
+	/* validate response */
+	if (!vrpmb_check_req_resp(VIRTIO_RPMB_REQ_GET_WRITE_COUNTER, in)) {
+		ret = -1;
+		goto out;
+	}
+
+	if (memcmp(&in->nonce, &out[0].nonce, RPMB_NONCE_SIZE)) {
+		rpmb_err("RPMB NONCE mismatch\n");
+		dump_hex_buffer("Result NONCE:",
+				&in->nonce, RPMB_NONCE_SIZE);
+		dump_hex_buffer("Expected NONCE: ",
+				&out[0].nonce, RPMB_NONCE_SIZE);
+		ret = -1;
+		goto out;
+	}
+
+	if (key) {
+		ret = vrpmb_check_mac(key, in, 1);
+		if (ret)
+			rpmb_err("%s: check mac error %d\n", __func__, ret);
+	}
+
+	ret = be32toh(in->write_counter);
+	rpmb_msg("counter 0x%x\n", ret);
+
+out:
+	free(out);
+	free(in);
+	return ret;
+
+}
+
+static int vrpmb_write_blocks(int dev_fd, void *key, void *data, int addr, int len)
+{
+	struct rpmb_ioc_reqresp_cmd cmd;
+	struct virtio_rpmb_frame *out, *in = NULL;
+	int frames = (len / 256) + 1;
+	uint8_t *p = (uint8_t *) data;
+	int i, ret;
+	int write_count = vrpmb_get_write_counter(dev_fd, key);
+
+	out = vrpmb_alloc_frames(frames);
+	in = vrpmb_alloc_frames(1);
+	if (!out || !in) {
+		rpmb_err("couldn't allocate frames");
+		return -ENOMEM;
+	}
+
+	/* First frame */
+	out[0].req_resp = htobe16(VIRTIO_RPMB_REQ_DATA_WRITE);
+	out[0].block_count = htobe16(frames - 1);
+	out[0].address = htobe16(addr);
+	out[0].write_counter = htobe32(write_count);
+
+	/* Copy data to write and prepare frames */
+	for (i = 0; i < frames; i++) {
+		struct virtio_rpmb_frame *f = &out[i];
+
+		memcpy(&f->data, &p[i * 256], 256);
+		RAND_bytes((void *) &f->nonce, RPMB_NONCE_SIZE);
+		vrpmb_compute_mac(key, f);
+	}
+
+	vrpmb_dump_frame("write_blocks", &out[0]);
+
+	/* Response request */
+	out[frames - 1].req_resp = htobe16(VIRTIO_RPMB_REQ_RESULT_READ);
+	out[frames - 1].block_count = htobe16(1);
+	RAND_bytes((void *) &out[frames - 1].nonce, RPMB_NONCE_SIZE);
+	vrpmb_compute_mac(key, &out[frames - 1]);
+
+	vrpmb_dump_frame("result_req", &out[frames - 1]);
+
+	cmd.request = (void *) out;
+	cmd.len = frames * sizeof(struct virtio_rpmb_frame);
+	cmd.response = (void *) in;
+	cmd.rlen = sizeof(struct virtio_rpmb_frame);
+
+	ret = ioctl(dev_fd, RPMB_IOC_WBLOCKS_CMD, &cmd);
+	if (ret < 0) {
+		rpmb_err("wblocks ioctl failure %d: %s.\n", ret,
+			 strerror(errno));
+	}
+
+	free(out);
+	free(in);
+	return ret;
+}
+
+/*
+ * To read blocks we receive a bunch of frames from the vrpmb device
+ * which we need to validate and extract the actual data into
+ * requested buffer.
+ */
+static int vrpmb_read_blocks(int dev_fd, void *key, int addr, int count, void *data, int len)
+{
+	struct rpmb_ioc_rblocks_cmd cmd;
+	int frame_length = count * sizeof(struct virtio_rpmb_frame);
+	struct virtio_rpmb_frame *frames = malloc(frame_length);
+	int i, ret = -1;
+
+	rpmb_dbg("%s: reading %d blocks into %d bytes (%d bytes of frames)\n",
+		 __func__, count, len, frame_length);
+
+	if (!frames) {
+		rpmb_err("unable to allocate memory for frames");
+		return -1;
+	}
+
+	cmd.addr = addr;
+	cmd.count = count;
+	cmd.len = frame_length;
+	cmd.data = (__u8 *) frames;
+
+	ret = ioctl(dev_fd, RPMB_IOC_RBLOCKS_CMD, &cmd);
+	if (ret < 0) {
+		rpmb_err("rblocks ioctl failure %d: %s.\n", ret,
+			 strerror(errno));
+		goto out;
+	}
+
+	for (i = 0; i < count; i++) {
+		struct virtio_rpmb_frame *f = &frames[i];
+
+		vrpmb_dump_frame("block data", f);
+
+		if (key) {
+			ret = vrpmb_check_mac(key, f, 1);
+			if (ret) {
+				rpmb_err("%s: check mac error frame %d/%d\n", __func__, i, ret);
+				break;
+			}
+		}
+
+		memcpy(data, &f->data, RPMB_BLOCK_SIZE);
+		data += RPMB_BLOCK_SIZE;
+	}
+	ret = 0;
+
+ out:
+	free(frames);
+	return ret;
+}
+
+/*
+ * Generic RPMB bits
+ */
+static int op_get_info(int nargs, char *argv[])
+{
+	int dev_fd;
+	struct rpmb_ioc_cap_cmd cap;
+
+	if (nargs != 1)
+		return -EINVAL;
+
+	memset(&cap, 0, sizeof(cap));
+	dev_fd = open_dev_file(argv[0], &cap);
+	if (dev_fd < 0)
+		return -errno;
+	argv++;
+
+	printf("RPMB rpmb_target = %d\n", cap.target);
+	printf("RPMB capacity    = %d\n", cap.capacity);
+	printf("RPMB block_size  = %d\n", cap.block_size);
+	printf("RPMB wr_cnt_max  = %d\n", cap.wr_cnt_max);
+	printf("RPMB rd_cnt_max  = %d\n", cap.rd_cnt_max);
+	printf("RPMB auth_method = %d\n", cap.auth_method);
+
+	close(dev_fd);
+
+	return 0;
+}
+
+static void *read_key(const char *path)
+{
+	int key_fd = open_rd_file(path, "key file");
+	void *key;
+
+	if (key_fd < 0)
+		return NULL;
+
+	key = malloc(RPMB_KEY_SIZE);
+
+	if (!key) {
+		rpmb_err("out of memory for key\n");
+		return NULL;
+	}
+
+	if (read(key_fd, key, RPMB_KEY_SIZE) != RPMB_KEY_SIZE) {
+		rpmb_err("couldn't read key (%s)\n", strerror(errno));
+		return NULL;
+	}
+
+	close(key_fd);
+	return key;
+}
+
+static int op_rpmb_program_key(int nargs, char *argv[])
+{
+	int ret = -EINVAL, fd = -1;
+	struct rpmb_ioc_cap_cmd cap;
+	void *key;
+
+	if (nargs < 1 || nargs > 2)
+		return ret;
+
+	fd = open_dev_file(argv[0], &cap);
+	if (fd < 0) {
+		perror("opening RPMB device");
+		return ret;
+	}
+	argv++;
+
+	key = read_key(argv[0]);
+
+	if (key)
+		ret = vrpmb_program_key(fd, key);
+
+	close_fd(fd);
+	return ret;
+}
+
+
+static int op_rpmb_get_write_counter(int nargs, char **argv)
+{
+	int ret, fd = -1;
+	struct rpmb_ioc_cap_cmd cap;
+	void *key = NULL;
+
+	ret = -EINVAL;
+	if (nargs < 1 || nargs > 2)
+		return ret;
+
+	fd = open_dev_file(argv[0], &cap);
+	if (fd < 0) {
+		perror("opening RPMB device");
+		return ret;
+	}
+	argv++;
+
+	if (argv[0]) {
+		key = read_key(argv[0]);
+		if (!key)
+			rpmb_err("failed to read key data");
+	}
+
+	ret = vrpmb_get_write_counter(fd, key);
+	if (ret < 0) {
+		rpmb_err("counter ioctl failure %d: %s.\n", ret, strerror(errno));
+	} else {
+		printf("Counter value is: %d\n", ret);
+		ret = 0;
+	}
+
+	close_fd(fd);
+	return ret;
+}
+
+static int op_rpmb_read_blocks(int nargs, char **argv)
+{
+	int ret, data_fd, fd = -1;
+	struct rpmb_ioc_cap_cmd cap;
+	unsigned long numarg;
+	uint16_t addr, blocks_cnt;
+	void *key = NULL;
+
+	ret = -EINVAL;
+	if (nargs < 4 || nargs > 5)
+		return ret;
+
+	fd = open_dev_file(argv[0], &cap);
+	if (fd < 0) {
+		perror("opening RPMB device");
+		return ret;
+	}
+	argv++;
+
+	errno = 0;
+	numarg = strtoul(argv[0], NULL, 0);
+	if (errno || numarg > USHRT_MAX) {
+		rpmb_err("wrong block address\n");
+		goto out;
+	}
+	addr = (uint16_t)numarg;
+	argv++;
+
+	errno = 0;
+	numarg = strtoul(argv[0], NULL, 0);
+	if (errno || numarg > USHRT_MAX) {
+		rpmb_err("wrong blocks count\n");
+		goto out;
+	}
+	blocks_cnt = (uint16_t)numarg;
+	argv++;
+
+	if (blocks_cnt == 0) {
+		rpmb_err("wrong blocks count\n");
+		goto out;
+	}
+
+	data_fd = open_wr_file(argv[0], "output data");
+	if (data_fd < 0)
+		goto out;
+	argv++;
+
+	if (argv[0]) {
+		key = read_key(argv[0]);
+		if (!key) {
+			rpmb_err("failed to read key data");
+			goto out;
+		}
+	}
+
+	while (blocks_cnt > 0) {
+		int to_copy = min(blocks_cnt, cap.rd_cnt_max);
+		int length = to_copy * RPMB_BLOCK_SIZE;
+		void *data = malloc(length);
+
+		if (!data) {
+			ret = ENOMEM;
+			goto out;
+		}
+
+		vrpmb_read_blocks(fd, key, addr, to_copy, data, length);
+
+		ret = write_file(data_fd, data, length);
+		if (ret < 0) {
+			perror("writing data");
+			goto out;
+		} else {
+			rpmb_dbg("wrote %d bytes/%d blocks to file\n", length, to_copy);
+		}
+
+		free(data);
+		addr += to_copy;
+		blocks_cnt -= to_copy;
+	}
+
+	ret = 0;
+out:
+	close_fd(fd);
+	close_fd(data_fd);
+
+	return ret;
+}
+
+static int op_rpmb_write_blocks(int nargs, char **argv)
+{
+	int ret, data_fd, fd = -1;
+	struct rpmb_ioc_cap_cmd cap;
+	unsigned long numarg;
+	uint16_t addr, blocks_cnt;
+	void *key;
+
+	ret = -EINVAL;
+	if (nargs < 4 || nargs > 5)
+		return ret;
+
+	fd = open_dev_file(argv[0], &cap);
+	if (fd < 0) {
+		perror("opening RPMB device");
+		return ret;
+	}
+	argv++;
+
+	errno = 0;
+	numarg = strtoul(argv[0], NULL, 0);
+	if (errno || numarg > USHRT_MAX) {
+		rpmb_err("wrong block address\n");
+		goto out;
+	}
+	addr = (uint16_t)numarg;
+	argv++;
+
+	errno = 0;
+	numarg = strtoul(argv[0], NULL, 0);
+	if (errno || numarg > USHRT_MAX) {
+		rpmb_err("wrong blocks count\n");
+		goto out;
+	}
+	blocks_cnt = (uint16_t)numarg;
+	argv++;
+
+	if (blocks_cnt == 0) {
+		rpmb_err("wrong blocks count\n");
+		goto out;
+	}
+
+	data_fd = open_rd_file(argv[0], "input data");
+	if (data_fd < 0)
+		goto out;
+	argv++;
+
+	key = read_key(nargs == 5 ? argv[0] : NULL);
+	if (!key) {
+		rpmb_err("failed to read key data");
+		goto out;
+	}
+
+	while (blocks_cnt > 0) {
+		int to_copy = min(blocks_cnt, cap.wr_cnt_max);
+		int length = to_copy * 256;
+		void *data = malloc(length);
+
+		if (!data) {
+			ret = ENOMEM;
+			goto out;
+		}
+
+		ret = read_file(data_fd, data, length);
+		if (ret < 0) {
+			perror("reading data");
+			goto out;
+		}
+
+		ret = vrpmb_write_blocks(fd, key, data, addr, length);
+		if (ret < 0) {
+			rpmb_err("wblocks ioctl failure %d: %s.\n", ret,
+				 strerror(errno));
+			goto out;
+		}
+
+		free(data);
+		addr += to_copy;
+		blocks_cnt -= to_copy;
+	}
+
+	ret = 0;
+out:
+	close_fd(fd);
+	close_fd(data_fd);
+
+	return ret;
+}
+
+typedef int (*rpmb_op)(int argc, char *argv[]);
+
+struct rpmb_cmd {
+	const char *op_name;
+	rpmb_op     op;
+	const char  *usage; /* usage title */
+	const char  *help;  /* help */
+};
+
+static const struct rpmb_cmd cmds[] = {
+	{
+		"get-info",
+		op_get_info,
+		"<RPMB_DEVICE>",
+		"    Get RPMB device info\n",
+	},
+	{
+		"program-key",
+		op_rpmb_program_key,
+		"<RPMB_DEVICE> <KEYFILE>",
+		"    Program authentication KEYFILE\n"
+		"    NOTE: This is a one-time programmable irreversible change.\n",
+	},
+	{
+		"write-counter",
+		op_rpmb_get_write_counter,
+		"<RPMB_DEVICE>",
+		"    Rertrive write counter value from the <RPMB_DEVICE> to stdout.\n"
+	},
+	{
+		"write-blocks",
+		op_rpmb_write_blocks,
+		"<RPMB_DEVICE> <address> <block_count> <DATA_FILE> <KEYID>",
+		"    <block count> of 256 bytes will be written from the DATA_FILE\n"
+		"    to the <RPMB_DEVICE> at block offset <address>.\n"
+		"    When DATA_FILE is -, read from standard input.\n",
+	},
+	{
+		"read-blocks",
+		op_rpmb_read_blocks,
+		"<RPMB_DEVICE> <address> <blocks count> <OUTPUT_FILE>",
+		"    <block count> of 256 bytes will be read from <RPMB_DEVICE>\n"
+		"    to the OUTPUT_FILE\n"
+		"    When OUTPUT_FILE is -, write to standard output\n",
+	},
+
+	{ NULL, NULL, NULL, NULL }
+};
+
+static void help(const char *prog, const struct rpmb_cmd *cmd)
+{
+	printf("%s %s %s\n", prog, cmd->op_name, cmd->usage);
+	printf("%s\n", cmd->help);
+}
+
+static void usage(const char *prog)
+{
+	int i;
+
+	printf("\n");
+	printf("Usage: %s [-v] <command> <args>\n\n", prog);
+	for (i = 0; cmds[i].op_name; i++)
+		printf("       %s %s %s\n",
+		       prog, cmds[i].op_name, cmds[i].usage);
+
+	printf("\n");
+	printf("      %s -v/--verbose: runs in verbose mode\n", prog);
+	printf("      %s help : shows this help\n", prog);
+	printf("      %s help <command>: shows detailed help\n", prog);
+}
+
+static bool call_for_help(const char *arg)
+{
+	return !strcmp(arg, "help") ||
+	       !strcmp(arg, "-h")   ||
+	       !strcmp(arg, "--help");
+}
+
+static bool parse_verbose(const char *arg)
+{
+	return !strcmp(arg, "-v") ||
+	       !strcmp(arg, "--verbose");
+}
+
+static const
+struct rpmb_cmd *parse_args(const char *prog, int *_argc, char **_argv[])
+{
+	int i;
+	int argc = *_argc;
+	char **argv =  *_argv;
+	const struct rpmb_cmd *cmd = NULL;
+	bool need_help = false;
+
+	argc--; argv++;
+
+	if (argc == 0)
+		goto out;
+
+	if (call_for_help(argv[0])) {
+		argc--; argv++;
+		if (argc == 0)
+			goto out;
+
+		need_help = true;
+	}
+
+	if (parse_verbose(argv[0])) {
+		argc--; argv++;
+		if (argc == 0)
+			goto out;
+
+		verbose = true;
+	}
+
+	for (i = 0; cmds[i].op_name; i++) {
+		if (!strncmp(argv[0], cmds[i].op_name,
+			     strlen(cmds[i].op_name))) {
+			cmd = &cmds[i];
+			argc--; argv++;
+			break;
+		}
+	}
+
+	if (!cmd)
+		goto out;
+
+	if (need_help || (argc > 0 && call_for_help(argv[0]))) {
+		help(prog, cmd);
+		argc--; argv++;
+		return NULL;
+	}
+
+out:
+	*_argc = argc;
+	*_argv = argv;
+
+	if (!cmd)
+		usage(prog);
+
+	return cmd;
+}
+
+int main(int argc, char *argv[])
+{
+	const char *prog = basename(argv[0]);
+	const struct rpmb_cmd *cmd;
+	int ret;
+
+	cmd = parse_args(prog, &argc, &argv);
+	if (!cmd)
+		exit(EXIT_SUCCESS);
+
+	ret = cmd->op(argc, argv);
+	if (ret == -EINVAL)
+		help(prog, cmd);
+
+	exit(ret);
+}
diff --git a/tools/rpmb/test.sh b/tools/rpmb/test.sh
new file mode 100755
index 000000000000..2cbba5529618
--- /dev/null
+++ b/tools/rpmb/test.sh
@@ -0,0 +1,22 @@
+#!/bin/sh -e
+# SPDX-License-Identifier: GPL-2.0+
+echo "get info"
+./rpmb -v get-info /dev/rpmb0
+echo "program key"
+./rpmb -v program-key /dev/rpmb0 key
+echo "get write counter"
+./rpmb -v write-counter /dev/rpmb0
+echo "get write counter (and verify)"
+./rpmb -v write-counter /dev/rpmb0 key
+echo "generating data"
+dd if=/dev/urandom of=data.in count=4 bs=256
+echo "write data"
+./rpmb -v write-blocks /dev/rpmb0 0 4 data.in key
+echo "read data back"
+rm -f data.out
+./rpmb -v read-blocks /dev/rpmb0 0 4 data.out
+cmp data.in data.out
+echo "read data back with key check"
+truncate -s 0 data.out
+./rpmb -v read-blocks /dev/rpmb0 0 4 data.out key
+cmp data.in data.out
-- 
2.30.2

