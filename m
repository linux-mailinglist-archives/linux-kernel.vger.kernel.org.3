Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3164AD248
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 08:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348395AbiBHHhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 02:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348375AbiBHHhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 02:37:02 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E66C03FECA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 23:36:59 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id k17so13205244plk.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 23:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ppq4XlgFUv42e60ZLq/R/m9c3uPkEPmuzaFcdHPRBnk=;
        b=xVoHJj/4zyPvyg7fneG+v1w0Ib0159bkGEZFF8GmxqGz1GIqJQvjHPPWQUUBQVBWSi
         yR2SPqfsbh97O8Bk0wkaV2DY7IDHGcuTgyVWO/W/8a0okGQfamKHXNVAIF4if1wm6/w5
         iiwk1B4JgZBA4eWoYz+PU1VYZ55CZdIYVNH4J5zSrekqulSmRsmD2G0K+Pf8fVKb53hx
         t4ihL4kylEoaMDcmJaTJcAiXjkdVmkC43SCUedvI61iLAerc6p8houdOghfe1doOVpQa
         oubwmMrsU31yjFg4iMICpMtw3IcU5yLSUYRvgyulqzAWcjvp0pMZyUz3r23mxXP1tv2z
         smFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ppq4XlgFUv42e60ZLq/R/m9c3uPkEPmuzaFcdHPRBnk=;
        b=SxPdFYuARS+Y/u+Ff++Hpl6LNeRD4WJ6BY8pC4jNohcXVwQ/GXl3RUJ0n3csE0/cy8
         w0AmI//Bi480yAoPlZFJOUIkAaYo+AsNqFVDlkAwKhDte2I4Rp9XzVI5uR0rRY0E6hHa
         a2NdElFv5E/3OBFSlenZfHLrb/5UKogIG9fgZZoR9UtAgGV6MtkEwDcablV7Q0nW8UVg
         hxON+SqNql07ysst8+AKbeyOwWNFnprxpdRSugvt+6K5ecEJlxjO1cTdbMt9SyrWQaRO
         XubUHnZQ5/UmHv4BHu3RvzFt/Cdp61Nqz189fN4oHAASlYwxjAWBPjJZKkl7z4PsGcA8
         phIw==
X-Gm-Message-State: AOAM533ssRfA1kyrIWo+wITw3HSewLVBVI85ZftLK1ACtp80TQ5y8x1S
        37THrmuHxSgaZ8PbcH83165goQ==
X-Google-Smtp-Source: ABdhPJzNE1tP0FCmJnNbT+MwdBxWiom5QGlNn45IpoyK3Oqddhm8dX950DKcNeuV59Q8o0qQlea8fA==
X-Received: by 2002:a17:902:ab06:: with SMTP id ik6mr3065211plb.162.1644305818957;
        Mon, 07 Feb 2022 23:36:58 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id gx10sm1621017pjb.7.2022.02.07.23.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 23:36:58 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, zi.yan@cs.rutgers.edu,
        kirill.shutemov@linux.intel.com, rientjes@google.com,
        lars.persson@axis.com, mike.kravetz@oracle.com, ziy@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 5/5] mm: replace multiple dcache flush with flush_dcache_folio()
Date:   Tue,  8 Feb 2022 15:36:17 +0800
Message-Id: <20220208073617.70342-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220208073617.70342-1-songmuchun@bytedance.com>
References: <20220208073617.70342-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the code by using flush_dcache_folio().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/migrate.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index c418e8d92b9c..daf2b3508670 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -933,12 +933,8 @@ static int move_to_new_page(struct page *newpage, struct page *page,
 		if (!PageMappingFlags(page))
 			page->mapping = NULL;
 
-		if (likely(!is_zone_device_page(newpage))) {
-			int i, nr = compound_nr(newpage);
-
-			for (i = 0; i < nr; i++)
-				flush_dcache_page(newpage + i);
-		}
+		if (likely(!is_zone_device_page(newpage)))
+			flush_dcache_folio(page_folio(newpage));
 	}
 out:
 	return rc;
-- 
2.11.0

