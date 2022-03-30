Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759E44ECF8D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 00:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351600AbiC3WUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 18:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351534AbiC3WU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 18:20:29 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B9127B33;
        Wed, 30 Mar 2022 15:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648678723; x=1680214723;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H1KpTa0+fBlmVghgQCEOE2xle7VZSq8pDfmVLiOn1qo=;
  b=JjbqMzFVYIQEpW5kNJ3YqGaHAEolEvANByBRh4Yk9KnwVy6Im7nplpak
   RoLDlAuWYYv/mybHT3PSIvuo2XNXU1M9emblS5rDIJpyyxgc7FrvOOOII
   9rhq0Sn08/99qQdx28BmN/7g1YwrwRvO9iWpWdYfA+HQeHfuw17e8XkL6
   mcjPqwVhrfSdXzIbr/1pCzqiLLw7ib3EXg1tutJHnI55vjWE/Rzj9o/M9
   Q9PramKp5ZFQjS5yHnj1vQMVrPSc9T2Br4FaxAbuw3zW62iXtEqRWIcD6
   S2XxqzE8NQGYrC6AFZEF7szwqpoOfSosEsNwUEqns5dCBr482N10af60J
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="346095999"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="346095999"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 15:18:25 -0700
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="788171913"
Received: from ksanitha-mobl3.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.209.123.221])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 15:18:24 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 6/6] tools/tdx: Add a sample attestation user app
Date:   Wed, 30 Mar 2022 15:18:05 -0700
Message-Id: <9247fade9db5ae6eb183b2f92fdedb898282376a.1648664666.git.sathyanarayanan.kuppuswamy@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648664666.git.sathyanarayanan.kuppuswamy@intel.com>
References: <cover.1648664666.git.sathyanarayanan.kuppuswamy@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This application uses the misc device /dev/tdx-attest to get TDREPORT
from the TDX Module or request quote from the VMM.

It tests following attestation features:

  - Get report using TDX_CMD_GET_TDREPORT IOCTL.
  - Using report data request quote from VMM using TDX_CMD_GEN_QUOTE IOCTL.
  - Get the quote size using TDX_CMD_GET_QUOTE_SIZE IOCTL.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 tools/Makefile                              |  16 +-
 tools/arch/x86/tdx/Makefile                 |  19 ++
 tools/arch/x86/tdx/attest/.gitignore        |   2 +
 tools/arch/x86/tdx/attest/Makefile          |  24 ++
 tools/arch/x86/tdx/attest/tdx-attest-test.c | 263 ++++++++++++++++++++
 5 files changed, 321 insertions(+), 3 deletions(-)
 create mode 100644 tools/arch/x86/tdx/Makefile
 create mode 100644 tools/arch/x86/tdx/attest/.gitignore
 create mode 100644 tools/arch/x86/tdx/attest/Makefile
 create mode 100644 tools/arch/x86/tdx/attest/tdx-attest-test.c

diff --git a/tools/Makefile b/tools/Makefile
index db2f7b8ebed5..87b597754a55 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -30,6 +30,7 @@ help:
 	@echo '  selftests              - various kernel selftests'
 	@echo '  bootconfig             - boot config tool'
 	@echo '  spi                    - spi tools'
+	@echo '  tdx                    - TDX related test tools'
 	@echo '  tmon                   - thermal monitoring and tuning tool'
 	@echo '  tracing                - misc tracing tools'
 	@echo '  turbostat              - Intel CPU idle stats and freq reporting tool'
@@ -97,11 +98,14 @@ freefall: FORCE
 kvm_stat: FORCE
 	$(call descend,kvm/$@)
 
+tdx: FORCE
+	$(call descend,arch/x86/$@)
+
 all: acpi cgroup counter cpupower gpio hv firewire \
 		perf selftests bootconfig spi turbostat usb \
 		virtio vm bpf x86_energy_perf_policy \
 		tmon freefall iio objtool kvm_stat wmi \
-		pci debugging tracing
+		pci debugging tracing tdx
 
 acpi_install:
 	$(call descend,power/$(@:_install=),install)
