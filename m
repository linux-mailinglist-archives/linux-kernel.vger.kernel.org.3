Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A844B1578
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 19:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243429AbiBJSoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 13:44:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiBJSoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 13:44:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A952F54
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 10:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644518653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PXnVtI935m7FvZKpfg4pjfmoPSIc7HpPcrtV3vV4Jm8=;
        b=dfk1+XTknsXO2tmZh27XZVZio6QQzHbyCEQBHXWKQDl5TU+9wUPPK8QekD4eeR4lD+2nGO
        Q4uQBAkEbuh9AI6Bv59FqnzQi2vvw7J4PEOu7rzCpQDDpv8hLhGZiKVkflW49gDTxvIhq0
        OdYcVFIYWfZbHCf1dmvP1OdkCdHzxug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-tqGQOJ3dN5-9TdKnRD6Tsw-1; Thu, 10 Feb 2022 13:44:10 -0500
X-MC-Unique: tqGQOJ3dN5-9TdKnRD6Tsw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4D9992502;
        Thu, 10 Feb 2022 18:44:08 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA6EA7E124;
        Thu, 10 Feb 2022 18:44:06 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 1/2] drivers/base/node: rename link_mem_sections() to register_memory_block_under_node()
Date:   Thu, 10 Feb 2022 19:43:58 +0100
Message-Id: <20220210184359.235565-2-david@redhat.com>
In-Reply-To: <20220210184359.235565-1-david@redhat.com>
References: <20220210184359.235565-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's adjust the stale terminology, making it match
unregister_memory_block_under_nodes() and
do_register_memory_block_under_node(). We're dealing with memory block
devices, which span 1..X memory sections.

Acked-by: Oscar Salvador <osalvador@suse.de>
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

