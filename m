Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25E158AC0D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 16:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240849AbiHEOAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 10:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240823AbiHEOAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:00:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35D71D32F;
        Fri,  5 Aug 2022 07:00:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D31B1384BC;
        Fri,  5 Aug 2022 13:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659707982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O+xnLCzRm3wCvOKJU2zaPptRBcHx/EeRzCeYNw/wYxM=;
        b=ULKieD0Clqbk1OxfYVDmMU8R/DZ/ZTQ09LXzG4fSSUM1ReaEKRQgvnXk8769QAGjepNxGl
        vYZjSyNo7GNpu+ONQCSpWglexrGfrBKpHfk/nCfuFRLz4nCZ/8nQjbH9aWrnExlIVGVMg5
        yXjQfIR6fgX/tKJ1zp23I8Zh/8ZsJqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659707982;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O+xnLCzRm3wCvOKJU2zaPptRBcHx/EeRzCeYNw/wYxM=;
        b=bA1/R3O9XM9oEoCWYlwWyRggAXb/rRmQUu0qVXvn0WpNyswPjFf8ub5wyCPXLgeV/sgHOJ
        gaTWmV0f4pgFlyCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B234133B5;
        Fri,  5 Aug 2022 13:59:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gWwqF04i7WJ+PQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 05 Aug 2022 13:59:42 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id e8bbcba8;
        Fri, 5 Aug 2022 14:00:26 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     wenqingliu0120@gmail.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH] ext4: fix bug in extents parsing when number of entries in header is zero
Date:   Fri,  5 Aug 2022 15:00:25 +0100
Message-Id: <20220805140025.26295-1-lhenriques@suse.de>
In-Reply-To: <bug-215941-13602@https.bugzilla.kernel.org/>
References: <bug-215941-13602@https.bugzilla.kernel.org/>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When walking through an inode extents, the ext4_ext_binsearch_idx() function
assumes that the extent header has been previously validated.  However,
there are no checks that verify that the number of entries (eh->eh_entries)
is non-zero.  And this will lead to problems because the EXT_FIRST_INDEX()
and EXT_LAST_INDEX() will return garbage and result in this:

[  135.245946] ------------[ cut here ]------------
[  135.247579] kernel BUG at fs/ext4/extents.c:2258!
[  135.249045] invalid opcode: 0000 [#1] PREEMPT SMP
[  135.250320] CPU: 2 PID: 238 Comm: tmp118 Not tainted 5.19.0-rc8+ #4
[  135.252067] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b-rebuilt.opensuse.org 04/01/2014
[  135.255065] RIP: 0010:ext4_ext_map_blocks+0xc20/0xcb0
[  135.256475] Code:
[  135.261433] RSP: 0018:ffffc900005939f8 EFLAGS: 00010246
[  135.262847] RAX: 0000000000000024 RBX: ffffc90000593b70 RCX: 0000000000000023
[  135.264765] RDX: ffff8880038e5f10 RSI: 0000000000000003 RDI: ffff8880046e922c
[  135.266670] RBP: ffff8880046e9348 R08: 0000000000000001 R09: ffff888002ca580c
[  135.268576] R10: 0000000000002602 R11: 0000000000000000 R12: 0000000000000024
[  135.270477] R13: 0000000000000000 R14: 0000000000000024 R15: 0000000000000000
[  135.272394] FS:  00007fdabdc56740(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
[  135.274510] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  135.276075] CR2: 00007ffc26bd4f00 CR3: 0000000006261004 CR4: 0000000000170ea0
[  135.277952] Call Trace:
[  135.278635]  <TASK>
[  135.279247]  ? preempt_count_add+0x6d/0xa0
[  135.280358]  ? percpu_counter_add_batch+0x55/0xb0
[  135.281612]  ? _raw_read_unlock+0x18/0x30
[  135.282704]  ext4_map_blocks+0x294/0x5a0
[  135.283745]  ? xa_load+0x6f/0xa0
[  135.284562]  ext4_mpage_readpages+0x3d6/0x770
[  135.285646]  read_pages+0x67/0x1d0
[  135.286492]  ? folio_add_lru+0x51/0x80
[  135.287441]  page_cache_ra_unbounded+0x124/0x170
[  135.288510]  filemap_get_pages+0x23d/0x5a0
[  135.289457]  ? path_openat+0xa72/0xdd0
[  135.290332]  filemap_read+0xbf/0x300
[  135.291158]  ? _raw_spin_lock_irqsave+0x17/0x40
[  135.292192]  new_sync_read+0x103/0x170
[  135.293014]  vfs_read+0x15d/0x180
[  135.293745]  ksys_read+0xa1/0xe0
[  135.294461]  do_syscall_64+0x3c/0x80
[  135.295284]  entry_SYSCALL_64_after_hwframe+0x46/0xb0

Unfortunately, __ext4_ext_check() only verifies that eh->eh_entries doesn't
exceed eh->eh_max.  And since an empty leaf seems to be a valid value in
same cases, adding this extra check there isn't an option.

This patch simply adds the check directly in ext4_ext_binsearch_idx() and
propagates this error so that the kernel doesn't hit this BUG_ON() in
ext4_ext_determine_hole().

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215941
Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 fs/ext4/extents.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

Hi!

This bug is easily reproducible using the filesystem image provided --
it's just a matter of mounting it and run:

    $ cat /mnt/foo/bar/xattr

Anyway, I hope my analysis of the bug is correct -- the root cause seems
to be an extent header with an invalid value for in eh_entries, which will
later cause the BUG_ON().

Cheers,
--
Luís

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c148bb97b527..53cfe2c681c4 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -738,7 +738,7 @@ void ext4_ext_drop_refs(struct ext4_ext_path *path)
  * binary search for the closest index of the given block
  * the header must be checked before calling this
  */
-static void
+static int
 ext4_ext_binsearch_idx(struct inode *inode,
 			struct ext4_ext_path *path, ext4_lblk_t block)
 {
@@ -748,6 +748,11 @@ ext4_ext_binsearch_idx(struct inode *inode,
 
 	ext_debug(inode, "binsearch for %u(idx):  ", block);
 
+	if (eh->eh_entries == 0) {
+		EXT4_ERROR_INODE(inode, "No entries in extent header!");
+		return -EFSCORRUPTED;
+	}
+
 	l = EXT_FIRST_INDEX(eh) + 1;
 	r = EXT_LAST_INDEX(eh);
 	while (l <= r) {
@@ -791,7 +796,7 @@ ext4_ext_binsearch_idx(struct inode *inode,
 		BUG_ON(chix != path->p_idx);
 	}
 #endif
-
+	return 0;
 }
 
 /*
@@ -919,7 +924,9 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 		ext_debug(inode, "depth %d: num %d, max %d\n",
 			  ppos, le16_to_cpu(eh->eh_entries), le16_to_cpu(eh->eh_max));
 
-		ext4_ext_binsearch_idx(inode, path + ppos, block);
+		ret = ext4_ext_binsearch_idx(inode, path + ppos, block);
+		if (ret < 0)
+			goto err;
 		path[ppos].p_block = ext4_idx_pblock(path[ppos].p_idx);
 		path[ppos].p_depth = i;
 		path[ppos].p_ext = NULL;
