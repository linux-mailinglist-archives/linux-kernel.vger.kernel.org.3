Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCC75401E3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343707AbiFGO5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343588AbiFGO5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:57:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8413DF5504
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 07:57:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E4A1B820C0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B77C385A5;
        Tue,  7 Jun 2022 14:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654613823;
        bh=nDnXhWwGWY2yGaLSuRCAm0nBVVcyRnqJYYG907O4XyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nd4p7QhupV2Nce3ccr1qtQJn+L3tFhCevXuqUWH6rWzzS5sYynfbv2x2nDZ9YeYrk
         eBDEwiaaIU0UdIwRkREBVpkS2ZBgL61V+agdcj3O+8+YfC0DmVXjIadrk91l3UJ9m+
         jOPLhiVlSDYY2W1bQEGhBGbm2onfWgPXVjBndojGhdNSzMvY4ezBcD+4yLhlISLSe3
         CdaGcaBgxP1PqfOSyZ/BMgg7VKEkWkFZkN0aNfwH4Q1YzYdGHv38mkGekvBLvbeeyV
         j2y/Em47lIdSzG0vPsLn0UrLPuTPWPSkFNHfHzAQGHrLp6/JiEtmPxDiVqW/iddjwZ
         9cHlFs0Bf2JTw==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        tzungbi@kernel.org
Subject: [PATCH v2 09/15] platform/chrome: cros_ec_proto: separate cros_ec_get_proto_info_legacy()
Date:   Tue,  7 Jun 2022 14:56:33 +0000
Message-Id: <20220607145639.2362750-10-tzungbi@kernel.org>
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

Rename cros_ec_host_command_proto_query_v2() to
cros_ec_get_proto_info_legacy() and make it responsible for setting
`ec_dev` fields for EC protocol v2.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v1:
- Preserve the "cros_ec_" prefix.

 drivers/platform/chrome/cros_ec_proto.c      | 72 +++++++++-----------
 drivers/platform/chrome/cros_ec_proto_test.c | 22 +++---
 2 files changed, 44 insertions(+), 50 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 6f5be9e5ede4..04b9704ed302 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -351,51 +351,57 @@ static int cros_ec_get_proto_info(struct cros_ec_device *ec_dev, int devidx)
 	return ret;
 }
 
-static int cros_ec_host_command_proto_query_v2(struct cros_ec_device *ec_dev)
+static int cros_ec_get_proto_info_legacy(struct cros_ec_device *ec_dev)
 {
 	struct cros_ec_command *msg;
-	struct ec_params_hello *hello_params;
-	struct ec_response_hello *hello_response;
+	struct ec_params_hello *params;
+	struct ec_response_hello *response;
 	int ret;
-	int len = max(sizeof(*hello_params), sizeof(*hello_response));
 
-	msg = kmalloc(sizeof(*msg) + len, GFP_KERNEL);
+	ec_dev->proto_version = 2;
+
+	msg = kzalloc(sizeof(*msg) + max(sizeof(*params), sizeof(*response)), GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
 
-	msg->version = 0;
 	msg->command = EC_CMD_HELLO;
-	hello_params = (struct ec_params_hello *)msg->data;
-	msg->outsize = sizeof(*hello_params);
-	hello_response = (struct ec_response_hello *)msg->data;
-	msg->insize = sizeof(*hello_response);
+	msg->insize = sizeof(*response);
+	msg->outsize = sizeof(*params);
 
-	hello_params->in_data = 0xa0b0c0d0;
+	params = (struct ec_params_hello *)msg->data;
+	params->in_data = 0xa0b0c0d0;
 
 	ret = send_command(ec_dev, msg);
-
 	if (ret < 0) {
-		dev_dbg(ec_dev->dev,
-			"EC failed to respond to v2 hello: %d\n",
-			ret);
+		dev_dbg(ec_dev->dev, "EC failed to respond to v2 hello: %d\n", ret);
 		goto exit;
-	} else if (msg->result != EC_RES_SUCCESS) {
-		dev_err(ec_dev->dev,
-			"EC responded to v2 hello with error: %d\n",
-			msg->result);
-		ret = msg->result;
+	}
+
+	ret = cros_ec_map_error(msg->result);
+	if (ret) {
+		dev_err(ec_dev->dev, "EC responded to v2 hello with error: %d\n", msg->result);
 		goto exit;
-	} else if (hello_response->out_data != 0xa1b2c3d4) {
+	}
+
+	response = (struct ec_response_hello *)msg->data;
+	if (response->out_data != 0xa1b2c3d4) {
 		dev_err(ec_dev->dev,
 			"EC responded to v2 hello with bad result: %u\n",
-			hello_response->out_data);
+			response->out_data);
 		ret = -EBADMSG;
 		goto exit;
 	}
 
-	ret = 0;
+	ec_dev->max_request = EC_PROTO2_MAX_PARAM_SIZE;
+	ec_dev->max_response = EC_PROTO2_MAX_PARAM_SIZE;
+	ec_dev->max_passthru = 0;
+	ec_dev->pkt_xfer = NULL;
+	ec_dev->din_size = EC_PROTO2_MSG_BYTES;
+	ec_dev->dout_size = EC_PROTO2_MSG_BYTES;
 
- exit:
+	dev_dbg(ec_dev->dev, "falling back to proto v2\n");
+	ret = 0;
+exit:
 	kfree(msg);
 	return ret;
 }
