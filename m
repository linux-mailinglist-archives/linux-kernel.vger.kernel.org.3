Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11F35A752B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 06:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiHaEdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 00:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiHaEdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 00:33:00 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D445856BA1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 21:32:58 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id t5so13082939pjs.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 21:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=2wlBh69S5T/T9iHDDZDeIpM5ED2QS1+ze35Ex3GUlR0=;
        b=o2TG8IsxTiiSRyA/cXmZzMuPYEhOc3r6wd8+sqOV/QUv03LK0j0VlHggIdLyZVjJqY
         EO8mbEd6RIEQ1FLDgCBu4L/9xr7vk6FBOxiLQImGE38nmwAgJUdn9F/2gnKya5qb4EdZ
         wi6Xp/Y6C2lqFEfBBMw+2hKLv85uG8XZ+ATCrzj3t/v5P6AMpWW2xoi0VLbq7Lt1l72T
         pO1QgEyNKpe+Sz7gDdEXr6Yahuo6MOEu3CLyBwJJD0970fPhMAdTaNRQ7bXgUMdg3Cfd
         qX/pqVc2ww5lGgbl8htr+PasTuHynxAoS8oqg0xdS4mxCZHff07DTIKiSb3GtLJywmkz
         kQAg==
X-Gm-Message-State: ACgBeo1n8N1QKkJkqsaX+zqNmegXGTmW942k02N60FU1SiJ9uhNLXpcR
        0gwEYR61mOUKN9/3xq7u2KQ=
X-Google-Smtp-Source: AA6agR6GYEh50FxwD7XiaLAuWExdR2R2U+/5DGkH1XMXjpl7KZVFqoEFwzIayr/3o6De0oNi4lzmTA==
X-Received: by 2002:a17:90a:6b0d:b0:1fa:c6fe:db6 with SMTP id v13-20020a17090a6b0d00b001fac6fe0db6mr1382049pjj.99.1661920378185;
        Tue, 30 Aug 2022 21:32:58 -0700 (PDT)
Received: from karthik-strix-linux.karthek.com ([117.241.13.19])
        by smtp.gmail.com with ESMTPSA id d11-20020a62f80b000000b0053624c50d74sm10208149pfh.126.2022.08.30.21.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 21:32:57 -0700 (PDT)
Date:   Wed, 31 Aug 2022 10:02:51 +0530
From:   Karthik Alapati <mail@karthek.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     =ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] fs/ntfs3: fix memory leak in put_ntfs()
Message-ID: <Yw7kc+eNDImk7+w+@karthik-strix-linux.karthek.com>
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

