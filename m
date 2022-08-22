Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A25759B8E1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 07:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbiHVFxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 01:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiHVFxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 01:53:31 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6334EB84F
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 22:53:29 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id d71so8475702pgc.13
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 22:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc;
        bh=f230ruE4+CLPqroPsjYT5wPkd3GxwIw2c9LBwheZlYI=;
        b=IXKfpzFWQ5qv3Q1fQWkw62fzn4t9nh/oO6pfprmwV5CuuC7UGVD9BTadMtcx1/nXTu
         MGSUsCLXFEF7CQFGRr0e2rrhzk5PeCzHuRriF/14jLPyVizdYueeI/QZdtWBbU6ebHHA
         FldeK3/8TM4scpjYbFAS3jKmav0UEt2UsJvCAoeVHXTPwJ2OiqUzSmS0vUyTQM4yNUAw
         TSRqrUCAPrfL/eCIHlnizy+OoLIf5IgYjFq91UAI68kSKg+SWJbEWjRsLkhkWk8Eo/DB
         MaNqRRyBB0YGP6CJtAQGacr2qm2qcAZ7tPDYWQw4shKj1jTuu4PATmSNUFHyxwffk5Gm
         c4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=f230ruE4+CLPqroPsjYT5wPkd3GxwIw2c9LBwheZlYI=;
        b=oCaPyq6Hqs5/9ijlsB00DryOUBKvDw36t98k76fMgvO40t7hc2p04H93IUbruhAGX6
         BE0oOGDyRWO3l638wovYdn09mO5dUSx2a5SpD9xgLO0o1Gvq4ffN7L+FJ/12TmpkoO9n
         zKKq/FxoVl7iQy95HJLBEpicieyMV66wYSkF8LaVkQxnXCQqOtccUaSi+ACrcGV7lRRd
         aOfXWQodRHSLIbOgD031N8/19GsijQ4Wm0nuZIARabIOitBW1PnrtNDwFDKBVt4x1tlR
         QPMHoRvIL6+MfOG9eQjKcUj1pB8eKElm+R7L1isNzWWH8vk3LlxZ34ARB4WhfFNCDwPR
         3rGg==
X-Gm-Message-State: ACgBeo17eCC4klNlSaG+WoLOSgu5dtDBViI3Zr/xQDHnsPZfKXANcXDC
        sIZIzA0q5laH1c/3XA9YRaL2bbmCTF8=
X-Google-Smtp-Source: AA6agR5Q1/LTVD3GIr4u2NPiLtZLrsJuyg0KQ4NWa20Bfwu9JKLFbtYD23XtuGFkrFo78OzXtEpa4g==
X-Received: by 2002:a63:9042:0:b0:41c:cdd4:ae66 with SMTP id a63-20020a639042000000b0041ccdd4ae66mr15535165pge.47.1661147608830;
        Sun, 21 Aug 2022 22:53:28 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id cu14-20020a17090afa8e00b001f23db09351sm7078817pjb.46.2022.08.21.22.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 22:53:28 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        zhangwen@coolpad.com, Yue Hu <huyue2@coolpad.com>
Subject: [RFC PATCH 2/2] erofs: add on-disk compressed fragments support
Date:   Mon, 22 Aug 2022 13:53:01 +0800
Message-Id: <b087322de2adfd8ce39a5d380191562b0b0e0086.1661146058.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1661146058.git.huyue2@coolpad.com>
References: <cover.1661146058.git.huyue2@coolpad.com>
In-Reply-To: <cover.1661146058.git.huyue2@coolpad.com>
References: <cover.1661146058.git.huyue2@coolpad.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@coolpad.com>

Introduce on-disk compressed fragments feature.

