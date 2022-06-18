Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D88E550178
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 02:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383783AbiFRArl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 20:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbiFRArj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 20:47:39 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1021C63C7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 17:47:39 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 193so2510474pgc.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 17:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jAq1OWKefq6Uf6mnDfJMitLNgK+QPvN0uQDkkiwg9A4=;
        b=dvsWPBgzkIabBMQ6PpwoFSIxmE/zGZQtcit2nkVuW6axlQ7nKKZUmp0jQtOJGsFsHf
         xBBOj+zNYHsrgX2tHbnk7RjbOLpudzgg9h/AZ1So1LLxQBaieaCsWxAO9QCOAgXVL+Ur
         WakgRDD5aY2+9pcT16hrGFHmBtcZ5bm6iFNLt6zyuxbe/Gg5zmedjy4RO9AISce3VnZ7
         RRK8nruaRTYCd8M1G3cep9njj0bMyXi78Rf8SIHkwgDVf04X6hhdPzKrVRRENWtAMLFY
         eU5ABXl4fWRbNOyBB7xkd1GKICGwTGiwLV+dkCYjlGk1JWZ38577zqXHvcbYvE9byj8i
         ztXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jAq1OWKefq6Uf6mnDfJMitLNgK+QPvN0uQDkkiwg9A4=;
        b=g7oVl8LGXXKjVt5bnzUGWQXyN999KyaBlmuDkKoLxCvbNFvm8JEdoQXpFKLMhV10Ma
         jnYKPysk9aIczD5SeFTAtJS3qpqUOW0MiJKleooKc0Buv05hvnIZBoJ9Q8nOlX6YuUbo
         mDo4/lmFyW7AmoAs89XacKsOU/I9HaKgLsDHfB0lZWZyUc1qG1Ip8pBuIr5ngSimMugR
         OC4XceJRk9bnq7YaM5MaIWhGgBgZGP6q00IzSX9S0E2ejFQI2J41ZkJCWFTMDoSw55HN
         qzzHWZ0Anwa3zF1BIzZGWKmd6tVgXRk9ESjFAD04S1q30fJP2Bqt2LPZEQ5KXmyErDHa
         5sHw==
X-Gm-Message-State: AJIora/p8uhr8GhvghnBBuIUdQsCf2Biy6vy+thf0TBbJBESc/qc88xq
        MuJoTxv+x6izzRAajJXsVUg=
X-Google-Smtp-Source: AGRyM1vGGwXGS75rbw/4GKiK2NGssYitd1RTX5wepPhPrBlPkhAMP3i/JqQSELQxTkHOUB0c5ItQyA==
X-Received: by 2002:a63:914b:0:b0:3fc:f8b2:d947 with SMTP id l72-20020a63914b000000b003fcf8b2d947mr11239602pge.491.1655513258571;
        Fri, 17 Jun 2022 17:47:38 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id p48-20020a056a0026f000b0050dc7628184sm4376827pfw.94.2022.06.17.17.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 17:47:37 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [mm-unstable PATCH] mm: thp: fix hugepage_vma_check() for gate vma
Date:   Fri, 17 Jun 2022 17:47:36 -0700
Message-Id: <20220618004736.1235352-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The syzbot reported the below issue:

BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:71 [inline]
BUG: KASAN: null-ptr-deref in test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
BUG: KASAN: null-ptr-deref in hugepage_vma_check+0x8e/0x750 mm/huge_memory.c:82
Read of size 8 at addr 00000000000005a8 by task syz-executor.5/21978

CPU: 0 PID: 21978 Comm: syz-executor.5 Not tainted 5.19.0-rc2-next-20220616-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 kasan_report+0xbe/0x1f0 mm/kasan/report.c:495
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
 hugepage_vma_check+0x8e/0x750 mm/huge_memory.c:82
 show_smap+0x1c6/0x470 fs/proc/task_mmu.c:866
 traverse.part.0+0xcf/0x5f0 fs/seq_file.c:111
 traverse fs/seq_file.c:101 [inline]
 seq_read_iter+0x90f/0x1280 fs/seq_file.c:195
 seq_read+0x337/0x4b0 fs/seq_file.c:162
 do_loop_readv_writev fs/read_write.c:763 [inline]
 do_loop_readv_writev fs/read_write.c:750 [inline]
 do_iter_read+0x4f8/0x750 fs/read_write.c:805
 vfs_readv+0xe5/0x150 fs/read_write.c:923
 do_preadv fs/read_write.c:1015 [inline]
 __do_sys_preadv fs/read_write.c:1065 [inline]
 __se_sys_preadv fs/read_write.c:1060 [inline]
 __x64_sys_preadv+0x22b/0x310 fs/read_write.c:1060
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f5c1d889109
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5c1ea69168 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00007f5c1d99bf60 RCX: 00007f5c1d889109
RDX: 0000000000000001 RSI: 00000000200006c0 RDI: 0000000000000005
RBP: 00007f5c1d8e305d R08: 0000000000000000 R09: 0000000000000000
R10: 00000000fffffffe R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd8514b43f R14: 00007f5c1ea69300 R15: 0000000000022000

The mm of the vma returned by smaps is NULL.  But it seems impossible
for normal vma since the mm is pinned before reaching hugepage_vma_check()
unless the vma is gate vma.

The gate vma doesn't have valid mm, but its size is PAGE_SIZE so the old
code (checking vma size first) did return before dereferencing mm.  So
move vma size check to the top to make sure it returns for gate vma
before dereferencing mm.

Reported-by: syzbot+4d875b4d2e2b60bae9b4@syzkaller.appspotmail.com
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/huge_memory.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2e2a8b5bc567..8e4ebd155ec6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -73,6 +73,20 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
 			unsigned long vm_flags,
 			bool smaps, bool in_pf)
 {
+	/*
+	 * Check alignment for file vma and size for both file and anon vma.
+	 *
+	 * Call this before touching mm since gate vma may be met by smaps,
+	 * which doesn't have valid mm. The size of gate vma is PAGE_SIZE so
+	 * it will just return here.
+	 *
+	 * Skip the check for page fault. Huge fault does the check in fault
+	 * handlers. And this check is not suitable for huge PUD fault.
+	 */
+	if (!in_pf &&
+	    !transhuge_vma_suitable(vma, (vma->vm_end - HPAGE_PMD_SIZE)))
+		return false;
+
 	/*
 	 * Explicitly disabled through madvise or prctl, or some
 	 * architectures may disable THP for some mappings, for
@@ -99,16 +113,6 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
 	if (vm_flags & VM_NO_KHUGEPAGED)
 		return false;
 
-	/*
-	 * Check alignment for file vma and size for both file and anon vma.
-	 *
-	 * Skip the check for page fault. Huge fault does the check in fault
-	 * handlers. And this check is not suitable for huge PUD fault.
-	 */
-	if (!in_pf &&
-	    !transhuge_vma_suitable(vma, (vma->vm_end - HPAGE_PMD_SIZE)))
-		return false;
-
 	/*
 	 * Enabled via shmem mount options or sysfs settings.
 	 * Must be done before hugepage flags check since shmem has its
-- 
2.26.3

