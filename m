Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707C150A2A7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389420AbiDUOiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389416AbiDUOir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:38:47 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049DA13D59
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:35:55 -0700 (PDT)
Received: from pop-os.home ([86.243.180.246])
        by smtp.orange.fr with ESMTPA
        id hXuQn30c3AyM1hXuRnZAqN; Thu, 21 Apr 2022 16:35:53 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 21 Apr 2022 16:35:53 +0200
X-ME-IP: 86.243.180.246
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH] bus: sunxi-rsb: Fix the return value of sunxi_rsb_device_create()
Date:   Thu, 21 Apr 2022 16:35:49 +0200
Message-Id: <ef2b9576350bba4c8e05e669e9535e9e2a415763.1650551719.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code is really spurious.
It always returns an ERR_PTR, even when err is known to be 0 and calls
put_device() after a successful device_register() call.

It is likely that the return statement in the normal path is missing.
Add 'return rdev;' to fix it.

Fixes: d787dcdb9c8f ("bus: sunxi-rsb: Add driver for Allwinner Reduced Serial Bus")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is completely speculative and compile tested only.
---
 drivers/bus/sunxi-rsb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index 4566e730ef2b..60b082fe2ed0 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -227,6 +227,8 @@ static struct sunxi_rsb_device *sunxi_rsb_device_create(struct sunxi_rsb *rsb,
 
 	dev_dbg(&rdev->dev, "device %s registered\n", dev_name(&rdev->dev));
 
+	return rdev;
+
 err_device_add:
 	put_device(&rdev->dev);
 
-- 
2.32.0

