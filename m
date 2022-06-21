Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B69552B46
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 08:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346222AbiFUGqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 02:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346202AbiFUGqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 02:46:34 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6E01C121
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 23:46:33 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id k127so7011962pfd.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 23:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JI5187A/roVo6JAbOBFXjnebVpVgrehVAoIVRGh0e44=;
        b=FrXBiLnBfk7eFPJKW6Gs5IKtpFdUBAPc6uwr6+eSP2SzABCpb7yrfxCn5YRntMh9Kg
         VfQEb4+xfRce7XuCdKObakYlW9+58/BWhmZEJiaXm/YmvOyhWBCcimbvtzn7ywmmbxBd
         ILgZg1pgFC/WEKM154UsesXVjDBOfvtpZbfdio7UlTYbrchMMh5+nJEkP1WnsXbsrTC/
         SubEcYEBYrTVLvtxUD68hcJeDY7xcvzCZrwng2nBwF2cfzKpyRVACqDaufI3Xd+4v1Ix
         JepineKyh+NyAmKYnxZjL4TWGK7keAwOypf/JfNGGhy1JYSrbS3g8UbvB0GwONwdFBYM
         NjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JI5187A/roVo6JAbOBFXjnebVpVgrehVAoIVRGh0e44=;
        b=IoqYwiZvmS6kbormw/5PWilSBG1ry9n33qPJuAd94Vmx8ib/mBYk8XM4O+KEw1eK5n
         D0CWPv9BB+xdwWNwTmfSUItNMoc2gt2c2/1mignJ5oI9yz2DGFuPy6QQM0mtioPTL4uj
         0d8VxHAodhKXLtiXUu5c3f+Fui6V/+ockQxVdg66h81ZbNJi12/y1ZOSrsQ4d0YpFUHn
         wWTF1aHBjxR5cWxnqBBwylcCyAH9V8Rerj3ZROux5DSMNC7W/ZHuyR03773mzA1nDjUn
         BYp/MKUxcJ7t81BIHBh2rq0ESiFAzvLTdjX0sdy4Fdyxdanh+oZqx5TusBVypK6cNH4G
         vLpw==
X-Gm-Message-State: AJIora9C0EiRlLXFhWrHRoU9plR1IMdcBHcfBrwtCNo1rNR0pV5Ls4iD
        Iipr8iPlP+DrFk5Ma3DeX+k=
X-Google-Smtp-Source: AGRyM1sWxhn1YJDFuMUpYnrb9WUa5XI5GyMrWbeFjTWiF4Ic/BDExoj4a5wCCu0/L6ZPm9rIbGYNMQ==
X-Received: by 2002:a05:6a00:410a:b0:51e:6fc6:e4da with SMTP id bu10-20020a056a00410a00b0051e6fc6e4damr28721999pfb.84.1655793993060;
        Mon, 20 Jun 2022 23:46:33 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902654a00b0015e8d4eb29csm9709043pln.230.2022.06.20.23.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 23:46:31 -0700 (PDT)
From:   Chao Liu <chaoliu719@gmail.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
        Wayne Zhang <zhangwen@coolpad.com>,
        Chao Liu <liuchao@coolpad.com>
Subject: [PATCH] f2fs: allow compression of files without blocks
Date:   Tue, 21 Jun 2022 14:42:02 +0800
Message-Id: <20220621064202.1078536-1-chaoliu719@gmail.com>
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

Files created by truncate have a size but no blocks, so
they can be allowed to enable compression.

Signed-off-by: Chao Liu <liuchao@coolpad.com>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2d1114b0ceef..daaa0dfd2d2e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1879,7 +1879,7 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 		if (iflags & F2FS_COMPR_FL) {
 			if (!f2fs_may_compress(inode))
 				return -EINVAL;
-			if (S_ISREG(inode->i_mode) && inode->i_size)
+			if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
 				return -EINVAL;
 
 			set_compress_context(inode);
-- 
2.36.1

