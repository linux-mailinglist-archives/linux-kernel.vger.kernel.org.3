Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9A346B94A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbhLGKnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:43:51 -0500
Received: from mail.avm.de ([212.42.244.119]:56322 "EHLO mail.avm.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233550AbhLGKnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:43:49 -0500
X-Greylist: delayed 515 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Dec 2021 05:43:48 EST
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
        by mail.avm.de (Postfix) with ESMTP;
        Tue,  7 Dec 2021 11:31:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1638873107; bh=pp4Derk/QtrY/93T7G4BebwlxTAK+8lT96TFpjMZh4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gCR9QGDK/0prD531OPEUum2MYEB5lo5xDBW2fFnaeQV/wuZJNBSr/Q3gJrW5AlaKo
         w98bgSiBe2HYOTwnRysI3JjvrsNnlbMXfncYsoM8vrjuryCqAJZoxYgicDr5oDEZbL
         OjF064fcUNJMCak6uY0FNXp1F6BW3cGHxGmq9sEU=
Received: from tkh-linux.avm.de ([172.17.33.53])
          by mail-notes.avm.de (HCL Domino Release 11.0.1FP4)
          with ESMTP id 2021120711314710-7978 ;
          Tue, 7 Dec 2021 11:31:47 +0100 
From:   =?UTF-8?q?Thomas=20K=C3=BChnel?= <thomas.kuehnel@avm.de>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Thomas=20K=C3=BChnel?= <thomas.kuehnel@avm.de>
Subject: [PATCH 3/3] fs/ntfs3: use _le variants of bitops functions
Date:   Tue, 7 Dec 2021 11:24:55 +0100
Message-Id: <20211207102454.576906-4-thomas.kuehnel@avm.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211207102454.576906-1-thomas.kuehnel@avm.de>
References: <20211207102454.576906-1-thomas.kuehnel@avm.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 11.0.1FP4|October 01, 2021) at
 07.12.2021 11:31:47,
        Serialize by Router on ANIS1/AVM(Release 11.0.1FP4|October 01, 2021) at
 07.12.2021 11:31:47,
        Serialize complete at 07.12.2021 11:31:47
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
X-purgate-ID: 149429::1638873107-0000056E-2492F8FC/0/0
X-purgate-type: clean
X-purgate-size: 5811
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions from bitops.h already have _le variants so use them to
prevent invalid reads/writes of the bitmap on big endian systems.

