Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14546503466
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 08:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiDPGNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 02:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiDPGNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 02:13:44 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BDC3B285
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 23:11:14 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g12-20020a17090a640c00b001cb59d7a57cso8735350pjj.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 23:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bcOfBPL4OuuAG640SlARJZ6hb/FVaA7pZLG+NuBAIqI=;
        b=Nr9bl2Lz08LmMiCuXk2WBYjQ3ZmKPTXuZQS2+uFJ1CoadNQabr40ys3p22cNkg5BVK
         1YThbJeevQDiujyTY5YVNqtAHT3QCkw8t8GqlDOPZncNJOwVv6YZASYqUOgZKLdCZrBk
         9uPzDp1xjIrM3BjF1GsOjQjEOBi9oVUyqDErGdsYMM1O7hcf4dQWeuAQXk9IJHMBI0Sc
         V5cM2SGK1bWWxG67Si3NMEFkZDJTU9PFGhrRMJkRVqgHwCtkOKJSIdo1PvQgJuPoVTJH
         m0cTAELczTDhfJZKRRlon7bckFWhPdp0Qg9syoOVaLdTXxEHxyp/4D2B8Pg/okgVQhCV
         gFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bcOfBPL4OuuAG640SlARJZ6hb/FVaA7pZLG+NuBAIqI=;
        b=dvvgcJWdEBWTTVzCZ7sh2VreseDzNUt2nMJo8UFewxsVnyLMRbSfM+24zcCP80obVz
         VMKy+AHfmPFe0icA0ZYidQkvW5VbFVuR+yLk1dNKf7JCa8rex6QSu0UKv3dyGgj0I+8/
         okQRhaPRgu/fMWHydllfmx7Wh9X39Ifk7tk583JUH21HJmcsonOZCrQfLsYhJKRD5Fil
         vU7FT9AFmdOjs16Wy+l5fpwQhNvyPrfxjFcxjRSOA4qKEQh3TypActbmpD0gcC9ZXGCo
         73Sr2bhgR8IWr/UaRDPZGORit+HUO/z347Rtg4JaDkKKRYgVzhX7TSkStuS0knNWKpX7
         wGJg==
X-Gm-Message-State: AOAM533HWLb+fZQlqABn1o9jJ38ea0sy2qr9HAPk7fqRY0twwW8MSvzX
        C5kHe+wGbZTx+TOW/y1C2JM=
X-Google-Smtp-Source: ABdhPJwepZdppnnzYaQcm1cA/smdaAO5t6Oc4XxNF8dETGCwvJW/qEmZficFIgsPqhVBdyUuKHNRHA==
X-Received: by 2002:a17:90b:1642:b0:1c6:c6d0:fbfa with SMTP id il2-20020a17090b164200b001c6c6d0fbfamr2466474pjb.218.1650089473414;
        Fri, 15 Apr 2022 23:11:13 -0700 (PDT)
Received: from localhost.localdomain ([125.131.156.123])
        by smtp.gmail.com with ESMTPSA id n12-20020a17090a670c00b001cbb7fdb9e4sm10428029pjj.53.2022.04.15.23.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 23:11:12 -0700 (PDT)
From:   Wonhyuk Yang <vvghjk1234@gmail.com>
To:     vvghjk1234@gmail.com, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/slub: Remove repeated action in calculate_order()
Date:   Sat, 16 Apr 2022 15:11:04 +0900
Message-Id: <20220416061104.481674-1-vvghjk1234@gmail.com>
X-Mailer: git-send-email 2.30.2
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

To calculate order, calc_slab_order() is called repeatly
changing the fract_leftover. Thus, the branch which is not dependent
on fract_leftover is executed repeatly. So make it run only once.

Plus, when min_object reached to 0, we set fract_leftover to 1.
In this case, we can calculate order by max(slub_min_order,
get_order(size) instead of calling calc_slab_order().

No functional impact expectd.

Signed-off-by: Wonhyuk Yang <vvghjk1234@gmail.com>
---
 mm/slub.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index ed5c2c03a47a..e7a394d7b75a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3795,9 +3795,6 @@ static inline unsigned int calc_slab_order(unsigned int size,
 	unsigned int min_order = slub_min_order;
 	unsigned int order;
 
-	if (order_objects(min_order, size) > MAX_OBJS_PER_PAGE)
-		return get_order(size * MAX_OBJS_PER_PAGE) - 1;
-
 	for (order = max(min_order, (unsigned int)get_order(min_objects * size));
 			order <= max_order; order++) {
 
@@ -3820,6 +3817,11 @@ static inline int calculate_order(unsigned int size)
 	unsigned int max_objects;
 	unsigned int nr_cpus;
 
+	if (unlikely(order_objects(slub_min_order, size) > MAX_OBJS_PER_PAGE)) {
+		order = get_order(size * MAX_OBJS_PER_PAGE) - 1;
+		goto out;
+	}
+
 	/*
 	 * Attempt to find best configuration for a slab. This
 	 * works by first attempting to generate a layout with
@@ -3865,14 +3867,8 @@ static inline int calculate_order(unsigned int size)
 	 * We were unable to place multiple objects in a slab. Now
 	 * lets see if we can place a single object there.
 	 */
-	order = calc_slab_order(size, 1, slub_max_order, 1);
-	if (order <= slub_max_order)
-		return order;
-
-	/*
-	 * Doh this slab cannot be placed using slub_max_order.
-	 */
-	order = calc_slab_order(size, 1, MAX_ORDER, 1);
+	order = max_t(unsigned int, slub_min_order, (unsigned int)get_order(size));
+out:
 	if (order < MAX_ORDER)
 		return order;
 	return -ENOSYS;
-- 
2.30.2

