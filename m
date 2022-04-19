Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DF5507D5C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 01:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358492AbiDSXtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 19:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358180AbiDSXt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 19:49:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7F91DA52
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 16:46:43 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650412001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WojArbM9OzLNiontaIQZoMbzC5aP6fR9aoNVu9FnfGE=;
        b=Sos/EZ4DnLNhubs5EVj4evdQZQmzC3Gmd+zMls9Xvk1JX6zgqtS4iqa640r3TU2TTGfZ+y
        kHjiaFM6lwck4EbopQRqnUviJsKtIZaaMJy1yRPOJxTaqyHrmRapSfV4/HpTLIAbhI5FV6
        5rdJxDOp2NzTI9PXUAu6FVBJH5zGEsLP5g88Uflkt8w/F2/RRAK3WBIWvhDDuUuGmSB0BD
        Xhqpa6HVwnzj0JFltuHcSO81REmzLHKjVLytGPMwMOf4HgiBnE23khofN5WXuFxUvvOpZi
        FsIyfqOn28/V7Vsgbi5e0YjKcNE5MsuPrpR/Emyb5P0dm8ktYISDj2bIPdfi/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650412001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WojArbM9OzLNiontaIQZoMbzC5aP6fR9aoNVu9FnfGE=;
        b=twfu5jLa5BuAOjvqmSo/2v0tdfOoYjRsUzoRskXsP2LW+lzH/IRyioy53ChEPQ1LZnbh2q
        3Q264YFqZA+2TFAw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 07/15] printk: call boot_delay_msec() in printk_delay()
Date:   Wed, 20 Apr 2022 01:52:29 +0206
Message-Id: <20220419234637.357112-8-john.ogness@linutronix.de>
In-Reply-To: <20220419234637.357112-1-john.ogness@linutronix.de>
References: <20220419234637.357112-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

boot_delay_msec() is always called immediately before printk_delay()
so just call it from within printk_delay().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 82ad3d3d0d4a..2f99e0b383b9 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2048,8 +2048,10 @@ static u8 *__printk_recursion_counter(void)
 
 int printk_delay_msec __read_mostly;
 
-static inline void printk_delay(void)
+static inline void printk_delay(int level)
 {
+	boot_delay_msec(level);
+
 	if (unlikely(printk_delay_msec)) {
 		int m = printk_delay_msec;
 
@@ -2274,8 +2276,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 		in_sched = true;
 	}
 
-	boot_delay_msec(level);
-	printk_delay();
+	printk_delay(level);
 
 	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
 
-- 
2.30.2

