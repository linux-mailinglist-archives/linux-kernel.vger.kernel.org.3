Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A836B5247FE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351526AbiELIhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351516AbiELIgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:36:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB62C26108
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:36:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6E38B8271B
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692F5C34114;
        Thu, 12 May 2022 08:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652344612;
        bh=fGGk+oRwdXQ4AQBOdNScxfYCcCLuxWnBXpFkWB+DaRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WtbeEQMhupWBZOGeW3kTzf9yJkeUZ4b1GuK6xoATAIuY2L9oy10EApfiJZbLkwdWd
         CmI4yJf6wyudOj3NStTS0mYtH2F5Mqwt/DADBVToemi0KGrdigBFEHYSCL3l7Nie4k
         eSc95DFErF+3DxXZlHETHV1+F1UItBwa5VWihLxMpwTV3QfGPi9BYXix+Tnhxt4lIO
         KR+3REKSBayiedPJ5WZA/tWS76EennOMGqJ1/Ixgbm6wOJvFo3cAPurJhQcGKnmCyL
         xGlDIsoJcTFfqCrChBA0YWsRdjQwmGWeVNdHUhsPvHViY1V37A8pLFdWsmelRF5tYK
         F+SwdETqZ3Tlg==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] platform/chrome: correct cros_ec_prepare_tx() usage
Date:   Thu, 12 May 2022 16:36:23 +0800
Message-Id: <20220512083627.885338-3-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
In-Reply-To: <20220512083627.885338-1-tzungbi@kernel.org>
References: <20220512083627.885338-1-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cros_ec_prepare_tx() returns either:
- >= 0 for number of prepared bytes.
- < 0 for -errno.

Correct the comment and make sure all callers check the return code.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_i2c.c   | 2 ++
 drivers/platform/chrome/cros_ec_ishtp.c | 4 +++-
 drivers/platform/chrome/cros_ec_lpc.c   | 2 ++
 drivers/platform/chrome/cros_ec_proto.c | 2 +-
 drivers/platform/chrome/cros_ec_rpmsg.c | 2 ++
 drivers/platform/chrome/cros_ec_spi.c   | 4 ++++
 6 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_i2c.c b/drivers/platform/chrome/cros_ec_i2c.c
index 22feb0fd4ce7..a4f305f1eb0e 100644
--- a/drivers/platform/chrome/cros_ec_i2c.c
+++ b/drivers/platform/chrome/cros_ec_i2c.c
@@ -89,6 +89,8 @@ static int cros_ec_pkt_xfer_i2c(struct cros_ec_device *ec_dev,
 
 	ec_dev->dout++;
 	ret = cros_ec_prepare_tx(ec_dev, msg);
+	if (ret < 0)
+		goto done;
 	ec_dev->dout--;
 
 	/* send command to EC and read answer */
diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
index 4020b8354bae..cb2031cf7106 100644
--- a/drivers/platform/chrome/cros_ec_ishtp.c
+++ b/drivers/platform/chrome/cros_ec_ishtp.c
@@ -521,7 +521,9 @@ static int cros_ec_pkt_xfer_ish(struct cros_ec_device *ec_dev,
 	out_msg->hdr.status = 0;
 
 	ec_dev->dout += OUT_MSG_EC_REQUEST_PREAMBLE;
-	cros_ec_prepare_tx(ec_dev, msg);
+	rv = cros_ec_prepare_tx(ec_dev, msg);
+	if (rv < 0)
+		goto end_error;
 	ec_dev->dout -= OUT_MSG_EC_REQUEST_PREAMBLE;
 
 	dev_dbg(dev,
diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 8eeef85a96b1..7677ab3c0ead 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -147,6 +147,8 @@ static int cros_ec_pkt_xfer_lpc(struct cros_ec_device *ec,
 	u8 *dout;
 
 	ret = cros_ec_prepare_tx(ec, msg);
+	if (ret < 0)
+		goto done;
 
 	/* Write buffer */
 	cros_ec_lpc_ops.write(EC_LPC_ADDR_HOST_PACKET, ret, ec->dout);
diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index db1c8ba43171..2d6d3fbfa905 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -164,7 +164,7 @@ static int send_command(struct cros_ec_device *ec_dev,
  * only SPI uses it. Once LPC uses the same protocol it can start using it.
  * I2C could use it now, with a refactor of the existing code.
  *
- * Return: 0 on success or negative error code.
+ * Return: number of prepared bytes on success or negative error code.
  */
 int cros_ec_prepare_tx(struct cros_ec_device *ec_dev,
 		       struct cros_ec_command *msg)
diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/chrome/cros_ec_rpmsg.c
index d96d15b8ca94..39d3b50a7c09 100644
--- a/drivers/platform/chrome/cros_ec_rpmsg.c
+++ b/drivers/platform/chrome/cros_ec_rpmsg.c
@@ -89,6 +89,8 @@ static int cros_ec_pkt_xfer_rpmsg(struct cros_ec_device *ec_dev,
 
 	ec_msg->result = 0;
 	len = cros_ec_prepare_tx(ec_dev, ec_msg);
+	if (len < 0)
+		return len;
 	dev_dbg(ec_dev->dev, "prepared, len=%d\n", len);
 
 	reinit_completion(&ec_rpmsg->xfer_ack);
diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 8493af0f680e..589f18e9537d 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -401,6 +401,8 @@ static int do_cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
 	unsigned long delay;
 
 	len = cros_ec_prepare_tx(ec_dev, ec_msg);
+	if (len < 0)
+		return len;
 	dev_dbg(ec_dev->dev, "prepared, len=%d\n", len);
 
 	/* If it's too soon to do another transaction, wait */
@@ -544,6 +546,8 @@ static int do_cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
 	unsigned long delay;
 
 	len = cros_ec_prepare_tx(ec_dev, ec_msg);
+	if (len < 0)
+		return len;
 	dev_dbg(ec_dev->dev, "prepared, len=%d\n", len);
 
 	/* If it's too soon to do another transaction, wait */
-- 
2.36.0.512.ge40c2bad7a-goog