@@ -467,20 +473,8 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
 		cros_ec_get_proto_info(ec_dev, CROS_EC_DEV_PD_INDEX);
 	} else {
 		/* Try querying with a v2 hello message. */
-		ec_dev->proto_version = 2;
-		ret = cros_ec_host_command_proto_query_v2(ec_dev);
-
-		if (ret == 0) {
-			/* V2 hello succeeded. */
-			dev_dbg(ec_dev->dev, "falling back to proto v2\n");
-
-			ec_dev->max_request = EC_PROTO2_MAX_PARAM_SIZE;
-			ec_dev->max_response = EC_PROTO2_MAX_PARAM_SIZE;
-			ec_dev->max_passthru = 0;
-			ec_dev->pkt_xfer = NULL;
-			ec_dev->din_size = EC_PROTO2_MSG_BYTES;
-			ec_dev->dout_size = EC_PROTO2_MSG_BYTES;
-		} else {
+		ret = cros_ec_get_proto_info_legacy(ec_dev);
+		if (ret) {
 			/*
 			 * It's possible for a test to occur too early when
 			 * the EC isn't listening. If this happens, we'll
@@ -488,7 +482,7 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
 			 */
 			ec_dev->proto_version = EC_PROTO_VERSION_UNKNOWN;
 			dev_dbg(ec_dev->dev, "EC query failed: %d\n", ret);
-			goto exit;
+			return ret;
 		}
 	}
 
diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
index 473714964cf2..9f7d9666369f 100644
--- a/drivers/platform/chrome/cros_ec_proto_test.c
+++ b/drivers/platform/chrome/cros_ec_proto_test.c
@@ -484,7 +484,7 @@ static void cros_ec_proto_test_query_all_legacy_normal_v3_return_error(struct ku
 		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
 	}
 
-	/* For cros_ec_host_command_proto_query_v2(). */
+	/* For cros_ec_get_proto_info_legacy(). */
 	{
 		struct ec_response_hello *data;
 
@@ -511,7 +511,7 @@ static void cros_ec_proto_test_query_all_legacy_normal_v3_return_error(struct ku
 		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
 	}
 
-	/* For cros_ec_host_command_proto_query_v2(). */
+	/* For cros_ec_get_proto_info_legacy(). */
 	{
 		struct ec_params_hello *data;
 
@@ -549,7 +549,7 @@ static void cros_ec_proto_test_query_all_legacy_normal_v3_return0(struct kunit *
 		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
 	}
 
-	/* For cros_ec_host_command_proto_query_v2(). */
+	/* For cros_ec_get_proto_info_legacy(). */
 	{
 		struct ec_response_hello *data;
 
@@ -576,7 +576,7 @@ static void cros_ec_proto_test_query_all_legacy_normal_v3_return0(struct kunit *
 		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
 	}
 
-	/* For cros_ec_host_command_proto_query_v2(). */
+	/* For cros_ec_get_proto_info_legacy(). */
 	{
 		struct ec_params_hello *data;
 
@@ -614,7 +614,7 @@ static void cros_ec_proto_test_query_all_legacy_xfer_error(struct kunit *test)
 		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
 	}
 
-	/* For cros_ec_host_command_proto_query_v2(). */
+	/* For cros_ec_get_proto_info_legacy(). */
 	{
 		mock = cros_kunit_ec_xfer_mock_addx(test, -EIO, EC_RES_SUCCESS, 0);
 		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
@@ -637,7 +637,7 @@ static void cros_ec_proto_test_query_all_legacy_xfer_error(struct kunit *test)
 		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
 	}
 
-	/* For cros_ec_host_command_proto_query_v2(). */
+	/* For cros_ec_get_proto_info_legacy(). */
 	{
 		mock = cros_kunit_ec_xfer_mock_next();
 		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
@@ -662,7 +662,7 @@ static void cros_ec_proto_test_query_all_legacy_return_error(struct kunit *test)
 		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
 	}
 
-	/* For cros_ec_host_command_proto_query_v2(). */
+	/* For cros_ec_get_proto_info_legacy(). */
 	{
 		mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND, 0);
 		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
@@ -670,7 +670,7 @@ static void cros_ec_proto_test_query_all_legacy_return_error(struct kunit *test)
 
 	cros_ec_proto_test_query_all_pretest(test);
 	ret = cros_ec_query_all(ec_dev);
-	KUNIT_EXPECT_EQ(test, ret, EC_RES_INVALID_COMMAND);
+	KUNIT_EXPECT_EQ(test, ret, -EOPNOTSUPP);
 	KUNIT_EXPECT_EQ(test, ec_dev->proto_version, EC_PROTO_VERSION_UNKNOWN);
 
 	/* For cros_ec_get_proto_info() without passthru. */
@@ -685,7 +685,7 @@ static void cros_ec_proto_test_query_all_legacy_return_error(struct kunit *test)
 		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
 	}
 
-	/* For cros_ec_host_command_proto_query_v2(). */
+	/* For cros_ec_get_proto_info_legacy(). */
 	{
 		mock = cros_kunit_ec_xfer_mock_next();
 		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
@@ -710,7 +710,7 @@ static void cros_ec_proto_test_query_all_legacy_data_error(struct kunit *test)
 		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
 	}
 
-	/* For cros_ec_host_command_proto_query_v2(). */
+	/* For cros_ec_get_proto_info_legacy(). */
 	{
 		struct ec_response_hello *data;
 
@@ -738,7 +738,7 @@ static void cros_ec_proto_test_query_all_legacy_data_error(struct kunit *test)
 		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
 	}
 
-	/* For cros_ec_host_command_proto_query_v2(). */
+	/* For cros_ec_get_proto_info_legacy(). */
 	{
 		mock = cros_kunit_ec_xfer_mock_next();
 		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
-- 
2.36.1.255.ge46751e96f-goog

