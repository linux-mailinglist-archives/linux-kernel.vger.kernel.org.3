Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E37955135B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240155AbiFTIwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240094AbiFTIvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:51:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A788612D1F;
        Mon, 20 Jun 2022 01:51:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E6A4B80EFB;
        Mon, 20 Jun 2022 08:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23ACDC341C6;
        Mon, 20 Jun 2022 08:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655715103;
        bh=R7BbkoAkXH1dj6TeELpY6vsOEzi80ZOjGxIPiK4mS90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DirDM6NNuTFmWgGKnGApS71tlQDKtkZj/PQcG3AFxWvIYhRyf1x8vedhiEkJ8G0nW
         hWW2V/mL7dnG2vB1wFyL+rxLI+Rk53EFf6/8Ai3wWfO0suo5fe3U9sSGGvJ9kUJ9MT
         K/epnA4TTYuaEphwZkEDxp9MvqdC7GWI+DcRnhMxcPkv7zk2xw9VC4V9klAO/AgyNk
         PpNFdhrT7Jl2QZ6zFxqQAhN/Jo6KtNi6EN848ZaK5Fe0k/LIqscJ9kkFG8wkGku5IP
         z+4BF/s2DKRFp8i87lwmCiYSZPYCTY+p+0vLW27TaS5MFFutQzMX8j1jBqM9KJcJgZ
         SaJrLbBgn/DCg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o3D8F-0005To-LQ; Mon, 20 Jun 2022 10:51:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/2] Input: usbtouchscreen - suppress empty array warnings
Date:   Mon, 20 Jun 2022 10:46:27 +0200
Message-Id: <20220620084628.20894-2-johan@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220620084628.20894-1-johan@kernel.org>
References: <20220620084628.20894-1-johan@kernel.org>
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

When compile-testing the USB touchscreen driver without enabling any of
the device type options the usbtouch_dev_info array ends up being empty,
something which triggers compiler warning with -Warray-bounds
(gcc-11.3.0).

drivers/input/touchscreen/usbtouchscreen.c: In function 'usbtouch_probe':
drivers/input/touchscreen/usbtouchscreen.c:1668:16:warning: array subscript <unknown> is outside array bounds of 'struct usbtouch_device_info[0]' [-Warray-bounds]
 1668 |         type = &usbtouch_dev_info[id->driver_info];

Suppress the warnings by making sure that the array is always non-empty.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/input/touchscreen/usbtouchscreen.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 43c521f50c85..6683554f0e92 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -128,6 +128,7 @@ enum {
 	DEVTYPE_NEXIO,
 	DEVTYPE_ELO,
 	DEVTYPE_ETOUCH,
+	DEVTYPE_COUNT
 };
 
 #define USB_DEVICE_HID_CLASS(vend, prod) \
@@ -1379,6 +1380,7 @@ static struct usbtouch_device_info usbtouch_dev_info[] = {
 		.read_data	= etouch_read_data,
 	},
 #endif
+	[DEVTYPE_COUNT] = { }	/* Make sure array is non-empty */
 };
 
 
-- 
2.35.1

