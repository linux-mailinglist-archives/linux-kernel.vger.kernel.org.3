Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB41497852
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 06:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236544AbiAXFSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 00:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236092AbiAXFSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 00:18:08 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F29C06173D
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 21:18:07 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so15561037pjp.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 21:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kKp2VsYVshLyXdr/Mm5s2c/ypkad29QD2/BMtkuP4rM=;
        b=KMFMXHj1seUsAKWZF1wx6B80aQgEMVTjVCw3uuJwzlNCa4fehZo82ctufwGRlAx/nE
         1Os6wrArlQlVOMsLzUOXbogYGGXyYCXhFJCR6N0818Utleh/fKrubFUP3fBm0Yubg9CE
         Jg5ag39IA6Ot0T5y35480iUDQddincDphtjn4Dm4W1Q/lQydpeCDai/soZLgzFhdlVt6
         atWJMdpe09b8mWmypGUz28vXNQXZtix3LpaGcXxJBusEaBK8PyoHArik4+PhVetiqkFg
         cEDufP1xSnLPFQCGYVM3OpQbMKq9lil+I9NBrKu5YeY5kVaEr2LwfkBG8+VqHXWZrgpa
         tcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kKp2VsYVshLyXdr/Mm5s2c/ypkad29QD2/BMtkuP4rM=;
        b=DGMNG+Mh0uAoFwC1eqYt1/o9fT6Rvquj14/iWeLWEQPYITAiahUf3ChMwIWCvUoL8H
         PtN7CVE25HLGdFf7XeglFw/4mKxO8KRs9LL3HUiQqPnWQiV9L4fwL8l/PymH0VsZmurT
         FAB/ypEDCiJNnOfOsg+OlHZSjLfmcI7IaX8yiHRhFcanMaB4UD4KmgGM46sGhUCjQ+vY
         iwh8137SPcs3Y9Vj5Km/8QX6h+F2IJ19f4ESgxe675q5GC3NSBr2DtzFOgBJo8vS1jRC
         fatdXrNYGZ8WoPuUel/m9ZMH4S0j7LXbvqDndhmsLhhJCtqWivzhXNMTwUXs60e8MWiU
         WlLg==
X-Gm-Message-State: AOAM531n9PkftlGFKFkjxhPqaLtLh3DOzl8yLsPqjtIXoWo4tPrvYusW
        kYs1DJOnTNeQszZKg7p7dpkZLQ==
X-Google-Smtp-Source: ABdhPJxybSZPlRDINVw0aEX2KARMUBoqgQqXKvdvrZKs+UMQM/WyESYd1/uYYZyNkz5zhJm/v1mvFg==
X-Received: by 2002:a17:903:24d:b0:149:b68f:579 with SMTP id j13-20020a170903024d00b00149b68f0579mr13534093plh.1.1643001487395;
        Sun, 23 Jan 2022 21:18:07 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id l21sm14263018pfu.120.2022.01.23.21.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 21:18:07 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, zi.yan@cs.rutgers.edu,
        kirill.shutemov@linux.intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 2/2] mm: fix missing cache flush for all tail pages of THP
Date:   Mon, 24 Jan 2022 13:17:52 +0800
Message-Id: <20220124051752.83281-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220124051752.83281-1-songmuchun@bytedance.com>
References: <20220124051752.83281-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The D-cache maintenance inside move_to_new_page() only consider one page,
there is still D-cache maintenance issue for tail pages of THP. Fix this
by not using flush_dcache_folio() since it is not backportable.

Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
Changes in v2:
 - Using a for loop instead of the folio variant for backportable.

 mm/migrate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index c9296d63878d..c418e8d92b9c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -933,9 +933,12 @@ static int move_to_new_page(struct page *newpage, struct page *page,
 		if (!PageMappingFlags(page))
 			page->mapping = NULL;
 
-		if (likely(!is_zone_device_page(newpage)))
-			flush_dcache_page(newpage);
+		if (likely(!is_zone_device_page(newpage))) {
+			int i, nr = compound_nr(newpage);
 
+			for (i = 0; i < nr; i++)
+				flush_dcache_page(newpage + i);
+		}
 	}
 out:
 	return rc;
-- 
2.11.0

