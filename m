Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B93589EDF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 17:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237340AbiHDPpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 11:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiHDPpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:45:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00610BE0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 08:45:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AEBA61365
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2013EC433D7;
        Thu,  4 Aug 2022 15:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659627912;
        bh=67a399x+rTfEKj3nLw9NN0oJirD4h+nRr31AXlDVvHI=;
        h=From:To:Cc:Subject:Date:From;
        b=N82xEdy/Fr8KzE7n6Qlyi0dN8RXfUDw5VTEOM0KkETgf9/6DNZw5yaeBSQO2zag2E
         mG3Um/HXyEb64a7pCR7+YCvg6mArhjDphmDRdFUAv5RTQfOs3duv5nJ7QRVrZG9Fww
         94efEV/JoLXhcJED0BsylpLnjyu8TkjbnwYgeUP29/vDvfyE1FkEqgCvuBOV5G0Dmc
         CjSf87Zgi5eyBbyVxPqYHhI98G/nh3j+n50R60dI2j5Iez+T+24kzl09hPxNUQCqda
         35a4XgbqoYNbayumx+MJXJqBAsiYWJzoG1evZUH8d/552qbLpAD2mG0wzgBBsLRWxl
         4LgZfV/PCfNBw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@oppo.com>
Subject: [PATCH] f2fs: iostat: support accounting compressed IO
Date:   Thu,  4 Aug 2022 23:45:00 +0800
Message-Id: <20220804154500.17719-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <chao.yu@oppo.com>

