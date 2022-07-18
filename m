Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B19577A3F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 07:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbiGRFKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 01:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbiGRFKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 01:10:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40700EE0A
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 22:10:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B80B8B80F03
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B18AC341CE;
        Mon, 18 Jul 2022 05:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658121009;
        bh=fkd2e0BODvoo+pEM/gTsjyNgH9JMUx2Ptnib31kv7Xw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ey1hG32SqY4uQjvaRSjPGz1NNHTyCtqEdsl/8I2Xaq+DSmmCKOOZQHVD+aEqAwrHY
         uKx/iQdbUH38tlhHan+zYxgp/6TT9ZtmwALNVPLrFJq+zQTKq9Oq8QJCm1vQVjcqFN
         FjUx36he4LLgfDOhT6MwMp28Aq4dONQ/kHKfQnjn1de05Wwyd8LcXaqLTuQZ+Ox03L
         1aQLCwHLuGSgQWxF8HQcflxv8LnGXDe0NETemUO8vSaVuBmfBrT68nNpjmGK+InTD8
         g1JAcAlSuEvRiUsURO+cD0lqAuRjLB4aNokdumxRYClNpMpaOTn/IHI+6TleLEPF0t
         FfEUsC7WnuGTA==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/10] platform/chrome: cros_ec_proto: add "cros_ec_" prefix to send_command()
Date:   Mon, 18 Jul 2022 05:09:06 +0000
Message-Id: <20220718050914.2267370-3-tzungbi@kernel.org>
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

To be neat, add "cros_ec_" prefix to static function send_command().

Reviewed-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v1:
- Add R-b tag.

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
2.37.0.170.g444d1eabd0-goog

