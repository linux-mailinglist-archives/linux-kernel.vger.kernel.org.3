Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F79542ED5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 13:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238114AbiFHLJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 07:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237760AbiFHLIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 07:08:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777C220C6FE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 04:08:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EE0CB826ED
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 11:08:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10DFC34116;
        Wed,  8 Jun 2022 11:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654686491;
        bh=9utig9RF8Bg7Bq/WOH9xC9oQXeMrla6qE/iCHPr6IWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NM3L2chwImVtwLlgqM1npFjS+gWX6+2JutiGOQLobPUeMx+CFybDS1H9v+EjOFIr+
         o7a7efvFiOaGD07bEhYctlRZlOljRjPocF1Xnb5r992yH7XFh1lOw4D4dbeoaSz9Ly
         ZgI/Euz/CIsmQFCFV+IeV3o5n7IXYclGB50IWUD/NmQFFO271fiwcT0Ute03ud4Umi
         btlDbmRBEGA9XxTc4vgBo+4jzs2wuR+xHiA3QdAaluUA2n8q5wm5sBCa9LamDDbKiz
         AXODm/lnkiueOqrWxeIVXd+GM8hXDkgXMxbhAtOLOhFlOTHmI3xVj99L9BOOSvSl6u
         DsLKu134V5N9w==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 19/23] platform/chrome: cros_ec_proto: add Kunit tests for getting cmd mask
Date:   Wed,  8 Jun 2022 11:07:30 +0000
Message-Id: <20220608110734.2928245-20-tzungbi@kernel.org>
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

cros_ec_get_host_command_version_mask() expects to receive
sizeof(struct ec_response_get_cmd_versions) from send_command().
The payload is valid only if the return value is positive.

Add Kunit tests for returning 0 from send_command() in
cros_ec_get_host_command_version_mask().

Note that because the 2 cros_ec_get_host_command_version_mask() use the
same `ver_mask`.  cros_ec_proto_test_query_all_no_host_sleep_return0()
polluates the `ver_mask` and returns 0 on the second send_command() to
make sure the second cros_ec_get_host_command_version_mask() doesn't
take the garbage from the previous call.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
No v2.  New and separated from the original series.

 drivers/platform/chrome/cros_ec_proto_test.c | 197 +++++++++++++++++++
 1 file changed, 197 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
index eb6d77b95c9f..c988ff1e2a5a 100644
--- a/drivers/platform/chrome/cros_ec_proto_test.c
+++ b/drivers/platform/chrome/cros_ec_proto_test.c
@@ -980,6 +980,94 @@ static void cros_ec_proto_test_query_all_no_mkbp_return_error(struct kunit *test
 	}
 }
 
+static void cros_ec_proto_test_query_all_no_mkbp_return0(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret;
+
+	/* Set some garbage bytes. */
+	ec_dev->mkbp_event_supported = 0xbf;
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
 static void cros_ec_proto_test_query_all_no_host_sleep(struct kunit *test)
 {
 	struct cros_ec_proto_test_priv *priv = test->priv;
@@ -1086,6 +1174,113 @@ static void cros_ec_proto_test_query_all_no_host_sleep(struct kunit *test)
 	}
 }
 
+static void cros_ec_proto_test_query_all_no_host_sleep_return0(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret;
+
+	/* Set some garbage bytes. */
+	ec_dev->host_sleep_v1 = true;
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
+		/* In order to pollute next cros_ec_get_host_command_version_mask(). */
+		data = (struct ec_response_get_cmd_versions *)mock->o_data;
+		data->version_mask = 0xbeef;
+	}
+
+	/* For cros_ec_get_host_command_version_mask() for host sleep v1. */
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
 static void cros_ec_proto_test_query_all_default_wake_mask_return_error(struct kunit *test)
 {
 	struct cros_ec_proto_test_priv *priv = test->priv;
@@ -1274,7 +1469,9 @@ static struct kunit_case cros_ec_proto_test_cases[] = {
 	KUNIT_CASE(cros_ec_proto_test_query_all_legacy_return0),
 	KUNIT_CASE(cros_ec_proto_test_query_all_no_mkbp),
 	KUNIT_CASE(cros_ec_proto_test_query_all_no_mkbp_return_error),
+	KUNIT_CASE(cros_ec_proto_test_query_all_no_mkbp_return0),
 	KUNIT_CASE(cros_ec_proto_test_query_all_no_host_sleep),
+	KUNIT_CASE(cros_ec_proto_test_query_all_no_host_sleep_return0),
 	KUNIT_CASE(cros_ec_proto_test_query_all_default_wake_mask_return_error),
 	{}
 };
-- 
2.36.1.255.ge46751e96f-goog

