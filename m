Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19D7549947
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbiFMQt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 12:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241134AbiFMQtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 12:49:01 -0400
Received: from SpacedOut.fries.net (SpacedOut.fries.net [IPv6:2001:470:3832:200::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22A71EA864
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 07:35:48 -0700 (PDT)
Received: from SpacedOut.fries.net (ip6-localhost [IPv6:0:0:0:0:0:0:0:1])
        by SpacedOut.fries.net (8.15.2/8.15.2/Debian-22) with ESMTPS id 25DEZckq3980090
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 09:35:38 -0500
Received: (from david@localhost)
        by SpacedOut.fries.net (8.15.2/8.15.2/Submit) id 25DEZZWS3980089;
        Mon, 13 Jun 2022 09:35:35 -0500
Date:   Mon, 13 Jun 2022 09:35:35 -0500
From:   David Fries <David@fries.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] spi: spidev_test: Warn when the mode is not the requested
 mode
Message-ID: <YqdLNyIX8MCQ7Sfs@spacedout.fries.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.6.2 (SpacedOut.fries.net [IPv6:::1]); Mon, 13 Jun 2022 09:35:38 -0500 (CDT)
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
Sorry forgot to run checkpatch.pl though it was silent about the
comments, which I reworded.

 tools/spi/spidev_test.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 83844f8b862a..941d713d6f23 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -417,6 +417,7 @@ int main(int argc, char *argv[])
 {
 	int ret = 0;
 	int fd;
+	uint32_t request;
 
 	parse_opts(argc, argv);
 
@@ -429,7 +430,10 @@ int main(int argc, char *argv[])
 
 	/*
 	 * spi mode
+	 * WR is write 'mode' to request the transfer mode
+	 * RD is read what mode the device actually is
 	 */
+	request = mode;
 	ret = ioctl(fd, SPI_IOC_WR_MODE32, &mode);
 	if (ret == -1)
 		pabort("can't set spi mode");
@@ -437,6 +441,14 @@ int main(int argc, char *argv[])
 	ret = ioctl(fd, SPI_IOC_RD_MODE32, &mode);
 	if (ret == -1)
 		pabort("can't get spi mode");
+	/*
+	 * Drivers can reject some mode options without returning an error.
+	 * Warn in this case to avoid the user thinking the requested mode is
+	 * supported since it didn't give an error.
+	 */
+	if (request != mode)
+		printf("WARNING device does not support requested mode 0x%x\n",
+			request);
 
 	/*
 	 * bits per word
-- 
2.30.2
