Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4603355DBAE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343835AbiF1Ct4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 22:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343779AbiF1Ctn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 22:49:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA68110BC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 19:49:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A462DB819BA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F4BC341CB;
        Tue, 28 Jun 2022 02:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656384578;
        bh=FHaTmUgiAOBou3jTjjclaGK3VUK22B3XVtClzeJg9Fc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gQxhQAG2zoXESXXAZf8lmkIYik3geUk7Eho3n/9JA1rZAGcOd2w4JIekhfKP7wlnT
         ZHn5LiEq2lxMQ/ZsFlWOyolx9UsQ336GHsMsVIXDG6RN6LhzDj3x1ftz7zLVQhh6Ei
         AS6McjGEkOPAcZ4J28f4gK0weU4RM/U1NZw6dY3nLyveBkj7I49lVA4r+aO6XSXkX8
         Farv6DgXisjjiXJr3ZcDTQ/ouviidENW0S6UlFpYJvIkHXMqAWeYrowBSCQgxKcWrM
         AhVq/lbzvfCzabrj423SqQbhbCUcA9jWlRiHMotu8XcCCH8u4aivG9C+O2hj82Z1tP
         DuU51SM5bqrPw==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 05/11] platform/chrome: cros_ec_proto: separate cros_ec_wait_until_complete()
Date:   Tue, 28 Jun 2022 02:49:07 +0000
Message-Id: <20220628024913.1755292-6-tzungbi@kernel.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220628024913.1755292-1-tzungbi@kernel.org>
References: <20220628024913.1755292-1-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EC returns EC_RES_IN_PROGRESS if the host command needs more time to
complete.  Whenever receives the return code, cros_ec_send_command()
sends EC_CMD_GET_COMMS_STATUS to query the command status.

Separate cros_ec_wait_until_complete() from cros_ec_send_command().
It sends EC_CMD_GET_COMMS_STATUS and waits until the previous command
was completed, or encountered error, or timed out.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_proto.c | 75 ++++++++++++-------------
 1 file changed, 36 insertions(+), 39 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 0cec013be3d3..466ecb063bd6 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -134,53 +134,50 @@ static int cros_ec_xfer_command(struct cros_ec_device *ec_dev, struct cros_ec_co
 	return ret;
 }
 
-static int cros_ec_send_command(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
+static int cros_ec_wait_until_complete(struct cros_ec_device *ec_dev, uint32_t *result)
 {
-	int ret = cros_ec_xfer_command(ec_dev, msg);
+	struct cros_ec_command *msg;
+	struct ec_response_get_comms_status *status;
+	int ret = 0, i;
+
+	msg = kzalloc(sizeof(*msg) + sizeof(*status), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
 
-	if (msg->result == EC_RES_IN_PROGRESS) {
-		int i;
-		struct cros_ec_command *status_msg;
-		struct ec_response_get_comms_status *status;
+	msg->command = EC_CMD_GET_COMMS_STATUS;
+	msg->insize = sizeof(*status);
 
-		status_msg = kmalloc(sizeof(*status_msg) + sizeof(*status),
-				     GFP_KERNEL);
-		if (!status_msg)
-			return -ENOMEM;
+	status = (struct ec_response_get_comms_status *)msg->data;
 
-		status_msg->version = 0;
-		status_msg->command = EC_CMD_GET_COMMS_STATUS;
-		status_msg->insize = sizeof(*status);
-		status_msg->outsize = 0;
+	/* Query the EC's status until it's no longer busy or we encounter an error. */
+	for (i = 0; i < EC_COMMAND_RETRIES; ++i) {
+		usleep_range(10000, 11000);
 
-		/*
-		 * Query the EC's status until it's no longer busy or
-		 * we encounter an error.
-		 */
-		for (i = 0; i < EC_COMMAND_RETRIES; i++) {
-			usleep_range(10000, 11000);
-
-			trace_cros_ec_request_start(status_msg);
-			ret = (*xfer_fxn)(ec_dev, status_msg);
-			trace_cros_ec_request_done(status_msg, ret);
-			if (ret == -EAGAIN)
-				continue;
-			if (ret < 0)
-				break;
-
-			msg->result = status_msg->result;
-			if (status_msg->result != EC_RES_SUCCESS)
-				break;
-
-			status = (struct ec_response_get_comms_status *)
-				 status_msg->data;
-			if (!(status->flags & EC_COMMS_STATUS_PROCESSING))
-				break;
-		}
+		ret = cros_ec_xfer_command(ec_dev, msg);
+		if (ret == -EAGAIN)
+			continue;
+		if (ret < 0)
+			break;
+
+		*result = msg->result;
+		if (msg->result != EC_RES_SUCCESS)
+			break;
 
-		kfree(status_msg);
+		if (!(status->flags & EC_COMMS_STATUS_PROCESSING))
+			break;
 	}
 
+	kfree(msg);
+	return ret;
+}
+
+static int cros_ec_send_command(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
+{
+	int ret = cros_ec_xfer_command(ec_dev, msg);
+
+	if (msg->result == EC_RES_IN_PROGRESS)
+		ret = cros_ec_wait_until_complete(ec_dev, &msg->result);
+
 	return ret;
 }
 
-- 
2.37.0.rc0.161.g10f37bed90-goog

