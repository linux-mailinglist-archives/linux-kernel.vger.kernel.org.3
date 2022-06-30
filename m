Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CB9560FD8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 06:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbiF3EBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 00:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbiF3EBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 00:01:12 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862E23916C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 21:00:55 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id o18so15924192plg.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 21:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ggFb66b2FdfhJM6RYYDPcnqe4LFasg+9yoyX1GLgz8Y=;
        b=CavkeJHNbx4rkrcSihwEKVaSnfnToWrzXmPPuZwWD2q9V+Elv2sx4sI+VUX/PRDEt9
         Uuef9hwROdzCDzEQ2nZCVjNrHGYKtRjbXK5SD4FC1BJlVhNEz4mG/irTrl7ILMM8ZuqU
         SI5Qf/Ho7NrZjIKipFa+dgpfp7HPDmEOpRifYfgEmUBhXlrjDmD8ulMgRL4Lq8wFfI3m
         fq1A938sdkXA1Z/jIDtBdt0BidtmURD3HYrMatm6VOswiyTuDnH/r+U3OoUzbt9e1WOg
         pQRrZBH0Qqbm0TEGFf2kUUKpLD/kLgiC4zXzXZ2KAkSvXbsuS3sVr+udshl/UgCKcAUm
         l+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ggFb66b2FdfhJM6RYYDPcnqe4LFasg+9yoyX1GLgz8Y=;
        b=oyDaqDsrOQGfilg8Y1LfjZmPDcmm+g4IJjxaa5q9MZQk8Z6Ui98vbuzslNoDZd7NYO
         RANNJ7NJzW6DqJfb7qU20IEH9aiSWrlzrSmUZ7JtVuLz0Y8UAI4AHC+fMvODvQE47peM
         6W2Nd8x7T+3+lI0eBSg8gGg70hCSeS8AEQvr+vY8qLv2vwOHlNFe6GwyzvtXXslXeNLt
         Tm+8oa46/mA/4PX1mvgd/8mEQnnqPs6ox84elptbDmcYlEWFoxGx8jLPKuxWFKyb2C9v
         z4k0Txn3dQVIXWoAZPuNu5B5xdn5CYYO6jXg+0eY6Uw4N43CJrTj5cBdfpQ3psUZJ4vd
         mKyQ==
X-Gm-Message-State: AJIora88sCuRH0AEDxwBPa1TtoXnGSrf3RqAFAQOMP91A9Fby6DQoF1A
        tpL9beATdvGFkOZeyOckWGsUMoyG198YWg==
X-Google-Smtp-Source: AGRyM1tf8y61iQUgmX0fbGLuWJi8dr4R2Tf9rJwcHZU796RX76U7NBtf053AViT9J+jWOfyNh2LgVQ==
X-Received: by 2002:a17:90b:390c:b0:1ec:ae13:c5aa with SMTP id ob12-20020a17090b390c00b001ecae13c5aamr9553485pjb.64.1656561655015;
        Wed, 29 Jun 2022 21:00:55 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902f7cd00b001651562eb16sm12203020plw.124.2022.06.29.21.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 21:00:54 -0700 (PDT)
From:   zys.zljxml@gmail.com
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, katrinzhou <katrinzhou@tencent.com>
Subject: [PATCH] kernfs: fix potential NULL dereference in __kernfs_remove
Date:   Thu, 30 Jun 2022 12:00:47 +0800
Message-Id: <20220630040047.3241781-1-zys.zljxml@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: katrinzhou <katrinzhou@tencent.com>

When lockdep is enabled, lockdep_assert_held_write would
cause potential NULL pointer dereference.

Fix the folloeing smatch warnings:

fs/kernfs/dir.c:1353 __kernfs_remove() warn: variable dereferenced before check 'kn' (see line 1346)

Signed-off-by: katrinzhou <katrinzhou@tencent.com>
---
 fs/kernfs/dir.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 6eca72cfa1f2..1cc88ba6de90 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1343,14 +1343,17 @@ static void __kernfs_remove(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos;
 
+	/* Short-circuit if non-root @kn has already finished removal. */
+	if (!kn)
+		return;
+
 	lockdep_assert_held_write(&kernfs_root(kn)->kernfs_rwsem);
 
 	/*
-	 * Short-circuit if non-root @kn has already finished removal.
 	 * This is for kernfs_remove_self() which plays with active ref
 	 * after removal.
 	 */
-	if (!kn || (kn->parent && RB_EMPTY_NODE(&kn->rb)))
+	if (kn->parent && RB_EMPTY_NODE(&kn->rb))
 		return;
 
 	pr_debug("kernfs %s: removing\n", kn->name);
-- 
2.27.0

