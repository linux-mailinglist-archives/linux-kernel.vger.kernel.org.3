Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BD95A64B4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiH3N2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiH3N2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:28:11 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367F37C515
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 06:28:08 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e20so14197065wri.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 06:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=7eOmG5vcgALD3xxGHVQOGIIFAg+EgIFM/dlzoVfn8rQ=;
        b=QKGDnenslUbWmPPpf11gnGkmnxe8BVqYH0efG1f2Sdw4stxWv2lRtb8uaBwUTGfYTt
         7quE8IXBMOuZpUjyymsHXMCDe5gRecszqJzedaqfPL/STN5Sj1l49bmU4mvaW2ac3UdF
         v8OW73wJ6TFJCh5IGSLvSWlW83823xxwRbWRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=7eOmG5vcgALD3xxGHVQOGIIFAg+EgIFM/dlzoVfn8rQ=;
        b=QdHnvgnJT63Nqg0Q5GkHINUaRtAtYRFy/BWsWa5ZehSeJ24vJDINfkYtFiWAf5B3V7
         cQ7jPHpBQtQDhRyiMyAeIFrQVnn5GnG932GA+PtGbORjwymzFLchTdq9MNOxpNR2J1UX
         m/aEgNEGTdxbh2C8l8pupvJQEvvK9Jxjo8NVOIi+1Do5IOr2nkeJmSSHPdNJ7Dw7QchY
         YstxbfLAOaFJ7pCno9bdHpwFYkJp/2bBXC8xbejFuqdGlx8lySWOFCn/mjx6IkMW/OQT
         6du04ONLG+rZdqCbTDcVljXjUkQVGRbPdcNZUagWfL0FMXBrq5SHL1KyQjaEc8gUAG7r
         SG4g==
X-Gm-Message-State: ACgBeo39eoOl/EM0mSMMtIufHL7c9mk+R6EwIu4jdwgNNmog86i7JTTY
        sOv5dB5EJe2ztHutC5c5l36++c9LEWAuGLN3
X-Google-Smtp-Source: AA6agR477dMcOubNMYR/wO4xxpwExASouvgABXv7EB3T+fC45Rmi0jPuJCYpMWoJi533oCCyIPLqnw==
X-Received: by 2002:a5d:4948:0:b0:226:d8c6:ba35 with SMTP id r8-20020a5d4948000000b00226d8c6ba35mr6106803wrs.155.1661866087317;
        Tue, 30 Aug 2022 06:28:07 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b2-20020adff902000000b00226dfac0149sm3558658wrr.114.2022.08.30.06.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 06:28:06 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>,
        Yangxi Xiang <xyangxi5@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        nick black <dankamongmen@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] tty/vt: Add console_lock check to vt_console_print()
Date:   Tue, 30 Aug 2022 15:28:03 +0200
Message-Id: <20220830132803.403744-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm scratching my head why we have this printing_lock. Digging through
historical git trees shows that:
- Added in 1.1.73, and I found absolutely no reason why.
- Converted to atomic bitops in 2.1.125pre2, I guess as part of SMP
  enabling/bugfixes.
- Converted to a proper spinlock in b0940003f25d ("vt: bitlock fix")
  because the hand-rolled atomic version lacked necessary memory
  barriers.

Digging around in lore for that time period did also not shed further
light.

The only reason I think this might still be relevant today is that (to
my understanding at least, ymmv) during an oops we might be printing
without console_lock held. See console_flush_on_panic() and the
comments in there - we flush out the console buffers irrespective of
whether we managed to acquire the right locks.

The strange thing is that this reason is fairly recent, because the
console flushing was historically done without oops_in_progress set.
This only changed in c7c3f05e341a ("panic: avoid deadlocks in
re-entrant console drivers"), which removed the call to
bust_spinlocks(0) (which decrements oops_in_progress again) before
flushing out the console (which back then was open coded as a
console_trylock/unlock pair).

Note that this entire mess should be properly fixed in the
printk/console layer, and not inflicted on each implementation.

For now just document what's going on and check that in all other
cases callers obey the locking rules.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
Cc: Yangxi Xiang <xyangxi5@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: nick black <dankamongmen@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Sam Ravnborg <sam@ravnborg.org>
--
Note that this applies on top of my earlier vt patch:

https://lore.kernel.org/lkml/20220826202419.198535-1-daniel.vetter@ffwll.ch/

Expect more, I'm digging around in here a bit ...
-Daniel
---
 drivers/tty/vt/vt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 4d29e4a17db7..54399dcc334e 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3083,7 +3083,10 @@ static void vt_console_print(struct console *co, const char *b, unsigned count)
 	ushort start_x, cnt;
 	int kmsg_console;
 
-	/* console busy or not yet initialized */
+	if (!oops_in_progress)
+		WARN_CONSOLE_UNLOCKED();
+
+	/* this protects against concurrent oops only */
 	if (!spin_trylock(&printing_lock))
 		return;
 
-- 
2.37.2

