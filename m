Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF1C53EC2E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239681AbiFFOMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239598AbiFFOMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:12:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DBA18362
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:12:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB218B819FC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 14:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB625C3411F;
        Mon,  6 Jun 2022 14:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654524728;
        bh=zE3keGA2rUQlZAJOsUqxllyR6XVIoHy7R3cjiqJ6oiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dc49kEiYEQhhYYhYviY0kbfSJLnOpf4SyxLam6na0yHt+5ugZX1y4cVji3LeGDRsP
         GlnFZFqTUaDgc7iUmhEK8y83uIB3SkKScLHidnHMtqEbX7+D+R8Q6knZfohWGz/T8p
         c/gewoW1/RRy0dCrOoB2/aRvpPrAl4JwcjHKe0EJdLkiLra4wZiKdbgt/+GExzD6VC
         4S5I4t3UsyA5odYa/F7gZmcnJ/PbdIKg5/Ka4rGYjEzsU+U5UZxwKZ+kFAvThAmwxF
         ii26k5VtRPdnXT5kh4nNNi2eqMxwLMcejgGhLurP3lVtmWhc6VMFSa6VOyMGT9g4jR
         A97cIpw62VUPw==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] platform/chrome: cros_ec_proto: arrange get_host_command_version_mask()
Date:   Mon,  6 Jun 2022 14:10:48 +0000
Message-Id: <20220606141051.285823-11-tzungbi@kernel.org>
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

- cros_ec_get_host_command_version_mask() is a private (static) function.
  Rename it to get_host_command_version_mask().

- Join multiple lines into one if it can fit in 100 columns.

- Don't show MKBP support version if it doesn't support.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_proto.c      | 26 ++++++----------
 drivers/platform/chrome/cros_ec_proto_test.c | 32 ++++++++++----------
 2 files changed, 25 insertions(+), 33 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 5f4414f05d66..07b57ea105b6 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -400,7 +400,7 @@ static int fill_protocol_info_legacy(struct cros_ec_device *ec_dev)
 }
 
 /*
- * cros_ec_get_host_command_version_mask
+ * get_host_command_version_mask
  *
  * Get the version mask of a given command.
  *
@@ -415,16 +415,14 @@ static int fill_protocol_info_legacy(struct cros_ec_device *ec_dev)
  * the caller has ec_dev->lock mutex or the caller knows there is
  * no other command in progress.
  */
-static int cros_ec_get_host_command_version_mask(struct cros_ec_device *ec_dev,
-	u16 cmd, u32 *mask)
+static int get_host_command_version_mask(struct cros_ec_device *ec_dev, u16 cmd, u32 *mask)
 {
 	struct ec_params_get_cmd_versions *pver;
 	struct ec_response_get_cmd_versions *rver;
 	struct cros_ec_command *msg;
 	int ret;
 
-	msg = kmalloc(sizeof(*msg) + max(sizeof(*rver), sizeof(*pver)),
-		      GFP_KERNEL);
+	msg = kmalloc(sizeof(*msg) + max(sizeof(*rver), sizeof(*pver)), GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
 
@@ -443,7 +441,6 @@ static int cros_ec_get_host_command_version_mask(struct cros_ec_device *ec_dev,
 	}
 
 	kfree(msg);
-
 	return ret;
 }
 
@@ -488,21 +485,16 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
 		return -ENOMEM;
 
 	/* Probe if MKBP event is supported */
-	ret = cros_ec_get_host_command_version_mask(ec_dev,
-						    EC_CMD_GET_NEXT_EVENT,
-						    &ver_mask);
-	if (ret < 0 || ver_mask == 0)
+	ret = get_host_command_version_mask(ec_dev, EC_CMD_GET_NEXT_EVENT, &ver_mask);
+	if (ret < 0 || ver_mask == 0) {
 		ec_dev->mkbp_event_supported = 0;
-	else
+	} else {
 		ec_dev->mkbp_event_supported = fls(ver_mask);
-
-	dev_dbg(ec_dev->dev, "MKBP support version %u\n",
-		ec_dev->mkbp_event_supported - 1);
+		dev_dbg(ec_dev->dev, "MKBP support version %u\n", ec_dev->mkbp_event_supported - 1);
+	}
 
 	/* Probe if host sleep v1 is supported for S0ix failure detection. */
-	ret = cros_ec_get_host_command_version_mask(ec_dev,
-						    EC_CMD_HOST_SLEEP_EVENT,
-						    &ver_mask);
+	ret = get_host_command_version_mask(ec_dev, EC_CMD_HOST_SLEEP_EVENT, &ver_mask);
 	ec_dev->host_sleep_v1 = (ret >= 0 && (ver_mask & EC_VER_MASK(1)));
 
 	/* Get host event wake mask. */
diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
index 22f9322787f4..e2c369765612 100644
--- a/drivers/platform/chrome/cros_ec_proto_test.c
+++ b/drivers/platform/chrome/cros_ec_proto_test.c
@@ -217,7 +217,7 @@ static void cros_ec_proto_test_query_all_normal(struct kunit *test)
 		data->max_request_packet_size = 0xbf;
 	}
 
-	/* For cros_ec_get_host_command_version_mask() for MKBP. */
+	/* For get_host_command_version_mask() for MKBP. */
 	{
 		struct ec_response_get_cmd_versions *data;
 
@@ -228,7 +228,7 @@ static void cros_ec_proto_test_query_all_normal(struct kunit *test)
 		data->version_mask = BIT(6) | BIT(5);
 	}
 
