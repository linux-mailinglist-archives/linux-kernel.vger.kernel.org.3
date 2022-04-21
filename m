Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD8350AA63
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 22:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392597AbiDUU4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 16:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392581AbiDUU4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:56:34 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D2F4EA15
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 13:53:44 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id w1so10798154lfa.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 13:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QMaXVrKk9gfumVTRL9xZxvAh+Uev5F5t1NCU2kpSj9Y=;
        b=JgY2opUF0mU6jJmGtfHvRgRMwUOhHike+V7WS9GYAJv9FeWiJLS9GaHBurVKfTpigk
         wN8dPahuZhpq23Et8iKWCKhJXFl3aTuSWePFXPAscZb6bO/gDWg1dM4wwl7qRy5PLuCx
         2voGTpg1P1uhNu4AMkX31N0ZJApoQiBqclQF166RqDTxK6AE5JvYsBZJ4YY0VNXx4nDc
         CBfFo/Te5JGq4nk95zBSjhH8graeObWF02JcqVfHXd1l53flgQbqjxmqBKMi4iwab9LP
         4vMeqWEXhojruavaihjE5vGLmUcKtdUfX4o4C7LG8cjM2F6I3J0E2GrJ/4vNTbCTE25H
         4NCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QMaXVrKk9gfumVTRL9xZxvAh+Uev5F5t1NCU2kpSj9Y=;
        b=B7AIrWGOs7Vdrw0tNGEmNgJHciR+9dS/VlZ+R3Zy0KcJtJpoYr+Du51fnen9MZEhB3
         OmsxGxs9PWaLtcRArlvuCmpGNVk5PgoHTE9S5TH65hjnU74MkQ0XMLS5Ef+eYzoVhWrh
         o6s/OYzF4yv5h7QFK1teEse70FwqFu3NYjDGJQp9gxQOGmS7bZ+ExX7Vwb/fyL+dGJ1G
         ZrKz9SH1BVyKuq0ekGSn2L+b9WGqv+X3s/RK4GN+J2ORLpiXeB+Ba6QE1PHretZAOJva
         Ir8qWP4tjgjnR5XrAtnjdIxr/68O+uhX1CN2cV4hUoRzssDzCdYYk9J6UfJoRL648CZc
         91aQ==
X-Gm-Message-State: AOAM533Fs0IWwkGJ7x2Ue8kgfDORzz+JmfNM/hd1ptTkiABD+biWhjmI
        lyNKue7PNfB4HCCMtgscUPA=
X-Google-Smtp-Source: ABdhPJw9myzb07PcFULj//fMjCRC8IEUK0ANDWS8yQnArFiD3LTeE6lCvtrrKb38lDXibyNjWif1EQ==
X-Received: by 2002:a19:ee05:0:b0:46e:2f8d:db76 with SMTP id g5-20020a19ee05000000b0046e2f8ddb76mr836068lfb.321.1650574422442;
        Thu, 21 Apr 2022 13:53:42 -0700 (PDT)
Received: from localhost.localdomain ([94.103.225.17])
        by smtp.gmail.com with ESMTPSA id q21-20020a05651232b500b0046bacf73c9fsm11963lfe.151.2022.04.21.13.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 13:53:42 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     almaz.alexandrovich@paragon-software.com, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        syzbot+c95173762127ad76a824@syzkaller.appspotmail.com
Subject: [PATCH 1/2] ntfs3: fix NULL deref in ntfs_update_mftmirr
Date:   Thu, 21 Apr 2022 23:53:36 +0300
Message-Id: <85293dd018cae78e4d48d74ca77710b11eed59ba.1650574393.git.paskripkin@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If ntfs_fill_super() wasn't called then sbi->sb will be equal to NULL.
Code should check this ptr before dereferencing. Syzbot hit this issue
via passing wrong mount param as can be seen from log below

Fail log:
ntfs3: Unknown parameter 'iochvrset'
general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 1 PID: 3589 Comm: syz-executor210 Not tainted 5.18.0-rc3-syzkaller-00016-gb253435746d9 #0
...
Call Trace:
 <TASK>
 put_ntfs+0x1ed/0x2a0 fs/ntfs3/super.c:463
 ntfs_fs_free+0x6a/0xe0 fs/ntfs3/super.c:1363
 put_fs_context+0x119/0x7a0 fs/fs_context.c:469
 do_new_mount+0x2b4/0xad0 fs/namespace.c:3044
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]

Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Reported-and-tested-by: syzbot+c95173762127ad76a824@syzkaller.appspotmail.com
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 fs/ntfs3/fsntfs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 3de5700a9b83..891125ca6848 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -831,10 +831,15 @@ int ntfs_update_mftmirr(struct ntfs_sb_info *sbi, int wait)
 {
 	int err;
 	struct super_block *sb = sbi->sb;
-	u32 blocksize = sb->s_blocksize;
+	u32 blocksize;
 	sector_t block1, block2;
 	u32 bytes;
 
+	if (!sb)
+		return -EINVAL;
+
+	blocksize = sb->s_blocksize;
+
 	if (!(sbi->flags & NTFS_FLAGS_MFTMIRR))
 		return 0;
 
-- 
2.35.1

