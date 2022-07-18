Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC82B577A42
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 07:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbiGRFK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 01:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbiGRFKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 01:10:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC37E0E4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 22:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D5EEB80E4C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA06C341CD;
        Mon, 18 Jul 2022 05:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658121012;
        bh=OFNFUOfkUXPHHG9R19TPDPEei1yRlrQ1+RSXitJR40U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KyZ6zFte/VR8ooqF1VBwHoM7aGjvmzQt9c1z/w6hZoIQosIu6pPz/RxF7CWwx2ENV
         si4wOvjgeOvDCSBSfjVPKOOPy6DNkH+qkiedFg0doc3RtZO/1ChACPEbMkKjfEl6wK
         kArRg8h3+jIxIlkn2s1PXijAd3WPBtvyh2rPosHc+aVG+qE3aZVLHWzU0JvP64s3QM
         it/0Owxl4wgAV9bWBVkH7DkUz9+4Nwo3oBTzWjXw1Ze8Rv18diQEsktI+9AdfK/4+3
         3Smi0Cz2WFeOVMiVvD9uLc54CyZJEdj/QR4av7xrxwKoElUZQkRm74Re95l5QxymXP
         KBhWE6qU5gQJQ==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/10] platform/chrome: cros_ec_proto: add Kunit tests for cros_ec_send_command()
Date:   Mon, 18 Jul 2022 05:09:08 +0000
Message-Id: <20220718050914.2267370-5-tzungbi@kernel.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220718050914.2267370-1-tzungbi@kernel.org>
References: <20220718050914.2267370-1-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cros_ec_cmd_xfer() is the only exported function that calls static
function cros_ec_send_command().

Add Kunit tests for cros_ec_send_command() through calling
cros_ec_cmd_xfer().

Reviewed-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v1:
- Add R-b tag.

 drivers/platform/chrome/cros_ec_proto_test.c | 265 +++++++++++++++++++
 drivers/platform/chrome/cros_kunit_util.c    |  20 ++
 drivers/platform/chrome/cros_kunit_util.h    |   4 +
 3 files changed, 289 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
index 33721607a5b9..64100fd81c6a 100644
--- a/drivers/platform/chrome/cros_ec_proto_test.c
+++ b/drivers/platform/chrome/cros_ec_proto_test.c
@@ -1680,6 +1680,262 @@ static void cros_ec_proto_test_cmd_xfer_excess_msg_outsize_with_passthru(struct
 	KUNIT_EXPECT_EQ(test, ret, -EMSGSIZE);
 }
 
