Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB57544680
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242477AbiFIIwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242573AbiFIIut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:50:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C40C47561
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 01:50:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CDA2DB82C8A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 08:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D7CC341C0;
        Thu,  9 Jun 2022 08:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654764632;
        bh=YqibN8iiTS3WQ3U0XqWD/LCELanWa3MM7HbOLkVQWUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NVL9Ti3US19rJXfx4EVpU6oEPkJtSv8z56PyA2UxYncgOFqDjqoMPBgxufkwyHa3F
         //LJTWhEuRI5Gsf4ZOSOc9tg/meVgl8Nm5BDnHF54BcA2ZssPXRFKUrD03c0ooM8lx
         BVpqQeQtF0+nbnUcf5LGTKkh1V1t96CJGEaTQPH+jfRs22m5ZPpz28XKRCqmUDSxGe
         7hl1D3XOmyNYxAt+3iixn16Bw/oncXzTk0mvNpgRKvBOcPCLacjJURDujUF4+AtU8V
         +d5w/lMnw+MTVgxUT8qetMnqMyxIwbbSqyUOhVraja+kkV5NywcT43zFVSx6ZwiYSH
         Yh1akVX1E/umA==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 15/21] platform/chrome: cros_ec_proto: add Kunit test for getting cmd mask error
Date:   Thu,  9 Jun 2022 08:49:51 +0000
Message-Id: <20220609084957.3684698-16-tzungbi@kernel.org>
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

cros_ec_query_all() uses cros_ec_get_host_command_version_mask() to
query the supported MKBP version; cros_ec_get_host_command_version_mask()
uses send_command() for transferring the host command.

Returning >=0 from send_command() only denotes the transfer was success.
cros_ec_get_host_command_version_mask() should check if EC wasn't happy
by checking `msg->result`.

Add a Kunit test for returning error in `msg->result` in
cros_ec_get_host_command_version_mask().  For the case,
cros_ec_query_all() should find the EC device doesn't support MKBP.

Reviewed-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v3:
- Add R-b tag.
- Fix typo s/transfering/transferring/.

 drivers/platform/chrome/cros_ec_proto_test.c | 89 ++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
index 63071af81c94..ce7a2f64f01b 100644
--- a/drivers/platform/chrome/cros_ec_proto_test.c
+++ b/drivers/platform/chrome/cros_ec_proto_test.c
@@ -892,6 +892,94 @@ static void cros_ec_proto_test_query_all_no_mkbp(struct kunit *test)
 	}
 }
 
+static void cros_ec_proto_test_query_all_no_mkbp_return_error(struct kunit *test)
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
+		mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND, 0);
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
@@ -1185,6 +1273,7 @@ static struct kunit_case cros_ec_proto_test_cases[] = {
 	KUNIT_CASE(cros_ec_proto_test_query_all_legacy_data_error),
 	KUNIT_CASE(cros_ec_proto_test_query_all_legacy_return0),
 	KUNIT_CASE(cros_ec_proto_test_query_all_no_mkbp),
+	KUNIT_CASE(cros_ec_proto_test_query_all_no_mkbp_return_error),
 	KUNIT_CASE(cros_ec_proto_test_query_all_no_host_sleep),
 	KUNIT_CASE(cros_ec_proto_test_query_all_default_wake_mask_return_error),
 	{}
-- 
2.36.1.255.ge46751e96f-goog

