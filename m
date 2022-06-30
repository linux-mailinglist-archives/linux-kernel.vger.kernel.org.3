Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD4856191B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbiF3L0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbiF3L0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:26:44 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1914507B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 04:26:43 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id o18so16786318plg.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 04:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/QWnWQZOHsPg9TekwAFOUwpYu4RmqUhD1lw7F3VzOwI=;
        b=D33t8BX/qMfkIJXaxFFUsnMMUHOyWDb1Y6hmRH9SZ+al09qzBn0tqtk9qp1hmuBYaj
         ICEWlm5DoP2uZjQG9wQqhLmzpkVD7yJsBRfP+vdreSS17o6DvfV1Nb38t22O50ybakBb
         QH4HUR6ZZ+Z7ObpQV8na4DjXBRkk3MklnY74HTo8hdvGIAHAb0l/pOm9qAAeOX/JwpTX
         GN2wERyMXNEtejs8iVZlF+vN/5IVOaTgNnsXaAyVb75uEUlFOPIPHyOuH+7ql2PXqZqn
         fOev2GIBFexbrdcFU0KVj0irqBvceMF6PnA5DfdAzJ+vX1jSN/ZymGqm1ARGl4vsDgwI
         /vWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/QWnWQZOHsPg9TekwAFOUwpYu4RmqUhD1lw7F3VzOwI=;
        b=phc/8FGPPySFM7KxdgWBAmaTr0nAAxu7cCOD9uRjks92hOI/h0byUae99qDaTghApF
         yke4ivzGD2DSdltnkpxUHbMOWm7zLADj2qJp0Dzew0viMgH2EVc+ENFz1oae7gPuNX7m
         rZCG4m8ox8sJAg8hvAGJtTSnHy4R1XdxWwa2s+0gSQFEp7uOBUpwprq0BivHzZJ6xJwF
         nSxcz5hyboydSmkoaYo4DQuzSo35S4ORYZl4FBRFBm4ORi5TaPQwiZX29ckpjYsYaiOF
         WCXSE0T8CHb/MzxhZslOLTqHWETO0WugL5t1TJTtEMPnfn/kl5gnf1fESoiRmRPkCLwR
         6V9Q==
X-Gm-Message-State: AJIora8ZljJzQO9GrUUehrjB5vD1PePnLPgL+vF0Fw3/3gb27rwXT63/
        rho5noCp2uVlXtwSN5Ug+jhYMmVrpbTtthi5
X-Google-Smtp-Source: AGRyM1t1yuX1kimrdl1mLic0T2PGJbcd4R9nhPE94hxmhrwiFq1P3gwLkvbNvMTlcHZEwVQ7aygskA==
X-Received: by 2002:a17:90b:1e06:b0:1ec:b513:4523 with SMTP id pg6-20020a17090b1e0600b001ecb5134523mr11666097pjb.58.1656588403407;
        Thu, 30 Jun 2022 04:26:43 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([43.224.245.232])
        by smtp.gmail.com with ESMTPSA id iz19-20020a170902ef9300b0016378bfeb90sm13247053plb.227.2022.06.30.04.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 04:26:42 -0700 (PDT)
From:   Guowei Du <duguoweisz@gmail.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, duguowei <duguowei@xiaomi.com>
Subject: [PATCH 7/7] f2fs: optimize shrink count
Date:   Thu, 30 Jun 2022 19:26:29 +0800
Message-Id: <20220630112629.6611-1-duguoweisz@gmail.com>
X-Mailer: git-send-email 2.36.1
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

From: duguowei <duguowei@xiaomi.com>

Remove the local variable 'run_no', add comments for better
reading.

Signed-off-by: duguowei <duguowei@xiaomi.com>
---
 fs/f2fs/shrinker.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
index dd3c3c7a90ec..7e439496dfca 100644
--- a/fs/f2fs/shrinker.c
+++ b/fs/f2fs/shrinker.c
@@ -76,18 +76,18 @@ unsigned long f2fs_shrink_scan(struct shrinker *shrink,
 	unsigned long nr = sc->nr_to_scan;
 	struct f2fs_sb_info *sbi;
 	struct list_head *p;
-	unsigned int run_no;
 	unsigned long freed = 0;
 
 	spin_lock(&f2fs_list_lock);
-	do {
-		run_no = ++shrinker_run_no;
-	} while (run_no == 0);
+	shrinker_run_no++;
+	/* if overflow, next loop needs to skip number 0 */
+	if (!shrinker_run_no)
+		shrinker_run_no = 1;
 	p = f2fs_list.next;
 	while (p != &f2fs_list) {
 		sbi = list_entry(p, struct f2fs_sb_info, s_list);
 
-		if (sbi->shrinker_run_no == run_no)
+		if (sbi->shrinker_run_no == shrinker_run_no)
 			break;
 
 		/* stop f2fs_put_super */
@@ -97,7 +97,7 @@ unsigned long f2fs_shrink_scan(struct shrinker *shrink,
 		}
 		spin_unlock(&f2fs_list_lock);
 
-		sbi->shrinker_run_no = run_no;
+		sbi->shrinker_run_no = shrinker_run_no;
 
 		/* shrink extent cache entries */
 		freed += f2fs_shrink_extent_tree(sbi, nr >> 1);
-- 
2.36.1