+static void cros_ec_proto_test_cmd_xfer_protocol_v3_normal(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	int ret;
+	struct cros_ec_command msg;
+
+	memset(&msg, 0, sizeof(msg));
+
+	ec_dev->proto_version = 3;
+	ec_dev->cmd_xfer = cros_kunit_ec_cmd_xfer_mock;
+	ec_dev->pkt_xfer = cros_kunit_ec_pkt_xfer_mock;
+
+	ret = cros_ec_cmd_xfer(ec_dev, &msg);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, cros_kunit_ec_cmd_xfer_mock_called, 0);
+	KUNIT_EXPECT_EQ(test, cros_kunit_ec_pkt_xfer_mock_called, 1);
+}
+
+static void cros_ec_proto_test_cmd_xfer_protocol_v3_no_op(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	int ret;
+	struct cros_ec_command msg;
+
+	memset(&msg, 0, sizeof(msg));
+
+	ec_dev->proto_version = 3;
+	ec_dev->cmd_xfer = cros_kunit_ec_cmd_xfer_mock;
+	ec_dev->pkt_xfer = NULL;
+
+	ret = cros_ec_cmd_xfer(ec_dev, &msg);
+	KUNIT_EXPECT_EQ(test, ret, -EIO);
+}
+
+static void cros_ec_proto_test_cmd_xfer_protocol_v2_normal(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	int ret;
+	struct cros_ec_command msg;
+
+	memset(&msg, 0, sizeof(msg));
+
+	ec_dev->proto_version = 2;
+	ec_dev->cmd_xfer = cros_kunit_ec_cmd_xfer_mock;
+	ec_dev->pkt_xfer = cros_kunit_ec_pkt_xfer_mock;
+
+	ret = cros_ec_cmd_xfer(ec_dev, &msg);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, cros_kunit_ec_cmd_xfer_mock_called, 1);
+	KUNIT_EXPECT_EQ(test, cros_kunit_ec_pkt_xfer_mock_called, 0);
+}
+
+static void cros_ec_proto_test_cmd_xfer_protocol_v2_no_op(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	int ret;
+	struct cros_ec_command msg;
+
+	memset(&msg, 0, sizeof(msg));
+
+	ec_dev->proto_version = 2;
+	ec_dev->cmd_xfer = NULL;
+	ec_dev->pkt_xfer = cros_kunit_ec_pkt_xfer_mock;
+
+	ret = cros_ec_cmd_xfer(ec_dev, &msg);
+	KUNIT_EXPECT_EQ(test, ret, -EIO);
+}
+
+static void cros_ec_proto_test_cmd_xfer_in_progress_normal(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret;
+	struct cros_ec_command msg;
+
+	memset(&msg, 0, sizeof(msg));
+
+	ec_dev->pkt_xfer = cros_kunit_ec_pkt_xfer_mock;
+
+	/* For the first host command to return EC_RES_IN_PROGRESS. */
+	{
+		mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_IN_PROGRESS, 0);
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+	}
+
+	/* For EC_CMD_GET_COMMS_STATUS. */
+	{
+		struct ec_response_get_comms_status *data;
+
+		mock = cros_kunit_ec_xfer_mock_add(test, sizeof(*data));
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+
+		data = (struct ec_response_get_comms_status *)mock->o_data;
+		data->flags = 0;
+	}
+
+	ret = cros_ec_cmd_xfer(ec_dev, &msg);
+	KUNIT_EXPECT_EQ(test, ret, sizeof(struct ec_response_get_comms_status));
+
+	KUNIT_EXPECT_EQ(test, msg.result, EC_RES_SUCCESS);
+
+	/* For the first host command to return EC_RES_IN_PROGRESS. */
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+	}
+
+	/* For EC_CMD_GET_COMMS_STATUS. */
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_COMMS_STATUS);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize,
+				sizeof(struct ec_response_get_comms_status));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
+	}
+
+	KUNIT_EXPECT_EQ(test, cros_kunit_ec_pkt_xfer_mock_called, 2);
+}
+
+static void cros_ec_proto_test_cmd_xfer_in_progress_retries_eagain(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret;
+	struct cros_ec_command msg;
+
+	memset(&msg, 0, sizeof(msg));
+
+	ec_dev->pkt_xfer = cros_kunit_ec_pkt_xfer_mock;
+
+	/* For the first host command to return EC_RES_IN_PROGRESS. */
+	{
+		mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_IN_PROGRESS, 0);
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+	}
+
+	/* For EC_CMD_GET_COMMS_STATUS EC_COMMAND_RETRIES times. */
+	cros_kunit_ec_xfer_mock_default_ret = -EAGAIN;
+
+	ret = cros_ec_cmd_xfer(ec_dev, &msg);
+	KUNIT_EXPECT_EQ(test, ret, -EAGAIN);
+
+	/* For EC_CMD_GET_COMMS_STATUS EC_COMMAND_RETRIES times. */
+	KUNIT_EXPECT_EQ(test, cros_kunit_ec_pkt_xfer_mock_called, 51);
+}
+
+static void cros_ec_proto_test_cmd_xfer_in_progress_retries_status_processing(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret;
+	struct cros_ec_command msg;
+
+	memset(&msg, 0, sizeof(msg));
+
+	ec_dev->pkt_xfer = cros_kunit_ec_pkt_xfer_mock;
+
+	/* For the first host command to return EC_RES_IN_PROGRESS. */
+	{
+		mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_IN_PROGRESS, 0);
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+	}
+
+	/* For EC_CMD_GET_COMMS_STATUS EC_COMMAND_RETRIES times. */
+	{
+		struct ec_response_get_comms_status *data;
+		int i;
+
+		for (i = 0; i < 50; ++i) {
+			mock = cros_kunit_ec_xfer_mock_add(test, sizeof(*data));
+			KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+
+			data = (struct ec_response_get_comms_status *)mock->o_data;
+			data->flags |= EC_COMMS_STATUS_PROCESSING;
+		}
+	}
+
+	ret = cros_ec_cmd_xfer(ec_dev, &msg);
+	KUNIT_EXPECT_EQ(test, ret, sizeof(struct ec_response_get_comms_status));
+
+	KUNIT_EXPECT_EQ(test, msg.result, EC_RES_SUCCESS);
+
+	/* For EC_CMD_GET_COMMS_STATUS EC_COMMAND_RETRIES times. */
+	KUNIT_EXPECT_EQ(test, cros_kunit_ec_pkt_xfer_mock_called, 51);
+}
+
+static void cros_ec_proto_test_cmd_xfer_in_progress_xfer_error(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret;
+	struct cros_ec_command msg;
+
+	memset(&msg, 0, sizeof(msg));
+
+	/* For the first host command to return EC_RES_IN_PROGRESS. */
+	{
+		mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_IN_PROGRESS, 0);
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+	}
+
+	/* For EC_CMD_GET_COMMS_STATUS. */
+	{
+		mock = cros_kunit_ec_xfer_mock_addx(test, -EIO, EC_RES_SUCCESS, 0);
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+	}
+
+	ret = cros_ec_cmd_xfer(ec_dev, &msg);
+	KUNIT_EXPECT_EQ(test, ret, -EIO);
+}
+
+static void cros_ec_proto_test_cmd_xfer_in_progress_return_error(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret;
+	struct cros_ec_command msg;
+
+	memset(&msg, 0, sizeof(msg));
+
+	ec_dev->pkt_xfer = cros_kunit_ec_pkt_xfer_mock;
+
+	/* For the first host command to return EC_RES_IN_PROGRESS. */
+	{
+		mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_IN_PROGRESS, 0);
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+	}
+
+	/* For EC_CMD_GET_COMMS_STATUS. */
+	{
+		mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND, 0);
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+	}
+
+	ret = cros_ec_cmd_xfer(ec_dev, &msg);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, msg.result, EC_RES_INVALID_COMMAND);
+
+	KUNIT_EXPECT_EQ(test, cros_kunit_ec_pkt_xfer_mock_called, 2);
+}
+
 static void cros_ec_proto_test_release(struct device *dev)
 {
 }