Signed-off-by: Thomas Kühnel <thomas.kuehnel@avm.de>
---
 fs/ntfs3/bitmap.c | 10 +++++-----
 fs/ntfs3/fsntfs.c |  8 ++++----
 fs/ntfs3/index.c  | 14 +++++++-------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index b61cf533b030..e3dc6714ef25 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -71,7 +71,7 @@ static size_t wnd_scan(const ulong *buf, size_t wbit, u32 wpos, u32 wend,
 	while (wpos < wend) {
 		size_t free_len;
 		u32 free_bits, end;
-		u32 used = find_next_zero_bit(buf, wend, wpos);
+		u32 used = find_next_zero_bit_le(buf, wend, wpos);
 
 		if (used >= wend) {
 			if (*b_len < *prev_tail) {
@@ -97,7 +97,7 @@ static size_t wnd_scan(const ulong *buf, size_t wbit, u32 wpos, u32 wend,
 		 * Now we have a fragment [wpos, wend) staring with 0.
 		 */
 		end = wpos + to_alloc - *prev_tail;
-		free_bits = find_next_bit(buf, min(end, wend), wpos);
+		free_bits = find_next_bit_le(buf, min(end, wend), wpos);
 
 		free_len = *prev_tail + free_bits - wpos;
 
@@ -579,7 +579,7 @@ static int wnd_rescan(struct wnd_bitmap *wnd)
 			wbits = wnd->nbits - wbit;
 
 		do {
-			used = find_next_zero_bit(buf, wbits, wpos);
+			used = find_next_zero_bit_le(buf, wbits, wpos);
 
 			if (used > wpos && prev_tail) {
 				wnd_add_free_ext(wnd, wbit + wpos - prev_tail,
@@ -595,7 +595,7 @@ static int wnd_rescan(struct wnd_bitmap *wnd)
 				break;
 			}
 
-			frb = find_next_bit(buf, wbits, wpos);
+			frb = find_next_bit_le(buf, wbits, wpos);
 			if (frb >= wbits) {
 				/* Keep last free block. */
 				prev_tail += frb - wpos;
@@ -1457,7 +1457,7 @@ int ntfs_trim_fs(struct ntfs_sb_info *sbi, struct fstrim_range *range)
 		buf = (ulong *)bh->b_data;
 
 		for (; wbit < wbits; wbit++) {
-			if (!test_bit(wbit, buf)) {
+			if (!test_bit_le(wbit, buf)) {
 				if (!len)
 					lcn = lcn_wnd + wbit;
 				len += 1;
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 4de9acb16968..1f801c9eae67 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -618,13 +618,13 @@ int ntfs_look_free_mft(struct ntfs_sb_info *sbi, CLST *rno, bool mft,
 						 NULL, 0, NULL, NULL))
 					goto next;
 
-				__clear_bit(ir - MFT_REC_RESERVED,
+				__clear_bit_le(ir - MFT_REC_RESERVED,
 					    &sbi->mft.reserved_bitmap);
 			}
 		}
 
 		/* Scan 5 bits for zero. Bit 0 == MFT_REC_RESERVED */
-		zbit = find_next_zero_bit(&sbi->mft.reserved_bitmap,
+		zbit = find_next_zero_bit_le(&sbi->mft.reserved_bitmap,
 					  MFT_REC_FREE, MFT_REC_RESERVED);
 		if (zbit >= MFT_REC_FREE) {
 			sbi->mft.next_reserved = MFT_REC_FREE;
@@ -692,7 +692,7 @@ int ntfs_look_free_mft(struct ntfs_sb_info *sbi, CLST *rno, bool mft,
 	if (*rno >= MFT_REC_FREE)
 		wnd_set_used(wnd, *rno, 1);
 	else if (*rno >= MFT_REC_RESERVED && sbi->mft.reserved_bitmap_inited)
-		__set_bit(*rno - MFT_REC_RESERVED, &sbi->mft.reserved_bitmap);
+		__set_bit_le(*rno - MFT_REC_RESERVED, &sbi->mft.reserved_bitmap);
 
 out:
 	if (!mft)
@@ -718,7 +718,7 @@ void ntfs_mark_rec_free(struct ntfs_sb_info *sbi, CLST rno)
 		else
 			wnd_set_free(wnd, rno, 1);
 	} else if (rno >= MFT_REC_RESERVED && sbi->mft.reserved_bitmap_inited) {
-		__clear_bit(rno - MFT_REC_RESERVED, &sbi->mft.reserved_bitmap);
+		__clear_bit_le(rno - MFT_REC_RESERVED, &sbi->mft.reserved_bitmap);
 	}
 
 	if (rno < wnd_zone_bit(wnd))
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 6f81e3a49abf..9547422200ab 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -323,7 +323,7 @@ static int indx_mark_used(struct ntfs_index *indx, struct ntfs_inode *ni,
 	if (err)
 		return err;
 
-	__set_bit(bit - bbuf.bit, bbuf.buf);
+	__set_bit_le(bit - bbuf.bit, bbuf.buf);
 
 	bmp_buf_put(&bbuf, true);
 
@@ -343,7 +343,7 @@ static int indx_mark_free(struct ntfs_index *indx, struct ntfs_inode *ni,
 	if (err)
 		return err;
 
-	__clear_bit(bit - bbuf.bit, bbuf.buf);
+	__clear_bit_le(bit - bbuf.bit, bbuf.buf);
 
 	bmp_buf_put(&bbuf, true);
 
@@ -457,7 +457,7 @@ static int scan_nres_bitmap(struct ntfs_inode *ni, struct ATTRIB *bitmap,
 
 static bool scan_for_free(const ulong *buf, u32 bit, u32 bits, size_t *ret)
 {
-	size_t pos = find_next_zero_bit(buf, bits, bit);
+	size_t pos = find_next_zero_bit_le(buf, bits, bit);
 
 	if (pos >= bits)
 		return false;
@@ -489,7 +489,7 @@ static int indx_find_free(struct ntfs_index *indx, struct ntfs_inode *ni,
 
 	if (!b->non_res) {
 		u32 nbits = 8 * le32_to_cpu(b->res.data_size);
-		size_t pos = find_next_zero_bit(resident_data(b), nbits, 0);
+		size_t pos = find_next_zero_bit_le(resident_data(b), nbits, 0);
 
 		if (pos < nbits)
 			*bit = pos;
@@ -505,7 +505,7 @@ static int indx_find_free(struct ntfs_index *indx, struct ntfs_inode *ni,
 
 static bool scan_for_used(const ulong *buf, u32 bit, u32 bits, size_t *ret)
 {
-	size_t pos = find_next_bit(buf, bits, bit);
+	size_t pos = find_next_bit_le(buf, bits, bit);
 
 	if (pos >= bits)
 		return false;
@@ -536,7 +536,7 @@ int indx_used_bit(struct ntfs_index *indx, struct ntfs_inode *ni, size_t *bit)
 
 	if (!b->non_res) {
 		u32 nbits = le32_to_cpu(b->res.data_size) * 8;
-		size_t pos = find_next_bit(resident_data(b), nbits, from);
+		size_t pos = find_next_bit_le(resident_data(b), nbits, from);
 
 		if (pos < nbits)
 			*bit = pos;
@@ -1954,7 +1954,7 @@ static int indx_shrink(struct ntfs_index *indx, struct ntfs_inode *ni,
 		if (bit >= nbits)
 			return 0;
 
-		pos = find_next_bit(bm, nbits, bit);
+		pos = find_next_bit_le(bm, nbits, bit);
 		if (pos < nbits)
 			return 0;
 	} else {
-- 
2.25.1

