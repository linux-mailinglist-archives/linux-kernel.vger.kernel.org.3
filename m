Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D83B57F8E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 07:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbiGYE7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 00:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGYE7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 00:59:12 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DC4DFA0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 21:59:10 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id v28so7815444qkg.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 21:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs-stonybrook-edu.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f6BGyWRa2BjQbDxlapQ6tA/QtZAsEXjWkQiWpBuogLs=;
        b=rYz3Eqlfn2BBckMR84v/yxdwG1KuAQwjLcz+sUOT0sk+QIQ+NKdaMpol8SO0bCzgWl
         f9KvDrKpPa6rHtjP+O167hotM7JZE374Um3ZdtAmtiN1e+2QeNG+2dPOqfGx6dmILAhu
         OkJV+yh8TOU6AUuTlxLHmrJXq5Hwk4eoWMWdJrs59pG0IATNxhwQHWfoVi3fR59HknUX
         /7gO6r9ApHxj5Op+5+qKrv5jwsPN6nM/A6WAZP9d9DVPEbko7PKHLp1JayxHIrpzK/Uc
         dkUKoGbmcgLg1IGhL3KKSl0SMiD2US6tJpzOQZR/LU5r8jZFN0EW1GagpTthqcYq1WV1
         RivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f6BGyWRa2BjQbDxlapQ6tA/QtZAsEXjWkQiWpBuogLs=;
        b=zJV+PCJoMdqC2Z8D9cL9lmOSSizrUsOQqJKBgCtFejdYP3AvAoizGUP9xtTvsYYjxG
         qpGQLYPy0X3W9q+j/reRsUAfe1XoKazDKD77pVy6WlFBT8sFk+ZLJlh/qZcy0s5CyQc8
         15CjFBqI7uModAgpa7E3B5y+qdR6gjKC8CbEnTX9XKJ8VHs+V1mBRtYULM1NEZkKvBmZ
         CEZkDhf+EPteEfkwg5/CWdH3tfOR52Tujz+JN7aSybFdX8MOoOFs5ZH8DNO5ZOCbrEuf
         GOTWUIk8MkQLbNphPAddtkbnhQglNQPkSwLWmacgUla7F3Bi2EWaAE48/YVaKCY5XNKJ
         9JqQ==
X-Gm-Message-State: AJIora+B4DS0tEmXYIrrFg6xowIRe5eZgRJu79TCC1K2lqyMPn9uYcio
        p9XaOeGinZS+aircNz9YqDoQ+As2tWWOVw==
X-Google-Smtp-Source: AGRyM1uS0iPlsbKkDYNQdF1aWJgVudPzoq9XLqI/N2wu+EpnfqK56z6QlpWSLgUjrEr+wssDnqgeZg==
X-Received: by 2002:ae9:e313:0:b0:6b5:e41b:64fe with SMTP id v19-20020ae9e313000000b006b5e41b64femr7815515qkf.323.1658725149192;
        Sun, 24 Jul 2022 21:59:09 -0700 (PDT)
Received: from sgdp06.fsl.cs.sunysb.edu (sgdp6.fsl.cs.sunysb.edu. [130.245.126.123])
        by smtp.googlemail.com with ESMTPSA id n8-20020ac86748000000b0031f286f868dsm3766746qtp.92.2022.07.24.21.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 21:59:08 -0700 (PDT)
From:   Yifei Liu <yifeliu@cs.stonybrook.edu>
Cc:     yifeliu@cs.stonybrook.edu, ezk@cs.stonybrook.edu,
        madkar@cs.stonybrook.edu, David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Kyeong Yoo <kyeong.yoo@alliedtelesis.co.nz>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] jffs2: correct logic when creating a hole in jffs2_write_begin
Date:   Mon, 25 Jul 2022 04:58:27 +0000
Message-Id: <20220725045830.11502-1-yifeliu@cs.stonybrook.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bug description and fix:

1. Write data to a file, say all 1s from offset 0 to 16.

2. Truncate the file to a smaller size, say 8 bytes.

3. Write new bytes (say 2s) from an offset past the original size of the
file, say at offset 20, for 4 bytes.  This is supposed to create a "hole"
in the file, meaning that the bytes from offset 8 (where it was truncated
above) up to the new write at offset 20, should all be 0s (zeros).

4. flush all caches using "echo 3 > /proc/sys/vm/drop_caches" (or unmount
and remount) the f/s.

