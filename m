Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B15552B58
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 08:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346295AbiFUGzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 02:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiFUGzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 02:55:46 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DDF1CFCF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 23:55:45 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id y13-20020a17090a154d00b001eaaa3b9b8dso12416855pja.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 23:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lrtTaXmDH4j2G9DmDgYy3Hx6WoOoJlaM6bssxvYmN/s=;
        b=U/6RCn5/rnlCWPEvZmw/CvlDBd7e7AuS8iDEETwq+hrEH+sdjwYLrsXxea6i48NMrs
         Us2vRiB6BQRD8MOtGP7RS1KLIB0GU00JbD87+Fsk0BkmrLxxQE2R+0IGo6HfLaVl+15w
         W7ol69OS3VwQEgHJMGDwVjZQRkVm0tr6EuTz/OKifAyh1KsRlHB5EOEZ0GEz8LnAvNws
         u2fDrLpN2sOA/dvHcR7+7241kVt3vpHpYnIGGxKY3rJrpYM7iVwImg6BZfwrAxtSnM9m
         YBqRn5/b8rdrdidYVsr2xvfc/2grb8CTwV39h0O3LDATqjVDB6UMoNNWTgVTSM1Pc48v
         5Zpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lrtTaXmDH4j2G9DmDgYy3Hx6WoOoJlaM6bssxvYmN/s=;
        b=iDljhzexXEtWWzpkOOGRbmp8t05jSLmPeuUyLAht7MOCR4uoYlSfekY3tje/EK8A/2
         aUuQBdG8vCZuN/HcR/Ip3tgFApxRMRguKlTFP2mhAjIYHEkRPIwhB7swt+aNE11K1FsA
         fjznlzVQZU1rjDVb4rNBO0SiPx64avOFGZFwWZnZSCakJgMW4b8MWbpeYPwptUqbTYtP
         CN0219dJKWFFSghS7JTDxvVpzI4jhndP//bTTz+uSLpBJ3lBW4rGMGWnO9U3RWbG3mS+
         1Bc1a4OTR7NxN2N/gjGuAlCmPXhL25QDx9fG99Fh5jEtMN/j+eNN1iBDUsXDTlA9R37Q
         m7zg==
X-Gm-Message-State: AJIora86ck8K4qKLUKBV6U3x+aGBHrV4wtgvEsjTCwhJg5EUUNNm1dQS
        CaZzUD3i/RTWXAOJtZTJNBqZEpVoRFyRGKP+
X-Google-Smtp-Source: AGRyM1sbObkSlzAr84nXXCiR0sZIUcKAWYxHwt27RpCXoFi8PVJJ46244mVxNRT+sShWIgXpygECKQ==
X-Received: by 2002:a17:902:d2d0:b0:168:b0b2:f068 with SMTP id n16-20020a170902d2d000b00168b0b2f068mr26766089plc.45.1655794545155;
        Mon, 20 Jun 2022 23:55:45 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709028eca00b0016368840c41sm8230471plo.14.2022.06.20.23.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 23:55:43 -0700 (PDT)
From:   Chao Liu <chaoliu719@gmail.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
        Wayne Zhang <zhangwen@coolpad.com>,
        Xiaoyu Qi <qxy65535@gmail.com>, Chao Liu <liuchao@coolpad.com>
Subject: [PATCH] f2fs: fix to remove F2FS_COMPR_FL and tag F2FS_NOCOMP_FL at the same time
Date:   Tue, 21 Jun 2022 14:48:33 +0800
Message-Id: <20220621064833.1079383-1-chaoliu719@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Liu <liuchao@coolpad.com>

If the inode has the compress flag, it will fail to use
'chattr -c +m' to remove its compress flag and tag no compress flag.
However, the same command will be successful when executed again,
as shown below:

  $ touch foo.txt
  $ chattr +c foo.txt
  $ chattr -c +m foo.txt
  chattr: Invalid argument while setting flags on foo.txt
  $ chattr -c +m foo.txt
  $ f2fs_io getflags foo.txt
  get a flag on foo.txt ret=0, flags=nocompression,inline_data

Fix this by removing some checks in f2fs_setflags_common()
that do not affect the original logic. I go through all the
possible scenarios, and the results are as follows. Bold is
the only thing that has changed.

+---------------+-----------+-----------+----------+
|               |            file flags            |
+ command       +-----------+-----------+----------+
|               | no flag   | compr     | nocompr  |
+---------------+-----------+-----------+----------+
| chattr +c     | compr     | compr     | -EINVAL  |
| chattr -c     | no flag   | no flag   | nocompr  |
| chattr +m     | nocompr   | -EINVAL   | nocompr  |
| chattr -m     | no flag   | compr     | no flag  |
| chattr +c +m  | -EINVAL   | -EINVAL   | -EINVAL  |
| chattr +c -m  | compr     | compr     | compr    |
| chattr -c +m  | nocompr   | *nocompr* | nocompr  |
| chattr -c -m  | no flag   | no flag   | no flag  |
+---------------+-----------+-----------+----------+

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Chao Liu <liuchao@coolpad.com>
---

This patch depends on the the patch
"f2fs: allow compression of files without blocks" sent earlier this day.

 fs/f2fs/file.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index daaa0dfd2d2e..0c3ae5993b7a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1873,10 +1873,7 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 		if (masked_flags & F2FS_COMPR_FL) {
 			if (!f2fs_disable_compressed_file(inode))
 				return -EINVAL;
-		}
-		if (iflags & F2FS_NOCOMP_FL)
-			return -EINVAL;
-		if (iflags & F2FS_COMPR_FL) {
+		} else {
 			if (!f2fs_may_compress(inode))
 				return -EINVAL;
 			if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
@@ -1885,10 +1882,6 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 			set_compress_context(inode);
 		}
 	}
-	if ((iflags ^ masked_flags) & F2FS_NOCOMP_FL) {
-		if (masked_flags & F2FS_COMPR_FL)
-			return -EINVAL;
-	}

 	fi->i_flags = iflags | (fi->i_flags & ~mask);
 	f2fs_bug_on(F2FS_I_SB(inode), (fi->i_flags & F2FS_COMPR_FL) &&
--
2.36.1
