Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6065401D8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244562AbiFGO5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237758AbiFGO45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:56:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC45C5DA2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 07:56:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B11F96168A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F3CC3411F;
        Tue,  7 Jun 2022 14:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654613814;
        bh=tYjTcNkSmwgyPx9RAfkc3l3XrCv/u7Tuyy0q9qMY+38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WdOo3uMF6Z/Dbkt8SPbeB1Iou/vh22LeywClJ+GrabgtY0Ep9brCqfAOAJO65RESu
         CiWm1eZlk3KlBFS1Gpyt6UrvYNZ8fem6G+XlWZFwvUicttvKy2jpuZaahi+qSKwLNr
         cyd0BJ0ymx2OEvM6SKzvTYRf11CZTEm0ACJtfIL6Bf6MpveBmwf4GGu/Hmxqjwlq93
         HP7nWuTjPIEYXohFp5ZFTpa+u/iiah5e1bqvI0tpNlFvSiK3Cfc7H8ExUgdp+Y+Ox2
         FF+Xs1yolWmNgAC3qOndW8LhsvHy0Deno5dz5sfFLASl9F6K/Cwp9ZbtJwCzh0bZrV
         vcw4TTnCyf/iQ==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        tzungbi@kernel.org
Subject: [PATCH v2 02/15] platform/chrome: cros_ec_proto: add Kunit tests for cros_ec_query_all()
Date:   Tue,  7 Jun 2022 14:56:26 +0000
Message-Id: <20220607145639.2362750-3-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220607145639.2362750-1-tzungbi@kernel.org>
References: <20220607145639.2362750-1-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cros_ec_query_all() sends multiple host commands to EC for querying
supported protocols and settings.

Add required mock for interacting with cros_ec_query_all() and Kunit
tests.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v1:
- Initialize the mock ec_dev->dev more to get rid of kernel WARN().
- Elaborate more on the test case names.

 drivers/platform/chrome/Kconfig              |   6 +
 drivers/platform/chrome/Makefile             |   1 +
 drivers/platform/chrome/cros_ec_proto_test.c | 801 +++++++++++++++++++
 drivers/platform/chrome/cros_kunit_util.c    |  98 +++
 drivers/platform/chrome/cros_kunit_util.h    |  36 +
 5 files changed, 942 insertions(+)
 create mode 100644 drivers/platform/chrome/cros_kunit_util.c
 create mode 100644 drivers/platform/chrome/cros_kunit_util.h

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 4b3d2427e8dd..0b069d874845 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -268,11 +268,17 @@ config CHROMEOS_PRIVACY_SCREEN
 source "drivers/platform/chrome/wilco_ec/Kconfig"
 
 # Kunit test cases
+config CROS_KUNIT
+	tristate
+	help
+	  ChromeOS Kunit.
+
 config CROS_EC_PROTO_KUNIT_TEST
 	tristate "Kunit tests for ChromeOS EC protocol" if !KUNIT_ALL_TESTS
 	depends on KUNIT && CROS_EC
 	default KUNIT_ALL_TESTS
 	select CROS_EC_PROTO
+	select CROS_KUNIT
 	help
 	  Kunit tests for the ChromeOS Embedded Controller protocol.
 
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index 3c380066c6b6..a06bc56d12a8 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -32,4 +32,5 @@ obj-$(CONFIG_CROS_USBPD_NOTIFY)		+= cros_usbpd_notify.o
 obj-$(CONFIG_WILCO_EC)			+= wilco_ec/
 
 # Kunit test cases
+obj-$(CONFIG_CROS_KUNIT)		+= cros_kunit_util.o
 obj-$(CONFIG_CROS_EC_PROTO_KUNIT_TEST)	+= cros_ec_proto_test.o
diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
index 25c4fca5c165..7ec53de4e256 100644
--- a/drivers/platform/chrome/cros_ec_proto_test.c
+++ b/drivers/platform/chrome/cros_ec_proto_test.c
@@ -9,6 +9,7 @@
 #include <linux/platform_data/cros_ec_proto.h>
 
 #include "cros_ec.h"
+#include "cros_kunit_util.h"
 
 #define BUFSIZE 512
 
@@ -172,6 +173,778 @@ static void cros_ec_proto_test_check_result(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, ret, -EAGAIN);
 }
 