5. Check the content of the file.  It is wrong.  The 1s that used to be
between bytes 9 and 16, before the truncation, have REAPPEARED (they should
be 0s).

We wrote a script and helper C program to reproduce the bug
(reproduce_jffs2_write_begin_issue.sh, write_file.c, and Makefile).  We can
make them available to anyone.

The above example is shown when writing a small file within the same first
page.  But the bug happens for larger files, as long as steps 1, 2, and 3
above all happen within the same page.

The problem was traced to the jffs2_write_begin code, where it goes into an
'if' statement intended to handle writes past the current EOF (i.e., writes
that may create a hole).  The code computes a 'pageofs' that is the floor
of the write position (pos), aligned to the page size boundary.  In other
words, 'pageofs' will never be larger than 'pos'.  The code then sets the
internal jffs2_raw_inode->isize to the size of max(current inode size,
pageofs) but that is wrong: the new file size should be the 'pos', which is
larger than both the current inode size and pageofs.

Similarly, the code incorrectly sets the internal jffs2_raw_inode->dsize to
the difference between the pageofs minus current inode size; instead it
should be the current pos minus the current inode size.  Finally,
inode->i_size was also set incorrectly.

The patch below fixes this bug.  The bug was discovered using a new tool
for finding f/s bugs using model checking, called MCFS (Model Checking File
Systems).

Signed-off-by: Yifei Liu <yifeliu@cs.stonybrook.edu>
Signed-off-by: Erez Zadok <ezk@cs.stonybrook.edu>
Signed-off-by: Manish Adkar <madkar@cs.stonybrook.edu>
---
 fs/jffs2/file.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index ba86acbe12d3..0479096b96e4 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -137,19 +137,18 @@ static int jffs2_write_begin(struct file *filp, struct address_space *mapping,
 	struct jffs2_inode_info *f = JFFS2_INODE_INFO(inode);
 	struct jffs2_sb_info *c = JFFS2_SB_INFO(inode->i_sb);
 	pgoff_t index = pos >> PAGE_SHIFT;
-	uint32_t pageofs = index << PAGE_SHIFT;
 	int ret = 0;
 
 	jffs2_dbg(1, "%s()\n", __func__);
 
-	if (pageofs > inode->i_size) {
-		/* Make new hole frag from old EOF to new page */
+	if (pos > inode->i_size) {
+		/* Make new hole frag from old EOF to new position */
 		struct jffs2_raw_inode ri;
 		struct jffs2_full_dnode *fn;
 		uint32_t alloc_len;
 
-		jffs2_dbg(1, "Writing new hole frag 0x%x-0x%x between current EOF and new page\n",
-			  (unsigned int)inode->i_size, pageofs);
+		jffs2_dbg(1, "Writing new hole frag 0x%x-0x%x between current EOF and new position\n",
+			  (unsigned int)inode->i_size, (uint32_t)pos);
 
 		ret = jffs2_reserve_space(c, sizeof(ri), &alloc_len,
 					  ALLOC_NORMAL, JFFS2_SUMMARY_INODE_SIZE);
@@ -169,10 +168,10 @@ static int jffs2_write_begin(struct file *filp, struct address_space *mapping,
 		ri.mode = cpu_to_jemode(inode->i_mode);
 		ri.uid = cpu_to_je16(i_uid_read(inode));
 		ri.gid = cpu_to_je16(i_gid_read(inode));
-		ri.isize = cpu_to_je32(max((uint32_t)inode->i_size, pageofs));
+		ri.isize = cpu_to_je32((uint32_t)pos);
 		ri.atime = ri.ctime = ri.mtime = cpu_to_je32(JFFS2_NOW());
 		ri.offset = cpu_to_je32(inode->i_size);
-		ri.dsize = cpu_to_je32(pageofs - inode->i_size);
+		ri.dsize = cpu_to_je32((uint32_t)pos - inode->i_size);
 		ri.csize = cpu_to_je32(0);
 		ri.compr = JFFS2_COMPR_ZERO;
 		ri.node_crc = cpu_to_je32(crc32(0, &ri, sizeof(ri)-8));
@@ -202,7 +201,7 @@ static int jffs2_write_begin(struct file *filp, struct address_space *mapping,
 			goto out_err;
 		}
 		jffs2_complete_reservation(c);
-		inode->i_size = pageofs;
+		inode->i_size = pos;
 		mutex_unlock(&f->sem);
 	}
 
-- 
2.25.1

