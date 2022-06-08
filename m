Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3092542EBC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 13:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237810AbiFHLIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 07:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236969AbiFHLHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 07:07:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C9B1B177A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 04:07:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80D51615AC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 11:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4C7C34116;
        Wed,  8 Jun 2022 11:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654686471;
        bh=I9AvwmF7pLsogiDz8OU4bTZ0HnX2hq+Ls0iMslLb8wA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XOKywZOiBzF3mwEYVI/PvM79Jsi2eiy38SGMCoreLR4gDWWY+1pCcOUog7iXGjYdB
         4c965OwNObFpDq6xwa5G1sPrAfziEBg2bQxYVVE+4yQmVkauIjDqoElA4R5mheHxE4
         E7Af/KQmS1CqvUbRHK3wh/kmQ3ZJ08zWdyBuBY8B2/ecjdkLjs0ajNqA1SGCwVjxrs
         chfusFOFTSyHNPd8v0NYhWBMWfry2utaDYwR931bY4/Fok2MNbSvPfDiKgJP+jTdRL
         N3cf+Zsuu+C6VCEEeUgL8dxtK1mhOJRe/9CO0ta28jZ6VyOSNKe4CdOXkczkxA4nUt
         nfzsK8kQDhBsQ==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/23] platform/chrome: use macros for passthru indexes
Date:   Wed,  8 Jun 2022 11:07:14 +0000
Message-Id: <20220608110734.2928245-4-tzungbi@kernel.org>
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

Move passthru indexes for EC and PD devices to common header.  Also use
them instead of literal constants.

Reviewed-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
No change from v2.

Changes from v1:
- Add R-b tag.

 drivers/platform/chrome/cros_ec.c            |  3 ---
 drivers/platform/chrome/cros_ec_proto.c      |  6 +++---
 drivers/platform/chrome/cros_ec_proto_test.c | 15 ++++++++++-----
 drivers/platform/chrome/cros_ec_trace.h      |  8 ++++----
 include/linux/platform_data/cros_ec_proto.h  |  3 +++
 5 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index b3e94cdf7d1a..e51a3f2176c7 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -19,9 +19,6 @@
 
 #include "cros_ec.h"
 