-	/* For cros_ec_get_host_command_version_mask() for host sleep v1. */
+	/* For get_host_command_version_mask() for host sleep v1. */
 	{
 		struct ec_response_get_cmd_versions *data;
 
@@ -288,7 +288,7 @@ static void cros_ec_proto_test_query_all_normal(struct kunit *test)
 		KUNIT_EXPECT_EQ(test, ec_dev->max_passthru, 0xbf - sizeof(struct ec_host_request));
 	}
 
-	/* For cros_ec_get_host_command_version_mask() for MKBP. */
+	/* For get_host_command_version_mask() for MKBP. */
 	{
 		struct ec_params_get_cmd_versions *data;
 
@@ -307,7 +307,7 @@ static void cros_ec_proto_test_query_all_normal(struct kunit *test)
 		KUNIT_EXPECT_EQ(test, ec_dev->mkbp_event_supported, 7);
 	}
 
-	/* For cros_ec_get_host_command_version_mask() for host sleep v1. */
+	/* For get_host_command_version_mask() for host sleep v1. */
 	{
 		struct ec_params_get_cmd_versions *data;
 
@@ -502,7 +502,7 @@ static void cros_ec_proto_test_query_all_no_mkbp(struct kunit *test)
 		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
 	}
 
-	/* For cros_ec_get_host_command_version_mask() for MKBP. */
+	/* For get_host_command_version_mask() for MKBP. */
 	{
 		struct ec_response_get_cmd_versions *data;
 
@@ -543,7 +543,7 @@ static void cros_ec_proto_test_query_all_no_mkbp(struct kunit *test)
 		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
 	}
 
-	/* For cros_ec_get_host_command_version_mask() for MKBP. */
+	/* For get_host_command_version_mask() for MKBP. */
 	{
 		struct ec_params_get_cmd_versions *data;
 
@@ -596,7 +596,7 @@ static void cros_ec_proto_test_query_all_no_mkbp2(struct kunit *test)
 		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
 	}
 
-	/* For cros_ec_get_host_command_version_mask() for MKBP. */
+	/* For get_host_command_version_mask() for MKBP. */
 	{
 		mock = cros_kunit_ec_xfer_mock_add(test, 0);
 		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
@@ -632,7 +632,7 @@ static void cros_ec_proto_test_query_all_no_mkbp2(struct kunit *test)
 		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
 	}
 
-	/* For cros_ec_get_host_command_version_mask() for MKBP. */
+	/* For get_host_command_version_mask() for MKBP. */
 	{
 		struct ec_params_get_cmd_versions *data;
 
@@ -685,14 +685,14 @@ static void cros_ec_proto_test_query_all_no_host_sleep(struct kunit *test)
 		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
 	}
 
-	/* For cros_ec_get_host_command_version_mask() for MKBP. */
+	/* For get_host_command_version_mask() for MKBP. */
 	{
 		mock = cros_kunit_ec_xfer_mock_add(test,
 						   sizeof(struct ec_response_get_cmd_versions));
 		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
 	}
 
-	/* For cros_ec_get_host_command_version_mask() for host sleep v1. */
+	/* For get_host_command_version_mask() for host sleep v1. */
 	{
 		struct ec_response_get_cmd_versions *data;
 
@@ -733,7 +733,7 @@ static void cros_ec_proto_test_query_all_no_host_sleep(struct kunit *test)
 		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
 	}
 
-	/* For cros_ec_get_host_command_version_mask() for MKBP. */
+	/* For get_host_command_version_mask() for MKBP. */
 	{
 		mock = cros_kunit_ec_xfer_mock_next();
 		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
@@ -745,7 +745,7 @@ static void cros_ec_proto_test_query_all_no_host_sleep(struct kunit *test)
 		KUNIT_EXPECT_EQ(test, mock->msg.outsize, sizeof(struct ec_params_get_cmd_versions));
 	}
 
-	/* For cros_ec_get_host_command_version_mask() for host sleep v1. */
+	/* For get_host_command_version_mask() for host sleep v1. */
 	{
 		mock = cros_kunit_ec_xfer_mock_next();
 		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
@@ -793,14 +793,14 @@ static void cros_ec_proto_test_query_all_default_wake_mask(struct kunit *test)
 		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
 	}
 
-	/* For cros_ec_get_host_command_version_mask() for MKBP. */
+	/* For get_host_command_version_mask() for MKBP. */
 	{
 		mock = cros_kunit_ec_xfer_mock_add(test,
 						   sizeof(struct ec_response_get_cmd_versions));
 		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
 	}
 
-	/* For cros_ec_get_host_command_version_mask() for host sleep v1. */
+	/* For get_host_command_version_mask() for host sleep v1. */
 	{
 		mock = cros_kunit_ec_xfer_mock_add(test,
 						   sizeof(struct ec_response_get_cmd_versions));
@@ -844,7 +844,7 @@ static void cros_ec_proto_test_query_all_default_wake_mask(struct kunit *test)
 		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
 	}
 
-	/* For cros_ec_get_host_command_version_mask() for MKBP. */
+	/* For get_host_command_version_mask() for MKBP. */
 	{
 		mock = cros_kunit_ec_xfer_mock_next();
 		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
@@ -856,7 +856,7 @@ static void cros_ec_proto_test_query_all_default_wake_mask(struct kunit *test)
 		KUNIT_EXPECT_EQ(test, mock->msg.outsize, sizeof(struct ec_params_get_cmd_versions));
 	}
 
-	/* For cros_ec_get_host_command_version_mask() for host sleep v1. */
+	/* For get_host_command_version_mask() for host sleep v1. */
 	{
 		mock = cros_kunit_ec_xfer_mock_next();
 		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
-- 
2.36.1.255.ge46751e96f-goog

