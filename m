Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC645570DF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 04:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377604AbiFWCJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 22:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiFWCI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 22:08:57 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B5913D3F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 19:08:56 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id jb13so3324439plb.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 19:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gFNqrvmdrehhVYe9abTr2VyL7ULkOZ03V3dAQM99o3U=;
        b=SGChNjh3wO0ObI0jHGsZTaKlJj3CIJcWvDAzyZMCNJ5hj6FLxOS4qy55ap+u2LUvCI
         bqwQXvR7CapH0pFjzh3BET+HiW/z0nRkjuDUl0QOQfI81Be6/vScx1BbC9yeyb/eVQ3A
         vDTpwmZdpT7QKGSGK2nSVt2kcRy9ZwpW7LmeWROAoG6mtXYuBB25F0uJm3wJBfG+gUzQ
         1EYKlZZHIYqfk3D5ttHKbgtOETES9idlfX8AG+9sp5OtAldbsXf7Usx1nVc2QZFHhzGh
         24kgaU6LFPQt9MVUXtBTLAtmx4R+v7KNqM48J5/No/GwBj3Rn1fdYH1GOI4Pf6byNsC5
         QARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gFNqrvmdrehhVYe9abTr2VyL7ULkOZ03V3dAQM99o3U=;
        b=vdnDQo9EuhyF3TswEL3yj7CfqOQyOSSNvCyIMqqP1VjOlnMqmCnaSopAWyF03s8+XS
         7jqazlkCtNcWo7zziPsi5whRV/HCMnCShYdJlGgGO8hu4VgHYlLRU76EOhtKO/WV2pJC
         lmzIjH/uRqKd8SyyOMEoDddc83qMWqzx8dTXy0XE+ojOdh25KLsVN5ow+IcKB4LF6n9B
         gshAiAXmkJ8Q6M36bC111nMe2S0lO2ke+pzauUb2xnCD/czIfML2fWjyYrFmO2x/oDw/
         mTojq9mVtP60/ilbgpKI0xCgps4CCRPeg3giIjcEt/x5iFhi0XXng6Ik91xcqTFyP2pu
         ubrw==
X-Gm-Message-State: AJIora+nTXPmbYa/ORgrhLmkfCt7u9rWbHhJhpmlELjsJoWFv8xLCTLv
        Y5x9X5vZjJ5QdifyGo9R6udJcY3w93o=
X-Google-Smtp-Source: AGRyM1ut5eimvJbLkUkpUbKtQdua0qme/fASO93DfJczTES2Dr+mvKAK+7WB1CaD9RFgVQRi3RXVcw==
X-Received: by 2002:a17:90a:f314:b0:1ec:91a9:3256 with SMTP id ca20-20020a17090af31400b001ec91a93256mr1430541pjb.155.1655950136037;
        Wed, 22 Jun 2022 19:08:56 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id jg4-20020a17090326c400b001663cf001besm13090011plb.174.2022.06.22.19.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 19:08:55 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     akpm@linux-foundation.org, willy@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH v2] mm/page_alloc: make the annotations of available memory more accurate
Date:   Thu, 23 Jun 2022 02:08:34 +0000
Message-Id: <20220623020833.972979-1-yang.yang29@zte.com.cn>
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

From: Yang Yang <yang.yang29@zte.com.cn>

Not all the systems use swap, so estimating available memory would
help to prevent swapping or OOM of system that not use swap.

And we need to reserve some page cache to prevent swapping or
thrashing. If somebody is accessing the pages in pagecache,
and if too much would be freed, most accesses might mean
reading data from disk, i.e. thrashing.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
v2:
- add signoff
---
 mm/page_alloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e538dde2c1c0..233f68d31cdd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5889,14 +5889,14 @@ long si_mem_available(void)
 
 	/*
 	 * Estimate the amount of memory available for userspace allocations,
-	 * without causing swapping.
+	 * without causing swapping or OOM.
 	 */
 	available = global_zone_page_state(NR_FREE_PAGES) - totalreserve_pages;
 
 	/*
 	 * Not all the page cache can be freed, otherwise the system will
-	 * start swapping. Assume at least half of the page cache, or the
-	 * low watermark worth of cache, needs to stay.
+	 * start swapping or thrashing. Assume at least half of the page
+	 * cache, or the low watermark worth of cache, needs to stay.
 	 */
 	pagecache = pages[LRU_ACTIVE_FILE] + pages[LRU_INACTIVE_FILE];
 	pagecache -= min(pagecache / 2, wmark_low);
-- 
2.25.1

