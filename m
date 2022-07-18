Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96941577A41
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 07:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbiGRFKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 01:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbiGRFKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 01:10:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D389F58C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 22:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10A206119E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE1AC341CA;
        Mon, 18 Jul 2022 05:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658121014;
        bh=O6BmjsqSJ+Huo3HjurXfnhr+k1oxAIxru4gq3B0ygJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HlnGHh1dyoOsNJ8jabgwfEh5st3eqslRLD8gYT+5/gL0SUlD1/EdKaNNyGENcwsT2
         iaIH8QXPRuz+38hfjVcjHTKdf5kcHzeaDc43brPoyE84v7FzCl84Nbv5zxj1Idm16b
         n/oqw8vhptjXEzgIkDX169v5nfdPeDyj2/9yBsqZ24d2l5cXXBwp+0mFpDdHo+codl
         iu32AxaeAqIds9sn6cAfGz4vOw84t0tOUQQswp0Ooc1wgimwLj9VwT51vchdamrxew
         h02z3FvDT+v3QuR89CiQre5tyFxLwO1Gw6AKdhafK/Xy5rvf8gYhLroAwu/Vt/N7uy
         SS1H/Q/UU/5uw==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/10] platform/chrome: cros_ec_proto: separate cros_ec_wait_until_complete()
Date:   Mon, 18 Jul 2022 05:09:10 +0000
Message-Id: <20220718050914.2267370-7-tzungbi@kernel.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220718050914.2267370-1-tzungbi@kernel.org>
References: <20220718050914.2267370-1-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Changes from v1:
- Allocate buffer in cros_ec_wait_until_complete() statically.
- Use `return ret` instead of `break` to make the intent explicit.

 drivers/platform/chrome/cros_ec_proto.c | 74 ++++++++++++-------------
 1 file changed, 35 insertions(+), 39 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 0cec013be3d3..a6ad7f7956e6 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -134,56 +134,52 @@ static int cros_ec_xfer_command(struct cros_ec_device *ec_dev, struct cros_ec_co
 	return ret;
 }
 
-static int cros_ec_send_command(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
+static int cros_ec_wait_until_complete(struct cros_ec_device *ec_dev, uint32_t *result)
 {
-	int ret = cros_ec_xfer_command(ec_dev, msg);
+	struct {
+		struct cros_ec_command msg;
+		struct ec_response_get_comms_status status;
+	} __packed buf;
+	struct cros_ec_command *msg = &buf.msg;
+	struct ec_response_get_comms_status *status = &buf.status;
+	int ret = 0, i;
 
-	if (msg->result == EC_RES_IN_PROGRESS) {
-		int i;
-		struct cros_ec_command *status_msg;
-		struct ec_response_get_comms_status *status;
+	msg->version = 0;
+	msg->command = EC_CMD_GET_COMMS_STATUS;
+	msg->insize = sizeof(*status);
+	msg->outsize = 0;
 
-		status_msg = kmalloc(sizeof(*status_msg) + sizeof(*status),
-				     GFP_KERNEL);
-		if (!status_msg)
-			return -ENOMEM;
+	/* Query the EC's status until it's no longer busy or we encounter an error. */
+	for (i = 0; i < EC_COMMAND_RETRIES; ++i) {
+		usleep_range(10000, 11000);
 
-		status_msg->version = 0;
-		status_msg->command = EC_CMD_GET_COMMS_STATUS;
-		status_msg->insize = sizeof(*status);
-		status_msg->outsize = 0;
+		ret = cros_ec_xfer_command(ec_dev, msg);
+		if (ret == -EAGAIN)
+			continue;
+		if (ret < 0)
+			return ret;
 
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
+		*result = msg->result;
+		if (msg->result != EC_RES_SUCCESS)
+			return ret;
 
-		kfree(status_msg);
+		if (!(status->flags & EC_COMMS_STATUS_PROCESSING))
+			return ret;
 	}
 
 	return ret;
 }
 
+static int cros_ec_send_command(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
+{
+	int ret = cros_ec_xfer_command(ec_dev, msg);
+
+	if (msg->result == EC_RES_IN_PROGRESS)
+		ret = cros_ec_wait_until_complete(ec_dev, &msg->result);
+
+	return ret;
+}
+
 /**
  * cros_ec_prepare_tx() - Prepare an outgoing message in the output buffer.
  * @ec_dev: Device to register.
-- 
2.37.0.170.g444d1eabd0-goog

