Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8B655414B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 06:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356516AbiFVEMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 00:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356882AbiFVELY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:11:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2073340D7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:11:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DE2B61909
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 04:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A589C341CE;
        Wed, 22 Jun 2022 04:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655871071;
        bh=h3iLpSbaIqSxlumUAzhaYH0B89//IZwGos4ci1lPn28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oRKD4uh7nx7nwt/6FT+fhd2G+HM3av39+MmyoV9GmgPhAGKmnL4xaw47RQvK1GJEn
         XVjQG8Va6zYlw669j2Pzv2ojPMQop3em54dtFPRD2VjM/sM40jvP2SQ+yZ16LEHZNE
         lqX27N5ZdybeWRi7JqJDg27ENhl4aBS9GpCa5kUEOMYKLsN3zZ5n5BNDFlE1TMGtwm
         ciIzkYvQoHsWwxToc2R0S/U/csBEDP5xaYn1KdDD5mZxMLoh54LSbLQLa9rcynD4Ej
         2mZ9BJP1ObSUljnRIXs5/3gv4XNjYCjqwd8W17igVnOQxylCcL+P7sNnfvKrySSoy1
         ksc8gB5fHeMAw==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] platform/chrome: cros_ec_proto: add Kunit tests for get_next_event
Date:   Wed, 22 Jun 2022 04:10:36 +0000
Message-Id: <20220622041040.202737-4-tzungbi@kernel.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
In-Reply-To: <20220622041040.202737-1-tzungbi@kernel.org>
References: <20220622041040.202737-1-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cros_ec_get_next_event() gets events from EC.  It consists of 3
versions of event retrieval:

1. No MKBP event.
2. MKBP event version 0.
3. MKBP event version >0.

Add Kunit tests for cros_ec_get_next_event().

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_proto_test.c | 266 +++++++++++++++++++
 1 file changed, 266 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
index be3ac77abdf9..64c4b79f7a0c 100644
--- a/drivers/platform/chrome/cros_ec_proto_test.c
+++ b/drivers/platform/chrome/cros_ec_proto_test.c
@@ -5,6 +5,7 @@
 
 #include <kunit/test.h>
 
+#include <asm-generic/unaligned.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 
@@ -2052,6 +2053,265 @@ static void cros_ec_proto_test_cmd_xfer_status_return_error(struct kunit *test)
 	}
 }
 