+static void cros_ec_proto_test_query_all_pretest(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+
+	/*
+	 * cros_ec_query_all() will free din and dout and allocate them again to fit the usage by
+	 * calling devm_kfree() and devm_kzalloc().  Set them to NULL as they aren't managed by
+	 * ec_dev->dev.
+	 */
+	ec_dev->din = NULL;
+	ec_dev->dout = NULL;
+}
+
+static void cros_ec_proto_test_query_all_normal(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret;
+
+	/* For cros_ec_host_command_proto_query() without passthru. */
+	{
+		struct ec_response_get_protocol_info *data;
+
+		mock = cros_kunit_ec_xfer_mock_add(test, sizeof(*data));
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+
+		data = (struct ec_response_get_protocol_info *)mock->o_data;
+		data->protocol_versions = BIT(3) | BIT(2);
+		data->max_request_packet_size = 0xbe;
+		data->max_response_packet_size = 0xef;
+	}
+
+	/* For cros_ec_host_command_proto_query() with passthru. */
+	{
+		struct ec_response_get_protocol_info *data;
+
+		mock = cros_kunit_ec_xfer_mock_add(test, sizeof(*data));
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+
+		data = (struct ec_response_get_protocol_info *)mock->o_data;
+		data->max_request_packet_size = 0xbf;
+	}
+
+	/* For cros_ec_get_host_command_version_mask() for MKBP. */
+	{
+		struct ec_response_get_cmd_versions *data;
+
+		mock = cros_kunit_ec_xfer_mock_add(test, sizeof(*data));
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+
+		data = (struct ec_response_get_cmd_versions *)mock->o_data;
+		data->version_mask = BIT(6) | BIT(5);
+	}
+
+	/* For cros_ec_get_host_command_version_mask() for host sleep v1. */
+	{
+		struct ec_response_get_cmd_versions *data;
+
+		mock = cros_kunit_ec_xfer_mock_add(test, sizeof(*data));
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+
+		data = (struct ec_response_get_cmd_versions *)mock->o_data;
+		data->version_mask = BIT(1);
+	}
+
+	/* For cros_ec_get_host_event_wake_mask(). */
+	{
+		struct ec_response_host_event_mask *data;
+
+		mock = cros_kunit_ec_xfer_mock_add(test, sizeof(*data));
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+
+		data = (struct ec_response_host_event_mask *)mock->o_data;
+		data->mask = 0xbeef;
+	}
+
+	cros_ec_proto_test_query_all_pretest(test);
+	ret = cros_ec_query_all(ec_dev);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	/* For cros_ec_host_command_proto_query() without passthru. */
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_PROTOCOL_INFO);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize,
+				sizeof(struct ec_response_get_protocol_info));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
+
+		KUNIT_EXPECT_EQ(test, ec_dev->max_request, 0xbe - sizeof(struct ec_host_request));
+		KUNIT_EXPECT_EQ(test, ec_dev->max_response, 0xef - sizeof(struct ec_host_response));
+		KUNIT_EXPECT_EQ(test, ec_dev->proto_version, 3);
+		KUNIT_EXPECT_EQ(test, ec_dev->din_size, 0xef + EC_MAX_RESPONSE_OVERHEAD);
+		KUNIT_EXPECT_EQ(test, ec_dev->dout_size, 0xbe + EC_MAX_REQUEST_OVERHEAD);
+	}
+
+	/* For cros_ec_host_command_proto_query() with passthru. */
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command,
+				EC_CMD_PASSTHRU_OFFSET(1) | EC_CMD_GET_PROTOCOL_INFO);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize,
+				sizeof(struct ec_response_get_protocol_info));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
+
+		KUNIT_EXPECT_EQ(test, ec_dev->max_passthru, 0xbf - sizeof(struct ec_host_request));
+	}
+
+	/* For cros_ec_get_host_command_version_mask() for MKBP. */
+	{
+		struct ec_params_get_cmd_versions *data;
+
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_CMD_VERSIONS);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize,
+				sizeof(struct ec_response_get_cmd_versions));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, sizeof(*data));
+
+		data = (struct ec_params_get_cmd_versions *)mock->i_data;
+		KUNIT_EXPECT_EQ(test, data->cmd, EC_CMD_GET_NEXT_EVENT);
+
+		KUNIT_EXPECT_EQ(test, ec_dev->mkbp_event_supported, 7);
+	}
+
+	/* For cros_ec_get_host_command_version_mask() for host sleep v1. */
+	{
+		struct ec_params_get_cmd_versions *data;
+
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_CMD_VERSIONS);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize,
+				sizeof(struct ec_response_get_cmd_versions));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, sizeof(*data));
+
+		data = (struct ec_params_get_cmd_versions *)mock->i_data;
+		KUNIT_EXPECT_EQ(test, data->cmd, EC_CMD_HOST_SLEEP_EVENT);
+
+		KUNIT_EXPECT_TRUE(test, ec_dev->host_sleep_v1);
+	}
+
+	/* For cros_ec_get_host_event_wake_mask(). */
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_HOST_EVENT_GET_WAKE_MASK);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize, sizeof(struct ec_response_host_event_mask));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
+
+		KUNIT_EXPECT_EQ(test, ec_dev->host_event_wake_mask, 0xbeef);
+	}
+}
+
+static void cros_ec_proto_test_query_all_no_pd_return_error(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret;
+
+	/* Set some garbage bytes. */
+	ec_dev->max_passthru = 0xbf;
+
+	/* For cros_ec_host_command_proto_query() without passthru. */
+	{
+		struct ec_response_get_protocol_info *data;
+
+		mock = cros_kunit_ec_xfer_mock_add(test, sizeof(*data));
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+
+		/*
+		 * Although it doesn't check the value, provides valid sizes so that
+		 * cros_ec_query_all() allocates din and dout correctly.
+		 */
+		data = (struct ec_response_get_protocol_info *)mock->o_data;
+		data->max_request_packet_size = 0xbe;
+		data->max_response_packet_size = 0xef;
+	}
+
+	/* For cros_ec_host_command_proto_query() with passthru. */
+	{
+		mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND, 0);
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+	}
+
+	cros_ec_proto_test_query_all_pretest(test);
+	ret = cros_ec_query_all(ec_dev);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	/* For cros_ec_host_command_proto_query() without passthru. */
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_PROTOCOL_INFO);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize,
+				sizeof(struct ec_response_get_protocol_info));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
+	}
+
+	/* For cros_ec_host_command_proto_query() with passthru. */
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command,
+				EC_CMD_PASSTHRU_OFFSET(1) | EC_CMD_GET_PROTOCOL_INFO);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize,
+				sizeof(struct ec_response_get_protocol_info));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
+
+		KUNIT_EXPECT_EQ(test, ec_dev->max_passthru, 0);
+	}
+}
+
+static void cros_ec_proto_test_query_all_legacy_normal_v3_return_error(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret;
+
+	/* For cros_ec_host_command_proto_query() without passthru. */
+	{
+		mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND, 0);
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+	}
+
+	/* For cros_ec_host_command_proto_query_v2(). */
+	{
+		struct ec_response_hello *data;
+
+		mock = cros_kunit_ec_xfer_mock_add(test, sizeof(*data));
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+
+		data = (struct ec_response_hello *)mock->o_data;
+		data->out_data = 0xa1b2c3d4;
+	}
+
+	cros_ec_proto_test_query_all_pretest(test);
+	ret = cros_ec_query_all(ec_dev);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	/* For cros_ec_host_command_proto_query() without passthru. */
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_PROTOCOL_INFO);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize,
+				sizeof(struct ec_response_get_protocol_info));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
+	}
+
+	/* For cros_ec_host_command_proto_query_v2(). */
+	{
+		struct ec_params_hello *data;
+
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_HELLO);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize, sizeof(struct ec_response_hello));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, sizeof(*data));
+
+		data = (struct ec_params_hello *)mock->i_data;
+		KUNIT_EXPECT_EQ(test, data->in_data, 0xa0b0c0d0);
+
+		KUNIT_EXPECT_EQ(test, ec_dev->proto_version, 2);
+		KUNIT_EXPECT_EQ(test, ec_dev->max_request, EC_PROTO2_MAX_PARAM_SIZE);
+		KUNIT_EXPECT_EQ(test, ec_dev->max_response, EC_PROTO2_MAX_PARAM_SIZE);
+		KUNIT_EXPECT_EQ(test, ec_dev->max_passthru, 0);
+		KUNIT_EXPECT_PTR_EQ(test, ec_dev->pkt_xfer, NULL);
+		KUNIT_EXPECT_EQ(test, ec_dev->din_size, EC_PROTO2_MSG_BYTES);
+		KUNIT_EXPECT_EQ(test, ec_dev->dout_size, EC_PROTO2_MSG_BYTES);
+	}
+}
+
+static void cros_ec_proto_test_query_all_legacy_xfer_error(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret;
+
+	/* For cros_ec_host_command_proto_query() without passthru. */
+	{
+		mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND, 0);
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+	}
+
+	/* For cros_ec_host_command_proto_query_v2(). */
+	{
+		mock = cros_kunit_ec_xfer_mock_addx(test, -EIO, EC_RES_SUCCESS, 0);
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+	}
+
+	cros_ec_proto_test_query_all_pretest(test);
+	ret = cros_ec_query_all(ec_dev);
+	KUNIT_EXPECT_EQ(test, ret, -EIO);
+	KUNIT_EXPECT_EQ(test, ec_dev->proto_version, EC_PROTO_VERSION_UNKNOWN);
+
+	/* For cros_ec_host_command_proto_query() without passthru. */
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_PROTOCOL_INFO);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize,
+				sizeof(struct ec_response_get_protocol_info));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
+	}
+
+	/* For cros_ec_host_command_proto_query_v2(). */
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_HELLO);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize, sizeof(struct ec_response_hello));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, sizeof(struct ec_params_hello));
+	}
+}
+
+static void cros_ec_proto_test_query_all_legacy_return_error(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret;
+
+	/* For cros_ec_host_command_proto_query() without passthru. */
+	{
+		mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND, 0);
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+	}
+
+	/* For cros_ec_host_command_proto_query_v2(). */
+	{
+		mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND, 0);
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+	}
+
+	cros_ec_proto_test_query_all_pretest(test);
+	ret = cros_ec_query_all(ec_dev);
+	KUNIT_EXPECT_EQ(test, ret, EC_RES_INVALID_COMMAND);
+	KUNIT_EXPECT_EQ(test, ec_dev->proto_version, EC_PROTO_VERSION_UNKNOWN);
+
+	/* For cros_ec_host_command_proto_query() without passthru. */
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_PROTOCOL_INFO);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize,
+				sizeof(struct ec_response_get_protocol_info));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
+	}
+
+	/* For cros_ec_host_command_proto_query_v2(). */
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_HELLO);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize, sizeof(struct ec_response_hello));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, sizeof(struct ec_params_hello));
+	}
+}
+
+static void cros_ec_proto_test_query_all_legacy_data_error(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret;
+
+	/* For cros_ec_host_command_proto_query() without passthru. */
+	{
+		mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND, 0);
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+	}
+
+	/* For cros_ec_host_command_proto_query_v2(). */
+	{
+		struct ec_response_hello *data;
+
+		mock = cros_kunit_ec_xfer_mock_add(test, sizeof(*data));
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+
+		data = (struct ec_response_hello *)mock->o_data;
+		data->out_data = 0xbeefbfbf;
+	}
+
+	cros_ec_proto_test_query_all_pretest(test);
+	ret = cros_ec_query_all(ec_dev);
+	KUNIT_EXPECT_EQ(test, ret, -EBADMSG);
+	KUNIT_EXPECT_EQ(test, ec_dev->proto_version, EC_PROTO_VERSION_UNKNOWN);
+
+	/* For cros_ec_host_command_proto_query() without passthru. */
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_PROTOCOL_INFO);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize,
+				sizeof(struct ec_response_get_protocol_info));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
+	}
+
+	/* For cros_ec_host_command_proto_query_v2(). */
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_HELLO);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize, sizeof(struct ec_response_hello));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, sizeof(struct ec_params_hello));
+	}
+}
+
+static void cros_ec_proto_test_query_all_no_mkbp(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret;
+
+	/* Set some garbage bytes. */
+	ec_dev->mkbp_event_supported = 0xbf;
+
+	/* For cros_ec_host_command_proto_query() without passthru. */
+	{
+		struct ec_response_get_protocol_info *data;
+
+		mock = cros_kunit_ec_xfer_mock_add(test, sizeof(*data));
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+
+		/*
+		 * Although it doesn't check the value, provides valid sizes so that
+		 * cros_ec_query_all() allocates din and dout correctly.
+		 */
+		data = (struct ec_response_get_protocol_info *)mock->o_data;
+		data->max_request_packet_size = 0xbe;
+		data->max_response_packet_size = 0xef;
+	}
+
+	/* For cros_ec_host_command_proto_query() with passthru. */
+	{
+		mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND, 0);
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+	}
+
+	/* For cros_ec_get_host_command_version_mask() for MKBP. */
+	{
+		struct ec_response_get_cmd_versions *data;
+
+		mock = cros_kunit_ec_xfer_mock_add(test, sizeof(*data));
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+
+		data = (struct ec_response_get_cmd_versions *)mock->o_data;
+		data->version_mask = 0;
+	}
+
+	cros_ec_proto_test_query_all_pretest(test);
+	ret = cros_ec_query_all(ec_dev);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	/* For cros_ec_host_command_proto_query() without passthru. */
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_PROTOCOL_INFO);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize,
+				sizeof(struct ec_response_get_protocol_info));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
+	}
+
+	/* For cros_ec_host_command_proto_query() with passthru. */
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command,
+				EC_CMD_PASSTHRU_OFFSET(1) | EC_CMD_GET_PROTOCOL_INFO);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize,
+				sizeof(struct ec_response_get_protocol_info));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
+	}
+
+	/* For cros_ec_get_host_command_version_mask() for MKBP. */
+	{
+		struct ec_params_get_cmd_versions *data;
+
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_CMD_VERSIONS);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize,
+				sizeof(struct ec_response_get_cmd_versions));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, sizeof(*data));
+
+		data = (struct ec_params_get_cmd_versions *)mock->i_data;
+		KUNIT_EXPECT_EQ(test, data->cmd, EC_CMD_GET_NEXT_EVENT);
+
+		KUNIT_EXPECT_EQ(test, ec_dev->mkbp_event_supported, 0);
+	}
+}
+
+static void cros_ec_proto_test_query_all_no_host_sleep(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret;
+
+	/* Set some garbage bytes. */
+	ec_dev->host_sleep_v1 = true;
+
+	/* For cros_ec_host_command_proto_query() without passthru. */
+	{
+		struct ec_response_get_protocol_info *data;
+
+		mock = cros_kunit_ec_xfer_mock_add(test, sizeof(*data));
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+
+		/*
+		 * Although it doesn't check the value, provides valid sizes so that
+		 * cros_ec_query_all() allocates din and dout correctly.
+		 */
+		data = (struct ec_response_get_protocol_info *)mock->o_data;
+		data->max_request_packet_size = 0xbe;
+		data->max_response_packet_size = 0xef;
+	}
+
+	/* For cros_ec_host_command_proto_query() with passthru. */
+	{
+		mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND, 0);
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+	}
+
+	/* For cros_ec_get_host_command_version_mask() for MKBP. */
+	{
+		mock = cros_kunit_ec_xfer_mock_add(test, 0);
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+	}
+
+	/* For cros_ec_get_host_command_version_mask() for host sleep v1. */
+	{
+		struct ec_response_get_cmd_versions *data;
+
+		mock = cros_kunit_ec_xfer_mock_add(test, sizeof(*data));
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+
+		data = (struct ec_response_get_cmd_versions *)mock->o_data;
+		data->version_mask = 0;
+	}
+
+	cros_ec_proto_test_query_all_pretest(test);
+	ret = cros_ec_query_all(ec_dev);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	/* For cros_ec_host_command_proto_query() without passthru. */
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_PROTOCOL_INFO);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize,
+				sizeof(struct ec_response_get_protocol_info));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
+	}
+
+	/* For cros_ec_host_command_proto_query() with passthru. */
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command,
+				EC_CMD_PASSTHRU_OFFSET(1) | EC_CMD_GET_PROTOCOL_INFO);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize,
+				sizeof(struct ec_response_get_protocol_info));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
+	}
+
+	/* For cros_ec_get_host_command_version_mask() for MKBP. */
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_CMD_VERSIONS);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize,
+				sizeof(struct ec_response_get_cmd_versions));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, sizeof(struct ec_params_get_cmd_versions));
+	}
+
+	/* For cros_ec_get_host_command_version_mask() for host sleep v1. */
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_CMD_VERSIONS);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize,
+				sizeof(struct ec_response_get_cmd_versions));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, sizeof(struct ec_params_get_cmd_versions));
+
+		KUNIT_EXPECT_FALSE(test, ec_dev->host_sleep_v1);
+	}
+}
+
+static void cros_ec_proto_test_query_all_default_wake_mask_return_error(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret;
+
+	/* Set some garbage bytes. */
+	ec_dev->host_event_wake_mask = U32_MAX;
+
+	/* For cros_ec_host_command_proto_query() without passthru. */
+	{
+		struct ec_response_get_protocol_info *data;
+
+		mock = cros_kunit_ec_xfer_mock_add(test, sizeof(*data));
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+
+		/*
+		 * Although it doesn't check the value, provides valid sizes so that
+		 * cros_ec_query_all() allocates din and dout correctly.
+		 */
+		data = (struct ec_response_get_protocol_info *)mock->o_data;
+		data->max_request_packet_size = 0xbe;
+		data->max_response_packet_size = 0xef;
+	}
+
+	/* For cros_ec_host_command_proto_query() with passthru. */
+	{
+		mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND, 0);
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+	}
+
+	/* For cros_ec_get_host_command_version_mask() for MKBP. */
+	{
+		mock = cros_kunit_ec_xfer_mock_add(test, 0);
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+	}
+
+	/* For cros_ec_get_host_command_version_mask() for host sleep v1. */
+	{
+		mock = cros_kunit_ec_xfer_mock_add(test, 0);
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+	}
+
+	/* For cros_ec_get_host_event_wake_mask(). */
+	{
+		mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND, 0);
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+	}
+
+	cros_ec_proto_test_query_all_pretest(test);
+	ret = cros_ec_query_all(ec_dev);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	/* For cros_ec_host_command_proto_query() without passthru. */
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_PROTOCOL_INFO);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize,
+				sizeof(struct ec_response_get_protocol_info));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
+	}
+
+	/* For cros_ec_host_command_proto_query() with passthru. */
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command,
+				EC_CMD_PASSTHRU_OFFSET(1) | EC_CMD_GET_PROTOCOL_INFO);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize,
+				sizeof(struct ec_response_get_protocol_info));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
+	}
+
+	/* For cros_ec_get_host_command_version_mask() for MKBP. */
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_CMD_VERSIONS);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize,
+				sizeof(struct ec_response_get_cmd_versions));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, sizeof(struct ec_params_get_cmd_versions));
+	}
+
+	/* For cros_ec_get_host_command_version_mask() for host sleep v1. */
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_CMD_VERSIONS);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize,
+				sizeof(struct ec_response_get_cmd_versions));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, sizeof(struct ec_params_get_cmd_versions));
+	}
+
+	/* For cros_ec_get_host_event_wake_mask(). */
+	{
+		u32 mask;
+
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_HOST_EVENT_GET_WAKE_MASK);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize, sizeof(struct ec_response_host_event_mask));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
+
+		mask = ec_dev->host_event_wake_mask;
+		KUNIT_EXPECT_EQ(test, mask & EC_HOST_EVENT_MASK(EC_HOST_EVENT_LID_CLOSED), 0);
+		KUNIT_EXPECT_EQ(test, mask & EC_HOST_EVENT_MASK(EC_HOST_EVENT_AC_DISCONNECTED), 0);
+		KUNIT_EXPECT_EQ(test, mask & EC_HOST_EVENT_MASK(EC_HOST_EVENT_BATTERY_LOW), 0);
+		KUNIT_EXPECT_EQ(test, mask & EC_HOST_EVENT_MASK(EC_HOST_EVENT_BATTERY_CRITICAL), 0);
+		KUNIT_EXPECT_EQ(test, mask & EC_HOST_EVENT_MASK(EC_HOST_EVENT_BATTERY), 0);
+		KUNIT_EXPECT_EQ(test, mask & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU), 0);
+		KUNIT_EXPECT_EQ(test, mask & EC_HOST_EVENT_MASK(EC_HOST_EVENT_BATTERY_STATUS), 0);
+	}
+}
+
+static void cros_ec_proto_test_release(struct device *dev)
+{
+}
+
 static int cros_ec_proto_test_init(struct kunit *test)
 {
 	struct cros_ec_proto_test_priv *priv;
@@ -188,24 +961,52 @@ static int cros_ec_proto_test_init(struct kunit *test)
 	ec_dev->din = (u8 *)priv->din;
 	ec_dev->din_size = ARRAY_SIZE(priv->din);
 	ec_dev->proto_version = EC_HOST_REQUEST_VERSION;
+	ec_dev->dev = kunit_kzalloc(test, sizeof(*ec_dev->dev), GFP_KERNEL);
+	if (!ec_dev->dev)
+		return -ENOMEM;
+	device_initialize(ec_dev->dev);
+	dev_set_name(ec_dev->dev, "cros_ec_proto_test");
+	ec_dev->dev->release = cros_ec_proto_test_release;
+	ec_dev->cmd_xfer = cros_kunit_ec_xfer_mock;
+	ec_dev->pkt_xfer = cros_kunit_ec_xfer_mock;
 
 	priv->msg = (struct cros_ec_command *)priv->_msg;
 
+	cros_kunit_mock_reset();
+
 	return 0;
 }
 
