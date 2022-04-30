Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7A6515983
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 03:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381974AbiD3BOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 21:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381972AbiD3BOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 21:14:00 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F95137001
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 18:10:40 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id b12so8516376plg.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 18:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HUvLzatNb0wuRiUwrpeITDjSWvWYxQ7+pBRT10EPG34=;
        b=U01NK771gyD2u/0rl7aHPLiWERoKiMxFcSbHTVhnjpdpTiWrWb9L6gm/C++rhgZlg0
         1N1GxLNkOGpMP4B/I/XQGCdiKKkcyLYu7dZ1cFZ/jm/XVx2Wv8HdIyXnouhMv35oGiH1
         5gue7dAzmB5Daqmy1Usl9Hs0ZdTuZjbknpamOf/i5YrHRKGu74pvg1J15/PzSPlw0/oZ
         4gTZ0uJmiESJvS1AXeZ69FXr2wZuV/AqxH83LAp9QFrnJLvzQluAJtFJwnDAiwGtEdbE
         PrYo0QjodS8PNONqo1DwA6S9sOfrmakXxsckHLcpTEE5e04G4ye/zmuwpUQ53+z7V9rt
         E0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HUvLzatNb0wuRiUwrpeITDjSWvWYxQ7+pBRT10EPG34=;
        b=v647jv8zszoabCDcxuAfnh4b4ibuG2eLLe19+8VdI5hsOGMcicoSYfv3zwOQgQXHdW
         YqJz91sJjZVbfoKc9Q3gKPBeI7gu3UCXs2FtS/pt2RgMsr2juCHTDy3t0lOm6f51zzh1
         BQPCAL94MkOMT0NWiWYVcSt93Gntw5bjpb770qqOKIiZzr2CD2UgszmXhQ2QApjzTLbe
         3MWS0OJuBLDXyvA0o3+S7g3CiwUiR9HWL0TAplxPcmSpGk9T/xR5VFOpHqKoRn5jlTI0
         HZ0vAz1N+eXXZFkOV3EFh0aTCxSgb9Z7ywq70d9gOeFQdY/k6DUtbGVHMuD0JN2oKqEX
         5Vsw==
X-Gm-Message-State: AOAM530j/H2MSGhRs2sTclU5VVWjQr9B4FczkLqtpONSro2m4ge+EsUX
        obO2gCd3RIVvmkhrzvE2PcMGuciUfWZHy2hQ
X-Google-Smtp-Source: ABdhPJx0HoYQRpElDgCFT/ew+2skNC5TEP+YatqGOH/IqSVePlSnmKImtIOfqTr9+e6uPnn1Zh7eTQ==
X-Received: by 2002:a17:903:240c:b0:153:c8df:7207 with SMTP id e12-20020a170903240c00b00153c8df7207mr1670891plo.44.1651281039758;
        Fri, 29 Apr 2022 18:10:39 -0700 (PDT)
Received: from localhost.localdomain ([125.131.156.123])
        by smtp.gmail.com with ESMTPSA id k3-20020a170902694300b0015e8d4eb24fsm212271plt.153.2022.04.29.18.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 18:10:38 -0700 (PDT)
From:   Wonhyuk Yang <vvghjk1234@gmail.com>
To:     Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ohhoon Kwon <ohkwon1043@gmail.com>,
        JaeSang Yoo <jsyoo5b@gmail.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>,
        Jiyoup Kim <lakroforce@gmail.com>,
        Donghyeok Kim <dthex5d@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/page_alloc: cache the result of node_dirty_ok()
Date:   Sat, 30 Apr 2022 10:10:32 +0900
Message-Id: <20220430011032.64071-1-vvghjk1234@gmail.com>
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

To spread dirty page, nodes are checked whether
it reached the dirty limit using the expensive
node_dirty_ok(). To reduce the number of calling
node_dirty_ok(), last node that hit the dirty
limit is cached.

Instead of caching the node, caching both node
and it's result of node_dirty_ok() can reduce
the number of calling node_dirty_ok() more than
before.

Signed-off-by: Wonhyuk Yang <vvghjk1234@gmail.com>
---
 mm/page_alloc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0e42038382c1..aba62cf31a0e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4068,7 +4068,8 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 {
 	struct zoneref *z;
 	struct zone *zone;
-	struct pglist_data *last_pgdat_dirty_limit = NULL;
+	struct pglist_data *last_pgdat = NULL;
+	bool last_pgdat_dirty_limit = false;
 	bool no_fallback;
 
 retry:
@@ -4107,13 +4108,13 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		 * dirty-throttling and the flusher threads.
 		 */
 		if (ac->spread_dirty_pages) {
-			if (last_pgdat_dirty_limit == zone->zone_pgdat)
-				continue;
+			if (last_pgdat != zone->zone_pgdat) {
+				last_pgdat = zone->zone_pgdat;
+				last_pgdat_dirty_limit = node_dirty_ok(zone->zone_pgdat);
+			}
 
-			if (!node_dirty_ok(zone->zone_pgdat)) {
-				last_pgdat_dirty_limit = zone->zone_pgdat;
+			if (!last_pgdat_dirty_limit)
 				continue;
-			}
 		}
 
 		if (no_fallback && nr_online_nodes > 1 &&
-- 
2.30.2