+static void cros_ec_proto_test_get_next_event_no_mkbp_event(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret;
+	bool wake_event, more_events;
+
+	ec_dev->max_request = 0xff;
+	ec_dev->max_response = 0xee;
+	ec_dev->mkbp_event_supported = 0;
+
+	/* Set some garbage bytes. */
+	wake_event = false;
+	more_events = true;
+
+	/* For get_keyboard_state_event(). */
+	{
+		union ec_response_get_next_data_v1 *data;
+
+		mock = cros_kunit_ec_xfer_mock_add(test, sizeof(*data));
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+
+		data = (union ec_response_get_next_data_v1 *)mock->o_data;
+		data->host_event = 0xbeef;
+	}
+
+	ret = cros_ec_get_next_event(ec_dev, &wake_event, &more_events);
+	KUNIT_EXPECT_EQ(test, ret, sizeof(union ec_response_get_next_data_v1));
+
+	KUNIT_EXPECT_EQ(test, ec_dev->event_data.event_type, EC_MKBP_EVENT_KEY_MATRIX);
+	KUNIT_EXPECT_EQ(test, ec_dev->event_data.data.host_event, 0xbeef);
+
+	KUNIT_EXPECT_TRUE(test, wake_event);
+	KUNIT_EXPECT_FALSE(test, more_events);
+
+	/* For get_keyboard_state_event(). */
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_MKBP_STATE);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize, sizeof(union ec_response_get_next_data_v1));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
+	}
+}
+
+static void cros_ec_proto_test_get_next_event_mkbp_event_ec_suspended(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	int ret;
+
+	ec_dev->mkbp_event_supported = 1;
+	ec_dev->suspended = true;
+
+	ret = cros_ec_get_next_event(ec_dev, NULL, NULL);
+	KUNIT_EXPECT_EQ(test, ret, -EHOSTDOWN);
+}
+
+static void cros_ec_proto_test_get_next_event_mkbp_event_version0(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret;
+	bool wake_event, more_events;
+
+	ec_dev->max_request = 0xff;
+	ec_dev->max_response = 0xee;
+	ec_dev->mkbp_event_supported = 1;
+
+	/* Set some garbage bytes. */
+	wake_event = true;
+	more_events = false;
+
+	/* For get_next_event_xfer(). */
+	{
+		struct ec_response_get_next_event *data;
+
+		mock = cros_kunit_ec_xfer_mock_add(test, sizeof(*data));
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+
+		data = (struct ec_response_get_next_event *)mock->o_data;
+		data->event_type = EC_MKBP_EVENT_SENSOR_FIFO | EC_MKBP_HAS_MORE_EVENTS;
+		data->data.sysrq = 0xbeef;
+	}
+
+	ret = cros_ec_get_next_event(ec_dev, &wake_event, &more_events);
+	KUNIT_EXPECT_EQ(test, ret, sizeof(struct ec_response_get_next_event));
+
+	KUNIT_EXPECT_EQ(test, ec_dev->event_data.event_type, EC_MKBP_EVENT_SENSOR_FIFO);
+	KUNIT_EXPECT_EQ(test, ec_dev->event_data.data.sysrq, 0xbeef);
+
+	KUNIT_EXPECT_FALSE(test, wake_event);
+	KUNIT_EXPECT_TRUE(test, more_events);
+
+	/* For get_next_event_xfer(). */
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_NEXT_EVENT);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize, sizeof(struct ec_response_get_next_event));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
+	}
+}
+
+static void cros_ec_proto_test_get_next_event_mkbp_event_version2(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret;
+	bool wake_event, more_events;
+
+	ec_dev->max_request = 0xff;
+	ec_dev->max_response = 0xee;
+	ec_dev->mkbp_event_supported = 3;
+
+	/* Set some garbage bytes. */
+	wake_event = false;
+	more_events = true;
+
+	/* For get_next_event_xfer(). */
+	{
+		struct ec_response_get_next_event_v1 *data;
+
+		mock = cros_kunit_ec_xfer_mock_add(test, sizeof(*data));
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+
+		data = (struct ec_response_get_next_event_v1 *)mock->o_data;
+		data->event_type = EC_MKBP_EVENT_FINGERPRINT;
+		data->data.sysrq = 0xbeef;
+	}
+
+	ret = cros_ec_get_next_event(ec_dev, &wake_event, &more_events);
+	KUNIT_EXPECT_EQ(test, ret, sizeof(struct ec_response_get_next_event_v1));
+
+	KUNIT_EXPECT_EQ(test, ec_dev->event_data.event_type, EC_MKBP_EVENT_FINGERPRINT);
+	KUNIT_EXPECT_EQ(test, ec_dev->event_data.data.sysrq, 0xbeef);
+
+	KUNIT_EXPECT_TRUE(test, wake_event);
+	KUNIT_EXPECT_FALSE(test, more_events);
+
+	/* For get_next_event_xfer(). */
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 2);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_NEXT_EVENT);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize,
+				sizeof(struct ec_response_get_next_event_v1));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
+	}
+}
+
+static void cros_ec_proto_test_get_next_event_mkbp_event_host_event_rtc(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret;
+	bool wake_event;
+	struct ec_response_get_next_event_v1 *data;
+
+	ec_dev->max_request = 0xff;
+	ec_dev->max_response = 0xee;
+	ec_dev->mkbp_event_supported = 3;
+	ec_dev->host_event_wake_mask = U32_MAX;
+
+	/* Set some garbage bytes. */
+	wake_event = true;
+
+	/* For get_next_event_xfer(). */
+	{
+		mock = cros_kunit_ec_xfer_mock_add(test,
+						   sizeof(data->event_type) +
+						   sizeof(data->data.host_event));
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+
+		data = (struct ec_response_get_next_event_v1 *)mock->o_data;
+		data->event_type = EC_MKBP_EVENT_HOST_EVENT;
+		put_unaligned_le32(EC_HOST_EVENT_MASK(EC_HOST_EVENT_RTC), &data->data.host_event);
+	}
+
+	ret = cros_ec_get_next_event(ec_dev, &wake_event, NULL);
+	KUNIT_EXPECT_EQ(test, ret, sizeof(data->event_type) + sizeof(data->data.host_event));
+
+	KUNIT_EXPECT_EQ(test, ec_dev->event_data.event_type, EC_MKBP_EVENT_HOST_EVENT);
+
+	KUNIT_EXPECT_FALSE(test, wake_event);
+
+	/* For get_next_event_xfer(). */
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 2);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_NEXT_EVENT);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize,
+				sizeof(struct ec_response_get_next_event_v1));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
+	}
+}
+
+static void cros_ec_proto_test_get_next_event_mkbp_event_host_event_masked(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret;
+	bool wake_event;
+	struct ec_response_get_next_event_v1 *data;
+
+	ec_dev->max_request = 0xff;
+	ec_dev->max_response = 0xee;
+	ec_dev->mkbp_event_supported = 3;
+	ec_dev->host_event_wake_mask = U32_MAX & ~EC_HOST_EVENT_MASK(EC_HOST_EVENT_AC_DISCONNECTED);
+
+	/* Set some garbage bytes. */
+	wake_event = true;
+
+	/* For get_next_event_xfer(). */
+	{
+		mock = cros_kunit_ec_xfer_mock_add(test,
+						   sizeof(data->event_type) +
+						   sizeof(data->data.host_event));
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+
+		data = (struct ec_response_get_next_event_v1 *)mock->o_data;
+		data->event_type = EC_MKBP_EVENT_HOST_EVENT;
+		put_unaligned_le32(EC_HOST_EVENT_MASK(EC_HOST_EVENT_AC_DISCONNECTED),
+				   &data->data.host_event);
+	}
+
+	ret = cros_ec_get_next_event(ec_dev, &wake_event, NULL);
+	KUNIT_EXPECT_EQ(test, ret, sizeof(data->event_type) + sizeof(data->data.host_event));
+
+	KUNIT_EXPECT_EQ(test, ec_dev->event_data.event_type, EC_MKBP_EVENT_HOST_EVENT);
+
+	KUNIT_EXPECT_FALSE(test, wake_event);
+
+	/* For get_next_event_xfer(). */
+	{
+		mock = cros_kunit_ec_xfer_mock_next();
+		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
+
+		KUNIT_EXPECT_EQ(test, mock->msg.version, 2);
+		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_NEXT_EVENT);
+		KUNIT_EXPECT_EQ(test, mock->msg.insize,
+				sizeof(struct ec_response_get_next_event_v1));
+		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
+	}
+}
+
 static void cros_ec_proto_test_release(struct device *dev)
 {
 }
@@ -2135,6 +2395,12 @@ static struct kunit_case cros_ec_proto_test_cases[] = {
 	KUNIT_CASE(cros_ec_proto_test_cmd_xfer_status_normal),
 	KUNIT_CASE(cros_ec_proto_test_cmd_xfer_status_xfer_error),
 	KUNIT_CASE(cros_ec_proto_test_cmd_xfer_status_return_error),
+	KUNIT_CASE(cros_ec_proto_test_get_next_event_no_mkbp_event),
+	KUNIT_CASE(cros_ec_proto_test_get_next_event_mkbp_event_ec_suspended),
+	KUNIT_CASE(cros_ec_proto_test_get_next_event_mkbp_event_version0),
+	KUNIT_CASE(cros_ec_proto_test_get_next_event_mkbp_event_version2),
+	KUNIT_CASE(cros_ec_proto_test_get_next_event_mkbp_event_host_event_rtc),
+	KUNIT_CASE(cros_ec_proto_test_get_next_event_mkbp_event_host_event_masked),
 	{}
 };
 
-- 
2.37.0.rc0.104.g0611611a94-goog

