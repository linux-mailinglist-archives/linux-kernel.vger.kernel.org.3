Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C97746B94C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbhLGKnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:43:55 -0500
Received: from mail.avm.de ([212.42.244.119]:56336 "EHLO mail.avm.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233934AbhLGKnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:43:49 -0500
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
        by mail.avm.de (Postfix) with ESMTP;
        Tue,  7 Dec 2021 11:31:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1638873106; bh=2FoNj0UdYpbmPLjQuSBiG98mRXupPeFFU07UlhIAPzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CdQ/3nEMBuHiDPkdW410mpH1iFQ2Wk/juGgMvTQAIOWZsKKIDlz4VexKc5TJA02Dj
         a+Pnhsj+YvGnNo42D3hwHdjo2g+MQrNGnKnEoqjcDO5FpCbYJoWFMkyXyhF57FNHIS
         fGSVV3o27fwG37JV8BWsprfZTbQ052oIlQrnc2KE=
Received: from tkh-linux.avm.de ([172.17.33.53])
          by mail-notes.avm.de (HCL Domino Release 11.0.1FP4)
          with ESMTP id 2021120711314642-7977 ;
          Tue, 7 Dec 2021 11:31:46 +0100 
From:   =?UTF-8?q?Thomas=20K=C3=BChnel?= <thomas.kuehnel@avm.de>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Thomas=20K=C3=BChnel?= <thomas.kuehnel@avm.de>,
        Nicolas Schier <n.schier@avm.de>
Subject: [PATCH 2/3] fs/ntfs3: add functions to modify LE bitmaps
Date:   Tue, 7 Dec 2021 11:24:54 +0100
Message-Id: <20211207102454.576906-3-thomas.kuehnel@avm.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211207102454.576906-1-thomas.kuehnel@avm.de>
References: <20211207102454.576906-1-thomas.kuehnel@avm.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 11.0.1FP4|October 01, 2021) at
 07.12.2021 11:31:46,
        Serialize by Router on ANIS1/AVM(Release 11.0.1FP4|October 01, 2021) at
 07.12.2021 11:31:46,
        Serialize complete at 07.12.2021 11:31:46
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
X-purgate-ID: 149429::1638873106-0000056E-C186803A/0/0
X-purgate-type: clean
X-purgate-size: 4144
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__bitmap_set/__bitmap_clear only works with bitmaps in CPU order.
Define a variant of these functions in ntfs3 to handle modifying bitmaps
read from the filesystem.

Signed-off-by: Thomas Kühnel <thomas.kuehnel@avm.de>
Reviewed-by: Nicolas Schier <n.schier@avm.de>
---
 fs/ntfs3/bitmap.c  | 46 +++++++++++++++++++++++++++++++++++++++++++---
 fs/ntfs3/fslog.c   |  4 ++--
 fs/ntfs3/ntfs_fs.h |  3 +++
 3 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index aa184407520f..b61cf533b030 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -741,7 +741,7 @@ int wnd_set_free(struct wnd_bitmap *wnd, size_t bit, size_t bits)
 
 		lock_buffer(bh);
 
-		__bitmap_clear(buf, wbit, op);
+		ntfs_bitmap_clear_le(buf, wbit, op);
 
 		wnd->free_bits[iw] += op;
 
@@ -793,7 +793,7 @@ int wnd_set_used(struct wnd_bitmap *wnd, size_t bit, size_t bits)
 
 		lock_buffer(bh);
 
-		__bitmap_set(buf, wbit, op);
+		ntfs_bitmap_set_le(buf, wbit, op);
 		wnd->free_bits[iw] -= op;
 
 		set_buffer_uptodate(bh);
@@ -1370,7 +1370,7 @@ int wnd_extend(struct wnd_bitmap *wnd, size_t new_bits)
 		lock_buffer(bh);
 		buf = (ulong *)bh->b_data;
 
-		__bitmap_clear(buf, b0, blocksize * 8 - b0);
+		ntfs_bitmap_clear_le(buf, b0, blocksize * 8 - b0);
 		frb = wbits - __bitmap_weight(buf, wbits);
 		wnd->total_zeroes += frb - wnd->free_bits[iw];
 		wnd->free_bits[iw] = frb;
@@ -1489,3 +1489,43 @@ int ntfs_trim_fs(struct ntfs_sb_info *sbi, struct fstrim_range *range)
 
 	return err;
 }
+
+void ntfs_bitmap_set_le(unsigned long *map, unsigned int start, int len)
+{
+	unsigned long *p = map + BIT_WORD(start);
+	const unsigned int size = start + len;
+	int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
+	unsigned long mask_to_set = cpu_to_le32(BITMAP_FIRST_WORD_MASK(start));
+
+	while (len - bits_to_set >= 0) {
+		*p |= mask_to_set;
+		len -= bits_to_set;
+		bits_to_set = BITS_PER_LONG;
+		mask_to_set = ~0UL;
+		p++;
+	}
+	if (len) {
+		mask_to_set &= cpu_to_le32(BITMAP_LAST_WORD_MASK(size));
+		*p |= mask_to_set;
+	}
+}
+
+void ntfs_bitmap_clear_le(unsigned long *map, unsigned int start, int len)
+{
+	unsigned long *p = map + BIT_WORD(start);
+	const unsigned int size = start + len;
+	int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
+	unsigned long mask_to_clear = cpu_to_le32(BITMAP_FIRST_WORD_MASK(start));
+
+	while (len - bits_to_clear >= 0) {
+		*p &= ~mask_to_clear;
+		len -= bits_to_clear;
+		bits_to_clear = BITS_PER_LONG;
+		mask_to_clear = ~0UL;
+		p++;
+	}
+	if (len) {
+		mask_to_clear &= cpu_to_le32(BITMAP_LAST_WORD_MASK(size));
+		*p &= ~mask_to_clear;
+	}
+}
diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 06492f088d60..5ec7dbad3add 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -3646,7 +3646,7 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 			goto dirty_vol;
 		}
 
-		__bitmap_set(Add2Ptr(buffer_le, roff), bmp_off, bmp_bits);
+		ntfs_bitmap_set_le(Add2Ptr(buffer_le, roff), bmp_off, bmp_bits);
 		a_dirty = true;
 		break;
 
@@ -3660,7 +3660,7 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 			goto dirty_vol;
 		}
 
-		__bitmap_clear(Add2Ptr(buffer_le, roff), bmp_off, bmp_bits);
+		ntfs_bitmap_clear_le(Add2Ptr(buffer_le, roff), bmp_off, bmp_bits);
 		a_dirty = true;
 		break;
 
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 8aaec7e0804e..aaecddeff4e5 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -828,6 +828,9 @@ int wnd_extend(struct wnd_bitmap *wnd, size_t new_bits);
 void wnd_zone_set(struct wnd_bitmap *wnd, size_t Lcn, size_t Len);
 int ntfs_trim_fs(struct ntfs_sb_info *sbi, struct fstrim_range *range);
 
+void ntfs_bitmap_set_le(unsigned long *map, unsigned int start, int len);
+void ntfs_bitmap_clear_le(unsigned long *map, unsigned int start, int len);
+
 /* Globals from upcase.c */
 int ntfs_cmp_names(const __le16 *s1, size_t l1, const __le16 *s2, size_t l2,
 		   const u16 *upcase, bool bothcase);
-- 
2.25.1

