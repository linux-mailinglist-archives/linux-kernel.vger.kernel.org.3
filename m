Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6F85A295E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 16:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245585AbiHZO0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 10:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343950AbiHZOZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 10:25:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21093336E;
        Fri, 26 Aug 2022 07:25:52 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MDhqY1L0LzkWbH;
        Fri, 26 Aug 2022 22:22:17 +0800 (CST)
Received: from CHINA (10.175.102.38) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 26 Aug
 2022 22:25:50 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Mark Brown <broonie@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH -next 2/4] spi: mockup: Add writeable tracepoint for spi transfer
Date:   Fri, 26 Aug 2022 14:43:39 +0000
Message-ID: <20220826144341.532265-3-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220826144341.532265-1-weiyongjun1@huawei.com>
References: <20220826144341.532265-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add writeable tracepoint for transfer_one_message(), then bpf program can
be used to control read and write data from spi master, as mockup chip's
expectation.

For example:

  #include "vmlinux.h"
  #include <bpf/bpf_helpers.h>
  #include <bpf/bpf_tracing.h>

  SEC("raw_tp.w/spi_transfer_writeable")
  int BPF_PROG(spi_transfer_writeable_test, struct spi_msg_ctx *msg,
               u8 chip, unsigned int len, u8 tx_nbits, u8 rx_nbits)
  {
      if (tx_nbits)
          msg->data[0] = 0x20;

      return 0;
  }

  char LICENSE[] SEC("license") = "GPL";

This will be useful for writing spi device mockup backend.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/spi/Kconfig               |  1 +
 drivers/spi/spi-mockup.c          | 50 +++++++++++++++++++++++++++++--
 include/linux/spi/spi-mockup.h    | 13 ++++++++
 include/trace/events/spi_mockup.h | 32 ++++++++++++++++++++
 4 files changed, 94 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index b58a1bd7999d..e0f0fa2746ad 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1161,6 +1161,7 @@ config SPI_TLE62X0
 config SPI_MOCKUP
 	tristate "SPI controller Testing Driver"
 	depends on OF
+	select BPF_EVENTS
 	help
 	  This enables SPI controller testing driver, which provides a way to
 	  test SPI subsystem.
diff --git a/drivers/spi/spi-mockup.c b/drivers/spi/spi-mockup.c
index 06cf9d122d64..7a93b194ee53 100644
--- a/drivers/spi/spi-mockup.c
+++ b/drivers/spi/spi-mockup.c
@@ -13,6 +13,9 @@
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/spi_mockup.h>
+
 #define MOCKUP_CHIPSELECT_MAX		8
 
 struct mockup_spi {
@@ -149,13 +152,56 @@ static struct attribute *spi_mockup_attrs[] = {
 };
 ATTRIBUTE_GROUPS(spi_mockup);
 
+static int spi_mockup_transfer_writeable(struct spi_master *master,
+					 struct spi_message *msg)
+{
+	struct spi_msg_ctx *ctx;
+	struct spi_transfer *t;
+	int ret = 0;
+
+	ctx = kmalloc(sizeof(*ctx), GFP_ATOMIC);
+	if (!ctx)
+		return -ENOMEM;
+
+	list_for_each_entry(t, &msg->transfers, transfer_list) {
+		if (t->len > SPI_BUFSIZ_MAX)
+			return -E2BIG;
+
+		memset(ctx, 0, sizeof(*ctx));
+
+		if (t->tx_nbits)
+			memcpy(ctx->data, t->tx_buf, t->len);
+
+		trace_spi_transfer_writeable(ctx, msg->spi->chip_select, t->len,
+					     t->tx_nbits, t->rx_nbits);
+
+		if (ctx->ret) {
+			ret = ctx->ret;
+			break;
+		}
+
+		if (t->rx_nbits)
+			memcpy(t->rx_buf, ctx->data, t->len);
+		msg->actual_length += t->len;
+	}
+
+	kfree(ctx);
+
+	return ret;
+}
+
 static int spi_mockup_transfer(struct spi_master *master,
 			       struct spi_message *msg)
 {
-	msg->status = 0;
+	int ret = 0;
+
+	if (trace_spi_transfer_writeable_enabled())
+		ret = spi_mockup_transfer_writeable(master, msg);
+
+	msg->status = ret;
 	spi_finalize_current_message(master);
 
-	return 0;
+	return ret;
 }
 
 static int spi_mockup_probe(struct platform_device *pdev)
diff --git a/include/linux/spi/spi-mockup.h b/include/linux/spi/spi-mockup.h
new file mode 100644
index 000000000000..6a4fe88cb376
--- /dev/null
+++ b/include/linux/spi/spi-mockup.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __LINUX_SPI_MOCKUP_H
+#define __LINUX_SPI_MOCKUP_H
+
+#define SPI_BUFSIZ_MAX		0x1000
+
+struct spi_msg_ctx {
+	int ret;
+	__u8 data[SPI_BUFSIZ_MAX];
+};
+
+#endif
diff --git a/include/trace/events/spi_mockup.h b/include/trace/events/spi_mockup.h
new file mode 100644
index 000000000000..193302f8627a
--- /dev/null
+++ b/include/trace/events/spi_mockup.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * SPI mockup controller transfer writeable tracepoint
+ *
+ * Copyright(c) 2022 Huawei Technologies Co., Ltd.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM spi_mockup
+
+#if !defined(_TRACE_SPI_MOCKUP_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_SPI_MOCKUP_H
+
+#include <linux/tracepoint.h>
+#include <linux/spi/spi-mockup.h>
+
+#ifndef DECLARE_TRACE_WRITABLE
+#define DECLARE_TRACE_WRITABLE(call, proto, args, size) \
+	DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))
+#endif
+
+DECLARE_TRACE_WRITABLE(spi_transfer_writeable,
+	TP_PROTO(struct spi_msg_ctx *msg, u8 chip_select, unsigned int len,
+		 u8 tx_nbits, u8 rx_nbits),
+	TP_ARGS(msg, chip_select, len, tx_nbits, rx_nbits),
+	sizeof(struct spi_msg_ctx)
+);
+
+#endif /* _TRACE_SPI_MOCKUP_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.34.1

