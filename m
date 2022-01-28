Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E193D49FCC4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 16:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349427AbiA1P0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 10:26:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55297 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349368AbiA1P0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:26:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643383595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O+0GSuARxgPmv9QtSGjbfP/X/EeiO1c9bowvj+NcHCE=;
        b=aSfJjHhNx52pbvSUxVYW+UuLZ0xxmIMNns0n9mHpOhs4FjVjRDcpCiih1czEG1kW7uA3Yo
        N+nzVR5QgXLLNHLzm+p8YJxC24pz9c06b5QbzqTk5v//LZnMg90srySoJHY3HcIRIB9iRG
        9YU3GHr0uL2aD1geFxgxxD4x12CgYd8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-yiTmon6UPlmBjpsNyDy7KA-1; Fri, 28 Jan 2022 10:26:31 -0500
X-MC-Unique: yiTmon6UPlmBjpsNyDy7KA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EE8A1091DA0;
        Fri, 28 Jan 2022 15:26:30 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C5557B9F7;
        Fri, 28 Jan 2022 15:26:28 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v1 1/2] drivers/base/node: rename link_mem_sections() to register_memory_block_under_node()
Date:   Fri, 28 Jan 2022 16:26:19 +0100
Message-Id: <20220128152620.168715-2-david@redhat.com>
In-Reply-To: <20220128152620.168715-1-david@redhat.com>
References: <20220128152620.168715-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's adjust the stale terminology, making it match
unregister_memory_block_under_nodes() and
do_register_memory_block_under_node(). We're dealing with memory block
devices, which span 1..X memory sections.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/node.c  |  5 +++--
 include/linux/node.h | 16 ++++++++--------
 mm/memory_hotplug.c  |  6 +++---
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index a133981a12fc..5d75341413ce 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -892,8 +892,9 @@ void unregister_memory_block_under_nodes(struct memory_block *mem_blk)
 			  kobject_name(&node_devices[mem_blk->nid]->dev.kobj));
 }
 
-void link_mem_sections(int nid, unsigned long start_pfn, unsigned long end_pfn,
-		       enum meminit_context context)
+void register_memory_blocks_under_node(int nid, unsigned long start_pfn,
+				       unsigned long end_pfn,
+				       enum meminit_context context)
 {
 	walk_memory_blocks_func_t func;
 
diff --git a/include/linux/node.h b/include/linux/node.h
index f3be6ccfebed..9ec680dd607f 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -99,13 +99,13 @@ extern struct node *node_devices[];
 typedef  void (*node_registration_func_t)(struct node *);
 
 #if defined(CONFIG_MEMORY_HOTPLUG) && defined(CONFIG_NUMA)
-void link_mem_sections(int nid, unsigned long start_pfn,
-		       unsigned long end_pfn,
-		       enum meminit_context context);
+void register_memory_blocks_under_node(int nid, unsigned long start_pfn,
+				       unsigned long end_pfn,
+				       enum meminit_context context);
 #else
-static inline void link_mem_sections(int nid, unsigned long start_pfn,
-				     unsigned long end_pfn,
-				     enum meminit_context context)
+static inline void register_memory_blocks_under_node(int nid, unsigned long start_pfn,
+						     unsigned long end_pfn,
+						     enum meminit_context context)
 {
 }
 #endif
@@ -129,8 +129,8 @@ static inline int register_one_node(int nid)
 		error = __register_one_node(nid);
 		if (error)
 			return error;
-		/* link memory sections under this node */
-		link_mem_sections(nid, start_pfn, end_pfn, MEMINIT_EARLY);
+		register_memory_blocks_under_node(nid, start_pfn, end_pfn,
+						  MEMINIT_EARLY);
 	}
 
 	return error;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 2a9627dc784c..69af90e9f507 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1421,9 +1421,9 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 		BUG_ON(ret);
 	}
 
-	/* link memory sections under this node.*/
-	link_mem_sections(nid, PFN_DOWN(start), PFN_UP(start + size - 1),
-			  MEMINIT_HOTPLUG);
+	register_memory_blocks_under_node(nid, PFN_DOWN(start),
+					  PFN_UP(start + size - 1),
+					  MEMINIT_HOTPLUG);
 
 	/* create new memmap entry */
 	if (!strcmp(res->name, "System RAM"))
-- 
2.34.1