+static void cros_ec_proto_test_exit(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+
+	put_device(ec_dev->dev);
+}
+
 static struct kunit_case cros_ec_proto_test_cases[] = {
 	KUNIT_CASE(cros_ec_proto_test_prepare_tx_legacy_normal),
 	KUNIT_CASE(cros_ec_proto_test_prepare_tx_legacy_bad_msg_outsize),
 	KUNIT_CASE(cros_ec_proto_test_prepare_tx_normal),
 	KUNIT_CASE(cros_ec_proto_test_prepare_tx_bad_msg_outsize),
 	KUNIT_CASE(cros_ec_proto_test_check_result),
+	KUNIT_CASE(cros_ec_proto_test_query_all_normal),
+	KUNIT_CASE(cros_ec_proto_test_query_all_no_pd_return_error),
+	KUNIT_CASE(cros_ec_proto_test_query_all_legacy_normal_v3_return_error),
+	KUNIT_CASE(cros_ec_proto_test_query_all_legacy_xfer_error),
+	KUNIT_CASE(cros_ec_proto_test_query_all_legacy_return_error),
+	KUNIT_CASE(cros_ec_proto_test_query_all_legacy_data_error),
+	KUNIT_CASE(cros_ec_proto_test_query_all_no_mkbp),
+	KUNIT_CASE(cros_ec_proto_test_query_all_no_host_sleep),
+	KUNIT_CASE(cros_ec_proto_test_query_all_default_wake_mask_return_error),
 	{}
 };
 
 static struct kunit_suite cros_ec_proto_test_suite = {
 	.name = "cros_ec_proto_test",
 	.init = cros_ec_proto_test_init,
+	.exit = cros_ec_proto_test_exit,
 	.test_cases = cros_ec_proto_test_cases,
 };
 
