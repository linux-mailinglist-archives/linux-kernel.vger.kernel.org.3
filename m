Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33C45973AC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240607AbiHQQK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241013AbiHQQKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:10:37 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7318A7F0A1;
        Wed, 17 Aug 2022 09:10:36 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x19so1302790plc.5;
        Wed, 17 Aug 2022 09:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=0w5leDnB9oITFRG2hBeGs/cY0LqF9F4f5ngXhRmBvoA=;
        b=b1IeAz0squDe+6l615WdkACq4EioqEHcrmbzFC8D4MNW5e68Ip3Dy8d05YiN/kUeTB
         kinEPW2ff5WzBQV39M2JOikWSmSBxOQNUB4Dabzc5h3d3dCFfsEejtCTE1Fr/IVALdDh
         xoMbF/J9Egn0X3Ew/hueK/z8Qvu2wrwI2rTmgGlXSdGupbwgwBK+Hzd+6SvPFgry3Iy3
         rA9G7Xl9K7i1llEA0b/2hcFvwrAHpFnB9enms3gdIDJSTvaIYnep8nZuZnNcb6wLlyQ3
         Ul1wjpN3Uz6zW9IUtvgcwTFHbPRd0doMQMyedsaY/NVohq5dk5+VBSI6w5ZVxMAnh4q6
         cazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=0w5leDnB9oITFRG2hBeGs/cY0LqF9F4f5ngXhRmBvoA=;
        b=cZPbCIP41g1lz5Abgcd6UmGe7FLgTAV+uCxS4ezHav6eSi+A8lyOr9N+R+TsSfwcug
         hnbHmLqMs7OeJJUET7Dmj1nqXlyplZBxWzfFLKnEklRbsnovFAlTPewvqF+5LtGZF5sd
         sUcaYpClWLYvW861Pmjkib5JNnEiB5JIJQl5ss22upTpwd21BzZPi8d+rOSY6tDl/zvO
         Am35jQxfqUrS69vPnTQviXvavUwftPSeVwnSdhCffa+0+A+tgbrMGbDhSuqXkgPtKt3v
         Us19p0izydYvyndMsCYaWt1nXknzpUkpDEiDlbUVxB/2ge4vcop0Zqt9yzbMn5lwkkRW
         ga4A==
X-Gm-Message-State: ACgBeo3Jbl9wyA8gKzM1Mz6B5Km3gj8CjeCuYaglShpYyHODkGj3KVHh
        Y1G/WBXXEdMUz3SlBz9VW3w=
X-Google-Smtp-Source: AA6agR7bLWJiCbr8SemRp/uA9NkzN4Nflo8rWCbGERFDYp+GuS6IK92hxYHxzM4TJSkt20/AYt0m8w==
X-Received: by 2002:a17:90a:c58e:b0:1f3:1ab5:22ae with SMTP id l14-20020a17090ac58e00b001f31ab522aemr4501736pjt.45.1660752635824;
        Wed, 17 Aug 2022 09:10:35 -0700 (PDT)
Received: from localhost ([36.112.203.167])
        by smtp.gmail.com with ESMTPSA id a15-20020aa795af000000b0052d5e93fcb7sm10658618pfk.191.2022.08.17.09.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 09:10:35 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     syzbot+ffe24b1afbc4cb5ae8fb@syzkaller.appspotmail.com
Cc:     linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, 18801353760@163.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        paskripkin@gmail.com, skhan@linuxfoundation.org,
        Hawkins Jiawei <yin31149@gmail.com>
Subject: [PATCH v2] reiserfs: add check in bin_search_in_dir_item()
Date:   Thu, 18 Aug 2022 00:10:28 +0800
Message-Id: <20220817161028.8027-1-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <000000000000bcbb0205e13dc53a@google.com>
References: <000000000000bcbb0205e13dc53a@google.com>
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

Syzkaller reports use-after-free Read as follows:
------------[ cut here ]------------
BUG: KASAN: use-after-free in bin_search_in_dir_item fs/reiserfs/namei.c:40 [inline]
BUG: KASAN: use-after-free in search_by_entry_key+0x81f/0x960 fs/reiserfs/namei.c:165
Read of size 4 at addr ffff8880715ee014 by task syz-executor352/3611

CPU: 0 PID: 3611 Comm: syz-executor352 Not tainted 5.19.0-rc1-syzkaller-00263-g1c27f1fc1549 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xeb/0x495 mm/kasan/report.c:313
 print_report mm/kasan/report.c:429 [inline]
 kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
 bin_search_in_dir_item fs/reiserfs/namei.c:40 [inline]
 search_by_entry_key+0x81f/0x960 fs/reiserfs/namei.c:165
 reiserfs_find_entry.part.0+0x139/0xdf0 fs/reiserfs/namei.c:322
 reiserfs_find_entry fs/reiserfs/namei.c:368 [inline]
 reiserfs_lookup+0x24a/0x490 fs/reiserfs/namei.c:368
 __lookup_slow+0x24c/0x480 fs/namei.c:1701
 lookup_one_len+0x16a/0x1a0 fs/namei.c:2730
 reiserfs_lookup_privroot+0x92/0x280 fs/reiserfs/xattr.c:980
 reiserfs_fill_super+0x21bb/0x2fb0 fs/reiserfs/super.c:2176
 mount_bdev+0x34d/0x410 fs/super.c:1367
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0001c57b80 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x715ee
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea0001c57bc8 ffff8880b9a403c0 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed

Memory state around the buggy address:
 ffff8880715edf00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880715edf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8880715ee000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                         ^
 ffff8880715ee080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880715ee100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================

The cause is that the value of rbound in bin_search_in_dir_item()
is out of bounds.

To be more specific, struct buffer_head's b_data field
contains the entry headers array, according to
set_de_item_location(). So the array's length should be less
than the size of b_data, or it may access the invalid memory.

This patch solves it by checking the array's size with b_data's size.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
v2:
  - rename subject from search_by_entry_key() to bin_search_in_dir_item()

 fs/reiserfs/namei.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
index 3d7a35d6a18b..c4c056ffafde 100644
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -33,7 +33,11 @@ static int bin_search_in_dir_item(struct reiserfs_dir_entry *de, loff_t off)
 	int rbound, lbound, j;
 
 	lbound = 0;
-	rbound = ih_entry_count(ih) - 1;
+	if (ih_location(ih) + ih_entry_count(ih) * IH_SIZE >=
+	    de->de_bh->b_size)
+		rbound = (de->de_bh->b_size - ih_location(ih)) / IH_SIZE - 1;
+	else
+		rbound = ih_entry_count(ih) - 1;
 
 	for (j = (rbound + lbound) / 2; lbound <= rbound;
 	     j = (rbound + lbound) / 2) {
-- 
2.25.1

