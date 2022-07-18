Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3567577A44
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 07:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbiGRFKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 01:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbiGRFKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 01:10:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D0413CC2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 22:10:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27125B80EF1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED59C341C8;
        Mon, 18 Jul 2022 05:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658121016;
        bh=qZEfQmPuzobblfAILf3AUWXcuMaT0V6hEOUvHUNl8Wg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T9D2Uwy5Q9lasElEuSApy6N0MnUxH+mHQhsf1FmV3W1fqzsRDG9gIjgJFtRm3X7uy
         Kqrsth9rh+JoQ/g7RQicEjrvHB0xzTExvIKrJ91qRYi7aHZQ2z9+sEX71aGhub4VI7
         jt89FUWYEsSQu2K01OWtXkSNi5I5+h+cPC0tA644n4H4zpnakVVPL6Js4/RbeXB9pA
         5rElaI0ZfxT3GpNc4Rep6j6NBFlW45TliPKWfza/6CnGVAwvFu/8Yl1xKzKtSwuepL
         E2+BLj2I++0b1rMIEyKmO5qnl3DZlVsSFUiEy3bWNAb5rS4vlgbYw4BGHePnMtOW/A
         AB3ZX+PrTggAw==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/10] platform/chrome: cros_ec_proto: return -EAGAIN when retries timed out
Date:   Mon, 18 Jul 2022 05:09:12 +0000
Message-Id: <20220718050914.2267370-9-tzungbi@kernel.org>
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

While EC_COMMS_STATUS_PROCESSING flag is still on after it tries
EC_COMMAND_RETRIES times for sending EC_CMD_GET_COMMS_STATUS,
cros_ec_wait_until_complete() doesn't return an error code.

Return -EAGAIN in the case instead.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
No changes from v1.

 drivers/platform/chrome/cros_ec_proto.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index a6ad7f7956e6..9dec475edc84 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -167,6 +167,9 @@ static int cros_ec_wait_until_complete(struct cros_ec_device *ec_dev, uint32_t *
 			return ret;
 	}
 
+	if (i >= EC_COMMAND_RETRIES)
+		ret = -EAGAIN;
+
 	return ret;
 }
 
-- 
2.37.0.170.g444d1eabd0-goog