@@ -127,13 +131,16 @@ freefall_install:
 kvm_stat_install:
 	$(call descend,kvm/$(@:_install=),install)
 
+tdx_install:
+	$(call descend,arch/x86/$(@:_install=),install)
+
 install: acpi_install cgroup_install counter_install cpupower_install gpio_install \
 		hv_install firewire_install iio_install \
 		perf_install selftests_install turbostat_install usb_install \
 		virtio_install vm_install bpf_install x86_energy_perf_policy_install \
 		tmon_install freefall_install objtool_install kvm_stat_install \
 		wmi_install pci_install debugging_install intel-speed-select_install \
-		tracing_install
+		tracing_install tdx_install
 
 acpi_clean:
 	$(call descend,power/acpi,clean)
@@ -172,11 +179,14 @@ freefall_clean:
 build_clean:
 	$(call descend,build,clean)
 
+tdx_clean:
+	$(call descend,arch/x86/$(@:_clean=),clean)
+
 clean: acpi_clean cgroup_clean counter_clean cpupower_clean hv_clean firewire_clean \
 		perf_clean selftests_clean turbostat_clean bootconfig_clean spi_clean usb_clean virtio_clean \
 		vm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
 		freefall_clean build_clean libbpf_clean libsubcmd_clean \
 		gpio_clean objtool_clean leds_clean wmi_clean pci_clean firmware_clean debugging_clean \
-		intel-speed-select_clean tracing_clean
+		intel-speed-select_clean tracing_clean tdx_clean
 
 .PHONY: FORCE
