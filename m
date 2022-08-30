Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5965A669C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 16:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiH3Otz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 10:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiH3Otw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 10:49:52 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDFC2613
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 07:49:51 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b16so6928673wru.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 07:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=kZOaD1B8emphOfywTXzw4uigM54srkRRmu9c5V6NK1A=;
        b=TYS4YvSN1AwESNxvEaaENxBSTEIASwZ0luttSQjo1X3Lce5ydRuQLu3JwlKvSpKDYs
         sd0pjW75BkM1hAar8lrW/TM+TVp5OuMrI10WEFguN+TskyaUZcGI1+8MdEPQsnv1sGPt
         dk283ZnDDTzZjOJq1v0fp6N0Vk60Vx6K3z/Zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=kZOaD1B8emphOfywTXzw4uigM54srkRRmu9c5V6NK1A=;
        b=m8LbZ/ZJjcTG31Q91Zax17LMl+274HckrMt6num4Zv+bav6xQN6nZqEf+udPv0+lsa
         CMTbsdOW+0y/i9velC3Wj+jNaJ8lnWjjqSmhaMDob4NYeHWEMfb2wqAzLgYSI2kbOpmj
         9vH+/5+OjCxxjb2wD/ffsoJYqClvGIGbmJIOltQHlN3ArkWYbF+T6Y7lZylIliSpgBy6
         4EOacnMsJG29cTlhtU6GaV8k+/IOtkyPl7lYExuujZmaxkpo4woBbAMRI8e/cxw9pYXC
         ofYu/rEWdxenomuaQqQbIf2lo5dibd/YcXK6afEgBesc+2Diffs6o2gpAszK0RK4wsVg
         Gw7A==
X-Gm-Message-State: ACgBeo2dBC7Wh2SylrnepFNDeQS8KN7WFkWYBe3E5afT7sPahQb35PA0
        fqc5BTzUBTZ4UypNA9QVgNrjSH9UWQxC0jB1
X-Google-Smtp-Source: AA6agR7IMUCFZ3dgjIQVl3c5wI9BXlutzG3Yq1jGBDzrat+5siYaeXaWXUU2UMfR7XiA2eFppONTFw==
X-Received: by 2002:a05:6000:81d:b0:226:dbad:1699 with SMTP id bt29-20020a056000081d00b00226dbad1699mr5622520wrb.212.1661870990105;
        Tue, 30 Aug 2022 07:49:50 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d4848000000b00226d01a4635sm9805359wrs.35.2022.08.30.07.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 07:49:49 -0700 (PDT)
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
Date:   Tue, 30 Aug 2022 16:49:45 +0200
Message-Id: <20220830144945.430528-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830132803.403744-1-daniel.vetter@ffwll.ch>
References: <20220830132803.403744-1-daniel.vetter@ffwll.ch>
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

v2: WARN_CONSOLE_UNLOCKED already checks for oops_in_progress
(something else that should be fixed I guess), hence remove the
open-coded check I've had.

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
 drivers/tty/vt/vt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 4d29e4a17db7..a6be32798fad 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3083,7 +3083,9 @@ static void vt_console_print(struct console *co, const char *b, unsigned count)
 	ushort start_x, cnt;
 	int kmsg_console;
 
-	/* console busy or not yet initialized */
+	WARN_CONSOLE_UNLOCKED();
+
+	/* this protects against concurrent oops only */
 	if (!spin_trylock(&printing_lock))
 		return;
 
-- 
2.37.2

