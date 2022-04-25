Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A1D50DE7E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241388AbiDYLMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236148AbiDYLMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:12:00 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B9B1D64;
        Mon, 25 Apr 2022 04:08:54 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 38CC11E80D60;
        Mon, 25 Apr 2022 19:05:48 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HGFfNuF0KorW; Mon, 25 Apr 2022 19:05:45 +0800 (CST)
Received: from localhost.localdomain (unknown [61.152.154.55])
        (Authenticated sender: renyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 273F11E80CB5;
        Mon, 25 Apr 2022 19:05:45 +0800 (CST)
From:   Ren Yu <renyu@nfschina.com>
To:     tony@atomide.com
Cc:     aaro.koskinen@iki.fi, linux@armlinux.org.uk,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        yuzhe@nfschina.com, Ren Yu <renyu@nfschina.com>
Subject: [PATCH] plat-omap: check return value of ioremap()
Date:   Mon, 25 Apr 2022 19:08:45 +0800
Message-Id: <20220425110845.415439-1-renyu@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ioremap() failed,return err

Signed-off-by: Ren Yu <renyu@nfschina.com>
---
 arch/arm/plat-omap/debug-leds.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/plat-omap/debug-leds.c b/arch/arm/plat-omap/debug-leds.c
index 2b698d074874..bf5034e10f6e 100644
--- a/arch/arm/plat-omap/debug-leds.c
+++ b/arch/arm/plat-omap/debug-leds.c
@@ -109,6 +109,9 @@ static int fpga_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	fpga = ioremap(iomem->start, resource_size(iomem));
+	if (!fpga)
+		return -ENOMEM;
+
 	writew_relaxed(0xff, &fpga->leds);
 
 	for (i = 0; i < ARRAY_SIZE(dbg_leds); i++) {
-- 
2.25.1

