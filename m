Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26735885E9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 04:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbiHCCvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 22:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiHCCvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 22:51:31 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF6613DEB
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 19:51:30 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so691792pjf.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 19:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SubjzKtYxDwDh8eAZSjb5LF7LaekSyXiSzaHJbGx46c=;
        b=0k+LPPDqot9w/ei6bhu8Saf19+jwJhCTiXVlPLOiH/apZc7EFs3Jc+LWVAZKLQqUtC
         y+zMdBbTj1vycCfeQN1LSjk7sMgFcCtm//nvZ6T8KNJWwAz19dvxAioiNSoj7NGR9pbs
         UpJkZNpYjowp/VWxNUKWywkbIGgE9KdbRsJqu70co7fJquTjPPUGw5HYby10E/dpDGwG
         ZkG9oTuCG5VE2yAbA75L3rn1i1hzt8vuJQTcqKin+iOPBMkzwUTWgCCL4k09JXl1eijO
         DP+088+KezS65c5G80sgmL0p6Z4gbVYCLfoWe8pNYfAVGUkqUGSVvbdGFi0d2oBBh5DA
         8ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SubjzKtYxDwDh8eAZSjb5LF7LaekSyXiSzaHJbGx46c=;
        b=zWIWpDUO2jtTKyB0giIuVZX956g2ic5QmXqHFrFSFk8QVPyqoNxnmaeLI41SpJ5K8X
         z12MiWygqf8Rz0pKiTwRA58jNKkdi0ckOE0OIfmHkxZml29+LYVg+m1kw38ZryV++9cz
         gLdMO5bAImiYihRexh2LQ+LoEKoSU+ZO38In5whpbaQ6laA1ZMy8vWIh4HkFa5rvw4Zv
         tQzOrk5MxpfM1Ksxe0/rJN2U+kWQ6VC5xJslp+HrdE8DB5Fp8HUmsHe0bMwbu9wIpCtO
         B6GiLNWH3dY+G2WlEycOmJz629/aHhjD76LBuZ6FVb9dD0wVWSJJS0t8v2M5MHev2Vyn
         9MdQ==
X-Gm-Message-State: ACgBeo1LZjHtzZ4AG5uyxBtTbEMZRE0+MQFqaYxsPbvfZw1tlSjGQ7S9
        HzPT0ZGnst27J7f3i5S2kzekNQ==
X-Google-Smtp-Source: AA6agR6uAIymTe7SBs7hQLYRkzepfVqH5J0cZPr2b2QFOnfJKDV5zb6tsgX3vckF3HVoYYBWmgo0sg==
X-Received: by 2002:a17:902:bd8a:b0:16c:dfcf:38ba with SMTP id q10-20020a170902bd8a00b0016cdfcf38bamr23775277pls.35.1659495089834;
        Tue, 02 Aug 2022 19:51:29 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902d2cc00b0016da68b09b3sm444774plc.87.2022.08.02.19.51.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Aug 2022 19:51:29 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH] mm/page_alloc: only search higher order when fallback
Date:   Wed,  3 Aug 2022 10:51:21 +0800
Message-Id: <20220803025121.47018-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems unnecessary to search pages with order < alloc_order in
fallback allocation.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e008a3df0485..0abafc2fc3e0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2934,7 +2934,7 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 	 * i.e. orders < pageblock_order. If there are no local zones free,
 	 * the zonelists will be reiterated without ALLOC_NOFRAGMENT.
 	 */
-	if (alloc_flags & ALLOC_NOFRAGMENT)
+	if (order < pageblock_order && alloc_flags & ALLOC_NOFRAGMENT)
 		min_order = pageblock_order;
 
 	/*
-- 
2.31.1

