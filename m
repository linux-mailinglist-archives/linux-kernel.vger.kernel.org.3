Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D30B4E1E81
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 01:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244087AbiCUA3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 20:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbiCUA3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 20:29:36 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291B61AD9E
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 17:28:12 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id qa43so26799431ejc.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 17:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aCTf8n9H9nq25dWu8V2vUoF9tag+6oTRBAzmjV9SkuE=;
        b=K/0MonxU92qnmpeXdgBVu8Uh0a1tMXBlQVro3ZK2voLfGnN7xPJTJsAJaIwwH6mB2H
         kSESTYjWKI45F1qtpmebSrEt1a9ms0WcROkDQQKBcfueo/dXtjp0Ib4nB0SUSmqP81CU
         wmo1vTGYjb0lKjSp5VIFbUNbLqT8j6b2U6hSm/xCr8krjUobnCe3Yh6lhliVFLc2lus8
         RBiPalaGsyJCKP286ued3V9IhF8YT/S5btnWc1dIKAavutlZQVpPX0aOOeLVsm7zTfq4
         PqSyE4rrax+p2ZysOlbS/YPBEMW3OitXzLk4AZ1Mzz7JJ0EOFm8kgIjEXzTmkH4yS/WH
         JlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aCTf8n9H9nq25dWu8V2vUoF9tag+6oTRBAzmjV9SkuE=;
        b=n+AgVae9jO+V+5mJHy9ra0FlV8Xnrd4HotJlRWnc+321qrpnRiA82ZEfNbwjodslMc
         LCow6G+xgJCeCaLdIzXosv/eWqQrXToGJefWOBRolSLX26yD1lwJkemfGL5nNCESO6Yz
         iPtkAUD+IjF3N1rBe9mlMGyOCtjugXzJvDcvMfmd8GryViCEHiTHSGuSKG0HNwlQrHWF
         rU3wm7P44AFbdedNBKk53QSsmGh8UJts+ewl2ClEjGoqcXPzhdKC1vIDl4uuVGVip4hw
         nxlepx3ihgTIW5ib5o08pOoN4f61xgP8mi9BuS9vFP9lpriFMoNksPb9mFqb1QxX/WE5
         7QYg==
X-Gm-Message-State: AOAM531nk7j47WYjWC86pAiSrm1wqNAEAjRND80UeTBeBZ6Knp6JJo16
        h387o6JJxPR3vQy6S2/5UrQ=
X-Google-Smtp-Source: ABdhPJyUsD4gBFjn9CVZWOmbnFNoFniccGuh6bMf1C0U2q2kCBTsEtwLdJCH232zBkVgeuuY9qiHCQ==
X-Received: by 2002:a17:906:1153:b0:6df:d816:264a with SMTP id i19-20020a170906115300b006dfd816264amr7296392eja.546.1647822490564;
        Sun, 20 Mar 2022 17:28:10 -0700 (PDT)
Received: from leap.localnet (host-87-20-105-171.retail.telecomitalia.it. [87.20.105.171])
        by smtp.gmail.com with ESMTPSA id d7-20020a50cd47000000b004187eacb4d6sm7232513edj.37.2022.03.20.17.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 17:28:09 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     christophe.jaillet@wanadoo.fr, dhowells@redhat.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Cc:     syzbot <syzbot+d55757faa9b80590767b@syzkaller.appspotmail.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in __free_pages
Date:   Mon, 21 Mar 2022 01:28:07 +0100
Message-ID: <1821968.CQOukoFCf9@leap>
In-Reply-To: <000000000000b1807c05daad8f98@google.com>
References: <000000000000b1807c05daad8f98@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart22582093.6Emhk5qWAg"
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

--nextPart22582093.6Emhk5qWAg
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
Probably I'm missing something, but I want to try once more...

The argument I follow is that when, in the "error_p" label, the code 
frees the pages, it frees in a loop from pages[0] to pages[nr_pages -1].
Thus I saw that when pages[i] are allocated at line 256 by a call to 
alloc_page() and this allocation fails it jumps to the "error_p" label
without saving and using the number of successful allocations as a limit
of the loop that calls __free_pages().

As I said, perhaps I'm missing something deeper but I noticed that in my
diff I assigned "allocated_pages" with "i + 1" and probably I'm still 
going off by one.

Let's try the last time...

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Thanks,

Fabio M. De Francesco

--nextPart22582093.6Emhk5qWAg
Content-Disposition: attachment; filename="diff"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="diff"

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 00703444a219..5b0531020cf8 100644
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
+		allocated_pages = i;
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

--nextPart22582093.6Emhk5qWAg--



