Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10343599721
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347713AbiHSIT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347602AbiHSIS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:18:57 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F582CE38
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:18:25 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id 2so3576637pll.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=rLwSa6/VTW7j0kyqXcfy39gB1REZsTOlo6USC+44fKA=;
        b=DGsBTFwoasmSy8pqSB5oaI5VXpDB5tusl0fn0fcTh174La3Lmx1CKlTZw1TyAjvqNX
         iJEsIutCOHFdiZLDYKAms2+N4rFmyCcHqwpr1H06ArSaUSW5xx88NUANb8ZuSAfB4IUI
         nutUk1++EN2gKYMmhSM+s1IFBPnvzfXupx9Xt2SJJMzJXAT0cZv6hSEyDrqKCkKPgrbw
         5Z+blKOmXquLceOzlczOWj+vHCxYCVuFoPzxDUcPBFvNLmaqqsEAERF0j0qjvu51jHmX
         xYOBzkH6R3QhQnwOJqP3R/sm0yGNYEVk1EAZAhtws9dUyVMKGwqtEpaQ1QoZI0QBD1BW
         vg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=rLwSa6/VTW7j0kyqXcfy39gB1REZsTOlo6USC+44fKA=;
        b=VeRmNtnSUpLEMEfXQj53rtgLsIUbcyz5W4zvl5Hua26rNmvSo6HnWyPgvy5AaNaTO0
         WmlfD5B3eW8pBHJ9YW1/wo+b3c9DCdiTpRGWlUk4/Gl0UNqw0M6aat7LMkLADlPNXsJR
         USwnOHJuYhZxyeg6wAUAKtEfwgflLtavVDLGwEOIyels8V74CiiyeXlz+nY80ramSjjo
         z/I42aItkZEO8rqY8X7gAoh8HPGgLYYTmExnFIU+vJbgC5PWZ+dkXEZiX/OakVGa68N7
         LPAFaPWdFusy3AeU+GwxhWKZIR8WQNWPVX8IvkQoouImWMzU1++Z3d7rDaPjpEiHjec4
         la6g==
X-Gm-Message-State: ACgBeo0ObJa4ihAMjWZFqPuAQnHNgvoh+vzkvYwSGeDwJUMPtRReKWe4
        c49XgLUHPBOm7RsSFiX3wZ4KspT6/Sc=
X-Google-Smtp-Source: AA6agR4xH4C8LF3bwYBaWoMm4O4lCPvhgeUaISiC+AfOmq1Cs04/9nsTsboLSjukk+AOFUN+0gWi1w==
X-Received: by 2002:a17:90b:3008:b0:1fa:be55:d1bc with SMTP id hg8-20020a17090b300800b001fabe55d1bcmr10500791pjb.114.1660897104537;
        Fri, 19 Aug 2022 01:18:24 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id bk2-20020a056a02028200b0041c0c9c0072sm2363529pgb.64.2022.08.19.01.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:18:24 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     tytso@mit.edu
Cc:     willy@infradead.org, songmuchun@bytedance.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] fs/qnx6: delete unnecessary checks before brelse()
Date:   Fri, 19 Aug 2022 08:18:19 +0000
Message-Id: <20220819081819.96347-1-chi.minghao@zte.com.cn>
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
 fs/qnx6/inode.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index b9895afca9d1..85b2fa3b211c 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -470,10 +470,8 @@ static int qnx6_fill_super(struct super_block *s, void *data, int silent)
 out1:
 	iput(sbi->inodes);
 out:
-	if (bh1)
-		brelse(bh1);
-	if (bh2)
-		brelse(bh2);
+	brelse(bh1);
+	brelse(bh2);
 outnobh:
 	kfree(qs);
 	s->s_fs_info = NULL;
-- 
2.25.1
