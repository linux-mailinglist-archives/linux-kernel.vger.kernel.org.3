Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931E1536996
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 03:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355327AbiE1BHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 21:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiE1BHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 21:07:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE25C29C81
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 18:07:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F46C618F8
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 01:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A94C385A9;
        Sat, 28 May 2022 01:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653700058;
        bh=fnuHYMuoxHN8RWWIoGtl2rQq4IIhNVlqax99ENyTxM0=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=HtIyO3wWgST9IOfxQimTnG0ubPv2DdUGIeLUITzIRXTODUOOdPtTfp23XI9sZcQZH
         H1qBt3DWQ7uX2wCTY3Xu+T84FISkAmLxBydSrDZKD0E3Zi3VCBEzJKwvwSlKlhDbS4
         gXLMMet+BoR8/hRKYkZTQ5/VkXTMVNrsccna+9tYa5pgqQUWPjDwaSny9IYh38FeFe
         +hHoSDhrbh/7ghJPpSykp07nX6Yxbrb9zj8z91aB7IcyJi4YSDlygO+y2kWMLTheaX
         4og3rv5KHyAHNLj6LoC7v3MyUprEA1N2nWKeWbln5GY/KOUw0V3Ufnl7jcuwMIbHyC
         pJ0x12incsr8g==
Date:   Fri, 27 May 2022 18:07:37 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [RFC PATCH v2] f2fs: add sysfs entry to avoid FUA
Message-ID: <YpF12RCV6wn/BrwI@google.com>
References: <20220527205955.3251982-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527205955.3251982-1-jaegeuk@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some UFS storage supporting FUA gives slower DIO write bandwidth with FUA
than write+cache_flush. But, in some small chunk writes, there's no
reason to avoid FUA for shorter latency. Let's give a way to handle it
by user.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

 Note that, this is a RFC, waiting for a better/right solution.

 Documentation/ABI/testing/sysfs-fs-f2fs | 7 +++++++
 fs/f2fs/data.c                          | 2 ++
 fs/f2fs/f2fs.h                          | 1 +
 fs/f2fs/sysfs.c                         | 9 +++++++++
 4 files changed, 19 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 9b583dd0298b..8ca49f7d28ad 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -434,6 +434,7 @@ Date:		April 2020
 Contact:	"Daeho Jeong" <daehojeong@google.com>
 Description:	Give a way to change iostat_period time. 3secs by default.
 		The new iostat trace gives stats gap given the period.
+
 What:		/sys/fs/f2fs/<disk>/max_io_bytes
 Date:		December 2020
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
@@ -442,6 +443,12 @@ Description:	This gives a control to limit the bio size in f2fs.
 		whereas, if it has a certain bytes value, f2fs won't submit a
 		bio larger than that size.
 
+What:		/sys/fs/f2fs/<disk>/no_fua_dio
+Date:		May 2022
+Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
+Description:	This contorls whether direct IOs attach FUA or not. Default is
+		using FUA.
+
 What:		/sys/fs/f2fs/<disk>/stat/sb_status
 Date:		December 2020
 Contact:	"Chao Yu" <yuchao0@huawei.com>
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f5f2b7233982..23486486eab2 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4153,6 +4153,8 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if ((inode->i_state & I_DIRTY_DATASYNC) ||
 	    offset + length > i_size_read(inode))
 		iomap->flags |= IOMAP_F_DIRTY;
+	if (F2FS_I_SB(inode)->no_fua_dio)
+		iomap->flags |= IOMAP_F_DIRTY;
 
 	return 0;
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e10838879538..4897ada1929b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1671,6 +1671,7 @@ struct f2fs_sb_info {
 	int dir_level;				/* directory level */
 	int readdir_ra;				/* readahead inode in readdir */
 	u64 max_io_bytes;			/* max io bytes to merge IOs */
+	bool no_fua_dio;			/* don't add FUA in DIO write */
 
 	block_t user_block_count;		/* # of user blocks */
 	block_t total_valid_block_count;	/* # of valid blocks */
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 4c50aedd5144..199ba3e20ab0 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -608,6 +608,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "no_fua_dio")) {
+		if (t != 0 && t != 1)
+			return -EINVAL;
+		sbi->no_fua_dio = t;
+		return count;
+	}
+
 	*ui = (unsigned int)t;
 
 	return count;
@@ -771,6 +778,7 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, iostat_period_ms, iostat_period_ms);
 #endif
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, readdir_ra, readdir_ra);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, max_io_bytes, max_io_bytes);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, no_fua_dio, no_fua_dio);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_pin_file_thresh, gc_pin_file_threshold);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_super_block, extension_list, extension_list);
 #ifdef CONFIG_F2FS_FAULT_INJECTION
@@ -890,6 +898,7 @@ static struct attribute *f2fs_attrs[] = {
 #endif
 	ATTR_LIST(readdir_ra),
 	ATTR_LIST(max_io_bytes),
+	ATTR_LIST(no_fua_dio),
 	ATTR_LIST(gc_pin_file_thresh),
 	ATTR_LIST(extension_list),
 #ifdef CONFIG_F2FS_FAULT_INJECTION
-- 
2.36.1.124.g0e6072fb45-goog


