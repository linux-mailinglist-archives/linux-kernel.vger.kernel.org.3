Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FB051594E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 02:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359771AbiD3A31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 20:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbiD3A3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 20:29:24 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259D99681A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 17:26:04 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o69so7017505pjo.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 17:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wj0GCAwyvudPRmGRRgsX12+MeUaxxTPPMDMQ7+QSvNg=;
        b=l+jK1iji/9TzBj7wkgUFu/NItPRwk6FZVFT2XJAwgjLa7CgwjRFyTekvMZlCecijWr
         Rt+D6gKOqH/P69hDamtFwIfI6eu1sOM319CwQF0hbH+l5aYNTatIGAsZJXxJ+xT0DdHr
         eHvzW17qMHRMQSmyfKli/H+Wh/zCToKvFPDZNiHmG6FkZH6gE7Rp+JIY/zAAFsrRJvdq
         5OKUiZDl62LVYIEs3Z0zCu+f/XqJ77zb1EWE6jj2Z5/Iz+yFG0O9EhK72C8Dbe8uln+B
         L/XaS/44KYb+2TvpdnAvY3wrU9/4t/BoYR9bYSKw5yz2JnLTIVPmuVnEnGfqd5BrqZ1E
         S4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wj0GCAwyvudPRmGRRgsX12+MeUaxxTPPMDMQ7+QSvNg=;
        b=OGx3TXZKsyK7bd01P9BBzwnqNgVKVsmLHgwlbdKY1STZ+VC55GTQ99EdTtSVCX0aoV
         Yo6LpUj3J4xb5u/ocVmdClulWjy2Apx1u+sg/Ljr48bQxjA+Il6mZVPcD+C7PSVcsVLv
         iwrSux4dWaGij2D6Ksq47524LBiA7OCCBjQhzKqj/bSmLjFKXByR8dzRpf8c8MyRE3hh
         pijzBJwZZBb8RHi5a+inUA497iiz6/uW6zq2BD8yrBKkOxX4pCT9F5fqX4E9qguNdBJw
         Zijv5Q+c0TDnKG4JQQhhhTVCjvFQtqZmaT+QNAMYOigVMYdyQNDLM3pdpDfULbgI+Ms1
         HG2w==
X-Gm-Message-State: AOAM531EcojkkpSvURBj8fffCzkSzILPpJ731wXUYBsNQ9gNk1dQ/f2k
        XGXejT5FOhW5RbPEnFQjX/4=
X-Google-Smtp-Source: ABdhPJwbC29ym+34xajMXMcVDFqWB0hl6bj7vlrp2zq9ZwucXZYdNW6X1oLcnNgIex9U5/T1FF2XEw==
X-Received: by 2002:a17:902:82c9:b0:15d:3a76:936f with SMTP id u9-20020a17090282c900b0015d3a76936fmr1733796plz.139.1651278363471;
        Fri, 29 Apr 2022 17:26:03 -0700 (PDT)
Received: from localhost.localdomain ([125.131.156.123])
        by smtp.gmail.com with ESMTPSA id u12-20020a170902e80c00b0015e8d4eb25fsm181271plg.169.2022.04.29.17.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 17:26:02 -0700 (PDT)
From:   Wonhyuk Yang <vvghjk1234@gmail.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Wonhyuk Yang <vvghjk1234@gmail.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [Patch v3] mm/slub: Remove repeated action in calculate_order()
Date:   Sat, 30 Apr 2022 09:25:55 +0900
Message-Id: <20220430002555.3881-1-vvghjk1234@gmail.com>
X-Mailer: git-send-email 2.30.2
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

To calculate order, calc_slab_order() is called repeatly changing the
fract_leftover. Thus, the branch which is not dependent on
fract_leftover is executed repeatly. So make it run only once.

Plus, when min_object reached to 1, we set fract_leftover to 1. In
this case, we can calculate order by max(slub_min_order,
get_order(size)) instead of calling calc_slab_order().

No functional impact expected.

Signed-off-by: Wonhyuk Yang <vvghjk1234@gmail.com>
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---

 mm/slub.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index ed5c2c03a47a..1fe4d62b72b8 100644
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
+	order = max_t(unsigned int, slub_min_order, get_order(size));
+out:
 	if (order < MAX_ORDER)
 		return order;
 	return -ENOSYS;
-- 
2.30.2

