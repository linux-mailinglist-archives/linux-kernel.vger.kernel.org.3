Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC7F525ADD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 06:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377037AbiEMEmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 00:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377006AbiEMEl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 00:41:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D46BA309A
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 21:41:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71475B82AE9
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 04:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D16DC34100;
        Fri, 13 May 2022 04:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652416915;
        bh=UxhsGKq6Hkz6ckhEo9ojFFKACE0CY4WmkG8hUvrsotg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=smlc+YIa5VkRSQlje/Lq2H5idoQ7Dlhj86sSl6C2kgH15xdzu975CuZUb7pz197Jo
         ik6bc2Nrd9xSUl7qDvJajG6GHZYMAY5cnpZMe+x3icWkVFhZoGy6K4beQJchfAt1nL
         V95Ie1QlHFVa1y1Fyah1NWgFhP9sGqM1f7dte99y+yTh8AnT35y/U4CcKkRKnAwmqG
         402wssdhU7om2q6v3+yUSyEmsQo2cZjSTnxIz7vs2TY+SGJzN1ZG4NKHmvvGkfEXtj
         cbMWCcJZW509T7CROuRv68KlxA+uQR3QA0KsP/TJPnEukIzejQUtpIqoUhZbF0i+92
         e5qWtD2d3Jqkg==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] platform/chrome: correct cros_ec_prepare_tx() usage
Date:   Fri, 13 May 2022 12:41:38 +0800
Message-Id: <20220513044143.1045728-3-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
In-Reply-To: <20220513044143.1045728-1-tzungbi@kernel.org>
References: <20220513044143.1045728-1-tzungbi@kernel.org>
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

Reviewed-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v1:
- Add R-b tag.

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
2.36.0.550.gb090851708-goog

