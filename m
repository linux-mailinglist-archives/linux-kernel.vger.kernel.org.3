Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555E854C114
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 07:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345711AbiFOFNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 01:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243538AbiFOFNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 01:13:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7614227160
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 22:13:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 054EC616A4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:13:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AB7C3411B;
        Wed, 15 Jun 2022 05:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655269987;
        bh=ZNPEv167URz6WTK9s6ICZv11yZTOdgPUlR8S5bdtLm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=owSQTeJsI+CF7/aM4z2eR3Wn65AbfYmGOuNUeqhcdyQ/LaZCwq57+tIq0Q8O8Zws/
         ILfAVs++70aRdsKXh6+Ds2KJsAw//DkFEJ6yYgGGsv7WjjdZF9kkjy/na+HtkRMNfb
         mlWE2SsH5bGbTEIqiMb91fBY6NDfnYyRHJZuwgRYAIcWUsAofkTuPbwzFAoQavjlfI
         0Am0Pd7QHG4FA7ioxl7lmlYk5y76i7jMFeiGTD2REkQulB48WC7DYkLOEDRbwYH0bR
         YhwHSQKhK8Vpw14OUkrWjbEPPdXrZjiNZ4y6hn7NDws5+SMqeseq88ZojNQXBbGhah
         As5134fy/8xXA==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] platform/chrome: cros_ec_proto: add Kunit tests for cros_ec_send_command()
Date:   Wed, 15 Jun 2022 05:12:40 +0000
Message-Id: <20220615051248.1628156-4-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220615051248.1628156-1-tzungbi@kernel.org>
References: <20220615051248.1628156-1-tzungbi@kernel.org>
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

cros_ec_cmd_xfer() is the only exported function that calls static
function cros_ec_send_command().

Add Kunit tests for cros_ec_send_command() through calling
cros_ec_cmd_xfer().

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
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
index e031777dea87..3ede971e82ee 100644
--- a/drivers/platform/chrome/cros_kunit_util.c
+++ b/drivers/platform/chrome/cros_kunit_util.c
@@ -15,6 +15,10 @@
 
 int cros_kunit_ec_xfer_mock_default_ret;
 EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock_default_ret);
+int cros_kunit_ec_cmd_xfer_mock_called;
+EXPORT_SYMBOL_GPL(cros_kunit_ec_cmd_xfer_mock_called);
+int cros_kunit_ec_pkt_xfer_mock_called;
+EXPORT_SYMBOL_GPL(cros_kunit_ec_pkt_xfer_mock_called);
 
 static struct list_head cros_kunit_ec_xfer_mock_in;
 static struct list_head cros_kunit_ec_xfer_mock_out;
@@ -46,6 +50,20 @@ int cros_kunit_ec_xfer_mock(struct cros_ec_device *ec_dev, struct cros_ec_comman
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
@@ -90,6 +108,8 @@ EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock_next);
 void cros_kunit_mock_reset(void)
 {
 	cros_kunit_ec_xfer_mock_default_ret = 0;
+	cros_kunit_ec_cmd_xfer_mock_called = 0;
+	cros_kunit_ec_pkt_xfer_mock_called = 0;
 	INIT_LIST_HEAD(&cros_kunit_ec_xfer_mock_in);
 	INIT_LIST_HEAD(&cros_kunit_ec_xfer_mock_out);
 }
diff --git a/drivers/platform/chrome/cros_kunit_util.h b/drivers/platform/chrome/cros_kunit_util.h
index 79c4525f873c..ae4080cb13f1 100644
--- a/drivers/platform/chrome/cros_kunit_util.h
+++ b/drivers/platform/chrome/cros_kunit_util.h
@@ -24,8 +24,12 @@ struct ec_xfer_mock {
 };
 
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
2.36.1.476.g0c4daa206d-goog

