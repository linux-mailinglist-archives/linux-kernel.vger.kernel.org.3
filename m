Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87F353EC4C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239700AbiFFONB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239636AbiFFOMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:12:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF5B25E8F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:12:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAAFE6136A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 14:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BF5C385A9;
        Mon,  6 Jun 2022 14:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654524732;
        bh=k9eV0AnZ2X92k+wBWdLIl2ZtT9hBC/I4zr6ytrdT4zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t4hZjEOXJ+NuA8XiPXLNzjQEQxggNNC+CMnJqlnw70hbYI7M++7qA7bPCh4TmXIc6
         6CJ4K6ejPGr1yvAhZpPNhhsCB2DGfU5OXk96TM5p63+troMV0xxY2T5k0ERfomZB9K
         5UtMSsyo1qy1MZ6T2NrRV4vCjJV5y6PcvJTkefj+aNWypnlcr6RDIAWyAmBiy3v068
         cndivhxIumK2c5lZute2owjcr+XXqQGCdfrECc/DI3D9VXJSakqY8EocnsDawMfYx6
         jeJIlSbHFFxsVfbn0X7dLZe1UE2eLzZS/+4MphAVEFSERBEg5PEC5AX41+cAv0n5cZ
         cWb/8R8pxfPLA==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] platform/chrome: cros_ec_proto: fix get_host_event_wake_mask() returns
Date:   Mon,  6 Jun 2022 14:10:51 +0000
Message-Id: <20220606141051.285823-14-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220606141051.285823-1-tzungbi@kernel.org>
References: <20220606141051.285823-1-tzungbi@kernel.org>
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

get_host_event_wake_mask() only gets valid result if send_command()
returns sizeof(struct ec_response_host_event_mask).  Simplify the
code and correct the callers.

Also add a Kunit test for guarding if get_host_event_wake_mask() returns 0.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_proto.c      |  15 +--
 drivers/platform/chrome/cros_ec_proto_test.c | 131 +++++++++++++++++++
 2 files changed, 137 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 1622e24747c9..1d2399473f35 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -236,7 +236,7 @@ EXPORT_SYMBOL(cros_ec_check_result);
  *
  * @ec_dev: EC device to call
  * @msg: message structure to use
- * @mask: result when function returns >=0.
+ * @mask: result when function returns >0.
  *
  * LOCKING:
  * the caller has ec_dev->lock mutex, or the caller knows there is
@@ -256,19 +256,16 @@ static int get_host_event_wake_mask(struct cros_ec_device *ec_dev, uint32_t *mas
 	msg->insize = sizeof(*r);
 
 	ret = send_command(ec_dev, msg);
-	if (ret >= 0) {
+	if (ret > 0) {
 		mapped = cros_ec_map_error(msg->result);
 		if (mapped) {
 			ret = mapped;
-			goto exit;
+		} else {
+			r = (struct ec_response_host_event_mask *)msg->data;
+			*mask = r->mask;
 		}
 	}
-	if (ret > 0) {
-		r = (struct ec_response_host_event_mask *)msg->data;
-		*mask = r->mask;
-	}
 
-exit:
 	kfree(msg);
 	return ret;
 }
@@ -499,7 +496,7 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
 
 	/* Get host event wake mask. */
 	ret = get_host_event_wake_mask(ec_dev, &ec_dev->host_event_wake_mask);
-	if (ret < 0) {
+	if (ret <= 0) {
 		/*
 		 * If the EC doesn't support EC_CMD_HOST_EVENT_GET_WAKE_MASK,
 		 * use a reasonable default. Note that we ignore various
diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
index f63196289f54..1ccc837b30cf 100644
--- a/drivers/platform/chrome/cros_ec_proto_test.c
+++ b/drivers/platform/chrome/cros_ec_proto_test.c
@@ -999,6 +999,136 @@ static void cros_ec_proto_test_query_all_default_wake_mask(struct kunit *test)
 	}
 }
 
+static void cros_ec_proto_test_query_all_default_wake_mask2(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret;
+
+	/* Set some garbage bytes. */
+	ec_dev->host_event_wake_mask = U32_MAX;
+
+	/* For fill_protocol_info() without passthru. */
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
+	/* For fill_protocol_info() with passthru. */
+	{
+		mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND,
+						    sizeof(struct ec_response_get_protocol_info));
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+	}
+
+	/* For get_host_command_version_mask() for MKBP. */
+	{
+		mock = cros_kunit_ec_xfer_mock_add(test,
+						   sizeof(struct ec_response_get_cmd_versions));
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+	}
+
+	/* For get_host_command_version_mask() for host sleep v1. */
+	{
+		mock = cros_kunit_ec_xfer_mock_add(test,
+						   sizeof(struct ec_response_get_cmd_versions));
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+	}
+
+	/* For get_host_event_wake_mask(). */
+	{
+		mock = cros_kunit_ec_xfer_mock_add(test, 0);
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+	}
+
+	cros_ec_proto_test_query_all_pretest(test);
+	ret = cros_ec_query_all(ec_dev);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	/* For fill_protocol_info() without passthru. */
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
+	/* For fill_protocol_info() with passthru. */
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
+	/* For get_host_command_version_mask() for MKBP. */
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
+	/* For get_host_command_version_mask() for host sleep v1. */
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
+	/* For get_host_event_wake_mask(). */
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
 static int cros_ec_proto_test_init(struct kunit *test)
 {
 	struct cros_ec_proto_test_priv *priv;
@@ -1051,6 +1181,7 @@ static struct kunit_case cros_ec_proto_test_cases[] = {
 	KUNIT_CASE(cros_ec_proto_test_query_all_no_host_sleep),
 	KUNIT_CASE(cros_ec_proto_test_query_all_no_host_sleep2),
 	KUNIT_CASE(cros_ec_proto_test_query_all_default_wake_mask),
+	KUNIT_CASE(cros_ec_proto_test_query_all_default_wake_mask2),
 	{}
 };
 
-- 
2.36.1.255.ge46751e96f-goog

