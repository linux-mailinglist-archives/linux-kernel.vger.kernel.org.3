Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD72E580F71
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbiGZI4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiGZI4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:56:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAE7B4AD;
        Tue, 26 Jul 2022 01:56:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C7B0B8128F;
        Tue, 26 Jul 2022 08:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091A2C341C0;
        Tue, 26 Jul 2022 08:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658825798;
        bh=SMBADMV9je+BEusk6Ogun7zma2H0hMl2CeFThJT1Avg=;
        h=From:To:Cc:Subject:Date:From;
        b=BfnT7ng5u3yHSC1GNkZJ0TbbZQA6+U2ayCPn7p9JRsZSiNVG0cjeOkKlu8fi0DZdp
         cw+CBCodKycpuwzIJCuqDeW0GX2O/iUn3EmrF4tuCL9BuCICiBK6ksB24QDmXkjrb1
         LNFs85uEQ5640j6wvjFRMteOHdGpgpS18q2TfqEX3q3/4rp+cn5DSnhsGOBoYVuB0n
         lwjBnQoVyoWp4FyQ8rlO9XSf75WmpO7PqfzLRsEFxN3LKuQCzla6cdiSaYIRO5b5Vb
         kd9xChigezw9X1JQccpNEYKj7R9H3QBrLqkqbZNXWZnUaAVTakyRkbB8b1syXIY3jT
         KtXmCkYl8SM8g==
Received: by pali.im (Postfix)
        id AA6F282D; Tue, 26 Jul 2022 10:56:34 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: armada_37xx_wdt: Fix .set_timeout callback
Date:   Tue, 26 Jul 2022 10:56:12 +0200
Message-Id: <20220726085612.10672-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ioctl(WDIOC_SETTIMEOUT) calls .set_timeout and .ping callbacks and it is
expected that it changes current watchdog timeout.

armada_37xx_wdt's .ping callback just reping counter 0 and does not touch
counter 1 used for timeout. So it is needed to set counter 1 to the new
value in .set_timeout callback to ensure ioctl(WDIOC_SETTIMEOUT)
functionality. Fix it.

Fixes: 54e3d9b518c8 ("watchdog: Add support for Armada 37xx CPU watchdog")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/watchdog/armada_37xx_wdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/armada_37xx_wdt.c b/drivers/watchdog/armada_37xx_wdt.c
index 1635f421ef2c..b84cba94b135 100644
--- a/drivers/watchdog/armada_37xx_wdt.c
+++ b/drivers/watchdog/armada_37xx_wdt.c
@@ -179,6 +179,8 @@ static int armada_37xx_wdt_set_timeout(struct watchdog_device *wdt,
 	dev->timeout = (u64)dev->clk_rate * timeout;
 	do_div(dev->timeout, CNTR_CTRL_PRESCALE_MIN);
 
+	set_counter_value(dev, CNTR_ID_WDOG, dev->timeout);
+
 	return 0;
 }
 
-- 
2.20.1

