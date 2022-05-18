Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B7152B5F6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbiERJSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbiERJSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:18:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26241A051
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:18:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86E4D616F9
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 09:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4ADC385A5;
        Wed, 18 May 2022 09:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652865512;
        bh=6rLezUzKWqLKI6DG7y/Y4pd3Z/CMgk7TBbjkXlTm+bI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tiHDPQCAGNn7tl+lYKAdpfAzId9qq0doC26nQk5npNanuU06Ur7/SgEOp7JHo0UPM
         uUxABiSkTi6bBAFjfcjJEuOOuHaSuPJJ23gV4h/NbFTJ2b/m6GVBT76h7WggpGGFyK
         v/gqsA6kAqPHh0bQgj5CdoDFajvoBcXSQoBnV27S1D9dhW1Zjc/M9W7Jc5ArqRGZ3V
         N09Atl4MgfP5egu8wnxoaLFLekxUJmjrugkcM1EgdHDe8Uzek8AuNaDFxeVvM2UHd0
         PZktenEhT/FMv07fZbzkMyUEgft3WYVMk34R8IzOlzK3KLaa4U4AaEWdnkNkVheoh4
         TWgMeWSYAlFXw==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        tzungbi@kernel.org, dianders@chromium.org
Subject: [PATCH 1/4] platform/chrome: cros_ec_proto: add Kunit tests for cros_ec_prepare_tx()
Date:   Wed, 18 May 2022 17:18:11 +0800
Message-Id: <20220518091814.2028579-2-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
In-Reply-To: <20220518091814.2028579-1-tzungbi@kernel.org>
References: <20220518091814.2028579-1-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cros_ec_prepare_tx() is used to fill the protocol headers according to
the requested protocol version.

Add Kunit tests cros_ec_prepare_tx() for each version.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/Kconfig              |   9 +
 drivers/platform/chrome/Makefile             |   3 +
 drivers/platform/chrome/cros_ec_proto_test.c | 173 +++++++++++++++++++
 3 files changed, 185 insertions(+)
 create mode 100644 drivers/platform/chrome/cros_ec_proto_test.c

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 717299cbccac..4b3d2427e8dd 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -267,4 +267,13 @@ config CHROMEOS_PRIVACY_SCREEN
 
 source "drivers/platform/chrome/wilco_ec/Kconfig"
 
+# Kunit test cases
+config CROS_EC_PROTO_KUNIT_TEST
+	tristate "Kunit tests for ChromeOS EC protocol" if !KUNIT_ALL_TESTS
+	depends on KUNIT && CROS_EC
+	default KUNIT_ALL_TESTS
+	select CROS_EC_PROTO
+	help
+	  Kunit tests for the ChromeOS Embedded Controller protocol.
+
 endif # CHROMEOS_PLATFORMS
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index 52f5a2dde8b8..3c380066c6b6 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -30,3 +30,6 @@ obj-$(CONFIG_CROS_USBPD_LOGGER)		+= cros_usbpd_logger.o
 obj-$(CONFIG_CROS_USBPD_NOTIFY)		+= cros_usbpd_notify.o
 
 obj-$(CONFIG_WILCO_EC)			+= wilco_ec/
