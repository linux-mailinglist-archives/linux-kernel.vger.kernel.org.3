Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263225474D3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 15:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbiFKNfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 09:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbiFKNfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 09:35:10 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996EBEA8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 06:35:07 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso1868725pjk.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 06:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PbAl4kI4EWPjlfr5EPy02/EZq5DBezEwz9F8zcvz1MI=;
        b=dnfYy1ggDd7wo8E0EUz0ooEKa3e3RIH+cyYmrSJawMdt2/497OMEZjpHXu2EmIJTgb
         nJuCZZWuy9ecGkTWmAmamFLUUpVfx/rMK71INj3ws/FrC2wyib3+r3mk1abd6siXr4Ny
         79GBsLHCjeKjjzLArt7zM1+w3GHmojGfWiVQdz3pL+TZZIjjVwece4GzFn1orUzG1za8
         qaF2XaDOZr6oMomXKRoeKkJF5JK3rnkgg/8jylaoYg2JmxP4/w+PPfheNOibLgzNOrKw
         Q9hXMgF2gvN/sPVuJStrLvqsIJo3/LIAEgUuaySw3ik8ZmSyfBjy7pU7ZDePAM6zh/Xz
         N6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PbAl4kI4EWPjlfr5EPy02/EZq5DBezEwz9F8zcvz1MI=;
        b=QLbpxHYKhK1M9iss9JxbCKYAiKNHoyfFPcuoYnCfQTwRSTVUXosV95eq7YQH5LbMp7
         KTepldD6HbVtoBnqHqZJyir8Kjlp5EDpx0RS466x8BjaYXOZvQ8jbPr3z8pCMtm1kC8n
         qqk2OcY8zhfJQZomI46IHNm+ORvlzzIs6/COKvhyjJKjV0Geo7qDCsTDyGmZW67OoNF3
         IYAgkXMceaiGeruHsr+SwImIL1/jlZ6FkPXHOov5JQAIhF5sOhO7c5Dna+BFZ6apwezj
         8kxM46tccH9Xh6fhELBG0LePZf6qEntInsDlFhYov+RLqhtsQ3xQlo2GMBmb8s22P4Hp
         N4dQ==
X-Gm-Message-State: AOAM530HXfBMhiWBbNr6vPNr1FnbOjkCHfIMwlWY8j+7lJiQiVkpajxq
        4CDFPLbmvNRoAao5M1kuSjQxQg==
X-Google-Smtp-Source: ABdhPJxPfKKpT6yvYdnNGtyRN9bmpn9b67+pEOt5QIhh/nyJ4aCG49+7zcDi2vtatboK70bLeFEssA==
X-Received: by 2002:a17:90a:974b:b0:1ea:2bd3:b6f5 with SMTP id i11-20020a17090a974b00b001ea2bd3b6f5mr5254156pjw.196.1654954507141;
        Sat, 11 Jun 2022 06:35:07 -0700 (PDT)
Received: from localhost.localdomain ([199.101.192.70])
        by smtp.gmail.com with ESMTPSA id y190-20020a6264c7000000b00517c84fd24asm1587267pfb.172.2022.06.11.06.35.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Jun 2022 06:35:06 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Minchan Kim <minchan@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        shameerali.kolothum.thodi@huawei.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH] mm: fix is_pinnable_page return value
Date:   Sat, 11 Jun 2022 21:34:42 +0800
Message-Id: <20220611133442.15290-1-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1c563432588d ("mm: fix is_pinnable_page against a cma page")
Changes from
return !(is_zone_movable_page(page) || is_migrate_cma_page(page)) ||
        is_zero_pfn(page_to_pfn(page));
to
return !(is_zone_movable_page(page) || is_zero_pfn(page_to_pfn(page)));

Unfortunately, this changes the return value since the ! area is error.
It should be:
return !(is_zone_movable_page(page)) || is_zero_pfn(page_to_pfn(page));

This causes qemu to be hung with a passthrough device.

Fixes: 1c563432588d ("mm: fix is_pinnable_page against a cma page")
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index bc8f326be0ce..bbbcdde6c4dc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1600,7 +1600,7 @@ static inline bool is_pinnable_page(struct page *page)
 	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
 		return false;
 #endif
-	return !(is_zone_movable_page(page) || is_zero_pfn(page_to_pfn(page)));
+	return !(is_zone_movable_page(page)) || is_zero_pfn(page_to_pfn(page));
 }
 #else
 static inline bool is_pinnable_page(struct page *page)
-- 
2.36.1

