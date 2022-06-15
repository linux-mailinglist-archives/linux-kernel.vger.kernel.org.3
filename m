Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D4B54C113
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 07:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346033AbiFOFNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 01:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344650AbiFOFNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 01:13:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA0525EA9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 22:13:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C9CDB81BFB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065DBC3411F;
        Wed, 15 Jun 2022 05:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655269989;
        bh=6ItXxr6KZikq3OhN5ZSu919u0fACp3SvOrk9yJh74MM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p/Rvr6IR2IPAJA5zET142LmUmNMUvwbnc4EmpAY+aFT5a2fibq7A64h6g/9VcOswK
         SDEOv2pPH9XfBybKBpA/GNT0tW9smc+tfwzCRkCgKLaesrMIPfiVLjAp/lYW36S/t1
         doWGQuCfvF4hxIVmazElk87Obn+1BZMxQ5sSOsvo4K8KM4IuKGrSM0agRTtTXccTx6
         6d2CN9e0wrHLS0M/UBNvZDskXxRkUF78bURVE9w2YcLokNEKgE0/j7QGR7m2SScs91
         ZlPQuhskbI7r6Q6OoX5vvjeTX4sXVNOix/x6IZIFr/C/KkaGa7XdrJyI50ERZg1KG/
         NvxZWx9djnxVA==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] platform/chrome: cros_ec_proto: separate cros_ec_wait_until_complete()
Date:   Wed, 15 Jun 2022 05:12:42 +0000
Message-Id: <20220615051248.1628156-6-tzungbi@kernel.org>
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
2.36.1.476.g0c4daa206d-goog