-#define CROS_EC_DEV_EC_INDEX 0
-#define CROS_EC_DEV_PD_INDEX 1
-
 static struct cros_ec_platform ec_p = {
 	.ec_name = CROS_EC_DEV_NAME,
 	.cmd_offset = EC_CMD_PASSTHRU_OFFSET(CROS_EC_DEV_EC_INDEX),
diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 13ced9d2dd71..65191af5139c 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -433,7 +433,7 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
 
 	/* First try sending with proto v3. */
 	ec_dev->proto_version = 3;
-	ret = cros_ec_host_command_proto_query(ec_dev, 0, proto_msg);
+	ret = cros_ec_host_command_proto_query(ec_dev, CROS_EC_DEV_EC_INDEX, proto_msg);
 
 	if (ret == 0) {
 		proto_info = (struct ec_response_get_protocol_info *)
@@ -459,7 +459,7 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
 		/*
 		 * Check for PD
 		 */
-		ret = cros_ec_host_command_proto_query(ec_dev, 1, proto_msg);
+		ret = cros_ec_host_command_proto_query(ec_dev, CROS_EC_DEV_PD_INDEX, proto_msg);
 
 		if (ret) {
 			dev_dbg(ec_dev->dev, "no PD chip found: %d\n", ret);
@@ -609,7 +609,7 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
 		msg->insize = ec_dev->max_response;
 	}
 
-	if (msg->command < EC_CMD_PASSTHRU_OFFSET(1)) {
+	if (msg->command < EC_CMD_PASSTHRU_OFFSET(CROS_EC_DEV_PD_INDEX)) {
 		if (msg->outsize > ec_dev->max_request) {
 			dev_err(ec_dev->dev,
 				"request of size %u is too big (max: %u)\n",
diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
index 675306c16d47..f8dbfb0d8dc8 100644
--- a/drivers/platform/chrome/cros_ec_proto_test.c
+++ b/drivers/platform/chrome/cros_ec_proto_test.c
@@ -281,7 +281,8 @@ static void cros_ec_proto_test_query_all_normal(struct kunit *test)
 
 		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
 		KUNIT_EXPECT_EQ(test, mock->msg.command,
-				EC_CMD_PASSTHRU_OFFSET(1) | EC_CMD_GET_PROTOCOL_INFO);
+				EC_CMD_PASSTHRU_OFFSET(CROS_EC_DEV_PD_INDEX) |
+				EC_CMD_GET_PROTOCOL_INFO);
 		KUNIT_EXPECT_EQ(test, mock->msg.insize,
 				sizeof(struct ec_response_get_protocol_info));
 		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
@@ -396,7 +397,8 @@ static void cros_ec_proto_test_query_all_no_pd_return_error(struct kunit *test)
 
 		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
 		KUNIT_EXPECT_EQ(test, mock->msg.command,
-				EC_CMD_PASSTHRU_OFFSET(1) | EC_CMD_GET_PROTOCOL_INFO);
+				EC_CMD_PASSTHRU_OFFSET(CROS_EC_DEV_PD_INDEX) |
+				EC_CMD_GET_PROTOCOL_INFO);
 		KUNIT_EXPECT_EQ(test, mock->msg.insize,
 				sizeof(struct ec_response_get_protocol_info));
 		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
@@ -685,7 +687,8 @@ static void cros_ec_proto_test_query_all_no_mkbp(struct kunit *test)
 
 		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
 		KUNIT_EXPECT_EQ(test, mock->msg.command,
-				EC_CMD_PASSTHRU_OFFSET(1) | EC_CMD_GET_PROTOCOL_INFO);
+				EC_CMD_PASSTHRU_OFFSET(CROS_EC_DEV_PD_INDEX) |
+				EC_CMD_GET_PROTOCOL_INFO);
 		KUNIT_EXPECT_EQ(test, mock->msg.insize,
 				sizeof(struct ec_response_get_protocol_info));
 		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
@@ -783,7 +786,8 @@ static void cros_ec_proto_test_query_all_no_host_sleep(struct kunit *test)
 
 		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
 		KUNIT_EXPECT_EQ(test, mock->msg.command,
-				EC_CMD_PASSTHRU_OFFSET(1) | EC_CMD_GET_PROTOCOL_INFO);
+				EC_CMD_PASSTHRU_OFFSET(CROS_EC_DEV_PD_INDEX) |
+				EC_CMD_GET_PROTOCOL_INFO);
 		KUNIT_EXPECT_EQ(test, mock->msg.insize,
 				sizeof(struct ec_response_get_protocol_info));
 		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
@@ -889,7 +893,8 @@ static void cros_ec_proto_test_query_all_default_wake_mask_return_error(struct k
 
 		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
 		KUNIT_EXPECT_EQ(test, mock->msg.command,
-				EC_CMD_PASSTHRU_OFFSET(1) | EC_CMD_GET_PROTOCOL_INFO);
+				EC_CMD_PASSTHRU_OFFSET(CROS_EC_DEV_PD_INDEX) |
+				EC_CMD_GET_PROTOCOL_INFO);
 		KUNIT_EXPECT_EQ(test, mock->msg.insize,
 				sizeof(struct ec_response_get_protocol_info));
 		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
diff --git a/drivers/platform/chrome/cros_ec_trace.h b/drivers/platform/chrome/cros_ec_trace.h
index 9bb5cd2c98b8..d7e407de88df 100644
--- a/drivers/platform/chrome/cros_ec_trace.h
+++ b/drivers/platform/chrome/cros_ec_trace.h
@@ -30,8 +30,8 @@ TRACE_EVENT(cros_ec_request_start,
 	),
 	TP_fast_assign(
 		__entry->version = cmd->version;
-		__entry->offset = cmd->command / EC_CMD_PASSTHRU_OFFSET(1);
-		__entry->command = cmd->command % EC_CMD_PASSTHRU_OFFSET(1);
+		__entry->offset = cmd->command / EC_CMD_PASSTHRU_OFFSET(CROS_EC_DEV_PD_INDEX);
+		__entry->command = cmd->command % EC_CMD_PASSTHRU_OFFSET(CROS_EC_DEV_PD_INDEX);
 		__entry->outsize = cmd->outsize;
 		__entry->insize = cmd->insize;
 	),
@@ -55,8 +55,8 @@ TRACE_EVENT(cros_ec_request_done,
 	),
 	TP_fast_assign(
 		__entry->version = cmd->version;
-		__entry->offset = cmd->command / EC_CMD_PASSTHRU_OFFSET(1);
-		__entry->command = cmd->command % EC_CMD_PASSTHRU_OFFSET(1);
+		__entry->offset = cmd->command / EC_CMD_PASSTHRU_OFFSET(CROS_EC_DEV_PD_INDEX);
+		__entry->command = cmd->command % EC_CMD_PASSTHRU_OFFSET(CROS_EC_DEV_PD_INDEX);
 		__entry->outsize = cmd->outsize;
 		__entry->insize = cmd->insize;
 		__entry->result = cmd->result;
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 138fd912c808..6475a8066f00 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -21,6 +21,9 @@
 #define CROS_EC_DEV_SCP_NAME	"cros_scp"
 #define CROS_EC_DEV_TP_NAME	"cros_tp"
 
+#define CROS_EC_DEV_EC_INDEX 0
+#define CROS_EC_DEV_PD_INDEX 1
+
 /*
  * The EC is unresponsive for a time after a reboot command.  Add a
  * simple delay to make sure that the bus stays locked.
-- 
2.36.1.255.ge46751e96f-goog

