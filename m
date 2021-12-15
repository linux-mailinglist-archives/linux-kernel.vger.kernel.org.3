Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540954759D9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242958AbhLONms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:42:48 -0500
Received: from mga02.intel.com ([134.134.136.20]:34641 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242923AbhLONmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:42:40 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="226509039"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="226509039"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 05:42:40 -0800
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="518774324"
Received: from cdobraun-mobl.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.251.212.15])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 05:42:37 -0800
From:   Tero Kristo <tero.kristo@linux.intel.com>
To:     linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        jikos@kernel.org, tero.kristo@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        peter.hutterer@who-t.net
Subject: [RFCv5 2/2] samples: hid-bpf: add HID USI samples
Date:   Wed, 15 Dec 2021 15:42:20 +0200
Message-Id: <20211215134220.1735144-3-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215134220.1735144-1-tero.kristo@linux.intel.com>
References: <20211215134220.1735144-1-tero.kristo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These samples add HID USI client and server code. These are not compiled
within kernel tree and are provided strictly as RFC only; the target for
these is to build them external to the kernel tree. The provided samples
run HID USI client-server communication over D-BUS.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 samples/bpf/hid_usi.h             |  21 ++
 samples/bpf/hid_usi_client.c      | 154 +++++++++++
 samples/bpf/hid_usi_server.c      | 438 ++++++++++++++++++++++++++++++
 samples/bpf/hid_usi_server_kern.c | 267 ++++++++++++++++++
 4 files changed, 880 insertions(+)
 create mode 100644 samples/bpf/hid_usi.h
 create mode 100644 samples/bpf/hid_usi_client.c
 create mode 100644 samples/bpf/hid_usi_server.c
 create mode 100644 samples/bpf/hid_usi_server_kern.c

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
diff --git a/samples/bpf/hid_usi_client.c b/samples/bpf/hid_usi_client.c
new file mode 100644
index 000000000000..81a956798f62
--- /dev/null
+++ b/samples/bpf/hid_usi_client.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021, Intel Corporation
+ */
+
+#include <stdio.h>
+#include <gio/gio.h>
+#include <getopt.h>
+
+static void usi_var_get(GDBusProxy *proxy, const char *var)
+{
+	GVariant *result;
+	unsigned int val;
+	const GVariantType *type;
+	char *str;
+
+	result = g_dbus_proxy_get_cached_property(proxy, var);
+	type = g_variant_get_type(result);
+	if (g_variant_type_equal(type, G_VARIANT_TYPE_UINT32)) {
+		g_variant_get(result, "u", &val);
+		printf("Value for %s (u): %u\n", var, val);
+	} else if (g_variant_type_equal(type, G_VARIANT_TYPE_STRING)) {
+		g_variant_get(result, "&s", &str);
+		printf("Value for %s (s): %s\n", var, str);
+	} else {
+		printf("Unsupported type %s for %s\n",
+		       g_variant_get_type_string(result), var);
+	}
+	g_variant_unref(result);
+}
+
+static void usi_dump_vars(GDBusProxy *proxy)
+{
+	gchar **vars;
+	int i;
+
+	vars = g_dbus_proxy_get_cached_property_names(proxy);
+
+	i = 0;
+	while (vars && vars[i]) {
+		usi_var_get(proxy, vars[i]);
+		i++;
+	}
+
+	g_strfreev(vars);
+}
+
+static void usi_var_set(GDBusProxy *proxy, const char *var, unsigned int value)
+{
+	GError *error = NULL;
+
+	g_dbus_proxy_call_sync(proxy,
+			       "org.freedesktop.DBus.Properties.Set",
+			       g_variant_new("(su)", var, value),
+			       G_DBUS_CALL_FLAGS_NONE, -1, NULL, &error);
+
+	g_assert_no_error(error);
+}
+
+static void usage(void)
+{
+	extern const char *__progname;
+
+	printf("Usage: %s [--help] [--dump] [--color] [--width] [--style] [value]\n",
+	       __progname);
+
+	printf("\nOptions:\n");
+	printf("    --help, -h          this help text\n");
+	printf("    --color [value]     gets/sets stylus color\n");
+	printf("    --width [value]     gets/sets stylus line width\n");
+	printf("    --style [value]     gets/sets stylus line style\n");
+	printf("    --dump              dump all variables\n");
+}
+
+int main(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+	GDBusConnection *conn;
+	GError *error = NULL;
+	const char *version;
+	GVariant *variant;
+	const char *var = NULL;
+	static struct option options[] = {
+		{ "help", no_argument, NULL, 'h' },
+		{ "color", no_argument, NULL, 'c' },
+		{ "width", no_argument, NULL, 'w' },
+		{ "style", no_argument, NULL, 's' },
+		{ "dump", no_argument, NULL, 'd' },
+	};
+	int opt;
+	int retval = 0;
+	unsigned int value;
+
+	conn = g_bus_get_sync(G_BUS_TYPE_SESSION, NULL, &error);
+	g_assert_no_error(error);
+
+	proxy = g_dbus_proxy_new_sync(conn,
+				      G_DBUS_PROXY_FLAGS_NONE,
+				      NULL,				/* GDBusInterfaceInfo */
+				      "org.universalstylus.PenServer",		/* name */
+				      "/org/universalstylus/Pen",	/* object path */
+				      "org.universalstylus.PenInterface",	/* interface */
+				      NULL,				/* GCancellable */
+				      &error);
+	g_assert_no_error(error);
+
+	/* read the version property of the interface */
+	variant = g_dbus_proxy_get_cached_property(proxy, "Version");
+	g_assert(variant != NULL);
+	g_variant_get(variant, "s", &version);
+	g_variant_unref(variant);
+	printf("Server version v%s\n", version);
+
+	while ((opt = getopt_long(argc, argv, "hcwsd", options, NULL)) != -1) {
+		switch (opt) {
+		case 'c':
+			var = "LineColor";
+			break;
+		case 'w':
+			var = "LineWidth";
+			break;
+		case 's':
+			var = "LineStyle";
+			break;
+		case 'd':
+			usi_dump_vars(proxy);
+			goto exit;
+
+		default:
+			usage();
+			retval = EXIT_FAILURE;
+			goto exit;
+		}
+	}
+
+	if (!var) {
+		usage();
+		retval = EXIT_FAILURE;
+		goto exit;
+	}
+	if (argc == optind) {
+		usi_var_get(proxy, var);
+	} else if (argc == optind + 1) {
+		value = atoi(argv[argc - 1]);
+		usi_var_set(proxy, var, value);
+	} else {
+		usage();
+		retval = EXIT_FAILURE;
+	}
+
+exit:
+	g_object_unref(proxy);
+	g_object_unref(conn);
+	return retval;
+}
diff --git a/samples/bpf/hid_usi_server.c b/samples/bpf/hid_usi_server.c
new file mode 100644
index 000000000000..6d2012b018ac
--- /dev/null
+++ b/samples/bpf/hid_usi_server.c
@@ -0,0 +1,438 @@
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
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <dbus/dbus.h>
+#include <dbus/dbus-glib-lowlevel.h>
+#include <glib.h>
+
+#include "bpf_util.h"
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+
+#include <sys/stat.h>
+
+#include "hid_usi.h"
+
+static const char *version = "0.5";
+static GMainLoop *mainloop;
+
+static char *sysfs_path;
+static int sysfs_fd;
+static int prog_count;
+static int cache, wr_cache;
+
+static const struct option long_options[] = {
+	{ "help", no_argument, NULL, 'h' },
+};
+
+struct prog {
+	int fd;
+	enum bpf_attach_type type;
+};
+
+static struct prog progs[10];
+
+static const char *server_introspection_xml =
+	DBUS_INTROSPECT_1_0_XML_DOCTYPE_DECL_NODE
+	"<node>\n"
+	"  <interface name='org.freedesktop.DBus.Introspectable'>\n"
+	"    <method name='Introspect'>\n"
+	"      <arg name='data' type='s' direction='out' />\n"
+	"    </method>\n"
+	"  </interface>\n"
+
+	"  <interface name='org.freedesktop.DBus.Properties'>\n"
+	"    <method name='Get'>\n"
+	"      <arg name='property'  type='s' direction='in' />\n"
+	"      <arg name='value'     type='s' direction='out' />\n"
+	"    </method>\n"
+	"    <method name='Set'>\n"
+	"      <arg name='property'  type='s' direction='in' />\n"
+	"      <arg name='value'     type='u' direction='in' />\n"
+	"    </method>\n"
+	"    <method name='GetAll'>\n"
+	"      <arg name='properties' type='a{sv}' direction='out'/>\n"
+	"    </method>\n"
+	"  </interface>\n"
+
+	"  <interface name='org.universalstylus.PenInterface'>\n"
+	"    <property name='Version' type='s' access='read' />\n"
+	"    <property name='LineColor' type='u' access='readwrite' />\n"
+	"    <property name='LineWidth' type='u' access='readwrite' />\n"
+	"    <property name='LineStyle' type='u' access='readwrite' />\n"
+	"  </interface>\n"
+	"</node>\n";
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
+	exit(0);
+}
+
+static void usage(const char *prog)
+{
+	fprintf(stderr,
+		"usage: %s /sys/bus/hid/devices/<dev>/modalias\n\n",
+		prog);
+}
+
+static int param_to_idx(const char *param)
+{
+	if (!strcmp(param, "LineColor"))
+		return USI_PEN_COLOR;
+	if (!strcmp(param, "LineWidth"))
+		return USI_PEN_LINE_WIDTH;
+	if (!strcmp(param, "LineStyle"))
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
+	if (err) {
+		printf("Update failed for %d, err=%d\n", idx, err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int read_value(const char *param)
+{
+	int value = -ENOENT;
+	int idx = param_to_idx(param);
+
+	bpf_map_lookup_elem(cache, &idx, &value);
+
+	return value;
+}
+
+static DBusHandlerResult usi_set_prop(DBusConnection *conn, DBusError *err,
+				      DBusMessage *msg, DBusMessage *reply)
+{
+	const char *property;
+	unsigned int value;
+	int ret;
+
+	if (!dbus_message_get_args(msg, err,
+				   DBUS_TYPE_STRING, &property,
+				   DBUS_TYPE_UINT32, &value,
+				   DBUS_TYPE_INVALID))
+		return -1;
+
+	if (write_value(property, value) < 0)
+		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+
+	return DBUS_HANDLER_RESULT_HANDLED;
+}
+
+static DBusHandlerResult usi_get_prop(DBusConnection *conn, DBusError *err,
+				      DBusMessage *msg, DBusMessage *reply)
+{
+	const char *property;
+	int value;
+
+	if (!dbus_message_get_args(msg, err,
+				   DBUS_TYPE_STRING, &property,
+				   DBUS_TYPE_INVALID))
+		return -1;
+
+	if (!strcmp(property, "Version")) {
+		dbus_message_append_args(reply,
+					 DBUS_TYPE_STRING, &version,
+					 DBUS_TYPE_INVALID);
+	} else {
+		value = read_value(property);
+		if (value < 0)
+			return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+
+		dbus_message_append_args(reply,
+					 DBUS_TYPE_UINT32, &value,
+					 DBUS_TYPE_INVALID);
+	}
+
+	return DBUS_HANDLER_RESULT_HANDLED;
+}
+
+static DBusHandlerResult usi_get_all_props(DBusConnection *conn, DBusError *err,
+					   DBusMessage *reply)
+{
+	DBusMessageIter array, dict, iter, variant;
+	const char *props[] = {
+		"Version", "LineColor", "LineWidth", "LineStyle"
+	};
+	const char *types[] = { "s", "u", "u", "u" };
+	int i;
+	unsigned int value;
+	void *ptr;
+	int itype;
+
+	dbus_message_iter_init_append(reply, &iter);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, "{sv}", &array);
+
+	for (i = 0; i < ARRAY_SIZE(props); i++) {
+		dbus_message_iter_open_container(&array, DBUS_TYPE_DICT_ENTRY, NULL, &dict);
+		dbus_message_iter_append_basic(&dict, DBUS_TYPE_STRING, &props[i]);
+		dbus_message_iter_open_container(&dict, DBUS_TYPE_VARIANT, types[i], &variant);
+		if (i == 0) {
+			ptr = &version;
+			itype = DBUS_TYPE_STRING;
+		} else {
+			value = read_value(props[i]);
+			ptr = &value;
+			itype = DBUS_TYPE_UINT32;
+		}
+		dbus_message_iter_append_basic(&variant, itype, ptr);
+		dbus_message_iter_close_container(&dict, &variant);
+		dbus_message_iter_close_container(&array, &dict);
+	}
+
+	dbus_message_iter_close_container(&iter, &array);
+
+	return DBUS_HANDLER_RESULT_HANDLED;
+}
+
+static DBusHandlerResult usi_message_handler(DBusConnection *conn,
+					     DBusMessage *message, void *data)
+{
+	DBusHandlerResult result = DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+	DBusMessage *reply;
+	DBusError err;
+	int value;
+
+	fprintf(stderr, "Got D-Bus request: %s.%s on %s\n",
+		dbus_message_get_interface(message),
+		dbus_message_get_member(message),
+		dbus_message_get_path(message));
+
+	dbus_error_init(&err);
+
+	reply = dbus_message_new_method_return(message);
+	if (!reply)
+		return DBUS_HANDLER_RESULT_NEED_MEMORY;
+
+	if (dbus_message_is_method_call(message, DBUS_INTERFACE_INTROSPECTABLE, "Introspect")) {
+		dbus_message_append_args(reply,
+					 DBUS_TYPE_STRING, &server_introspection_xml,
+					 DBUS_TYPE_INVALID);
+
+	} else if (dbus_message_is_method_call(message, DBUS_INTERFACE_PROPERTIES, "Get")) {
+		result = usi_get_prop(conn, &err, message, reply);
+	} else if (dbus_message_is_method_call(message, DBUS_INTERFACE_PROPERTIES, "GetAll")) {
+		result = usi_get_all_props(conn, &err, reply);
+	} else if (dbus_message_is_method_call(message, DBUS_INTERFACE_PROPERTIES, "Set")) {
+		result = usi_set_prop(conn, &err, message, reply);
+	} else {
+		dbus_message_unref(reply);
+		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+	}
+
+	if (dbus_error_is_set(&err)) {
+		dbus_message_unref(reply);
+
+		reply = dbus_message_new_error(message, err.name, err.message);
+		dbus_error_free(&err);
+
+		if (!reply)
+			return DBUS_HANDLER_RESULT_NEED_MEMORY;
+	}
+
+	result = DBUS_HANDLER_RESULT_HANDLED;
+
+	if (!dbus_connection_send(conn, reply, NULL))
+		result = DBUS_HANDLER_RESULT_NEED_MEMORY;
+
+	dbus_message_unref(reply);
+
+	return result;
+}
+
+const DBusObjectPathVTable usi_vtable = {
+	.message_function = usi_message_handler,
+};
+
+static int server_run(void)
+{
+	DBusConnection *conn;
+	DBusError err;
+	int rv;
+
+	dbus_error_init(&err);
+
+	conn = dbus_bus_get(DBUS_BUS_SESSION, &err);
+	if (!conn) {
+		fprintf(stderr, "Failed to get a session DBus connection: %s\n", err.message);
+		goto fail;
+	}
+
+	rv = dbus_bus_request_name(conn, "org.universalstylus.PenServer",
+				   DBUS_NAME_FLAG_REPLACE_EXISTING, &err);
+	if (rv != DBUS_REQUEST_NAME_REPLY_PRIMARY_OWNER) {
+		fprintf(stderr, "Failed to request name on bus: %s\n", err.message);
+		goto fail;
+	}
+
+	if (!dbus_connection_register_object_path(conn,
+						  "/org/universalstylus/Pen",
+						  &usi_vtable, NULL)) {
+		fprintf(stderr, "Failed to register a object path for 'Pen'\n");
+		goto fail;
+	}
+
+	printf("Starting dbus USI server v%s\n", version);
+	mainloop = g_main_loop_new(NULL, false);
+	dbus_connection_setup_with_g_main(conn, NULL);
+	g_main_loop_run(mainloop);
+
+	return 0;
+fail:
+	dbus_error_free(&err);
+	return -1;
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
+	struct sockaddr_un addr;
+	struct sockaddr_un from;
+	socklen_t from_len = sizeof(from);
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
+	server_run();
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
+	while ((opt = getopt_long(argc, argv, "h", long_options,
+				  NULL)) != -1) {
+		switch (opt) {
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
+	printf("sysfs_path: %s\n", sysfs_path);
+
+	return attach_progs(argc, argv);
+}
diff --git a/samples/bpf/hid_usi_server_kern.c b/samples/bpf/hid_usi_server_kern.c
new file mode 100644
index 000000000000..3ecf638fb94d
--- /dev/null
+++ b/samples/bpf/hid_usi_server_kern.c
@@ -0,0 +1,267 @@
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
+#define MS_TO_JIFFIES(t) ((t) * HZ / 1000)
+
+static const char param_names[USI_NUM_PARAMS][6] = {
+	"id",
+	"range",
+	"touch",
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
+static bool work_pending;
+static u64 last_pen_event;
+
+SEC("hid/work")
+int hid_work(struct hid_bpf_ctx *ctx)
+{
+	int i, tmp;
+	int *wrc, *c;
+	u8 *buf;
+	bool have_work = false;
+
+	for (i = USI_PEN_COLOR; i < USI_NUM_PARAMS; i++) {
+		tmp = i;
+
+		wrc = bpf_map_lookup_elem(&wr_cache, &tmp);
+		c = bpf_map_lookup_elem(&cache, &tmp);
+
+		if (!wrc || !c)
+			continue;
+
+		if (*wrc == -1)
+			continue;
+
+		if (*wrc != *c) {
+			bpf_printk("updating %s to %x", param_names[i],
+				   *wrc);
+			buf = bpf_ringbuf_reserve(&ringbuf, 16, 0);
+			if (!buf)
+				continue;
+
+			buf[0] = features[i].idx;
+			buf[1] = 1;
+			if (i == USI_PEN_LINE_STYLE && *wrc == 6)
+				buf[2] = 255;
+			else
+				buf[2] = *wrc;
+
+			bpf_hid_raw_request(ctx, buf, 3,
+					    HID_FEATURE_REPORT,
+					    HID_REQ_SET_REPORT);
+
+			bpf_ringbuf_discard(buf, 0);
+
+			*c = *wrc;
+
+			*wrc = -1;
+
+			have_work = true;
+			break;
+		}
+	}
+
+	if (have_work)
+		bpf_hid_schedule_work(ctx, MS_TO_JIFFIES(100));
+	else
+		work_pending = false;
+
+	return 0;
+}
+
+SEC("hid/raw_event")
+int hid_raw_event(struct hid_bpf_ctx *ctx)
+{
+	u32 i;
+	u32 tmp;
+	int val, new_val;
+	int *wrc, *c;
+	u8 *buf;
+	u32 flags = 0;
+	int offset;
+	int size;
+	int in_range;
+	int touching;
+	u64 jiffies;
+
+	if (ctx->event.data[0] != inputs[USI_PEN_IN_RANGE].idx)
+		return 0;
+
+	in_range = bpf_hid_get_data(ctx, inputs[USI_PEN_IN_RANGE].offset,
+				    inputs[USI_PEN_IN_RANGE].size);
+	touching = bpf_hid_get_data(ctx, inputs[USI_PEN_TOUCHING].offset,
+				    inputs[USI_PEN_TOUCHING].size);
+
+	if (!touching) {
+		last_pen_event = 0;
+		return 0;
+	}
+
+	jiffies = bpf_jiffies64();
+
+	if (!last_pen_event)
+		last_pen_event = jiffies;
+
+	for (i = USI_PEN_COLOR; i < USI_NUM_PARAMS; i++) {
+		offset = inputs[i].offset;
+		size = inputs[i].size;
+		val = bpf_hid_get_data(ctx, offset, size);
+
+		new_val = val;
+		if (i == USI_PEN_LINE_STYLE && new_val == 255)
+			new_val = 6;
+
+		/*
+		 * Make a local copy of 'i' which we can refer via a
+		 * pointer to satisfy BPF verifier.
+		 */
+		tmp = i;
+
+		wrc = bpf_map_lookup_elem(&wr_cache, &tmp);
+		c = bpf_map_lookup_elem(&cache, &tmp);
+		if (!wrc || !c)
+			continue;
+
+		if (*wrc != -1 && *wrc != *c && !work_pending) {
+			bpf_hid_schedule_work(ctx, MS_TO_JIFFIES(200));
+			work_pending = true;
+		}
+
+		if (jiffies < last_pen_event + MS_TO_JIFFIES(200))
+			*c = new_val;
+
+		if (new_val != *c)
+			new_val = *c;
+
+		if (new_val != val)
+			bpf_hid_set_data(ctx, offset, size, new_val);
+	}
+
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
+	int *wrc;
+	int i, tmp;
+
+	if (ctx->type != HID_BPF_RDESC_FIXUP)
+		return 0;
+
+	ret = bpf_hid_foreach_rdesc_item(ctx, process_hid_rdesc_item, (void *)0, 0);
+	for (i = USI_PEN_COLOR; i < USI_NUM_PARAMS; i++) {
+		tmp = i;
+		wrc = bpf_map_lookup_elem(&wr_cache, &tmp);
+		if (!wrc)
+			continue;
+		*wrc = -1;
+	}
+
+	bpf_printk("ret: %d", ret);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
+u32 _version SEC("version") = LINUX_VERSION_CODE;
-- 
2.25.1