diff --git a/tools/arch/x86/tdx/Makefile b/tools/arch/x86/tdx/Makefile
new file mode 100644
index 000000000000..64217dd21d5c
--- /dev/null
+++ b/tools/arch/x86/tdx/Makefile
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0
+include ../../../scripts/Makefile.include
+
+all: attest
+
+clean: attest_clean
+
+install: attest_install
+
+attest:
+	$(call descend,attest)
+
+attest_install:
+	$(call descend,attest,install)
+
+attest_clean:
+	$(call descend,attest,clean)
+
+.PHONY: all install clean attest latency_install latency_clean
diff --git a/tools/arch/x86/tdx/attest/.gitignore b/tools/arch/x86/tdx/attest/.gitignore
new file mode 100644
index 000000000000..5f819a8a6c49
--- /dev/null
+++ b/tools/arch/x86/tdx/attest/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+tdx-attest-test
diff --git a/tools/arch/x86/tdx/attest/Makefile b/tools/arch/x86/tdx/attest/Makefile
new file mode 100644
index 000000000000..e5ae961c988d
--- /dev/null
+++ b/tools/arch/x86/tdx/attest/Makefile
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for vm tools
+#
+VAR_CFLAGS := $(shell pkg-config --cflags libtracefs 2>/dev/null)
+VAR_LDLIBS := $(shell pkg-config --libs libtracefs 2>/dev/null)
+
+TARGETS = tdx-attest-test
+CFLAGS = -static -Wall -I../../../../include -Wextra -g -O2 $(VAR_CFLAGS)
+LDFLAGS = -lpthread $(VAR_LDLIBS)
+
+all: $(TARGETS)
+
+%: %.c
+	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS)
+
+clean:
+	$(RM) tdx-attest-test
+
+prefix ?= /usr/local
+sbindir ?= ${prefix}/sbin
+
+install: all
+	install -d $(DESTDIR)$(sbindir)
+	install -m 755 -p $(TARGETS) $(DESTDIR)$(sbindir)
diff --git a/tools/arch/x86/tdx/attest/tdx-attest-test.c b/tools/arch/x86/tdx/attest/tdx-attest-test.c
new file mode 100644
index 000000000000..ce7b8e77c772
--- /dev/null
+++ b/tools/arch/x86/tdx/attest/tdx-attest-test.c
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * tdx-attest-test.c - utility to test TDX attestation feature.
+ *
+ * Copyright (C) 2021 - 2022 Intel Corporation. All rights reserved.
+ *
+ * Author: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <stdio.h>
+#include <ctype.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <limits.h>
+#include <stdbool.h>
+#include <getopt.h>
+#include <stdint.h> /* uintmax_t */
+#include <sys/mman.h>
+#include <time.h>
+
+#include "../../../../../include/uapi/misc/tdx.h"
+
+#define devname		"/dev/tdx-attest"
+
+#define HEX_DUMP_SIZE	16
+#define MAX_ROW_SIZE	70
+
+/* length of trans_len */
+#define REPORT_HEADER_SIZE	4
+/* version, status, in_len, out_len */
+#define QUOTE_HEADER_SIZE	24
+
+#define ATTESTATION_TEST_BIN_VERSION "0.1"
+
+struct tdx_attest_args {
+	bool is_dump_data;
+	bool is_get_tdreport;
+	bool is_get_quote_size;
+	bool is_gen_quote;
+	bool debug_mode;
+	char *out_file;
+};
+
+struct tdx_quote_blob {
+	uint64_t version;
+	uint64_t status;
+	uint32_t in_len;
+	uint32_t out_len;
+	int8_t trans_len[4];
+	uint8_t data;
+};
+
+static void print_hex_dump(const char *title, const char *prefix_str,
+			   const void *buf, int len)
+{
+	const __u8 *ptr = buf;
+	int i, rowsize = HEX_DUMP_SIZE;
+
+	if (!len || !buf)
+		return;
+
+	printf("\t\t%s", title);
+
+	for (i = 0; i < len; i++) {
+		if (!(i % rowsize))
+			printf("\n%s%.8x:", prefix_str, i);
+		printf(" %.2x", ptr[i]);
+	}
+
+	printf("\n");
+}
+
+static void gen_report_data(__u8 *report_data, bool dump_data)
+{
+	int i;
+
+	srand(time(NULL));
+
+	for (i = 0; i < TDX_REPORT_DATA_LEN; i++)
+		report_data[i] = rand();
+
+	if (dump_data)
+		print_hex_dump("\n\t\tTDX report data\n", " ",
+			       report_data, TDX_REPORT_DATA_LEN);
+}
+
+static int get_tdreport(int devfd, bool dump_data, __u8 *report_data)
+{
+	__u8 tdrdata[TDX_TDREPORT_LEN] = {0};
+	int ret;
+
+	if (!report_data)
+		report_data = tdrdata;
+
+	gen_report_data(report_data, dump_data);
+
+	ret = ioctl(devfd, TDX_CMD_GET_TDREPORT, report_data);
+	if (ret) {
+		printf("TDX_CMD_GET_TDREPORT ioctl() %d failed\n", ret);
+		return -EIO;
+	}
+
+	if (dump_data)
+		print_hex_dump("\n\t\tTDX tdreport data\n", " ", report_data,
+			       TDX_TDREPORT_LEN);
+
+	return 0;
+}
+
+static __u64 get_quote_size(int devfd)
+{
+	int ret;
+	__u64 quote_size;
+
+	ret = ioctl(devfd, TDX_CMD_GET_QUOTE_SIZE, &quote_size);
+	if (ret) {
+		printf("TDX_CMD_GET_QUOTE_SIZE ioctl() %d failed\n", ret);
+		return -EIO;
+	}
+
+	printf("Quote size: %lld\n", quote_size);
+
+	return quote_size;
+}
+
+static int gen_quote(int devfd, bool dump_data)
+{
+	__u64 quote_size, quote_new_size;
+	struct tdx_quote_blob *quote_blob;
+	struct tdx_gen_quote getquote_arg;
+	__u8 *quote_data;
+	int ret;
+
+	quote_size = get_quote_size(devfd);
+
+	quote_new_size = sizeof(*quote_blob) + sizeof(char) * quote_size;
+
+	quote_data = malloc(quote_new_size);
+	if (!quote_data) {
+		printf("%s queue data alloc failed\n", devname);
+		return -ENOMEM;
+	}
+
+	quote_blob = (struct tdx_quote_blob *)quote_data;
+
+	ret = get_tdreport(devfd, dump_data, &quote_blob->data);
+	if (ret) {
+		printf("TDX_CMD_GET_TDREPORT ioctl() %d failed\n", ret);
+		goto done;
+	}
+
+	quote_blob->version = 1;
+	quote_blob->status = 0;
+	quote_blob->trans_len[0] = (uint8_t)((TDX_TDREPORT_LEN >> 24) & 0xFF);
+	quote_blob->trans_len[1] = (uint8_t)((TDX_TDREPORT_LEN >> 16) & 0xFF);
+	quote_blob->trans_len[2] = (uint8_t)((TDX_TDREPORT_LEN >> 8) & 0xFF);
+	quote_blob->trans_len[3] = (uint8_t)((TDX_TDREPORT_LEN) & 0xFF);
+	quote_blob->in_len = REPORT_HEADER_SIZE + TDX_TDREPORT_LEN;
+	quote_blob->out_len = quote_new_size - QUOTE_HEADER_SIZE;
+
+	getquote_arg.buf = quote_data;
+	getquote_arg.len = quote_new_size;
+
+	ret = ioctl(devfd, TDX_CMD_GEN_QUOTE, &getquote_arg);
+	if (ret) {
+		printf("TDX_CMD_GEN_QUOTE ioctl() %d failed\n", ret);
+		goto done;
+	}
+
+	print_hex_dump("\n\t\tTDX Quote data\n", " ", &quote_blob->data,
+		       quote_size);
+
+done:
+	free(quote_data);
+
+	return ret;
+}
+
+static void usage(void)
+{
+	puts("\nUsage:\n");
+	puts("tdx_attest [options]\n");
+
+	puts("Attestation device test utility.");
+
+	puts("\nOptions:\n");
+	puts(" -d, --dump                Dump tdreport/tdquote data");
+	puts(" -r, --get-tdreport        Get TDREPORT data");
+	puts(" -g, --gen-quote           Generate TDQUOTE");
+	puts(" -s, --get-quote-size      Get TDQUOTE size");
+}
+
+int main(int argc, char **argv)
+{
+	int ret, devfd;
+	struct tdx_attest_args args = {0};
+
+	static const struct option longopts[] = {
+		{ "dump",           no_argument,       NULL, 'd' },
+		{ "get-tdreport",   required_argument, NULL, 'r' },
+		{ "gen-quote",      required_argument, NULL, 'g' },
+		{ "gen-quote-size", required_argument, NULL, 's' },
+		{ "version",        no_argument,       NULL, 'V' },
+		{ NULL,             0, NULL, 0 }
+	};
+
+	while ((ret = getopt_long(argc, argv, "hdrgsV", longopts,
+				  NULL)) != -1) {
+		switch (ret) {
+		case 'd':
+			args.is_dump_data = true;
+			break;
+		case 'r':
+			args.is_get_tdreport = true;
+			break;
+		case 'g':
+			args.is_gen_quote = true;
+			break;
+		case 's':
+			args.is_get_quote_size = true;
+			break;
+		case 'h':
+			usage();
+			return 0;
+		case 'V':
+			printf("Version: %s\n", ATTESTATION_TEST_BIN_VERSION);
+			return 0;
+		default:
+			printf("Invalid options\n");
+			usage();
+			return -EINVAL;
+		}
+	}
+
+	devfd = open(devname, O_RDWR | O_SYNC);
+	if (devfd < 0) {
+		printf("%s open() failed\n", devname);
+		return -ENODEV;
+	}
+
+	if (args.is_get_quote_size)
+		get_quote_size(devfd);
+
+	if (args.is_get_tdreport)
+		get_tdreport(devfd, args.is_dump_data, NULL);
+
+	if (args.is_gen_quote)
+		gen_quote(devfd, args.is_dump_data);
+
+	close(devfd);
+
+	return 0;
+}
-- 
2.25.1

