Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E751F525ADE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 06:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377057AbiEMEmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 00:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377012AbiEMEmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 00:42:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC9CBCE87
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 21:42:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D770B82B5C
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 04:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487D2C34100;
        Fri, 13 May 2022 04:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652416922;
        bh=Pm5xt1pWIVuJwfVzV4nlj6lC7Q/VLMkt5So5beSne8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E2g/x+oVgM+TCsbGPt9EbAG9Ib1RHIMhd/fBeFWggR/qTlSH3vGhnos5vAmyCEG6q
         nr854v6lA3G+oOEkJyxzjYyD/PXc2BtfdBBxJHhSWacWelVsazmB4zyCowqTCn5Ph9
         EwhGNszHoXiG1Gsf5NXWfGT+ubGEECx5YY82epBuWF+0rRqKix0h17nwguMBQkhP55
         QpeDdccGz1J05Nt339D8d11PsFjaaGo9kGL9DCH6TsGuj5lsSAMFVYF1C1sGhBC/d9
         wYO/vgVL7Y7XG066Y8uE2IFx81/8cVaPI1kgZdJgNPuvsfIIwYv0eeYh/s8hvSfU0e
         jAEN+9QQvXrAA==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] platform/chrome: cros_ec_spi: drop BUG_ON() if `din` isn't large enough
Date:   Fri, 13 May 2022 12:41:43 +0800
Message-Id: <20220513044143.1045728-8-tzungbi@kernel.org>
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

It is overkill to crash the kernel if the `din` buffer is going to full
or overflow.

Drop the BUG_ON() and return -EINVAL instead.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v1:
- Separate from the original 6th patch.

 drivers/platform/chrome/cros_ec_spi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 5264615f46af..7360b3ff6e4f 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -160,7 +160,8 @@ static int receive_n_bytes(struct cros_ec_device *ec_dev, u8 *buf, int n)
 	struct spi_message msg;
 	int ret;
 
-	BUG_ON(buf - ec_dev->din + n > ec_dev->din_size);
+	if (buf - ec_dev->din + n > ec_dev->din_size)
+		return -EINVAL;
 
 	memset(&trans, 0, sizeof(trans));
 	trans.cs_change = 1;
@@ -197,7 +198,8 @@ static int cros_ec_spi_receive_packet(struct cros_ec_device *ec_dev,
 	unsigned long deadline;
 	int todo;
 
-	BUG_ON(ec_dev->din_size < EC_MSG_PREAMBLE_COUNT);
+	if (ec_dev->din_size < EC_MSG_PREAMBLE_COUNT)
+		return -EINVAL;
 
 	/* Receive data until we see the header byte */
 	deadline = jiffies + msecs_to_jiffies(EC_MSG_DEADLINE_MS);
@@ -304,7 +306,8 @@ static int cros_ec_spi_receive_response(struct cros_ec_device *ec_dev,
 	unsigned long deadline;
 	int todo;
 
-	BUG_ON(ec_dev->din_size < EC_MSG_PREAMBLE_COUNT);
+	if (ec_dev->din_size < EC_MSG_PREAMBLE_COUNT)
+		return -EINVAL;
 
 	/* Receive data until we see the header byte */
 	deadline = jiffies + msecs_to_jiffies(EC_MSG_DEADLINE_MS);
-- 
2.36.0.550.gb090851708-goog

