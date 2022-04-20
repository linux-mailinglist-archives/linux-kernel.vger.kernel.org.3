Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09405080ED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359496AbiDTGTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 02:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359480AbiDTGTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:19:08 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4870393DB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 23:16:23 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id s14so900970plk.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 23:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nrmZN1YGOXwt96xOgDckyKdEp0sX0UQnyV38Md8fDGs=;
        b=bHBqeh+CrW9h20RGBZXkWpQvf8YwJDwRfjQbGqhVknLEACTwHhEFaqmd+4l3Ptfxza
         EH+vqfFNLManK+QQZpss9gjUc5sa4qLUw58mojbTvaS0INZipA6XoRm/Ya7F4FtG7Wit
         Uyf2UqDky9RIWj9xOQdq/xcxbvdoPRvCbyR6D81bsw9ihcmPykjPgTGlB3UpVh7UYSXO
         L0KtEzQD8e3StZ862FvNcchsX569ksD90vwg3fFJCQk/TdPVzP8SnmiTfHqcoTE5+8n8
         574kbXlWpTmaISmD9nVClw4EETxiiNS1Gn++gl0sF7IFhWKNnxDA/FJYeilTaX2VXWAp
         ThDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nrmZN1YGOXwt96xOgDckyKdEp0sX0UQnyV38Md8fDGs=;
        b=GZeemRLiQZo7i4zfiDaxB4bdvR9X1iSNOHwTaqE7xqrtPS2CHRg8IJMFbGFcLupztm
         rE8p+U+uwywdLow6LoObK7d1G4VcCz2PBHx0S5a3gOY0wDzHKi8+w4gEVJ+wEWDs8wBd
         5HFgQidLNQ/KyUWn3ecYMLVDzoE0YlagdNrmXfD2Gxbf3RZK+vxg4hjhV6mCLS+BX93b
         Glxyo3mjAXrCJpduTvKqy/gsA2a+iW1aUYKWcoFa6Jm9l6lPFqr4VPY/madXkk0pSIX8
         8dpBRXc+4CfyXk4DhCjxIwrsEB3Yc89AwVxGhxAwPeO+YTor1KQQ916M7d1R+qkd4EET
         hd9g==
X-Gm-Message-State: AOAM53331hKhhtk0Ix1mnww30F7RsSmFMMfCmmvIw2Qal9P8SPdH6nU7
        LVavA02pjcnHYUany/DLTTc=
X-Google-Smtp-Source: ABdhPJzsrUQ6zA4RClsX41beCZK8xWPN5bmsPvGtAMLQAsLGHZDSBcFO1TBTgkG8has8I8lBOqtAkw==
X-Received: by 2002:a17:90b:4d86:b0:1d2:cd59:d275 with SMTP id oj6-20020a17090b4d8600b001d2cd59d275mr2589745pjb.119.1650435383187;
        Tue, 19 Apr 2022 23:16:23 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:daec:60d:88f6:798a])
        by smtp.gmail.com with ESMTPSA id k22-20020aa790d6000000b0050a765d5d48sm9798778pfk.160.2022.04.19.23.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 23:16:22 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Duoming Zhou <duoming@zju.edu.cn>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 2/3] arch: xtensa: platforms: Fix deadlock in rs_close()
Date:   Tue, 19 Apr 2022 23:16:10 -0700
Message-Id: <20220420061611.4103443-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220420061611.4103443-1-jcmvbkbc@gmail.com>
References: <20220420061611.4103443-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Duoming Zhou <duoming@zju.edu.cn>

There is a deadlock in rs_close(), which is shown
below:

   (Thread 1)              |      (Thread 2)
                           | rs_open()
rs_close()                 |  mod_timer()
 spin_lock_bh() //(1)      |  (wait a time)
 ...                       | rs_poll()
 del_timer_sync()          |  spin_lock() //(2)
 (wait timer to stop)      |  ...

We hold timer_lock in position (1) of thread 1 and
use del_timer_sync() to wait timer to stop, but timer handler
also need timer_lock in position (2) of thread 2.
As a result, rs_close() will block forever.

This patch deletes the redundant timer_lock in order to
prevent the deadlock. Because there is no race condition
between rs_close, rs_open and rs_poll.

Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Message-Id: <20220407154430.22387-1-duoming@zju.edu.cn>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/platforms/iss/console.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
index 81d7c7e8f7e9..10b79d3c74e0 100644
--- a/arch/xtensa/platforms/iss/console.c
+++ b/arch/xtensa/platforms/iss/console.c
@@ -36,24 +36,19 @@ static void rs_poll(struct timer_list *);
 static struct tty_driver *serial_driver;
 static struct tty_port serial_port;
 static DEFINE_TIMER(serial_timer, rs_poll);
-static DEFINE_SPINLOCK(timer_lock);
 
 static int rs_open(struct tty_struct *tty, struct file * filp)
 {
-	spin_lock_bh(&timer_lock);
 	if (tty->count == 1)
 		mod_timer(&serial_timer, jiffies + SERIAL_TIMER_VALUE);
-	spin_unlock_bh(&timer_lock);
 
 	return 0;
 }
 
 static void rs_close(struct tty_struct *tty, struct file * filp)
 {
-	spin_lock_bh(&timer_lock);
 	if (tty->count == 1)
 		del_timer_sync(&serial_timer);
-	spin_unlock_bh(&timer_lock);
 }
 
 
@@ -73,8 +68,6 @@ static void rs_poll(struct timer_list *unused)
 	int rd = 1;
 	unsigned char c;
 
-	spin_lock(&timer_lock);
-
 	while (simc_poll(0)) {
 		rd = simc_read(0, &c, 1);
 		if (rd <= 0)
@@ -87,7 +80,6 @@ static void rs_poll(struct timer_list *unused)
 		tty_flip_buffer_push(port);
 	if (rd)
 		mod_timer(&serial_timer, jiffies + SERIAL_TIMER_VALUE);
-	spin_unlock(&timer_lock);
 }
 
 
-- 
2.30.2

