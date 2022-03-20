Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F16F4E1E44
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 00:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343804AbiCTXe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 19:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343795AbiCTXe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 19:34:28 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E224B432
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 16:33:04 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id j15so12666721eje.9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 16:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uQPiFqRvX0iU7YfpbfjC+ZQZO/1vgJtvlTW1i5LMQfI=;
        b=N4lLdI2eTNT69W+VOpf0og2roMUUSG0e3legL6kzP7zI0cJTtgG72ayQIx1CCOLn12
         G/t+jiMq3xAACOTSSCwp4LTYemk3GUCr4quK8SrHkkmMulOvhjs1hTXNAtn6juzVWQWY
         FJEoV54eTcq9zspzO0W/3HVH40eTo5s2gUWEdloMep1emF/syHpfsWuxxKRlwxlMwD7q
         cSMKuzJfCW0BEImurePDOBSMsGFIR4B1xOXoJE4fHE2jNOPEFlvykzHuzP89YVYZcdxF
         B+xCf95kdIhF1kIuXsZz9F64W1UCzZ5bjiv1b3NlInLBH3UTwV0swqwofWIqmqSdxdZS
         wT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uQPiFqRvX0iU7YfpbfjC+ZQZO/1vgJtvlTW1i5LMQfI=;
        b=GzlTfitMKlfQ0IDu+J//REl9zJDBEcNY+P8ihvuxxNdaTMZ+wntUWnmCARiS30YUd4
         i/UeO6i9bZoOeT3ViKEpBIrqE88AUgr9PXuLhAaJik30sC9Qaeuy6uzyDTNFS4IaQ64B
         OGiKJe16r5iUQE7FMLGS8cSISdDz0ZzkHpL/eDeQs6etDZSaNqGJwKwvoVC+nfQ5Wi7t
         evwnyQgJXCrVsf/87/tSuk2IWXXqlp8CvSKtF/xpSAKWDsmGB8rYqqCIWLCkWG2FFxme
         qfR6m9fQEKsdLS0j0Lm3IoMs1Ql/xahQKcCXSt6V9aTVGoHHD6Gl3XKl8a7fz0DgnjMk
         Ihvw==
X-Gm-Message-State: AOAM533Z9Q7Tl3xRPzOgOxrA8vFcqHBgguxl0yS3o1tlznVPWxafyfzK
        f9g/ax/6GDd+A3jdESS19K4=
X-Google-Smtp-Source: ABdhPJyNENV24sJ4WRKv+qoHRZVPKgp+PxUxyuDc7XTy1xCZrMLXGrhi0vynwWpAN0hPJVS05M9MTA==
X-Received: by 2002:a17:907:dab:b0:6df:e51a:b990 with SMTP id go43-20020a1709070dab00b006dfe51ab990mr6563985ejc.573.1647819182657;
        Sun, 20 Mar 2022 16:33:02 -0700 (PDT)
Received: from leap.localnet (host-87-20-105-171.retail.telecomitalia.it. [87.20.105.171])
        by smtp.gmail.com with ESMTPSA id r22-20020a17090638d600b006d584aaa9c9sm6205283ejd.133.2022.03.20.16.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 16:33:01 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     christophe.jaillet@wanadoo.fr, dhowells@redhat.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Cc:     syzbot <syzbot+d55757faa9b80590767b@syzkaller.appspotmail.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in __free_pages
Date:   Mon, 21 Mar 2022 00:32:57 +0100
Message-ID: <2238978.ElGaqSPkdT@leap>
In-Reply-To: <000000000000b1807c05daad8f98@google.com>
References: <000000000000b1807c05daad8f98@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart4703824.GXAFRqVoOG"
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

--nextPart4703824.GXAFRqVoOG
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
Let's test my diff...

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Fabio M. De Francesco

--nextPart4703824.GXAFRqVoOG
Content-Disposition: attachment; filename="diff"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="diff"

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 00703444a219..f2406b343a17 100644
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
@@ -254,7 +254,8 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 
 	for (i = 0; i < nr_pages; i++) {
 		pages[i] = alloc_page(GFP_KERNEL);
-		if (!pages[i])
+		allocated_pages = i + 1;
+		if (!pages[i]) {
 			goto error_p;
 		pages[i]->index = i * WATCH_QUEUE_NOTES_PER_PAGE;
 	}
@@ -271,7 +272,7 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 	return 0;
 
 error_p:
-	for (i = 0; i < nr_pages; i++)
+	for (i = 0; i < allocated_pages; i++)
 		__free_page(pages[i]);
 	kfree(pages);
 error:

--nextPart4703824.GXAFRqVoOG--



