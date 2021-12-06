Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2F3468F3F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 03:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbhLFCoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 21:44:22 -0500
Received: from mailgw.kylinos.cn ([123.150.8.42]:41260 "EHLO nksmu.kylinos.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234509AbhLFCoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 21:44:21 -0500
X-UUID: a46e52ad887a47babfb69df7a5707fea-20211206
X-CPASD-INFO: e9cade70235244928ee33cc2d62db7a9@romdgZGXZWBeU3d-g3eEbFiWlWNkj4O
        BpnBSlJBnjVmVhH5xTWJsXVKBfG5QZWNdYVN_eGpQY19gZFB5i3-XblBgXoZgUZB3tHudgZSTZw==
X-CPASD-FEATURE: 0.0
X-CLOUD-ID: e9cade70235244928ee33cc2d62db7a9
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,EXT:0.0,OB:0.0,URL:-5,T
        VAL:173.0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:1.0,CUTS:246.0,IP:-2.0,MAL:0.0,ATTNUM:0
        .0,PHF:-5.0,PHC:-5.0,SPF:4.0,EDMS:-3,IPLABEL:4488.0,FROMTO:0,AD:0,FFOB:0.0,CF
        OB:0.0,SPC:0.0,SIG:-5,AUF:16,DUF:24983,ACD:124,DCD:226,SL:0,AG:0,CFC:0.346,CF
        SR:0.062,UAT:0,RAF:0,VERSION:2.3.4
X-CPASD-ID: a46e52ad887a47babfb69df7a5707fea-20211206
X-CPASD-BLOCK: 1001
X-CPASD-STAGE: 1, 1
X-UUID: a46e52ad887a47babfb69df7a5707fea-20211206
X-User: yinxiujiang@kylinos.cn
Received: from localhost.localdomain [(118.26.139.139)] by nksmu.kylinos.cn
        (envelope-from <yinxiujiang@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1558014127; Mon, 06 Dec 2021 10:49:06 +0800
From:   Yin Xiujiang <yinxiujiang@kylinos.cn>
To:     almaz.alexandrovich@paragon-software.com
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/ntfs3: Fix slab-out-of-bounds in r_page
Date:   Mon,  6 Dec 2021 10:40:45 +0800
Message-Id: <20211206024045.15539-1-yinxiujiang@kylinos.cn>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When PAGE_SIZE is 64K, if read_log_page is called by log_read_rst for
the first time, the size of *buffer would be equal to
DefaultLogPageSize(4K).But for *buffer operations like memcpy,
if the memory area size(n) which being assigned to buffer is larger
than 4K (log->page_size(64K) or bytes(64K-page_off)), it will cause
an out of boundary error.
 Call trace:
  [...]
  kasan_report+0x44/0x130
  check_memory_region+0xf8/0x1a0
  memcpy+0xc8/0x100
  ntfs_read_run_nb+0x20c/0x460
  read_log_page+0xd0/0x1f4
  log_read_rst+0x110/0x75c
  log_replay+0x1e8/0x4aa0
  ntfs_loadlog_and_replay+0x290/0x2d0
  ntfs_fill_super+0x508/0xec0
  get_tree_bdev+0x1fc/0x34c
  [...]

Fix this by setting variable r_page to NULL in log_read_rst.

Signed-off-by: Yin Xiujiang <yinxiujiang@kylinos.cn>
---
 fs/ntfs3/fslog.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 06492f088d60..4fdb5bdfc2ee 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -1180,10 +1180,7 @@ static int log_read_rst(struct ntfs_log *log, u32 l_size, bool first,
 			struct restart_info *info)
 {
 	u32 skip, vbo;
-	struct RESTART_HDR *r_page = kmalloc(DefaultLogPageSize, GFP_NOFS);
-
-	if (!r_page)
-		return -ENOMEM;
+	struct RESTART_HDR *r_page = NULL;
 
 	memset(info, 0, sizeof(struct restart_info));
 
@@ -1199,7 +1196,6 @@ static int log_read_rst(struct ntfs_log *log, u32 l_size, bool first,
 	/* Loop continuously until we succeed. */
 	for (; vbo < l_size; vbo = 2 * vbo + skip, skip = 0) {
 		bool usa_error;
-		u32 sys_page_size;
 		bool brst, bchk;
 		struct RESTART_AREA *ra;
 
@@ -1253,24 +1249,6 @@ static int log_read_rst(struct ntfs_log *log, u32 l_size, bool first,
 			goto check_result;
 		}
 
-		/* Read the entire restart area. */
-		sys_page_size = le32_to_cpu(r_page->sys_page_size);
-		if (DefaultLogPageSize != sys_page_size) {
-			kfree(r_page);
-			r_page = kzalloc(sys_page_size, GFP_NOFS);
-			if (!r_page)
-				return -ENOMEM;
-
-			if (read_log_page(log, vbo,
-					  (struct RECORD_PAGE_HDR **)&r_page,
-					  &usa_error)) {
-				/* Ignore any errors. */
-				kfree(r_page);
-				r_page = NULL;
-				continue;
-			}
-		}
-
 		if (is_client_area_valid(r_page, usa_error)) {
 			info->valid_page = true;
 			ra = Add2Ptr(r_page, le16_to_cpu(r_page->ra_off));
-- 
2.30.0

