Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B575034B1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 09:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiDPHoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 03:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiDPHoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 03:44:07 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F71F8EEC
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 00:41:36 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id t4so10083194pgc.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 00:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YTmNGfrC+3pxkSIDNGI4Pu99E1WgWPC8IWfV/O/1jPo=;
        b=BuaJUevtcqJmCeqT9gjYj5JDfFjXqxpdLmSEYY3wyml2Ixmo/t7AumlMXEtfwsYnLz
         QT5QXdDnuywbvgo0TwQN9kjAZOnElhfXKh1CfYKSZpk2/hkTsJSJJyK2aS/mVm6T+dyP
         srFde8KDdu3+trIBgOq2ZPMXjYjG2aPkbEpDLe+tEQw1+ZnaU0NYCDEkPLvNn+qrN/vn
         DD3sp6tYHmSfb8HeauRdIoX3NYLHU5WCp65UVnrSxrf/p8clRN61C/5yg7Avdkobte1R
         Erf8GEEmFjF7N9IO+vB7BeHMAQ4mwTQqghPKnANEa5Nn3zaVbbGa15QqQ86t5Wz7yRxp
         Ob1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YTmNGfrC+3pxkSIDNGI4Pu99E1WgWPC8IWfV/O/1jPo=;
        b=Vadt6R3uZe7fZbT01R+7Y2RlPFSITUs8BuoMfcGQRWRzWwWNNM/qvccgwQd4vc9DUo
         979chF+NwbV2wJViA43HEtAM4Sv/d6fhwgV+bmzX71G2vIIyd/WJIWe9EaVSnM3g9NTR
         AKbs2Ox9VGa6AkF30iRMk5n3x49FppU/Ezn9bSHP0xLWXBjquZykHkdAFtwaqgcGQ5yy
         fpG7SdNFli4fqckexRwINzn4O/Wbs2QJCExzaE2Aev6LiFBIinY0VGP3kP70cjum/a7v
         KTX6KG3Sxx1/DJrIqlsthctdIxtbBd/7aqSsivDKIgGLIt+t+LLk4KAAXxVYewehdS97
         Uphw==
X-Gm-Message-State: AOAM533AM8hAIBc+yiBGhhjPcylDDXCOuUUn4musk5aX72ERVmAdO8sl
        w9N6qZmvcmPVS6fJRtcG6iw=
X-Google-Smtp-Source: ABdhPJx2jNKo3m5uktJcIeP3hTP5PFlKUvfSL5GX+AWVcLyenjLIBkBQzJADzIwtVmRfGoLRG8RyOg==
X-Received: by 2002:a63:ad0c:0:b0:374:50b4:c955 with SMTP id g12-20020a63ad0c000000b0037450b4c955mr2037578pgf.530.1650094895773;
        Sat, 16 Apr 2022 00:41:35 -0700 (PDT)
Received: from localhost.localdomain ([125.131.156.123])
        by smtp.gmail.com with ESMTPSA id e6-20020a056a001a8600b004fac74c8382sm5078720pfv.47.2022.04.16.00.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 00:41:35 -0700 (PDT)
From:   Wonhyuk Yang <vvghjk1234@gmail.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Ohhoon Kwon <ohkwon1043@gmail.com>,
        JaeSang Yoo <jsyoo5b@gmail.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>,
        Jiyoup Kim <lakroforce@gmail.com>,
        Donghyeok Kim <dthex5d@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/slub: Remove repeated action in calculate_order()
Date:   Sat, 16 Apr 2022 16:40:59 +0900
Message-Id: <20220416074059.526970-1-vvghjk1234@gmail.com>
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

To calculate order, calc_slab_order() is called repeatly changing the
fract_leftover. Thus, the branch which is not dependent on
fract_leftover is executed repeatly. So make it run only once.

Plus, when min_object reached to 0, we set fract_leftover to 1. In
this case, we can calculate order by max(slub_min_order,
get_order(size)) instead of calling calc_slab_order().

No functional impact expected.

Signed-off-by: Wonhyuk Yang <vvghjk1234@gmail.com>
---
V1 -> V2: Fix typo miss in a commit message

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

