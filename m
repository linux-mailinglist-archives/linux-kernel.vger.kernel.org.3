Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD199547F44
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 07:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbiFMFup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 01:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbiFMFud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 01:50:33 -0400
X-Greylist: delayed 638 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Jun 2022 22:50:32 PDT
Received: from SpacedOut.fries.net (SpacedOut.fries.net [IPv6:2001:470:3832:200::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525645FE6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 22:50:32 -0700 (PDT)
Received: from SpacedOut.fries.net (ip6-localhost [IPv6:0:0:0:0:0:0:0:1])
        by SpacedOut.fries.net (8.15.2/8.15.2/Debian-22) with ESMTPS id 25D5dfdW3963830
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 00:39:41 -0500
Received: (from david@localhost)
        by SpacedOut.fries.net (8.15.2/8.15.2/Submit) id 25D5dfhh3963829;
        Mon, 13 Jun 2022 00:39:41 -0500
Date:   Mon, 13 Jun 2022 00:39:41 -0500
From:   David Fries <David@fries.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] spi: spidev_test: Warn when the mode is not the requested
 mode
Message-ID: <YqbNnSGtWHe/GG7w@spacedout.fries.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.6.2 (SpacedOut.fries.net [IPv6:::1]); Mon, 13 Jun 2022 00:39:41 -0500 (CDT)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print a warning if the device mode doesn't match the requested mode.
The user doesn't enter the mode in hex so it isn't obvious when
setting the mode succeeds that the mode isn't the requested mode.  The
kernel logs a message, it will be more visible if the test also prints
a warning.  I was testing --quad, which is unsupported, but doesn't
cause the mode request to fail.

Signed-off-by: David Fries <David@Fries.net>
---
This is the kernel log, I just didn't see it at first.
spidev spi1.0: setup: ignoring unsupported mode bits 200

I was testing --quad on a Raspberry Pi where I didn't expect it to
work, which the ioctl didn't return an error, it just cleared the bits
it didn't support.

 tools/spi/spidev_test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 83844f8b862a..5629387bfc56 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -417,6 +417,7 @@ int main(int argc, char *argv[])
 {
 	int ret = 0;
 	int fd;
+	uint32_t request;
 
 	parse_opts(argc, argv);
 
@@ -430,13 +431,23 @@ int main(int argc, char *argv[])
 	/*
 	 * spi mode
 	 */
+	/* WR is make a request to assign 'mode' */
+	request = mode;
 	ret = ioctl(fd, SPI_IOC_WR_MODE32, &mode);
 	if (ret == -1)
 		pabort("can't set spi mode");
 
+	/* RD is read what mode the device actually is in */
 	ret = ioctl(fd, SPI_IOC_RD_MODE32, &mode);
 	if (ret == -1)
 		pabort("can't get spi mode");
+	/* Drivers can reject some mode bits without returning an error.
+	 * Read the current value to identify what mode it is in, and if it
+	 * differs from the requested mode, warn the user.
+	 */
+	if(request != mode)
+		printf("WARNING device does not support requested mode 0x%x\n",
+			request);
 
 	/*
 	 * bits per word
-- 
2.30.2
