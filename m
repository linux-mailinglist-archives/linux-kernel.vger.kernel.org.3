Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E100753C9A9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 14:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244147AbiFCMEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 08:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244107AbiFCMEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:04:22 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623582D1F5;
        Fri,  3 Jun 2022 05:04:18 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4LF1l30pPhz9sSg;
        Fri,  3 Jun 2022 14:04:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mariushoch.de;
        s=MBO0001; t=1654257855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=thJEOw47aWkwJpKjStXW53n2jByTCrrfxouzhvoKL88=;
        b=wtham21rh9ClkfLxngtddRDxEtskNWMqCdTu/A9FrQLD5gBT5QeMX/wnRjGPjQ7ro9Qka7
        R+NJYdvod5snYn0HeMHcAUdKLBVZsRDKTfkcSz7BKvSHULLpPhpIxqqsYpwxeAsANveRyX
        l/rPkLNj3St41Vs86fHr/3opW3McaW0qf+a1pf8ehhGPeLABa8GR0RMB2FcxWDGa1/2Mul
        pI1DEclvb+2XwdidsNkFgYX/LNQO8jCmUIpb4858HFrWgQSrXAh9oB3tpbyaTZtV6zFtWY
        3U1bje5qlLmCJKOEfHKypBfE1WitoY+QZo/sbNw3ngM1WMRsBO3Mlq5zCTfIUQ==
From:   Marius Hoch <mail@mariushoch.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marius Hoch <mail@mariushoch.de>
Subject: [PATCH] Input: soc_button_array - also add Lenovo Yoga Tablet2 1051F to dmi_use_low_level_irq
Date:   Fri,  3 Jun 2022 14:02:46 +0200
Message-Id: <20220603120246.3065-1-mail@mariushoch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4LF1l30pPhz9sSg
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 223f61b8c5ad ("Input: soc_button_array - add Lenovo Yoga Tablet2
1051L to the dmi_use_low_level_irq list") added the 1051L to this list
already, but the same problem applies to the 1051F. As there are no
further 1051 variants (just the F/L), we can just DMI match 1051.

Tested on a Lenovo Yoga Tablet2 1051F: Without this patch the
home-button stops working after a wakeup from suspend.

Signed-off-by: Marius Hoch <mail@mariushoch.de>
---
 drivers/input/misc/soc_button_array.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index cbb1599a520e..480476121c01 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -85,13 +85,13 @@ static const struct dmi_system_id dmi_use_low_level_irq[] = {
 	},
 	{
 		/*
-		 * Lenovo Yoga Tab2 1051L, something messes with the home-button
+		 * Lenovo Yoga Tab2 1051F/1051L, something messes with the home-button
 		 * IRQ settings, leading to a non working home-button.
 		 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "60073"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "1051L"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "1051"),
 		},
 	},
 	{} /* Terminating entry */
-- 
2.36.1