This approach adds a new field called `h_fragmentoff' in the per-file
compression header to indicate the fragment offset of each tail pcluster
or the whole file in the special packed inode.

Like ztailpacking, it will also find and record the 'headlcn' of the
tail pcluster when initializing per-inode zmap for making follow-on
requests more easy.

Moreover, enable the offset for shifted decompression since we are
writing from 'pageofs_ofs' when compressing if this feature is used.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/decompressor.c |  4 +--
 fs/erofs/erofs_fs.h     | 26 ++++++++++++++-----
 fs/erofs/internal.h     | 16 +++++++++---
 fs/erofs/super.c        |  6 +++++
 fs/erofs/sysfs.c        |  2 ++
 fs/erofs/zdata.c        | 55 ++++++++++++++++++++++++++++++++++++++++-
 fs/erofs/zmap.c         | 40 +++++++++++++++++++++++++++---
 7 files changed, 133 insertions(+), 16 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index dc02d95b52d7..fe4a34ac2de7 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -338,8 +338,8 @@ static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
 		return 0;
 	}
 
-	/* set it to pageofs_out if fragments feature is used */
-	headofs_in = 0;
+	headofs_in = !erofs_sb_has_fragments(EROFS_SB(rq->sb)) ? 0 :
+		     rq->pageofs_out;
 
 	src = kmap_atomic(*rq->in) + rq->pageofs_in;
 	if (rq->out[0]) {
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 2b48373f690b..3306cca5f03b 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -25,6 +25,7 @@
 #define EROFS_FEATURE_INCOMPAT_DEVICE_TABLE	0x00000008
 #define EROFS_FEATURE_INCOMPAT_COMPR_HEAD2	0x00000008
 #define EROFS_FEATURE_INCOMPAT_ZTAILPACKING	0x00000010
+#define EROFS_FEATURE_INCOMPAT_FRAGMENTS	0x00000020
 #define EROFS_ALL_FEATURE_INCOMPAT		\
 	(EROFS_FEATURE_INCOMPAT_ZERO_PADDING | \
 	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
@@ -32,7 +33,8 @@
 	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE | \
 	 EROFS_FEATURE_INCOMPAT_DEVICE_TABLE | \
 	 EROFS_FEATURE_INCOMPAT_COMPR_HEAD2 | \
-	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING)
+	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING | \
+	 EROFS_FEATURE_INCOMPAT_FRAGMENTS)
 
 #define EROFS_SB_EXTSLOT_SIZE	16
 
@@ -71,7 +73,9 @@ struct erofs_super_block {
 	} __packed u1;
 	__le16 extra_devices;	/* # of devices besides the primary device */
 	__le16 devt_slotoff;	/* startoff = devt_slotoff * devt_slotsize */
-	__u8 reserved2[38];
+	__u8 reserved[6];
+	__le64 packed_nid;	/* nid of the special packed inode */
+	__u8 reserved2[24];
 };
 
 /*
@@ -295,16 +299,25 @@ struct z_erofs_lzma_cfgs {
  * bit 1 : HEAD1 big pcluster (0 - off; 1 - on)
  * bit 2 : HEAD2 big pcluster (0 - off; 1 - on)
  * bit 3 : tailpacking inline pcluster (0 - off; 1 - on)
+ * bit 4 : fragment pcluster (0 - off; 1 - on)
  */
 #define Z_EROFS_ADVISE_COMPACTED_2B		0x0001
 #define Z_EROFS_ADVISE_BIG_PCLUSTER_1		0x0002
 #define Z_EROFS_ADVISE_BIG_PCLUSTER_2		0x0004
 #define Z_EROFS_ADVISE_INLINE_PCLUSTER		0x0008
+#define Z_EROFS_ADVISE_FRAGMENT_PCLUSTER	0x0010
 
+#define Z_EROFS_FRAGMENT_INODE_BIT              7
 struct z_erofs_map_header {
-	__le16	h_reserved1;
-	/* indicates the encoded size of tailpacking data */
-	__le16  h_idata_size;
+	union {
+		/* direct addressing for fragment offset */
+		__le32  h_fragmentoff;
+		struct {
+			__le16  h_reserved1;
+			/* indicates the encoded size of tailpacking data */
+			__le16  h_idata_size;
+		};
+	};
 	__le16	h_advise;
 	/*
 	 * bit 0-3 : algorithm type of head 1 (logical cluster type 01);
@@ -313,7 +326,8 @@ struct z_erofs_map_header {
 	__u8	h_algorithmtype;
 	/*
 	 * bit 0-2 : logical cluster bits - 12, e.g. 0 for 4096;
-	 * bit 3-7 : reserved.
+	 * bit 3-6 : reserved;
+	 * bit 7   : move the whole file into packed inode or not.
 	 */
 	__u8	h_clusterbits;
 };
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index cfee49d33b95..7b9d31bab928 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -120,6 +120,7 @@ struct erofs_sb_info {
 	struct inode *managed_cache;
 
 	struct erofs_sb_lz4_info lz4;
+	struct inode *packed_inode;
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	struct erofs_dev_context *devs;
 	struct dax_device *dax_dev;
@@ -306,6 +307,7 @@ EROFS_FEATURE_FUNCS(chunked_file, incompat, INCOMPAT_CHUNKED_FILE)
 EROFS_FEATURE_FUNCS(device_table, incompat, INCOMPAT_DEVICE_TABLE)
 EROFS_FEATURE_FUNCS(compr_head2, incompat, INCOMPAT_COMPR_HEAD2)
 EROFS_FEATURE_FUNCS(ztailpacking, incompat, INCOMPAT_ZTAILPACKING)
+EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 
 /* atomic flag definitions */
@@ -341,8 +343,13 @@ struct erofs_inode {
 			unsigned char  z_algorithmtype[2];
 			unsigned char  z_logical_clusterbits;
 			unsigned long  z_tailextent_headlcn;
-			erofs_off_t    z_idataoff;
-			unsigned short z_idata_size;
+			union {
+				struct {
+					erofs_off_t    z_idataoff;
+					unsigned short z_idata_size;
+				};
+				erofs_off_t z_fragmentoff;
+			};
 		};
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	};
@@ -400,6 +407,7 @@ extern const struct address_space_operations z_erofs_aops;
 enum {
 	BH_Encoded = BH_PrivateStart,
 	BH_FullMapped,
+	BH_Fragment,
 };
 
 /* Has a disk mapping */
@@ -410,6 +418,8 @@ enum {
 #define EROFS_MAP_ENCODED	(1 << BH_Encoded)
 /* The length of extent is full */
 #define EROFS_MAP_FULL_MAPPED	(1 << BH_FullMapped)
+/* Located in the special packed inode */
+#define EROFS_MAP_FRAGMENT	(1 << BH_Fragment)
 
 struct erofs_map_blocks {
 	struct erofs_buf buf;
@@ -431,7 +441,7 @@ struct erofs_map_blocks {
 #define EROFS_GET_BLOCKS_FIEMAP	0x0002
 /* Used to map the whole extent if non-negligible data is requested for LZMA */
 #define EROFS_GET_BLOCKS_READMORE	0x0004
-/* Used to map tail extent for tailpacking inline pcluster */
+/* Used to map tail extent for tailpacking inline or fragment pcluster */
 #define EROFS_GET_BLOCKS_FINDTAIL	0x0008
 
 enum {
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 3173debeaa5a..fde5ece36b2c 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -381,6 +381,8 @@ static int erofs_read_superblock(struct super_block *sb)
 #endif
 	sbi->islotbits = ilog2(sizeof(struct erofs_inode_compact));
 	sbi->root_nid = le16_to_cpu(dsb->root_nid);
+	sbi->packed_inode = erofs_sb_has_fragments(sbi) ?
+		erofs_iget(sb, le64_to_cpu(dsb->packed_nid), false) : NULL;
 	sbi->inos = le64_to_cpu(dsb->inos);
 
 	sbi->build_time = le64_to_cpu(dsb->build_time);
@@ -411,6 +413,8 @@ static int erofs_read_superblock(struct super_block *sb)
 		erofs_info(sb, "EXPERIMENTAL compressed inline data feature in use. Use at your own risk!");
 	if (erofs_is_fscache_mode(sb))
 		erofs_info(sb, "EXPERIMENTAL fscache-based on-demand read feature in use. Use at your own risk!");
+	if (erofs_sb_has_fragments(sbi))
+		erofs_info(sb, "EXPERIMENTAL compressed fragments feature in use. Use at your own risk!");
 out:
 	erofs_put_metabuf(&buf);
 	return ret;
@@ -908,6 +912,8 @@ static void erofs_put_super(struct super_block *sb)
 #ifdef CONFIG_EROFS_FS_ZIP
 	iput(sbi->managed_cache);
 	sbi->managed_cache = NULL;
+	iput(sbi->packed_inode);
+	sbi->packed_inode = NULL;
 #endif
 	erofs_fscache_unregister_cookie(&sbi->s_fscache);
 }
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index c1383e508bbe..1b52395be82a 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -76,6 +76,7 @@ EROFS_ATTR_FEATURE(device_table);
 EROFS_ATTR_FEATURE(compr_head2);
 EROFS_ATTR_FEATURE(sb_chksum);
 EROFS_ATTR_FEATURE(ztailpacking);
+EROFS_ATTR_FEATURE(fragments);
 
 static struct attribute *erofs_feat_attrs[] = {
 	ATTR_LIST(zero_padding),
@@ -86,6 +87,7 @@ static struct attribute *erofs_feat_attrs[] = {
 	ATTR_LIST(compr_head2),
 	ATTR_LIST(sb_chksum),
 	ATTR_LIST(ztailpacking),
+	ATTR_LIST(fragments),
 	NULL,
 };
 ATTRIBUTE_GROUPS(erofs_feat);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 5792ca9e0d5e..3dd3b829766f 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -650,6 +650,33 @@ static bool should_alloc_managed_pages(struct z_erofs_decompress_frontend *fe,
 		la < fe->headoffset;
 }
 
+static int z_erofs_read_fragment_data(struct page *page, unsigned int pageofs,
+				      loff_t start, unsigned int len)
+{
+	struct inode *const inode = page->mapping->host;
+	erofs_off_t offset = EROFS_I(inode)->z_fragmentoff + start;
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
+	u8 *src, *dst;
+	unsigned int i, cnt;
+
+	for (i = 0; i < len; i += cnt) {
+		cnt = min(EROFS_BLKSIZ - (unsigned int)erofs_blkoff(offset),
+			  len - i);
+		src = erofs_bread(&buf, EROFS_I_SB(inode)->packed_inode,
+				  erofs_blknr(offset), EROFS_KMAP);
+		if (IS_ERR(src))
+			return PTR_ERR(src);
+
+		dst = kmap_atomic(page);
+		memcpy(dst + pageofs + i, src + erofs_blkoff(offset), cnt);
+		kunmap_atomic(dst);
+
+		offset += cnt;
+	}
+	erofs_put_metabuf(&buf);
+	return 0;
+}
+
 static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 				struct page *page, struct page **pagepool)
 {
@@ -688,7 +715,8 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		/* didn't get a valid pcluster previously (very rare) */
 	}
 
-	if (!(map->m_flags & EROFS_MAP_MAPPED))
+	if (!(map->m_flags & EROFS_MAP_MAPPED) ||
+	    map->m_flags & EROFS_MAP_FRAGMENT)
 		goto hitted;
 
 	err = z_erofs_collector_begin(fe);
@@ -735,6 +763,31 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		zero_user_segment(page, cur, end);
 		goto next_part;
 	}
+	if (map->m_flags & EROFS_MAP_FRAGMENT) {
+		unsigned int pageofs, skip, len;
+
+		if (!map->m_la) {
+			len = (offset + cur + 1 == inode->i_size) ? (cur + 1) :
+			      end;
+			err = z_erofs_read_fragment_data(page, 0, offset, len);
+			goto out;
+		}
+		if (map->m_la < offset) {
+			pageofs = 0;
+			skip = offset - map->m_la;
+		} else {
+			pageofs = map->m_la & ~PAGE_MASK;
+			skip = 0;
+		}
+		DBG_BUGON(map->m_llen - skip > PAGE_SIZE);
+		err = z_erofs_read_fragment_data(page, pageofs, skip,
+						 map->m_llen - skip);
+		if (err)
+			goto out;
+		++spiltted;
+		tight = false;
+		goto next_part;
+	}
 
 	exclusive = (!cur && (!spiltted || tight));
 	if (cur)
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index d58549ca1df9..5a1a360017ff 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -123,6 +123,23 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		if (err < 0)
 			goto out_unlock;
 	}
+	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER) {
+		vi->z_fragmentoff = le32_to_cpu(h->h_fragmentoff);
+
+		if (h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT) {
+			vi->z_tailextent_headlcn = 0;
+		} else {
+			struct erofs_map_blocks map = {
+				.buf = __EROFS_BUF_INITIALIZER
+			};
+
+			err = z_erofs_do_map_blocks(inode, &map,
+						    EROFS_GET_BLOCKS_FINDTAIL);
+			erofs_put_metabuf(&map.buf);
+			if (err < 0)
+				goto out_unlock;
+		}
+	}
 	/* paired with smp_mb() at the beginning of the function */
 	smp_mb();
 	set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
@@ -598,6 +615,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
 	bool ztailpacking = vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER;
+	bool inpacked = vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
 	struct z_erofs_maprecorder m = {
 		.inode = inode,
 		.map = map,
@@ -632,9 +650,10 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 			/*
 			 * For ztailpacking files, in order to inline data more
 			 * effectively, special EOF lclusters are now supported
-			 * which can have three parts at most.
+			 * which can have three parts at most, also suitable to
+			 * files with fragment data.
 			 */
-			if (ztailpacking && end > inode->i_size)
+			if ((ztailpacking || inpacked) && end > inode->i_size)
 				end = inode->i_size;
 			break;
 		}
@@ -672,6 +691,9 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 		map->m_flags |= EROFS_MAP_META;
 		map->m_pa = vi->z_idataoff;
 		map->m_plen = vi->z_idata_size;
+	} else if (inpacked && m.lcn == vi->z_tailextent_headlcn) {
+		map->m_flags |= EROFS_MAP_FRAGMENT;
+		DBG_BUGON(!map->m_la);
 	} else {
 		map->m_pa = blknr_to_addr(m.pblk);
 		err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
@@ -709,6 +731,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 			    struct erofs_map_blocks *map,
 			    int flags)
 {
+	struct erofs_inode *const vi = EROFS_I(inode);
 	int err = 0;
 
 	trace_z_erofs_map_blocks_iter_enter(inode, map, flags);
@@ -725,11 +748,19 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	if (err)
 		goto out;
 
+	if ((vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER) &&
+	    !vi->z_tailextent_headlcn) {
+		map->m_llen = map->m_la + 1;
+		map->m_la = 0;
+		map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_FRAGMENT;
+		goto out;
+	}
+
 	err = z_erofs_do_map_blocks(inode, map, flags);
 out:
 	trace_z_erofs_map_blocks_iter_exit(inode, map, flags, err);
 
-	/* aggressively BUG_ON iff CONFIG_EROFS_FS_DEBUG is on */
+	/* aggressively BUG_ON if CONFIG_EROFS_FS_DEBUG is on */
 	DBG_BUGON(err < 0 && err != -ENOMEM);
 	return err;
 }
@@ -751,7 +782,8 @@ static int z_erofs_iomap_begin_report(struct inode *inode, loff_t offset,
 	iomap->length = map.m_llen;
 	if (map.m_flags & EROFS_MAP_MAPPED) {
 		iomap->type = IOMAP_MAPPED;
-		iomap->addr = map.m_pa;
+		iomap->addr = map.m_flags & EROFS_MAP_FRAGMENT ?
+			      IOMAP_NULL_ADDR : map.m_pa;
 	} else {
 		iomap->type = IOMAP_HOLE;
 		iomap->addr = IOMAP_NULL_ADDR;
-- 
2.17.1

