Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E80525AD9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 06:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377029AbiEMEmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 00:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377017AbiEMEmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 00:42:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE495A30A3
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 21:42:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A777619F1
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 04:42:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C95C34116;
        Fri, 13 May 2022 04:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652416920;
        bh=yRw9OiL6/COzMbaUd1gNsGDfBq6AJMmRuleh8yX3C5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GqIF3uqEkBLQ3TqFsbwTTgRGpIyF7/KDTGwosK+byp6hSagAFgp4s0MP9in50ccTm
         sjdUhU+S4fW8TsFn5+Rg55jLn0XQwWRoHoYZ8sT11LOlF5Dd+daJz+vGVHZjMmgVWC
         Ui6jQZzxfYW5hCqDU1whSil7XFrTahP7BOh3+y9k/QhF2YOd0mSVYeCEs6fjyGmOGj
         aVNTV2VaQqtVZv7pdvgFIVYdCoViZJ0ZY73CFlXYa1re6QelzEFXA+kB+AoHPfDDpi
         +EUywEYuHp4Eb1n/elCATQhLElPINYkQjyDVqx01i+qdLhICN3KSQsY+UhiG0g97OL
         BP6KqbMxayluA==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] platform/chrome: cros_ec_spi: drop unneeded BUG_ON()
Date:   Fri, 13 May 2022 12:41:42 +0800
Message-Id: <20220513044143.1045728-7-tzungbi@kernel.org>
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

In the context, the following conditions are always false:

- `todo` < 0
Suppose that EC_SPI_FRAME_START is found at the last byte of transfer.

In the case, `ptr` == `end` - 1.  As a result, `todo` must be 0.

- `todo` > `ec_dev->din_size`
Suppose that there is no preamble bytes.  EC_SPI_FRAME_START is found at
the first byte of transfer.

In the case, `end` == `ptr` + EC_MSG_PREAMBLE_COUNT.
As a result, `todo` == EC_MSG_PREAMBLE_COUNT - 1.
However, it already checked `ec_dev->din_size` < EC_MSG_PREAMBLE_COUNT at
the beginning of function.

Drop the unneeded BUG_ON().

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v1:
- Separate from the original 6th patch.
- Drop the BUG_ON() instead of returning -EINVAL.

 drivers/platform/chrome/cros_ec_spi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 589f18e9537d..5264615f46af 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -237,7 +237,6 @@ static int cros_ec_spi_receive_packet(struct cros_ec_device *ec_dev,
 	 * start of our buffer
 	 */
 	todo = end - ++ptr;
-	BUG_ON(todo < 0 || todo > ec_dev->din_size);
 	todo = min(todo, need_len);
 	memmove(ec_dev->din, ptr, todo);
 	ptr = ec_dev->din + todo;
@@ -345,7 +344,6 @@ static int cros_ec_spi_receive_response(struct cros_ec_device *ec_dev,
 	 * start of our buffer
 	 */
 	todo = end - ++ptr;
-	BUG_ON(todo < 0 || todo > ec_dev->din_size);
 	todo = min(todo, need_len);
 	memmove(ec_dev->din, ptr, todo);
 	ptr = ec_dev->din + todo;
-- 
2.36.0.550.gb090851708-goog

