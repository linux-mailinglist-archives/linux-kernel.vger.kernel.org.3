Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539AF4AC9D4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 20:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240532AbiBGTpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 14:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240743AbiBGTnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:43:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9D4C0401DA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 11:43:34 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644263011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+2Lr9d9qHR05sofK1L6gRmeoW4SDlcmhBs2p6+5unzY=;
        b=Ye6Rq+yPI0pCCoA1ujHlzs6Hut1pSADQzp1YfshvjDIyKFSP9dINja/z0yiDEzW/x04OzP
        JM06uk+EqWX8b4j0Dtu3CrJ2ZHvACglmdRx3BZ67bAAhEyXagw10XLJWP3dae3elrDKSyU
        /cFEGpg11bRTusJgJeCpW3U4+SxGQlfPRPz7bC6QOGGzCNTZF6BqdPriVTnvyMDJ58QkIi
        cseJ0wilL4O1ClqttjT7VNz+ck1mo9whfQqXTjKyBRCzMBf1/NcKcL4851RDKNLm79//Bk
        rm2RPkGx7CkQPFMqBcgqUjSgwXNNjhfYcIFbF0ewKDfoQcxAucWVStfI/33UAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644263011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+2Lr9d9qHR05sofK1L6gRmeoW4SDlcmhBs2p6+5unzY=;
        b=tqjp5W7SLXHhL+7/7InwEQae83NyGcoKqnf64AdDtX9zW1j1+SP32XyV6LQI1bRpmTuefc
        /9+RuiKBj655JVCQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        David Sterba <dsterba@suse.com>,
        =?UTF-8?q?Samuel=20Iglesias=20Gons=C3=A1lvez?= 
        <siglesias@igalia.com>, Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        nick black <dankamongmen@gmail.com>
Subject: [PATCH printk v1 13/13] console: introduce CON_MIGHT_SLEEP for vt
Date:   Mon,  7 Feb 2022 20:49:23 +0106
Message-Id: <20220207194323.273637-14-john.ogness@linutronix.de>
In-Reply-To: <20220207194323.273637-1-john.ogness@linutronix.de>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
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

Deadlocks and the framebuffer console have been a recurring issue
that is getting worse. Daniel Vetter suggested [0] that
fbcon->write() should no longer be called from an atomic context.

Introduce a new console flag CON_MIGHT_SLEEP for a console driver to
specify that it is only called from sleepable contexts. Set the
fbcon to use this new flag.

[0] https://lore.kernel.org/all/YYuS1uNhxWOEX1Ci@phenom.ffwll.local

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/vt/vt.c     | 2 +-
 include/linux/console.h | 1 +
 kernel/printk/printk.c  | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 7359c3e80d63..ab4712cc9327 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3161,7 +3161,7 @@ static struct console vt_console_driver = {
 	.write		= vt_console_print,
 	.device		= vt_console_device,
 	.unblank	= unblank_screen,
-	.flags		= CON_PRINTBUFFER,
+	.flags		= CON_PRINTBUFFER|CON_MIGHT_SLEEP,
 	.index		= -1,
 };
 #endif
diff --git a/include/linux/console.h b/include/linux/console.h
index c51c7f5507a5..ea52c56b3ff8 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -138,6 +138,7 @@ static inline int con_debug_leave(void)
 #define CON_BRL		(32) /* Used for a braille device */
 #define CON_EXTENDED	(64) /* Use the extended output format a la /dev/kmsg */
 #define CON_PAUSED	(128) /* Sleep while console is locked */
+#define CON_MIGHT_SLEEP	(256) /* Can only be called from sleepable context */
 
 struct console {
 	char	name[16];
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 086155578f10..b92ef67a5aa2 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2836,6 +2836,8 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 
 			if (!console_is_usable(con))
 				continue;
+			if ((con->flags & CON_MIGHT_SLEEP) && !do_cond_resched)
+				continue;
 			any_usable = true;
 
 			if (con->flags & CON_EXTENDED) {
-- 
2.30.2

