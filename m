Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F2A54C11A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 07:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346161AbiFOFNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 01:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243804AbiFOFNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 01:13:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE00227176
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 22:13:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 794EDB81BFB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482A9C341C8;
        Wed, 15 Jun 2022 05:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655269986;
        bh=HzxmI06J0+gbvIw8Mk49vLYOJ5K4ttyGawmN3HAEkAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xv9vBWL8n9SKqDL5XgA7+/RWxjV1Fgc5qrjmUlBMVNaEQT9xEUXPu/Z6e3S6m16sT
         vbpmeTbwjo3ZvEMJPbIJvs1Qrwq3a9IdS5BaXbACx4m8fNkN/qLx4umd+cquOh5xpz
         Bd/i4sWRPzBfS75nd4V+5cG3qXizlscGiavOoHXHfLPEesvn6mDVTBL3hVZ7u7Fpgj
         TtrgO/jYOjG+BtFTn1tT2mX7iGfcjSrOzwBQO36u7S4xsTEzKU1IX9rEVnBon2VD15
         TVtfGFqLn4K2BREBjCGSVsGCeQaCXwXZ2HOqg4C/BONWnn0ppOto5wGtaQflelkosH
         9n9LeF4ZvuHtQ==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] platform/chrome: cros_ec_proto: add Kunit tests for cros_ec_cmd_xfer()
Date:   Wed, 15 Jun 2022 05:12:39 +0000
Message-Id: <20220615051248.1628156-3-tzungbi@kernel.org>
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

cros_ec_cmd_xfer() transfers the given command and data if any.  It
performs some sanity checks and calls cros_ec_send_command().

Add Kunit tests for cros_ec_cmd_xfer().

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_proto_test.c | 149 +++++++++++++++++++
 1 file changed, 149 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
index 1e2a1522c288..33721607a5b9 100644
--- a/drivers/platform/chrome/cros_ec_proto_test.c
+++ b/drivers/platform/chrome/cros_ec_proto_test.c
@@ -1535,6 +1535,151 @@ static void cros_ec_proto_test_query_all_default_wake_mask_return0(struct kunit
 	}
 }
 
+static void cros_ec_proto_test_cmd_xfer_normal(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret;
+	struct {
+		struct cros_ec_command msg;
+		u8 data[0x100];
+	} __packed buf;
+
+	ec_dev->max_request = 0xff;
+	ec_dev->max_response = 0xee;
+	ec_dev->max_passthru = 0xdd;
+
+	buf.msg.version = 0;
+	buf.msg.command = EC_CMD_HELLO;
+	buf.msg.insize = 4;
+	buf.msg.outsize = 2;
+	buf.data[0] = 0x55;
+	buf.data[1] = 0xaa;
+
+	{
+		u8 *data;
+
+		mock = cros_kunit_ec_xfer_mock_add(test, 4);
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+
+		data = (u8 *)mock->o_data;
+		data[0] = 0xaa;
+		data[1] = 0x55;
+		data[2] = 0xcc;
+		data[3] = 0x33;
+	}
+
+	ret = cros_ec_cmd_xfer(ec_dev, &buf.msg);
+	KUNIT_EXPECT_EQ(test, ret, 4);
+
+	{
+		u8 *data;
+
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_HELLO);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize, 4);
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 2);
+
+		data = (u8 *)mock->i_data;
+		KUNIT_EXPECT_EQ(test, data[0], 0x55);
+		KUNIT_EXPECT_EQ(test, data[1], 0xaa);
+
+		KUNIT_EXPECT_EQ(test, buf.data[0], 0xaa);
+		KUNIT_EXPECT_EQ(test, buf.data[1], 0x55);
+		KUNIT_EXPECT_EQ(test, buf.data[2], 0xcc);
+		KUNIT_EXPECT_EQ(test, buf.data[3], 0x33);
+	}
+}
+
+static void cros_ec_proto_test_cmd_xfer_excess_msg_insize(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret;
+	struct {
+		struct cros_ec_command msg;
+		u8 data[0x100];
+	} __packed buf;
+
+	ec_dev->max_request = 0xff;
+	ec_dev->max_response = 0xee;
+	ec_dev->max_passthru = 0xdd;
+
+	buf.msg.version = 0;
+	buf.msg.command = EC_CMD_HELLO;
+	buf.msg.insize = 0xee + 1;
+	buf.msg.outsize = 2;
+
+	{
+		mock = cros_kunit_ec_xfer_mock_add(test, 0xcc);
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+	}
+
+	ret = cros_ec_cmd_xfer(ec_dev, &buf.msg);
+	KUNIT_EXPECT_EQ(test, ret, 0xcc);
+
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_HELLO);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize, 0xee);
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 2);
+	}
+}
+
+static void cros_ec_proto_test_cmd_xfer_excess_msg_outsize_without_passthru(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	int ret;
+	struct {
+		struct cros_ec_command msg;
+		u8 data[0x100];
+	} __packed buf;
+
+	ec_dev->max_request = 0xff;
+	ec_dev->max_response = 0xee;
+	ec_dev->max_passthru = 0xdd;
+
+	buf.msg.version = 0;
+	buf.msg.command = EC_CMD_HELLO;
+	buf.msg.insize = 4;
+	buf.msg.outsize = 0xff + 1;
+
+	ret = cros_ec_cmd_xfer(ec_dev, &buf.msg);
+	KUNIT_EXPECT_EQ(test, ret, -EMSGSIZE);
+}
+
+static void cros_ec_proto_test_cmd_xfer_excess_msg_outsize_with_passthru(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	int ret;
+	struct {
+		struct cros_ec_command msg;
+		u8 data[0x100];
+	} __packed buf;
+
+	ec_dev->max_request = 0xff;
+	ec_dev->max_response = 0xee;
+	ec_dev->max_passthru = 0xdd;
+
+	buf.msg.version = 0;
+	buf.msg.command = EC_CMD_PASSTHRU_OFFSET(CROS_EC_DEV_PD_INDEX) + EC_CMD_HELLO;
+	buf.msg.insize = 4;
+	buf.msg.outsize = 0xdd + 1;
+
+	ret = cros_ec_cmd_xfer(ec_dev, &buf.msg);
+	KUNIT_EXPECT_EQ(test, ret, -EMSGSIZE);
+}
+
 static void cros_ec_proto_test_release(struct device *dev)
 {
 }
@@ -1601,6 +1746,10 @@ static struct kunit_case cros_ec_proto_test_cases[] = {
 	KUNIT_CASE(cros_ec_proto_test_query_all_no_host_sleep_return0),
 	KUNIT_CASE(cros_ec_proto_test_query_all_default_wake_mask_return_error),
 	KUNIT_CASE(cros_ec_proto_test_query_all_default_wake_mask_return0),
+	KUNIT_CASE(cros_ec_proto_test_cmd_xfer_normal),
+	KUNIT_CASE(cros_ec_proto_test_cmd_xfer_excess_msg_insize),
+	KUNIT_CASE(cros_ec_proto_test_cmd_xfer_excess_msg_outsize_without_passthru),
+	KUNIT_CASE(cros_ec_proto_test_cmd_xfer_excess_msg_outsize_with_passthru),
 	{}
 };
 
-- 
2.36.1.476.g0c4daa206d-goog