diff --git a/drivers/platform/chrome/cros_kunit_util.c b/drivers/platform/chrome/cros_kunit_util.c
new file mode 100644
index 000000000000..e031777dea87
--- /dev/null
+++ b/drivers/platform/chrome/cros_kunit_util.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * CrOS Kunit tests utilities.
+ */
+
+#include <kunit/test.h>
+
+#include <linux/list.h>
+#include <linux/minmax.h>
+#include <linux/platform_data/cros_ec_commands.h>
+#include <linux/platform_data/cros_ec_proto.h>
+
+#include "cros_ec.h"
+#include "cros_kunit_util.h"
+
+int cros_kunit_ec_xfer_mock_default_ret;
+EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock_default_ret);
+
+static struct list_head cros_kunit_ec_xfer_mock_in;
+static struct list_head cros_kunit_ec_xfer_mock_out;
+
+int cros_kunit_ec_xfer_mock(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
+{
+	struct ec_xfer_mock *mock;
+
+	mock = list_first_entry_or_null(&cros_kunit_ec_xfer_mock_in, struct ec_xfer_mock, list);
+	if (!mock)
+		return cros_kunit_ec_xfer_mock_default_ret;
+
+	list_del(&mock->list);
+
+	memcpy(&mock->msg, msg, sizeof(*msg));
+	if (msg->outsize) {
+		mock->i_data = kunit_kzalloc(mock->test, msg->outsize, GFP_KERNEL);
+		if (mock->i_data)
+			memcpy(mock->i_data, msg->data, msg->outsize);
+	}
+
+	msg->result = mock->result;
+	if (msg->insize)
+		memcpy(msg->data, mock->o_data, min(msg->insize, mock->o_data_len));
+
+	list_add_tail(&mock->list, &cros_kunit_ec_xfer_mock_out);
+
+	return mock->ret;
+}
+EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock);
+
+struct ec_xfer_mock *cros_kunit_ec_xfer_mock_add(struct kunit *test, size_t size)
+{
+	return cros_kunit_ec_xfer_mock_addx(test, size, EC_RES_SUCCESS, size);
+}
+EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock_add);
+
+struct ec_xfer_mock *cros_kunit_ec_xfer_mock_addx(struct kunit *test,
+						  int ret, int result, size_t size)
+{
+	struct ec_xfer_mock *mock;
+
+	mock = kunit_kzalloc(test, sizeof(*mock), GFP_KERNEL);
+	if (!mock)
+		return NULL;
+
+	list_add_tail(&mock->list, &cros_kunit_ec_xfer_mock_in);
+	mock->test = test;
+
+	mock->ret = ret;
+	mock->result = result;
+	mock->o_data = kunit_kzalloc(test, size, GFP_KERNEL);
+	if (!mock->o_data)
+		return NULL;
+	mock->o_data_len = size;
+
+	return mock;
+}
+EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock_addx);
+
+struct ec_xfer_mock *cros_kunit_ec_xfer_mock_next(void)
+{
+	struct ec_xfer_mock *mock;
+
+	mock = list_first_entry_or_null(&cros_kunit_ec_xfer_mock_out, struct ec_xfer_mock, list);
+	if (mock)
+		list_del(&mock->list);
+
+	return mock;
+}
+EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock_next);
+
+void cros_kunit_mock_reset(void)
+{
+	cros_kunit_ec_xfer_mock_default_ret = 0;
+	INIT_LIST_HEAD(&cros_kunit_ec_xfer_mock_in);
+	INIT_LIST_HEAD(&cros_kunit_ec_xfer_mock_out);
+}
+EXPORT_SYMBOL_GPL(cros_kunit_mock_reset);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/platform/chrome/cros_kunit_util.h b/drivers/platform/chrome/cros_kunit_util.h
new file mode 100644
index 000000000000..79c4525f873c
--- /dev/null
+++ b/drivers/platform/chrome/cros_kunit_util.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * CrOS Kunit tests utilities.
+ */
+
+#ifndef _CROS_KUNIT_UTIL_H_
+#define _CROS_KUNIT_UTIL_H_
+
+#include <linux/platform_data/cros_ec_proto.h>
+
+struct ec_xfer_mock {
+	struct list_head list;
+	struct kunit *test;
+
+	/* input */
+	struct cros_ec_command msg;
+	void *i_data;
+
+	/* output */
+	int ret;
+	int result;
+	void *o_data;
+	u32 o_data_len;
+};
+
+extern int cros_kunit_ec_xfer_mock_default_ret;
+
+int cros_kunit_ec_xfer_mock(struct cros_ec_device *ec_dev, struct cros_ec_command *msg);
+struct ec_xfer_mock *cros_kunit_ec_xfer_mock_add(struct kunit *test, size_t size);
+struct ec_xfer_mock *cros_kunit_ec_xfer_mock_addx(struct kunit *test,
+						  int ret, int result, size_t size);
+struct ec_xfer_mock *cros_kunit_ec_xfer_mock_next(void);
+
+void cros_kunit_mock_reset(void);
+
+#endif
-- 
2.36.1.255.ge46751e96f-goog