@@ -1750,6 +2006,15 @@ static struct kunit_case cros_ec_proto_test_cases[] = {
 	KUNIT_CASE(cros_ec_proto_test_cmd_xfer_excess_msg_insize),
 	KUNIT_CASE(cros_ec_proto_test_cmd_xfer_excess_msg_outsize_without_passthru),
 	KUNIT_CASE(cros_ec_proto_test_cmd_xfer_excess_msg_outsize_with_passthru),
+	KUNIT_CASE(cros_ec_proto_test_cmd_xfer_protocol_v3_normal),
+	KUNIT_CASE(cros_ec_proto_test_cmd_xfer_protocol_v3_no_op),
+	KUNIT_CASE(cros_ec_proto_test_cmd_xfer_protocol_v2_normal),
+	KUNIT_CASE(cros_ec_proto_test_cmd_xfer_protocol_v2_no_op),
+	KUNIT_CASE(cros_ec_proto_test_cmd_xfer_in_progress_normal),
+	KUNIT_CASE(cros_ec_proto_test_cmd_xfer_in_progress_retries_eagain),
+	KUNIT_CASE(cros_ec_proto_test_cmd_xfer_in_progress_retries_status_processing),
+	KUNIT_CASE(cros_ec_proto_test_cmd_xfer_in_progress_xfer_error),
+	KUNIT_CASE(cros_ec_proto_test_cmd_xfer_in_progress_return_error),
 	{}
 };
 
