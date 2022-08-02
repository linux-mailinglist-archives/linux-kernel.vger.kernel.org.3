Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6757F58778F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbiHBHKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbiHBHKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:10:41 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F310C22BE3
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 00:10:40 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id x10so11946008plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 00:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=9E5lubngFnwU28P2LAysppkLSVmPXiDzv5fdAZHb7/4=;
        b=XLtYTU18C5wyOeZr8YZlzSdYR5dw+KlaE0k8rGJuLZNkfCwUqBNRhCUhcYG51wj90b
         yviAalYmCQlc5eHIh2T+AklUtSVqIv9zCqTDfuYkrN5h4aWkzKNydTDIEVk2BVfdDzFJ
         f0IOT9gFMX7Gqh1N8GutPBipKjWmf6990DE7viKsVYqu+O3uVYHbaUK1h7rBwbJlzjae
         s0adNI5Z/HW8U/Yp0aZYm/eEkJBxGvLSU4DPBoiH/R0K6sHVj4rrPQQYjt5jkey4y7I5
         lJkagyZeTXNblU1L1z5IrpP8hI1x9vXiyoD1iSdUQjOcWcSZhju+rKinLb5eIRLRHgDk
         GSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=9E5lubngFnwU28P2LAysppkLSVmPXiDzv5fdAZHb7/4=;
        b=EcSxA9sl39IQqy7+v6tQaD7FkunopwPMRzfM45yTRur+498r1CQhkx6VLJLliq3sIM
         2IjfXq7ReGiaujQwIyhKCMOg0ad5mmCpQR3CMcZz5qeznbBg3AqfPuYuLIWzj4YD6VFd
         tTnpMsTGkmcaSIryvRnIWQWJGEjCJdmfoT+3eaUA8ULtefrZVftHYpRRpZw8d6JYzuZv
         NjOWgBH4gYPQdJ0yW9dMnTE+jjRq0eujVfVToC3zhAvZxuOr0OO07p6UKLoXGGLmYELm
         1e9hnJefS8EI3nPkBFM2U79oN/5VbdycePyCC4wu9SkoMWfjjWOespaUPjQDWf4JcN/c
         mdeg==
X-Gm-Message-State: ACgBeo3xM3mNWI4wUD/+RvG+JmPaHir9xQRfI5xOzRmzMxUA/YteuWGN
        5reJgLTQaraJ2vQfcf7fkR0=
X-Google-Smtp-Source: AA6agR4GtJqs9gHhi+JMWYNyqCs4GxCH3kfQQ3Ow39hVA0MxsJ8aXFkO8k54tF9PjJ9/CZk1edja4A==
X-Received: by 2002:a17:902:d491:b0:16c:509a:ac3b with SMTP id c17-20020a170902d49100b0016c509aac3bmr20567282plg.103.1659424240410;
        Tue, 02 Aug 2022 00:10:40 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p185-20020a6229c2000000b005251f4596f0sm9971318pfp.107.2022.08.02.00.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 00:10:39 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     akpm@linux-foundation.org, hannes@cmpxchg.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] mm/vmscan: define macros for refaults in struct lruvec
Date:   Tue,  2 Aug 2022 07:10:13 +0000
Message-Id: <20220802071012.1648335-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

The magic number 0 and 1 are used in several places in vmscan.c.
Define macros for them to improve code readability.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 include/linux/mmzone.h | 2 ++
 mm/vmscan.c            | 8 ++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index e24b40c52468..795076c33163 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -306,6 +306,8 @@ static inline bool is_active_lru(enum lru_list lru)
 	return (lru == LRU_ACTIVE_ANON || lru == LRU_ACTIVE_FILE);
 }
 
+#define ANON 0
+#define FILE 1
 #define ANON_AND_FILE 2
 
 enum lruvec_flags {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b2b1431352dc..f6a54c25ac7d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3230,7 +3230,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 
 		refaults = lruvec_page_state(target_lruvec,
 				WORKINGSET_ACTIVATE_ANON);
-		if (refaults != target_lruvec->refaults[0] ||
+		if (refaults != target_lruvec->refaults[ANON] ||
 			inactive_is_low(target_lruvec, LRU_INACTIVE_ANON))
 			sc->may_deactivate |= DEACTIVATE_ANON;
 		else
@@ -3243,7 +3243,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		 */
 		refaults = lruvec_page_state(target_lruvec,
 				WORKINGSET_ACTIVATE_FILE);
-		if (refaults != target_lruvec->refaults[1] ||
+		if (refaults != target_lruvec->refaults[FILE] ||
 		    inactive_is_low(target_lruvec, LRU_INACTIVE_FILE))
 			sc->may_deactivate |= DEACTIVATE_FILE;
 		else
@@ -3559,9 +3559,9 @@ static void snapshot_refaults(struct mem_cgroup *target_memcg, pg_data_t *pgdat)
 
 	target_lruvec = mem_cgroup_lruvec(target_memcg, pgdat);
 	refaults = lruvec_page_state(target_lruvec, WORKINGSET_ACTIVATE_ANON);
-	target_lruvec->refaults[0] = refaults;
+	target_lruvec->refaults[ANON] = refaults;
 	refaults = lruvec_page_state(target_lruvec, WORKINGSET_ACTIVATE_FILE);
-	target_lruvec->refaults[1] = refaults;
+	target_lruvec->refaults[FILE] = refaults;
 }
 
 /*
-- 
2.25.1

