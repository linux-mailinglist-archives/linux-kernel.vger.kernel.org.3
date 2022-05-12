Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73855247FC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351625AbiELIh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351537AbiELIhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:37:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553CF719D6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:36:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFF15B8271A
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C41C385B8;
        Thu, 12 May 2022 08:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652344616;
        bh=5S/vz7oJHep62A20DBAYfOQXHyrn3WGZtDhKGTPDufY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FJ1gcyq5IOQlKCWX5ZOo2OtVn94j3ivOnsCK1rVmJmDjTgXTsB8x31tgWsAet+2Wy
         gwvB5vLf4R5dUw+OXMAK6Ksazgsxc3pI6gHoIDXuxgAlgznDcdNu0TaYiota3w/R1N
         5GcTTLuC7tsTkcbAXmafBqa4j1JEBe/wRN0wWxR+1FD1oF0dWoS8BPZ8xKyoAUBfkN
         7osqRQH6Q4zOBBrJjoh/epqZIlh9a9ffmIU+qPtsyFB4J7EX02YhVw2MYOc5B+MPbl
         4E2SCHtFe0nIYhn15yc+hCi61jmzNr5IKeg3dFkhm43ybZIXynfk05R2CB5Xyqh8Fn
         ZxvG8dmwgy5zQ==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] platform/chrome: cros_ec_i2c: drop BUG_ON() in cros_ec_pkt_xfer_i2c()
Date:   Thu, 12 May 2022 16:36:26 +0800
Message-Id: <20220512083627.885338-6-tzungbi@kernel.org>
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

It is overkill to crash the kernel if the given message is oversize.

Drop the BUG_ON() and return -EINVAL instead.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_i2c.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_i2c.c b/drivers/platform/chrome/cros_ec_i2c.c
index a4f305f1eb0e..9f5b95763173 100644
--- a/drivers/platform/chrome/cros_ec_i2c.c
+++ b/drivers/platform/chrome/cros_ec_i2c.c
@@ -72,13 +72,19 @@ static int cros_ec_pkt_xfer_i2c(struct cros_ec_device *ec_dev,
 	i2c_msg[1].flags = I2C_M_RD;
 
 	packet_len = msg->insize + response_header_size;
-	BUG_ON(packet_len > ec_dev->din_size);
+	if (packet_len > ec_dev->din_size) {
+		ret = -EINVAL;
+		goto done;
+	}
 	in_buf = ec_dev->din;
 	i2c_msg[1].len = packet_len;
 	i2c_msg[1].buf = (char *) in_buf;
 
 	packet_len = msg->outsize + request_header_size;
-	BUG_ON(packet_len > ec_dev->dout_size);
+	if (packet_len > ec_dev->dout_size) {
+		ret = -EINVAL;
+		goto done;
+	}
 	out_buf = ec_dev->dout;
 	i2c_msg[0].len = packet_len;
 	i2c_msg[0].buf = (char *) out_buf;
-- 
2.36.0.512.ge40c2bad7a-goog

