Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB2E588FE0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 17:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238305AbiHCPz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 11:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238393AbiHCPzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 11:55:37 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179E7B4A2
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 08:54:10 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id z3so1791839qtv.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 08:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs-stonybrook-edu.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=PZWPUpVvF9cKIsgpwg6daHjxAiTOoYVGBnAYticzGhY=;
        b=OVc1n5/b/fmZ0C2vLRPLIuj9H9JCeO6s4H5Czk9eJYvj4bZqh3Q3MGft/isGv95E9w
         Zh7pNz9I2erpIO7d6us6AqnTRJhV618K3PJhm2AV97UrbEW/7LoOk+GscNm6HrwmGYca
         qEcz5f4h1D5PDbZTHO7lJ2kMXPyc5aCGy/CUACuW0EMuN4xmqSqAcPvU4v/UOhnJcqIw
         YvcaLOL2Zfm1e6YlDSwcLX4h/VlrEr38JG2OgZDmr6JpONPnvs/GeVWtcwS1vF9aePqC
         dncyS2P2GZ+fKAVFDHwrmyFD63bW3ya0su90k9uHVjtidXDlMRnhv7QIw+JxFbrznEPD
         gXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=PZWPUpVvF9cKIsgpwg6daHjxAiTOoYVGBnAYticzGhY=;
        b=JCft2TACmVY2pPjJZjNCuqIE3DblpK+Kmk5zyA6suubYsgIfQ4Pwbl1ASbdEWovHL0
         g5HncXjMEADRKVsA61j1Wd/rRGIzUAZw/0DC1bKvHND94AJlefqoTTuSevQcdwEOMnDK
         KG3xjlnXlb+AAQ0JIPSXZrL+w88xbtN+oy1diktXxAS4GWfb+yefUcdQu9tskX5UuBDu
         vyhosiHTQzy3j77iwWoPx0MxZUxE82Dl+g9wNeAIAmsXe350A0IzJcvFZvwCUOJ0uj4a
         w2T8EGUev2heQKxoyzzcIjY+fZKlJioeR07AREWgO1RoNhBxp78XSf3rT7hKXajYFg+k
         Kb3g==
X-Gm-Message-State: AJIora/CnWuOXcPwKkDEBIC9lyCJw4JAOL/RJKIPzvhss2ihGLUQ3GnM
        nZEeJj9vdpzKOUgMX715ZEDqNg==
X-Google-Smtp-Source: AGRyM1sWWba8NY7xWkmAVGphiUFqgi6FgQq65hLjbWLLtcK7DMOzBoMwpkOfIDf9+X1bRbU+Q2ApLg==
X-Received: by 2002:ac8:5e47:0:b0:31e:ed53:ba5a with SMTP id i7-20020ac85e47000000b0031eed53ba5amr22551176qtx.530.1659542049150;
        Wed, 03 Aug 2022 08:54:09 -0700 (PDT)
Received: from sgdp06.fsl.cs.sunysb.edu (sgdp6.fsl.cs.sunysb.edu. [130.245.126.123])
        by smtp.googlemail.com with ESMTPSA id x13-20020a05620a258d00b006b60e1cf2c2sm12589223qko.0.2022.08.03.08.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 08:54:08 -0700 (PDT)
From:   Yifei Liu <yifeliu@cs.stonybrook.edu>
Cc:     yifeliu@cs.stonybrook.edu, ezk@cs.stonybrook.edu,
        madkar@cs.stonybrook.edu, David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Kyeong Yoo <kyeong.yoo@alliedtelesis.co.nz>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] jffs2: correct logic when creating a hole in jffs2_write_begin
Date:   Wed,  3 Aug 2022 15:53:12 +0000
Message-Id: <20220803155315.2073584-1-yifeliu@cs.stonybrook.edu>
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

4. Flush all caches using "echo 3 > /proc/sys/vm/drop_caches" (or unmount
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

