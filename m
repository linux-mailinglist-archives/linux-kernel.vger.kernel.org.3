Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EE2599701
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347683AbiHSIR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347584AbiHSIRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:17:07 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3297BE192F;
        Fri, 19 Aug 2022 01:17:05 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id y4so3551828plb.2;
        Fri, 19 Aug 2022 01:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=sWp63BpVW8U7jAJS0MU5jHAUsPkleFN5R+CfvsKi3C8=;
        b=C6E1jDISCgMWDW9pnZhE7J0+TOlfLs/SL0BvEnbhBl1cOaLOXPUkG0PsMKXga8lGMf
         S2wHURTITV1Rq9JkhGaTwKlby/7FSHfRAIPScHpHSMT3YjsBMELwfC8ipcrB464GrD9h
         ZnJjlI6vdcoh0J+8Cyay7v86g01ubH4NdCXSZqylVbyit+YHsruhkTAkIT62SuJ09kiX
         hwh+ogQuE+SpWKDkY7qLQNHDWxp287xo5wQ7QCtE/P9sEfHcRkIJGifHtkQfRbJUcGHY
         RNGtxDVImZlWR/qzbM2CWJPwn243C+fiGciyO9ooeAdtPheFINVJaw6zGFirPIHpyXvj
         1oSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=sWp63BpVW8U7jAJS0MU5jHAUsPkleFN5R+CfvsKi3C8=;
        b=5Ehr7Wpj4N+TbuPElcD5Gbfv7CB3mvwFoY0WTNksWswo6nQMm7wjN3QjXOIJwr150F
         HvzDQROkoQ3hmgx0Vz4uNaJmiqgyC8Ym0Ax5OQvx9zfAJ4gECnmPfkcviDt06rrshq3d
         jB4DQI3yH4chjcH5GZ8x5HvEsaX9bjd48HZNkRqZX19QuEmvFkjSmHH5Mcwh5YkVLUiO
         w/RhqBDBXY1JiMgAGed5QshP0XIKAzXjQomBkZ6KNigUoRYShNaHdwkb7M3DqRhaZQMJ
         1mWkF6e6wzAzNM6nMWt2QYrNdAo2Jx/GS0aEnHKq2bPueDHHvDjH5CXRKcvIG/a5P1jt
         +WZA==
X-Gm-Message-State: ACgBeo0rg+GzzY7oALQ87KwYpZkFvnaoD7RgzaEvmA92YTJGvQngjqdX
        XsX6TW34kPyoCSoPtEwmR22NiZorRmo=
X-Google-Smtp-Source: AA6agR7VK+ZQDhU10x5yVImCqMsR5CNFnTX5ANRWf4TRJlqrO+8+IxA88g3tYPj+KKOdAgJ2e6eScg==
X-Received: by 2002:a17:90b:1bc7:b0:1f5:37a6:e473 with SMTP id oa7-20020a17090b1bc700b001f537a6e473mr6995083pjb.87.1660897024753;
        Fri, 19 Aug 2022 01:17:04 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b00172a6cf0a84sm2631032plg.124.2022.08.19.01.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:17:04 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     konishi.ryusuke@gmail.com
Cc:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] nilfs2: delete unnecessary checks before brelse()
Date:   Fri, 19 Aug 2022 08:17:00 +0000
Message-Id: <20220819081700.96279-1-chi.minghao@zte.com.cn>
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
 fs/nilfs2/btree.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index f544c22fff78..b3b5a46488c2 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -1668,8 +1668,7 @@ static int nilfs_btree_check_delete(struct nilfs_bmap *btree, __u64 key)
 	maxkey = nilfs_btree_node_get_key(node, nchildren - 1);
 	nextmaxkey = (nchildren > 1) ?
 		nilfs_btree_node_get_key(node, nchildren - 2) : 0;
-	if (bh != NULL)
-		brelse(bh);
+	brelse(bh);
 
 	return (maxkey == key) && (nextmaxkey < NILFS_BMAP_LARGE_LOW);
 }
@@ -1717,8 +1716,7 @@ static int nilfs_btree_gather_data(struct nilfs_bmap *btree,
 		ptrs[i] = le64_to_cpu(dptrs[i]);
 	}
 
-	if (bh != NULL)
-		brelse(bh);
+	brelse(bh);
 
 	return nitems;
 }
-- 
2.25.1
