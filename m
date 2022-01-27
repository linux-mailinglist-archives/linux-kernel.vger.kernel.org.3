Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079A749DD01
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 09:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238018AbiA0Ixc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 03:53:32 -0500
Received: from mail-ej1-f51.google.com ([209.85.218.51]:45664 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237956AbiA0IxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 03:53:22 -0500
Received: by mail-ej1-f51.google.com with SMTP id me13so4109894ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 00:53:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XTSCSWPE5HlRFNZCvz3I8p5LYXgsNZWlsLbybuNzyTQ=;
        b=FSOW0c2P5ofKKFZsLwUQdfXsC3YuIHGSW2LK3Kec4bKBcqlFllDOOTa2HooiGKYdIU
         aUiTrRS1XA2SuSnpX1MO/ZYRs8CsrKFBf3k7/a8gvtUFlaQQ5O7pVApG44ZQso1rvzUX
         W8RNJMiv8zhROdHaSZSUzSpJCRE4XMALCpByxiNY2AEj0e0mx1v6QvB641nV8uwEPq8s
         9MZx2Gk10a3KAgPJTUWtFdT8GONIoWq8Ul8p+veU0KAWrp1UK3yOhP4nKQBGaDNPIrc9
         0QkveBPa/OgdK/05C/hWze1r12IexDtE0BQscc1yYJVLIQzgZSnQFMLAc6icwiwJQszi
         Il9g==
X-Gm-Message-State: AOAM5338uWgTeewRZXz7RjAeAHllSv7VFHBTNFYdBZRTq223/SHr9CUa
        GZZA4fnv5MmXPExIGP450uI=
X-Google-Smtp-Source: ABdhPJx5ObyDxjwZXcVYWQ4o7Bymlq1geZKx3vr/oZ+xt0Gwg0+GZ4uac6cBGWutrb83Kkr4i2ecBQ==
X-Received: by 2002:a17:907:b01:: with SMTP id h1mr2087725ejl.728.1643273600849;
        Thu, 27 Jan 2022 00:53:20 -0800 (PST)
Received: from localhost.localdomain (ip-85-160-47-31.eurotel.cz. [85.160.47.31])
        by smtp.gmail.com with ESMTPSA id n11sm11029757edv.52.2022.01.27.00.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 00:53:20 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Rafael Aquini <raquini@redhat.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH 5/6] mm: make free_area_init_node aware of memory less nodes
Date:   Thu, 27 Jan 2022 09:53:04 +0100
Message-Id: <20220127085305.20890-6-mhocko@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127085305.20890-1-mhocko@kernel.org>
References: <20220127085305.20890-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

free_area_init_node is also called from memory less node initialization
path (free_area_init_memoryless_node). It doesn't really make much sense
to display the physical memory range for those nodes:
Initmem setup node XX [mem 0x0000000000000000-0x0000000000000000]

Instead be explicit that the node is memoryless:
Initmem setup node XX as memoryless

Acked-by: Rafael Aquini <raquini@redhat.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/page_alloc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 32d0189de4c5..83da2279be72 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7682,9 +7682,14 @@ static void __init free_area_init_node(int nid)
 	pgdat->node_start_pfn = start_pfn;
 	pgdat->per_cpu_nodestats = NULL;
 
-	pr_info("Initmem setup node %d [mem %#018Lx-%#018Lx]\n", nid,
-		(u64)start_pfn << PAGE_SHIFT,
-		end_pfn ? ((u64)end_pfn << PAGE_SHIFT) - 1 : 0);
+	if (start_pfn != end_pfn) {
+		pr_info("Initmem setup node %d [mem %#018Lx-%#018Lx]\n", nid,
+			(u64)start_pfn << PAGE_SHIFT,
+			end_pfn ? ((u64)end_pfn << PAGE_SHIFT) - 1 : 0);
+	} else {
+		pr_info("Initmem setup node %d as memoryless\n", nid);
+	}
+
 	calculate_node_totalpages(pgdat, start_pfn, end_pfn);
 
 	alloc_node_mem_map(pgdat);
-- 
2.30.2

