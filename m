Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C334E531FE2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 02:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbiEXAdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 20:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiEXAdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 20:33:43 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D88B19BAEE;
        Mon, 23 May 2022 17:33:40 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id BB4E01E80D3A;
        Tue, 24 May 2022 08:26:23 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zVO1dCYpLbsQ; Tue, 24 May 2022 08:26:21 +0800 (CST)
Received: from ubuntu.localdomain (unknown [101.228.248.69])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id E250A1E80CE5;
        Tue, 24 May 2022 08:26:20 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     sander@svanheule.net, wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] watchdog: change "char *" string form to "char []"
Date:   Mon, 23 May 2022 17:33:35 -0700
Message-Id: <20220524003335.64801-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The string form of "char []" declares a single variable. It is better
than "char *" which creates two variables.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 drivers/watchdog/realtek_otto_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/realtek_otto_wdt.c b/drivers/watchdog/realtek_otto_wdt.c
index 60058a0c3ec4..c653ec73a999 100644
--- a/drivers/watchdog/realtek_otto_wdt.c
+++ b/drivers/watchdog/realtek_otto_wdt.c
@@ -265,7 +265,7 @@ static int otto_wdt_probe_clk(struct otto_wdt_ctrl *ctrl)
 
 static int otto_wdt_probe_reset_mode(struct otto_wdt_ctrl *ctrl)
 {
-	static const char *mode_property = "realtek,reset-mode";
+	static const char mode_property[] = "realtek,reset-mode";
 	const struct fwnode_handle *node = ctrl->dev->fwnode;
 	int mode_count;
 	u32 mode;
-- 
2.25.1

