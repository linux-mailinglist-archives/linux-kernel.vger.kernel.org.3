Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25454B0DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 13:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241660AbiBJMh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 07:37:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240214AbiBJMhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 07:37:51 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C255FDA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 04:37:53 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id t14-20020a17090a3e4e00b001b8f6032d96so5417143pjm.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 04:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oDahdnw06IsGwB/7M26luCqPUnRrkijqY+ZjOYkno4A=;
        b=tpGNdIY2hwVGwRhbVAEv6E5VyLyH6hl7LUw7SLZyLIw8PMoLNcP/DUGn0A+TA43MA3
         DAp3ueB1y4QZ01hqgxcV1mb3FD1UWVfLo9aGY6MkmnYv1rOx2LYVOFu5ECBqxxAlZ6h7
         +fYloX/Dkjb81uKdqULv2aHbXuLal3uHsATiys2WgJE7mplGe4YGnpxk3Z0z9gm5fdvJ
         Fvl59LuYztWU/omTw0zQNUWaMxPJB3cNt2Hzp19Bnjfm+NtW+p+D6/+bjn6Ikjry2ySE
         7IJqRMvlWxRjZy4PkrIHOFY8qSvSNocEuSXW3CRF3ibl5YTyGYBL49XvaPC+KX6yN7Yk
         TAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oDahdnw06IsGwB/7M26luCqPUnRrkijqY+ZjOYkno4A=;
        b=vm1Vw5M+DAhTLyr03lnimxr6L/0Kx/5rcYNCuRGPncDcDVLzu9/C8HsUa2Lot/vLTb
         TTFwVgOTrrklyorowQoFCkBU9dEwcFYRrigR2PZKeZqv3tjGZ9hcpXKuWmrCDdLWY/rA
         slx/oqDuQhazwLY4qBNMZpA66SUADBaw0DHimXo3WAPbQJMRvrI93c1z2yB5dhFQJdv1
         UK9vsEFB5Tx+st2mTsGgDXYHqPQzaeEwI7HhydmR5wsO34amWY7gToPT1P0jvbEDywzR
         QDKKlQ7XIa5Rw5slB/WgQH7kQ5r+7DufMzlUWgRrHhweqbL7cDl9KkoyA0Ao+lmiHpgS
         23WQ==
X-Gm-Message-State: AOAM531sk1V/Sq3/5jxciL9eGmSlcZllujmZouu75SBnXGRd5EzmxIfO
        BrZrha0R0N6HSoUZqz1K9JYUZw==
X-Google-Smtp-Source: ABdhPJzn0l92vEIhPNZDK6wnPCBAAD+wPaRAZsukzdXyxqRwg+i/PIhMukVTcN6WwYR8rEu1ZtzJfQ==
X-Received: by 2002:a17:90a:fe15:: with SMTP id ck21mr2602609pjb.95.1644496673004;
        Thu, 10 Feb 2022 04:37:53 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id i8sm11767812pgf.94.2022.02.10.04.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 04:37:52 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, zi.yan@cs.rutgers.edu,
        kirill.shutemov@linux.intel.com, rientjes@google.com,
        lars.persson@axis.com, mike.kravetz@oracle.com, ziy@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 7/7] mm: replace multiple dcache flush with flush_dcache_folio()
Date:   Thu, 10 Feb 2022 20:30:58 +0800
Message-Id: <20220210123058.79206-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220210123058.79206-1-songmuchun@bytedance.com>
References: <20220210123058.79206-1-songmuchun@bytedance.com>
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
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
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

