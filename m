Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7076055E2C4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343776AbiF1Ctm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 22:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245557AbiF1Ctj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 22:49:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30490F29
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 19:49:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2ED5612C8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:49:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7D9C341CC;
        Tue, 28 Jun 2022 02:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656384577;
        bh=/mCONiNi6+rv5jRQfmF6KXwkU9b+H5v0JzqV3x5Sslg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jo4S5RZzxr1vph9vG7CefP5Cj1E24kKfkP/fvyN6K6toynuuXtPCubkrkEwjNmuDu
         rhZgGvxnTL0E7TFOkF9DfB/bB/ZyBEfmBN20JuoPy3p2YUr/JtCSLvBoiWG7lYNxU5
         CSGSck6NVcCODFpp5XIUeTVuqWdwsdE4EzY/R99j0D7r2oQg3pRj6UytmMWHh2RNST
         Vwdui8G14JWJgpfAEtr6THk13InceS5ikD85SEDHZM++NeBIniU8LFylfDcwDPNa0T
         UQqeiLfZovKKWpiqGmLx59i0mg9H0pWx2spe0ariAWEPEL2kiMHHsB9C8QLuDhnhHj
         BNoUPWAOaqs/A==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 04/11] platform/chrome: cros_ec_proto: separate cros_ec_xfer_command()
Date:   Tue, 28 Jun 2022 02:49:06 +0000
Message-Id: <20220628024913.1755292-5-tzungbi@kernel.org>
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

cros_ec_send_command() has extra logic to handle EC_RES_IN_PROGRESS.
Separate the command transfer part into cros_ec_xfer_command() so
that other functions can re-use it.

Reviewed-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_proto.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index b02fd1414e52..0cec013be3d3 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -107,7 +107,7 @@ static int prepare_tx_legacy(struct cros_ec_device *ec_dev,
 	return EC_MSG_TX_PROTO_BYTES + msg->outsize;
 }
 
-static int cros_ec_send_command(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
+static int cros_ec_xfer_command(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
 {
 	int ret;
 	int (*xfer_fxn)(struct cros_ec_device *ec, struct cros_ec_command *msg);
@@ -123,14 +123,21 @@ static int cros_ec_send_command(struct cros_ec_device *ec_dev, struct cros_ec_co
 		 * the EC is trying to use protocol v2, on an underlying
 		 * communication mechanism that does not support v2.
 		 */
-		dev_err_once(ec_dev->dev,
-			     "missing EC transfer API, cannot send command\n");
+		dev_err_once(ec_dev->dev, "missing EC transfer API, cannot send command\n");
 		return -EIO;
 	}
 
 	trace_cros_ec_request_start(msg);
 	ret = (*xfer_fxn)(ec_dev, msg);
 	trace_cros_ec_request_done(msg, ret);
+
+	return ret;
+}
+
+static int cros_ec_send_command(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
+{
+	int ret = cros_ec_xfer_command(ec_dev, msg);
+
 	if (msg->result == EC_RES_IN_PROGRESS) {
 		int i;
 		struct cros_ec_command *status_msg;
-- 
2.37.0.rc0.161.g10f37bed90-goog