Previously, we supported to account FS_CDATA_READ_IO type IO only,
in this patch, it adds to account more type IO for compressed file:
- APP_BUFFERED_CDATA_IO
- APP_MAPPED_CDATA_IO
- FS_CDATA_IO
- APP_BUFFERED_CDATA_READ_IO
- APP_MAPPED_CDATA_READ_IO

Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/f2fs/compress.c          |  2 +-
 fs/f2fs/f2fs.h              |  5 ++++
 fs/f2fs/file.c              | 27 ++++++++++++++++----
 fs/f2fs/iostat.c            | 50 ++++++++++++++++++++++---------------
 include/trace/events/f2fs.h | 24 ++++++++++++++----
 5 files changed, 77 insertions(+), 31 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index fa237e5c7173..6855fdca0464 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1537,7 +1537,7 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
 		}
 
 		err = f2fs_write_compressed_pages(cc, submitted,
-							wbc, io_type);
+							wbc, FS_CDATA_IO);
 		if (!err)
 			return 0;
 		f2fs_bug_on(F2FS_I_SB(cc->inode), err != -EAGAIN);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d187bdc39b79..8cd191fc0c5d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1156,7 +1156,10 @@ enum iostat_type {
 	APP_BUFFERED_IO,		/* app buffered write IOs */
 	APP_WRITE_IO,			/* app write IOs */
 	APP_MAPPED_IO,			/* app mapped IOs */
+	APP_BUFFERED_CDATA_IO,		/* app buffered write IOs on compressed file */
+	APP_MAPPED_CDATA_IO,		/* app mapped write IOs on compressed file */
 	FS_DATA_IO,			/* data IOs from kworker/fsync/reclaimer */
+	FS_CDATA_IO,			/* data IOs from kworker/fsync/reclaimer on compressed file */
 	FS_NODE_IO,			/* node IOs from kworker/fsync/reclaimer */
 	FS_META_IO,			/* meta IOs from kworker/reclaimer */
 	FS_GC_DATA_IO,			/* data IOs from forground gc */
@@ -1170,6 +1173,8 @@ enum iostat_type {
 	APP_BUFFERED_READ_IO,		/* app buffered read IOs */
 	APP_READ_IO,			/* app read IOs */
 	APP_MAPPED_READ_IO,		/* app mapped read IOs */
+	APP_BUFFERED_CDATA_READ_IO,	/* app buffered read IOs on compressed file  */
+	APP_MAPPED_CDATA_READ_IO,	/* app mapped read IOs on compressed file  */
 	FS_DATA_READ_IO,		/* data read IOs */
 	FS_GDATA_READ_IO,		/* data read IOs from background gc */
 	FS_CDATA_READ_IO,		/* compressed data read IOs */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4a3f4eaa3fc5..a7b33edb4e83 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -42,9 +42,14 @@ static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
 	vm_fault_t ret;
 
 	ret = filemap_fault(vmf);
-	if (!ret)
-		f2fs_update_iostat(F2FS_I_SB(inode), APP_MAPPED_READ_IO,
+	if (!ret) {
+		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+
+		f2fs_update_iostat(sbi, APP_MAPPED_READ_IO, F2FS_BLKSIZE);
+		if (f2fs_compressed_file(inode))
+			f2fs_update_iostat(sbi, APP_MAPPED_CDATA_READ_IO,
 							F2FS_BLKSIZE);
+	}
 
 	trace_f2fs_filemap_fault(inode, vmf->pgoff, (unsigned long)ret);
 
@@ -155,6 +160,8 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 		SetPageUptodate(page);
 
 	f2fs_update_iostat(sbi, APP_MAPPED_IO, F2FS_BLKSIZE);
+	if (f2fs_compressed_file(inode))
+		f2fs_update_iostat(sbi, APP_MAPPED_CDATA_IO, F2FS_BLKSIZE);
 	f2fs_update_time(sbi, REQ_TIME);
 
 	trace_f2fs_vm_page_mkwrite(page, DATA);
@@ -4308,8 +4315,14 @@ static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		ret = f2fs_dio_read_iter(iocb, to);
 	} else {
 		ret = filemap_read(iocb, to, 0);
-		if (ret > 0)
-			f2fs_update_iostat(F2FS_I_SB(inode), APP_BUFFERED_READ_IO, ret);
+		if (ret > 0) {
+			struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+
+			f2fs_update_iostat(sbi, APP_BUFFERED_READ_IO, ret);
+			if (f2fs_compressed_file(inode))
+				f2fs_update_iostat(sbi,
+					APP_BUFFERED_CDATA_READ_IO, ret);
+		}
 	}
 	if (trace_f2fs_dataread_end_enabled())
 		trace_f2fs_dataread_end(inode, pos, ret);
@@ -4425,8 +4438,12 @@ static ssize_t f2fs_buffered_write_iter(struct kiocb *iocb,
 	current->backing_dev_info = NULL;
 
 	if (ret > 0) {
+		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+
 		iocb->ki_pos += ret;
-		f2fs_update_iostat(F2FS_I_SB(inode), APP_BUFFERED_IO, ret);
+		f2fs_update_iostat(sbi, APP_BUFFERED_IO, ret);
+		if (f2fs_compressed_file(inode))
+			f2fs_update_iostat(sbi, APP_BUFFERED_CDATA_IO, ret);
 	}
 	return ret;
 }
diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
index d84c5f6cc09d..2fc156a8b32b 100644
--- a/fs/f2fs/iostat.c
+++ b/fs/f2fs/iostat.c
@@ -31,55 +31,65 @@ int __maybe_unused iostat_info_seq_show(struct seq_file *seq, void *offset)
 
 	/* print app write IOs */
 	seq_puts(seq, "[WRITE]\n");
-	seq_printf(seq, "app buffered:	%-16llu\n",
+	seq_printf(seq, "app buffered data:	%-16llu\n",
 				sbi->rw_iostat[APP_BUFFERED_IO]);
-	seq_printf(seq, "app direct:	%-16llu\n",
+	seq_printf(seq, "app direct data:	%-16llu\n",
 				sbi->rw_iostat[APP_DIRECT_IO]);
-	seq_printf(seq, "app mapped:	%-16llu\n",
+	seq_printf(seq, "app mapped data:	%-16llu\n",
 				sbi->rw_iostat[APP_MAPPED_IO]);
+	seq_printf(seq, "app buffered cdata:	%-16llu\n",
+				sbi->rw_iostat[APP_BUFFERED_CDATA_IO]);
+	seq_printf(seq, "app mapped cdata:	%-16llu\n",
+				sbi->rw_iostat[APP_MAPPED_CDATA_IO]);
 
 	/* print fs write IOs */
-	seq_printf(seq, "fs data:	%-16llu\n",
+	seq_printf(seq, "fs data:		%-16llu\n",
 				sbi->rw_iostat[FS_DATA_IO]);
-	seq_printf(seq, "fs node:	%-16llu\n",
+	seq_printf(seq, "fs cdata:		%-16llu\n",
+				sbi->rw_iostat[FS_CDATA_IO]);
+	seq_printf(seq, "fs node:		%-16llu\n",
 				sbi->rw_iostat[FS_NODE_IO]);
-	seq_printf(seq, "fs meta:	%-16llu\n",
+	seq_printf(seq, "fs meta:		%-16llu\n",
 				sbi->rw_iostat[FS_META_IO]);
-	seq_printf(seq, "fs gc data:	%-16llu\n",
+	seq_printf(seq, "fs gc data:		%-16llu\n",
 				sbi->rw_iostat[FS_GC_DATA_IO]);
-	seq_printf(seq, "fs gc node:	%-16llu\n",
+	seq_printf(seq, "fs gc node:		%-16llu\n",
 				sbi->rw_iostat[FS_GC_NODE_IO]);
-	seq_printf(seq, "fs cp data:	%-16llu\n",
+	seq_printf(seq, "fs cp data:		%-16llu\n",
 				sbi->rw_iostat[FS_CP_DATA_IO]);
-	seq_printf(seq, "fs cp node:	%-16llu\n",
+	seq_printf(seq, "fs cp node:		%-16llu\n",
 				sbi->rw_iostat[FS_CP_NODE_IO]);
-	seq_printf(seq, "fs cp meta:	%-16llu\n",
+	seq_printf(seq, "fs cp meta:		%-16llu\n",
 				sbi->rw_iostat[FS_CP_META_IO]);
 
 	/* print app read IOs */
 	seq_puts(seq, "[READ]\n");
-	seq_printf(seq, "app buffered:	%-16llu\n",
+	seq_printf(seq, "app buffered data:		%-16llu\n",
 				sbi->rw_iostat[APP_BUFFERED_READ_IO]);
-	seq_printf(seq, "app direct:	%-16llu\n",
+	seq_printf(seq, "app direct data:		%-16llu\n",
 				sbi->rw_iostat[APP_DIRECT_READ_IO]);
-	seq_printf(seq, "app mapped:	%-16llu\n",
+	seq_printf(seq, "app mapped data:		%-16llu\n",
 				sbi->rw_iostat[APP_MAPPED_READ_IO]);
+	seq_printf(seq, "app buffered cdata:		%-16llu\n",
+				sbi->rw_iostat[APP_BUFFERED_CDATA_READ_IO]);
+	seq_printf(seq, "app mapped cdata:		%-16llu\n",
+				sbi->rw_iostat[APP_MAPPED_CDATA_READ_IO]);
 
 	/* print fs read IOs */
-	seq_printf(seq, "fs data:	%-16llu\n",
+	seq_printf(seq, "fs data:		%-16llu\n",
 				sbi->rw_iostat[FS_DATA_READ_IO]);
-	seq_printf(seq, "fs gc data:	%-16llu\n",
+	seq_printf(seq, "fs gc data:		%-16llu\n",
 				sbi->rw_iostat[FS_GDATA_READ_IO]);
-	seq_printf(seq, "fs compr_data:	%-16llu\n",
+	seq_printf(seq, "fs cdata:		%-16llu\n",
 				sbi->rw_iostat[FS_CDATA_READ_IO]);
-	seq_printf(seq, "fs node:	%-16llu\n",
+	seq_printf(seq, "fs node:		%-16llu\n",
 				sbi->rw_iostat[FS_NODE_READ_IO]);
-	seq_printf(seq, "fs meta:	%-16llu\n",
+	seq_printf(seq, "fs meta:		%-16llu\n",
 				sbi->rw_iostat[FS_META_READ_IO]);
 
 	/* print other IOs */
 	seq_puts(seq, "[OTHER]\n");
-	seq_printf(seq, "fs discard:	%-16llu\n",
+	seq_printf(seq, "fs discard:		%-16llu\n",
 				sbi->rw_iostat[FS_DISCARD]);
 
 	return 0;
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 513e889ef8aa..e395442502e8 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1823,7 +1823,10 @@ TRACE_EVENT(f2fs_iostat,
 		__field(unsigned long long,	app_bio)
 		__field(unsigned long long,	app_wio)
 		__field(unsigned long long,	app_mio)
+		__field(unsigned long long,	app_bcdio)
+		__field(unsigned long long,	app_mcdio)
 		__field(unsigned long long,	fs_dio)
+		__field(unsigned long long,	fs_cdio)
 		__field(unsigned long long,	fs_nio)
 		__field(unsigned long long,	fs_mio)
 		__field(unsigned long long,	fs_gc_dio)
@@ -1835,6 +1838,8 @@ TRACE_EVENT(f2fs_iostat,
 		__field(unsigned long long,	app_brio)
 		__field(unsigned long long,	app_rio)
 		__field(unsigned long long,	app_mrio)
+		__field(unsigned long long,	app_bcrio)
+		__field(unsigned long long,	app_mcrio)
 		__field(unsigned long long,	fs_drio)
 		__field(unsigned long long,	fs_gdrio)
 		__field(unsigned long long,	fs_cdrio)
@@ -1849,7 +1854,10 @@ TRACE_EVENT(f2fs_iostat,
 		__entry->app_bio	= iostat[APP_BUFFERED_IO];
 		__entry->app_wio	= iostat[APP_WRITE_IO];
 		__entry->app_mio	= iostat[APP_MAPPED_IO];
+		__entry->app_bcdio	= iostat[APP_BUFFERED_CDATA_IO];
+		__entry->app_mcdio	= iostat[APP_MAPPED_CDATA_IO];
 		__entry->fs_dio		= iostat[FS_DATA_IO];
+		__entry->fs_cdio	= iostat[FS_CDATA_IO];
 		__entry->fs_nio		= iostat[FS_NODE_IO];
 		__entry->fs_mio		= iostat[FS_META_IO];
 		__entry->fs_gc_dio	= iostat[FS_GC_DATA_IO];
@@ -1861,6 +1869,8 @@ TRACE_EVENT(f2fs_iostat,
 		__entry->app_brio	= iostat[APP_BUFFERED_READ_IO];
 		__entry->app_rio	= iostat[APP_READ_IO];
 		__entry->app_mrio	= iostat[APP_MAPPED_READ_IO];
+		__entry->app_bcrio	= iostat[APP_BUFFERED_CDATA_READ_IO];
+		__entry->app_mcrio	= iostat[APP_MAPPED_CDATA_READ_IO];
 		__entry->fs_drio	= iostat[FS_DATA_READ_IO];
 		__entry->fs_gdrio	= iostat[FS_GDATA_READ_IO];
 		__entry->fs_cdrio	= iostat[FS_CDATA_READ_IO];
@@ -1870,20 +1880,24 @@ TRACE_EVENT(f2fs_iostat,
 	),
 
 	TP_printk("dev = (%d,%d), "
-		"app [write=%llu (direct=%llu, buffered=%llu), mapped=%llu], "
-		"fs [data=%llu, node=%llu, meta=%llu, discard=%llu], "
+		"app [write=%llu (direct=%llu, buffered=%llu), mapped=%llu, "
+		"compr(buffered=%llu, mapped=%llu)], "
+		"fs [data=%llu, cdata=%llu, node=%llu, meta=%llu, discard=%llu], "
 		"gc [data=%llu, node=%llu], "
 		"cp [data=%llu, node=%llu, meta=%llu], "
 		"app [read=%llu (direct=%llu, buffered=%llu), mapped=%llu], "
-		"fs [data=%llu, (gc_data=%llu, compr_data=%llu), "
+		"compr(buffered=%llu, mapped=%llu)], "
+		"fs [data=%llu, (gc_data=%llu, cdata=%llu), "
 		"node=%llu, meta=%llu]",
 		show_dev(__entry->dev), __entry->app_wio, __entry->app_dio,
-		__entry->app_bio, __entry->app_mio, __entry->fs_dio,
+		__entry->app_bio, __entry->app_mio, __entry->app_bcdio,
+		__entry->app_mcdio, __entry->fs_dio, __entry->fs_cdio,
 		__entry->fs_nio, __entry->fs_mio, __entry->fs_discard,
 		__entry->fs_gc_dio, __entry->fs_gc_nio, __entry->fs_cp_dio,
 		__entry->fs_cp_nio, __entry->fs_cp_mio,
 		__entry->app_rio, __entry->app_drio, __entry->app_brio,
-		__entry->app_mrio, __entry->fs_drio, __entry->fs_gdrio,
+		__entry->app_mrio, __entry->app_bcrio, __entry->app_mcrio,
+		__entry->fs_drio, __entry->fs_gdrio,
 		__entry->fs_cdrio, __entry->fs_nrio, __entry->fs_mrio)
 );
 
-- 
2.36.1

