Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69773524800
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351606AbiELIhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351571AbiELIhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:37:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB04CC5DBE
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:37:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65AFCB826AF
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164F1C34100;
        Thu, 12 May 2022 08:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652344618;
        bh=LulTl0X/xWYEJDLcbMNeSC0LiiB0mopTbVJ4S9B5CWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aknmkpW9llvJbuu8T055OBxPfg1rFdjhn7WSCzvmGPUPM+xB6af/1MdNZZH5BzGaB
         NHwFSMvWviwlh5KTE/4iPdciguFAWjza8/KWz96CHlOdTAPTbDe3WifkkhMY0D+mLE
         pcBSyTm1avHBEWOiLhmdLoU8faMm+oIvYi8Q+Kl2WjhQCrA5zCx0NIH2mQ8zAhzglQ
         Lnjxh+G5jVu/1vr1bg4ZhMmOl1TD8pL0LxFsEelcPz09DXcBtXDoPvbDxPEej9aoXK
         16dl3itiIn+4me6lSlr8p8XR6OTQXzXJEJ9039PcJmOAzVpBShDBI/Y+UcMqqUSp6A
         Onazve+5hmgkg==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] platform/chrome: cros_ec_spi: drop BUG_ON()
Date:   Thu, 12 May 2022 16:36:27 +0800
Message-Id: <20220512083627.885338-7-tzungbi@kernel.org>
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

It is overkill to crash the kernel if the `din` buffer is going to full
or overflow.

Drop the BUG_ON() and return -EINVAL instead.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_spi.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 589f18e9537d..0a938f317adc 100644
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
@@ -237,7 +239,8 @@ static int cros_ec_spi_receive_packet(struct cros_ec_device *ec_dev,
 	 * start of our buffer
 	 */
 	todo = end - ++ptr;
-	BUG_ON(todo < 0 || todo > ec_dev->din_size);
+	if (todo < 0 || todo > ec_dev->din_size)
+		return -EINVAL;
 	todo = min(todo, need_len);
 	memmove(ec_dev->din, ptr, todo);
 	ptr = ec_dev->din + todo;
@@ -305,7 +308,8 @@ static int cros_ec_spi_receive_response(struct cros_ec_device *ec_dev,
 	unsigned long deadline;
 	int todo;
 
-	BUG_ON(ec_dev->din_size < EC_MSG_PREAMBLE_COUNT);
+	if (ec_dev->din_size < EC_MSG_PREAMBLE_COUNT)
+		return -EINVAL;
 
 	/* Receive data until we see the header byte */
 	deadline = jiffies + msecs_to_jiffies(EC_MSG_DEADLINE_MS);
@@ -345,7 +349,8 @@ static int cros_ec_spi_receive_response(struct cros_ec_device *ec_dev,
 	 * start of our buffer
 	 */
 	todo = end - ++ptr;
-	BUG_ON(todo < 0 || todo > ec_dev->din_size);
+	if (todo < 0 || todo > ec_dev->din_size)
+		return -EINVAL;
 	todo = min(todo, need_len);
 	memmove(ec_dev->din, ptr, todo);
 	ptr = ec_dev->din + todo;
-- 
2.36.0.512.ge40c2bad7a-goog

