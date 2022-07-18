Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BE9577A43
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 07:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbiGRFK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 01:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbiGRFKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 01:10:22 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F5CEE0A
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 22:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EF8BFCE0EF3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BC1C341C0;
        Mon, 18 Jul 2022 05:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658121013;
        bh=2AJY7UOnSKuVvqFNVT9weNxjX2Q/FUV/Ywaba8qJwe8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gi9NsWl51RzQUiOJkTIXynCcezX0o2fvnsGpgqsFQiz1Ce7V4boJJmzU1RpHsjyHK
         Y92DRFJ1H4EtqRFMtV2NTrSzNbq/bV20Yc5AvkOPwRoXu1xeQVyHbpnnh3TdeNe+bd
         7DY0d9dPcxSGjzSsaeZqcTU159t7hXSpMSarG+GqwC8YmBy3dMjsH1KZ6P83C59jQ6
         /XepllLVo5AI66Sywu51H0AbWfjoVczutp1OCCLuchoUJce1NIHaHlz2G4EtSOA/lk
         en5eyUswjtGg5sqeUK87C7UU+HWr3rz2MEvsjvmNnJc743RupLrnHu8sROI7ZIGqPe
         LsJMejJWt9+fQ==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/10] platform/chrome: cros_ec_proto: separate cros_ec_xfer_command()
Date:   Mon, 18 Jul 2022 05:09:09 +0000
Message-Id: <20220718050914.2267370-6-tzungbi@kernel.org>
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

cros_ec_send_command() has extra logic to handle EC_RES_IN_PROGRESS.
Separate the command transfer part into cros_ec_xfer_command() so
that other functions can re-use it.

Reviewed-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v1:
- Add R-b tag.

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
2.37.0.170.g444d1eabd0-goog

