Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE144E1E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 00:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343825AbiCTXl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 19:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343817AbiCTXl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 19:41:56 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451C913EA1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 16:40:30 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id pv16so26868715ejb.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 16:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VdlG6mTj8V0qa6LW+EAb/nzlDL7H440Rv+RZPov6g8E=;
        b=D8f2R6OYZFLc6u7kMl3O3osy8Q8/t7i0WqHCl5rK2uB0Pg3xTLi8jrHQlGCu9c1VPs
         0Lgae+5Z/dXUcu3KYFcoV3QJbaxz3z+x1pQlaKyNKnAm+nHaUStG0cDQG8q9rHTiZoGG
         e3k62PTbZ2yJJl2VeP1aAPm5P4AJ6k6E91hZ+ER4H4D0jmPRYUTDKTf9dep0ybZaSi02
         VM9h6TQJrOeHRakr8DgXx4H3Kh5syYnl2qe+zANF2QJntE6Uwi6xFgyChXcinOM8EmW3
         fbr3llVfXHloYPQawY9LQpTGzHK1IK83agaQuPP7cBMvqh5KMhtfxXMSdX5RtY3ztLw9
         AIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VdlG6mTj8V0qa6LW+EAb/nzlDL7H440Rv+RZPov6g8E=;
        b=Cjz0InAom5aQtUne1axvv24rAt6uXjzsxL/3e3yyxNgRNm6APamGzcJT+1HZZ1e7MF
         HWvRjfsexGULVyqcD1cgeQkEqKXrU84etlAsfPp8AeOgq+SN9KhQ9usNTcFEPlqyoqDh
         FRb7f51Ui5P0elKCbkrzqsBIH6TZspu7VXwLCc1ZfyvKJCrbQD689b08Wlj2sHsGPTHc
         RCmc61yHqlcSv6EsK46NYHW/XRa9GIp9gpweWn2hXHsOD6eUsNih78dibmI0RqPIVSWM
         pVpAQrIOkhHwEANA9Hexm7Kiae4pcx6cWskNsjl1vqMtMtbbNq+4GUw5IRygwAXZh/nx
         rtPg==
X-Gm-Message-State: AOAM532SQ7cKLdxZtcuW3lfoTb4J0+1JooyHiG25MGCVp3VwDoKEJpTm
        4k7QTx5zJGXNYQ+BClxl8hc=
X-Google-Smtp-Source: ABdhPJyZIbOWqfvRr/p2+8vp0O14a0nOkIVoeA3h2CtwtPwvhQfdqmZ4Z6RKedJ6fX0OPK0E3ovpKw==
X-Received: by 2002:a17:906:2486:b0:6cf:ced9:e4cc with SMTP id e6-20020a170906248600b006cfced9e4ccmr18211883ejb.201.1647819629396;
        Sun, 20 Mar 2022 16:40:29 -0700 (PDT)
Received: from leap.localnet (host-87-20-105-171.retail.telecomitalia.it. [87.20.105.171])
        by smtp.gmail.com with ESMTPSA id sb31-20020a1709076d9f00b006ceb969822esm6190773ejc.76.2022.03.20.16.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 16:40:27 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     christophe.jaillet@wanadoo.fr, dhowells@redhat.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Cc:     syzbot <syzbot+d55757faa9b80590767b@syzkaller.appspotmail.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in __free_pages
Date:   Mon, 21 Mar 2022 00:40:26 +0100
Message-ID: <3165925.aeNJFYEL58@leap>
In-Reply-To: <000000000000b1807c05daad8f98@google.com>
References: <000000000000b1807c05daad8f98@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart3171984.44csPzL39Z"
Content-Transfer-Encoding: 7Bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart3171984.44csPzL39Z
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On domenica 20 marzo 2022 23:04:18 CET syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    56e337f2cf13 Revert "gpio: Revert regression in sysfs-gpio..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17e0a8c5700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d35f9bc6884af6c9
> dashboard link: https://syzkaller.appspot.com/bug?extid=d55757faa9b80590767b
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=134e4e91700000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=127bd083700000
> 
> Bisection is inconclusive: the issue happens on the oldest tested release.
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=138601c5700000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=104601c5700000
> console output: https://syzkaller.appspot.com/x/log.txt?x=178601c5700000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d55757faa9b80590767b@syzkaller.appspotmail.com
> 
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffc794ecea0 R14: 000000000000000d R15: 00007ff328525490
>  </TASK>
> ==================================================================
> BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:71 [inline]
> BUG: KASAN: null-ptr-deref in atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
> BUG: KASAN: null-ptr-deref in page_ref_count include/linux/page_ref.h:67 [inline]
> BUG: KASAN: null-ptr-deref in put_page_testzero include/linux/mm.h:717 [inline]
> BUG: KASAN: null-ptr-deref in __free_pages+0x1f/0x1b0 mm/page_alloc.c:5473
> Read of size 4 at addr 0000000000000034 by task syz-executor168/3599
> 
> CPU: 1 PID: 3599 Comm: syz-executor168 Not tainted 5.17.0-rc8-syzkaller-00003-g56e337f2cf13 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  __kasan_report mm/kasan/report.c:446 [inline]
>  kasan_report.cold+0x66/0xdf mm/kasan/report.c:459
>  check_region_inline mm/kasan/generic.c:183 [inline]
>  kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
>  instrument_atomic_read include/linux/instrumented.h:71 [inline]
>  atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
>  page_ref_count include/linux/page_ref.h:67 [inline]
>  put_page_testzero include/linux/mm.h:717 [inline]
>  __free_pages+0x1f/0x1b0 mm/page_alloc.c:5473
>  watch_queue_set_size+0x499/0x630 kernel/watch_queue.c:275
>  pipe_ioctl+0xac/0x2b0 fs/pipe.c:632
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:874 [inline]
>  __se_sys_ioctl fs/ioctl.c:860 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7ff3284b2d59
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 31 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc794ece38 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000031 RCX: 00007ff3284b2d59
> RDX: 0000000000000029 RSI: 0000000000005760 RDI: 0000000000000003
> RBP: 00007ffc794ece40 R08: 0000000000000001 R09: 00007ffc794e0035
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffc794ecea0 R14: 000000000000000d R15: 00007ff328525490
>  </TASK>
> ==================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
> 
> -- 
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000b1807c05daad8f98%40google.com.
> 
Sorry, left an open brace and compilation failed.
Let's try again...

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Fabio M. De Francesco

--nextPart3171984.44csPzL39Z
Content-Disposition: attachment; filename="diff"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="diff"

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 00703444a219..0e47c516714f 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -220,7 +220,7 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 	struct page **pages;
 	unsigned long *bitmap;
 	unsigned long user_bufs;
-	int ret, i, nr_pages;
+	int ret, i, nr_pages, allocated_pages;
 
 	if (!wqueue)
 		return -ENODEV;
@@ -254,6 +254,7 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 
 	for (i = 0; i < nr_pages; i++) {
 		pages[i] = alloc_page(GFP_KERNEL);
+		allocated_pages = i + 1;
 		if (!pages[i])
 			goto error_p;
 		pages[i]->index = i * WATCH_QUEUE_NOTES_PER_PAGE;
@@ -271,7 +272,7 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 	return 0;
 
 error_p:
-	for (i = 0; i < nr_pages; i++)
+	for (i = 0; i < allocated_pages; i++)
 		__free_page(pages[i]);
 	kfree(pages);
 error:

--nextPart3171984.44csPzL39Z--



