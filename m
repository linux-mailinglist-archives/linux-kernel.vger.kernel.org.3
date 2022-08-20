Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD58759AAD7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 05:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243855AbiHTDE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 23:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243748AbiHTDEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 23:04:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F9C5FF57
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 20:04:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42E6FB82A22
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 03:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7793CC433D6;
        Sat, 20 Aug 2022 03:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660964686;
        bh=2uLhTaJKKnwTxf3DxAGW2j0DhgaSzZ5GS/Eg1+j0uSo=;
        h=From:To:Cc:Subject:Date:From;
        b=mlAJMY8lv6Dcdyc/D6ggN29mn+yO/xItmUa6z7OvFlfsbnBOqL2xoDZvZZ9jIADXx
         EmF4UfgA9VApC3wFCwvTFuM5c6hXmu9+DRCBnVDiuADqLByhUyaQNnd1u9i3TMH7eF
         sZIFa4dM6JxhqDqwbeKjGuKmy/gbJI2xKFZArlsm+ww2Lu4zGH5L0eetrg9zUcs0jo
         AZQoZmfs6aPSgDlzZbloGBeASdZfVcZaQe1QEjTcVwa8sdieQH/cArv4ubxNdkV5NW
         4HJoBHAIIweA8A1V+GbrMMOYgzmBzuA9crDpZ3X0PF4GY8c+9WyxNoOhy1PYguIfUg
         Ri52krJ8tBSjA==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@oppo.com>
Subject: [PATCH v2] f2fs: iostat: support accounting compressed IO
Date:   Sat, 20 Aug 2022 11:04:41 +0800
Message-Id: <20220820030441.3509097-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
v2:
- handle all compression related iostats in f2fs_update_iostat()
 fs/f2fs/checkpoint.c        |  5 ++-
 fs/f2fs/data.c              |  8 ++--
 fs/f2fs/f2fs.h              |  5 +++
 fs/f2fs/file.c              | 16 ++++----
 fs/f2fs/gc.c                | 12 +++---
 fs/f2fs/iostat.c            | 74 ++++++++++++++++++++++++++-----------
 fs/f2fs/iostat.h            |  4 +-
 fs/f2fs/node.c              |  2 +-
 fs/f2fs/segment.c           | 11 +++---
 include/trace/events/f2fs.h | 24 +++++++++---
 10 files changed, 109 insertions(+), 52 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 37f7a9ea4746..96f7a480585f 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -89,7 +89,7 @@ static struct page *__get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index,
 		return ERR_PTR(err);
 	}
 
-	f2fs_update_iostat(sbi, FS_META_READ_IO, F2FS_BLKSIZE);
+	f2fs_update_iostat(sbi, NULL, FS_META_READ_IO, F2FS_BLKSIZE);
 
 	lock_page(page);
 	if (unlikely(page->mapping != mapping)) {
@@ -276,7 +276,8 @@ int f2fs_ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 		f2fs_put_page(page, err ? 1 : 0);
 
 		if (!err)
-			f2fs_update_iostat(sbi, FS_META_READ_IO, F2FS_BLKSIZE);
+			f2fs_update_iostat(sbi, NULL, FS_META_READ_IO,
+							F2FS_BLKSIZE);
 	}
 out:
 	blk_finish_plug(&plug);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index aa3ccddfa037..0869fbbb5516 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1083,7 +1083,7 @@ static int f2fs_submit_page_read(struct inode *inode, struct page *page,
 	}
 	ClearPageError(page);
 	inc_page_count(sbi, F2FS_RD_DATA);
-	f2fs_update_iostat(sbi, FS_DATA_READ_IO, F2FS_BLKSIZE);
+	f2fs_update_iostat(sbi, NULL, FS_DATA_READ_IO, F2FS_BLKSIZE);
 	__submit_bio(sbi, bio, DATA);
 	return 0;
 }
@@ -2122,7 +2122,8 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 		goto submit_and_realloc;
 
 	inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
-	f2fs_update_iostat(F2FS_I_SB(inode), FS_DATA_READ_IO, F2FS_BLKSIZE);
+	f2fs_update_iostat(F2FS_I_SB(inode), NULL, FS_DATA_READ_IO,
+							F2FS_BLKSIZE);
 	ClearPageError(page);
 	*last_block_in_bio = block_nr;
 	goto out;
@@ -2270,8 +2271,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 		refcount_inc(&dic->refcnt);
 
 		inc_page_count(sbi, F2FS_RD_DATA);
