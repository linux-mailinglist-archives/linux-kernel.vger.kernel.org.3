Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C638346532E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351641AbhLAQsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:48:24 -0500
Received: from mga12.intel.com ([192.55.52.136]:26298 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351556AbhLAQrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:47:23 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="216512570"
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="216512570"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 08:43:29 -0800
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="512784027"
Received: from razaahme-mobl.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.252.36.3])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 08:43:26 -0800
From:   Tero Kristo <tero.kristo@linux.intel.com>
To:     linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        jikos@kernel.org, mika.westerberg@linux.intel.com,
        tero.kristo@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        peter.hutterer@who-t.net
Subject: [RFCv3 6/7] samples: hid: add new hid-usi sample
Date:   Wed,  1 Dec 2021 18:43:00 +0200
Message-Id: <20211201164301.44653-7-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201164301.44653-1-tero.kristo@linux.intel.com>
References: <20211201164301.44653-1-tero.kristo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HID-usi sample adds support for writing USI pen variables. When the
sample is run, it creates a unix fifo under /tmp/usi, which can be
written with "<param> set <val>", where param is in [color,width,style],
and val is an integer value for the parameter.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 samples/bpf/Makefile       |   3 +
 samples/bpf/hid_usi.h      |  21 ++++
 samples/bpf/hid_usi_kern.c | 230 ++++++++++++++++++++++++++++++++++
 samples/bpf/hid_usi_user.c | 247 +++++++++++++++++++++++++++++++++++++
 4 files changed, 501 insertions(+)
 create mode 100644 samples/bpf/hid_usi.h
 create mode 100644 samples/bpf/hid_usi_kern.c
 create mode 100644 samples/bpf/hid_usi_user.c

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 11f6f0cfab9e..6f45f6048979 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -62,6 +62,7 @@ tprogs-y += xdp_monitor
 
 tprogs-y += hid_mouse
 tprogs-y += hid_surface_dial
+tprogs-y += hid_usi
 
 # Libbpf dependencies
 LIBBPF_SRC = $(TOOLS_PATH)/lib/bpf
@@ -129,6 +130,7 @@ xdp_redirect-objs := xdp_redirect_user.o $(XDP_SAMPLE)
 xdp_monitor-objs := xdp_monitor_user.o $(XDP_SAMPLE)
 hid_mouse-objs := hid_mouse_user.o
 hid_surface_dial-objs := hid_surface_dial_user.o
+hid_usi-objs := hid_usi_user.o
 
 # Tell kbuild to always build the programs
 always-y := $(tprogs-y)
@@ -188,6 +190,7 @@ always-y += hbm_edt_kern.o
 always-y += xdpsock_kern.o
 always-y += hid_mouse_kern.o
 always-y += hid_surface_dial_kern.o
+always-y += hid_usi_kern.o
 
 ifeq ($(ARCH), arm)
 # Strip all except -D__LINUX_ARM_ARCH__ option needed to handle linux