diff --git a/drivers/platform/chrome/cros_kunit_util.c b/drivers/platform/chrome/cros_kunit_util.c
index 6810d558d462..e6a0a1b4ed4b 100644
--- a/drivers/platform/chrome/cros_kunit_util.c
+++ b/drivers/platform/chrome/cros_kunit_util.c
@@ -17,6 +17,10 @@ int cros_kunit_ec_xfer_mock_default_result;
 EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock_default_result);
 int cros_kunit_ec_xfer_mock_default_ret;
 EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock_default_ret);
+int cros_kunit_ec_cmd_xfer_mock_called;
+EXPORT_SYMBOL_GPL(cros_kunit_ec_cmd_xfer_mock_called);
+int cros_kunit_ec_pkt_xfer_mock_called;
+EXPORT_SYMBOL_GPL(cros_kunit_ec_pkt_xfer_mock_called);
 
 static struct list_head cros_kunit_ec_xfer_mock_in;
 static struct list_head cros_kunit_ec_xfer_mock_out;
@@ -50,6 +54,20 @@ int cros_kunit_ec_xfer_mock(struct cros_ec_device *ec_dev, struct cros_ec_comman
 }
 EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock);
 
+int cros_kunit_ec_cmd_xfer_mock(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
+{
+	++cros_kunit_ec_cmd_xfer_mock_called;
+	return cros_kunit_ec_xfer_mock(ec_dev, msg);
+}
+EXPORT_SYMBOL_GPL(cros_kunit_ec_cmd_xfer_mock);
+
+int cros_kunit_ec_pkt_xfer_mock(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
+{
+	++cros_kunit_ec_pkt_xfer_mock_called;
+	return cros_kunit_ec_xfer_mock(ec_dev, msg);
+}
+EXPORT_SYMBOL_GPL(cros_kunit_ec_pkt_xfer_mock);
+
 struct ec_xfer_mock *cros_kunit_ec_xfer_mock_add(struct kunit *test, size_t size)
 {
 	return cros_kunit_ec_xfer_mock_addx(test, size, EC_RES_SUCCESS, size);
@@ -95,6 +113,8 @@ void cros_kunit_mock_reset(void)
 {
 	cros_kunit_ec_xfer_mock_default_result = 0;
 	cros_kunit_ec_xfer_mock_default_ret = 0;
+	cros_kunit_ec_cmd_xfer_mock_called = 0;
+	cros_kunit_ec_pkt_xfer_mock_called = 0;
 	INIT_LIST_HEAD(&cros_kunit_ec_xfer_mock_in);
 	INIT_LIST_HEAD(&cros_kunit_ec_xfer_mock_out);
 }
diff --git a/drivers/platform/chrome/cros_kunit_util.h b/drivers/platform/chrome/cros_kunit_util.h
index 79c4f259f2bb..85e2974fd048 100644
--- a/drivers/platform/chrome/cros_kunit_util.h
+++ b/drivers/platform/chrome/cros_kunit_util.h
@@ -25,8 +25,12 @@ struct ec_xfer_mock {
 
 extern int cros_kunit_ec_xfer_mock_default_result;
 extern int cros_kunit_ec_xfer_mock_default_ret;
+extern int cros_kunit_ec_cmd_xfer_mock_called;
+extern int cros_kunit_ec_pkt_xfer_mock_called;
 
 int cros_kunit_ec_xfer_mock(struct cros_ec_device *ec_dev, struct cros_ec_command *msg);
+int cros_kunit_ec_cmd_xfer_mock(struct cros_ec_device *ec_dev, struct cros_ec_command *msg);
+int cros_kunit_ec_pkt_xfer_mock(struct cros_ec_device *ec_dev, struct cros_ec_command *msg);
 struct ec_xfer_mock *cros_kunit_ec_xfer_mock_add(struct kunit *test, size_t size);
 struct ec_xfer_mock *cros_kunit_ec_xfer_mock_addx(struct kunit *test,
 						  int ret, int result, size_t size);
-- 
2.37.0.170.g444d1eabd0-goog

