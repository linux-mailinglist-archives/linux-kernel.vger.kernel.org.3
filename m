Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7550B54C10C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 07:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345126AbiFOFNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 01:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237733AbiFOFNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 01:13:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC1026AED
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 22:13:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46FBEB81BF1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D40DC3411B;
        Wed, 15 Jun 2022 05:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655269984;
        bh=78h/xWejmUYXqnLJGctnzKO4vmtanAQy4FkFlDYdQXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pn5PpbZi4XEf/wyObY4kB4cFox427EPVYZYDHUKgtUbgUB0+4Ql4qHwGqqE7WIxLK
         D1aTYve/bijW8MA27yC5JkkDqDC8A3gDm1U0ZqZZc1aNd7SHh3FPlfOr9otypfKoxo
         HhZ7sRNUyLYajtLhI24YiUCFnJqW7Cho+PgVFjS61bX3uRWecwHU0Wf/CramhwV5wN
         cYamb0C9UO8A4IspFmwX6GW/WmDPLJukZ7/Hd4uz2sS9T/fN0ie4SIHOTnA+hFj0FX
         SGMjq02rIGbPivyYshDrywaPlCcQaIBOrH+nhv3RY7h/bWEm94bP3Eevv89IP/JFOU
         0b0ReWw69TgnQ==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] platform/chrome: cros_ec_proto: add "cros_ec_" prefix to send_command()
Date:   Wed, 15 Jun 2022 05:12:38 +0000
Message-Id: <20220615051248.1628156-2-tzungbi@kernel.org>
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

To be neat, add "cros_ec_" prefix to static function send_command().

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_proto.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 6923ea4401e5..b02fd1414e52 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -107,8 +107,7 @@ static int prepare_tx_legacy(struct cros_ec_device *ec_dev,
 	return EC_MSG_TX_PROTO_BYTES + msg->outsize;
 }
 
-static int send_command(struct cros_ec_device *ec_dev,
-			struct cros_ec_command *msg)
+static int cros_ec_send_command(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
 {
 	int ret;
 	int (*xfer_fxn)(struct cros_ec_device *ec, struct cros_ec_command *msg);
@@ -255,7 +254,7 @@ static int cros_ec_get_host_event_wake_mask(struct cros_ec_device *ec_dev, uint3
 	msg->command = EC_CMD_HOST_EVENT_GET_WAKE_MASK;
 	msg->insize = sizeof(*r);
 
-	ret = send_command(ec_dev, msg);
+	ret = cros_ec_send_command(ec_dev, msg);
 	if (ret < 0)
 		goto exit;
 
@@ -295,7 +294,7 @@ static int cros_ec_get_proto_info(struct cros_ec_device *ec_dev, int devidx)
 	msg->command = EC_CMD_PASSTHRU_OFFSET(devidx) | EC_CMD_GET_PROTOCOL_INFO;
 	msg->insize = sizeof(*info);
 
-	ret = send_command(ec_dev, msg);
+	ret = cros_ec_send_command(ec_dev, msg);
 	/*
 	 * Send command once again when timeout occurred.
 	 * Fingerprint MCU (FPMCU) is restarted during system boot which
@@ -304,7 +303,7 @@ static int cros_ec_get_proto_info(struct cros_ec_device *ec_dev, int devidx)
 	 * attempt because we waited at least EC_MSG_DEADLINE_MS.
 	 */
 	if (ret == -ETIMEDOUT)
-		ret = send_command(ec_dev, msg);
+		ret = cros_ec_send_command(ec_dev, msg);
 
 	if (ret < 0) {
 		dev_dbg(ec_dev->dev,
@@ -376,7 +375,7 @@ static int cros_ec_get_proto_info_legacy(struct cros_ec_device *ec_dev)
 	params = (struct ec_params_hello *)msg->data;
 	params->in_data = 0xa0b0c0d0;
 
-	ret = send_command(ec_dev, msg);
+	ret = cros_ec_send_command(ec_dev, msg);
 	if (ret < 0) {
 		dev_dbg(ec_dev->dev, "EC failed to respond to v2 hello: %d\n", ret);
 		goto exit;
@@ -453,7 +452,7 @@ static int cros_ec_get_host_command_version_mask(struct cros_ec_device *ec_dev,
 	pver = (struct ec_params_get_cmd_versions *)msg->data;
 	pver->cmd = cmd;
 
-	ret = send_command(ec_dev, msg);
+	ret = cros_ec_send_command(ec_dev, msg);
 	if (ret < 0)
 		goto exit;
 
@@ -634,7 +633,7 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
 		}
 	}
 
-	ret = send_command(ec_dev, msg);
+	ret = cros_ec_send_command(ec_dev, msg);
 	mutex_unlock(&ec_dev->lock);
 
 	return ret;
-- 
2.36.1.476.g0c4daa206d-goog

