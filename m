Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED3B542ECB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 13:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237977AbiFHLIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 07:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237830AbiFHLIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 07:08:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D5F1BE64C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 04:07:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69C32B826F6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 11:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3800CC3411D;
        Wed,  8 Jun 2022 11:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654686478;
        bh=KgGHV8HGZxrDMaZtPZJVbiwZh64YRLAD041HgvaUotE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SqLe3SG28nNFzkXh0gGSMo7WR18rETz2v+bsR1PqyCrILhTlbtjSqfLAOW0dZGKlm
         jC8GcjG1SxTqhtnUYdvX2w3/GTtOAYmAbTBOpqv8hY1kYjNbXNXpIQm2lMlIEtUc/i
         O9AI1An8kQkrVoJ6wvIbX23y0D9ouMzlkZ9o+e5ZG1bkzgoocboHqmWDw0CMB/Y6Io
         Ek/R2hKwC0OjTLs8Bivxzp61tYiw/UdncagtlBIkyQtRvKwM5QB1AqdVxTqHN6XGYk
         oI7sViXh2I5+jAtT8Wv9YpUepIlQryIj9DR5xG8iHij5L5tNpu1aweRLMNOG4IcqKc
         plnRCrpyN+NPA==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/23] platform/chrome: cros_ec_proto: add Kunit tests for getting proto info
Date:   Wed,  8 Jun 2022 11:07:19 +0000
Message-Id: <20220608110734.2928245-9-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220608110734.2928245-1-tzungbi@kernel.org>
References: <20220608110734.2928245-1-tzungbi@kernel.org>
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

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
No v2.  New and separated from the original series.

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