-		f2fs_update_iostat(sbi, FS_DATA_READ_IO, F2FS_BLKSIZE);
-		f2fs_update_iostat(sbi, FS_CDATA_READ_IO, F2FS_BLKSIZE);
+		f2fs_update_iostat(sbi, inode, FS_DATA_READ_IO, F2FS_BLKSIZE);
 		ClearPageError(page);
 		*last_block_in_bio = blkaddr;
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 99c4f073cdcc..088c3d1574b8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1158,7 +1158,10 @@ enum iostat_type {
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
@@ -1172,6 +1175,8 @@ enum iostat_type {
 	APP_BUFFERED_READ_IO,		/* app buffered read IOs */
 	APP_READ_IO,			/* app read IOs */
 	APP_MAPPED_READ_IO,		/* app mapped read IOs */
+	APP_BUFFERED_CDATA_READ_IO,	/* app buffered read IOs on compressed file  */
+	APP_MAPPED_CDATA_READ_IO,	/* app mapped read IOs on compressed file  */
 	FS_DATA_READ_IO,		/* data read IOs */
 	FS_GDATA_READ_IO,		/* data read IOs from background gc */
 	FS_CDATA_READ_IO,		/* compressed data read IOs */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ce4905a073b3..771f1f7f3690 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -43,8 +43,8 @@ static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
 
 	ret = filemap_fault(vmf);
 	if (!ret)
-		f2fs_update_iostat(F2FS_I_SB(inode), APP_MAPPED_READ_IO,
-							F2FS_BLKSIZE);
+		f2fs_update_iostat(F2FS_I_SB(inode), inode,
+					APP_MAPPED_READ_IO, F2FS_BLKSIZE);
 
 	trace_f2fs_filemap_fault(inode, vmf->pgoff, (unsigned long)ret);
 
@@ -154,7 +154,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	if (!PageUptodate(page))
 		SetPageUptodate(page);
 
-	f2fs_update_iostat(sbi, APP_MAPPED_IO, F2FS_BLKSIZE);
+	f2fs_update_iostat(sbi, inode, APP_MAPPED_IO, F2FS_BLKSIZE);
 	f2fs_update_time(sbi, REQ_TIME);
 
 	trace_f2fs_vm_page_mkwrite(page, DATA);
@@ -4212,7 +4212,7 @@ static int f2fs_dio_read_end_io(struct kiocb *iocb, ssize_t size, int error,
 	dec_page_count(sbi, F2FS_DIO_READ);
 	if (error)
 		return error;
-	f2fs_update_iostat(sbi, APP_DIRECT_READ_IO, size);
+	f2fs_update_iostat(sbi, NULL, APP_DIRECT_READ_IO, size);
 	return 0;
 }
 
@@ -4301,7 +4301,8 @@ static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	} else {
 		ret = filemap_read(iocb, to, 0);
 		if (ret > 0)
-			f2fs_update_iostat(F2FS_I_SB(inode), APP_BUFFERED_READ_IO, ret);
+			f2fs_update_iostat(F2FS_I_SB(inode), inode,
+						APP_BUFFERED_READ_IO, ret);
 	}
 	if (trace_f2fs_dataread_end_enabled())
 		trace_f2fs_dataread_end(inode, pos, ret);
@@ -4418,7 +4419,8 @@ static ssize_t f2fs_buffered_write_iter(struct kiocb *iocb,
 
 	if (ret > 0) {
 		iocb->ki_pos += ret;
-		f2fs_update_iostat(F2FS_I_SB(inode), APP_BUFFERED_IO, ret);
+		f2fs_update_iostat(F2FS_I_SB(inode), inode,
+						APP_BUFFERED_IO, ret);
 	}
 	return ret;
 }
@@ -4431,7 +4433,7 @@ static int f2fs_dio_write_end_io(struct kiocb *iocb, ssize_t size, int error,
 	dec_page_count(sbi, F2FS_DIO_WRITE);
 	if (error)
 		return error;
-	f2fs_update_iostat(sbi, APP_DIRECT_IO, size);
+	f2fs_update_iostat(sbi, NULL, APP_DIRECT_IO, size);
 	return 0;
 }
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 3397fd22d820..fd400d148afb 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1202,8 +1202,8 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 	f2fs_put_page(fio.encrypted_page, 0);
 	f2fs_put_page(page, 1);
 
-	f2fs_update_iostat(sbi, FS_DATA_READ_IO, F2FS_BLKSIZE);
-	f2fs_update_iostat(sbi, FS_GDATA_READ_IO, F2FS_BLKSIZE);
+	f2fs_update_iostat(sbi, inode, FS_DATA_READ_IO, F2FS_BLKSIZE);
+	f2fs_update_iostat(sbi, NULL, FS_GDATA_READ_IO, F2FS_BLKSIZE);
 
 	return 0;
 put_encrypted_page:
@@ -1303,8 +1303,10 @@ static int move_data_block(struct inode *inode, block_t bidx,
 			goto up_out;
 		}
 
-		f2fs_update_iostat(fio.sbi, FS_DATA_READ_IO, F2FS_BLKSIZE);
-		f2fs_update_iostat(fio.sbi, FS_GDATA_READ_IO, F2FS_BLKSIZE);
+		f2fs_update_iostat(fio.sbi, inode, FS_DATA_READ_IO,
+							F2FS_BLKSIZE);
+		f2fs_update_iostat(fio.sbi, NULL, FS_GDATA_READ_IO,
+							F2FS_BLKSIZE);
 
 		lock_page(mpage);
 		if (unlikely(mpage->mapping != META_MAPPING(fio.sbi) ||
@@ -1356,7 +1358,7 @@ static int move_data_block(struct inode *inode, block_t bidx,
 		goto put_page_out;
 	}
 
-	f2fs_update_iostat(fio.sbi, FS_GC_DATA_IO, F2FS_BLKSIZE);
+	f2fs_update_iostat(fio.sbi, NULL, FS_GC_DATA_IO, F2FS_BLKSIZE);
 
 	f2fs_update_data_blkaddr(&dn, newaddr);
 	set_inode_flag(inode, FI_APPEND_WRITE);
diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
index d84c5f6cc09d..3166a8939ed4 100644
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
+	seq_printf(seq, "app buffered data:	%-16llu\n",
 				sbi->rw_iostat[APP_BUFFERED_READ_IO]);
-	seq_printf(seq, "app direct:	%-16llu\n",
+	seq_printf(seq, "app direct data:	%-16llu\n",
 				sbi->rw_iostat[APP_DIRECT_READ_IO]);
-	seq_printf(seq, "app mapped:	%-16llu\n",
+	seq_printf(seq, "app mapped data:	%-16llu\n",
 				sbi->rw_iostat[APP_MAPPED_READ_IO]);
+	seq_printf(seq, "app buffered cdata:	%-16llu\n",
+				sbi->rw_iostat[APP_BUFFERED_CDATA_READ_IO]);
+	seq_printf(seq, "app mapped cdata:	%-16llu\n",
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
@@ -159,7 +169,7 @@ void f2fs_reset_iostat(struct f2fs_sb_info *sbi)
 	spin_unlock_irq(&sbi->iostat_lat_lock);
 }
 
-void f2fs_update_iostat(struct f2fs_sb_info *sbi,
+void f2fs_update_iostat(struct f2fs_sb_info *sbi, struct inode *inode,
 			enum iostat_type type, unsigned long long io_bytes)
 {
 	unsigned long flags;
@@ -176,6 +186,28 @@ void f2fs_update_iostat(struct f2fs_sb_info *sbi,
 	if (type == APP_BUFFERED_READ_IO || type == APP_DIRECT_READ_IO)
 		sbi->rw_iostat[APP_READ_IO] += io_bytes;
 
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+	if (inode && f2fs_compressed_file(inode)) {
+		if (type == APP_BUFFERED_IO)
+			sbi->rw_iostat[APP_BUFFERED_CDATA_IO] += io_bytes;
+
+		if (type == APP_BUFFERED_READ_IO)
+			sbi->rw_iostat[APP_BUFFERED_CDATA_READ_IO] += io_bytes;
+
+		if (type == APP_MAPPED_READ_IO)
+			sbi->rw_iostat[APP_MAPPED_CDATA_READ_IO] += io_bytes;
+
+		if (type == APP_MAPPED_IO)
+			sbi->rw_iostat[APP_MAPPED_CDATA_IO] += io_bytes;
+
+		if (type == FS_DATA_READ_IO)
+			sbi->rw_iostat[FS_CDATA_READ_IO] += io_bytes;
+
+		if (type == FS_DATA_IO)
+			sbi->rw_iostat[FS_CDATA_IO] += io_bytes;
+	}
+#endif
+
 	spin_unlock_irqrestore(&sbi->iostat_lock, flags);
 
 	f2fs_record_iostat(sbi);
diff --git a/fs/f2fs/iostat.h b/fs/f2fs/iostat.h
index 22a2d01f57ef..2c048307b6e0 100644
--- a/fs/f2fs/iostat.h
+++ b/fs/f2fs/iostat.h
@@ -31,7 +31,7 @@ struct iostat_lat_info {
 extern int __maybe_unused iostat_info_seq_show(struct seq_file *seq,
 			void *offset);
 extern void f2fs_reset_iostat(struct f2fs_sb_info *sbi);
-extern void f2fs_update_iostat(struct f2fs_sb_info *sbi,
+extern void f2fs_update_iostat(struct f2fs_sb_info *sbi, struct inode *inode,
 			enum iostat_type type, unsigned long long io_bytes);
 
 struct bio_iostat_ctx {
@@ -65,7 +65,7 @@ extern void f2fs_destroy_iostat_processing(void);
 extern int f2fs_init_iostat(struct f2fs_sb_info *sbi);
 extern void f2fs_destroy_iostat(struct f2fs_sb_info *sbi);
 #else
-static inline void f2fs_update_iostat(struct f2fs_sb_info *sbi,
+static inline void f2fs_update_iostat(struct f2fs_sb_info *sbi, struct inode *inode,
 		enum iostat_type type, unsigned long long io_bytes) {}
 static inline void iostat_update_and_unbind_ctx(struct bio *bio, int rw) {}
 static inline void iostat_alloc_and_bind_ctx(struct f2fs_sb_info *sbi,
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index e06a0c478b39..2484285be3ad 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1369,7 +1369,7 @@ static int read_node_page(struct page *page, blk_opf_t op_flags)
 	err = f2fs_submit_page_bio(&fio);
 
 	if (!err)
-		f2fs_update_iostat(sbi, FS_NODE_READ_IO, F2FS_BLKSIZE);
+		f2fs_update_iostat(sbi, NULL, FS_NODE_READ_IO, F2FS_BLKSIZE);
 
 	return err;
 }
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0de21f82d7bc..a5054725d0b6 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1171,7 +1171,7 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 
 		atomic_inc(&dcc->issued_discard);
 
-		f2fs_update_iostat(sbi, FS_DISCARD, 1);
+		f2fs_update_iostat(sbi, NULL, FS_DISCARD, 1);
 
 		lstart += len;
 		start += len;
@@ -3388,7 +3388,7 @@ void f2fs_do_write_meta_page(struct f2fs_sb_info *sbi, struct page *page,
 	f2fs_submit_page_write(&fio);
 
 	stat_inc_meta_count(sbi, page->index);
-	f2fs_update_iostat(sbi, io_type, F2FS_BLKSIZE);
+	f2fs_update_iostat(sbi, NULL, io_type, F2FS_BLKSIZE);
 }
 
 void f2fs_do_write_node_page(unsigned int nid, struct f2fs_io_info *fio)
@@ -3398,7 +3398,7 @@ void f2fs_do_write_node_page(unsigned int nid, struct f2fs_io_info *fio)
 	set_summary(&sum, nid, 0, 0);
 	do_write_page(&sum, fio);
 
-	f2fs_update_iostat(fio->sbi, fio->io_type, F2FS_BLKSIZE);
+	f2fs_update_iostat(fio->sbi, NULL, fio->io_type, F2FS_BLKSIZE);
 }
 
 void f2fs_outplace_write_data(struct dnode_of_data *dn,
@@ -3412,7 +3412,7 @@ void f2fs_outplace_write_data(struct dnode_of_data *dn,
 	do_write_page(&sum, fio);
 	f2fs_update_data_blkaddr(dn, fio->new_blkaddr);
 
-	f2fs_update_iostat(sbi, fio->io_type, F2FS_BLKSIZE);
+	f2fs_update_iostat(sbi, dn->inode, fio->io_type, F2FS_BLKSIZE);
 }
 
 int f2fs_inplace_write_data(struct f2fs_io_info *fio)
@@ -3453,7 +3453,8 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 	if (!err) {
 		f2fs_update_device_state(fio->sbi, fio->ino,
 						fio->new_blkaddr, 1);
-		f2fs_update_iostat(fio->sbi, fio->io_type, F2FS_BLKSIZE);
+		f2fs_update_iostat(fio->sbi, fio->page->mapping->host,
+						fio->io_type, F2FS_BLKSIZE);
 	}
 
 	return err;
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index f1e922237736..b262985f0c3a 100644
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
2.25.1

