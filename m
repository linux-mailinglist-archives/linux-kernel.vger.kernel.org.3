Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025B25446A3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242568AbiFIIxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242558AbiFIIur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:50:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2226412
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 01:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D1D2619BF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 08:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0BEC341C4;
        Thu,  9 Jun 2022 08:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654764623;
        bh=EdG5OzLY+Z1n/Q+SjiOMB4FhLiYyt4zEUGFNSpTwj60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a+fMI/zkshXHHppgKQ8POJy21qBAAELzVB8HogyH90j4WofG3hawu0enCJ/ENYs3x
         I+lr591B9lG3aIYlWEpaBuN8nkQJGWHX/nJ27+Gv503A0P0QfO89DmOq8LizaqPADk
         qAEJQCPuFEzV1+93lHPVakQQZUE/fYXvrcOMgQhQKfWtAQS+W3eEdhb9lQ4l/98k0x
         Kmy3R4SU42z4L6/A2cIwTRBZvMvgPfozlrSQXjfAeWNbqMLW6elSrQRxaZRRiXkl4B
         2PsoTqSTGJdpSU7IAIfz5jciaKcqcLM42FnE1UdDTTVDGXFbkNU5u3lwhtwqMy0tAq
         b0RIbplaIZOMA==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/21] platform/chrome: cros_ec_proto: add Kunit tests for getting proto info
Date:   Thu,  9 Jun 2022 08:49:44 +0000
Message-Id: <20220609084957.3684698-9-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220609084957.3684698-1-tzungbi@kernel.org>
References: <20220609084957.3684698-1-tzungbi@kernel.org>
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

cros_ec_get_proto_info() expects to receive
sizeof(struct ec_response_get_protocol_info) from send_command().  The
payload is valid only if the return value is positive.

Add Kunit tests for returning 0 from send_command() in
cros_ec_get_proto_info().

Reviewed-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v3:
- Add R-b tag.

 drivers/platform/chrome/cros_ec_proto_test.c | 132 +++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
index 8b16666c1657..1378ac90e1cb 100644
--- a/drivers/platform/chrome/cros_ec_proto_test.c
+++ b/drivers/platform/chrome/cros_ec_proto_test.c
@@ -407,6 +407,71 @@ static void cros_ec_proto_test_query_all_no_pd_return_error(struct kunit *test)
 	}
 }
 
+static void cros_ec_proto_test_query_all_no_pd_return0(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret;
+
+	/* Set some garbage bytes. */
+	ec_dev->max_passthru = 0xbf;
+
+	/* For cros_ec_get_proto_info() without passthru. */
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
+	/* For cros_ec_get_proto_info() with passthru. */
+	{
+		mock = cros_kunit_ec_xfer_mock_add(test, 0);
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+	}
+
+	cros_ec_proto_test_query_all_pretest(test);
+	ret = cros_ec_query_all(ec_dev);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	/* For cros_ec_get_proto_info() without passthru. */
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
+	/* For cros_ec_get_proto_info() with passthru. */
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command,
+				EC_CMD_PASSTHRU_OFFSET(CROS_EC_DEV_PD_INDEX) |
+				EC_CMD_GET_PROTOCOL_INFO);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize,
+				sizeof(struct ec_response_get_protocol_info));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
+
+		KUNIT_EXPECT_EQ(test, ec_dev->max_passthru, 0);
+	}
+}
+
 static void cros_ec_proto_test_query_all_legacy_normal_v3_return_error(struct kunit *test)
 {
 	struct cros_ec_proto_test_priv *priv = test->priv;
@@ -472,6 +537,71 @@ static void cros_ec_proto_test_query_all_legacy_normal_v3_return_error(struct ku
 	}
 }
 
+static void cros_ec_proto_test_query_all_legacy_normal_v3_return0(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret;
+
+	/* For cros_ec_get_proto_info() without passthru. */
+	{
+		mock = cros_kunit_ec_xfer_mock_add(test, 0);
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
+	/* For cros_ec_get_proto_info() without passthru. */
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
 static void cros_ec_proto_test_query_all_legacy_xfer_error(struct kunit *test)
 {
 	struct cros_ec_proto_test_priv *priv = test->priv;
@@ -999,7 +1129,9 @@ static struct kunit_case cros_ec_proto_test_cases[] = {
 	KUNIT_CASE(cros_ec_proto_test_check_result),
 	KUNIT_CASE(cros_ec_proto_test_query_all_normal),
 	KUNIT_CASE(cros_ec_proto_test_query_all_no_pd_return_error),
+	KUNIT_CASE(cros_ec_proto_test_query_all_no_pd_return0),
 	KUNIT_CASE(cros_ec_proto_test_query_all_legacy_normal_v3_return_error),
+	KUNIT_CASE(cros_ec_proto_test_query_all_legacy_normal_v3_return0),
 	KUNIT_CASE(cros_ec_proto_test_query_all_legacy_xfer_error),
 	KUNIT_CASE(cros_ec_proto_test_query_all_legacy_return_error),
 	KUNIT_CASE(cros_ec_proto_test_query_all_legacy_data_error),
-- 
2.36.1.255.ge46751e96f-goog

