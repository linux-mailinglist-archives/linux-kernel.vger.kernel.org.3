Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6347B5A37FD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 15:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbiH0Nrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 09:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiH0Nrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 09:47:41 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5493E2E9DB
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 06:47:40 -0700 (PDT)
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 27RDlNSJ032657;
        Sat, 27 Aug 2022 22:47:23 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Sat, 27 Aug 2022 22:47:23 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 27RDlNUK032654
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 27 Aug 2022 22:47:23 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <2110618e-57f0-c1ce-b2ad-b6cacef3f60e@I-love.SAKURA.ne.jp>
Date:   Sat, 27 Aug 2022 22:47:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: [PATCH] tty: n_gsm: initialize more members at gsm_alloc_mux()
Content-Language: en-US
To:     Daniel Starke <daniel.starke@siemens.com>
References: <0000000000008be58e05e5b5d971@google.com>
 <000000000000434f7a05e5bab1ce@google.com>
Cc:     syzbot <syzbot+cf155def4e717db68a12@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000434f7a05e5bab1ce@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is reporting use of uninitialized spinlock at gsmld_write() [1], for
commit 32dd59f96924f45e ("tty: n_gsm: fix race condition in gsmld_write()")
allows accessing gsm->tx_lock before gsm_activate_mux() initializes it.

Since object initialization should be done right after allocation in order
to avoid accessing uninitialized memory, move initialization of
timer/work/waitqueue/spinlock from gsmld_open()/gsm_activate_mux() to
gsm_alloc_mux().

Link: https://syzkaller.appspot.com/bug?extid=cf155def4e717db68a12 [1]
Reported-by: syzbot <syzbot+cf155def4e717db68a12@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Tested-by: syzbot <syzbot+cf155def4e717db68a12@syzkaller.appspotmail.com>
Fixes: 32dd59f96924f45e ("tty: n_gsm: fix race condition in gsmld_write()")
---
 drivers/tty/n_gsm.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index caa5c14ed57f..70cd90474679 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2501,13 +2501,6 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
 	if (dlci == NULL)
 		return -ENOMEM;
 
-	timer_setup(&gsm->kick_timer, gsm_kick_timer, 0);
-	timer_setup(&gsm->t2_timer, gsm_control_retransmit, 0);
-	INIT_WORK(&gsm->tx_work, gsmld_write_task);
-	init_waitqueue_head(&gsm->event);
-	spin_lock_init(&gsm->control_lock);
-	spin_lock_init(&gsm->tx_lock);
-
 	if (gsm->encoding == 0)
 		gsm->receive = gsm0_receive;
 	else
@@ -2612,6 +2605,12 @@ static struct gsm_mux *gsm_alloc_mux(void)
 	kref_init(&gsm->ref);
 	INIT_LIST_HEAD(&gsm->tx_ctrl_list);
 	INIT_LIST_HEAD(&gsm->tx_data_list);
+	timer_setup(&gsm->kick_timer, gsm_kick_timer, 0);
+	timer_setup(&gsm->t2_timer, gsm_control_retransmit, 0);
+	INIT_WORK(&gsm->tx_work, gsmld_write_task);
+	init_waitqueue_head(&gsm->event);
+	spin_lock_init(&gsm->control_lock);
+	spin_lock_init(&gsm->tx_lock);
 
 	gsm->t1 = T1;
 	gsm->t2 = T2;
@@ -2946,10 +2945,6 @@ static int gsmld_open(struct tty_struct *tty)
 
 	gsmld_attach_gsm(tty, gsm);
 
-	timer_setup(&gsm->kick_timer, gsm_kick_timer, 0);
-	timer_setup(&gsm->t2_timer, gsm_control_retransmit, 0);
-	INIT_WORK(&gsm->tx_work, gsmld_write_task);
-
 	return 0;
 }
 
-- 
2.34.1

