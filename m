Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B892D4757C3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbhLOL3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237214AbhLOL3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:29:47 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC5BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 03:29:46 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 1954F421F5;
        Wed, 15 Dec 2021 11:29:42 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH] soc: apple: apple-pmgr-pwrstate: Do not build as a module
Date:   Wed, 15 Dec 2021 20:29:35 +0900
Message-Id: <20211215112935.238561-1-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This doesn't make any sense as a module since it is a critical device,
and it turns out of_phandle_iterator_args was not exported so the module
version doesn't build anyway.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/soc/apple/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/apple/Kconfig b/drivers/soc/apple/Kconfig
index 3eb14abf8d33..9b8de31d6a8f 100644
--- a/drivers/soc/apple/Kconfig
+++ b/drivers/soc/apple/Kconfig
@@ -5,7 +5,7 @@ if ARCH_APPLE || COMPILE_TEST
 menu "Apple SoC drivers"
 
 config APPLE_PMGR_PWRSTATE
-	tristate "Apple SoC PMGR power state control"
+	bool "Apple SoC PMGR power state control"
 	depends on PM
 	select REGMAP
 	select MFD_SYSCON
-- 
2.33.0

