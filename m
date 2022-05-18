Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E5352B62E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbiERJSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbiERJSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:18:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8997A1EAF2
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:18:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2408D616EE
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 09:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E84C34115;
        Wed, 18 May 2022 09:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652865514;
        bh=ZxnBh42w0CZG6u7DBza0nWMtyG7KckyK4dV0afsK/lQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ivDt7d4TkiBOCd+5XzY5wywDi/BieFMTpUoVSEHz46Ht56CY+dKB/o6IZTJcntjmv
         V2PX+x8noU7EEawRqsKOu2vqBnfdv+Gr8Wr8z/QapNNycD36nFyTIABkTCneOnlLGm
         3KGJ+FaycOeRgBQo1vVVY/u4edECP104UTsCpD05yjKOkqQCFoggcDt++dMM9zkA5i
         7KUe9zYwIp4ltz63dGjoGUvm2ozSpmvJB8KSMdaqfRcBvJQDcX7S18iSL8LAED6XBm
         UpHS/890yYqXouQdIbmiskdMzPVj8pPBxwbUKrPKRDTvU08yg0oNVMF28KREoCBruZ
         ThRwnsYWJA/Ew==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        tzungbi@kernel.org, dianders@chromium.org
Subject: [PATCH 2/4] platform/chrome: cros_ec_proto: factor legacy out from cros_ec_prepare_tx()
Date:   Wed, 18 May 2022 17:18:12 +0800
Message-Id: <20220518091814.2028579-3-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
In-Reply-To: <20220518091814.2028579-1-tzungbi@kernel.org>
References: <20220518091814.2028579-1-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cros_ec_prepare_tx() mixed the code for both versions.  To be neat and to
make it clear, factor the legacy part out as a separate function, rename
the function, and update the comments.

Specifically,
- prepare_tx(), for current protocol version (i.e. 3).
- prepare_tx_legacy(), for protocol version <= 2.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_proto.c | 51 ++++++++++++++-----------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index ff767dccdf0f..01ab58b3269b 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -52,8 +52,8 @@ static int cros_ec_map_error(uint32_t result)
 	return ret;
 }
 
-static int prepare_packet(struct cros_ec_device *ec_dev,
-			  struct cros_ec_command *msg)
+static int prepare_tx(struct cros_ec_device *ec_dev,
+		      struct cros_ec_command *msg)
 {
 	struct ec_host_request *request;
 	u8 *out;
@@ -85,6 +85,28 @@ static int prepare_packet(struct cros_ec_device *ec_dev,
 	return sizeof(*request) + msg->outsize;
 }
 
+static int prepare_tx_legacy(struct cros_ec_device *ec_dev,
+			     struct cros_ec_command *msg)
+{
+	u8 *out;
+	u8 csum;
+	int i;
+
+	if (msg->outsize > EC_PROTO2_MAX_PARAM_SIZE)
+		return -EINVAL;
+
+	out = ec_dev->dout;
+	out[0] = EC_CMD_VERSION0 + msg->version;
+	out[1] = msg->command;
+	out[2] = msg->outsize;
+	csum = out[0] + out[1] + out[2];
+	for (i = 0; i < msg->outsize; i++)
+		csum += out[EC_MSG_TX_HEADER_BYTES + i] = msg->data[i];
+	out[EC_MSG_TX_HEADER_BYTES + msg->outsize] = csum;
+
+	return EC_MSG_TX_PROTO_BYTES + msg->outsize;
+}
+
 static int send_command(struct cros_ec_device *ec_dev,
 			struct cros_ec_command *msg)
 {
@@ -161,35 +183,18 @@ static int send_command(struct cros_ec_device *ec_dev,
  * @ec_dev: Device to register.
  * @msg: Message to write.
  *
- * This is intended to be used by all ChromeOS EC drivers, but at present
- * only SPI uses it. Once LPC uses the same protocol it can start using it.
- * I2C could use it now, with a refactor of the existing code.
+ * This is used by all ChromeOS EC drivers to prepare the outgoing message
+ * according to different protocol versions.
  *
  * Return: number of prepared bytes on success or negative error code.
  */
 int cros_ec_prepare_tx(struct cros_ec_device *ec_dev,
 		       struct cros_ec_command *msg)
 {
-	u8 *out;
-	u8 csum;
-	int i;
-
 	if (ec_dev->proto_version > 2)
-		return prepare_packet(ec_dev, msg);
-
-	if (msg->outsize > EC_PROTO2_MAX_PARAM_SIZE)
-		return -EINVAL;
-
-	out = ec_dev->dout;
-	out[0] = EC_CMD_VERSION0 + msg->version;
-	out[1] = msg->command;
-	out[2] = msg->outsize;
-	csum = out[0] + out[1] + out[2];
-	for (i = 0; i < msg->outsize; i++)
-		csum += out[EC_MSG_TX_HEADER_BYTES + i] = msg->data[i];
-	out[EC_MSG_TX_HEADER_BYTES + msg->outsize] = csum;
+		return prepare_tx(ec_dev, msg);
 
-	return EC_MSG_TX_PROTO_BYTES + msg->outsize;
+	return prepare_tx_legacy(ec_dev, msg);
 }
 EXPORT_SYMBOL(cros_ec_prepare_tx);
 
-- 
2.36.0.550.gb090851708-goog

