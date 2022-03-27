Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806144E8508
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 04:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbiC0CnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 22:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbiC0CnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 22:43:09 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C83F6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 19:41:30 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id lr4so13863739ejb.11
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 19:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Lp7OyzRBJpk9Yhtc35RHQ3SBsAFn1AOoGl5hsCUQLbs=;
        b=MAfmrOrSIP7drRaxTKwnegVd2sfztTnVTorPJK7e8aedVf6yMq/vRH817+4junb0ix
         ww+vG67sokwSMY5RVO6HhUib64/0sQ2XS5JucHsX31m/OR9NLqUTm9p+n6V11nImiTX3
         Z6HtXyyaaSK/XZDBfV6wnTdmzYzovYALAQZGw3clsmYjWZX168IuxaKjggXyvjp9G2Px
         cM/1T2ZQiLgW6HDPX95O0zS7ODao/evQK+pSDRxmDrqpOpGkIKEc17SMD8p9XLvUpB88
         eM8cWlmXHL4+vvCZrLiMp64LTm4si3S0fe3GkN83AQ0V8uFCGK0eAWNcgrM0fMB3WjWU
         yu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Lp7OyzRBJpk9Yhtc35RHQ3SBsAFn1AOoGl5hsCUQLbs=;
        b=m3U2z11YYAu2LX0YdZXbeCGZ4wNKYiNiq7ms8SqDm32cJM+T2kBoBcZv6DuaQoct2u
         4tzaQosihKF1Q5PU+Lv7kLBMdi5srlzzQ4UAxIzf8qQ2LnWX6vHOHde0/8Vspllbe2qB
         kbKrmMTlEUKJiU1GPuNV+rNlXZLT+a1o6BvJYnXFyZi5Mg6h8Q16ACOnyhVlT6LCIy4e
         zPPSQYCepa05Yvo2M/dPrPBP3fFB1O22aasRIq2e9E16sACwbpgwzooA2VnKMRDQ9kHW
         QDsWcL4Wj7KlsSpv5LxpBejfAL4MQKxlvcK3a28c5oxsdVNg7Z1FUj/stDk+0EhM1Qm+
         vPbA==
X-Gm-Message-State: AOAM530pUbD7N2K5VtvoPuT/DgWn0V2RfTL8fTtq5Gu2oC5Ff/Vzmv3U
        sXJuRdc3u3grHLbu8IWJOb9kIrePpPc=
X-Google-Smtp-Source: ABdhPJwff1yCMKXeTrXkMama+S8HcSKS9lgO5aoriPadtVF0OJUe0QGsnM0vV+XByfwOXQGdiWM8OA==
X-Received: by 2002:a17:907:eab:b0:6da:8ec5:d386 with SMTP id ho43-20020a1709070eab00b006da8ec5d386mr19851733ejc.668.1648348888564;
        Sat, 26 Mar 2022 19:41:28 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id sd7-20020a1709076e0700b006e015549bdfsm3982750ejc.53.2022.03.26.19.41.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Mar 2022 19:41:28 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 1/2] mm/vmscan: reclaim only affects managed_zones
Date:   Sun, 27 Mar 2022 02:41:00 +0000
Message-Id: <20220327024101.10378-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As mentioned in commit 6aa303defb74 ("mm, vmscan: only allocate and
reclaim from zones with pages managed by the buddy allocator") , reclaim
only affects managed_zones.

Let's adjust the code and comment accordingly.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/vmscan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7ad54b770bb1..89745cf34386 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1031,7 +1031,7 @@ static bool skip_throttle_noprogress(pg_data_t *pgdat)
 	for (i = 0; i < MAX_NR_ZONES; i++) {
 		struct zone *zone = pgdat->node_zones + i;
 
-		if (!populated_zone(zone))
+		if (!managed_zone(zone))
 			continue;
 
 		reclaimable += zone_reclaimable_pages(zone);
@@ -3912,7 +3912,7 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx)
 	}
 
 	/*
-	 * If a node has no populated zone within highest_zoneidx, it does not
+	 * If a node has no managed zone within highest_zoneidx, it does not
 	 * need balancing by definition. This can happen if a zone-restricted
 	 * allocation tries to wake a remote kswapd.
 	 */
-- 
2.33.1

