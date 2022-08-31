Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AE65A752D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 06:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbiHaEef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 00:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiHaEec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 00:34:32 -0400
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566A8A74CC
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 21:34:32 -0700 (PDT)
Received: by mail-pg1-f169.google.com with SMTP id q9so12510138pgq.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 21:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=2wlBh69S5T/T9iHDDZDeIpM5ED2QS1+ze35Ex3GUlR0=;
        b=tL/vMYZvB8ACo4GUIU5VFPZLIjFGYchlvn6fmxISYrxfl49fvaNzRE46TZgCuHPvwT
         3wVZcVOrUoUU8qe2yt3yq++nl3pP7b1JBmmeotP7NX7oC+0SvGYmejFeNaub8/c66mKv
         RMQgmpZpdCBKXvWdw3NZg3372rfxVR97l5y3yk046Y07r9zLiYjJSJDNrD7YEJM8Wvag
         6Uu15G4S6dAGlqQ37+NhoX+jP5C69v4ga8FWPa7t1wDNd/3GFCIieedw/9drej+UNf2m
         nhMp7/Yd3VmOpP9ROlPOPUjC/GIbpOypnGbzJrHrSEQ8NC2lYGjwbk7TBGJ0tOZxw7Pl
         N5uA==
X-Gm-Message-State: ACgBeo0ToeGdxhqXvdtcj5trjuF8hzuvj85ASWWt4gMvipWcpo0YW9w7
        PNh6R+oa1q7puyI2mM2UiSI=
X-Google-Smtp-Source: AA6agR4aRTLQgVsfv0pPYxAQbQfzQbA1lqOd5fp6MfoDJ0xxr78O1KzjwNP50pFkW8SiSA/HlkkMhA==
X-Received: by 2002:a63:8a44:0:b0:42b:351d:e309 with SMTP id y65-20020a638a44000000b0042b351de309mr20133305pgd.426.1661920471855;
        Tue, 30 Aug 2022 21:34:31 -0700 (PDT)
Received: from karthik-strix-linux.karthek.com ([117.241.13.19])
        by smtp.gmail.com with ESMTPSA id q16-20020a63e950000000b0041d6d37deb5sm107851pgj.81.2022.08.30.21.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 21:34:31 -0700 (PDT)
Date:   Wed, 31 Aug 2022 10:04:25 +0530
From:   Karthik Alapati <mail@karthek.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] fs/ntfs3: fix memory leak in put_ntfs()
Message-ID: <Yw7k0VQm+8l8JKWr@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

free options in put_ntfs() rather than in ntfs_put_super()

BUG: memory leak
unreferenced object 0xffff8881104f3720 (size 32):
  comm "syz-executor634", pid 3605, jiffies 4294945517 (age 12.630s)
  hex dump (first 32 bytes):
    e0 36 4f 10 81 88 ff ff 80 57 e1 85 ff ff ff ff  .6O......W......
    00 00 00 00 00 00 00 00 c0 ff c0 ff 00 00 00 00  ................
  backtrace:
    [<ffffffff81b23ef2>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff81b23ef2>] kzalloc include/linux/slab.h:733 [inline]
    [<ffffffff81b23ef2>] ntfs_init_fs_context+0x22/0x1e0 fs/ntfs3/super.c:1397
    [<ffffffff81650045>] alloc_fs_context+0x225/0x3b0 fs/fs_context.c:290
    [<ffffffff8162bed3>] do_new_mount fs/namespace.c:3025 [inline]
    [<ffffffff8162bed3>] path_mount+0x6f3/0x10d0 fs/namespace.c:3370
    [<ffffffff8162cffe>] do_mount fs/namespace.c:3383 [inline]
    [<ffffffff8162cffe>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff8162cffe>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff8162cffe>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
    [<ffffffff845e4855>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845e4855>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff8881104f36e0 (size 32):
  comm "syz-executor634", pid 3605, jiffies 4294945517 (age 12.630s)
  hex dump (first 32 bytes):
    6d 61 63 63 79 72 69 6c 6c 69 63 00 00 00 00 00  maccyrillic.....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814c5b1d>] kmemdup_nul+0x2d/0x70 mm/util.c:152
    [<ffffffff8164f66e>] vfs_parse_fs_string+0x6e/0xd0 fs/fs_context.c:178
    [<ffffffff8164f7b0>] generic_parse_monolithic+0xe0/0x130 fs/fs_context.c:224
    [<ffffffff8162c374>] do_new_mount fs/namespace.c:3036 [inline]
    [<ffffffff8162c374>] path_mount+0xb94/0x10d0 fs/namespace.c:3370
    [<ffffffff8162cffe>] do_mount fs/namespace.c:3383 [inline]
    [<ffffffff8162cffe>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff8162cffe>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff8162cffe>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
    [<ffffffff845e4855>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845e4855>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

Link: https://syzkaller.appspot.com/bug?id=332ba47915d0e39e94b42a622f195f0804ecb67f
Reported-by: syzbot+9d67170b20e8f94351c8@syzkaller.appspotmail.com
Signed-off-by: Karthik Alapati <mail@karthek.com>
---
 fs/ntfs3/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 47012c9bf505..ffb76a5bfd4f 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -439,6 +439,7 @@ static void init_once(void *foo)
  */
 static noinline void put_ntfs(struct ntfs_sb_info *sbi)
 {
+	put_mount_options(sbi->options);
 	kfree(sbi->new_rec);
 	kvfree(ntfs_put_shared(sbi->upcase));
 	kfree(sbi->def_table);
@@ -482,7 +483,6 @@ static void ntfs_put_super(struct super_block *sb)
 	/* Mark rw ntfs as clear, if possible. */
 	ntfs_set_state(sbi, NTFS_DIRTY_CLEAR);
 
-	put_mount_options(sbi->options);
 	put_ntfs(sbi);
 	sb->s_fs_info = NULL;
 
-- 
2.37.2

