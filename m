Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF85599705
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347578AbiHSIOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347548AbiHSIO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:14:27 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837109924E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:14:25 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id jl18so3549517plb.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=YK37fFdxLSTLBwKIRdkAwKxJnG2ZI8b2iX/XtEeoxb8=;
        b=mTJDa6KMUFTeqd2hiqbB5ggy9Y2CmV2kSoT+vJDmSsWSteqRm0JgdBw3UekV5vJ1jn
         lyVb2FcbtdLY1BNBQVLwZw6AOpxPZLAfzrx5HvgCAd8t9LgOg0hZYeDVL3/8lAPfj6/4
         +N5+6qa9Ld8M4oh1E3pmTXpSkOxEMlN+2rCiVB1V7JRRS7ArQGqxm7qQypj9ezDIB3W8
         7+etly5cxopqbuKeUynwFbrAi2GlvXNgw4eWox9rhcWyMo76yjo2sFVI/ICvLZEhfYEo
         fivnebYulH1dWVveHLuCYrxthe16WE8pQjy1HCD5iW1A631WLYEmC5bHJC1DN+IlMaFa
         4uVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=YK37fFdxLSTLBwKIRdkAwKxJnG2ZI8b2iX/XtEeoxb8=;
        b=K+rDAdTGB59uiZF+DzBDHEuZcvlDthM5UL+eWXYei+P/DoUdG6riz4LPVyIH3Bks+9
         Q2RAcA8pU1pkJI1tpPLKnT/xWWbHAvkNueu1SWyZ1yBDmP8Thoe3Hzr9/9Io8/Clw8UX
         reiJCTe1IEUqtQbA3DnpGosvb+NWj7YiDPZSKOCnsCu/YouRLH2h9N2uja6dHDDJqw86
         desl/F2VlZ7FYZqPAjMp6VKB2BDwS9aWnD1tL/HCUaNz1QiAhPTgT44EHQn+3eE7Do5D
         pAIo6Dmb7LsmYSl7s7XG8fY5Nb/fp6cv6ho6268Ti+QKod5xju12YS7ZqkC3/jPBXWtU
         3hrg==
X-Gm-Message-State: ACgBeo1KLV3J380rp2VjNVPdyW91gbCHERZVW1gOOhCsWgrYy7TtPQ7v
        8c+jhvQIOJng6Xb9gEN/ldE=
X-Google-Smtp-Source: AA6agR6t540+Ntz21IPw/ZU6P7bhAJM7aQPuAfkvlHTFsGjsWRX55apDy4hRfxQgVLHgAxoxLyFb5g==
X-Received: by 2002:a17:90b:1d89:b0:1f5:a59:46b1 with SMTP id pf9-20020a17090b1d8900b001f50a5946b1mr7029025pjb.173.1660896865062;
        Fri, 19 Aug 2022 01:14:25 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090332cb00b0016892555955sm2632351plr.179.2022.08.19.01.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:14:24 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     roman.gushchin@linux.dev
Cc:     songmuchun@bytedance.com, tytso@mit.edu, jack@suse.cz,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] isofs: delete unnecessary checks before brelse()
Date:   Fri, 19 Aug 2022 08:14:20 +0000
Message-Id: <20220819081420.96209-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

The brelse() function tests whether its argument is NULL
and then returns immediately.
Thus remove the tests which are not needed around the shown calls.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 fs/isofs/inode.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 88bf20303466..df9d70588b60 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1277,13 +1277,11 @@ static int isofs_read_level3_size(struct inode *inode)
 	} while (more_entries);
 out:
 	kfree(tmpde);
-	if (bh)
-		brelse(bh);
+	brelse(bh);
 	return 0;
 
 out_nomem:
-	if (bh)
-		brelse(bh);
+	brelse(bh);
 	return -ENOMEM;
 
 out_noread:
@@ -1486,8 +1484,7 @@ static int isofs_read_inode(struct inode *inode, int relocated)
 	ret = 0;
 out:
 	kfree(tmpde);
-	if (bh)
-		brelse(bh);
+	brelse(bh);
 	return ret;
 
 out_badread:
-- 
2.25.1
