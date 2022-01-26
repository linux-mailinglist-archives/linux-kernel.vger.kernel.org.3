Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2CB49D036
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243509AbiAZRAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236857AbiAZRAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:00:32 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFFAC06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:00:32 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id z131so10574199pgz.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ajou.ac.kr; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZLHyK20O5fjF8tpaoo4j4wWZ9TVY0iYMrpJ/AYsNoaQ=;
        b=vrRs5jvx6MkUUyv2+3VMlJ0DdZKdb5shEnyiX6qp1PYWk/jGgYvTT5hwB+VXIgNNh/
         Sss0qn3KCFbxifeoskWZw8SC5TMnXCX/L1/7Q6Da2k0lUBZj/MLhH6/gP/BGcjs65Ujt
         G1OWv1P2NOFGz8C73t9E4E0auwqGR5PwM8qrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZLHyK20O5fjF8tpaoo4j4wWZ9TVY0iYMrpJ/AYsNoaQ=;
        b=dJzgihyBZIMKSinBqo9jqSXUqpRbi2Lpw6BhO3qlzXl+n7oasLxByAyE7bRHpIn8fe
         0tiEMzHNMr2nBikzxsqvcUAj5RY98v1P8hImh5CYM8gV1rw2BJ16wlbKwpaTVNVw7gi5
         bKTkrnV5WC1EAKV4cQ9qVt+Z7Ivf0B9tEgv9UAKSoef3ll1o3wAyI5gyDTgBSC1RsXMF
         YAbNlsQjLyQX+geKKVOe7+ohebD0ASy0KrdAn+gKfqVjOfFWMg0vq/d4IB8ZpwHp5nW5
         bEwMSSevWi6oib7gDF7flznZLakhfDc4gCMnq49Qt99OvxVABaxBxMa017ClQqDeKs4t
         /Ssw==
X-Gm-Message-State: AOAM533xHA75+BIyb9HHG4S5CKaaFZiALhLJ0kEf5fdi0WHiBLBnLfL0
        l0OrKCwTVlNO4TAD8dk3aLYuDA==
X-Google-Smtp-Source: ABdhPJxjVpKnnpPwVrHzt9Td3FqWXgprztHCOyVZfWq6BIkg6WioylZ1Pcindlze94y0eyDQ5CLH9g==
X-Received: by 2002:a65:578b:: with SMTP id b11mr11425671pgr.318.1643216431459;
        Wed, 26 Jan 2022 09:00:31 -0800 (PST)
Received: from localhost.localdomain ([210.107.197.32])
        by smtp.googlemail.com with ESMTPSA id q6sm17540644pgb.85.2022.01.26.09.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 09:00:31 -0800 (PST)
From:   Jonghyeon Kim <tome01@ajou.ac.kr>
To:     dan.j.williams@intel.com
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com,
        akpm@linux-foundation.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jonghyeon Kim <tome01@ajou.ac.kr>
Subject: [PATCH 1/2] mm/memory_hotplug: Export shrink span functions for zone and node
Date:   Thu, 27 Jan 2022 02:00:01 +0900
Message-Id: <20220126170002.19754-1-tome01@ajou.ac.kr>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export shrink_zone_span() and update_pgdat_span() functions to head
file. We need to update real number of spanned pages for NUMA nodes and
zones when we add memory device node such as device dax memory.

Signed-off-by: Jonghyeon Kim <tome01@ajou.ac.kr>
---
 include/linux/memory_hotplug.h | 3 +++
 mm/memory_hotplug.c            | 6 ++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index be48e003a518..25c7f60c317e 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -337,6 +337,9 @@ extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 extern void remove_pfn_range_from_zone(struct zone *zone,
 				       unsigned long start_pfn,
 				       unsigned long nr_pages);
+extern void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
+			     unsigned long end_pfn);
+extern void update_pgdat_span(struct pglist_data *pgdat);
 extern bool is_memblock_offlined(struct memory_block *mem);
 extern int sparse_add_section(int nid, unsigned long pfn,
 		unsigned long nr_pages, struct vmem_altmap *altmap);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 2a9627dc784c..38f46a9ef853 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -389,7 +389,7 @@ static unsigned long find_biggest_section_pfn(int nid, struct zone *zone,
 	return 0;
 }
 
-static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
+void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 			     unsigned long end_pfn)
 {
 	unsigned long pfn;
@@ -428,8 +428,9 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 		}
 	}
 }
+EXPORT_SYMBOL_GPL(shrink_zone_span);
 
-static void update_pgdat_span(struct pglist_data *pgdat)
+void update_pgdat_span(struct pglist_data *pgdat)
 {
 	unsigned long node_start_pfn = 0, node_end_pfn = 0;
 	struct zone *zone;
@@ -456,6 +457,7 @@ static void update_pgdat_span(struct pglist_data *pgdat)
 	pgdat->node_start_pfn = node_start_pfn;
 	pgdat->node_spanned_pages = node_end_pfn - node_start_pfn;
 }
+EXPORT_SYMBOL_GPL(update_pgdat_span);
 
 void __ref remove_pfn_range_from_zone(struct zone *zone,
 				      unsigned long start_pfn,
-- 
2.17.1