diff --git a/samples/bpf/hid_usi.h b/samples/bpf/hid_usi.h
new file mode 100644
index 000000000000..90803375d9c1
--- /dev/null
+++ b/samples/bpf/hid_usi.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright(c) 2021 Intel Corporation.
+ */
+
+#ifndef HID_USI_H_
+#define HID_USI_H_
+
+#include <linux/bits.h>
+
+enum {
+	USI_PEN_ID = 0,
+	USI_PEN_IN_RANGE,
+	USI_PEN_TOUCHING,
+	USI_PEN_COLOR,
+	USI_PEN_LINE_WIDTH,
+	USI_PEN_LINE_STYLE,
+	USI_NUM_PARAMS
+};
+
+#endif /* HID_USI_H */
diff --git a/samples/bpf/hid_usi_kern.c b/samples/bpf/hid_usi_kern.c
new file mode 100644
index 000000000000..1ba32eef99c3
--- /dev/null
+++ b/samples/bpf/hid_usi_kern.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2021 Intel Corporation. */
+#include <linux/version.h>
+#include <uapi/linux/bpf.h>
+#include <uapi/linux/hid.h>
+#include <uapi/linux/bpf_hid.h>
+#include <bpf/bpf_helpers.h>
+
+#include "hid_usi.h"
+
+static const char param_names[USI_NUM_PARAMS][6] = {
+	"id",
+	"flags",
+	"color",
+	"width",
+	"style",
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
+} ringbuf SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, int);
+	__uint(max_entries, USI_NUM_PARAMS);
+} cache SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, int);
+	__uint(max_entries, USI_NUM_PARAMS);
+} wr_cache SEC(".maps");
+
+struct rep_data {
+	int offset;
+	int size;
+	int idx;
+};
+
+static struct rep_data inputs[USI_NUM_PARAMS];
+static struct rep_data features[USI_NUM_PARAMS];
+
+SEC("hid/raw_event")
+int hid_raw_event(struct hid_bpf_ctx *ctx)
+{
+	u32 i;
+	u32 tmp;
+	int val;
+	int *wrc, *c;
+	u8 *buf;
+	u32 flags = 0;
+	int offset;
+	int size;
+	int in_range;
+	int touching;
+	bool cache_valid;
+
+	if (ctx->event.data[0] != inputs[USI_PEN_IN_RANGE].idx)
+		return 0;
+
+	in_range = bpf_hid_get_data(ctx, inputs[USI_PEN_IN_RANGE].offset,
+				    inputs[USI_PEN_IN_RANGE].size);
+	touching = bpf_hid_get_data(ctx, inputs[USI_PEN_TOUCHING].offset,
+				    inputs[USI_PEN_TOUCHING].size);
+
+	bpf_printk("flags: in_range=%d, touching=%d", in_range, touching);
+
+	if (!touching && cache_valid) {
+		for (i = USI_PEN_COLOR; i < USI_NUM_PARAMS; i++) {
+			val = 0;
+
+			/*
+			 * Make a local copy of i so that we can get a
+			 * pointer reference to it. i itself must remain
+			 * inside a register so that BPF verifier can
+			 * calculate its value properly.
+			 */
+			tmp = i;
+			bpf_map_update_elem(&wr_cache, &tmp, &val, 0);
+			bpf_map_update_elem(&cache, &tmp, &val, 0);
+		}
+		cache_valid = false;
+	}
+
+	if (!touching)
+		return 0;
+
+	for (i = USI_PEN_COLOR; i < USI_NUM_PARAMS; i++) {
+		offset = inputs[i].offset;
+		size = inputs[i].size;
+		val = bpf_hid_get_data(ctx, offset, size);
+
+		/*
+		 * Again, make a local copy of i which we can refer via a
+		 * pointer to satisfy BPF verifier.
+		 */
+		tmp = i;
+
+		wrc = bpf_map_lookup_elem(&wr_cache, &tmp);
+		c = bpf_map_lookup_elem(&cache, &tmp);
+		if (!wrc || !c)
+			continue;
+
+		bpf_printk("raw[%d]: %s = %02x", i, param_names[i], val);
+		bpf_printk(" (c=%02x, wr=%02x)", *c, *wrc);
+
+		if (*wrc != *c) {
+			val = *wrc;
+
+			buf = bpf_ringbuf_reserve(&ringbuf, 16, 0);
+			if (!buf)
+				continue;
+
+			buf[0] = features[i].idx;
+			buf[1] = 1;
+			buf[2] = val;
+
+			bpf_hid_raw_request(ctx, buf, 3,
+					    HID_FEATURE_REPORT,
+					    HID_REQ_SET_REPORT);
+
+			bpf_ringbuf_discard(buf, 0);
+		}
+
+		if (val != *c && !cache_valid) {
+			bpf_map_update_elem(&cache, &tmp, &val, 0);
+			bpf_map_update_elem(&wr_cache, &tmp, &val, 0);
+			cache_valid = true;
+		} else {
+			bpf_hid_set_data(ctx, offset, size, *c);
+		}
+	}
+
+	return 0;
+}
+
+SEC("hid/event")
+int set_haptic(struct hid_bpf_ctx *ctx)
+{
+	return 0;
+}
+
+static void process_tag(struct hid_bpf_ctx *ctx, struct rep_data *data,
+			struct hid_bpf_parser *parser, u64 *idx)
+{
+	u32 i;
+	int id;
+	u32 offset;
+
+	for (i = 0; i < parser->local.usage_index && i < 16; i++) {
+		offset = parser->report.current_offset +
+			i * parser->global.report_size;
+
+		switch (parser->local.usage[i]) {
+		case HID_DG_PEN_COLOR:
+			id = USI_PEN_COLOR;
+			break;
+		case HID_DG_PEN_LINE_WIDTH:
+			id = USI_PEN_LINE_WIDTH;
+			break;
+		case HID_DG_PEN_LINE_STYLE_INK:
+			id = USI_PEN_LINE_STYLE;
+			/*
+			 * Force flags for line style. This makes it act
+			 * as a simple variable from HID core point of view.
+			 */
+			bpf_hid_set_data(ctx, (*idx + 1) << 3, 8, 0x2);
+			break;
+		case HID_DG_INRANGE:
+			if (parser->local.usage_index == 1)
+				continue;
+
+			id = USI_PEN_IN_RANGE;
+			break;
+		case HID_DG_TIPSWITCH:
+			if (parser->local.usage_index == 1)
+				continue;
+
+			id = USI_PEN_TOUCHING;
+			break;
+		default:
+			continue;
+		}
+
+		data[id].offset = offset + 8;
+		data[id].size = parser->global.report_size;
+		data[id].idx = parser->report.id;
+
+		bpf_printk("parsed id=%d, offset=%d, idx=%d",
+			   id, data[id].offset, data[id].idx);
+	}
+}
+
+static u64 process_hid_rdesc_item(struct hid_bpf_ctx *ctx,
+				  struct hid_bpf_parser *parser, u64 *idx,
+				  void *data)
+{
+	struct hid_bpf_item *item = &parser->item;
+
+	switch (item->type) {
+	case HID_ITEM_TYPE_MAIN:
+		if (item->tag == HID_MAIN_ITEM_TAG_INPUT)
+			process_tag(ctx, inputs, parser, idx);
+		if (item->tag == HID_MAIN_ITEM_TAG_FEATURE)
+			process_tag(ctx, features, parser, idx);
+	}
+
+	return 0;
+}
+
+SEC("hid/rdesc_fixup")
+int hid_rdesc_fixup(struct hid_bpf_ctx *ctx)
+{
+	int ret;
+
+	if (ctx->type != HID_BPF_RDESC_FIXUP)
+		return 0;
+
+	ret = bpf_hid_foreach_rdesc_item(ctx, process_hid_rdesc_item, (void *)0, 0);
+	bpf_printk("ret: %d", ret);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
+u32 _version SEC("version") = LINUX_VERSION_CODE;
diff --git a/samples/bpf/hid_usi_user.c b/samples/bpf/hid_usi_user.c
new file mode 100644
index 000000000000..b05a3f768835
--- /dev/null
+++ b/samples/bpf/hid_usi_user.c
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021, Intel Corporation
+ */
+#include <linux/bpf.h>
+#include <linux/if_link.h>
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <libgen.h>
+#include <sys/resource.h>
+#include <getopt.h>
+
+#include "bpf_util.h"
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+
+#include <sys/stat.h>
+
+#include "hid_usi.h"
+
+static char *sysfs_path;
+static char *fifoname = "/tmp/usi";
+static int sysfs_fd;
+static int fifo_fd;
+static int prog_count;
+static int cache, wr_cache;
+
+static const struct option long_options[] = {
+	{ "help", no_argument, NULL, 'h' },
+	{ "fifo", required_argument, NULL, 'f' },
+};
+
+struct prog {
+	int fd;
+	enum bpf_attach_type type;
+};
+
+static struct prog progs[10];
+
+static void int_exit(int sig)
+{
+	int ret;
+
+	for (prog_count--; prog_count >= 0 ; prog_count--) {
+		ret = bpf_prog_detach2(progs[prog_count].fd, sysfs_fd, progs[prog_count].type);
+		if (ret)
+			fprintf(stderr, "bpf_prog_detach2: returned %m\n");
+	}
+
+	close(sysfs_fd);
+	close(fifo_fd);
+	remove(fifoname);
+	exit(0);
+}
+
+static void usage(const char *prog)
+{
+	fprintf(stderr,
+		"usage: %s [-f <fifoname>] /dev/HIDRAW\n\n",
+		prog);
+}
+
+static int param_to_idx(const char *param)
+{
+	if (!strcmp(param, "color"))
+		return USI_PEN_COLOR;
+	if (!strcmp(param, "width"))
+		return USI_PEN_LINE_WIDTH;
+	if (!strcmp(param, "style"))
+		return USI_PEN_LINE_STYLE;
+
+	return -EINVAL;
+}
+
+static int write_value(const char *param, int value)
+{
+	int err;
+	int idx = param_to_idx(param);
+
+	printf("%s: param=%s (%d), value=%d\n", __func__, param, idx, value);
+	err = bpf_map_update_elem(wr_cache, &idx, &value, BPF_ANY);
+	if (err)
+		printf("Update failed for %d, err=%d\n", idx, err);
+
+	return 0;
+}
+
+static int read_value(const char *param)
+{
+	int value;
+	int idx = param_to_idx(param);
+
+	printf("%s: param=%s (%d)\n", __func__, param, idx);
+
+	if (bpf_map_lookup_elem(cache, &idx, &value))
+		printf("Value missing for %d\n", idx);
+	else
+		printf("Value for %d = %d\n", idx, value);
+
+	return 0;
+}
+
+static int attach_progs(int argc, char **argv)
+{
+	char filename[256];
+	struct bpf_prog_info info = {};
+	__u32 info_len = sizeof(info);
+	struct bpf_object *obj;
+	struct bpf_program *prog;
+	int err = 0;
+	char buf[BUFSIZ];
+	char param[16];
+	char op[8];
+	int value;
+	int m, n;
+
+	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
+	obj = bpf_object__open_file(filename, NULL);
+	err = libbpf_get_error(obj);
+	if (err) {
+		fprintf(stderr, "ERROR: opening BPF object file failed\n");
+		obj = NULL;
+		err = 1;
+		goto cleanup;
+	}
+
+	/* load BPF program */
+	err = bpf_object__load(obj);
+	if (err) {
+		fprintf(stderr, "ERROR: loading BPF object file failed\n");
+		goto cleanup;
+	}
+
+	sysfs_fd = open(sysfs_path, O_RDONLY);
+
+	bpf_object__for_each_program(prog, obj) {
+		progs[prog_count].fd = bpf_program__fd(prog);
+		progs[prog_count].type = bpf_program__get_expected_attach_type(prog);
+
+		err = bpf_prog_attach(progs[prog_count].fd,
+				      sysfs_fd,
+				      progs[prog_count].type,
+				      0);
+		if (err) {
+			fprintf(stderr, "bpf_prog_attach: err=%m\n");
+			progs[prog_count].fd = 0;
+			goto cleanup;
+		}
+		printf("attached BPF program with FD=%d, type=%d\n",
+		       progs[prog_count].fd, progs[prog_count].type);
+		prog_count++;
+	}
+
+	signal(SIGINT, int_exit);
+	signal(SIGTERM, int_exit);
+
+	err = bpf_obj_get_info_by_fd(progs[0].fd, &info, &info_len);
+	if (err) {
+		printf("can't get prog info - %s\n", strerror(errno));
+		goto cleanup;
+	}
+
+	cache = bpf_object__find_map_fd_by_name(obj, "cache");
+	if (cache < 0) {
+		printf("can't get 'cache' shared mem from object - %m\n");
+		goto cleanup;
+	}
+
+	wr_cache = bpf_object__find_map_fd_by_name(obj, "wr_cache");
+	if (wr_cache < 0) {
+		printf("can't get 'wr_cache' shared mem from object - %m\n");
+		goto cleanup;
+	}
+
+	mkfifo(fifoname, 0666);
+
+	fifo_fd = open(fifoname, O_RDWR);
+	if (fifo_fd < 0) {
+		perror("Fifo open error.\n");
+		err = fifo_fd;
+		goto cleanup;
+	}
+
+	while (1) {
+		n = read(fifo_fd, buf, BUFSIZ);
+		if (n < 0)
+			break;
+		buf[n] = 0;
+
+		printf("%s: received '%s'\n", __func__, buf);
+
+		m = sscanf(buf, "%16s %8s %d", param, op, &value);
+		if (m == 2 && strcmp(op, "get") == 0)
+			read_value(param);
+		else if (m == 3 && strcmp(op, "set") == 0)
+			write_value(param, value);
+	}
+
+	return 0;
+
+ cleanup:
+	for (prog_count--; prog_count >= 0; prog_count--) {
+		if (bpf_prog_detach2(progs[prog_count].fd, sysfs_fd, progs[prog_count].type))
+			fprintf(stderr, "bpf_prog_detach2: returned %m\n");
+	}
+
+	bpf_object__close(obj);
+	return err;
+}
+
+int main(int argc, char **argv)
+{
+	int opt;
+
+	while ((opt = getopt_long(argc, argv, "f:", long_options,
+				  NULL)) != -1) {
+		switch (opt) {
+		case 'f':
+			fifoname = optarg;
+			break;
+		default:
+			usage(basename(argv[0]));
+			return 1;
+		}
+	}
+
+	if (optind == argc) {
+		usage(basename(argv[0]));
+		return 1;
+	}
+
+	sysfs_path = argv[optind];
+	if (!sysfs_path) {
+		perror("hidraw");
+		return 1;
+	}
+
+	printf("fifoname: %s\n", fifoname);
+	printf("sysfs_path: %s\n", sysfs_path);
+
+	return attach_progs(argc, argv);
+}
-- 
2.25.1

