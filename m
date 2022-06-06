Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF9C53E8FF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239695AbiFFOM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239615AbiFFOMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:12:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CAE25C72
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:12:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A39EB819F4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 14:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B06C385A9;
        Mon,  6 Jun 2022 14:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654524729;
        bh=7TiEgNiICfiuJiznG+dnnnYsuwyExFEvzD8fxQfd54M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aPG5LCC1R+cUJc/eTyPITmVUkmxNiwDBH0vA1QR/WTiSNunGx96KDlsysLsUX2M8v
         hoihExCPUH9tiILDQBM+H6nA6acEOwJyG1RW02lvd1S5o9G5XUHyCXY07yb1rk2dRE
         YUvtr5jgaxp6AlGMdYZnmbMAqOXDKJhrNYSrUuXNzDMbkBvf1FTbl5/bIeyeAtkH8J
         Dx6dNosK/nMWk4sfuYdNT/qukggdJ5el2QsCJdyRTyL0JOB+AJDu+qf9CcPdprkNyh
         S7x54g0djuMshhyQm7WwOJN00N9nvq7iluykJRWcIm19auBi2CNi4J43LXc7nIpXSI
         URLjoKMGevdLg==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] platform/chrome: cros_ec_proto: fix get_host_command_version_mask() returns
Date:   Mon,  6 Jun 2022 14:10:49 +0000
Message-Id: <20220606141051.285823-12-tzungbi@kernel.org>
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

`mask` of get_host_command_version_mask() is valid only if it returns
positive number (i.e. sizeof(struct ec_response_get_cmd_versions)).

- Remove the unneeded `ver_mask` initialization.

- Update callers of get_host_command_version_mask() for checking correct
  return values.

- Add a Kunit test: `ver_mask` has some garbage bytes from
  previous EC_CMD_GET_NEXT_EVENT but there is no host sleep.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_proto.c      |   8 +-
 drivers/platform/chrome/cros_ec_proto_test.c | 109 +++++++++++++++++++
 2 files changed, 113 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 07b57ea105b6..91c945c9911f 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -409,7 +409,7 @@ static int fill_protocol_info_legacy(struct cros_ec_device *ec_dev)
  * @cmd: command to get the version of.
  * @mask: result when function returns 0.
  *
- * @return 0 on success, error code otherwise
+ * @return >0 on success, error code otherwise
  *
  * LOCKING:
  * the caller has ec_dev->lock mutex or the caller knows there is
@@ -454,7 +454,7 @@ static int get_host_command_version_mask(struct cros_ec_device *ec_dev, u16 cmd,
 int cros_ec_query_all(struct cros_ec_device *ec_dev)
 {
 	struct device *dev = ec_dev->dev;
-	u32 ver_mask = 0;
+	u32 ver_mask;
 	int ret;
 
 	/* First try sending with proto v3. */
@@ -486,7 +486,7 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
 
 	/* Probe if MKBP event is supported */
 	ret = get_host_command_version_mask(ec_dev, EC_CMD_GET_NEXT_EVENT, &ver_mask);
-	if (ret < 0 || ver_mask == 0) {
+	if (ret <= 0 || ver_mask == 0) {
 		ec_dev->mkbp_event_supported = 0;
 	} else {
 		ec_dev->mkbp_event_supported = fls(ver_mask);
@@ -495,7 +495,7 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
 
 	/* Probe if host sleep v1 is supported for S0ix failure detection. */
 	ret = get_host_command_version_mask(ec_dev, EC_CMD_HOST_SLEEP_EVENT, &ver_mask);
-	ec_dev->host_sleep_v1 = (ret >= 0 && (ver_mask & EC_VER_MASK(1)));
+	ec_dev->host_sleep_v1 = (ret > 0 && (ver_mask & EC_VER_MASK(1)));
 
 	/* Get host event wake mask. */
 	ret = cros_ec_get_host_event_wake_mask(ec_dev, &ec_dev->host_event_wake_mask);
diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
index e2c369765612..7d73aeb99d1d 100644
--- a/drivers/platform/chrome/cros_ec_proto_test.c
+++ b/drivers/platform/chrome/cros_ec_proto_test.c
@@ -760,6 +760,114 @@ static void cros_ec_proto_test_query_all_no_host_sleep(struct kunit *test)
 	}
 }
 
+static void cros_ec_proto_test_query_all_no_host_sleep2(struct kunit *test)
+{
+	struct cros_ec_proto_test_priv *priv = test->priv;
+	struct cros_ec_device *ec_dev = &priv->ec_dev;
+	struct ec_xfer_mock *mock;
+	int ret;
+
+	/* Set some garbage bytes. */
+	ec_dev->host_sleep_v1 = true;
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
+		struct ec_response_get_cmd_versions *data;
+
+		mock = cros_kunit_ec_xfer_mock_add(test, sizeof(*data));
+		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
+
+		/* In order to pollute next get_host_command_version_mask(). */
+		data = (struct ec_response_get_cmd_versions *)mock->o_data;
+		data->version_mask = 0xbeef;
+	}
+
+	/* For get_host_command_version_mask() for host sleep v1. */
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
+
+		KUNIT_EXPECT_FALSE(test, ec_dev->host_sleep_v1);
+	}
+}
+
 static void cros_ec_proto_test_query_all_default_wake_mask(struct kunit *test)
 {
 	struct cros_ec_proto_test_priv *priv = test->priv;
@@ -941,6 +1049,7 @@ static struct kunit_case cros_ec_proto_test_cases[] = {
 	KUNIT_CASE(cros_ec_proto_test_query_all_no_mkbp),
 	KUNIT_CASE(cros_ec_proto_test_query_all_no_mkbp2),
 	KUNIT_CASE(cros_ec_proto_test_query_all_no_host_sleep),
+	KUNIT_CASE(cros_ec_proto_test_query_all_no_host_sleep2),
 	KUNIT_CASE(cros_ec_proto_test_query_all_default_wake_mask),
 	{}
 };
-- 
2.36.1.255.ge46751e96f-goog