+
+# Kunit test cases
+obj-$(CONFIG_CROS_EC_PROTO_KUNIT_TEST)	+= cros_ec_proto_test.o
diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
new file mode 100644
index 000000000000..61abb18ac00b
--- /dev/null
+++ b/drivers/platform/chrome/cros_ec_proto_test.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Kunit tests for ChromeOS Embedded Controller protocol.
+ */
+
+#include <kunit/test.h>
+
+#include <linux/platform_data/cros_ec_commands.h>
+#include <linux/platform_data/cros_ec_proto.h>
+
+#include "cros_ec.h"
+
+#define BUFSIZE 512
+
+struct cros_ec_proto_test_priv {
+	struct cros_ec_device ec_dev;
+	u8 dout[BUFSIZE];
+	u8 din[BUFSIZE];
+	struct cros_ec_command *msg;
+	u8 _msg[BUFSIZE];
+};
+
+static void cros_ec_proto_test_prepare_tx_legacy_normal(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct cros_ec_command *msg = priv->msg;
+	int ret, i;
+	u8 csum;
+
+	ec_dev->proto_version = 2;
+
+	msg->command = EC_CMD_HELLO;
+	msg->outsize = EC_PROTO2_MAX_PARAM_SIZE;
+	msg->data[0] = 0xde;
+	msg->data[1] = 0xad;
+	msg->data[2] = 0xbe;
+	msg->data[3] = 0xef;
+
+	ret = cros_ec_prepare_tx(ec_dev, msg);
+
+	KUNIT_EXPECT_EQ(test, ret, EC_MSG_TX_PROTO_BYTES + EC_PROTO2_MAX_PARAM_SIZE);
+	KUNIT_EXPECT_EQ(test, ec_dev->dout[0], EC_CMD_VERSION0);
+	KUNIT_EXPECT_EQ(test, ec_dev->dout[1], EC_CMD_HELLO);
+	KUNIT_EXPECT_EQ(test, ec_dev->dout[2], EC_PROTO2_MAX_PARAM_SIZE);
+	KUNIT_EXPECT_EQ(test, EC_MSG_TX_HEADER_BYTES, 3);
+	KUNIT_EXPECT_EQ(test, ec_dev->dout[EC_MSG_TX_HEADER_BYTES + 0], 0xde);
+	KUNIT_EXPECT_EQ(test, ec_dev->dout[EC_MSG_TX_HEADER_BYTES + 1], 0xad);
+	KUNIT_EXPECT_EQ(test, ec_dev->dout[EC_MSG_TX_HEADER_BYTES + 2], 0xbe);
+	KUNIT_EXPECT_EQ(test, ec_dev->dout[EC_MSG_TX_HEADER_BYTES + 3], 0xef);
+	for (i = 4; i < EC_PROTO2_MAX_PARAM_SIZE; ++i)
+		KUNIT_EXPECT_EQ(test, ec_dev->dout[EC_MSG_TX_HEADER_BYTES + i], 0);
+
+	csum = EC_CMD_VERSION0;
+	csum += EC_CMD_HELLO;
+	csum += EC_PROTO2_MAX_PARAM_SIZE;
+	csum += 0xde;
+	csum += 0xad;
+	csum += 0xbe;
+	csum += 0xef;
+	KUNIT_EXPECT_EQ(test,
+			ec_dev->dout[EC_MSG_TX_HEADER_BYTES + EC_PROTO2_MAX_PARAM_SIZE],
+			csum);
+}
+
+static void cros_ec_proto_test_prepare_tx_legacy_bad_msg_outsize(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct cros_ec_command *msg = priv->msg;
+	int ret;
+
+	ec_dev->proto_version = 2;
+
+	msg->outsize = EC_PROTO2_MAX_PARAM_SIZE + 1;
+
+	ret = cros_ec_prepare_tx(ec_dev, msg);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+}
+
+static void cros_ec_proto_test_prepare_tx_normal(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct cros_ec_command *msg = priv->msg;
+	struct ec_host_request *request = (struct ec_host_request *)ec_dev->dout;
+	int ret, i;
+	u8 csum;
+
+	msg->command = EC_CMD_HELLO;
+	msg->outsize = 0x88;
+	msg->data[0] = 0xde;
+	msg->data[1] = 0xad;
+	msg->data[2] = 0xbe;
+	msg->data[3] = 0xef;
+
+	ret = cros_ec_prepare_tx(ec_dev, msg);
+
+	KUNIT_EXPECT_EQ(test, ret, sizeof(*request) + 0x88);
+
+	KUNIT_EXPECT_EQ(test, request->struct_version, EC_HOST_REQUEST_VERSION);
+	KUNIT_EXPECT_EQ(test, request->command, EC_CMD_HELLO);
+	KUNIT_EXPECT_EQ(test, request->command_version, 0);
+	KUNIT_EXPECT_EQ(test, request->data_len, 0x88);
+	KUNIT_EXPECT_EQ(test, ec_dev->dout[sizeof(*request) + 0], 0xde);
+	KUNIT_EXPECT_EQ(test, ec_dev->dout[sizeof(*request) + 1], 0xad);
+	KUNIT_EXPECT_EQ(test, ec_dev->dout[sizeof(*request) + 2], 0xbe);
+	KUNIT_EXPECT_EQ(test, ec_dev->dout[sizeof(*request) + 3], 0xef);
+	for (i = 4; i < 0x88; ++i)
+		KUNIT_EXPECT_EQ(test, ec_dev->dout[sizeof(*request) + i], 0);
+
+	csum = EC_HOST_REQUEST_VERSION;
+	csum += EC_CMD_HELLO;
+	csum += 0x88;
+	csum += 0xde;
+	csum += 0xad;
+	csum += 0xbe;
+	csum += 0xef;
+	KUNIT_EXPECT_EQ(test, request->checksum, (u8)-csum);
+}
+
+static void cros_ec_proto_test_prepare_tx_bad_msg_outsize(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct cros_ec_command *msg = priv->msg;
+	int ret;
+
+	msg->outsize = ec_dev->dout_size - sizeof(struct ec_host_request) + 1;
+
+	ret = cros_ec_prepare_tx(ec_dev, msg);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+}
+
+static int cros_ec_proto_test_init(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv;
+	struct cros_ec_device *ec_dev;
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	test->priv = priv;
+
+	ec_dev = &priv->ec_dev;
+	ec_dev->dout = (u8 *)priv->dout;
+	ec_dev->dout_size = ARRAY_SIZE(priv->dout);
+	ec_dev->din = (u8 *)priv->din;
+	ec_dev->din_size = ARRAY_SIZE(priv->din);
+	ec_dev->proto_version = EC_HOST_REQUEST_VERSION;
+
+	priv->msg = (struct cros_ec_command *)priv->_msg;
+
+	return 0;
+}
+
+static struct kunit_case cros_ec_proto_test_cases[] = {
+	KUNIT_CASE(cros_ec_proto_test_prepare_tx_legacy_normal),
+	KUNIT_CASE(cros_ec_proto_test_prepare_tx_legacy_bad_msg_outsize),
+	KUNIT_CASE(cros_ec_proto_test_prepare_tx_normal),
+	KUNIT_CASE(cros_ec_proto_test_prepare_tx_bad_msg_outsize),
+	{}
+};
+
+static struct kunit_suite cros_ec_proto_test_suite = {
+	.name = "cros_ec_proto_test",
+	.init = cros_ec_proto_test_init,
+	.test_cases = cros_ec_proto_test_cases,
+};
+
+kunit_test_suite(cros_ec_proto_test_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.36.0.550.gb090851708-goog

