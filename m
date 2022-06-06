Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AF953EB70
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239687AbiFFOMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239626AbiFFOMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:12:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EB9397
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:12:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FD69B819F4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 14:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36460C385A9;
        Mon,  6 Jun 2022 14:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654524726;
        bh=9wzElO881O9xQMsS2PzouDUmDxr/gRI/ym+HLKM4i04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G8aqutko2G3cLSMvxqreIQ+zCXlkKwBVJizsxnyBgWQ2Ez52fosChEG7MarC1ksjw
         qP+lxLsXnC0htedZ7Ej4Qiai1R2M2VHLsyq+jNqE5Q3bUYaEHmnR7FjrZYvTabSDZm
         OIdKRjWsOlmam4c+T075RQVaAt64xDD37jazttm1+Hi+SWgorFIE587goAmNoGxBEs
         hPMxu3ygl8E778y6Wy9j87UKkW4XemPUParLGCx/2D8XMQvjKoL8pPKHkftc/IRExU
         IRxGnPYZZ9bR3ep43q+ldjx4eMkHReZpKYjk+YkKsyHwptbxt8pdh0AtZFo44BD7RU
         QFHVJCGFM0+Nw==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] platform/chrome: cros_ec_proto: separate fill_protocol_info_legacy()
Date:   Mon,  6 Jun 2022 14:10:46 +0000
Message-Id: <20220606141051.285823-9-tzungbi@kernel.org>
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

Rename cros_ec_host_command_proto_query_v2() to
fill_protocol_info_legacy() and make it responsible for setting `ec_dev`
fields for EC protocol v2.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_proto.c      | 72 +++++++++-----------
 drivers/platform/chrome/cros_ec_proto_test.c |  4 +-
 2 files changed, 35 insertions(+), 41 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index f57b4dba95b7..abb30a685567 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -344,51 +344,57 @@ static int fill_protocol_info(struct cros_ec_device *ec_dev, int devidx)
 	return ret;
 }
 
-static int cros_ec_host_command_proto_query_v2(struct cros_ec_device *ec_dev)
+static int fill_protocol_info_legacy(struct cros_ec_device *ec_dev)
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
@@ -460,20 +466,8 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
 		fill_protocol_info(ec_dev, CROS_EC_DEV_PD_INDEX);
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
+		ret = fill_protocol_info_legacy(ec_dev);
+		if (ret) {
 			/*
 			 * It's possible for a test to occur too early when
 			 * the EC isn't listening. If this happens, we'll
@@ -481,7 +475,7 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
 			 */
 			ec_dev->proto_version = EC_PROTO_VERSION_UNKNOWN;
 			dev_dbg(ec_dev->dev, "EC query failed: %d\n", ret);
-			goto exit;
+			return ret;
 		}
 	}
 
diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
index cdedbdfc1885..79150bf511fb 100644
--- a/drivers/platform/chrome/cros_ec_proto_test.c
+++ b/drivers/platform/chrome/cros_ec_proto_test.c
@@ -418,7 +418,7 @@ static void cros_ec_proto_test_query_all_legacy_normal(struct kunit *test)
 		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
 	}
 
-	/* For cros_ec_host_command_proto_query_v2(). */
+	/* For fill_protocol_info_legacy(). */
 	{
 		struct ec_response_hello *data;
 
@@ -445,7 +445,7 @@ static void cros_ec_proto_test_query_all_legacy_normal(struct kunit *test)
 		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
 	}
 
-	/* For cros_ec_host_command_proto_query_v2(). */
+	/* For fill_protocol_info_legacy(). */
 	{
 		struct ec_params_hello *data;
 
-- 
2.36.1.255.ge46751e96f-goog

