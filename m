Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DF95A02C1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 22:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240389AbiHXUan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 16:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbiHXUam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 16:30:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0FB42ACE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 13:30:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A57160F50
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 20:30:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF59C433C1;
        Wed, 24 Aug 2022 20:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661373040;
        bh=KhuS2aA1cGvG8nGq+Lnvn6JqXWMq3xDEeS47IiRZhRs=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=onWIBk5pqvcS71A0KUMxGFzrgQj6rmzCCcUE0SKuj3rM6aCQp1bDza3jfYDt4SnRT
         8rCyTnB3indPyaDcRxMCPYlupDi/C2qIjZAMNb0Nadee4PLu4gNFSrgaBRx6m6jd7/
         blJE05rAjxlw5bAqrKnhdBsDWN7uZBe/sEA0jsWIPDoQ9eo8HqPJMTC0Tg2AZz1ELk
         6xz3a6cl5jBPjqK5C0aM3vyQvmi6Ab/OmiTTl9GE7v7OuuDgXVvAv78rVSHupem0rV
         pkTkPeQUMB+QBh1OvKmTDWtRy6hhXzY/WNjSHdqimnqOydWvAzs4BhqsuPkyKkFLTF
         xLKX0YzUXtyHg==
Date:   Wed, 24 Aug 2022 13:30:38 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/2 v2] f2fs: complete checkpoints during remount
Message-ID: <YwaKbmB23U9czf51@google.com>
References: <20220819231514.3609958-1-jaegeuk@kernel.org>
 <20220819231514.3609958-2-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819231514.3609958-2-jaegeuk@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise, pending checkpoints can contribute a race condition to give a
quota warning.

- Thread                      - checkpoint thread
                              add checkpoints to the list
do_remount()
 down_write(&sb->s_umount);
 f2fs_remount()
                              block_operations()
                               down_read_trylock(&sb->s_umount) = 0
 up_write(&sb->s_umount);
                               f2fs_quota_sync()
                                dquot_writeback_dquots()
                                 WARN_ON_ONCE(!rwsem_is_locked(&sb->s_umount));

Or,

do_remount()
 down_write(&sb->s_umount);
 f2fs_remount()
                              create a ckpt thread
                              f2fs_enable_checkpoint() adds checkpoints
			      wait for f2fs_sync_fs()
                              trigger another pending checkpoint
                               block_operations()
                                down_read_trylock(&sb->s_umount) = 0
 up_write(&sb->s_umount);
                                f2fs_quota_sync()
                                 dquot_writeback_dquots()
                                  WARN_ON_ONCE(!rwsem_is_locked(&sb->s_umount));

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

 Change log from v1:
  - add one more case

 fs/f2fs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4f2ff50b247c..0f29c759a898 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2185,6 +2185,9 @@ static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 	f2fs_up_write(&sbi->gc_lock);
 
 	f2fs_sync_fs(sbi->sb, 1);
+
+	/* Let's ensure there's no pending checkpoint anymore */
+	f2fs_flush_ckpt_thread(sbi);
 }
 
 static int f2fs_remount(struct super_block *sb, int *flags, char *data)
@@ -2350,6 +2353,9 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		f2fs_stop_ckpt_thread(sbi);
 		need_restart_ckpt = true;
 	} else {
+		/* Flush if the prevous checkpoint, if exists. */
+		f2fs_flush_ckpt_thread(sbi);
+
 		err = f2fs_start_ckpt_thread(sbi);
 		if (err) {
 			f2fs_err(sbi,
-- 
2.37.1.595.g718a3a8f04-goog

