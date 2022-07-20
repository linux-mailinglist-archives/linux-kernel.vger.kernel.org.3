Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE0E57B127
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 08:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiGTGdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 02:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiGTGd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 02:33:29 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2272154073;
        Tue, 19 Jul 2022 23:33:29 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id b133so11901866pfb.6;
        Tue, 19 Jul 2022 23:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ip8sfT3MomUNm29brPu+2k5VsrDURTEoCZs6KvoAjCg=;
        b=mPCN2m2YAamRuXjOWWlyImJNiFeyt9Ei44tMgjZzOD0xokfqaWnWh0tbE50km4Eq9u
         gaRLkV6Wbul9wu4a6BAlyq1P6IAJe11QlDd5TJGgVQft0yuno8FMpFEOe9OMGhbQQiXF
         ovmm3I8q+Vtmunej3wNf5sPEVr7GUPp0uSN9lDzGqtV/8Ll1xU4+P2+7KefkLjQyxztT
         5Dno5OwJ1iWi3FF1bV6r/RvY/g5k32Zoi5RXelQJNeIz5K19w7BDpIWXnWlyiPR7CmE9
         WPFM50xagworbq55Zia6FJgqN+QYxveWfeDg/afGny+xCu0hqZ5aA4XfDfODXCY1KMvP
         543g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ip8sfT3MomUNm29brPu+2k5VsrDURTEoCZs6KvoAjCg=;
        b=7gDYcp8NE20CITOs9Bysd6pCzOupHrjBIgk8Ul1StDeZciYxNylpe1UtR3zBAiGOtT
         5YAuZ/1Sn6HdwmeQlIDwbl0E13kQhPIyYV8dnYbyJ4+R1e+CTvAklJtOHGEGl0oas30y
         MgFyKkO2PKHRfAhlfqNGe663cdX+EacUNd2pNpRFozkHRsijIQ6RY1kGhRXaIMSNyddT
         sWcSCy5t00R9dPihH9Y+SNa3pRbs4xxKn5jDPGj5aV/nlRYjv7wsZDMLe+ar5KaLBUNW
         a0262Hd6CzM4JAt3rqVH4yK6AUDYwFdzqSGPT8a59Y1KZJ8bAlw81/uuvzazH66dOT8O
         cCmg==
X-Gm-Message-State: AJIora8y18287BKfJ7G5+etPJpeJIvZCBhmLE/fmdBZUdwtJlWlS0mcB
        jYnXfdw2ZZ1hb2mMhq8sb//JgYHfIvtwCA==
X-Google-Smtp-Source: AGRyM1vtNy8vx+Z6wiWiOIXPrXleBmIDc6TdHARdlCBAs8Xfi+lhMhhke5DhJORFSz3+rfKvcxJygQ==
X-Received: by 2002:a63:680a:0:b0:415:aacf:d384 with SMTP id d10-20020a63680a000000b00415aacfd384mr32726461pgc.232.1658298808320;
        Tue, 19 Jul 2022 23:33:28 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.4])
        by smtp.gmail.com with ESMTPSA id y11-20020a17090322cb00b0016bf10203fbsm12955793plg.12.2022.07.19.23.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 23:33:27 -0700 (PDT)
From:   zengjx95@gmail.com
To:     reiserfs-devel@vger.kernel.org
Cc:     willy@infradead.org, jlayton@kernel.org,
        damien.lemoal@opensource.wdc.com, jack@suse.cz,
        edward.shishkin@gmail.com, linux-kernel@vger.kernel.org,
        Zeng Jingxiang <linuszeng@tencent.com>
Subject: [PATCH] fs/reiserfs/inode: remove dead code in _get_block_create_0()
Date:   Wed, 20 Jul 2022 14:33:10 +0800
Message-Id: <20220720063310.992149-1-zengjx95@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zeng Jingxiang <linuszeng@tencent.com>

Fix "control flow" issues found by Coverity
Logically dead code (DEADCODE)
Execution cannot reach this statement.

Assigned_value: Assigning value NULL to p here
293	char *p = NULL;
In the following conditional expression, the value of p is always NULL,
as a result, the kunmap() cannot be executed.
308	if (p)
309		kunmap(bh_result->b_page);

355	if (p)
356		kunmap(bh_result->b_page);

366	if (p)
367		kunmap(bh_result->b_page);

Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
---
 fs/reiserfs/inode.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index 0cffe054b78e..d1b0c7645fcb 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -305,8 +305,6 @@ static int _get_block_create_0(struct inode *inode, sector_t block,
 	result = search_for_position_by_key(inode->i_sb, &key, &path);
 	if (result != POSITION_FOUND) {
 		pathrelse(&path);
-		if (p)
-			kunmap(bh_result->b_page);
 		if (result == IO_ERROR)
 			return -EIO;
 		/*
@@ -352,8 +350,6 @@ static int _get_block_create_0(struct inode *inode, sector_t block,
 		}
 
 		pathrelse(&path);
-		if (p)
-			kunmap(bh_result->b_page);
 		return ret;
 	}
 	/* requested data are in direct item(s) */
@@ -363,8 +359,6 @@ static int _get_block_create_0(struct inode *inode, sector_t block,
 		 * when it is stored in direct item(s)
 		 */
 		pathrelse(&path);
-		if (p)
-			kunmap(bh_result->b_page);
 		return -ENOENT;
 	}
 
-- 
2.27.0

